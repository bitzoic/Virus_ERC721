# Virus ERC721 Simulator

This project takes a spin on the CryptoZombies project where hosts can be infected by a virus.

Two hosts can interact with one another. When a host has a virus infection, there is a possibility for the virus to spread. Hosts can become vaccinated and wear masks to reduce their chance of infection. The effectiveness of a vaccination is determined by the mRNA value of the vaccination and the RNA value of the virus variant.

The user can perform the following actions: 
1. A host can be created.
2. A host can interact with another host.
3. A host can put on a mask.
4. A host can remove a mask.
5. A host can get vaccinated.

The following interactions can occur:
1. If neither host has a virus, no infections occur.
2. 1 host has a virus, it can infect another. If newly infected host is vaccinated, the vaccination mRNA will mutate to become more effective against the specific virus strain.
3. If both hosts have a virus, a new variant is formed. 
