##Dockerfile to Build Maker2 image

maker2 publication  https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-12-491

*using a localperl installation to enable the mpi (default perl comes with pthread support which leads to errors maker is run with mpiexec)
*substitution of with default perl with loacalperl at the moment quick and dirty
*trf is provided ia this git because of problems whens loading the binary with wget

*use the image like this:

```
docker run -it -v $(pwd):/media maker -CTL
```

creates the maker control fles in the current working directory

```
docker run -it -v $(pwd):/media maker

```
starts the maker run when all three control files are located in the current working directory

paths to data files should start with /media because this is theworking directory in the docker image


```
docker run -it -v $(pwd):/media mpiexec -n 24 --allow-run-as-root maker

 ```

 runs maker with 24 cores and openmpi
