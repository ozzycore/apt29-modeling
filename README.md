# apt29-modeling
## Overview
One of the popular methods for risk assessment is the attack graph and, in particular, the logical attack graph.  
MulVAL is a well-known open-source framework for constructing logical attack graphs.  
It is extensible and is commonly used by researchers, but still, it doesn't cover many attack scenarios.  
To increase MulVAL's coverage of attack scenarios and simplify the time-consuming and error-prone modeling process, we propose a methodology for creating interaction rules for currently uncovered attack techniques.  
We present the usage of the proposed methodology on Techniques picked from the MITRE evaluation APT29 attack scenario.  

## Repository Structure
- **/steps**: all the modeld IRs (Interaction Rules) chosed from the MITRE Evaluation APT29 scenario.
- **/docs**: relevant documentaion.
- **Dockerfile**: Dockerfile for running the MulVAL environment.

## Build instructions
```
# Build the dockerfile
docker build -f Dockerfile -t local/mulval:latest . 

# Run the image (you can mount the required directories)
docker run \
--mount src=`pwd`/scenarios,target=/root/mulval/scenarios,type=bind \
--mount src=`pwd`/kb,target=/root/mulval/kb,type=bind \
-it --platform linux/amd64 local/mulval /bin/bash ```

```
## Generating LAG using MulVAL
```
graph_gen.sh input.P -r interaction_rules.P -p -v
```

## References

- [MITRE Evaluation - APT29 scenario](https://attackevals.mitre-engenuity.org/enterprise/apt29/operational-flow)
- [A Survey of MulVAL Extensions and Their Attack Scenarios Coverage](https://arxiv.org/pdf/2208.05750.pdf)