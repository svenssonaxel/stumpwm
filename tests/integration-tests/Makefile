run-tests: $(shell ./script internal-get-run-tests-deps)

ci: $(shell ./script internal-get-ci-deps)

generate-tests: test-runner.iid
	./script internal-generate-tests "${COUNT}"

testcases/%.results/success: testcases/%.sh test-runner.iid
	./script internal-run-one-test "$*" expect-success

testcases/%.results/fail: testcases/%.sh test-runner.iid
	./script internal-run-one-test "$*" expect-failure

test-runner.iid: $(shell find ../.. -path ../../tests/integration-tests/testcases -prune -o -print)
	docker build --iidfile test-runner.iid \
		--build-arg userUID="$(shell id -u)" \
		--build-arg userNAME="$(shell if [ `id -u` -eq 0 ]; then echo root; else echo user; fi)" \
		--build-arg userWORKDIR="$(shell if [ `id -u` -eq 0 ]; then echo /root; else echo /home/user; fi)" \
		-f Dockerfile ../..

.PHONY: run-tests generate-tests
