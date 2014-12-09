soem-rosbuild
=============

This project is dedicated to run the Simple Open EtherCAT Master within ROS environment 

=============
Changelog comments:

  4. add elmo emergency code dictionary: based on EtherCAT Application Manual v.1.403 November 2012, section 6.1 Emergency Error Description (p.73)

  3. change lib used - Xenomai POSIX, cflags & ldflags update: use Xenomai lib instead of Linux
      CLOCK_MONOTONIC is critical to our application, the change suggested in: http://www.xenomai.org/pipermail/xenomai/2014-September/031720.html is not take into account.

  2. exception with Elmo product when read PDO map: When read PDO mapping of slaves, skip the method using Complete Access (CA) & use directly CAN over EtherCAT (CoE), which give the right size of EtherCAT frame input & output buffer.

  1. rtnet define added, work now with realtime Ethernet protocol: put some define to work with RTNet, using realtime transfer through Ethernet ports instead of normal socket comm. Patch taken from here: http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-June/007165.html
