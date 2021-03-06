FSTAR_HOME?=../dependencies/FStar
KREMLIN_HOME?=$(FSTAR_HOME)/../kremlin
HACL_HOME?=../..

include $(FSTAR_HOME)/src/gmake/fstar.mk
include $(FSTAR_HOME)/ulib/ml/Makefile.include

FSTAR_ARGS=$(OTHERFLAGS)

.PHONY=lib all

# OCaml variables
OCAMLOPT := $(OCAMLOPT) -w -8-20-26-28-10

all: lib
	$(MAKE)	poly1305.exe chacha20.exe salsa20.exe chacha20poly1305.exe gf128.exe ed25519.exe curve25519.exe sha2_256.exe sha2_512.exe

lib:
	$(MAKE) -C ../code/lib/ml MEM=HST


EXTRACTED= FStar_Seq_Base.ml FStar_Seq.ml FStar_Seq_Properties.ml FStar_Math_Lib.ml FStar_BitVector.ml FStar_UInt.ml  FStar_Endianness.ml

NOEXTRACT=$(addprefix --no_extract FStar., Classical Ghost Int16 Int32 Int64 Int63 Int16 Int8 Int.Cast Int List.Tot.Base List.Tot List.Tot.Properties Math.Lemmas Mul StrongExcludedMiddle UInt128 UInt16 UInt32 UInt63 UInt64 UInt8) $(addprefix --no_extract Hacl., UInt64 UInt32 UInt8)

ARGSl=--codegen OCaml --lax --include ../code/lib/kremlin $(NOEXTRACT) --include $(KREMLIN_HOME)/kremlib
ARGS=--codegen OCaml --include ../code/lib/kremlin $(NOEXTRACT) --include $(KREMLIN_HOME)/kremlib --detail_errors

OCAML_INCLUDES=-I ../code/lib/ml ../code/lib/ml/hacllib.cmxa

SPEC_FILES=	Spec.Chacha20.Lemmas.fst \
		Spec.Chacha20.fst \
		Spec.Chacha20_vec.fst \
		Spec.Chacha20Poly1305.fst \
		Spec.CTR.fst \
		Spec.Curve25519.Lemmas.fst \
		Spec.Curve25519.fst \
		Spec.GaloisField.fst \
		Spec.GF128.fst \
		Spec.HSalsa20.fst \
		Spec.Lib.fst \
		Spec.Poly1305.fst \
		Spec.Poly1305.Lemmas.fst \
		Spec.Salsa20.fst \
		Spec.SHA2_256.fst \
		Spec.SHA2_384.fst \
		Spec.SHA2_512.fst \
		Spec.Ed25519.fst

%.fst-verify: %.fst
	$(FSTAR)  --include $(KREMLIN_HOME)/kremlib --include $(HACL_HOME)/code/lib/kremlin $*.fst

all-ver: $(addsuffix -verify, $(SPEC_FILES))

%.fst-hints: %.fst
	-$(FSTAR) --include $(KREMLIN_HOME)/kremlib --include $(HACL_HOME)/code/lib/kremlin $*.fst --record_hints

all-hints: $(addsuffix -hints, $(SPEC_FILES))

gf128.exe: Spec.GF128.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p gf128-spec
	$(FSTAR) $(ARGS) --odir gf128-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> gf128-spec/Spec_GF128.ml
	$(OCAMLOPT) -I gf128-spec $(OCAML_INCLUDES) $(addprefix gf128-spec/, $(EXTRACTED)) gf128-spec/Spec_GaloisField.ml gf128-spec/Spec_GF128.ml -o gf128.exe
	./gf128.exe

poly1305.exe: Spec.Poly1305.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p poly-spec
	$(FSTAR) $(ARGS) --odir poly-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> poly-spec/Spec_Poly1305.ml
	$(OCAMLOPT) -I poly-spec $(OCAML_INCLUDES) $(addprefix poly-spec/, $(EXTRACTED)) poly-spec/Spec_Poly1305_Lemmas.ml poly-spec/Spec_Poly1305.ml -o poly1305.exe
	./poly1305.exe

curve25519.exe: Spec.Curve25519.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p curve25519-spec
	$(FSTAR) $(ARGS) --odir curve25519-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> curve25519-spec/Spec_Curve25519.ml
	$(OCAMLOPT) -I curve25519-spec $(OCAML_INCLUDES) $(addprefix curve25519-spec/, $(EXTRACTED)) curve25519-spec/Spec_Loops.ml curve25519-spec/Spec_Lib.ml curve25519-spec/Spec_Curve25519.ml -o curve25519.exe
	./curve25519.exe


VRFl.exe: Spec.VRF.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p vrf-spec
	$(FSTAR) $(ARGSl) --odir vrf-spec $^ 
	#$(OCAMLOPT) -I vrf-spec $(OCAML_INCLUDES) $(addprefix vrf-spec/, $(EXTRACTED)) vrf-spec/Spec_Loops.ml vrf-spec/Spec_Lib.ml vrf-spec/Spec_VRF.ml -o vrf.exe
	#./vrf.exe	

VRF.exe: Spec.VRF.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p vrf-spec
	$(FSTAR) $(ARGS) --odir  vrf-spec $^
	#$(OCAMLOPT) -I vrf-spec $(OCAML_INCLUDES) $(addprefix vrf-spec/, $(EXTRACTED)) vrf-spec/Spec_Loops.ml vrf-spec/Spec_Lib.ml vrf-spec/Spec_VRF.ml -o vrf.exe
	#./vrf.exe	

VRFh.exe: Spec.VRF.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p vrf-spec
	$(FSTAR) $(ARGS) --odir vrf-spec $^ --record_hints
	#$(OCAMLOPT) -I vrf-spec $(OCAML_INCLUDES) $(addprefix vrf-spec/, $(EXTRACTED)) vrf-spec/Spec_Loops.ml vrf-spec/Spec_Lib.ml vrf-spec/Spec_VRF.ml -o vrf.exe
	#./vrf.exe	

chacha20.exe: Spec.Chacha20.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p chacha-spec
	$(FSTAR) $(ARGS) --odir chacha-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> chacha-spec/Spec_Chacha20.ml
	$(OCAMLOPT) -I chacha-spec $(OCAML_INCLUDES) $(addprefix chacha-spec/, $(EXTRACTED)) chacha-spec/Spec_Loops.ml chacha-spec/Seq_Create.ml chacha-spec/Spec_Lib.ml chacha-spec/Spec_CTR.ml chacha-spec/Spec_Chacha20.ml -o chacha20.exe
	./chacha20.exe

salsa20.exe: Spec.Salsa20.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p salsa-spec
	$(FSTAR) $(ARGS) --odir salsa-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> salsa-spec/Spec_Salsa20.ml
	$(OCAMLOPT) -I salsa-spec $(OCAML_INCLUDES) $(addprefix salsa-spec/, $(EXTRACTED)) salsa-spec/Spec_Loops.ml salsa-spec/Seq_Create.ml salsa-spec/Spec_Lib.ml salsa-spec/Spec_CTR.ml salsa-spec/Spec_Salsa20.ml -o salsa20.exe
	./salsa20.exe

chacha20poly1305.exe: Spec.Chacha20Poly1305.fst
	$(MAKE) -C ../code/lib/ml MEM=HST
	mkdir -p chacha-poly-spec
	$(FSTAR) $(ARGS) --odir chacha-poly-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> chacha-poly-spec/Spec_Chacha20Poly1305.ml
	$(OCAMLOPT) -I chacha-poly-spec $(OCAML_INCLUDES) $(addprefix chacha-poly-spec/, $(EXTRACTED)) chacha-poly-spec/Spec_Loops.ml chacha-poly-spec/Seq_Create.ml chacha-poly-spec/Spec_Lib.ml chacha-poly-spec/Spec_CTR.ml chacha-poly-spec/Spec_Chacha20.ml chacha-poly-spec/Spec_Poly1305_Lemmas.ml chacha-poly-spec/Spec_Poly1305.ml chacha-poly-spec/Spec_Chacha20Poly1305.ml -o chacha20poly1305.exe
	./chacha20poly1305.exe

sha2_256.exe: Spec.SHA2_256.fst
	$(MAKE) lib
	mkdir -p sha2-spec
	$(FSTAR) $(ARGS) --odir sha2-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else "FAILURE\n")' >> sha2-spec/Spec_SHA2_256.ml
	$(OCAMLOPT) -I sha2-spec $(OCAML_INCLUDES) $(addprefix sha2-spec/, $(EXTRACTED)) sha2-spec/Spec_Loops.ml sha2-spec/Spec_Lib.ml sha2-spec/Seq_Create.ml sha2-spec/Spec_SHA2_256.ml -o sha2_256.exe
	./sha2_256.exe

sha2_384.exe: Spec.SHA2_384.fst
	$(MAKE) lib
	mkdir -p sha2-spec
	$(FSTAR) $(ARGS) --odir sha2-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else "FAILURE\n")' >> sha2-spec/Spec_SHA2_384.ml
	$(OCAMLOPT) -I sha2-spec $(OCAML_INCLUDES) $(addprefix sha2-spec/, $(EXTRACTED)) sha2-spec/Spec_Loops.ml sha2-spec/Spec_Lib.ml sha2-spec/Seq_Create.ml sha2-spec/Spec_SHA2_384.ml -o sha2_384.exe
	./sha2_384.exe

sha2_512.exe: Spec.SHA2_512.fst
	$(MAKE) lib
	mkdir -p sha2-spec
	$(FSTAR) $(ARGS) --odir sha2-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else "FAILURE\n")' >> sha2-spec/Spec_SHA2_512.ml
	$(OCAMLOPT) -I sha2-spec $(OCAML_INCLUDES) $(addprefix sha2-spec/, $(EXTRACTED)) sha2-spec/Spec_Loops.ml sha2-spec/Spec_Lib.ml sha2-spec/Seq_Create.ml sha2-spec/Spec_SHA2_512.ml -o sha2_512.exe
	./sha2_512.exe

hmac_sha2_256.exe: Spec.HMAC.SHA2_256.fst
	$(MAKE) lib
	mkdir -p hmac-sha2-spec
	$(FSTAR) $(ARGS) --odir hmac-sha2-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else "FAILURE\n")' >> hmac-sha2-spec/Spec_HMAC_SHA2_256.ml
	$(OCAMLOPT) -I hmac-sha2-spec $(OCAML_INCLUDES) $(addprefix hmac-sha2-spec/, $(EXTRACTED)) hmac-sha2-spec/Spec_Loops.ml hmac-sha2-spec/Spec_Lib.ml hmac-sha2-spec/Seq_Create.ml hmac-sha2-spec/Spec_SHA2_256.ml hmac-sha2-spec/Spec_HMAC_SHA2_256.ml -o hmac_sha2_256.exe
	./hmac_sha2_256.exe

ed25519.exe: Spec.SHA512.fst Spec.Ed25519.fst
	$(MAKE) lib
	mkdir -p ed25519-spec
	$(FSTAR) $(ARGS) --odir ed25519-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else "FAILURE\n")' >> ed25519-spec/Spec_Ed25519.ml
	$(OCAMLOPT) -I ed25519-spec  $(OCAML_INCLUDES) $(addprefix ed25519-spec/, $(EXTRACTED) Spec_Loops.ml Spec_Lib.ml Spec_Curve25519.ml Seq_Create.ml Spec_SHA2_512.ml Spec_SHA512.ml Spec_Ed25519.ml) -o ed25519.exe
	./ed25519.exe

clean:
	$(MAKE) -C ../code/lib/ml clean
	rm -rf *.cmi *.cmo *.cmx *.o *~ *.out *.exe poly-spec chacha-spec chacha-poly-spec salsa-spec gf128-spec curve25519-spec sha2-spec hmac-sha2-spec ed25519-spec
