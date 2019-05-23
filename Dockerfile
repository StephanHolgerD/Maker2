#MAINTAINER stephan.drukewitz@ime.fraunofer.de
FROM ubuntu:16.04
WORKDIR /opt/Maker
ADD ./trf /usr/local/bin
ADD ./maker/ /opt/Maker/maker
RUN apt-get update && apt-get -y install \
    build-essential \
    wget \
    libboost-iostreams-dev \
    zlib1g-dev \
    bamtools \
    libbamtools-dev \
    libgd-dev \
    hmmer ; \
  cpan App::cpanminus ; \
  cpanm \
    File::Which \
    Bio::Root::Version \
    IO::All \
    IO::Prompt \
    DBD::SQLite \
    Perl::Unsafe::Signals \
    Bit::Vector \
    Inline::C \
    forks \
    forks::shared \
    Want \
    ExtUtils::CBuilder \
    DBI \
    File::Which \
    LWP::Simple \
    File::Which \
    Term::ReadKey \
    DBD::Pg \
    Carp \
    Text::Soundex ; \
  wget http://bioinf.uni-greifswald.de/augustus/binaries/old/augustus-3.2.3.tar.gz ; \
  wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz ; \
  wget http://korflab.ucdavis.edu/Software/snap-2013-11-29.tar.gz ; \
  wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.28/ncbi-blast-2.2.28+-x64-linux.tar.gz ; \
  wget https://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20170127.tar.gz ; \
  wget http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0-x86_64.tar.gz ; \
  tar -xzvf RepeatMasker-open-4-0-7.tar.gz ;\
  tar -xzvf snap-2013-11-29.tar.gz ;\
  tar -xzvf exonerate-2.2.0-x86_64.tar.gz ;\
  tar -xzvf augustus-3.2.3.tar.gz ; \
  tar -xzvf ncbi-blast-2.2.28+-x64-linux.tar.gz ; \
  cd snap ; make ; cd .. ; \
  wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.gz ; \
      tar -xzvf openmpi-4.0.1.tar.gz ; \
      mkdir openmpi ; \
      cd openmpi-4.0.1 ; \
      ./configure prefix=/opt/Maker/openmpi ; \
      make all ; \
      make install ; \
      cd .. ; \
  cd RepeatMasker ; printf "\n\n\n\n4\n/usr/bin/\n\n5\n" | ./configure ; cd .. ; \
  rm *tar.gz ;

ENV PATH=${PATH}:\
/opt/Maker/RepeatMasker\
:/opt/Maker/snap\
:/opt/Maker/ncbi-blast-2.2.28+/bin\
:/opt/Maker/exonerate-2.2.0-x86_64/bin\
:/opt/Maker/augustus-3.2.3/bin\
:/opt/Maker/openmpi/bin\
:/opt/Maker/maker

#RUN cd maker/src && printf "y\n\n\n" | perl Build.PL && ./Build installdeps ; \

#RUN cd RepeatMasker ; printf "\n\n\n\n4\n/usr/bin/\n\n5\n" | ./configure ; cd ../maker/src && printf "y\n\n\n" | perl Build.PL && ./Build installdeps && ./Build status
