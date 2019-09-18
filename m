Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069F2B68BC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfIRRL5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 13:11:57 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33454 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfIRRL4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 13:11:56 -0400
Received: by mail-io1-f46.google.com with SMTP id m11so1064487ioo.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsIivjyq7s+rHbq1SBfL3K6n4X9p6nX1VwC2HjMkoJU=;
        b=Nz5lbgOrn/SRGiKSydDAkqLyJe1WqKh7AfqKPdYcpzGOTcFzkPnOiMO85KBGVQ+GaN
         ueSItcALteu/YVFckCQ0DyP7Ep3M4JZ4Tb5IhiHr6+9ULjLOZsKtYDYvHGRaXiAaD9FO
         ikOr4m00xDyGhvJxA2v9KdaafU/RcEBmGTA9XFGq/oJt1NFt7JTJ7Dg0/MYjbD4bMYm2
         0ghVTJuDeulnqkaAY4906nAkgvV4ROF/6Ct9uN7Xq+s8KgXQ1C+j52S+qNQu40Lpqdsi
         LDHd/e0qqcWGVpfOBFyQVEPfLa89WAHOPfkwU0xWeirs1CBgTiqr+sg7hJJuR0oHq6Aa
         +cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsIivjyq7s+rHbq1SBfL3K6n4X9p6nX1VwC2HjMkoJU=;
        b=crBB31aBI8xHPFHtW29wWD3eZ90dZLBeUloIexDkpQ+/vhR1Illfr88dHuK1zTs+tB
         it3UOacSdorA5PXiVCkwr3MQtWG7IdhB17bPuKMJXNgVMTaKvBWTtI7ljEKg/l6/4nlF
         /xSADeA1J0P/QIt+GqgoSun54loLRJ0Xt2SprlbKEe38jNJVwJc7+M/rjyxgm0a4hFbm
         94axkrChfkYKdYPh3BgnZysJsXNyJsIR0fUfIJ2G13cHVouTIlwQig9ROAhTZXEeHcpc
         wIDqMFC/lPA50QDE1ByjdLT2IBQaeW09Bkqyk0a2qJI+ifvTmvcAxGRwZ5cmMaK4u7Of
         50+Q==
X-Gm-Message-State: APjAAAWOilNLs5ImWHPsdyGpszBDfrNII2ugGiJcLgM/kLIZeEDRsq4K
        SlpQNdl8g6tOEF9teqZmn8K+F44RA/JjDmBMYJrBktB0WNQ=
X-Google-Smtp-Source: APXvYqy76486O/nfUpQcoNKCk6tJLzAMWdIFzRzL0z8OvgNXKHY1w2cNGaxvLPBtchgkZJM4huByj6iTmthq+hZy72o=
X-Received: by 2002:a5e:c745:: with SMTP id g5mr4353576iop.9.1568826714135;
 Wed, 18 Sep 2019 10:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com>
 <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
 <CAKKzd-9zK0ZKWksyp7S+myGrtbc3s4npEhy02SS-wfLCS0tKSw@mail.gmail.com> <CABPxzYJ1YCwdVqba74aptV3KCwCDFT_UP8TCh6C30-gu=CRKNQ@mail.gmail.com>
In-Reply-To: <CABPxzYJ1YCwdVqba74aptV3KCwCDFT_UP8TCh6C30-gu=CRKNQ@mail.gmail.com>
From:   David Ho <davidkwho@gmail.com>
Date:   Wed, 18 Sep 2019 10:11:43 -0700
Message-ID: <CAKKzd-8=K=3mDQ4mbqWpas9HgnDqG-veV64C4gFpGtqXyBO-0Q@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 18, 2019 at 1:14 AM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> Is this a new issue probably after some update? The only thing we can
> see from the
> kernel logs are that Auth/Assoc are getting timed-out, no info as to why?
>

This is a new HP laptop I bought recently, wiped Windows, and
installed the latest LTS Ubuntu.
The only updates are the critical/minor updates from the update manager.

I can't tell you why this happened other than the fact that it failed
100% of the time at that Starbucks location, before that I was using a
6-year-old Windows laptop at that same location for more than a year.

hardware setup:
davidkwho@mumble15:~$ sudo lshw
mumble15
    description: Notebook
    product: HP Laptop 15-da0xxx (3FR23AV)
    vendor: HP
    version: Type1ProductConfigId
    serial: CND9140Z5B
    width: 64 bits
    capabilities: smbios-3.0 dmi-3.0 smp vsyscall32
    configuration: administrator_password=disabled boot=normal
chassis=notebook family=103C_5335KV HP Notebook sku=3FR23AV
uuid=52464501-5420-11E9-8101-C46516E85DBD
  *-core
       description: Motherboard
       product: 84A6
       vendor: HP
       physical id: 0
       version: 80.41
       serial: PHJFBC2WVC4US5
       slot: Type2 - Board Chassis Location
     *-firmware
          description: BIOS
          vendor: Insyde
          physical id: 0
          version: F.18
          date: 03/15/2019
          size: 128KiB
          capacity: 6080KiB
          capabilities: pci upgrade shadowing cdboot bootselect edd
int13floppynec int13floppytoshiba int13floppy360 int13floppy1200
int13floppy720 int13floppy2880 int9keyboard int10video acpi usb
biosbootspecification uefi
     *-cpu
          description: CPU
          product: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
          serial: To Be Filled By O.E.M.
          slot: U3E1
          size: 3328MHz
          capacity: 4005MHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr
pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc art
arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid
aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est
tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe
popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1
avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt
xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify
hwp_act_window hwp_epp md_clear flush_l1d cpufreq
          configuration: cores=4 enabledcores=4 threads=8
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1 Cache
             size: 256KiB
             capacity: 256KiB
             capabilities: synchronous internal write-back unified
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2 Cache
             size: 1MiB
             capacity: 1MiB
             capabilities: synchronous internal write-back unified
             configuration: level=2
        *-cache:2
             description: L3 cache
             physical id: 7
             slot: L3 Cache
             size: 8MiB
             capacity: 8MiB
             capabilities: synchronous internal write-back unified
             configuration: level=3
     *-memory
          description: System Memory
          physical id: 27
          slot: System board or motherboard
          size: 8GiB
        *-bank:0
             description: SODIMM DDR4 Synchronous Unbuffered
(Unregistered) 2400 MHz (0.4 ns)
             product: 8ATF1G64HZ-2G6E1
             vendor: Micron
             physical id: 0
             serial: 206C7068
             slot: Bottom-slot 1(left)
             size: 8GiB
             width: 64 bits
             clock: 2400MHz (0.4ns)
        *-bank:1
             description: SODIMM DDR Synchronous [empty]
             physical id: 1
             slot: Bottom-slot 2(right)
     *-pci
          description: Host bridge
          product: Xeon E3-1200 v6/7th Gen Core Processor Host
Bridge/DRAM Registers
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 08
          width: 32 bits
          clock: 33MHz
          configuration: driver=skl_uncore
          resources: irq:0
        *-display
             description: VGA compatible controller
             product: UHD Graphics 620
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: pciexpress msi pm vga_controller bus_master
cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:128 memory:b0000000-b0ffffff
memory:a0000000-afffffff ioport:5000(size=64) memory:c0000-dffff
        *-generic:0
             description: Signal processing controller
             product: Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
Processor Thermal Subsystem
             vendor: Intel Corporation
             physical id: 4
             bus info: pci@0000:00:04.0
             version: 08
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm cap_list
             configuration: driver=proc_thermal latency=0
             resources: irq:16 memory:b1220000-b1227fff
        *-generic:1 UNCLAIMED
             description: System peripheral
             product: Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th Gen
Core Processor Gaussian Mixture Model
             vendor: Intel Corporation
             physical id: 8
             bus info: pci@0000:00:08.0
             version: 00
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm bus_master cap_list
             configuration: latency=0
             resources: memory:b1232000-b1232fff
        *-usb
             description: USB controller
             product: Sunrise Point-LP USB 3.0 xHCI Controller
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:124 memory:b1210000-b121ffff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 5.0.0-27-generic xhci-hcd
                physical id: 0
                bus info: usb@1
                logical name: usb1
                version: 5.00
                capabilities: usb-2.00
                configuration: driver=hub slots=12 speed=480Mbit/s
              *-usb:0
                   description: USB hub
                   product: USB 2.0 Hub
                   vendor: Terminus Technology Inc.
                   physical id: 1
                   bus info: usb@1:1
                   version: 1.11
                   capabilities: usb-2.00
                   configuration: driver=hub maxpower=100mA slots=4
speed=480Mbit/s
                 *-usb
                      description: Keyboard
                      product: USB Receiver
                      vendor: Logitech
                      physical id: 2
                      bus info: usb@1:1.2
                      version: 12.01
                      capabilities: usb-2.00
                      configuration: driver=usbhid maxpower=98mA speed=12Mbit/s
              *-usb:1
                   description: Keyboard
                   product: USB Receiver
                   vendor: Logitech
                   physical id: 2
                   bus info: usb@1:2
                   version: 12.01
                   capabilities: usb-2.00
                   configuration: driver=usbhid maxpower=98mA speed=12Mbit/s
              *-usb:2
                   description: Video
                   product: HP TrueVision HD Camera
                   vendor: SunplusIT Inc
                   physical id: 5
                   bus info: usb@1:5
                   version: 0.02
                   capabilities: usb-2.00
                   configuration: driver=uvcvideo maxpower=500mA speed=480Mbit/s
              *-usb:3
                   description: Bluetooth wireless interface
                   product: Bluetooth Radio
                   vendor: Realtek
                   physical id: 6
                   bus info: usb@1:6
                   version: 1.10
                   serial: 00e04c000001
                   capabilities: bluetooth usb-1.10
                   configuration: driver=btusb maxpower=500mA speed=12Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 5.0.0-27-generic xhci-hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 5.00
                capabilities: usb-3.00
                configuration: driver=hub slots=6 speed=5000Mbit/s
        *-generic:2
             description: Signal processing controller
             product: Sunrise Point-LP Thermal subsystem
             vendor: Intel Corporation
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=intel_pch_thermal latency=0
             resources: irq:18 memory:b1233000-b1233fff
        *-communication
             description: Communication controller
             product: Sunrise Point-LP CSME HECI #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: irq:127 memory:b1234000-b1234fff
        *-storage
             description: RAID bus controller
             product: 82801 Mobile SATA Controller [RAID mode]
             vendor: Intel Corporation
             physical id: 17
             bus info: pci@0000:00:17.0
             version: 21
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:125 memory:b1230000-b1231fff
memory:b1237000-b12370ff ioport:5080(size=8) ioport:5088(size=4)
ioport:5060(size=32) memory:b1235000-b12357ff
        *-pci:0
             description: PCI bridge
             product: Sunrise Point-LP PCI Express Root Port #5
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:122 ioport:4000(size=4096) memory:b1100000-b11fffff
           *-network
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit
Ethernet Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:01:00.0
                logical name: eno1
                version: 15
                serial: c4:65:16:e8:5d:bd
                size: 10Mbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix bus_master
cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd
1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes
driver=r8169 duplex=half firmware=rtl8168h-2_0.0.2 02/26/15 latency=0
link=no multicast=yes port=MII speed=10Mbit/s
                resources: irq:16 ioport:4000(size=256)
memory:b1104000-b1104fff memory:b1100000-b1103fff
        *-pci:1
             description: PCI bridge
             product: Sunrise Point-LP PCI Express Root Port #6
             vendor: Intel Corporation
             physical id: 1c.5
             bus info: pci@0000:00:1c.5
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:123 ioport:3000(size=4096) memory:b1000000-b10fffff
           *-network
                description: Wireless interface
                product: RTL8822BE 802.11a/b/g/n/ac WiFi adapter
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:02:00.0
                logical name: wlo1
                version: 00
                serial: 48:5f:99:bc:ab:b9
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
ethernet physical wireless
                configuration: broadcast=yes driver=rtw_pci
driverversion=5.0.0-27-generic firmware=N/A ip=10.170.245.234
latency=0 link=yes multicast=yes wireless=IEEE 802.11
                resources: irq:17 ioport:3000(size=256) memory:b1000000-b100ffff
        *-isa
             description: ISA bridge
             product: Intel(R) 100 Series Chipset Family LPC
Controller/eSPI Controller - 9D4E
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 21
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
             configuration: latency=0
        *-memory UNCLAIMED
             description: Memory controller
             product: Sunrise Point-LP PMC
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 21
             width: 32 bits
             clock: 33MHz (30.3ns)
             capabilities: bus_master
             configuration: latency=0
             resources: memory:b122c000-b122ffff
        *-multimedia
             description: Audio device
             product: Sunrise Point-LP HD Audio
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=snd_hda_intel latency=32
             resources: irq:129 memory:b1228000-b122bfff
memory:b1200000-b120ffff
        *-serial UNCLAIMED
             description: SMBus
             product: Sunrise Point-LP SMBus
             vendor: Intel Corporation
             physical id: 1f.4
             bus info: pci@0000:00:1f.4
             version: 21
             width: 64 bits
             clock: 33MHz
             configuration: latency=0
             resources: memory:b1236000-b12360ff ioport:5040(size=32)
     *-scsi
          physical id: 1
          logical name: scsi2
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: SAMSUNG MZNLN128
             physical id: 0.0.0
             bus info: scsi@2:0.0.0
             logical name: /dev/sda
             version: 4H3Q
             serial: S3T8NX0M360513
             size: 119GiB (128GB)
             capabilities: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=5
guid=4dab7fd1-f689-4f70-a615-988e1d0741ee logicalsectorsize=512
sectorsize=4096
           *-volume:0 UNCLAIMED
                description: Windows FAT volume
                vendor: mkfs.fat
                physical id: 1
                bus info: scsi@2:0.0.0,1
                version: FAT32
                serial: 5e7b-a005
                size: 510MiB
                capacity: 511MiB
                capabilities: boot fat initialized
                configuration: FATs=2 filesystem=fat name=EFI System Partition
           *-volume:1
                description: EXT4 volume
                vendor: Linux
                physical id: 2
                bus info: scsi@2:0.0.0,2
                logical name: /dev/sda2
                logical name: /
                version: 1.0
                serial: 2612288a-b134-4c80-b5bb-34deee70e33f
                size: 118GiB
                capabilities: journaled extended_attributes
large_files huge_files dir_nlink recover 64bit extents ext4 ext2
initialized
                configuration: created=2019-04-13 11:09:43
filesystem=ext4 lastmountpoint=/ modified=2019-09-17 16:55:58
mount.fstype=ext4 mount.options=rw,relatime,errors=remount-ro
mounted=2019-09-17 16:56:03 state=mounted
  *-battery
       product: HT03041
       vendor: 313-2C-34-A
       physical id: 1
       version: 0
       serial: 06089 03/14/2019
       slot: Primary
       capacity: 41040mWh
       configuration: voltage=11.4V
  *-power UNCLAIMED
       description: OEM Define 1
       product: OEM Define 5
       vendor: OEM Define 2
       physical id: 2
       version: OEM Define 6
       serial: OEM Define 3
       capacity: 75mWh
