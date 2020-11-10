Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAD2ACFA3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 07:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKJG1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 01:27:30 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:34876 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKJG10 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 01:27:26 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2020 01:26:20 EST
Date:   Tue, 10 Nov 2020 07:20:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1604989244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3AclDd/hWNhXNZBEp8pkvqpQ3Z7/BAxiHTt0z/Nzo+Y=;
        b=ZHHEGB24U8LePpWdLTElWEEHJCSPsXkmhym0Jb9HDMEAr9yJZXEkw9pbLlczl+FQS7FXhs
        B6FtjRDHJ4RglyMFJoSogQkc6uoQ8Lbq2DXSLGz0oVW+lUnEngTDf84l83biQb6LHFh+ri
        6WDo5f3Z49oPgy0m1A9tcY/Xsi6PrnrgffTi+KMs5CU4pRRlKux8LUjAN3YeANYEakZ6MH
        hAAjD+yeGCnHZOpz929DsbnOUBdBIHn5OfGvJP1ppTBNdPEtZ1nokAWQX0lDbm9VYZjhmA
        nV2EL/K0IkzQ6/oMJx8wDoanUoc5lQa5XdLobnAGO8cdp0XS7c96DTkx95PlBQ==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Crash / Null pointer dereference in l2cap_chan_send()
Message-ID: <20201110062039.GC2423@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

With Linux 5.9.6 and on Debian Sid I frequently run into bluetooth+wifi rel=
ated
kernel panics with iwlwifi. Typically on wifi (re)connection
bluetooth/A2DP audio first freezes. And then the kernel panics on
either triggering a disconnect in bluetoothctl, a pulseaudio
restart or on calling "hciconfig hci0 down".

Call traces are usually pointing to one of the following modules/functions:

* l2cap_chan_send+0x109/0xb80 [bluetooth]
* i915_gem_execbuffer2_ioctl+0x386/0x490 [i915]
* drm_vma_node_allow+0x27/0xd0 [drm]
* drm_syncobj_create+0x2a/0xc0 [drm]

(see bottom for full dmesg outputs)

The issue was introduced with the following commit:

    f4bfdc5e571e ("iwlwifi: mvm: stop supporting swcrypto and bt_coex_activ=
e module parameters")
    * first affected tag: v5.8-rc1


Full steps to reproduce:

$ sudo systemctl --global disable pulseaudio.service
$ sudo systemctl disable NetworkManager
$ sudo systemctl disable bluetooth.service
$ echo "options iwlwifi bt_coex_active=3D0" | sudo tee /etc/modprobe.d/iwlw=
ifi.conf
$ sudo reboot

$ sudo systemctl start bluetooth.service
$ bluetoothctl
Agent registered
[CHG] Controller 7C:76:35:14:E6:DB Pairable: yes
{ $ pulseaudio }
[CHG] Controller 7C:76:35:14:E6:DB Class: 0x0004010c
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110b-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001108-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000180a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001112-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB Class: 0x000c010c
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110b-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001108-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000180a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001112-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110b-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001108-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000180a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001112-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB Class: 0x002c010c
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110b-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001108-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 0000180a-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 7C:76:35:14:E6:DB UUIDs: 00001112-0000-1000-8000-00805f9b3=
4fb
{ powering on BT headset }
[CHG] Device E4:22:A5:BE:D8:A1 Connected: yes
{ starting BT A2DP music, sucessful }
{ sudo ip link set up dev wlp61s0 }
{ sudo iw dev wlp61s0 connect vogtland.freifunk.net }
{ music stops, ~20 seconds later headset informs via "phone two disconnecte=
d" }
[PLT BB PRO 2]# disconnect E4:22:A5:BE:D8:A1
Attempting to disconnect from E4:22:A5:BE:D8:A1
Successful disconnected
[CHG] Device E4:22:A5:BE:D8:A1 Connected: no
[bluetooth]# connect E4:22:A5:BE:D8:A1=20
Attempting to connect to E4:22:A5:BE:D8:A1
Failed to connect: org.bluez.Error.Failed
{ sudo hciconfig hci0 down }
{ crash }


# Hardware

The laptop is a Thinkpad T480s with the following hardware:

$ lsusb
=2E..
8087:0a2b Intel Corp. Bluetooth wireless interface
=2E..
$ lspci
=2E..
3d:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
=2E..


# Software

* Linux 5.9.6 (2d182f2dc3b7d38fb1f2a74aabab50a3e0d27c3d)
* OS: Debian Sid
* pulseaudio 13.0
* bluez 5.55


# dmesg 1/5


[    0.000000] Linux version 5.9.6 (linus@linus-work) (gcc (Debian 10.2.0-1=
6) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #4 SMP Sat Nov 7 17:08:=
24 CET 2020
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.9.6 root=3D/dev/mapper=
/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G-:512M
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000074f9cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000074f9d000-0x0000000074f9dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000074f9e000-0x0000000074f9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000074f9f000-0x000000007e8f7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e8f8000-0x000000007e9bdfff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007e9be000-0x000000007ff2bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ff2c000-0x000000007ff99fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007ff9a000-0x000000007fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x0000000087ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000088600000-0x000000008c7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004727fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=3D0x7ff92000 SMBIOS=3D0x7f052000 SMBIOS 3.0=
=3D0x7f04f000 ACPI=3D0x7fffe000 ACPI 2.0=3D0x7fffe014 ESRT=3D0x7eeca000 MEM=
ATTR=3D0x7971d298=20
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (1.12 ) 04/=
09/2018
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.000998] tsc: Detected 1999.968 MHz TSC
[    0.000998] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001001] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001008] last_pfn =3D 0x472800 max_arch_pfn =3D 0x400000000
[    0.001012] MTRR default type: write-back
[    0.001013] MTRR fixed ranges enabled:
[    0.001015]   00000-9FFFF write-back
[    0.001016]   A0000-BFFFF uncachable
[    0.001017]   C0000-FFFFF write-protect
[    0.001017] MTRR variable ranges enabled:
[    0.001019]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001021]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001022]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001023]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.001023]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.001024]   5 disabled
[    0.001025]   6 disabled
[    0.001025]   7 disabled
[    0.001026]   8 disabled
[    0.001027]   9 disabled
[    0.001698] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001916] last_pfn =3D 0x80000 max_arch_pfn =3D 0x400000000
[    0.019308] esrt: Reserving ESRT space from 0x000000007eeca000 to 0x0000=
00007eeca088.
[    0.019316] kexec: Reserving the low 1M of memory for crashkernel
[    0.019320] Using GB pages for direct mapping
[    0.019672] Secure boot could not be determined
[    0.019673] RAMDISK: [mem 0x316af000-0x34b4efff]
[    0.019679] ACPI: Early table checksum verification disabled
[    0.019682] ACPI: RSDP 0x000000007FFFE014 000024 (v02 LENOVO)
[    0.019686] ACPI: XSDT 0x000000007FFAD188 000124 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019692] ACPI: FACP 0x000000007FFE1000 0000F4 (v05 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019698] ACPI: DSDT 0x000000007FFBB000 0218A6 (v02 LENOVO SKL      00=
000000 INTL 20160527)
[    0.019702] ACPI: FACS 0x000000007FF3D000 000040
[    0.019705] ACPI: SSDT 0x000000007FFE9000 01320E (v02 LENOVO DptfTabl 00=
001000 INTL 20160527)
[    0.019708] ACPI: SSDT 0x000000007FFE8000 0003DB (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20160527)
[    0.019711] ACPI: TPM2 0x000000007FFE7000 000034 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019714] ACPI: UEFI 0x000000007FF53000 000042 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019717] ACPI: SSDT 0x000000007FFE3000 0030A3 (v02 LENOVO SaSsdt   00=
003000 INTL 20160527)
[    0.019721] ACPI: SSDT 0x000000007FFE2000 0005C6 (v02 LENOVO PerfTune 00=
001000 INTL 20160527)
[    0.019724] ACPI: HPET 0x000000007FFE0000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019727] ACPI: APIC 0x000000007FFDF000 00012C (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019730] ACPI: MCFG 0x000000007FFDE000 00003C (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019733] ACPI: ECDT 0x000000007FFDD000 000053 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019736] ACPI: SSDT 0x000000007FFB9000 001C9C (v02 LENOVO RVP7Rtd3 00=
001000 INTL 20160527)
[    0.019739] ACPI: SSDT 0x000000007FFB7000 00163C (v02 LENOVO ProjSsdt 00=
000010 INTL 20160527)
[    0.019742] ACPI: BOOT 0x000000007FFB6000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019745] ACPI: BATB 0x000000007FFB5000 00004A (v02 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019748] ACPI: SLIC 0x000000007FFB4000 000176 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019751] ACPI: SSDT 0x000000007FFB2000 0017AE (v02 LENOVO CpuSsdt  00=
003000 INTL 20160527)
[    0.019755] ACPI: SSDT 0x000000007FFB1000 00056D (v02 LENOVO CtdpB    00=
001000 INTL 20160527)
[    0.019758] ACPI: SSDT 0x000000007FFB0000 000678 (v02 LENOVO UsbCTabl 00=
001000 INTL 20160527)
[    0.019761] ACPI: LPIT 0x000000007FFAF000 000094 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019764] ACPI: WSMT 0x000000007FFAE000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019767] ACPI: SSDT 0x000000007FFFD000 0001D8 (v02 LENOVO HdaDsp   00=
000000 INTL 20160527)
[    0.019770] ACPI: SSDT 0x000000007FFAC000 0004FC (v02 LENOVO TbtTypeC 00=
000000 INTL 20160527)
[    0.019773] ACPI: SSDT 0x000000007FFAB000 0002D1 (v02 LENOVO Wwan     00=
000001 INTL 20160527)
[    0.019776] ACPI: DBGP 0x000000007FFAA000 000034 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019779] ACPI: DBG2 0x000000007FFA9000 000054 (v00 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019783] ACPI: MSDM 0x000000007FFA8000 000055 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019786] ACPI: DMAR 0x000000007FFA7000 0000CC (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019789] ACPI: ASF! 0x000000007FFA6000 0000A0 (v32 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019792] ACPI: FPDT 0x000000007FFA5000 000044 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019795] ACPI: BGRT 0x000000007FFA4000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019801] ACPI: UEFI 0x000000007FF3A000 00013E (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019818] ACPI: Local APIC address 0xfee00000
[    0.019921] No NUMA configuration found
[    0.019922] Faking a node at [mem 0x0000000000000000-0x00000004727fffff]
[    0.019926] NODE_DATA(0) allocated [mem 0x4727fb000-0x4727fffff]
[    0.019946] Reserving 512MB of memory at 1280MB for crashkernel (System =
RAM: 16144MB)
[    0.019977] Zone ranges:
[    0.019978]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.019979]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.019981]   Normal   [mem 0x0000000100000000-0x00000004727fffff]
[    0.019982]   Device   empty
[    0.019983] Movable zone start for each node
[    0.019984] Early memory node ranges
[    0.019985]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.019986]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.019987]   node   0: [mem 0x0000000000100000-0x0000000074f9cfff]
[    0.019988]   node   0: [mem 0x0000000074f9f000-0x000000007e8f7fff]
[    0.019989]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.019990]   node   0: [mem 0x0000000100000000-0x00000004727fffff]
[    0.020281] Zeroed struct page in unavailable ranges: 28526 pages
[    0.020283] Initmem setup node 0 [mem 0x0000000000001000-0x00000004727ff=
fff]
[    0.020284] On node 0 totalpages: 4133010
[    0.020286]   DMA zone: 64 pages used for memmap
[    0.020287]   DMA zone: 155 pages reserved
[    0.020288]   DMA zone: 3995 pages, LIFO batch:0
[    0.020341]   DMA32 zone: 8036 pages used for memmap
[    0.020342]   DMA32 zone: 514295 pages, LIFO batch:63
[    0.025917]   Normal zone: 56480 pages used for memmap
[    0.025918]   Normal zone: 3614720 pages, LIFO batch:63
[    0.026313] Reserving Intel graphics memory at [mem 0x8a800000-0x8c7ffff=
f]
[    0.026681] ACPI: PM-Timer IO Port: 0x1808
[    0.026683] ACPI: Local APIC address 0xfee00000
[    0.026691] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.026692] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.026692] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.026693] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.026694] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.026694] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.026695] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.026696] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.026696] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.026697] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.026698] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.026698] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.026699] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.026700] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.026700] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.026701] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.026729] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.026732] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026733] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.026735] ACPI: IRQ0 used by override.
[    0.026736] ACPI: IRQ9 used by override.
[    0.026739] Using ACPI (MADT) for SMP configuration information
[    0.026740] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.026748] e820: update [mem 0x783d7000-0x784d6fff] usable =3D=3D> rese=
rved
[    0.026757] TSC deadline timer available
[    0.026758] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.026780] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.026782] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.026784] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x000fffff]
[    0.026786] PM: hibernation: Registered nosave memory: [mem 0x74f9d000-0=
x74f9dfff]
[    0.026786] PM: hibernation: Registered nosave memory: [mem 0x74f9e000-0=
x74f9efff]
[    0.026788] PM: hibernation: Registered nosave memory: [mem 0x783d7000-0=
x784d6fff]
[    0.026790] PM: hibernation: Registered nosave memory: [mem 0x7e8f8000-0=
x7e9bdfff]
[    0.026791] PM: hibernation: Registered nosave memory: [mem 0x7e9be000-0=
x7ff2bfff]
[    0.026791] PM: hibernation: Registered nosave memory: [mem 0x7ff2c000-0=
x7ff99fff]
[    0.026792] PM: hibernation: Registered nosave memory: [mem 0x7ff9a000-0=
x7fffefff]
[    0.026794] PM: hibernation: Registered nosave memory: [mem 0x80000000-0=
x87ffffff]
[    0.026795] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x885fffff]
[    0.026795] PM: hibernation: Registered nosave memory: [mem 0x88600000-0=
x8c7fffff]
[    0.026796] PM: hibernation: Registered nosave memory: [mem 0x8c800000-0=
xf7ffffff]
[    0.026797] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.026798] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfe00ffff]
[    0.026798] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0=
xfe010fff]
[    0.026799] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    0.026801] [mem 0x8c800000-0xf7ffffff] available for PCI devices
[    0.026803] Booting paravirtualized kernel on bare hardware
[    0.026806] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.032912] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.033161] percpu: Embedded 55 pages/cpu s185048 r8192 d32040 u262144
[    0.033169] pcpu-alloc: s185048 r8192 d32040 u262144 alloc=3D1*2097152
[    0.033170] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.033197] Built 1 zonelists, mobility grouping on.  Total pages: 40682=
75
[    0.033198] Policy zone: Normal
[    0.033199] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.9.6 root=3D/dev=
/mapper/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G-:512M
[    0.034596] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.035246] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.035345] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.057300] Memory: 1494496K/16532040K available (12291K kernel code, 13=
20K rwdata, 3768K rodata, 1636K init, 1748K bss, 1023068K reserved, 0K cma-=
reserved)
[    0.057309] random: get_random_u64 called from __kmem_cache_create+0x2e/=
0x540 with crng_init=3D0
[    0.057461] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.057474] Kernel/User page tables isolation: enabled
[    0.057497] ftrace: allocating 34845 entries in 137 pages
[    0.075038] ftrace: allocated 137 pages with 3 groups
[    0.075184] rcu: Hierarchical RCU implementation.
[    0.075185] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D8.
[    0.075186] 	Rude variant of Tasks RCU enabled.
[    0.075187] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.075188] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.079717] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.080118] random: crng done (trusting CPU's manufacturer)
[    0.080147] Console: colour dummy device 80x25
[    0.080153] printk: console [tty0] enabled
[    0.080173] ACPI: Core revision 20200717
[    0.080659] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    0.080728] APIC: Switch to symmetric I/O mode setup
[    0.080730] DMAR: Host address width 39
[    0.080732] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.080739] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.080741] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.080746] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.080747] DMAR: RMRR base: 0x0000007f47f000 end: 0x0000007f49efff
[    0.080749] DMAR: RMRR base: 0x0000008a000000 end: 0x0000008c7fffff
[    0.080750] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.080752] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.080753] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.080754] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.082376] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082378] x2apic enabled
[    0.082391] Switched APIC routing to cluster x2apic.
[    0.086504] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.104604] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x39a8208cdd2, max_idle_ns: 881590748921 ns
[    0.104609] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3999.93 BogoMIPS (lpj=3D7999872)
[    0.104612] pid_max: default: 32768 minimum: 301
[    0.108640] LSM: Security Framework initializing
[    0.108648] Yama: becoming mindful.
[    0.108682] AppArmor: AppArmor initialized
[    0.108685] TOMOYO Linux initialized
[    0.108735] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.108766] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.109125] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.109159] process: using mwait in idle threads
[    0.109162] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.109163] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.109166] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.109168] Spectre V2 : Mitigation: Full generic retpoline
[    0.109168] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.109169] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.109170] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.109171] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.109172] Speculative Store Bypass: Vulnerable
[    0.109174] SRBDS: Vulnerable: No microcode
[    0.109175] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.109447] Freeing SMP alternatives memory: 32K
[    0.112717] smpboot: CPU0: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xa)
[    0.112863] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112889] ... version:                4
[    0.112890] ... bit width:              48
[    0.112890] ... generic registers:      4
[    0.112891] ... value mask:             0000ffffffffffff
[    0.112892] ... max period:             00007fffffffffff
[    0.112893] ... fixed-purpose events:   3
[    0.112893] ... event mask:             000000070000000f
[    0.112946] rcu: Hierarchical SRCU implementation.
[    0.113759] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.113855] smp: Bringing up secondary CPUs ...
[    0.113964] x86: Booting SMP configuration:
[    0.113966] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.117313] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.117313]  #5 #6 #7
[    0.117440] smp: Brought up 1 node, 8 CPUs
[    0.117440] smpboot: Max logical packages: 1
[    0.117440] smpboot: Total of 8 processors activated (31999.48 BogoMIPS)
[    0.148681] node 0 deferred pages initialised in 28ms
[    0.149042] devtmpfs: initialized
[    0.149042] x86/mm: Memory block size: 128MB
[    0.150126] PM: Registering ACPI NVS region [mem 0x74f9d000-0x74f9dfff] =
(4096 bytes)
[    0.150126] PM: Registering ACPI NVS region [mem 0x7ff2c000-0x7ff99fff] =
(450560 bytes)
[    0.150126] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.150126] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.150126] pinctrl core: initialized pinctrl subsystem
[    0.150126] NET: Registered protocol family 16
[    0.150126] audit: initializing netlink subsys (disabled)
[    0.150126] audit: type=3D2000 audit(1604783934.068:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.150126] thermal_sys: Registered thermal governor 'fair_share'
[    0.150126] thermal_sys: Registered thermal governor 'bang_bang'
[    0.150126] thermal_sys: Registered thermal governor 'step_wise'
[    0.150126] thermal_sys: Registered thermal governor 'user_space'
[    0.150126] cpuidle: using governor ladder
[    0.150126] cpuidle: using governor menu
[    0.150126] Simple Boot Flag at 0x47 set to 0x1
[    0.150126] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.150126] ACPI: bus type PCI registered
[    0.150126] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.152623] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.152627] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.152649] PCI: Using configuration type 1 for base access
[    0.153108] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.153845] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.153845] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.349162] ACPI: Added _OSI(Module Device)
[    0.349162] ACPI: Added _OSI(Processor Device)
[    0.349162] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.349162] ACPI: Added _OSI(Processor Aggregator Device)
[    0.349162] ACPI: Added _OSI(Linux-Dell-Video)
[    0.349162] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.349162] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.415703] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.417383] ACPI: EC: EC started
[    0.417384] ACPI: EC: interrupt blocked
[    0.419802] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.419802] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.421907] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.497399] ACPI: Dynamic OEM Table Load:
[    0.497422] ACPI: SSDT 0xFFFF8CD247722000 0005CD (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.499271] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.500712] ACPI: Dynamic OEM Table Load:
[    0.500723] ACPI: SSDT 0xFFFF8CD405EAC000 0003FF (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.502561] ACPI: Dynamic OEM Table Load:
[    0.502570] ACPI: SSDT 0xFFFF8CD247306540 0000BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.504263] ACPI: Dynamic OEM Table Load:
[    0.504272] ACPI: SSDT 0xFFFF8CD247727000 000628 (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.506444] ACPI: Dynamic OEM Table Load:
[    0.506458] ACPI: SSDT 0xFFFF8CD405EB4000 000D14 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.509086] ACPI: Dynamic OEM Table Load:
[    0.509095] ACPI: SSDT 0xFFFF8CD405EAB000 000317 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.510969] ACPI: Dynamic OEM Table Load:
[    0.510978] ACPI: SSDT 0xFFFF8CD405EA8800 00030A (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.516220] ACPI: Interpreter enabled
[    0.516291] ACPI: (supports S0 S3 S4 S5)
[    0.516292] ACPI: Using IOAPIC for interrupt routing
[    0.516343] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.517204] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.522003] ACPI: Power Resource [PUBS] (on)
[    0.552879] ACPI: Power Resource [PXP] (on)
[    0.574142] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.574149] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.576945] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.578542] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR]
[    0.578543] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.581241] PCI host bridge to bus 0000:00
[    0.581244] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.581245] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.581247] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.581248] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]
[    0.581249] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    0.581250] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]
[    0.581251] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]
[    0.581252] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]
[    0.581254] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]
[    0.581255] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]
[    0.581256] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]
[    0.581257] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]
[    0.581258] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]
[    0.581259] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]
[    0.581260] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]
[    0.581262] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ffff=
f window]
[    0.581263] pci_bus 0000:00: root bus resource [mem 0x8c800000-0xf7fffff=
f window]
[    0.581264] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    0.581266] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.581283] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.582399] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.582412] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.582421] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.582427] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.582450] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.583588] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.583601] pci 0000:00:04.0: reg 0x10: [mem 0xe8240000-0xe8247fff 64bit]
[    0.584828] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.584842] pci 0000:00:08.0: reg 0x10: [mem 0xe8250000-0xe8250fff 64bit]
[    0.585993] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.586012] pci 0000:00:14.0: reg 0x10: [mem 0xe8220000-0xe822ffff 64bit]
[    0.586088] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.587350] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.587371] pci 0000:00:14.2: reg 0x10: [mem 0xe8251000-0xe8251fff 64bit]
[    0.588663] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.588870] pci 0000:00:15.0: reg 0x10: [mem 0xe8252000-0xe8252fff 64bit]
[    0.590893] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.590917] pci 0000:00:16.0: reg 0x10: [mem 0xe8253000-0xe8253fff 64bit]
[    0.590998] pci 0000:00:16.0: PME# supported from D3hot
[    0.592205] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.593338] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.593520] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.594632] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.594824] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.594914] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.596126] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.596232] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.597478] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.598762] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.598777] pci 0000:00:1f.2: reg 0x10: [mem 0xe824c000-0xe824ffff]
[    0.599987] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.600013] pci 0000:00:1f.3: reg 0x10: [mem 0xe8248000-0xe824bfff 64bit]
[    0.600050] pci 0000:00:1f.3: reg 0x20: [mem 0xe8230000-0xe823ffff 64bit]
[    0.600109] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.601338] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.601390] pci 0000:00:1f.4: reg 0x10: [mem 0xe8254000-0xe82540ff 64bit]
[    0.601441] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.602668] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.602689] pci 0000:00:1f.6: reg 0x10: [mem 0xe8200000-0xe821ffff]
[    0.602801] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.604013] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.604102] pci 0000:04:00.0: [8086:15c0] type 01 class 0x060400
[    0.604161] pci 0000:04:00.0: enabling Extended Tags
[    0.604255] pci 0000:04:00.0: supports D1 D2
[    0.604257] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604432] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.604437] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.604442] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.604525] pci 0000:05:00.0: [8086:15c0] type 01 class 0x060400
[    0.604588] pci 0000:05:00.0: enabling Extended Tags
[    0.604686] pci 0000:05:00.0: supports D1 D2
[    0.604687] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604828] pci 0000:05:01.0: [8086:15c0] type 01 class 0x060400
[    0.604890] pci 0000:05:01.0: enabling Extended Tags
[    0.604990] pci 0000:05:01.0: supports D1 D2
[    0.604991] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605121] pci 0000:05:02.0: [8086:15c0] type 01 class 0x060400
[    0.605183] pci 0000:05:02.0: enabling Extended Tags
[    0.605278] pci 0000:05:02.0: supports D1 D2
[    0.605279] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605442] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.605452] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.605460] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.605535] pci 0000:06:00.0: [8086:15bf] type 00 class 0x088000
[    0.605558] pci 0000:06:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.605571] pci 0000:06:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.605639] pci 0000:06:00.0: enabling Extended Tags
[    0.605752] pci 0000:06:00.0: supports D1 D2
[    0.605753] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605930] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.605939] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.605993] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.606003] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.606010] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.606099] pci 0000:3c:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.606124] pci 0000:3c:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.606210] pci 0000:3c:00.0: enabling Extended Tags
[    0.606326] pci 0000:3c:00.0: supports D1 D2
[    0.606327] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.606421] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.606539] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.606549] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.606910] pci 0000:3d:00.0: [8086:24fd] type 00 class 0x028000
[    0.606947] pci 0000:3d:00.0: reg 0x10: [mem 0xe8100000-0xe8101fff 64bit]
[    0.607384] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    0.607970] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.607975] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.608231] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.608255] pci 0000:3e:00.0: reg 0x10: [mem 0xe8000000-0xe8003fff 64bit]
[    0.612646] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.612651] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.615723] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.615789] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.615849] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.615909] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.615969] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.616028] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.616088] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.616148] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.617019] ACPI: EC: interrupt unblocked
[    0.617020] ACPI: EC: event unblocked
[    0.617033] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.617033] ACPI: EC: GPE=3D0x16
[    0.617035] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.617037] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.617144] iommu: Default domain type: Translated=20
[    0.617164] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.617164] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.617164] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.617164] vgaarb: loaded
[    0.617164] EDAC MC: Ver: 3.0.0
[    0.617170] Registered efivars operations
[    0.617170] NetLabel: Initializing
[    0.617170] NetLabel:  domain hash size =3D 128
[    0.617170] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.617170] NetLabel:  unlabeled traffic allowed by default
[    0.617170] PCI: Using ACPI for IRQ routing
[    0.619306] PCI: pci_cache_line_size set to 64 bytes
[    0.621348] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.621349] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.621350] e820: reserve RAM buffer [mem 0x74f9d000-0x77ffffff]
[    0.621352] e820: reserve RAM buffer [mem 0x783d7000-0x7bffffff]
[    0.621353] e820: reserve RAM buffer [mem 0x7e8f8000-0x7fffffff]
[    0.621354] e820: reserve RAM buffer [mem 0x472800000-0x473ffffff]
[    0.621394] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.621398] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.623444] clocksource: Switched to clocksource tsc-early
[    0.633623] VFS: Disk quotas dquot_6.6.0
[    0.633643] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.633797] AppArmor: AppArmor Filesystem Enabled
[    0.633815] pnp: PnP ACPI init
[    0.634058] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.634060] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.634062] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.634063] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.634065] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.634066] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.634068] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.634074] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.634512] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.634517] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.635079] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.635080] system 00:02: [io  0xffff] has been reserved
[    0.635082] system 00:02: [io  0xffff] has been reserved
[    0.635083] system 00:02: [io  0xffff] has been reserved
[    0.635085] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.635086] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.635090] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.635231] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.635284] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.635288] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    0.635312] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.635331] pnp 00:06: Plug and Play ACPI device, IDs LEN008f PNP0f13 (a=
ctive)
[    0.635469] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.635471] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.635473] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.635474] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.635476] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.635478] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.635480] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.635481] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.635482] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.635484] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.635485] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.635487] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.635489] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.635491] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.635492] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.635494] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.635495] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.635497] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.635499] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.635500] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.635504] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.637269] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.637270] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.637272] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.637276] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.638444] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.638446] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.638447] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.638449] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.638450] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.638452] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.638453] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.638455] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.638456] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.638458] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.638462] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.638797] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.638798] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.638800] system 00:0a: [mem 0x00100000-0x8c7fffff] could not be reser=
ved
[    0.638802] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.638803] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.638807] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.638977] pnp: PnP ACPI: found 11 devices
[    0.645020] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.645091] NET: Registered protocol family 2
[    0.645272] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.645399] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.645663] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.645766] TCP: Hash tables configured (established 131072 bind 65536)
[    0.645825] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.645886] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.645967] NET: Registered protocol family 1
[    0.645973] NET: Registered protocol family 44
[    0.645982] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    0.645985] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.645987] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    0.645989] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus =
07-3b] add_size 1000
[    0.645993] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus =
05-3c] add_size 1000
[    0.645994] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
04-3c] add_size 2000
[    0.646009] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8c800000-0x8c9ffff=
f]
[    0.646021] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8ca00000-0x8cbffff=
f 64bit pref]
[    0.646024] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.646026] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x4fff]
[    0.646030] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.646034] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.646039] pci 0000:00:1c.0:   bridge window [mem 0x8c800000-0x8c9fffff]
[    0.646042] pci 0000:00:1c.0:   bridge window [mem 0x8ca00000-0x8cbfffff=
 64bit pref]
[    0.646048] pci 0000:04:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.646051] pci 0000:05:01.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.646053] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.646058] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.646068] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.646071] pci 0000:05:01.0:   bridge window [io  0x3000-0x3fff]
[    0.646076] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.646080] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.646087] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.646092] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.646102] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.646104] pci 0000:04:00.0:   bridge window [io  0x3000-0x3fff]
[    0.646109] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.646113] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.646119] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.646121] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.646125] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.646128] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.646133] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.646137] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.646143] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.646149] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.646157] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.646158] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.646160] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.646161] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.646162] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.646163] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.646164] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.646166] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.646167] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.646168] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.646169] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.646170] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.646171] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.646172] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.646174] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.646175] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.646176] pci_bus 0000:00: resource 20 [mem 0x8c800000-0xf7ffffff wind=
ow]
[    0.646177] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.646179] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.646180] pci_bus 0000:01: resource 1 [mem 0x8c800000-0x8c9fffff]
[    0.646181] pci_bus 0000:01: resource 2 [mem 0x8ca00000-0x8cbfffff 64bit=
 pref]
[    0.646183] pci_bus 0000:04: resource 0 [io  0x3000-0x4fff]
[    0.646184] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.646185] pci_bus 0000:04: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.646186] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.646187] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.646189] pci_bus 0000:05: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.646190] pci_bus 0000:06: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.646191] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.646192] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.646193] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.646195] pci_bus 0000:3c: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.646196] pci_bus 0000:3d: resource 1 [mem 0xe8100000-0xe81fffff]
[    0.646197] pci_bus 0000:3e: resource 1 [mem 0xe8000000-0xe80fffff]
[    0.646361] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.646886] pci 0000:04:00.0: enabling device (0006 -> 0007)
[    0.647483] PCI: CLS 128 bytes, default 64
[    0.647546] Trying to unpack rootfs image as initramfs...
[    1.863822] Freeing initrd memory: 53888K
[    1.863896] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:1=
5.0
[    1.863918] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.863920] software IO TLB: mapped [mem 0x79f2f000-0x7df2f000] (64MB)
[    1.864573] Initialise system trusted keyrings
[    1.864582] Key type blacklist registered
[    1.864650] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.866061] zbud: loaded
[    1.866249] integrity: Platform Keyring initialized
[    1.866252] Key type asymmetric registered
[    1.866253] Asymmetric key parser 'x509' registered
[    1.866260] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.866314] io scheduler mq-deadline registered
[    1.866752] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.866785] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.866964] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    1.866989] pcieport 0000:00:1c.4: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.867283] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    1.867527] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.867914] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
[    1.868051] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.868372] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.868399] efifb: probing for efifb
[    1.868416] efifb: framebuffer at 0xc0000000, using 14400k, total 14400k
[    1.868417] efifb: mode is 2560x1440x32, linelength=3D10240, pages=3D1
[    1.868418] efifb: scrolling: redraw
[    1.868419] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.868522] Console: switching to colour frame buffer device 160x45
[    1.877827] fb0: EFI VGA frame buffer device
[    1.877836] intel_idle: MWAIT substates: 0x11142120
[    1.877837] intel_idle: v0.5.1 model 0x8E
[    1.878404] intel_idle: Local APIC timer is reliable in all C-states
[    1.883366] thermal LNXTHERM:00: registered as thermal_zone0
[    1.883368] ACPI: Thermal Zone [THM0] (45 C)
[    1.883654] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.884374] Linux agpgart interface v0.103
[    1.884421] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.884422] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    1.885169] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.887195] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.887200] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.887365] mousedev: PS/2 mouse device common for all mice
[    1.887422] rtc_cmos 00:03: RTC can wake from S4
[    1.888144] rtc_cmos 00:03: registered as rtc0
[    1.888291] rtc_cmos 00:03: setting system clock to 2020-11-07T21:18:56 =
UTC (1604783936)
[    1.888327] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[    1.888337] intel_pstate: Intel P-state driver initializing
[    1.889061] intel_pstate: HWP enabled
[    1.889209] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.889498] ledtrig-cpu: registered to indicate activity on CPUs
[    1.889847] NET: Registered protocol family 10
[    1.897128] Segment Routing with IPv6
[    1.897143] mip6: Mobile IPv6
[    1.897144] NET: Registered protocol family 17
[    1.897300] mpls_gso: MPLS GSO support
[    1.897977] microcode: sig=3D0x806ea, pf=3D0x80, revision=3D0x84
[    1.898228] microcode: Microcode Update Driver: v2.2.
[    1.898230] IPI shorthand broadcast: enabled
[    1.898235] sched_clock: Marking stable (1897376250, 558494)->(190552722=
7, -7592483)
[    1.898479] registered taskstats version 1
[    1.898481] Loading compiled-in X.509 certificates
[    1.898503] zswap: loaded using pool lzo/zbud
[    1.898749] Key type ._fscrypt registered
[    1.898750] Key type .fscrypt registered
[    1.898751] Key type fscrypt-provisioning registered
[    1.898777] AppArmor: AppArmor sha1 policy hashing enabled
[    1.899559] integrity: Loading X.509 certificate: UEFI:db
[    1.899575] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.899575] integrity: Loading X.509 certificate: UEFI:db
[    1.899584] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.899585] integrity: Loading X.509 certificate: UEFI:db
[    1.899599] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.899599] integrity: Loading X.509 certificate: UEFI:db
[    1.899611] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.902178] Freeing unused kernel image (initmem) memory: 1636K
[    1.929051] Write protecting the kernel read-only data: 18432k
[    1.929572] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.929765] Freeing unused kernel image (rodata/data gap) memory: 328K
[    1.968824] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.968825] x86/mm: Checking user space page tables
[    2.004933] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.004935] Run /init as init process
[    2.004936]   with arguments:
[    2.004936]     /init
[    2.004937]   with environment:
[    2.004937]     HOME=3D/
[    2.004937]     TERM=3Dlinux
[    2.004938]     BOOT_IMAGE=3D/vmlinuz-5.9.6
[    2.004938]     crashkernel=3D384M-8G:128M,8G-:512M
[    2.073746] button: module verification failed: signature and/or require=
d key missing - tainting kernel
[    2.074008] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    2.082053] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.082110] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.086301] ACPI: bus type USB registered
[    2.086313] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    2.086317] usbcore: registered new interface driver usbfs
[    2.086323] usbcore: registered new interface driver hub
[    2.086350] usbcore: registered new device driver usb
[    2.086573] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    2.089918] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    2.091229] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.091236] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    2.092321] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000081109810
[    2.092340] cryptd: max_cpu_qlen set to 1000
[    2.092635] ACPI: Sleep Button [SLPB]
[    2.092685] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.092724] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input4
[    2.092734] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.092816] ACPI: Lid Switch [LID]
[    2.092875] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input5
[    2.092893] ACPI: Power Button [PWRF]
[    2.092934] xhci_hcd 0000:00:14.0: cache line size of 128 is not support=
ed
[    2.093197] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.093198] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.093199] usb usb1: Product: xHCI Host Controller
[    2.093200] usb usb1: Manufacturer: Linux 5.9.6 xhci-hcd
[    2.093200] usb usb1: SerialNumber: 0000:00:14.0
[    2.093577] hub 1-0:1.0: USB hub found
[    2.093601] hub 1-0:1.0: 12 ports detected
[    2.096051] pps_core: LinuxPPS API ver. 1 registered
[    2.096051] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.096367] AVX2 version of gcm_enc/dec engaged.
[    2.096367] AES CTR mode by8 optimization enabled
[    2.099946] PTP clock support registered
[    2.100219] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.100911] i2c i2c-0: Successfully instantiated SPD at 0x51
[    2.103607] battery: ACPI: Battery Slot [BAT0] (battery present)
[    2.103700] nvme nvme0: pci function 0000:3e:00.0
[    2.103948] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.103951] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    2.103954] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.104182] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.104183] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.104184] usb usb2: Product: xHCI Host Controller
[    2.104185] usb usb2: Manufacturer: Linux 5.9.6 xhci-hcd
[    2.104186] usb usb2: SerialNumber: 0000:00:14.0
[    2.104280] hub 2-0:1.0: USB hub found
[    2.104373] hub 2-0:1.0: 6 ports detected
[    2.104765] usb: port power management may be unreliable
[    2.104987] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.104991] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 3
[    2.106138] xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    2.106291] e1000e: Intel(R) PRO/1000 Network Driver
[    2.106292] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.106465] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    2.106685] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.106686] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.106687] usb usb3: Product: xHCI Host Controller
[    2.106687] usb usb3: Manufacturer: Linux 5.9.6 xhci-hcd
[    2.106688] usb usb3: SerialNumber: 0000:3c:00.0
[    2.106775] hub 3-0:1.0: USB hub found
[    2.106781] hub 3-0:1.0: 2 ports detected
[    2.107223] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.107225] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 4
[    2.107228] xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.107255] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.107255] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.107256] usb usb4: Product: xHCI Host Controller
[    2.107256] usb usb4: Manufacturer: Linux 5.9.6 xhci-hcd
[    2.107257] usb usb4: SerialNumber: 0000:3c:00.0
[    2.107336] hub 4-0:1.0: USB hub found
[    2.107343] hub 4-0:1.0: 2 ports detected
[    2.111639] nvme nvme0: Shutdown timeout set to 8 seconds
[    2.120500] nvme nvme0: 8/0/0 default/read/poll queues
[    2.124432]  nvme0n1: p1 p2 p3
[    2.157770] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    2.158365] checking generic (c0000000 e10000) vs hw (e7000000 1000000)
[    2.158365] checking generic (c0000000 e10000) vs hw (c0000000 10000000)
[    2.158366] fb0: switching to inteldrmfb from EFI VGA
[    2.158410] Console: switching to colour dummy device 80x25
[    2.158430] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.159371] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    2.159396] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver=
1_04.bin failed with error -2
[    2.159397] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/kb=
l_dmc_ver1_04.bin. Disabling runtime power management.
[    2.159397] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    2.165075] i915 0000:00:02.0: [drm] Reducing the compressed framebuffer=
 size. This may lead to less power savings than a non-reduced-size. Try to =
increase stolen memory size if available in BIOS.
[    2.189709] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on mi=
nor 0
[    2.191542] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.191790] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input6
[    2.305927] fbcon: i915drmfb (fb0) is primary device
[    2.348520] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    2.415771] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 8c:=
16:45:66:ba:11
[    2.415775] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    2.415875] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    2.418033] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.448987] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    2.485162] usb 2-3: New USB device found, idVendor=3D0bda, idProduct=3D=
0316, bcdDevice=3D 2.04
[    2.485166] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.485169] usb 2-3: Product: USB3.0-CRW
[    2.485171] usb 2-3: Manufacturer: Generic
[    2.485173] usb 2-3: SerialNumber: 20120501030900000
[    2.516848] SCSI subsystem initialized
[    2.519772] usb-storage 2-3:1.0: USB Mass Storage device detected
[    2.520430] scsi host0: usb-storage 2-3:1.0
[    2.520674] usbcore: registered new interface driver usb-storage
[    2.522209] usbcore: registered new interface driver uas
[    2.587806] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x7f3001)
[    2.599581] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0f.
[    2.608745] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.611427] psmouse serio1: elantech: Elan sample query result 00, 20, c9
[    2.635393] psmouse serio1: elantech: Trying to set up SMBus access
[    2.770080] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
9540, bcdDevice=3D 1.20
[    2.770085] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.770088] usb 1-3: Product: EMV Smartcard Reader
[    2.770090] usb 1-3: Manufacturer: Generic
[    2.864886] tsc: Refined TSC clocksource calibration: 1991.999 MHz
[    2.864904] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396=
d4ffc055, max_idle_ns: 881590662783 ns
[    2.864993] clocksource: Switched to clocksource tsc
[    2.896896] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    3.058251] usb 1-5: New USB device found, idVendor=3D04f2, idProduct=3D=
b615, bcdDevice=3D 0.11
[    3.058256] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.058259] usb 1-5: Product: Integrated IR Camera
[    3.058261] usb 1-5: Manufacturer: SunplusIT Inc
[    3.188709] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    3.346281] usb 1-6: New USB device found, idVendor=3D2cb7, idProduct=3D=
0210, bcdDevice=3D 3.33
[    3.346285] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    3.346288] usb 1-6: Product: L830-EB-00
[    3.346291] usb 1-6: Manufacturer: FIBOCOM
[    3.346293] usb 1-6: SerialNumber: 004999010640000
[    3.408536] Console: switching to colour frame buffer device 160x45
[    3.434426] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    3.488671] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    3.538450] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.=
00 PQ: 0 ANSI: 6
[    3.556645] raid6: avx2x4   gen() 25824 MB/s
[    3.624646] raid6: avx2x4   xor() 20516 MB/s
[    3.641550] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[    3.641551] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    3.692648] raid6: avx2x2   gen() 43285 MB/s
[    3.760674] raid6: avx2x2   xor() 26043 MB/s
[    3.772652] usb 1-8: new high-speed USB device number 6 using xhci_hcd
[    3.828670] raid6: avx2x1   gen() 36427 MB/s
[    3.896675] raid6: avx2x1   xor() 22219 MB/s
[    3.935977] usb 1-8: New USB device found, idVendor=3D04f2, idProduct=3D=
b614, bcdDevice=3D 0.12
[    3.935978] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.935979] usb 1-8: Product: Integrated Camera
[    3.935979] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    3.964667] raid6: sse2x4   gen() 17899 MB/s
[    4.032645] raid6: sse2x4   xor() 10675 MB/s
[    4.068653] usb 1-9: new full-speed USB device number 7 using xhci_hcd
[    4.100668] raid6: sse2x2   gen() 17961 MB/s
[    4.168651] raid6: sse2x2   xor() 11106 MB/s
[    4.222008] usb 1-9: New USB device found, idVendor=3D06cb, idProduct=3D=
009a, bcdDevice=3D 1.64
[    4.222009] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    4.222010] usb 1-9: SerialNumber: 5bb5988684f7
[    4.236651] raid6: sse2x1   gen() 14987 MB/s
[    4.304672] raid6: sse2x1   xor()  7508 MB/s
[    4.304672] raid6: using algorithm avx2x2 gen() 43285 MB/s
[    4.304673] raid6: .... xor() 26043 MB/s, rmw enabled
[    4.304673] raid6: using avx2x2 recovery algorithm
[    4.304966] xor: automatically using best checksumming function   avx   =
   =20
[    4.305113] async_tx: api initialized (async)
[    4.322631] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    4.501374] device-mapper: uevent: version 1.0.3
[    4.501503] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[   10.240896] Btrfs loaded, crc32c=3Dcrc32c-intel
[   10.276470] PM: Image not found (code -22)
[   10.365383] EXT4-fs (dm-1): mounted filesystem with ordered data mode. O=
pts: (null)
[   10.412971] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   10.479527] systemd[1]: Inserted module 'autofs4'
[   10.559799] systemd[1]: systemd 246.6-2 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCR=
E2 default-hierarchy=3Dhybrid)
[   10.577166] systemd[1]: Detected architecture x86-64.
[   10.589595] systemd[1]: Set hostname to <linus-work>.
[   10.652830] systemd[1]: /lib/systemd/system/gpsd.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/g=
psd.sock \xffffffe2\xffffff86\xffffff92 /run/gpsd.sock; please update the u=
nit file accordingly.
[   10.662093] systemd[1]: /lib/systemd/system/plymouth-start.service:16: U=
nit configured to use KillMode=3Dnone. This is unsafe, as it disables syste=
md's process lifecycle management for the service. Please update your servi=
ce to use a safer KillMode=3D, such as 'mixed' or 'control-group'. Support =
for KillMode=3Dnone is deprecated and will eventually be removed.
[   10.670160] systemd[1]: /lib/systemd/system/rpc-statd.service:16: PIDFil=
e=3D references a path below legacy directory /var/run/, updating /var/run/=
rpc.statd.pid \xffffffe2\xffffff86\xffffff92 /run/rpc.statd.pid; please upd=
ate the unit file accordingly.
[   10.676787] systemd[1]: /lib/systemd/system/smartmontools.service:10: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.
[   10.680571] systemd[1]: /lib/systemd/system/kdump-tools.service:6: Stand=
ard output type syslog+console is obsolete, automatically updating to journ=
al+console. Please update your unit file, and consider removing the setting=
 altogether.
[   10.682451] systemd[1]: /lib/systemd/system/fancontrol.service:11: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/fancontrol.pid \xffffffe2\xffffff86\xffffff92 /run/fancontrol.pid; please =
update the unit file accordingly.
[   10.686651] systemd[1]: Queued start job for default target Graphical In=
terface.
[   10.687304] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   10.687708] systemd[1]: Created slice system-getty.slice.
[   10.687888] systemd[1]: Created slice system-modprobe.slice.
[   10.688099] systemd[1]: Created slice Cryptsetup Units Slice.
[   10.688271] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   10.688453] systemd[1]: Created slice system-tor.slice.
[   10.688633] systemd[1]: Created slice User and Session Slice.
[   10.688674] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   10.688782] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   10.688842] systemd[1]: Reached target Slices.
[   10.688867] systemd[1]: Reached target Libvirt guests shutdown.
[   10.688906] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   10.688969] systemd[1]: Listening on LVM2 poll daemon socket.
[   10.691468] systemd[1]: Listening on RPCbind Server Activation Socket.
[   10.691555] systemd[1]: Listening on Syslog Socket.
[   10.691615] systemd[1]: Listening on fsck to fsckd communication Socket.
[   10.691649] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   10.691740] systemd[1]: Listening on Journal Audit Socket.
[   10.691789] systemd[1]: Listening on Journal Socket (/dev/log).
[   10.691852] systemd[1]: Listening on Journal Socket.
[   10.691920] systemd[1]: Listening on udev Control Socket.
[   10.691968] systemd[1]: Listening on udev Kernel Socket.
[   10.692556] systemd[1]: Mounting Huge Pages File System...
[   10.693215] systemd[1]: Mounting POSIX Message Queue File System...
[   10.693772] systemd[1]: Mounting NFSD configuration filesystem...
[   10.694338] systemd[1]: Mounting RPC Pipe File System...
[   10.695092] systemd[1]: Mounting Kernel Debug File System...
[   10.695731] systemd[1]: Mounting Kernel Trace File System...
[   10.695828] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   10.695960] systemd[1]: Finished Availability of block devices.
[   10.696928] systemd[1]: Starting Set the console keyboard layout...
[   10.697608] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   10.698200] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   10.698243] systemd[1]: Condition check resulted in Load Kernel Module d=
rm being skipped.
[   10.698653] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   10.698699] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[   10.699847] systemd[1]: Starting Journal Service...
[   10.700730] systemd[1]: Starting Load Kernel Modules...
[   10.701419] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.702149] systemd[1]: Starting Coldplug All udev Devices...
[   10.703234] systemd[1]: Mounted Huge Pages File System.
[   10.703328] systemd[1]: Mounted POSIX Message Queue File System.
[   10.703420] systemd[1]: Mounted Kernel Debug File System.
[   10.703512] systemd[1]: Mounted Kernel Trace File System.
[   10.703882] systemd[1]: Finished Set the console keyboard layout.
[   10.704270] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   10.709664] RPC: Registered named UNIX socket transport module.
[   10.709664] RPC: Registered udp transport module.
[   10.709665] RPC: Registered tcp transport module.
[   10.709665] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.710109] EXT4-fs (dm-1): re-mounted. Opts: errors=3Dremount-ro
[   10.710665] lp: driver loaded but no devices found
[   10.711015] systemd[1]: Mounted RPC Pipe File System.
[   10.711406] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.712211] systemd[1]: Starting pNFS block layout mapping daemon...
[   10.712640] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.712688] systemd[1]: Condition check resulted in Platform Persistent =
Storage Archival being skipped.
[   10.713253] ppdev: user-space parallel port driver
[   10.713376] systemd[1]: Starting Load/Save Random Seed...
[   10.714112] systemd[1]: Starting Create System Users...
[   10.714744] systemd[1]: Started pNFS block layout mapping daemon.
[   10.717825] systemd[1]: Finished Load Kernel Modules.
[   10.718039] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.718105] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.718889] systemd[1]: Starting Apply Kernel Variables...
[   10.724373] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.725265] systemd[1]: Mounted NFSD configuration filesystem.
[   10.728846] systemd[1]: Finished Apply Kernel Variables.
[   10.729812] systemd[1]: Finished Load/Save Random Seed.
[   10.736343] systemd[1]: Finished Create System Users.
[   10.737081] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.750186] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.751552] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   10.760326] systemd[1]: Finished Coldplug All udev Devices.
[   10.761213] systemd[1]: Starting Helper to synchronize boot up for ifupd=
own...
[   10.765816] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   10.765928] systemd[1]: Reached target Local File Systems (Pre).
[   10.765960] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.765978] systemd[1]: Reached target Containers.
[   10.805832] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[   10.806775] systemd[1]: Starting Show Plymouth Boot Screen...
[   10.824064] systemd[1]: Started Show Plymouth Boot Screen.
[   10.824206] systemd[1]: Condition check resulted in Dispatch Password Re=
quests to Console Directory Watch being skipped.
[   10.824293] systemd[1]: Started Forward Password Requests to Plymouth Di=
rectory Watch.
[   10.853513] tpm_tis IFX0763:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   10.855817] ACPI: AC Adapter [AC] (on-line)
[   10.889197] systemd[1]: Created slice system-systemd\x2dbacklight.slice.
[   10.889966] systemd[1]: Starting Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight...
[   10.895759] systemd[1]: Finished Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight.
[   10.939606] mc: Linux media interface: v0.10
[   10.939801] Non-volatile memory driver v1.3
[   10.940647] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   10.942618] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   10.942619] thinkpad_acpi: http://ibm-acpi.sf.net/
[   10.942619] thinkpad_acpi: ThinkPad BIOS N22ET35W (1.12 ), EC N22HT22W
[   10.942619] thinkpad_acpi: Lenovo ThinkPad T480s, model 20L70053GE
[   10.942915] thinkpad_acpi: radio switch found; radios are enabled
[   10.942926] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[   10.942927] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[   10.944471] intel_rapl_common: Found RAPL domain package
[   10.944472] intel_rapl_common: Found RAPL domain dram
[   10.944960] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THE=
RMAL_PCI
[   10.945163] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[   10.946019] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[   10.949270] videodev: Linux video capture interface: v2.00
[   10.950408] cdc_acm 1-6:1.2: ttyACM0: USB ACM device
[   10.951442] usbcore: registered new interface driver cdc_acm
[   10.951442] cdc_acm: USB Abstract Control Model driver for USB modems an=
d ISDN adapters
[   10.956143] usbcore: registered new interface driver cdc_ether
[   10.958633] uvcvideo: Found UVC 1.00 device Integrated IR Camera (04f2:b=
615)
[   10.958634] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   10.958634] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   10.959326] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[   10.959330] usbcore: registered new interface driver cdc_ncm
[   10.959331] battery: new extension: ThinkPad Battery Extension
[   10.959896] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[   10.960096] usbcore: registered new interface driver cdc_wdm
[   10.960285] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   10.975193] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   10.975363] input: Integrated IR Camera: Integrate as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-5/1-5:1.0/input/input8
[   10.976225] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b614)
[   10.976225] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   10.976226] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   10.989026] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-8/1-8:1.0/input/input9
[   10.989066] usbcore: registered new interface driver uvcvideo
[   10.989067] USB Video Class driver (1.1.1)
[   10.997841] systemd[1]: Started Journal Service.
[   11.000257] cdc_mbim 1-6:1.0: setting rx_max =3D 16384
[   11.001799] cdc_mbim 1-6:1.0: cdc-wdm0: USB WDM device
[   11.001943] cdc_mbim 1-6:1.0 wwan0: register 'cdc_mbim' at usb-0000:00:1=
4.0-6, CDC MBIM, 22:56:bf:fa:1b:91
[   11.001971] usbcore: registered new interface driver cdc_mbim
[   11.016764] Bluetooth: Core ver 2.22
[   11.016775] NET: Registered protocol family 31
[   11.016775] Bluetooth: HCI device and connection manager initialized
[   11.016778] Bluetooth: HCI socket layer initialized
[   11.016780] Bluetooth: L2CAP socket layer initialized
[   11.016783] Bluetooth: SCO socket layer initialized
[   11.070603] elan_i2c 0-0015: supply vcc not found, using dummy regulator
[   11.078574] elan_i2c 0-0015: unexpected iap version 0x00 (ic type: 0x20)=
, firmware update will not work
[   11.078578] elan_i2c 0-0015: Elan Touchpad: Module ID: 0x0020, Firmware:=
 0x0001, Sample: 0x0000, IAP: 0x0000
[   11.078749] usbcore: registered new interface driver btusb
[   11.079276] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 20=
15
[   11.080282] Bluetooth: hci0: Device revision is 16
[   11.080282] Bluetooth: hci0: Secure boot is enabled
[   11.080283] Bluetooth: hci0: OTP lock is enabled
[   11.080283] Bluetooth: hci0: API lock is enabled
[   11.080283] Bluetooth: hci0: Debug lock is disabled
[   11.080284] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   11.080661] input: Elan Touchpad as /devices/pci0000:00/0000:00:1f.4/i2c=
-0/0-0015/input/input10
[   11.080711] input: Elan TrackPoint as /devices/pci0000:00/0000:00:1f.4/i=
2c-0/0-0015/input/input11
[   11.081864] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   11.104584] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   11.106450] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[   11.107909] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opt=
s: (null)
[   11.107913] ext2 filesystem being mounted at /boot supports timestamps u=
ntil 2038 (0x7fffffff)
[   11.112140] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.113089] cfg80211: loaded regulatory.db is malformed or signature is =
missing/invalid
[   11.168906] iTCO_vendor_support: vendor-support=3D0
[   11.169068] input: PC Speaker as /devices/platform/pcspkr/input/input12
[   11.169426] EFI Variables Facility v0.08 2004-May-17
[   11.170863] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   11.172518] Error: Driver 'pcspkr' is already registered, aborting...
[   11.173180] resource sanity check: requesting [mem 0xfed10000-0xfed15fff=
], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
[   11.173188] caller snb_uncore_imc_init_box+0x78/0xc0 [intel_uncore] mapp=
ing multiple BARs
[   11.173330] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.173384] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.173632] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.188140] Intel(R) Wireless WiFi driver for Linux
[   11.188400] iwlwifi 0000:3d:00.0: enabling device (0000 -> 0002)
[   11.191993] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
36.ucode failed with error -2
[   11.192013] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
35.ucode failed with error -2
[   11.192193] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
34.ucode failed with error -2
[   11.192206] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
33.ucode failed with error -2
[   11.192391] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
32.ucode failed with error -2
[   11.207224] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360=
 ms ovfl timer
[   11.207226] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   11.207226] RAPL PMU: hw unit of domain package 2^-14 Joules
[   11.207226] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   11.207227] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   11.207227] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   11.210870] iwlwifi 0000:3d:00.0: loaded firmware version 31.532993.0 82=
65-31.ucode op_mode iwlmvm
[   11.245608] audit: type=3D1400 audit(1604783945.852:2): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-s=
enddoc" pid=3D656 comm=3D"apparmor_parser"
[   11.248282] audit: type=3D1400 audit(1604783945.852:3): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/lxc-=
start" pid=3D657 comm=3D"apparmor_parser"
[   11.248680] audit: type=3D1400 audit(1604783945.856:4): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/gps=
d" pid=3D661 comm=3D"apparmor_parser"
[   11.250872] audit: type=3D1400 audit(1604783945.856:5): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/man"=
 pid=3D660 comm=3D"apparmor_parser"
[   11.250875] audit: type=3D1400 audit(1604783945.856:6): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_filter" p=
id=3D660 comm=3D"apparmor_parser"
[   11.250876] audit: type=3D1400 audit(1604783945.856:7): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_groff" pi=
d=3D660 comm=3D"apparmor_parser"
[   11.252278] audit: type=3D1400 audit(1604783945.856:8): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"lsb_release" =
pid=3D686 comm=3D"apparmor_parser"
[   11.253348] audit: type=3D1400 audit(1604783945.860:9): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/cup=
s-browsed" pid=3D658 comm=3D"apparmor_parser"
[   11.255343] audit: type=3D1400 audit(1604783945.860:10): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_modpr=
obe" pid=3D695 comm=3D"apparmor_parser"
[   11.255345] audit: type=3D1400 audit(1604783945.860:11): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_modpr=
obe//kmod" pid=3D695 comm=3D"apparmor_parser"
[   11.377180] pstore: Using crash dump compression: deflate
[   11.377196] pstore: Registered efi as persistent store backend
[   11.516913] Adding 16531452k swap on /dev/mapper/linus--work--vg-swap_1.=
  Priority:-2 extents:1 across:16531452k SSFS
[   11.521459] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[   11.613067] intel_rapl_common: Found RAPL domain package
[   11.613069] intel_rapl_common: Found RAPL domain core
[   11.613070] intel_rapl_common: Found RAPL domain uncore
[   11.613071] intel_rapl_common: Found RAPL domain dram
[   11.667867] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC257: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   11.667868] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   11.667869] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   11.667869] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[   11.667870] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   11.667871] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x19
[   11.667871] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[   11.671379] iwlwifi 0000:3d:00.0: Detected Intel(R) Dual Band Wireless A=
C 8265, REV=3D0x230
[   11.735262] iwlwifi 0000:3d:00.0: base HW address: 7c:76:35:14:e6:d7
[   11.755246] new mount options do not match the existing superblock, will=
 be ignored
[   11.811050] iwlwifi 0000:3d:00.0: iwlmvm doesn't allow to disable BT Coe=
x, check bt_coex_active module parameter
[   11.811165] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   11.811406] thermal thermal_zone6: failed to read out thermal zone (-61)
[   11.816895] fuse: init (API version 7.31)
[   11.819999] iwlwifi 0000:3d:00.0 wlp61s0: renamed from wlan0
[   11.930135] intel_pmc_core intel_pmc_core.0:  initialized
[   11.947792] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input13
[   11.947839] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input14
[   11.947886] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input15
[   11.947929] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[   11.947968] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[   11.948024] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input18
[   11.948087] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input19
[   11.948138] input: HDA Intel PCH HDMI/DP,pcm=3D10 as /devices/pci0000:00=
/0000:00:1f.3/sound/card0/input20
[   12.974024] Bluetooth: hci0: Waiting for firmware download to complete
[   12.974344] Bluetooth: hci0: Firmware loaded in 1851157 usecs
[   12.974374] Bluetooth: hci0: Waiting for device to boot
[   12.986341] Bluetooth: hci0: Device booted in 11710 usecs
[   12.989555] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16=
=2Eddc
[   12.991409] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.993371] Bluetooth: hci0: Reading supported features failed (-16)
[   12.997411] Bluetooth: hci0: Setting Intel telemetry ddc write event mas=
k failed (-95)
[   13.001407] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   13.288485] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   13.288556] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   13.293022] IPv6: ADDRCONF(NETDEV_CHANGE): veth3: link becomes ready
[   13.318127] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   13.326283] br0: port 1(enp0s31f6) entered blocking state
[   13.326287] br0: port 1(enp0s31f6) entered disabled state
[   13.326423] device enp0s31f6 entered promiscuous mode
[   13.520484] br0: port 2(veth0) entered blocking state
[   13.520489] br0: port 2(veth0) entered disabled state
[   13.520723] device veth0 entered promiscuous mode
[   13.529045] br0: port 3(veth2) entered blocking state
[   13.529053] br0: port 3(veth2) entered disabled state
[   13.529208] device veth2 entered promiscuous mode
[   13.535786] br0: port 3(veth2) entered blocking state
[   13.535791] br0: port 3(veth2) entered forwarding state
[   13.535827] br0: port 2(veth0) entered blocking state
[   13.535831] br0: port 2(veth0) entered forwarding state
[   15.174722] NFSD: Using UMH upcall client tracking operations.
[   15.174729] NFSD: starting 90-second grace period (net f00000a8)
[   15.422930] L1TF CPU bug present and SMT on, data leak possible. See CVE=
-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l=
1tf.html for details.
[   63.193713] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   63.193714] Bluetooth: BNEP filters: protocol multicast
[   63.193717] Bluetooth: BNEP socket layer initialized
[   63.197061] NET: Registered protocol family 38
[   72.287872] Bluetooth: RFCOMM TTY layer initialized
[   72.287876] Bluetooth: RFCOMM socket layer initialized
[   72.287881] Bluetooth: RFCOMM ver 1.11
[  105.042341] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input21
[  174.438922] wlp61s0: authenticate with 8a:04:f3:06:a8:84
[  174.454881] wlp61s0: send auth to 8a:04:f3:06:a8:84 (try 1/3)
[  174.462091] wlp61s0: authenticated
[  174.464977] wlp61s0: associate with 8a:04:f3:06:a8:84 (try 1/3)
[  174.466928] wlp61s0: RX AssocResp from 8a:04:f3:06:a8:84 (capab=3D0x421 =
status=3D0 aid=3D1)
[  174.472152] wlp61s0: associated
[  174.472243] IPv6: ADDRCONF(NETDEV_CHANGE): wlp61s0: link becomes ready
[  299.030248] Bluetooth: hci0: link tx timeout
[  299.030260] Bluetooth: hci0: killing stalled connection e4:22:a5:be:d8:a1
[  299.053464] general protection fault, probably for non-canonical address=
 0x652f31327475706e: 0000 [#1] SMP PTI
[  299.053478] CPU: 4 PID: 3866 Comm: bluetooth Kdump: loaded Tainted: G   =
         E     5.9.6 #4
[  299.053483] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  299.053527] RIP: 0010:hci_send_acl+0x1f/0x320 [bluetooth]
[  299.053534] Code: 00 48 8d 42 03 c3 c3 0f 1f 40 00 0f 1f 44 00 00 41 57 =
49 89 ff 41 56 41 55 41 54 55 89 d5 53 48 89 f3 48 83 ec 28 4c 8b 67 18 <49=
> 8b 84 24 58 05 00 00 48 89 44 24 10 0f 1f 44 00 00 4c 8b 6c 24
[  299.053539] RSP: 0018:ffffad6580fbfcf0 EFLAGS: 00010286
[  299.053544] RAX: ffff8cd58f9a2a00 RBX: ffff8cd58e29e100 RCX: ffffad6580f=
bfe18
[  299.053548] RDX: 0000000000000002 RSI: ffff8cd58e29e100 RDI: ffff8cd59f6=
d03c0
[  299.053551] RBP: 0000000000000002 R08: ffff8cd59e91aec0 R09: 00000000000=
00800
[  299.053555] R10: 000000000000000c R11: 0000000000000027 R12: 652f3132747=
5706e
[  299.053558] R13: 000000000000035c R14: ffff8cd58e29e100 R15: ffff8cd59f6=
d03c0
[  299.053563] FS:  00007f400755f700(0000) GS:ffff8cd5a2700000(0000) knlGS:=
0000000000000000
[  299.053567] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  299.053571] CR2: 00005644de516000 CR3: 0000000456eb4004 CR4: 00000000003=
706e0
[  299.053574] Call Trace:
[  299.053589]  ? mutex_lock+0xe/0x30
[  299.053641]  l2cap_chan_send+0x109/0xb80 [bluetooth]
[  299.053674]  ? bt_sock_wait_ready+0x13d/0x1b0 [bluetooth]
[  299.053684]  ? wake_up_q+0xa0/0xa0
[  299.053732]  l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
[  299.053741]  sock_sendmsg+0x5e/0x60
[  299.053747]  __sys_sendto+0xee/0x150
[  299.053758]  ? vfs_write+0x1da/0x210
[  299.053767]  ? exit_to_user_mode_prepare+0x32/0x140
[  299.053773]  __x64_sys_sendto+0x25/0x30
[  299.053780]  do_syscall_64+0x33/0x80
[  299.053786]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  299.053792] RIP: 0033:0x7f4015ca8494
[  299.053798] Code: 89 4c 24 1c e8 8d f8 ff ff 44 8b 54 24 1c 8b 3c 24 45 =
31 c9 89 c5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 ef 48 89 04 24 e8 b9 f8 ff ff 48 8b 04
[  299.053802] RSP: 002b:00007f400755ec90 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[  299.053807] RAX: ffffffffffffffda RBX: 0000000000000027 RCX: 00007f4015c=
a8494
[  299.053811] RDX: 000000000000035c RSI: 00007f3ffc000b60 RDI: 00000000000=
00027
[  299.053814] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  299.053817] R10: 0000000000004000 R11: 0000000000000246 R12: 000055efd6b=
bd548
[  299.053821] R13: 000000000000035c R14: 000055efd6bbd504 R15: 000055efd6b=
bd570
[  299.053826] Modules linked in: uinput(E) rfcomm(E) cmac(E) algif_hash(E)=
 algif_skcipher(E) af_alg(E) bnep(E) xt_CHECKSUM(E) xt_tcpudp(E) bridge(E) =
stp(E) llc(E) veth(E) snd_hda_codec_hdmi(E) snd_soc_skl(E) intel_pmc_core_p=
ltdrv(E) intel_pmc_core(E) snd_soc_hdac_hda(E) snd_hda_ext_core(E) nft_chai=
n_nat(E) fuse(E) xt_MASQUERADE(E) snd_soc_sst_ipc(E) nf_nat(E) snd_soc_sst_=
dsp(E) nf_conntrack(E) snd_soc_acpi_intel_match(E) nf_defrag_ipv6(E) snd_so=
c_acpi(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) nf_defrag_ipv4(E) joy=
dev(E) snd_soc_core(E) nft_compat(E) iwlmvm(E) snd_hda_codec_realtek(E) snd=
_compress(E) kvm_intel(E) intel_rapl_msr(E) snd_hda_codec_generic(E) nft_co=
unter(E) mac80211(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) nf_tables(=
E) efi_pstore(E) binfmt_misc(E) nfnetlink(E) irqbypass(E) libarc4(E) snd_hd=
a_codec(E) rapl(E) nls_ascii(E) nls_cp437(E) snd_hda_core(E) intel_cstate(E=
) iwlwifi(E) vfat(E) iTCO_wdt(E) intel_pmc_bxt(E) intel_uncore(E) fat(E) se=
rio_raw(E) efivars(E) mei_me(E)
[  299.053884]  pcspkr(E) iTCO_vendor_support(E) snd_hwdep(E) btusb(E) btrt=
l(E) snd_pcm(E) watchdog(E) btbcm(E) elan_i2c(E) btintel(E) snd_timer(E) cf=
g80211(E) intel_wmi_thunderbolt(E) wmi_bmof(E) mei(E) bluetooth(E) sg(E) ji=
tterentropy_rng(E) drbg(E) cdc_mbim(E) cdc_wdm(E) cdc_ncm(E) uvcvideo(E) cd=
c_ether(E) ansi_cprng(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2=
_v4l2(E) ecdh_generic(E) usbnet(E) videobuf2_common(E) mii(E) cdc_acm(E) ec=
c(E) videodev(E) thinkpad_acpi(E) processor_thermal_device(E) ucsi_acpi(E) =
typec_ucsi(E) nvram(E) intel_rapl_common(E) mc(E) tpm_crb(E) ledtrig_audio(=
E) intel_xhci_usb_role_switch(E) intel_pch_thermal(E) roles(E) intel_soc_dt=
s_iosf(E) typec(E) snd(E) soundcore(E) rfkill(E) int3403_thermal(E) ac(E) i=
nt340x_thermal_zone(E) int3400_thermal(E) acpi_thermal_rel(E) tpm_tis(E) tp=
m_tis_core(E) tpm(E) rng_core(E) acpi_pad(E) evdev(E) nfsd(E) coretemp(E) p=
arport_pc(E) auth_rpcgss(E) nfs_acl(E) ppdev(E) lockd(E) grace(E) lp(E) par=
port(E) sunrpc(E) efivarfs(E)
[  299.053946]  ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(=
E) crc16(E) mbcache(E) jbd2(E) btrfs(E) zstd_compress(E) dm_crypt(E) dm_mod=
(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) a=
sync_xor(E) async_tx(E) xor(E) sd_mod(E) raid6_pq(E) libcrc32c(E) raid1(E) =
raid0(E) multipath(E) linear(E) md_mod(E) uas(E) usb_storage(E) scsi_mod(E)=
 crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) i915(E) nvme(E) i2c=
_algo_bit(E) e1000e(E) nvme_core(E) ptp(E) drm_kms_helper(E) aesni_intel(E)=
 libaes(E) t10_pi(E) crypto_simd(E) cryptd(E) glue_helper(E) thunderbolt(E)=
 cec(E) xhci_pci(E) crc_t10dif(E) psmouse(E) crct10dif_generic(E) xhci_hcd(=
E) i2c_i801(E) crct10dif_pclmul(E) pps_core(E) i2c_smbus(E) crct10dif_commo=
n(E) intel_lpss_pci(E) intel_lpss(E) drm(E) usbcore(E) idma64(E) wmi(E) bat=
tery(E) video(E) button(E)
[  299.054010] ---[ end trace b4a80a41ec7a5aed ]---
[  299.182362] RIP: 0010:hci_send_acl+0x1f/0x320 [bluetooth]
[  299.182366] Code: 00 48 8d 42 03 c3 c3 0f 1f 40 00 0f 1f 44 00 00 41 57 =
49 89 ff 41 56 41 55 41 54 55 89 d5 53 48 89 f3 48 83 ec 28 4c 8b 67 18 <49=
> 8b 84 24 58 05 00 00 48 89 44 24 10 0f 1f 44 00 00 4c 8b 6c 24
[  299.182367] RSP: 0018:ffffad6580fbfcf0 EFLAGS: 00010286
[  299.182369] RAX: ffff8cd58f9a2a00 RBX: ffff8cd58e29e100 RCX: ffffad6580f=
bfe18
[  299.182369] RDX: 0000000000000002 RSI: ffff8cd58e29e100 RDI: ffff8cd59f6=
d03c0
[  299.182370] RBP: 0000000000000002 R08: ffff8cd59e91aec0 R09: 00000000000=
00800
[  299.182370] R10: 000000000000000c R11: 0000000000000027 R12: 652f3132747=
5706e
[  299.182371] R13: 000000000000035c R14: ffff8cd58e29e100 R15: ffff8cd59f6=
d03c0
[  299.182372] FS:  00007f400755f700(0000) GS:ffff8cd5a2700000(0000) knlGS:=
0000000000000000
[  299.182373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  299.182374] CR2: 00005644de516000 CR3: 0000000456eb4004 CR4: 00000000003=
706e0
[  299.182375] Kernel panic - not syncing: Fatal exception
[  299.183375] Kernel Offset: 0x3a400000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)

# dmesg 2/5

[    0.000000] Linux version 5.7.0-rc6+ (linus@linus-work) (gcc version 10.=
2.0 (Debian 10.2.0-16), GNU ld (GNU Binutils for Debian) 2.35.1) #16 SMP Mo=
n Nov 9 14:35:42 CET 2020
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.7.0-rc6+ root=3D/dev/m=
apper/linus--work--vg-root ro crashkernel=3D384M-8G:128M,8G-:512M
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000074f9cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000074f9d000-0x0000000074f9dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000074f9e000-0x0000000074f9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000074f9f000-0x000000007e8f7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e8f8000-0x000000007e9bdfff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007e9be000-0x000000007ff2bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ff2c000-0x000000007ff99fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007ff9a000-0x000000007fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x0000000087ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000088600000-0x000000008c7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004727fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi:  TPMFinalLog=3D0x7ff92000  SMBIOS=3D0x7f052000  SMBIOS =
3.0=3D0x7f04f000  ACPI=3D0x7fffe000  ACPI 2.0=3D0x7fffe014  ESRT=3D0x7eeca0=
00  MEMATTR=3D0x7971d298=20
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (1.12 ) 04/=
09/2018
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.001614] tsc: Detected 1999.968 MHz TSC
[    0.001614] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001618] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001628] last_pfn =3D 0x472800 max_arch_pfn =3D 0x400000000
[    0.001634] MTRR default type: write-back
[    0.001635] MTRR fixed ranges enabled:
[    0.001637]   00000-9FFFF write-back
[    0.001639]   A0000-BFFFF uncachable
[    0.001640]   C0000-FFFFF write-protect
[    0.001641] MTRR variable ranges enabled:
[    0.001644]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001645]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001647]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001648]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.001649]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.001650]   5 disabled
[    0.001651]   6 disabled
[    0.001652]   7 disabled
[    0.001653]   8 disabled
[    0.001653]   9 disabled
[    0.002494] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.003576] last_pfn =3D 0x80000 max_arch_pfn =3D 0x400000000
[    0.023381] esrt: Reserving ESRT space from 0x000000007eeca000 to 0x0000=
00007eeca088.
[    0.023391] kexec: Reserving the low 1M of memory for crashkernel
[    0.023396] Using GB pages for direct mapping
[    0.023400] BRK [0x33be01000, 0x33be01fff] PGTABLE
[    0.023402] BRK [0x33be02000, 0x33be02fff] PGTABLE
[    0.023404] BRK [0x33be03000, 0x33be03fff] PGTABLE
[    0.023433] BRK [0x33be04000, 0x33be04fff] PGTABLE
[    0.023436] BRK [0x33be05000, 0x33be05fff] PGTABLE
[    0.023544] BRK [0x33be06000, 0x33be06fff] PGTABLE
[    0.023568] BRK [0x33be07000, 0x33be07fff] PGTABLE
[    0.023605] BRK [0x33be08000, 0x33be08fff] PGTABLE
[    0.023644] BRK [0x33be09000, 0x33be09fff] PGTABLE
[    0.023655] Secure boot could not be determined
[    0.023657] RAMDISK: [mem 0x34d5b000-0x366a4fff]
[    0.023665] ACPI: Early table checksum verification disabled
[    0.023668] ACPI: RSDP 0x000000007FFFE014 000024 (v02 LENOVO)
[    0.023674] ACPI: XSDT 0x000000007FFAD188 000124 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023682] ACPI: FACP 0x000000007FFE1000 0000F4 (v05 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023690] ACPI: DSDT 0x000000007FFBB000 0218A6 (v02 LENOVO SKL      00=
000000 INTL 20160527)
[    0.023695] ACPI: FACS 0x000000007FF3D000 000040
[    0.023699] ACPI: SSDT 0x000000007FFE9000 01320E (v02 LENOVO DptfTabl 00=
001000 INTL 20160527)
[    0.023704] ACPI: SSDT 0x000000007FFE8000 0003DB (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20160527)
[    0.023708] ACPI: TPM2 0x000000007FFE7000 000034 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023712] ACPI: UEFI 0x000000007FF53000 000042 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023716] ACPI: SSDT 0x000000007FFE3000 0030A3 (v02 LENOVO SaSsdt   00=
003000 INTL 20160527)
[    0.023722] ACPI: SSDT 0x000000007FFE2000 0005C6 (v02 LENOVO PerfTune 00=
001000 INTL 20160527)
[    0.023727] ACPI: HPET 0x000000007FFE0000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023733] ACPI: APIC 0x000000007FFDF000 00012C (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023738] ACPI: MCFG 0x000000007FFDE000 00003C (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023742] ACPI: ECDT 0x000000007FFDD000 000053 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023746] ACPI: SSDT 0x000000007FFB9000 001C9C (v02 LENOVO RVP7Rtd3 00=
001000 INTL 20160527)
[    0.023751] ACPI: SSDT 0x000000007FFB7000 00163C (v02 LENOVO ProjSsdt 00=
000010 INTL 20160527)
[    0.023755] ACPI: BOOT 0x000000007FFB6000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023759] ACPI: BATB 0x000000007FFB5000 00004A (v02 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023763] ACPI: SLIC 0x000000007FFB4000 000176 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023768] ACPI: SSDT 0x000000007FFB2000 0017AE (v02 LENOVO CpuSsdt  00=
003000 INTL 20160527)
[    0.023772] ACPI: SSDT 0x000000007FFB1000 00056D (v02 LENOVO CtdpB    00=
001000 INTL 20160527)
[    0.023776] ACPI: SSDT 0x000000007FFB0000 000678 (v02 LENOVO UsbCTabl 00=
001000 INTL 20160527)
[    0.023781] ACPI: LPIT 0x000000007FFAF000 000094 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023785] ACPI: WSMT 0x000000007FFAE000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023789] ACPI: SSDT 0x000000007FFFD000 0001D8 (v02 LENOVO HdaDsp   00=
000000 INTL 20160527)
[    0.023793] ACPI: SSDT 0x000000007FFAC000 0004FC (v02 LENOVO TbtTypeC 00=
000000 INTL 20160527)
[    0.023797] ACPI: SSDT 0x000000007FFAB000 0002D1 (v02 LENOVO Wwan     00=
000001 INTL 20160527)
[    0.023802] ACPI: DBGP 0x000000007FFAA000 000034 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023806] ACPI: DBG2 0x000000007FFA9000 000054 (v00 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023810] ACPI: MSDM 0x000000007FFA8000 000055 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023814] ACPI: DMAR 0x000000007FFA7000 0000CC (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023819] ACPI: ASF! 0x000000007FFA6000 0000A0 (v32 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023823] ACPI: FPDT 0x000000007FFA5000 000044 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023827] ACPI: BGRT 0x000000007FFA4000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023831] ACPI: UEFI 0x000000007FF3A000 00013E (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.023842] ACPI: Local APIC address 0xfee00000
[    0.023949] No NUMA configuration found
[    0.023951] Faking a node at [mem 0x0000000000000000-0x00000004727fffff]
[    0.023957] NODE_DATA(0) allocated [mem 0x4727fb000-0x4727fffff]
[    0.023982] Reserving 512MB of memory at 1280MB for crashkernel (System =
RAM: 16144MB)
[    0.024029] Zone ranges:
[    0.024031]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.024033]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.024035]   Normal   [mem 0x0000000100000000-0x00000004727fffff]
[    0.024037]   Device   empty
[    0.024039] Movable zone start for each node
[    0.024040] Early memory node ranges
[    0.024042]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.024044]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.024045]   node   0: [mem 0x0000000000100000-0x0000000074f9cfff]
[    0.024047]   node   0: [mem 0x0000000074f9f000-0x000000007e8f7fff]
[    0.024048]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.024050]   node   0: [mem 0x0000000100000000-0x00000004727fffff]
[    0.024400] Zeroed struct page in unavailable ranges: 28526 pages
[    0.024402] Initmem setup node 0 [mem 0x0000000000001000-0x00000004727ff=
fff]
[    0.024406] On node 0 totalpages: 4133010
[    0.024407]   DMA zone: 64 pages used for memmap
[    0.024408]   DMA zone: 155 pages reserved
[    0.024410]   DMA zone: 3995 pages, LIFO batch:0
[    0.024513]   DMA32 zone: 8036 pages used for memmap
[    0.024515]   DMA32 zone: 514295 pages, LIFO batch:63
[    0.037222]   Normal zone: 56480 pages used for memmap
[    0.037223]   Normal zone: 3614720 pages, LIFO batch:63
[    0.038081] Reserving Intel graphics memory at [mem 0x8a800000-0x8c7ffff=
f]
[    0.038467] ACPI: PM-Timer IO Port: 0x1808
[    0.038470] ACPI: Local APIC address 0xfee00000
[    0.038479] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.038481] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.038496] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.038498] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.038499] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.038500] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.038501] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.038503] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.038504] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.038505] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.038506] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.038508] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.038509] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.038510] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.038512] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.038513] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.038542] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.038545] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.038548] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.038550] ACPI: IRQ0 used by override.
[    0.038552] ACPI: IRQ9 used by override.
[    0.038555] Using ACPI (MADT) for SMP configuration information
[    0.038557] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.038566] e820: update [mem 0x783d7000-0x784d6fff] usable =3D=3D> rese=
rved
[    0.038579] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.038606] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.038609] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.038612] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x000fffff]
[    0.038615] PM: hibernation: Registered nosave memory: [mem 0x74f9d000-0=
x74f9dfff]
[    0.038616] PM: hibernation: Registered nosave memory: [mem 0x74f9e000-0=
x74f9efff]
[    0.038619] PM: hibernation: Registered nosave memory: [mem 0x783d7000-0=
x784d6fff]
[    0.038621] PM: hibernation: Registered nosave memory: [mem 0x7e8f8000-0=
x7e9bdfff]
[    0.038623] PM: hibernation: Registered nosave memory: [mem 0x7e9be000-0=
x7ff2bfff]
[    0.038624] PM: hibernation: Registered nosave memory: [mem 0x7ff2c000-0=
x7ff99fff]
[    0.038625] PM: hibernation: Registered nosave memory: [mem 0x7ff9a000-0=
x7fffefff]
[    0.038628] PM: hibernation: Registered nosave memory: [mem 0x80000000-0=
x87ffffff]
[    0.038629] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x885fffff]
[    0.038631] PM: hibernation: Registered nosave memory: [mem 0x88600000-0=
x8c7fffff]
[    0.038632] PM: hibernation: Registered nosave memory: [mem 0x8c800000-0=
xf7ffffff]
[    0.038633] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.038634] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfe00ffff]
[    0.038636] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0=
xfe010fff]
[    0.038637] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    0.038640] [mem 0x8c800000-0xf7ffffff] available for PCI devices
[    0.038642] Booting paravirtualized kernel on bare hardware
[    0.038645] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.045169] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.045498] percpu: Embedded 55 pages/cpu s187992 r8192 d29096 u262144
[    0.045509] pcpu-alloc: s187992 r8192 d29096 u262144 alloc=3D1*2097152
[    0.045510] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.045543] Built 1 zonelists, mobility grouping on.  Total pages: 40682=
75
[    0.045545] Policy zone: Normal
[    0.045547] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.7.0-rc6+ root=
=3D/dev/mapper/linus--work--vg-root ro crashkernel=3D384M-8G:128M,8G-:512M
[    0.047260] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.048056] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.048189] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.074186] Memory: 1522748K/16532040K available (10243K kernel code, 12=
26K rwdata, 3688K rodata, 1584K init, 2148K bss, 993024K reserved, 0K cma-r=
eserved)
[    0.074198] random: get_random_u64 called from __kmem_cache_create+0x3e/=
0x600 with crng_init=3D0
[    0.074388] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.074407] Kernel/User page tables isolation: enabled
[    0.074442] ftrace: allocating 32380 entries in 127 pages
[    0.094826] ftrace: allocated 127 pages with 7 groups
[    0.095003] rcu: Hierarchical RCU implementation.
[    0.095006] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D8.
[    0.095008] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.095009] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.100438] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.100856] random: crng done (trusting CPU's manufacturer)
[    0.100902] Console: colour dummy device 80x25
[    0.101214] printk: console [tty0] enabled
[    0.101241] ACPI: Core revision 20200326
[    0.101814] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    0.101889] APIC: Switch to symmetric I/O mode setup
[    0.101894] DMAR: Host address width 39
[    0.101897] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.101907] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.101911] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.101918] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.101922] DMAR: RMRR base: 0x0000007f47f000 end: 0x0000007f49efff
[    0.101926] DMAR: RMRR base: 0x0000008a000000 end: 0x0000008c7fffff
[    0.101929] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.101943] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.101946] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.101949] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.103649] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.103653] x2apic enabled
[    0.103668] Switched APIC routing to cluster x2apic.
[    0.107837] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.125765] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x39a8208cdd2, max_idle_ns: 881590748921 ns
[    0.125774] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3999.93 BogoMIPS (lpj=3D7999872)
[    0.125780] pid_max: default: 32768 minimum: 301
[    0.130574] LSM: Security Framework initializing
[    0.130584] Yama: becoming mindful.
[    0.130651] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.130691] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.131110] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.131154] process: using mwait in idle threads
[    0.131159] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.131162] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.131167] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.131172] Spectre V2 : Mitigation: Full generic retpoline
[    0.131174] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.131177] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.131181] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.131184] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.131187] Speculative Store Bypass: Vulnerable
[    0.131191] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.131547] Freeing SMP alternatives memory: 28K
[    0.135750] smpboot: CPU0: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xa)
[    0.135939] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.135952] ... version:                4
[    0.135955] ... bit width:              48
[    0.135957] ... generic registers:      4
[    0.135959] ... value mask:             0000ffffffffffff
[    0.135962] ... max period:             00007fffffffffff
[    0.135964] ... fixed-purpose events:   3
[    0.135966] ... event mask:             000000070000000f
[    0.136045] rcu: Hierarchical SRCU implementation.
[    0.137365] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.137488] smp: Bringing up secondary CPUs ...
[    0.137617] x86: Booting SMP configuration:
[    0.137621] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.139028] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.139028]  #5 #6 #7
[    0.142788] smp: Brought up 1 node, 8 CPUs
[    0.142788] smpboot: Max logical packages: 1
[    0.142788] smpboot: Total of 8 processors activated (31999.48 BogoMIPS)
[    0.221780] node 0 initialised, 3504067 pages in 76ms
[    0.222263] devtmpfs: initialized
[    0.222263] x86/mm: Memory block size: 128MB
[    0.224291] PM: Registering ACPI NVS region [mem 0x74f9d000-0x74f9dfff] =
(4096 bytes)
[    0.224291] PM: Registering ACPI NVS region [mem 0x7ff2c000-0x7ff99fff] =
(450560 bytes)
[    0.224291] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.224291] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.224291] pinctrl core: initialized pinctrl subsystem
[    0.225798] thermal_sys: Registered thermal governor 'fair_share'
[    0.225799] thermal_sys: Registered thermal governor 'bang_bang'
[    0.225802] thermal_sys: Registered thermal governor 'step_wise'
[    0.225805] thermal_sys: Registered thermal governor 'user_space'
[    0.225988] NET: Registered protocol family 16
[    0.226122] audit: initializing netlink subsys (disabled)
[    0.226133] audit: type=3D2000 audit(1604948732.124:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.226133] cpuidle: using governor ladder
[    0.226133] cpuidle: using governor menu
[    0.226133] Simple Boot Flag at 0x47 set to 0x1
[    0.226133] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.226133] ACPI: bus type PCI registered
[    0.226133] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.226133] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.226133] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.226133] PCI: Using configuration type 1 for base access
[    0.227523] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.227535] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.227535] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.466436] ACPI: Added _OSI(Module Device)
[    0.466436] ACPI: Added _OSI(Processor Device)
[    0.466436] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.466436] ACPI: Added _OSI(Processor Aggregator Device)
[    0.466436] ACPI: Added _OSI(Linux-Dell-Video)
[    0.466436] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.466436] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.553871] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.555908] ACPI: EC: EC started
[    0.555912] ACPI: EC: interrupt blocked
[    0.558860] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.558863] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.561398] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.637339] ACPI: Dynamic OEM Table Load:
[    0.637370] ACPI: SSDT 0xFFFF9E774735D000 0005CD (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.639835] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.641725] ACPI: Dynamic OEM Table Load:
[    0.641743] ACPI: SSDT 0xFFFF9E797BF0D000 0003FF (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.644149] ACPI: Dynamic OEM Table Load:
[    0.644163] ACPI: SSDT 0xFFFF9E77472E7F00 0000BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.646289] ACPI: Dynamic OEM Table Load:
[    0.646303] ACPI: SSDT 0xFFFF9E774735B800 000628 (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.649021] ACPI: Dynamic OEM Table Load:
[    0.649040] ACPI: SSDT 0xFFFF9E7747D07000 000D14 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.652288] ACPI: Dynamic OEM Table Load:
[    0.652303] ACPI: SSDT 0xFFFF9E797BF0EC00 000317 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.654649] ACPI: Dynamic OEM Table Load:
[    0.654663] ACPI: SSDT 0xFFFF9E797BF0C400 00030A (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.661106] ACPI: Interpreter enabled
[    0.661200] ACPI: (supports S0 S3 S4 S5)
[    0.661203] ACPI: Using IOAPIC for interrupt routing
[    0.661275] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.662334] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.670117] ACPI: Power Resource [PUBS] (on)
[    0.699442] ACPI: Power Resource [PXP] (on)
[    0.727070] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.727083] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.730654] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.732504] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR]
[    0.732508] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.736016] PCI host bridge to bus 0000:00
[    0.736023] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.736027] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.736031] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.736035] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]
[    0.736038] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    0.736042] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]
[    0.736046] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]
[    0.736049] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]
[    0.736053] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]
[    0.736056] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]
[    0.736060] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]
[    0.736064] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]
[    0.736067] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]
[    0.736071] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]
[    0.736074] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]
[    0.736078] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ffff=
f window]
[    0.736082] pci_bus 0000:00: root bus resource [mem 0x8c800000-0xf7fffff=
f window]
[    0.736085] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    0.736090] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.736108] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.737580] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.737605] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.737620] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.737629] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.737658] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.739159] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.739184] pci 0000:00:04.0: reg 0x10: [mem 0xe8240000-0xe8247fff 64bit]
[    0.740778] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.740803] pci 0000:00:08.0: reg 0x10: [mem 0xe8250000-0xe8250fff 64bit]
[    0.742311] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.742342] pci 0000:00:14.0: reg 0x10: [mem 0xe8220000-0xe822ffff 64bit]
[    0.742433] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.744081] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.744113] pci 0000:00:14.2: reg 0x10: [mem 0xe8251000-0xe8251fff 64bit]
[    0.745709] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.745966] pci 0000:00:15.0: reg 0x10: [mem 0xe8252000-0xe8252fff 64bit]
[    0.748354] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.748390] pci 0000:00:16.0: reg 0x10: [mem 0xe8253000-0xe8253fff 64bit]
[    0.748479] pci 0000:00:16.0: PME# supported from D3hot
[    0.750057] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.751535] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.753093] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.754563] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.756144] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.756258] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.757850] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.757979] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.759600] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.761260] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.761282] pci 0000:00:1f.2: reg 0x10: [mem 0xe824c000-0xe824ffff]
[    0.762866] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.762905] pci 0000:00:1f.3: reg 0x10: [mem 0xe8248000-0xe824bfff 64bit]
[    0.762948] pci 0000:00:1f.3: reg 0x20: [mem 0xe8230000-0xe823ffff 64bit]
[    0.763016] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.764622] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.764680] pci 0000:00:1f.4: reg 0x10: [mem 0xe8254000-0xe82540ff 64bit]
[    0.764734] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.766331] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.766366] pci 0000:00:1f.6: reg 0x10: [mem 0xe8200000-0xe821ffff]
[    0.766493] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.768087] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.768183] pci 0000:04:00.0: [8086:15c0] type 01 class 0x060400
[    0.768262] pci 0000:04:00.0: enabling Extended Tags
[    0.768369] pci 0000:04:00.0: supports D1 D2
[    0.768373] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.768569] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.768577] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.768585] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.768670] pci 0000:05:00.0: [8086:15c0] type 01 class 0x060400
[    0.768755] pci 0000:05:00.0: enabling Extended Tags
[    0.768863] pci 0000:05:00.0: supports D1 D2
[    0.768867] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.769012] pci 0000:05:01.0: [8086:15c0] type 01 class 0x060400
[    0.769095] pci 0000:05:01.0: enabling Extended Tags
[    0.769206] pci 0000:05:01.0: supports D1 D2
[    0.769209] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.769342] pci 0000:05:02.0: [8086:15c0] type 01 class 0x060400
[    0.769425] pci 0000:05:02.0: enabling Extended Tags
[    0.769532] pci 0000:05:02.0: supports D1 D2
[    0.769535] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.769717] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.769730] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.769739] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.769815] pci 0000:06:00.0: [8086:15bf] type 00 class 0x088000
[    0.769856] pci 0000:06:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.769872] pci 0000:06:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.769948] pci 0000:06:00.0: enabling Extended Tags
[    0.770074] pci 0000:06:00.0: supports D1 D2
[    0.770077] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.770279] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.770292] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.770356] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.770368] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.770378] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.770467] pci 0000:3c:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.770510] pci 0000:3c:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.770604] pci 0000:3c:00.0: enabling Extended Tags
[    0.770732] pci 0000:3c:00.0: supports D1 D2
[    0.770735] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.770841] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.770983] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.770996] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.771529] pci 0000:3d:00.0: [8086:24fd] type 00 class 0x028000
[    0.771680] pci 0000:3d:00.0: reg 0x10: [mem 0xe8100000-0xe8101fff 64bit]
[    0.772293] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    0.773139] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.773146] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.773404] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.773443] pci 0000:3e:00.0: reg 0x10: [mem 0xe8000000-0xe8003fff 64bit]
[    0.773814] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.773822] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.777784] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.777870] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.777947] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.778024] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.778100] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.778176] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.778251] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.778326] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.779472] ACPI: EC: interrupt unblocked
[    0.779476] ACPI: EC: event unblocked
[    0.779491] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.779493] ACPI: EC: GPE=3D0x16
[    0.779499] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.779503] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.779625] iommu: Default domain type: Translated=20
[    0.779647] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.779647] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.779647] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.779647] vgaarb: loaded
[    0.779647] EDAC MC: Ver: 3.0.0
[    0.779647] Registered efivars operations
[    0.779647] PCI: Using ACPI for IRQ routing
[    0.783360] PCI: pci_cache_line_size set to 64 bytes
[    0.784460] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.784462] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.784463] e820: reserve RAM buffer [mem 0x74f9d000-0x77ffffff]
[    0.784464] e820: reserve RAM buffer [mem 0x783d7000-0x7bffffff]
[    0.784465] e820: reserve RAM buffer [mem 0x7e8f8000-0x7fffffff]
[    0.784467] e820: reserve RAM buffer [mem 0x472800000-0x473ffffff]
[    0.784620] NetLabel: Initializing
[    0.784623] NetLabel:  domain hash size =3D 128
[    0.784625] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.784649] NetLabel:  unlabeled traffic allowed by default
[    0.784683] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.784690] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.785807] clocksource: Switched to clocksource tsc-early
[    0.802747] VFS: Disk quotas dquot_6.6.0
[    0.802779] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.802886] pnp: PnP ACPI init
[    0.803208] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.803214] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.803218] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.803223] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.803227] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.803231] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.803235] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.803245] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.803861] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.803869] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.804545] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.804550] system 00:02: [io  0xffff] has been reserved
[    0.804554] system 00:02: [io  0xffff] has been reserved
[    0.804558] system 00:02: [io  0xffff] has been reserved
[    0.804561] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.804565] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.804573] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.804773] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.804848] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.804857] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    0.804888] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.804916] pnp 00:06: Plug and Play ACPI device, IDs LEN008f PNP0f13 (a=
ctive)
[    0.805114] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.805120] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.805124] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.805127] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.805131] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.805135] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.805139] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.805143] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.805146] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.805150] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.805154] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.805158] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.805163] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.805167] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.805172] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.805175] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.805179] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.805183] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.805188] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.805192] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.805200] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.807684] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.807690] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.807694] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.807701] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.809358] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.809364] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.809368] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.809372] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.809376] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.809381] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.809385] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.809389] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.809393] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.809397] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.809405] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.809889] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.809895] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.809899] system 00:0a: [mem 0x00100000-0x8c7fffff] could not be reser=
ved
[    0.809903] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.809908] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.809915] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.810158] pnp: PnP ACPI: found 11 devices
[    0.816797] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.816858] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    0.816865] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.816871] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    0.816877] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus =
07-3b] add_size 1000
[    0.816883] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus =
05-3c] add_size 1000
[    0.816888] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
04-3c] add_size 2000
[    0.816909] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8c800000-0x8c9ffff=
f]
[    0.816929] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8ca00000-0x8cbffff=
f 64bit pref]
[    0.816935] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.816940] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x4fff]
[    0.816947] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.816953] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.816961] pci 0000:00:1c.0:   bridge window [mem 0x8c800000-0x8c9fffff]
[    0.816968] pci 0000:00:1c.0:   bridge window [mem 0x8ca00000-0x8cbfffff=
 64bit pref]
[    0.816978] pci 0000:04:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.816983] pci 0000:05:01.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.816987] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.816996] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.817009] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.817014] pci 0000:05:01.0:   bridge window [io  0x3000-0x3fff]
[    0.817023] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.817030] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.817041] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.817050] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.817063] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.817068] pci 0000:04:00.0:   bridge window [io  0x3000-0x3fff]
[    0.817077] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.817084] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.817093] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.817098] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.817104] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.817110] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.817119] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.817125] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.817136] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.817145] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.817157] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.817161] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.817165] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.817169] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.817172] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.817176] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.817180] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.817183] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.817187] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.817190] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.817194] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.817197] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.817201] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.817204] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.817208] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.817211] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.817215] pci_bus 0000:00: resource 20 [mem 0x8c800000-0xf7ffffff wind=
ow]
[    0.817219] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.817223] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.817226] pci_bus 0000:01: resource 1 [mem 0x8c800000-0x8c9fffff]
[    0.817230] pci_bus 0000:01: resource 2 [mem 0x8ca00000-0x8cbfffff 64bit=
 pref]
[    0.817234] pci_bus 0000:04: resource 0 [io  0x3000-0x4fff]
[    0.817237] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.817240] pci_bus 0000:04: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.817244] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.817248] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.817251] pci_bus 0000:05: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.817255] pci_bus 0000:06: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.817259] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.817262] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.817266] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.817270] pci_bus 0000:3c: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.817273] pci_bus 0000:3d: resource 1 [mem 0xe8100000-0xe81fffff]
[    0.817277] pci_bus 0000:3e: resource 1 [mem 0xe8000000-0xe80fffff]
[    0.817564] NET: Registered protocol family 2
[    0.817800] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.817968] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.818325] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.818472] TCP: Hash tables configured (established 131072 bind 65536)
[    0.818553] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.818653] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.818823] NET: Registered protocol family 1
[    0.818847] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.819581] pci 0000:04:00.0: enabling device (0006 -> 0007)
[    0.820455] PCI: CLS 128 bytes, default 64
[    0.820535] Trying to unpack rootfs image as initramfs...
[    1.571565] Freeing initrd memory: 25896K
[    1.571619] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:1=
5.0
[    1.589840] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.589845] software IO TLB: mapped [mem 0x79f2f000-0x7df2f000] (64MB)
[    1.590644] Initialise system trusted keyrings
[    1.590660] Key type blacklist registered
[    1.590720] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.592635] zbud: loaded
[    1.592818] integrity: Platform Keyring initialized
[    1.592823] Key type asymmetric registered
[    1.592825] Asymmetric key parser 'x509' registered
[    1.592836] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.592916] io scheduler mq-deadline registered
[    1.593497] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.593541] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.593759] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    1.593803] pcieport 0000:00:1c.4: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.594180] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    1.594502] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.594935] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
[    1.595113] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.595505] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.595541] efifb: probing for efifb
[    1.595562] efifb: framebuffer at 0xc0000000, using 14400k, total 14400k
[    1.595566] efifb: mode is 2560x1440x32, linelength=3D10240, pages=3D1
[    1.595568] efifb: scrolling: redraw
[    1.595572] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.607833] Console: switching to colour frame buffer device 160x45
[    1.620088] fb0: EFI VGA frame buffer device
[    1.620194] intel_idle: MWAIT substates: 0x11142120
[    1.620195] intel_idle: v0.5.1 model 0x8E
[    1.620939] intel_idle: Local APIC timer is reliable in all C-states
[    1.626310] thermal LNXTHERM:00: registered as thermal_zone0
[    1.626430] ACPI: Thermal Zone [THM0] (41 C)
[    1.626821] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.628267] Linux agpgart interface v0.103
[    1.628413] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.628547] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    1.629509] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.631838] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.631944] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.632346] mousedev: PS/2 mouse device common for all mice
[    1.632521] rtc_cmos 00:03: RTC can wake from S4
[    1.633405] rtc_cmos 00:03: registered as rtc0
[    1.633683] rtc_cmos 00:03: setting system clock to 2020-11-09T19:05:33 =
UTC (1604948733)
[    1.633902] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[    1.634083] intel_pstate: Intel P-state driver initializing
[    1.634311] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.635571] intel_pstate: HWP enabled
[    1.635785] ledtrig-cpu: registered to indicate activity on CPUs
[    1.636362] NET: Registered protocol family 10
[    1.654078] Segment Routing with IPv6
[    1.657394] mip6: Mobile IPv6
[    1.660637] NET: Registered protocol family 17
[    1.664047] mpls_gso: MPLS GSO support
[    1.668324] microcode: sig=3D0x806ea, pf=3D0x80, revision=3D0x84
[    1.671774] microcode: Microcode Update Driver: v2.2.
[    1.671777] IPI shorthand broadcast: enabled
[    1.678123] sched_clock: Marking stable (1677137625, 977117)->(168501960=
3, -6904861)
[    1.681569] registered taskstats version 1
[    1.684218] Loading compiled-in X.509 certificates
[    1.686830] zswap: loaded using pool lzo/zbud
[    1.690149] integrity: Loading X.509 certificate: UEFI:db
[    1.692261] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.694200] integrity: Loading X.509 certificate: UEFI:db
[    1.695819] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.697310] integrity: Loading X.509 certificate: UEFI:db
[    1.698849] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.700388] integrity: Loading X.509 certificate: UEFI:db
[    1.701906] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.705669] Freeing unused kernel image (initmem) memory: 1584K
[    1.718203] Write protecting the kernel read-only data: 16384k
[    1.720273] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.722071] Freeing unused kernel image (rodata/data gap) memory: 408K
[    1.749247] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.750808] x86/mm: Checking user space page tables
[    1.777409] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.778959] Run /init as init process
[    1.780502]   with arguments:
[    1.780502]     /init
[    1.780502]   with environment:
[    1.780502]     HOME=3D/
[    1.780503]     TERM=3Dlinux
[    1.780503]     BOOT_IMAGE=3D/vmlinuz-5.7.0-rc6+
[    1.780503]     crashkernel=3D384M-8G:128M,8G-:512M
[    1.850467] video: module verification failed: signature and/or required=
 key missing - tainting kernel
[    1.874374] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    1.876278] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    1.876602] battery: ACPI: Battery Slot [BAT0] (battery present)
[    1.881040] ACPI: bus type USB registered
[    1.881064] pps_core: LinuxPPS API ver. 1 registered
[    1.886303] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.886329] usbcore: registered new interface driver usbfs
[    1.891809] usbcore: registered new interface driver hub
[    1.895150] usbcore: registered new device driver usb
[    1.897032] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.899033] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.900942] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.903196] PTP clock support registered
[    1.905376] cryptd: max_cpu_qlen set to 1000
[    1.909972] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.911683] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.913554] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    1.915515] AVX2 version of gcm_enc/dec engaged.
[    1.915753] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.918516] AES CTR mode by8 optimization enabled
[    1.921505] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    1.922585] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000081109810
[    1.924464] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    1.929669] xhci_hcd 0000:00:14.0: cache line size of 128 is not support=
ed
[    1.929987] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.932411] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.07
[    1.936413] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.939723] usb usb1: Product: xHCI Host Controller
[    1.942121] usb usb1: Manufacturer: Linux 5.7.0-rc6+ xhci-hcd
[    1.945227] usb usb1: SerialNumber: 0000:00:14.0
[    1.947788] hub 1-0:1.0: USB hub found
[    1.947815] nvme nvme0: pci function 0000:3e:00.0
[    1.949444] hub 1-0:1.0: 12 ports detected
[    1.953518] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.955084] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.956654] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.958257] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.07
[    1.960233] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.960331] nvme nvme0: Shutdown timeout set to 8 seconds
[    1.962162] usb usb2: Product: xHCI Host Controller
[    1.965979] usb usb2: Manufacturer: Linux 5.7.0-rc6+ xhci-hcd
[    1.967872] usb usb2: SerialNumber: 0000:00:14.0
[    1.971494] hub 2-0:1.0: USB hub found
[    1.972966] nvme nvme0: 8/0/0 default/read/poll queues
[    1.973126] hub 2-0:1.0: 6 ports detected
[    1.976573] usb: port power management may be unreliable
[    1.976830] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    1.977786]  nvme0n1: p1 p2 p3
[    1.978541] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    1.983647] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 3
[    1.985610] checking generic (c0000000 e10000) vs hw (e7000000 1000000)
[    1.985611] checking generic (c0000000 e10000) vs hw (c0000000 10000000)
[    1.985612] fb0: switching to inteldrmfb from EFI VGA
[    1.986284] xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    1.989598] Console: switching to colour dummy device 80x25
[    1.989632] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.989823] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.07
[    1.989825] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.989827] usb usb3: Product: xHCI Host Controller
[    1.989828] usb usb3: Manufacturer: Linux 5.7.0-rc6+ xhci-hcd
[    1.989829] usb usb3: SerialNumber: 0000:3c:00.0
[    1.989911] hub 3-0:1.0: USB hub found
[    1.989918] hub 3-0:1.0: 2 ports detected
[    1.990538] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.990912] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    1.990947] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    1.990953] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 4
[    1.990957] xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.990965] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver=
1_04.bin failed with error -2
[    1.990968] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/kb=
l_dmc_ver1_04.bin. Disabling runtime power management.
[    1.990969] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    1.990989] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.07
[    1.990991] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.990994] usb usb4: Product: xHCI Host Controller
[    1.990995] usb usb4: Manufacturer: Linux 5.7.0-rc6+ xhci-hcd
[    1.990997] usb usb4: SerialNumber: 0000:3c:00.0
[    1.991123] hub 4-0:1.0: USB hub found
[    1.991140] hub 4-0:1.0: 2 ports detected
[    1.997150] [drm] Reducing the compressed framebuffer size. This may lea=
d to less power savings than a non-reduced-size. Try to increase stolen mem=
ory size if available in BIOS.
[    2.004799] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on mi=
nor 0
[    2.006468] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.006684] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input3
[    2.120447] fbcon: i915drmfb (fb0) is primary device
[    2.123376] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    2.135109] Console: switching to colour frame buffer device 160x45
[    2.171700] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    2.191824] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 8c:=
16:45:66:ba:11
[    2.192049] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    2.192337] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    2.194554] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.289832] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.329810] raid6: avx2x4   gen() 27336 MB/s
[    2.397806] raid6: avx2x4   xor() 19880 MB/s
[    2.413723] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x7f3001)
[    2.423689] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0f.
[    2.433826] psmouse serio1: elantech: Elan sample query result 00, 20, c9
[    2.451012] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
9540, bcdDevice=3D 1.20
[    2.451068] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.451117] usb 1-3: Product: EMV Smartcard Reader
[    2.451150] usb 1-3: Manufacturer: Generic
[    2.454467] psmouse serio1: elantech: Trying to set up SMBus access
[    2.465812] raid6: avx2x2   gen() 44880 MB/s
[    2.533836] raid6: avx2x2   xor() 27466 MB/s
[    2.569969] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    2.597818] tsc: Refined TSC clocksource calibration: 1992.001 MHz
[    2.599578] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396=
d54029a7, max_idle_ns: 881590429682 ns
[    2.600929] usb 2-3: New USB device found, idVendor=3D0bda, idProduct=3D=
0316, bcdDevice=3D 2.04
[    2.601788] raid6: avx2x1   gen() 38005 MB/s
[    2.603618] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.608124] usb 2-3: Product: USB3.0-CRW
[    2.610351] usb 2-3: Manufacturer: Generic
[    2.612563] usb 2-3: SerialNumber: 20120501030900000
[    2.674075] raid6: avx2x1   xor() 16511 MB/s
[    2.742349] raid6: sse2x4   gen() 15451 MB/s
[    2.810620] raid6: sse2x4   xor()  8810 MB/s
[    2.878892] raid6: sse2x2   gen() 15599 MB/s
[    2.947164] raid6: sse2x2   xor()  9618 MB/s
[    3.015436] raid6: sse2x1   gen() 12966 MB/s
[    3.083709] raid6: sse2x1   xor()  7174 MB/s
[    3.085720] raid6: using algorithm avx2x2 gen() 44880 MB/s
[    3.087728] raid6: .... xor() 27466 MB/s, rmw enabled
[    3.089703] raid6: using avx2x2 recovery algorithm
[    3.091657] clocksource: Switched to clocksource tsc
[    3.093664] async_tx: api initialized (async)
[    3.096931] xor: automatically using best checksumming function   avx   =
   =20
[    3.147925] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    3.253953] device-mapper: uevent: version 1.0.3
[    3.260566] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[    3.305791] usb 1-5: New USB device found, idVendor=3D04f2, idProduct=3D=
b615, bcdDevice=3D 0.11
[    3.313866] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.320012] usb 1-5: Product: Integrated IR Camera
[    3.320014] usb 1-5: Manufacturer: SunplusIT Inc
[    3.460073] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    3.620634] usb 1-6: New USB device found, idVendor=3D2cb7, idProduct=3D=
0210, bcdDevice=3D 3.33
[    3.625841] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    3.627716] usb 1-6: Product: L830-EB-00
[    3.629568] usb 1-6: Manufacturer: FIBOCOM
[    3.631405] usb 1-6: SerialNumber: 004999010640000
[    3.772116] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    3.926081] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[    3.932387] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    4.068084] usb 1-8: new high-speed USB device number 6 using xhci_hcd
[    4.234785] usb 1-8: New USB device found, idVendor=3D04f2, idProduct=3D=
b614, bcdDevice=3D 0.12
[    4.240000] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.242081] usb 1-8: Product: Integrated Camera
[    4.244046] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    4.376080] usb 1-9: new full-speed USB device number 7 using xhci_hcd
[    4.530937] usb 1-9: New USB device found, idVendor=3D06cb, idProduct=3D=
009a, bcdDevice=3D 1.64
[    4.537806] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    4.544700] usb 1-9: SerialNumber: 5bb5988684f7
[   11.804549] PM: Image not found (code -22)
[   11.904616] EXT4-fs (dm-1): mounted filesystem with ordered data mode. O=
pts: (null)
[   12.017358] systemd[1]: Inserted module 'autofs4'
[   12.113438] systemd[1]: systemd 246.6-2 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCR=
E2 default-hierarchy=3Dhybrid)
[   12.140274] systemd[1]: Detected architecture x86-64.
[   12.167058] systemd[1]: Set hostname to <linus-work>.
[   12.259329] systemd[1]: /lib/systemd/system/gpsd.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/g=
psd.sock \xffffffe2\xffffff86\xffffff92 /run/gpsd.sock; please update the u=
nit file accordingly.
[   12.272331] systemd[1]: /lib/systemd/system/plymouth-start.service:16: U=
nit configured to use KillMode=3Dnone. This is unsafe, as it disables syste=
md's process lifecycle management for the service. Please update your servi=
ce to use a safer KillMode=3D, such as 'mixed' or 'control-group'. Support =
for KillMode=3Dnone is deprecated and will eventually be removed.
[   12.286133] systemd[1]: /lib/systemd/system/rpc-statd.service:16: PIDFil=
e=3D references a path below legacy directory /var/run/, updating /var/run/=
rpc.statd.pid \xffffffe2\xffffff86\xffffff92 /run/rpc.statd.pid; please upd=
ate the unit file accordingly.
[   12.296495] systemd[1]: /lib/systemd/system/smartmontools.service:10: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.
[   12.304405] systemd[1]: /lib/systemd/system/kdump-tools.service:6: Stand=
ard output type syslog+console is obsolete, automatically updating to journ=
al+console. Please update your unit file, and consider removing the setting=
 altogether.
[   12.310720] systemd[1]: /lib/systemd/system/fancontrol.service:11: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/fancontrol.pid \xffffffe2\xffffff86\xffffff92 /run/fancontrol.pid; please =
update the unit file accordingly.
[   12.319583] systemd[1]: Queued start job for default target Graphical In=
terface.
[   12.322643] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   12.325377] systemd[1]: Created slice system-getty.slice.
[   12.330166] systemd[1]: Created slice system-modprobe.slice.
[   12.335560] systemd[1]: Created slice Cryptsetup Units Slice.
[   12.340908] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   12.346311] systemd[1]: Created slice system-tor.slice.
[   12.351791] systemd[1]: Created slice User and Session Slice.
[   12.357061] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   12.362545] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   12.368003] systemd[1]: Reached target Slices.
[   12.370498] systemd[1]: Reached target Libvirt guests shutdown.
[   12.375869] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   12.381444] systemd[1]: Listening on LVM2 poll daemon socket.
[   12.389204] systemd[1]: Listening on RPCbind Server Activation Socket.
[   12.392581] systemd[1]: Listening on Syslog Socket.
[   12.397870] systemd[1]: Listening on fsck to fsckd communication Socket.
[   12.403176] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   12.408485] systemd[1]: Listening on Journal Audit Socket.
[   12.413481] systemd[1]: Listening on Journal Socket (/dev/log).
[   12.418253] systemd[1]: Listening on Journal Socket.
[   12.422761] systemd[1]: Listening on udev Control Socket.
[   12.427023] systemd[1]: Listening on udev Kernel Socket.
[   12.431528] systemd[1]: Mounting Huge Pages File System...
[   12.435525] systemd[1]: Mounting POSIX Message Queue File System...
[   12.439240] systemd[1]: Mounting NFSD configuration filesystem...
[   12.443223] systemd[1]: Mounting RPC Pipe File System...
[   12.447177] systemd[1]: Mounting Kernel Debug File System...
[   12.450987] systemd[1]: Mounting Kernel Trace File System...
[   12.454331] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   12.454404] systemd[1]: Finished Availability of block devices.
[   12.460468] systemd[1]: Starting Set the console keyboard layout...
[   12.464741] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   12.468713] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   12.472245] systemd[1]: Condition check resulted in Load Kernel Module d=
rm being skipped.
[   12.472582] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   12.476145] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[   12.477229] systemd[1]: Starting Journal Service...
[   12.483108] systemd[1]: Starting Load Kernel Modules...
[   12.487101] systemd[1]: Starting Remount Root and Kernel File Systems...
[   12.491434] systemd[1]: Starting Coldplug All udev Devices...
[   12.494707] EXT4-fs (dm-1): re-mounted. Opts: errors=3Dremount-ro
[   12.498329] systemd[1]: Mounted Huge Pages File System.
[   12.501448] systemd[1]: Mounted POSIX Message Queue File System.
[   12.505448] systemd[1]: proc-fs-nfsd.mount: Mount process exited, code=
=3Dexited, status=3D32/n/a
[   12.505451] systemd[1]: proc-fs-nfsd.mount: Failed with result 'exit-cod=
e'.
[   12.505728] systemd[1]: Failed to mount NFSD configuration filesystem.
[   12.513190] systemd[1]: Dependency failed for NFS Mount Daemon.
[   12.515162] systemd[1]: Dependency failed for NFS server and services.
[   12.517061] systemd[1]: Dependency failed for NFSv4 ID-name mapping serv=
ice.
[   12.521162] systemd[1]: nfs-idmapd.service: Job nfs-idmapd.service/start=
 failed with result 'dependency'.
[   12.523139] systemd[1]: nfs-server.service: Job nfs-server.service/start=
 failed with result 'dependency'.
[   12.525130] systemd[1]: nfs-mountd.service: Job nfs-mountd.service/start=
 failed with result 'dependency'.
[   12.525214] systemd[1]: run-rpc_pipefs.mount: Mount process exited, code=
=3Dexited, status=3D32/n/a
[   12.525216] systemd[1]: run-rpc_pipefs.mount: Failed with result 'exit-c=
ode'.
[   12.525480] systemd[1]: Failed to mount RPC Pipe File System.
[   12.534846] systemd[1]: Dependency failed for pNFS block layout mapping =
daemon.
[   12.536888] systemd[1]: nfs-blkmap.service: Job nfs-blkmap.service/start=
 failed with result 'dependency'.
[   12.536892] systemd[1]: Dependency failed for RPC security service for N=
FS client and server.
[   12.543142] systemd[1]: rpc-gssd.service: Job rpc-gssd.service/start fai=
led with result 'dependency'.
[   12.545156] systemd[1]: Dependency failed for RPC security service for N=
FS server.
[   12.547181] systemd[1]: rpc-svcgssd.service: Job rpc-svcgssd.service/sta=
rt failed with result 'dependency'.
[   12.549268] systemd[1]: Mounted Kernel Debug File System.
[   12.553537] systemd[1]: Mounted Kernel Trace File System.
[   12.558103] systemd[1]: Finished Set the console keyboard layout.
[   12.562423] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   12.566674] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   12.570897] systemd[1]: Finished Load Kernel Modules.
[   12.575083] systemd[1]: Finished Remount Root and Kernel File Systems.
[   12.579384] systemd[1]: Reached target NFS client services.
[   12.583403] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   12.583447] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   12.586703] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   12.591633] systemd[1]: Condition check resulted in Platform Persistent =
Storage Archival being skipped.
[   12.592212] systemd[1]: Starting Load/Save Random Seed...
[   12.598956] systemd[1]: Starting Apply Kernel Variables...
[   12.603857] systemd[1]: Starting Create System Users...
[   12.609275] systemd[1]: Finished Load/Save Random Seed.
[   12.614249] systemd[1]: Finished Apply Kernel Variables.
[   12.618953] systemd[1]: Finished Coldplug All udev Devices.
[   12.623589] systemd[1]: Finished Create System Users.
[   12.628233] systemd[1]: Starting Helper to synchronize boot up for ifupd=
own...
[   12.632596] systemd[1]: Starting Create Static Device Nodes in /dev...
[   12.646321] systemd[1]: Finished Create Static Device Nodes in /dev.
[   12.650078] systemd[1]: Reached target Local File Systems (Pre).
[   12.653962] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   12.653974] systemd[1]: Reached target Containers.
[   12.658711] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   12.715697] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[   12.720210] systemd[1]: Starting Show Plymouth Boot Screen...
[   12.725999] systemd[1]: Started Journal Service.
[   12.757816] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input4
[   12.762546] ACPI: Sleep Button [SLPB]
[   12.766873] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input5
[   12.771386] ACPI: Lid Switch [LID]
[   12.775521] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input6
[   12.778559] ACPI: Power Button [PWRF]
[   12.800765] ACPI: AC Adapter [AC] (off-line)
[   12.809063] Non-volatile memory driver v1.3
[   12.813067] tpm_tis IFX0763:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   12.822776] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   12.826445] thinkpad_acpi: http://ibm-acpi.sf.net/
[   12.829926] thinkpad_acpi: ThinkPad BIOS N22ET35W (1.12 ), EC N22HT22W
[   12.830025] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   12.833560] thinkpad_acpi: Lenovo ThinkPad T480s, model 20L70053GE
[   12.834625] thinkpad_acpi: radio switch found; radios are enabled
[   12.842792] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[   12.842792] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[   12.843739] intel_rapl_common: Found RAPL domain package
[   12.843746] intel_rapl_common: Found RAPL domain dram
[   12.844780] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[   12.845510] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[   12.847078] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THE=
RMAL_PCI
[   12.857315] thinkpad_acpi: Standard ACPI backlight interface available, =
not loading native one
[   12.864902] thinkpad_acpi: volume: disabled as there is no ALSA support =
in this kernel
[   12.868029] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[   12.868032] battery: new extension: ThinkPad Battery Extension
[   12.873284] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[   12.878660] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   12.883608] mc: Linux media interface: v0.10
[   12.887922] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   12.894954] elan_i2c 0-0015: supply vcc not found, using dummy regulator
[   12.895538] iTCO_vendor_support: vendor-support=3D0
[   12.896143] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   12.896199] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   12.896436] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   12.899695] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   12.902540] elan_i2c 0-0015: Elan Touchpad: Module ID: 0x0020, Firmware:=
 0x0001, Sample: 0x0000, IAP: 0x0000
[   12.917322] input: Elan Touchpad as /devices/pci0000:00/0000:00:1f.4/i2c=
-0/0-0015/input/input8
[   12.917424] videodev: Linux video capture interface: v2.00
[   12.917503] input: Elan TrackPoint as /devices/pci0000:00/0000:00:1f.4/i=
2c-0/0-0015/input/input9
[   12.917537] EFI Variables Facility v0.08 2004-May-17
[   12.917899] input: PC Speaker as /devices/platform/pcspkr/input/input10
[   12.924173] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   12.929227] cfg80211: loaded regulatory.db is malformed or signature is =
missing/invalid
[   13.030371] pstore: Using crash dump compression: deflate
[   13.030388] pstore: Registered efi as persistent store backend
[   13.033911] Intel(R) Wireless WiFi driver for Linux
[   13.034321] iwlwifi 0000:3d:00.0: enabling device (0000 -> 0002)
[   13.039986] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   13.041031] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
36.ucode failed with error -2
[   13.041039] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
35.ucode failed with error -2
[   13.041046] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
34.ucode failed with error -2
[   13.041052] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
33.ucode failed with error -2
[   13.041059] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
32.ucode failed with error -2
[   13.059986] iwlwifi 0000:3d:00.0: loaded firmware version 31.532993.0 82=
65-31.ucode op_mode iwlmvm
[   13.063506] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opt=
s: (null)
[   13.064263] iwlwifi 0000:3d:00.0: Direct firmware load for iwl-debug-yoy=
o.bin failed with error -2
[   13.068279] ext2 filesystem being mounted at /boot supports timestamps u=
ntil 2038 (0x7fffffff)
[   13.094599] Bluetooth: Core ver 2.22
[   13.094606] NET: Registered protocol family 31
[   13.094608] Bluetooth: HCI device and connection manager initialized
[   13.094610] Bluetooth: HCI socket layer initialized
[   13.094616] Bluetooth: L2CAP socket layer initialized
[   13.094619] Bluetooth: SCO socket layer initialized
[   13.095447] uvcvideo: Found UVC 1.00 device Integrated IR Camera (04f2:b=
615)
[   13.095448] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   13.095448] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   13.117229] uvcvideo 1-5:1.0: Entity type for entity Extension 6 was not=
 initialized!
[   13.135415] uvcvideo 1-5:1.0: Entity type for entity Extension 5 was not=
 initialized!
[   13.135416] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   13.135417] uvcvideo 1-5:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   13.135419] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   13.135420] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   13.135551] input: Integrated IR Camera: Integrate as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-5/1-5:1.0/input/input11
[   13.136430] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b614)
[   13.136431] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   13.136431] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   13.137837] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360=
 ms ovfl timer
[   13.137838] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   13.137838] RAPL PMU: hw unit of domain package 2^-14 Joules
[   13.137839] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   13.137839] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   13.137839] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   13.138384] usbcore: registered new interface driver btusb
[   13.138654] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 20=
15
[   13.139602] resource sanity check: requesting [mem 0xfed10000-0xfed15fff=
], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
[   13.139608] caller snb_uncore_imc_init_box+0x6c/0xb0 [intel_uncore] mapp=
ing multiple BARs
[   13.139659] Bluetooth: hci0: Device revision is 16
[   13.139660] Bluetooth: hci0: Secure boot is enabled
[   13.139660] Bluetooth: hci0: OTP lock is enabled
[   13.139661] Bluetooth: hci0: API lock is enabled
[   13.139661] Bluetooth: hci0: Debug lock is disabled
[   13.139661] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   13.141237] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[   13.151541] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   13.151542] uvcvideo 1-8:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   13.151543] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   13.151543] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   13.151578] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-8/1-8:1.0/input/input12
[   13.151615] usbcore: registered new interface driver uvcvideo
[   13.151615] USB Video Class driver (1.1.1)
[   13.206912] intel_rapl_common: Found RAPL domain package
[   13.206945] intel_rapl_common: Found RAPL domain core
[   13.206971] intel_rapl_common: Found RAPL domain uncore
[   13.206998] intel_rapl_common: Found RAPL domain dram
[   13.231926] Adding 16531452k swap on /dev/mapper/linus--work--vg-swap_1.=
  Priority:-2 extents:1 across:16531452k SSFS
[   13.320663] iwlwifi 0000:3d:00.0: Detected Intel(R) Dual Band Wireless A=
C 8265, REV=3D0x230
[   13.356742] intel_pmc_core intel_pmc_core.0:  initialized
[   13.385741] iwlwifi 0000:3d:00.0: base HW address: 7c:76:35:14:e6:d7
[   13.460437] iwlwifi 0000:3d:00.0: iwlmvm doesn't allow to disable BT Coe=
x, check bt_coex_active module parameter
[   13.464027] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   13.464283] thermal thermal_zone6: failed to read out thermal zone (-61)
[   13.471679] iwlwifi 0000:3d:00.0 wlp61s0: renamed from wlan0
[   13.842863] new mount options do not match the existing superblock, will=
 be ignored
[   13.986016] new mount options do not match the existing superblock, will=
 be ignored
[   14.347237] new mount options do not match the existing superblock, will=
 be ignored
[   14.535269] new mount options do not match the existing superblock, will=
 be ignored
[   14.652519] new mount options do not match the existing superblock, will=
 be ignored
[   14.654671] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   14.655768] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   14.657983] IPv6: ADDRCONF(NETDEV_CHANGE): veth3: link becomes ready
[   14.667887] br0: port 1(enp0s31f6) entered blocking state
[   14.668755] br0: port 1(enp0s31f6) entered disabled state
[   14.669654] device enp0s31f6 entered promiscuous mode
[   14.809120] Bluetooth: hci0: Waiting for firmware download to complete
[   14.810077] Bluetooth: hci0: Firmware loaded in 1632493 usecs
[   14.811028] Bluetooth: hci0: Waiting for device to boot
[   14.822682] Bluetooth: hci0: Device booted in 11441 usecs
[   14.823801] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16=
=2Eddc
[   14.826675] Bluetooth: hci0: Applying Intel DDC parameters completed
[   14.828717] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   14.860450] br0: port 2(veth0) entered blocking state
[   14.861454] br0: port 2(veth0) entered disabled state
[   14.862379] device veth0 entered promiscuous mode
[   14.864430] br0: port 3(veth2) entered blocking state
[   14.865507] br0: port 3(veth2) entered disabled state
[   14.866414] device veth2 entered promiscuous mode
[   14.868679] br0: port 3(veth2) entered blocking state
[   14.869616] br0: port 3(veth2) entered forwarding state
[   14.870523] br0: port 2(veth0) entered blocking state
[   14.871461] br0: port 2(veth0) entered forwarding state
[  106.462068] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  106.462071] Bluetooth: BNEP filters: protocol multicast
[  106.462074] Bluetooth: BNEP socket layer initialized
[  106.465025] NET: Registered protocol family 38
[  112.646043] Bluetooth: RFCOMM TTY layer initialized
[  112.646051] Bluetooth: RFCOMM socket layer initialized
[  112.646056] Bluetooth: RFCOMM ver 1.11
[  120.134038] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input13
[  162.413606] wlp61s0: authenticate with 0e:f0:78:5d:08:3c
[  162.430203] wlp61s0: send auth to 0e:f0:78:5d:08:3c (try 1/3)
[  162.446119] wlp61s0: authenticated
[  162.448115] wlp61s0: associate with 0e:f0:78:5d:08:3c (try 1/3)
[  162.454239] wlp61s0: RX AssocResp from 0e:f0:78:5d:08:3c (capab=3D0x421 =
status=3D0 aid=3D1)
[  162.460818] wlp61s0: associated
[  162.460921] IPv6: ADDRCONF(NETDEV_CHANGE): wlp61s0: link becomes ready
[  354.120092] wlp61s0: deauthenticating from 0e:f0:78:5d:08:3c by local ch=
oice (Reason: 3=3DDEAUTH_LEAVING)
[  369.645522] wlp61s0: authenticate with 0e:f0:78:5d:08:3c
[  369.655208] wlp61s0: send auth to 0e:f0:78:5d:08:3c (try 1/3)
[  369.661156] wlp61s0: authenticated
[  369.663940] wlp61s0: associate with 0e:f0:78:5d:08:3c (try 1/3)
[  369.668640] wlp61s0: RX AssocResp from 0e:f0:78:5d:08:3c (capab=3D0x421 =
status=3D0 aid=3D1)
[  369.681063] wlp61s0: associated
[  427.300751] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input14
[  592.731992] wlp61s0: deauthenticating from 0e:f0:78:5d:08:3c by local ch=
oice (Reason: 3=3DDEAUTH_LEAVING)
[  597.588242] wlp61s0: authenticate with 0e:f0:78:5d:08:3c
[  597.601769] wlp61s0: send auth to 0e:f0:78:5d:08:3c (try 1/3)
[  597.613961] wlp61s0: authenticated
[  597.616193] wlp61s0: associate with 0e:f0:78:5d:08:3c (try 1/3)
[  597.623430] wlp61s0: RX AssocResp from 0e:f0:78:5d:08:3c (capab=3D0x421 =
status=3D0 aid=3D1)
[  597.628291] wlp61s0: associated
[  598.598247] usb 1-7: USB disconnect, device number 5
[  598.907911] usb 1-7: new full-speed USB device number 8 using xhci_hcd
[  599.057465] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[  599.057475] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[  599.065575] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[  652.360218] ------------[ cut here ]------------
[  652.360238] WARNING: CPU: 6 PID: 7702 at kernel/workqueue.c:1412 __queue=
_work+0x34d/0x400
[  652.360241] Modules linked in: uinput(E) rfcomm(E) cmac(E) algif_hash(E)=
 algif_skcipher(E) af_alg(E) bnep(E) bridge(E) stp(E) llc(E) veth(E) binfmt=
_misc(E) nls_ascii(E) intel_pmc_core_pltdrv(E) intel_pmc_core(E) nls_cp437(=
E) vfat(E) iwlmvm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) fat(E) int=
el_cstate(E) intel_rapl_msr(E) joydev(E) intel_uncore(E) mac80211(E) btusb(=
E) btrtl(E) btbcm(E) intel_rapl_perf(E) btintel(E) libarc4(E) uvcvideo(E) b=
luetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) iwlwifi(E) efi_pstore(=
E) videobuf2_v4l2(E) videobuf2_common(E) ucsi_acpi(E) drbg(E) pcspkr(E) efi=
vars(E) serio_raw(E) wmi_bmof(E) ansi_cprng(E) videodev(E) iTCO_wdt(E) iTCO=
_vendor_support(E) elan_i2c(E) intel_wmi_thunderbolt(E) watchdog(E) ecdh_ge=
neric(E) thunderbolt(E) mei_me(E) ecc(E) mc(E) tpm_crb(E) typec_ucsi(E) int=
el_pch_thermal(E) cfg80211(E) processor_thermal_device(E) thinkpad_acpi(E) =
intel_rapl_common(E) typec(E) mei(E) intel_soc_dts_iosf(E) nvram(E) tpm_tis=
(E) tpm_tis_core(E)
[  652.360298]  ledtrig_audio(E) int3403_thermal(E) rfkill(E) int340x_therm=
al_zone(E) ac(E) tpm(E) int3400_thermal(E) evdev(E) acpi_thermal_rel(E) rng=
_core(E) acpi_pad(E) button(E) coretemp(E) efivarfs(E) autofs4(E) ext4(E) c=
rc32c_generic(E) crc16(E) mbcache(E) jbd2(E) dm_crypt(E) dm_mod(E) raid10(E=
) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) =
xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) =
linear(E) md_mod(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) =
i915(E) nvme(E) i2c_algo_bit(E) aesni_intel(E) nvme_core(E) intel_lpss_pci(=
E) xhci_pci(E) libaes(E) drm_kms_helper(E) t10_pi(E) crypto_simd(E) crc_t10=
dif(E) e1000e(E) cec(E) crct10dif_generic(E) xhci_hcd(E) intel_lpss(E) ptp(=
E) psmouse(E) cryptd(E) crct10dif_pclmul(E) glue_helper(E) i2c_i801(E) pps_=
core(E) crct10dif_common(E) idma64(E) usbcore(E) drm(E) wmi(E) battery(E) v=
ideo(E)
[  652.360361] CPU: 6 PID: 7702 Comm: krfcommd Kdump: loaded Tainted: G    =
        E     5.7.0-rc6+ #16
[  652.360364] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  652.360372] RIP: 0010:__queue_work+0x34d/0x400
[  652.360378] Code: e9 94 fd ff ff 49 89 c7 e9 47 fe ff ff 65 8b 05 81 7d =
17 56 a9 00 01 1f 00 75 0f 65 48 8b 3c 25 c0 8b 01 00 f6 47 24 20 75 25 <0f=
> 0b 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b e9 7d fe
[  652.360381] RSP: 0018:ffffa9f580a2fc68 EFLAGS: 00010046
[  652.360386] RAX: 0000000080000000 RBX: 0000000000000286 RCX: ffffa9f580a=
2fd90
[  652.360389] RDX: ffff9e7aa00a4850 RSI: ffff9e7a9d59b800 RDI: ffff9e7a98c=
0ae80
[  652.360392] RBP: ffff9e7aa00a4850 R08: 0000000000000000 R09: 00000000000=
00000
[  652.360395] R10: 0000000000000200 R11: 000000000000000c R12: 00000000000=
00200
[  652.360397] R13: 0000000000000200 R14: ffff9e7a9d59b800 R15: 00000000000=
00004
[  652.360402] FS:  0000000000000000(0000) GS:ffff9e7aa2780000(0000) knlGS:=
0000000000000000
[  652.360405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  652.360408] CR2: 0000559cff818000 CR3: 000000033b60a001 CR4: 00000000003=
606e0
[  652.360411] Call Trace:
[  652.360425]  queue_work_on+0x36/0x40
[  652.360477]  l2cap_chan_send+0x109/0xb80 [bluetooth]
[  652.360503]  ? bt_sock_wait_ready+0x13d/0x1b0 [bluetooth]
[  652.360511]  ? __switch_to_asm+0x40/0x70
[  652.360516]  ? wake_up_q+0xa0/0xa0
[  652.360556]  l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
[  652.360566]  sock_sendmsg+0x5e/0x60
[  652.360577]  rfcomm_send_frame+0x55/0x90 [rfcomm]
[  652.360587]  rfcomm_send_disc.isra.0+0x7e/0xc0 [rfcomm]
[  652.360597]  __rfcomm_dlc_close+0x1ee/0x260 [rfcomm]
[  652.360606]  rfcomm_run+0x458/0x1810 [rfcomm]
[  652.360613]  ? init_wait_entry+0x30/0x30
[  652.360624]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[  652.360630]  kthread+0x115/0x140
[  652.360636]  ? __kthread_bind_mask+0x60/0x60
[  652.360642]  ret_from_fork+0x35/0x40
[  652.360649] ---[ end trace 8a565cf36828a8f8 ]---
[  702.225844] general protection fault, probably for non-canonical address=
 0xfe42558af5383ec8: 0000 [#1] SMP PTI
[  702.225849] CPU: 4 PID: 7858 Comm: sudo Kdump: loaded Tainted: G        =
W   E     5.7.0-rc6+ #16
[  702.225850] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  702.225855] RIP: 0010:kmem_cache_alloc_trace+0x7e/0x220
[  702.225857] Code: 89 01 00 00 4d 8b 07 65 49 8b 50 08 65 4c 03 05 d0 99 =
f9 55 4d 8b 20 4d 85 e4 0f 84 75 01 00 00 41 8b 47 20 49 8b 3f 4c 01 e0 <48=
> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c 89 e0 48 0f c9 48 31 cb
[  702.225858] RSP: 0018:ffffa9f580f67c28 EFLAGS: 00010282
[  702.225860] RAX: fe42558af5383ec8 RBX: 0000000000000000 RCX: 00000000000=
00000
[  702.225861] RDX: 00000000000041fe RSI: 0000000000000dc0 RDI: 00000000000=
2ff00
[  702.225862] RBP: 0000000000000dc0 R08: ffff9e7aa272ff00 R09: ffff9e7a9e9=
bd590
[  702.225863] R10: 0000000000000002 R11: 0000000000000001 R12: fe42558af53=
83ea8
[  702.225864] R13: 0000000000000030 R14: ffff9e7747c07640 R15: ffff9e7747c=
07640
[  702.225865] FS:  00007f81e50f4d00(0000) GS:ffff9e7aa2700000(0000) knlGS:=
0000000000000000
[  702.225867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  702.225868] CR2: 00007f81e4b4e06c CR3: 0000000424e06001 CR4: 00000000003=
606e0
[  702.225869] Call Trace:
[  702.225873]  ? allocate_cgrp_cset_links+0x6e/0xa0
[  702.225876]  allocate_cgrp_cset_links+0x6e/0xa0
[  702.225878]  find_css_set+0x2d1/0x6b0
[  702.225881]  cgroup_migrate_prepare_dst+0x49/0x250
[  702.225883]  cgroup_attach_task+0xef/0x1e0
[  702.225885]  __cgroup1_procs_write.constprop.0+0x104/0x140
[  702.225888]  kernfs_fop_write+0xce/0x1b0
[  702.225891]  vfs_write+0xb6/0x1a0
[  702.225893]  ksys_write+0x5f/0xe0
[  702.225896]  do_syscall_64+0x49/0xd0
[  702.225899]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  702.225901] RIP: 0033:0x7f81e5284e93
[  702.225903] Code: 8b 15 01 f0 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff =
eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[  702.225904] RSP: 002b:00007ffdba3ec458 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  702.225906] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f81e52=
84e93
[  702.225907] RDX: 0000000000000005 RSI: 000055f7e6317510 RDI: 00000000000=
00007
[  702.225907] RBP: 000055f7e6317510 R08: 0000000000000000 R09: 00000000000=
00005
[  702.225908] R10: 000055f7e6318510 R11: 0000000000000246 R12: 00000000000=
00005
[  702.225909] R13: 000055f7e6313a20 R14: 0000000000000005 R15: 00007f81e53=
558a0
[  702.225911] Modules linked in: uinput(E) rfcomm(E) cmac(E) algif_hash(E)=
 algif_skcipher(E) af_alg(E) bnep(E) bridge(E) stp(E) llc(E) veth(E) binfmt=
_misc(E) nls_ascii(E) intel_pmc_core_pltdrv(E) intel_pmc_core(E) nls_cp437(=
E) vfat(E) iwlmvm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) fat(E) int=
el_cstate(E) intel_rapl_msr(E) joydev(E) intel_uncore(E) mac80211(E) btusb(=
E) btrtl(E) btbcm(E) intel_rapl_perf(E) btintel(E) libarc4(E) uvcvideo(E) b=
luetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) iwlwifi(E) efi_pstore(=
E) videobuf2_v4l2(E) videobuf2_common(E) ucsi_acpi(E) drbg(E) pcspkr(E) efi=
vars(E) serio_raw(E) wmi_bmof(E) ansi_cprng(E) videodev(E) iTCO_wdt(E) iTCO=
_vendor_support(E) elan_i2c(E) intel_wmi_thunderbolt(E) watchdog(E) ecdh_ge=
neric(E) thunderbolt(E) mei_me(E) ecc(E) mc(E) tpm_crb(E) typec_ucsi(E) int=
el_pch_thermal(E) cfg80211(E) processor_thermal_device(E) thinkpad_acpi(E) =
intel_rapl_common(E) typec(E) mei(E) intel_soc_dts_iosf(E) nvram(E) tpm_tis=
(E) tpm_tis_core(E)
[  702.225935]  ledtrig_audio(E) int3403_thermal(E) rfkill(E) int340x_therm=
al_zone(E) ac(E) tpm(E) int3400_thermal(E) evdev(E) acpi_thermal_rel(E) rng=
_core(E) acpi_pad(E) button(E) coretemp(E) efivarfs(E) autofs4(E) ext4(E) c=
rc32c_generic(E) crc16(E) mbcache(E) jbd2(E) dm_crypt(E) dm_mod(E) raid10(E=
) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) =
xor(E) async_tx(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) multipath(E) =
linear(E) md_mod(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) =
i915(E) nvme(E) i2c_algo_bit(E) aesni_intel(E) nvme_core(E) intel_lpss_pci(=
E) xhci_pci(E) libaes(E) drm_kms_helper(E) t10_pi(E) crypto_simd(E) crc_t10=
dif(E) e1000e(E) cec(E) crct10dif_generic(E) xhci_hcd(E) intel_lpss(E) ptp(=
E) psmouse(E) cryptd(E) crct10dif_pclmul(E) glue_helper(E) i2c_i801(E) pps_=
core(E) crct10dif_common(E) idma64(E) usbcore(E) drm(E) wmi(E) battery(E) v=
ideo(E)
[  702.225960] ---[ end trace 8a565cf36828a8f9 ]---
[  702.380270] RIP: 0010:kmem_cache_alloc_trace+0x7e/0x220
[  702.380274] Code: 89 01 00 00 4d 8b 07 65 49 8b 50 08 65 4c 03 05 d0 99 =
f9 55 4d 8b 20 4d 85 e4 0f 84 75 01 00 00 41 8b 47 20 49 8b 3f 4c 01 e0 <48=
> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c 89 e0 48 0f c9 48 31 cb
[  702.380275] RSP: 0018:ffffa9f580f67c28 EFLAGS: 00010282
[  702.380276] RAX: fe42558af5383ec8 RBX: 0000000000000000 RCX: 00000000000=
00000
[  702.380277] RDX: 00000000000041fe RSI: 0000000000000dc0 RDI: 00000000000=
2ff00
[  702.380278] RBP: 0000000000000dc0 R08: ffff9e7aa272ff00 R09: ffff9e7a9e9=
bd590
[  702.380278] R10: 0000000000000002 R11: 0000000000000001 R12: fe42558af53=
83ea8
[  702.380279] R13: 0000000000000030 R14: ffff9e7747c07640 R15: ffff9e7747c=
07640
[  702.380280] FS:  00007f81e50f4d00(0000) GS:ffff9e7aa2700000(0000) knlGS:=
0000000000000000
[  702.380281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  702.380281] CR2: 00007f81e4b4e06c CR3: 0000000424e06001 CR4: 00000000003=
606e0
[  702.380283] Kernel panic - not syncing: Fatal exception
[  702.381282] Kernel Offset: 0x28e00000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)

# dmesg 3/5

[    0.000000] Linux version 5.7.0+ (linus@linus-work) (gcc version 10.2.0 =
(Debian 10.2.0-16), GNU ld (GNU Binutils for Debian) 2.35.1) #14 SMP Mon No=
v 9 12:06:03 CET 2020
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.7.0+ root=3D/dev/mappe=
r/linus--work--vg-root ro crashkernel=3D384M-8G:128M,8G-:512M
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000074f9cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000074f9d000-0x0000000074f9dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000074f9e000-0x0000000074f9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000074f9f000-0x000000007e8f7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e8f8000-0x000000007e9bdfff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007e9be000-0x000000007ff2bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ff2c000-0x000000007ff99fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007ff9a000-0x000000007fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x0000000087ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000088600000-0x000000008c7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004727fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=3D0x7ff92000 SMBIOS=3D0x7f052000 SMBIOS 3.0=
=3D0x7f04f000 ACPI=3D0x7fffe000 ACPI 2.0=3D0x7fffe014 ESRT=3D0x7eeca000 MEM=
ATTR=3D0x79711298=20
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (1.12 ) 04/=
09/2018
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.001313] tsc: Detected 1999.968 MHz TSC
[    0.001313] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001316] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001324] last_pfn =3D 0x472800 max_arch_pfn =3D 0x400000000
[    0.001333] MTRR default type: write-back
[    0.001335] MTRR fixed ranges enabled:
[    0.001337]   00000-9FFFF write-back
[    0.001339]   A0000-BFFFF uncachable
[    0.001340]   C0000-FFFFF write-protect
[    0.001341] MTRR variable ranges enabled:
[    0.001343]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001344]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001345]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001346]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.001347]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.001348]   5 disabled
[    0.001348]   6 disabled
[    0.001349]   7 disabled
[    0.001350]   8 disabled
[    0.001350]   9 disabled
[    0.002018] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.002895] last_pfn =3D 0x80000 max_arch_pfn =3D 0x400000000
[    0.019970] esrt: Reserving ESRT space from 0x000000007eeca000 to 0x0000=
00007eeca088.
[    0.019978] kexec: Reserving the low 1M of memory for crashkernel
[    0.019982] Using GB pages for direct mapping
[    0.020655] Secure boot could not be determined
[    0.020656] RAMDISK: [mem 0x34d47000-0x3669afff]
[    0.020663] ACPI: Early table checksum verification disabled
[    0.020665] ACPI: RSDP 0x000000007FFFE014 000024 (v02 LENOVO)
[    0.020670] ACPI: XSDT 0x000000007FFAD188 000124 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020677] ACPI: FACP 0x000000007FFE1000 0000F4 (v05 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020683] ACPI: DSDT 0x000000007FFBB000 0218A6 (v02 LENOVO SKL      00=
000000 INTL 20160527)
[    0.020687] ACPI: FACS 0x000000007FF3D000 000040
[    0.020690] ACPI: SSDT 0x000000007FFE9000 01320E (v02 LENOVO DptfTabl 00=
001000 INTL 20160527)
[    0.020694] ACPI: SSDT 0x000000007FFE8000 0003DB (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20160527)
[    0.020698] ACPI: TPM2 0x000000007FFE7000 000034 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020701] ACPI: UEFI 0x000000007FF53000 000042 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020708] ACPI: SSDT 0x000000007FFE3000 0030A3 (v02 LENOVO SaSsdt   00=
003000 INTL 20160527)
[    0.020715] ACPI: SSDT 0x000000007FFE2000 0005C6 (v02 LENOVO PerfTune 00=
001000 INTL 20160527)
[    0.020719] ACPI: HPET 0x000000007FFE0000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020723] ACPI: APIC 0x000000007FFDF000 00012C (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020726] ACPI: MCFG 0x000000007FFDE000 00003C (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020729] ACPI: ECDT 0x000000007FFDD000 000053 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020733] ACPI: SSDT 0x000000007FFB9000 001C9C (v02 LENOVO RVP7Rtd3 00=
001000 INTL 20160527)
[    0.020736] ACPI: SSDT 0x000000007FFB7000 00163C (v02 LENOVO ProjSsdt 00=
000010 INTL 20160527)
[    0.020740] ACPI: BOOT 0x000000007FFB6000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020743] ACPI: BATB 0x000000007FFB5000 00004A (v02 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020747] ACPI: SLIC 0x000000007FFB4000 000176 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020750] ACPI: SSDT 0x000000007FFB2000 0017AE (v02 LENOVO CpuSsdt  00=
003000 INTL 20160527)
[    0.020754] ACPI: SSDT 0x000000007FFB1000 00056D (v02 LENOVO CtdpB    00=
001000 INTL 20160527)
[    0.020757] ACPI: SSDT 0x000000007FFB0000 000678 (v02 LENOVO UsbCTabl 00=
001000 INTL 20160527)
[    0.020761] ACPI: LPIT 0x000000007FFAF000 000094 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020764] ACPI: WSMT 0x000000007FFAE000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020768] ACPI: SSDT 0x000000007FFFD000 0001D8 (v02 LENOVO HdaDsp   00=
000000 INTL 20160527)
[    0.020771] ACPI: SSDT 0x000000007FFAC000 0004FC (v02 LENOVO TbtTypeC 00=
000000 INTL 20160527)
[    0.020775] ACPI: SSDT 0x000000007FFAB000 0002D1 (v02 LENOVO Wwan     00=
000001 INTL 20160527)
[    0.020779] ACPI: DBGP 0x000000007FFAA000 000034 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020782] ACPI: DBG2 0x000000007FFA9000 000054 (v00 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020785] ACPI: MSDM 0x000000007FFA8000 000055 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020789] ACPI: DMAR 0x000000007FFA7000 0000CC (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020792] ACPI: ASF! 0x000000007FFA6000 0000A0 (v32 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020796] ACPI: FPDT 0x000000007FFA5000 000044 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020799] ACPI: BGRT 0x000000007FFA4000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020803] ACPI: UEFI 0x000000007FF3A000 00013E (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.020812] ACPI: Local APIC address 0xfee00000
[    0.020914] No NUMA configuration found
[    0.020916] Faking a node at [mem 0x0000000000000000-0x00000004727fffff]
[    0.020920] NODE_DATA(0) allocated [mem 0x4727fb000-0x4727fffff]
[    0.020941] Reserving 512MB of memory at 1280MB for crashkernel (System =
RAM: 16144MB)
[    0.020976] Zone ranges:
[    0.020977]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.020980]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.020982]   Normal   [mem 0x0000000100000000-0x00000004727fffff]
[    0.020984]   Device   empty
[    0.020985] Movable zone start for each node
[    0.020987] Early memory node ranges
[    0.020988]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.020990]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.020991]   node   0: [mem 0x0000000000100000-0x0000000074f9cfff]
[    0.020992]   node   0: [mem 0x0000000074f9f000-0x000000007e8f7fff]
[    0.020994]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.020995]   node   0: [mem 0x0000000100000000-0x00000004727fffff]
[    0.021308] Zeroed struct page in unavailable ranges: 28526 pages
[    0.021310] Initmem setup node 0 [mem 0x0000000000001000-0x00000004727ff=
fff]
[    0.021312] On node 0 totalpages: 4133010
[    0.021314]   DMA zone: 64 pages used for memmap
[    0.021315]   DMA zone: 155 pages reserved
[    0.021316]   DMA zone: 3995 pages, LIFO batch:0
[    0.021359]   DMA32 zone: 8036 pages used for memmap
[    0.021360]   DMA32 zone: 514295 pages, LIFO batch:63
[    0.027003]   Normal zone: 56480 pages used for memmap
[    0.027004]   Normal zone: 3614720 pages, LIFO batch:63
[    0.027384] Reserving Intel graphics memory at [mem 0x8a800000-0x8c7ffff=
f]
[    0.027753] ACPI: PM-Timer IO Port: 0x1808
[    0.027755] ACPI: Local APIC address 0xfee00000
[    0.027763] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.027765] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.027766] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.027767] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.027768] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.027769] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.027770] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.027771] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.027772] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.027773] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.027774] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.027775] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.027776] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.027777] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.027778] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.027779] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.027807] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.027810] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.027812] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.027814] ACPI: IRQ0 used by override.
[    0.027815] ACPI: IRQ9 used by override.
[    0.027818] Using ACPI (MADT) for SMP configuration information
[    0.027820] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.027827] e820: update [mem 0x783d7000-0x784d6fff] usable =3D=3D> rese=
rved
[    0.027837] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.027859] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.027862] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.027864] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x000fffff]
[    0.027866] PM: hibernation: Registered nosave memory: [mem 0x74f9d000-0=
x74f9dfff]
[    0.027867] PM: hibernation: Registered nosave memory: [mem 0x74f9e000-0=
x74f9efff]
[    0.027869] PM: hibernation: Registered nosave memory: [mem 0x783d7000-0=
x784d6fff]
[    0.027872] PM: hibernation: Registered nosave memory: [mem 0x7e8f8000-0=
x7e9bdfff]
[    0.027873] PM: hibernation: Registered nosave memory: [mem 0x7e9be000-0=
x7ff2bfff]
[    0.027874] PM: hibernation: Registered nosave memory: [mem 0x7ff2c000-0=
x7ff99fff]
[    0.027875] PM: hibernation: Registered nosave memory: [mem 0x7ff9a000-0=
x7fffefff]
[    0.027877] PM: hibernation: Registered nosave memory: [mem 0x80000000-0=
x87ffffff]
[    0.027878] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x885fffff]
[    0.027879] PM: hibernation: Registered nosave memory: [mem 0x88600000-0=
x8c7fffff]
[    0.027880] PM: hibernation: Registered nosave memory: [mem 0x8c800000-0=
xf7ffffff]
[    0.027881] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.027882] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfe00ffff]
[    0.027883] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0=
xfe010fff]
[    0.027884] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    0.027886] [mem 0x8c800000-0xf7ffffff] available for PCI devices
[    0.027888] Booting paravirtualized kernel on bare hardware
[    0.027891] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.033439] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.033708] percpu: Embedded 55 pages/cpu s188120 r8192 d28968 u262144
[    0.033717] pcpu-alloc: s188120 r8192 d28968 u262144 alloc=3D1*2097152
[    0.033718] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.033744] Built 1 zonelists, mobility grouping on.  Total pages: 40682=
75
[    0.033746] Policy zone: Normal
[    0.033748] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.7.0+ root=3D/de=
v/mapper/linus--work--vg-root ro crashkernel=3D384M-8G:128M,8G-:512M
[    0.035142] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.035778] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.035888] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.057682] Memory: 1522708K/16532040K available (10243K kernel code, 12=
32K rwdata, 3708K rodata, 1588K init, 2132K bss, 993064K reserved, 0K cma-r=
eserved)
[    0.057691] random: get_random_u64 called from __kmem_cache_create+0x3e/=
0x600 with crng_init=3D0
[    0.057855] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.057871] Kernel/User page tables isolation: enabled
[    0.057895] ftrace: allocating 32520 entries in 128 pages
[    0.074706] ftrace: allocated 128 pages with 1 groups
[    0.074838] rcu: Hierarchical RCU implementation.
[    0.074840] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D8.
[    0.074842] 	Rude variant of Tasks RCU enabled.
[    0.074843] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.074845] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.079575] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.079952] random: crng done (trusting CPU's manufacturer)
[    0.079981] Console: colour dummy device 80x25
[    0.080242] printk: console [tty0] enabled
[    0.080264] ACPI: Core revision 20200430
[    0.080749] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    0.080822] APIC: Switch to symmetric I/O mode setup
[    0.080825] DMAR: Host address width 39
[    0.080828] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.080836] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.080839] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.080845] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.080848] DMAR: RMRR base: 0x0000007f47f000 end: 0x0000007f49efff
[    0.080851] DMAR: RMRR base: 0x0000008a000000 end: 0x0000008c7fffff
[    0.080854] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.080857] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.080860] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.080862] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.082489] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082492] x2apic enabled
[    0.082506] Switched APIC routing to cluster x2apic.
[    0.086618] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.104697] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x39a8208cdd2, max_idle_ns: 881590748921 ns
[    0.104705] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3999.93 BogoMIPS (lpj=3D7999872)
[    0.104710] pid_max: default: 32768 minimum: 301
[    0.108732] LSM: Security Framework initializing
[    0.108741] Yama: becoming mindful.
[    0.108807] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.108840] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.109169] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.109204] process: using mwait in idle threads
[    0.109209] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.109211] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.109216] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.109219] Spectre V2 : Mitigation: Full generic retpoline
[    0.109221] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.109224] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.109226] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.109229] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.109231] Speculative Store Bypass: Vulnerable
[    0.109235] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.109520] Freeing SMP alternatives memory: 28K
[    0.112795] smpboot: CPU0: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xa)
[    0.112942] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112953] ... version:                4
[    0.112955] ... bit width:              48
[    0.112956] ... generic registers:      4
[    0.112958] ... value mask:             0000ffffffffffff
[    0.112960] ... max period:             00007fffffffffff
[    0.112962] ... fixed-purpose events:   3
[    0.112964] ... event mask:             000000070000000f
[    0.113017] rcu: Hierarchical SRCU implementation.
[    0.114032] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.114125] smp: Bringing up secondary CPUs ...
[    0.114220] x86: Booting SMP configuration:
[    0.114223] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.117657] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.117657]  #5 #6 #7
[    0.117657] smp: Brought up 1 node, 8 CPUs
[    0.117657] smpboot: Max logical packages: 1
[    0.117657] smpboot: Total of 8 processors activated (31999.48 BogoMIPS)
[    0.148774] node 0 deferred pages initialised in 28ms
[    0.149125] devtmpfs: initialized
[    0.149125] x86/mm: Memory block size: 128MB
[    0.150196] PM: Registering ACPI NVS region [mem 0x74f9d000-0x74f9dfff] =
(4096 bytes)
[    0.150196] PM: Registering ACPI NVS region [mem 0x7ff2c000-0x7ff99fff] =
(450560 bytes)
[    0.150196] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.150196] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.150196] pinctrl core: initialized pinctrl subsystem
[    0.150196] thermal_sys: Registered thermal governor 'fair_share'
[    0.150196] thermal_sys: Registered thermal governor 'bang_bang'
[    0.150196] thermal_sys: Registered thermal governor 'step_wise'
[    0.150196] thermal_sys: Registered thermal governor 'user_space'
[    0.150196] NET: Registered protocol family 16
[    0.150196] audit: initializing netlink subsys (disabled)
[    0.150196] audit: type=3D2000 audit(1604924398.068:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.150196] cpuidle: using governor ladder
[    0.150196] cpuidle: using governor menu
[    0.150196] Simple Boot Flag at 0x47 set to 0x1
[    0.150196] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.150196] ACPI: bus type PCI registered
[    0.150196] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.150196] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.150196] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.150196] PCI: Using configuration type 1 for base access
[    0.150196] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.152743] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.152743] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.348956] ACPI: Added _OSI(Module Device)
[    0.348956] ACPI: Added _OSI(Processor Device)
[    0.348956] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.348956] ACPI: Added _OSI(Processor Aggregator Device)
[    0.348956] ACPI: Added _OSI(Linux-Dell-Video)
[    0.348956] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.348956] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.418162] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.419851] ACPI: EC: EC started
[    0.419853] ACPI: EC: interrupt blocked
[    0.422290] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.422292] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.424398] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.497732] ACPI: Dynamic OEM Table Load:
[    0.497761] ACPI: SSDT 0xFFFF9E8272B5F800 0005CD (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.499616] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.501069] ACPI: Dynamic OEM Table Load:
[    0.501083] ACPI: SSDT 0xFFFF9E82070FA800 0003FF (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.502943] ACPI: Dynamic OEM Table Load:
[    0.502954] ACPI: SSDT 0xFFFF9E82072DE540 0000BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.504671] ACPI: Dynamic OEM Table Load:
[    0.504682] ACPI: SSDT 0xFFFF9E8272B59800 000628 (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.506883] ACPI: Dynamic OEM Table Load:
[    0.506898] ACPI: SSDT 0xFFFF9E8272A17000 000D14 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.509557] ACPI: Dynamic OEM Table Load:
[    0.509569] ACPI: SSDT 0xFFFF9E82070FCC00 000317 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.511482] ACPI: Dynamic OEM Table Load:
[    0.511492] ACPI: SSDT 0xFFFF9E82070FF800 00030A (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.516794] ACPI: Interpreter enabled
[    0.516870] ACPI: (supports S0 S3 S4 S5)
[    0.516873] ACPI: Using IOAPIC for interrupt routing
[    0.516926] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.517788] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.522568] ACPI: Power Resource [PUBS] (on)
[    0.548965] ACPI: Power Resource [PXP] (on)
[    0.570221] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.570245] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.573132] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.574726] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR]
[    0.574729] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.577509] PCI host bridge to bus 0000:00
[    0.577514] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.577517] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.577520] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.577523] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]
[    0.577526] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    0.577528] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]
[    0.577531] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]
[    0.577534] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]
[    0.577537] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]
[    0.577540] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]
[    0.577542] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]
[    0.577545] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]
[    0.577548] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]
[    0.577551] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]
[    0.577553] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]
[    0.577556] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ffff=
f window]
[    0.577559] pci_bus 0000:00: root bus resource [mem 0x8c800000-0xf7fffff=
f window]
[    0.577562] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    0.577565] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.577580] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.578742] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.578760] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.578770] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.578778] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.578801] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.579978] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.579998] pci 0000:00:04.0: reg 0x10: [mem 0xe8240000-0xe8247fff 64bit]
[    0.581263] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.581284] pci 0000:00:08.0: reg 0x10: [mem 0xe8250000-0xe8250fff 64bit]
[    0.582472] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.582500] pci 0000:00:14.0: reg 0x10: [mem 0xe8220000-0xe822ffff 64bit]
[    0.582582] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.583883] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.583911] pci 0000:00:14.2: reg 0x10: [mem 0xe8251000-0xe8251fff 64bit]
[    0.585204] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.585468] pci 0000:00:15.0: reg 0x10: [mem 0xe8252000-0xe8252fff 64bit]
[    0.587520] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.587551] pci 0000:00:16.0: reg 0x10: [mem 0xe8253000-0xe8253fff 64bit]
[    0.587637] pci 0000:00:16.0: PME# supported from D3hot
[    0.588882] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.590055] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.591284] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.592445] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.593698] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.593796] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.595043] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.595157] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.596436] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.597767] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.597786] pci 0000:00:1f.2: reg 0x10: [mem 0xe824c000-0xe824ffff]
[    0.599032] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.599067] pci 0000:00:1f.3: reg 0x10: [mem 0xe8248000-0xe824bfff 64bit]
[    0.599106] pci 0000:00:1f.3: reg 0x20: [mem 0xe8230000-0xe823ffff 64bit]
[    0.599166] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.600427] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.600484] pci 0000:00:1f.4: reg 0x10: [mem 0xe8254000-0xe82540ff 64bit]
[    0.600536] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.601799] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.601830] pci 0000:00:1f.6: reg 0x10: [mem 0xe8200000-0xe821ffff]
[    0.601944] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.603199] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.603277] pci 0000:04:00.0: [8086:15c0] type 01 class 0x060400
[    0.603348] pci 0000:04:00.0: enabling Extended Tags
[    0.603443] pci 0000:04:00.0: supports D1 D2
[    0.603446] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.603621] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.603628] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.603634] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.603707] pci 0000:05:00.0: [8086:15c0] type 01 class 0x060400
[    0.603783] pci 0000:05:00.0: enabling Extended Tags
[    0.603880] pci 0000:05:00.0: supports D1 D2
[    0.603882] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604004] pci 0000:05:01.0: [8086:15c0] type 01 class 0x060400
[    0.604080] pci 0000:05:01.0: enabling Extended Tags
[    0.604179] pci 0000:05:01.0: supports D1 D2
[    0.604182] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604299] pci 0000:05:02.0: [8086:15c0] type 01 class 0x060400
[    0.604375] pci 0000:05:02.0: enabling Extended Tags
[    0.604470] pci 0000:05:02.0: supports D1 D2
[    0.604472] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604633] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.604644] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.604652] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.604716] pci 0000:06:00.0: [8086:15bf] type 00 class 0x088000
[    0.604754] pci 0000:06:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.604768] pci 0000:06:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.604838] pci 0000:06:00.0: enabling Extended Tags
[    0.604952] pci 0000:06:00.0: supports D1 D2
[    0.604955] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605138] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.605149] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.605203] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.605214] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.605222] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.605302] pci 0000:3c:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.605342] pci 0000:3c:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.605429] pci 0000:3c:00.0: enabling Extended Tags
[    0.605546] pci 0000:3c:00.0: supports D1 D2
[    0.605549] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605650] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.605774] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.605785] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.606248] pci 0000:3d:00.0: [8086:24fd] type 00 class 0x028000
[    0.606351] pci 0000:3d:00.0: reg 0x10: [mem 0xe8100000-0xe8101fff 64bit]
[    0.606954] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    0.607714] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.607721] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.607965] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.608000] pci 0000:3e:00.0: reg 0x10: [mem 0xe8000000-0xe8003fff 64bit]
[    0.608465] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.608471] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.611588] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611655] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.611717] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611779] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611840] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611900] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611961] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.612022] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.612903] ACPI: EC: interrupt unblocked
[    0.612907] ACPI: EC: event unblocked
[    0.612920] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.612922] ACPI: EC: GPE=3D0x16
[    0.612925] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.612928] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.613021] iommu: Default domain type: Translated=20
[    0.613038] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.613038] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.613038] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.613038] vgaarb: loaded
[    0.613038] EDAC MC: Ver: 3.0.0
[    0.613442] Registered efivars operations
[    0.613442] PCI: Using ACPI for IRQ routing
[    0.615234] PCI: pci_cache_line_size set to 64 bytes
[    0.617439] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.617440] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.617441] e820: reserve RAM buffer [mem 0x74f9d000-0x77ffffff]
[    0.617442] e820: reserve RAM buffer [mem 0x783d7000-0x7bffffff]
[    0.617443] e820: reserve RAM buffer [mem 0x7e8f8000-0x7fffffff]
[    0.617445] e820: reserve RAM buffer [mem 0x472800000-0x473ffffff]
[    0.617559] NetLabel: Initializing
[    0.617562] NetLabel:  domain hash size =3D 128
[    0.617563] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.617582] NetLabel:  unlabeled traffic allowed by default
[    0.617607] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.617612] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.619663] clocksource: Switched to clocksource tsc-early
[    0.629367] VFS: Disk quotas dquot_6.6.0
[    0.629390] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.629459] pnp: PnP ACPI init
[    0.629716] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.629720] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.629723] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.629727] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.629730] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.629732] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.629735] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.629742] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630203] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.630209] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630774] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.630778] system 00:02: [io  0xffff] has been reserved
[    0.630781] system 00:02: [io  0xffff] has been reserved
[    0.630784] system 00:02: [io  0xffff] has been reserved
[    0.630786] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.630789] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.630794] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630936] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.630994] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.631000] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    0.631022] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.631042] pnp 00:06: Plug and Play ACPI device, IDs LEN008f PNP0f13 (a=
ctive)
[    0.631183] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.631187] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.631190] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.631193] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.631196] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.631198] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.631201] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.631204] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.631206] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.631209] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.631212] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.631215] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.631218] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.631221] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.631224] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.631227] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.631230] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.631233] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.631236] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.631239] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.631244] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.633032] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.633035] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.633038] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.633044] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.634252] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.634256] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.634259] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.634262] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.634265] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.634268] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.634270] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.634273] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.634276] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.634279] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.634284] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.634618] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.634622] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.634625] system 00:0a: [mem 0x00100000-0x8c7fffff] could not be reser=
ved
[    0.634628] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.634631] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.634636] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.634805] pnp: PnP ACPI: found 11 devices
[    0.640815] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.640858] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    0.640863] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.640867] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    0.640871] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus =
07-3b] add_size 1000
[    0.640876] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus =
05-3c] add_size 1000
[    0.640879] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
04-3c] add_size 2000
[    0.640894] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8c800000-0x8c9ffff=
f]
[    0.640908] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8ca00000-0x8cbffff=
f 64bit pref]
[    0.640913] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.640916] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x4fff]
[    0.640920] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.640926] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.640932] pci 0000:00:1c.0:   bridge window [mem 0x8c800000-0x8c9fffff]
[    0.640937] pci 0000:00:1c.0:   bridge window [mem 0x8ca00000-0x8cbfffff=
 64bit pref]
[    0.640944] pci 0000:04:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.640948] pci 0000:05:01.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.640951] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.640958] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.640969] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.640973] pci 0000:05:01.0:   bridge window [io  0x3000-0x3fff]
[    0.640980] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.640985] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.640994] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.641001] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.641011] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.641015] pci 0000:04:00.0:   bridge window [io  0x3000-0x3fff]
[    0.641022] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.641027] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.641035] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.641038] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.641043] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.641047] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.641054] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.641059] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.641067] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.641074] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.641084] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.641087] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.641089] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.641092] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.641094] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.641097] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.641100] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.641102] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.641105] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.641107] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.641110] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.641112] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.641115] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.641117] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.641120] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.641122] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.641125] pci_bus 0000:00: resource 20 [mem 0x8c800000-0xf7ffffff wind=
ow]
[    0.641128] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.641130] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.641133] pci_bus 0000:01: resource 1 [mem 0x8c800000-0x8c9fffff]
[    0.641135] pci_bus 0000:01: resource 2 [mem 0x8ca00000-0x8cbfffff 64bit=
 pref]
[    0.641138] pci_bus 0000:04: resource 0 [io  0x3000-0x4fff]
[    0.641141] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.641143] pci_bus 0000:04: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.641146] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.641149] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.641151] pci_bus 0000:05: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.641154] pci_bus 0000:06: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.641157] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.641159] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.641161] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.641164] pci_bus 0000:3c: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.641167] pci_bus 0000:3d: resource 1 [mem 0xe8100000-0xe81fffff]
[    0.641169] pci_bus 0000:3e: resource 1 [mem 0xe8000000-0xe80fffff]
[    0.641354] NET: Registered protocol family 2
[    0.641529] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.641657] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.641923] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.642028] TCP: Hash tables configured (established 131072 bind 65536)
[    0.642084] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.642146] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.642258] NET: Registered protocol family 1
[    0.642275] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.642810] pci 0000:04:00.0: enabling device (0006 -> 0007)
[    0.643576] PCI: CLS 128 bytes, default 64
[    0.643626] Trying to unpack rootfs image as initramfs...
[    1.221209] Freeing initrd memory: 25936K
[    1.221283] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:1=
5.0
[    1.236781] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.236784] software IO TLB: mapped [mem 0x79f2f000-0x7df2f000] (64MB)
[    1.237414] Initialise system trusted keyrings
[    1.237425] Key type blacklist registered
[    1.237473] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.238815] zbud: loaded
[    1.238958] integrity: Platform Keyring initialized
[    1.238962] Key type asymmetric registered
[    1.238964] Asymmetric key parser 'x509' registered
[    1.238974] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.239027] io scheduler mq-deadline registered
[    1.239482] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.239517] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.239686] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    1.239713] pcieport 0000:00:1c.4: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.240012] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    1.240264] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.240636] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
[    1.240785] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.241108] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.241137] efifb: probing for efifb
[    1.241154] efifb: framebuffer at 0xc0000000, using 14400k, total 14400k
[    1.241156] efifb: mode is 2560x1440x32, linelength=3D10240, pages=3D1
[    1.241158] efifb: scrolling: redraw
[    1.241161] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.250501] Console: switching to colour frame buffer device 160x45
[    1.259836] fb0: EFI VGA frame buffer device
[    1.259912] intel_idle: MWAIT substates: 0x11142120
[    1.259913] intel_idle: v0.5.1 model 0x8E
[    1.260502] intel_idle: Local APIC timer is reliable in all C-states
[    1.264953] thermal LNXTHERM:00: registered as thermal_zone0
[    1.265043] ACPI: Thermal Zone [THM0] (46 C)
[    1.265369] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.266447] Linux agpgart interface v0.103
[    1.266565] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.266668] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    1.267617] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.269747] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.269829] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.270168] mousedev: PS/2 mouse device common for all mice
[    1.270308] rtc_cmos 00:03: RTC can wake from S4
[    1.271008] rtc_cmos 00:03: registered as rtc0
[    1.271247] rtc_cmos 00:03: setting system clock to 2020-11-09T12:19:59 =
UTC (1604924399)
[    1.271406] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[    1.271531] intel_pstate: Intel P-state driver initializing
[    1.272561] intel_pstate: HWP enabled
[    1.272659] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.273304] ledtrig-cpu: registered to indicate activity on CPUs
[    1.273776] NET: Registered protocol family 10
[    1.283035] Segment Routing with IPv6
[    1.284946] mip6: Mobile IPv6
[    1.286839] NET: Registered protocol family 17
[    1.288961] mpls_gso: MPLS GSO support
[    1.290994] microcode: sig=3D0x806ea, pf=3D0x80, revision=3D0x84
[    1.293588] microcode: Microcode Update Driver: v2.2.
[    1.293589] IPI shorthand broadcast: enabled
[    1.296351] sched_clock: Marking stable (1291892378, 811176)->(130041600=
1, -7712447)
[    1.297876] registered taskstats version 1
[    1.299270] Loading compiled-in X.509 certificates
[    1.300632] zswap: loaded using pool lzo/zbud
[    1.303148] integrity: Loading X.509 certificate: UEFI:db
[    1.304514] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.306070] integrity: Loading X.509 certificate: UEFI:db
[    1.307600] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.309171] integrity: Loading X.509 certificate: UEFI:db
[    1.310749] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.312372] integrity: Loading X.509 certificate: UEFI:db
[    1.313960] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.318091] Freeing unused kernel image (initmem) memory: 1588K
[    1.337162] Write protecting the kernel read-only data: 16384k
[    1.339279] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.341209] Freeing unused kernel image (rodata/data gap) memory: 388K
[    1.380579] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.382129] x86/mm: Checking user space page tables
[    1.419524] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.421048] Run /init as init process
[    1.422541]   with arguments:
[    1.422541]     /init
[    1.422542]   with environment:
[    1.422542]     HOME=3D/
[    1.422542]     TERM=3Dlinux
[    1.422543]     BOOT_IMAGE=3D/vmlinuz-5.7.0+
[    1.422543]     crashkernel=3D384M-8G:128M,8G-:512M
[    1.491981] video: module verification failed: signature and/or required=
 key missing - tainting kernel
[    1.499126] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    1.503006] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    1.505993] pps_core: LinuxPPS API ver. 1 registered
[    1.508086] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.511262] cryptd: max_cpu_qlen set to 1000
[    1.514783] ACPI: bus type USB registered
[    1.516047] battery: ACPI: Battery Slot [BAT0] (battery present)
[    1.516971] usbcore: registered new interface driver usbfs
[    1.520823] usbcore: registered new interface driver hub
[    1.522943] usbcore: registered new device driver usb
[    1.525433] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    1.528347] PTP clock support registered
[    1.528476] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.532133] AVX2 version of gcm_enc/dec engaged.
[    1.534217] AES CTR mode by8 optimization enabled
[    1.536354] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.538222] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.540399] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.542459] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.544202] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    1.546478] nvme nvme0: pci function 0000:3e:00.0
[    1.547061] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000081109810
[    1.551152] xhci_hcd 0000:00:14.0: cache line size of 128 is not support=
ed
[    1.553040] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.553078] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.07
[    1.554772] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.554901] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    1.556540] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.557318] nvme nvme0: Shutdown timeout set to 8 seconds
[    1.564783] usb usb1: Product: xHCI Host Controller
[    1.566326] nvme nvme0: 8/0/0 default/read/poll queues
[    1.566934] usb usb1: Manufacturer: Linux 5.7.0+ xhci-hcd
[    1.571090] usb usb1: SerialNumber: 0000:00:14.0
[    1.571655]  nvme0n1: p1 p2 p3
[    1.572800] hub 1-0:1.0: USB hub found
[    1.576479] hub 1-0:1.0: 12 ports detected
[    1.579939] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.581560] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.583157] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.585118] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.07
[    1.586847] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.588415] usb usb2: Product: xHCI Host Controller
[    1.590409] usb usb2: Manufacturer: Linux 5.7.0+ xhci-hcd
[    1.592298] usb usb2: SerialNumber: 0000:00:14.0
[    1.593985] hub 2-0:1.0: USB hub found
[    1.595483] hub 2-0:1.0: 6 ports detected
[    1.597439] usb: port power management may be unreliable
[    1.599150] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    1.600497] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 3
[    1.603057] xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    1.604680] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.07
[    1.606156] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.607639] usb usb3: Product: xHCI Host Controller
[    1.609129] usb usb3: Manufacturer: Linux 5.7.0+ xhci-hcd
[    1.610632] usb usb3: SerialNumber: 0000:3c:00.0
[    1.612208] hub 3-0:1.0: USB hub found
[    1.613707] hub 3-0:1.0: 2 ports detected
[    1.614276] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    1.615485] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    1.618106] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 4
[    1.619574] xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.620031] checking generic (c0000000 e10000) vs hw (e7000000 1000000)
[    1.621052] checking generic (c0000000 e10000) vs hw (c0000000 10000000)
[    1.621052] fb0: switching to inteldrmfb from EFI VGA
[    1.621072] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.07
[    1.624097] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.624098] usb usb4: Product: xHCI Host Controller
[    1.624099] usb usb4: Manufacturer: Linux 5.7.0+ xhci-hcd
[    1.624099] usb usb4: SerialNumber: 0000:3c:00.0
[    1.624109] Console: switching to colour dummy device 80x25
[    1.624133] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.624160] hub 4-0:1.0: USB hub found
[    1.624166] hub 4-0:1.0: 2 ports detected
[    1.652858] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.653196] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    1.653223] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver=
1_04.bin failed with error -2
[    1.653225] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/kb=
l_dmc_ver1_04.bin. Disabling runtime power management.
[    1.653227] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    1.658839] i915 0000:00:02.0: [drm] Reducing the compressed framebuffer=
 size. This may lead to less power savings than a non-reduced-size. Try to =
increase stolen memory size if available in BIOS.
[    1.667139] [drm] Initialized i915 1.6.0 20200515 for 0000:00:02.0 on mi=
nor 0
[    1.669208] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    1.669419] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input3
[    1.787079] fbcon: i915drmfb (fb0) is primary device
[    1.800324] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    1.867493] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 8c:=
16:45:66:ba:11
[    1.867496] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    1.867593] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    1.869745] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    1.920729] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    1.948797] usb 3-1: new high-speed USB device number 2 using xhci_hcd
[    2.030262] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x7f3001)
[    2.042245] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0f.
[    2.054175] psmouse serio1: elantech: Elan sample query result 00, 20, c9
[    2.077680] psmouse serio1: elantech: Trying to set up SMBus access
[    2.083929] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
9540, bcdDevice=3D 1.20
[    2.083933] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.083936] usb 1-3: Product: EMV Smartcard Reader
[    2.083938] usb 1-3: Manufacturer: Generic
[    2.103058] usb 3-1: New USB device found, idVendor=3D17ef, idProduct=3D=
3071, bcdDevice=3D a.73
[    2.103063] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.103066] usb 3-1: Product: USB2.0 Hub            =20
[    2.103068] usb 3-1: Manufacturer: VIA Labs, Inc.        =20
[    2.104514] hub 3-1:1.0: USB hub found
[    2.104694] hub 3-1:1.0: 5 ports detected
[    2.201074] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    2.230651] usb 4-1: new SuperSpeedPlus Gen 2 USB device number 2 using =
xhci_hcd
[    2.235002] usb 2-3: New USB device found, idVendor=3D0bda, idProduct=3D=
0316, bcdDevice=3D 2.04
[    2.235008] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.235013] usb 2-3: Product: USB3.0-CRW
[    2.235017] usb 2-3: Manufacturer: Generic
[    2.235021] usb 2-3: SerialNumber: 20120501030900000
[    2.254272] usb 4-1: New USB device found, idVendor=3D17ef, idProduct=3D=
3070, bcdDevice=3D a.73
[    2.254276] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.254278] usb 4-1: Product: USB3.1 Hub            =20
[    2.254280] usb 4-1: Manufacturer: VIA Labs, Inc.        =20
[    2.256858] tsc: Refined TSC clocksource calibration: 1991.999 MHz
[    2.256872] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396=
d4ffc055, max_idle_ns: 881590662783 ns
[    2.256988] clocksource: Switched to clocksource tsc
[    2.258365] hub 4-1:1.0: USB hub found
[    2.258701] hub 4-1:1.0: 4 ports detected
[    2.352812] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    2.511417] usb 1-4: New USB device found, idVendor=3D17ef, idProduct=3D=
3074, bcdDevice=3D 0.00
[    2.511421] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.511425] usb 1-4: Product: USB Billboard
[    2.511427] usb 1-4: Manufacturer: Cypress Semiconductor
[    2.511429] usb 1-4: SerialNumber: 11AD1D00E05F48161E0E0B00
[    2.520887] hid: raw HID events driver (C) Jiri Kosina
[    2.525317] usbcore: registered new interface driver usbhid
[    2.525318] usbhid: USB HID core driver
[    2.526504] hid-generic 0003:17EF:3074.0001: hiddev0,hidraw0: USB HID v1=
=2E11 Device [Cypress Semiconductor USB Billboard] on usb-0000:00:14.0-4/in=
put1
[    2.640986] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[    2.799140] usb 1-5: New USB device found, idVendor=3D04f2, idProduct=3D=
b615, bcdDevice=3D 0.11
[    2.799145] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.799148] usb 1-5: Product: Integrated IR Camera
[    2.799150] usb 1-5: Manufacturer: SunplusIT Inc
[    2.848796] usb 3-1.2: new high-speed USB device number 3 using xhci_hcd
[    2.894937] Console: switching to colour frame buffer device 160x45
[    2.928744] usb 1-6: new high-speed USB device number 5 using xhci_hcd
[    2.999718] usb 3-1.2: New USB device found, idVendor=3D17ef, idProduct=
=3D3071, bcdDevice=3D a.74
[    3.000569] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    3.003131] usb 3-1.2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    3.013118] usb 3-1.2: Product: USB2.0 Hub            =20
[    3.014604] usb 3-1.2: Manufacturer: VIA Labs, Inc.        =20
[    3.017878] hub 3-1.2:1.0: USB hub found
[    3.019642] hub 3-1.2:1.0: 4 ports detected
[    3.083274] usb 1-6: New USB device found, idVendor=3D2cb7, idProduct=3D=
0210, bcdDevice=3D 3.33
[    3.085736] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    3.088285] usb 1-6: Product: L830-EB-00
[    3.091103] usb 1-6: Manufacturer: FIBOCOM
[    3.093997] usb 1-6: SerialNumber: 004999010640000
[    3.236807] usb 1-7: new full-speed USB device number 6 using xhci_hcd
[    3.367568] usb 4-1.2: new SuperSpeedPlus Gen 2 USB device number 3 usin=
g xhci_hcd
[    3.394406] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[    3.401917] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    3.471999] usb 4-1.2: New USB device found, idVendor=3D17ef, idProduct=
=3D3070, bcdDevice=3D a.74
[    3.479728] usb 4-1.2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    3.487230] usb 4-1.2: Product: USB3.1 Hub            =20
[    3.495137] usb 4-1.2: Manufacturer: VIA Labs, Inc.        =20
[    3.522803] hub 4-1.2:1.0: USB hub found
[    3.528086] hub 4-1.2:1.0: 4 ports detected
[    3.552756] usb 1-8: new high-speed USB device number 7 using xhci_hcd
[    3.584740] raid6: avx2x4   gen() 30138 MB/s
[    3.600747] usb 3-1.3: new low-speed USB device number 4 using xhci_hcd
[    3.652741] raid6: avx2x4   xor() 21411 MB/s
[    3.712141] usb 1-8: New USB device found, idVendor=3D04f2, idProduct=3D=
b614, bcdDevice=3D 0.12
[    3.713830] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.715504] usb 1-8: Product: Integrated Camera
[    3.717182] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    3.720753] raid6: avx2x2   gen() 43339 MB/s
[    3.757768] usb 3-1.3: New USB device found, idVendor=3D046d, idProduct=
=3Dc069, bcdDevice=3D56.01
[    3.759428] usb 3-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    3.761129] usb 3-1.3: Product: USB Laser Mouse
[    3.762806] usb 3-1.3: Manufacturer: Logitech
[    3.772290] input: Logitech USB Laser Mouse as /devices/pci0000:00/0000:=
00:1c.4/0000:04:00.0/0000:05:02.0/0000:3c:00.0/usb3/3-1/3-1.3/3-1.3:1.0/000=
3:046D:C069.0002/input/input4
[    3.775816] hid-generic 0003:046D:C069.0002: input,hidraw1: USB HID v1.1=
0 Mouse [Logitech USB Laser Mouse] on usb-0000:3c:00.0-1.3/input0
[    3.788766] raid6: avx2x2   xor() 25964 MB/s
[    3.848753] usb 1-9: new full-speed USB device number 8 using xhci_hcd
[    3.856751] raid6: avx2x1   gen() 36245 MB/s
[    3.856761] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
[    3.924768] raid6: avx2x1   xor() 22270 MB/s
[    3.962093] usb 3-1.5: New USB device found, idVendor=3D17ef, idProduct=
=3D3075, bcdDevice=3D 0.01
[    3.963880] usb 3-1.5: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    3.965691] usb 3-1.5: Product: USB Billboard Device  =20
[    3.967433] usb 3-1.5: Manufacturer: VIA Labs, Inc.        =20
[    3.969175] usb 3-1.5: SerialNumber: 0000000000000001
[    3.992755] raid6: sse2x4   gen() 17567 MB/s
[    3.998172] usb 1-9: New USB device found, idVendor=3D06cb, idProduct=3D=
009a, bcdDevice=3D 1.64
[    3.999857] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    4.001587] usb 1-9: SerialNumber: 5bb5988684f7
[    4.060767] raid6: sse2x4   xor() 10309 MB/s
[    4.088773] usb 3-1.2.1: new high-speed USB device number 6 using xhci_h=
cd
[    4.128735] raid6: sse2x2   gen() 17465 MB/s
[    4.196771] raid6: sse2x2   xor() 10896 MB/s
[    4.240918] usb 3-1.2.1: New USB device found, idVendor=3D045b, idProduc=
t=3D0209, bcdDevice=3D 1.00
[    4.242750] usb 3-1.2.1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    4.245679] hub 3-1.2.1:1.0: USB hub found
[    4.247518] hub 3-1.2.1:1.0: 4 ports detected
[    4.264752] raid6: sse2x1   gen() 14680 MB/s
[    4.332766] raid6: sse2x1   xor()  7644 MB/s
[    4.334445] raid6: using algorithm avx2x2 gen() 43339 MB/s
[    4.336115] raid6: .... xor() 25964 MB/s, rmw enabled
[    4.337811] raid6: using avx2x2 recovery algorithm
[    4.339691] async_tx: api initialized (async)
[    4.341632] xor: automatically using best checksumming function   avx   =
   =20
[    4.381117] usb 3-1.2.3: new full-speed USB device number 7 using xhci_h=
cd
[    4.492148] device-mapper: uevent: version 1.0.3
[    4.494178] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[    4.540927] usb 3-1.2.3: New USB device found, idVendor=3D17ef, idProduc=
t=3D6047, bcdDevice=3D 3.30
[    4.544442] usb 3-1.2.3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    4.547287] usb 3-1.2.3: Product: ThinkPad Compact USB Keyboard with Tra=
ckPoint
[    4.549122] usb 3-1.2.3: Manufacturer: Lenovo
[    4.567550] input: Lenovo ThinkPad Compact USB Keyboard with TrackPoint =
as /devices/pci0000:00/0000:00:1c.4/0000:04:00.0/0000:05:02.0/0000:3c:00.0/=
usb3/3-1/3-1.2/3-1.2.3/3-1.2.3:1.0/0003:17EF:6047.0003/input/input5
[    4.633557] lenovo 0003:17EF:6047.0003: input,hidraw2: USB HID v1.00 Key=
board [Lenovo ThinkPad Compact USB Keyboard with TrackPoint] on usb-0000:3c=
:00.0-1.2.3/input0
[    4.651502] input: Lenovo ThinkPad Compact USB Keyboard with TrackPoint =
as /devices/pci0000:00/0000:00:1c.4/0000:04:00.0/0000:05:02.0/0000:3c:00.0/=
usb3/3-1/3-1.2/3-1.2.3/3-1.2.3:1.1/0003:17EF:6047.0004/input/input6
[    4.697008] usb 3-1.2.4: new high-speed USB device number 8 using xhci_h=
cd
[    4.729619] lenovo 0003:17EF:6047.0004: input,hiddev1,hidraw3: USB HID v=
1.00 Mouse [Lenovo ThinkPad Compact USB Keyboard with TrackPoint] on usb-00=
00:3c:00.0-1.2.3/input1
[    5.998316] usb 3-1.2.4: New USB device found, idVendor=3D17ef, idProduc=
t=3D306f, bcdDevice=3D 0.12
[    6.005246] usb 3-1.2.4: New USB device strings: Mfr=3D3, Product=3D1, S=
erialNumber=3D0
[    6.008487] usb 3-1.2.4: Product: ThinkPad Dock USB Audio
[    6.011698] usb 3-1.2.4: Manufacturer: Generic
[    6.031837] input: Generic ThinkPad Dock USB Audio Consumer Control as /=
devices/pci0000:00/0000:00:1c.4/0000:04:00.0/0000:05:02.0/0000:3c:00.0/usb3=
/3-1/3-1.2/3-1.2.4/3-1.2.4:1.3/0003:17EF:306F.0005/input/input7
[    6.097084] input: Generic ThinkPad Dock USB Audio as /devices/pci0000:0=
0/0000:00:1c.4/0000:04:00.0/0000:05:02.0/0000:3c:00.0/usb3/3-1/3-1.2/3-1.2.=
4/3-1.2.4:1.3/0003:17EF:306F.0005/input/input8
[    6.108703] hid-generic 0003:17EF:306F.0005: input,hiddev2,hidraw4: USB =
HID v1.11 Device [Generic ThinkPad Dock USB Audio] on usb-0000:3c:00.0-1.2.=
4/input3
[    6.325019] usb 3-1.2.1.1: new high-speed USB device number 9 using xhci=
_hcd
[    6.453420] usb 3-1.2.1.1: New USB device found, idVendor=3D045b, idProd=
uct=3D0209, bcdDevice=3D 1.00
[    6.464894] usb 3-1.2.1.1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
[    6.478150] hub 3-1.2.1.1:1.0: USB hub found
[    6.489571] hub 3-1.2.1.1:1.0: 4 ports detected
[    6.965015] usb 3-1.2.1.1.4: new full-speed USB device number 10 using x=
hci_hcd
[    7.053030] usb 3-1.2.1.1.4: device descriptor read/64, error -32
[    7.245049] usb 3-1.2.1.1.4: device descriptor read/64, error -32
[    7.441027] usb 3-1.2.1.1.4: new full-speed USB device number 11 using x=
hci_hcd
[    7.524848] usb 3-1.2.1.1.4: device descriptor read/64, error -32
[    7.721049] usb 3-1.2.1.1.4: device descriptor read/64, error -32
[    7.837120] usb 3-1.2.1.1-port4: attempt power cycle
[    8.449025] usb 3-1.2.1.1.4: new full-speed USB device number 12 using x=
hci_hcd
[    8.455699] usb 3-1.2.1.1.4: Device not responding to setup address.
[    8.665123] usb 3-1.2.1.1.4: Device not responding to setup address.
[    8.881020] usb 3-1.2.1.1.4: device not accepting address 12, error -71
[    8.985026] usb 3-1.2.1.1.4: new full-speed USB device number 13 using x=
hci_hcd
[    8.989110] usb 3-1.2.1.1.4: Device not responding to setup address.
[    9.201160] usb 3-1.2.1.1.4: Device not responding to setup address.
[    9.417018] usb 3-1.2.1.1.4: device not accepting address 13, error -71
[    9.422939] usb 3-1.2.1.1-port4: unable to enumerate USB device
[   20.241166] PM: Image not found (code -22)
[   20.333169] EXT4-fs (dm-1): mounted filesystem with ordered data mode. O=
pts: (null)
[   20.416626] systemd[1]: Inserted module 'autofs4'
[   20.500504] systemd[1]: systemd 246.6-2 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCR=
E2 default-hierarchy=3Dhybrid)
[   20.521194] systemd[1]: Detected architecture x86-64.
[   20.550129] systemd[1]: Set hostname to <linus-work>.
[   20.625356] systemd[1]: /lib/systemd/system/gpsd.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/g=
psd.sock \xffffffe2\xffffff86\xffffff92 /run/gpsd.sock; please update the u=
nit file accordingly.
[   20.639441] systemd[1]: /lib/systemd/system/plymouth-start.service:16: U=
nit configured to use KillMode=3Dnone. This is unsafe, as it disables syste=
md's process lifecycle management for the service. Please update your servi=
ce to use a safer KillMode=3D, such as 'mixed' or 'control-group'. Support =
for KillMode=3Dnone is deprecated and will eventually be removed.
[   20.652341] systemd[1]: /lib/systemd/system/rpc-statd.service:16: PIDFil=
e=3D references a path below legacy directory /var/run/, updating /var/run/=
rpc.statd.pid \xffffffe2\xffffff86\xffffff92 /run/rpc.statd.pid; please upd=
ate the unit file accordingly.
[   20.662163] systemd[1]: /lib/systemd/system/smartmontools.service:10: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.
[   20.669684] systemd[1]: /lib/systemd/system/kdump-tools.service:6: Stand=
ard output type syslog+console is obsolete, automatically updating to journ=
al+console. Please update your unit file, and consider removing the setting=
 altogether.
[   20.675741] systemd[1]: /lib/systemd/system/fancontrol.service:11: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/fancontrol.pid \xffffffe2\xffffff86\xffffff92 /run/fancontrol.pid; please =
update the unit file accordingly.
[   20.684410] systemd[1]: Queued start job for default target Graphical In=
terface.
[   20.687368] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   20.690125] systemd[1]: Created slice system-getty.slice.
[   20.694688] systemd[1]: Created slice system-modprobe.slice.
[   20.700113] systemd[1]: Created slice Cryptsetup Units Slice.
[   20.705569] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   20.711090] systemd[1]: Created slice system-tor.slice.
[   20.716549] systemd[1]: Created slice User and Session Slice.
[   20.721854] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   20.724400] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   20.729791] systemd[1]: Reached target Slices.
[   20.735212] systemd[1]: Reached target Libvirt guests shutdown.
[   20.737733] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   20.743170] systemd[1]: Listening on LVM2 poll daemon socket.
[   20.750980] systemd[1]: Listening on RPCbind Server Activation Socket.
[   20.754439] systemd[1]: Listening on Syslog Socket.
[   20.759653] systemd[1]: Listening on fsck to fsckd communication Socket.
[   20.764924] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   20.770230] systemd[1]: Listening on Journal Audit Socket.
[   20.775232] systemd[1]: Listening on Journal Socket (/dev/log).
[   20.780217] systemd[1]: Listening on Journal Socket.
[   20.784863] systemd[1]: Listening on udev Control Socket.
[   20.789267] systemd[1]: Listening on udev Kernel Socket.
[   20.793870] systemd[1]: Mounting Huge Pages File System...
[   20.797919] systemd[1]: Mounting POSIX Message Queue File System...
[   20.801701] systemd[1]: Mounting NFSD configuration filesystem...
[   20.805661] systemd[1]: Mounting RPC Pipe File System...
[   20.809681] systemd[1]: Mounting Kernel Debug File System...
[   20.813576] systemd[1]: Mounting Kernel Trace File System...
[   20.816938] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   20.817019] systemd[1]: Finished Availability of block devices.
[   20.823023] systemd[1]: Starting Set the console keyboard layout...
[   20.827289] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   20.831192] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   20.834681] systemd[1]: Condition check resulted in Load Kernel Module d=
rm being skipped.
[   20.835090] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   20.838525] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[   20.839644] systemd[1]: Starting Journal Service...
[   20.845403] systemd[1]: Starting Load Kernel Modules...
[   20.849389] systemd[1]: Starting Remount Root and Kernel File Systems...
[   20.853977] systemd[1]: Starting Coldplug All udev Devices...
[   20.856934] EXT4-fs (dm-1): re-mounted. Opts: errors=3Dremount-ro
[   20.861714] systemd[1]: Mounted Huge Pages File System.
[   20.864547] systemd[1]: Mounted POSIX Message Queue File System.
[   20.868636] systemd[1]: proc-fs-nfsd.mount: Mount process exited, code=
=3Dexited, status=3D32/n/a
[   20.868639] systemd[1]: proc-fs-nfsd.mount: Failed with result 'exit-cod=
e'.
[   20.868929] systemd[1]: Failed to mount NFSD configuration filesystem.
[   20.876350] systemd[1]: Dependency failed for NFS Mount Daemon.
[   20.880477] systemd[1]: Dependency failed for NFS server and services.
[   20.882466] systemd[1]: Dependency failed for NFSv4 ID-name mapping serv=
ice.
[   20.886548] systemd[1]: nfs-idmapd.service: Job nfs-idmapd.service/start=
 failed with result 'dependency'.
[   20.888404] systemd[1]: nfs-server.service: Job nfs-server.service/start=
 failed with result 'dependency'.
[   20.888409] systemd[1]: nfs-mountd.service: Job nfs-mountd.service/start=
 failed with result 'dependency'.
[   20.888514] systemd[1]: run-rpc_pipefs.mount: Mount process exited, code=
=3Dexited, status=3D32/n/a
[   20.894133] systemd[1]: run-rpc_pipefs.mount: Failed with result 'exit-c=
ode'.
[   20.894405] systemd[1]: Failed to mount RPC Pipe File System.
[   20.900299] systemd[1]: Dependency failed for RPC security service for N=
FS server.
[   20.902253] systemd[1]: rpc-svcgssd.service: Job rpc-svcgssd.service/sta=
rt failed with result 'dependency'.
[   20.902258] systemd[1]: Dependency failed for RPC security service for N=
FS client and server.
[   20.908600] systemd[1]: rpc-gssd.service: Job rpc-gssd.service/start fai=
led with result 'dependency'.
[   20.910461] systemd[1]: Dependency failed for pNFS block layout mapping =
daemon.
[   20.912363] systemd[1]: nfs-blkmap.service: Job nfs-blkmap.service/start=
 failed with result 'dependency'.
[   20.912495] systemd[1]: Mounted Kernel Debug File System.
[   20.918673] systemd[1]: Mounted Kernel Trace File System.
[   20.923091] systemd[1]: Finished Set the console keyboard layout.
[   20.927211] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   20.931245] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   20.935448] systemd[1]: Finished Load Kernel Modules.
[   20.939703] systemd[1]: Finished Remount Root and Kernel File Systems.
[   20.943958] systemd[1]: Reached target NFS client services.
[   20.947809] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   20.947853] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   20.950992] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   20.955816] systemd[1]: Condition check resulted in Platform Persistent =
Storage Archival being skipped.
[   20.956362] systemd[1]: Starting Load/Save Random Seed...
[   20.962692] systemd[1]: Starting Apply Kernel Variables...
[   20.967467] systemd[1]: Starting Create System Users...
[   20.971408] systemd[1]: Finished Load/Save Random Seed.
[   20.976001] systemd[1]: Finished Apply Kernel Variables.
[   20.984621] systemd[1]: Finished Create System Users.
[   20.987742] systemd[1]: Finished Coldplug All udev Devices.
[   20.992436] systemd[1]: Starting Helper to synchronize boot up for ifupd=
own...
[   20.996689] systemd[1]: Starting Create Static Device Nodes in /dev...
[   21.009236] systemd[1]: Finished Create Static Device Nodes in /dev.
[   21.012210] systemd[1]: Reached target Local File Systems (Pre).
[   21.016082] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   21.016095] systemd[1]: Reached target Containers.
[   21.024579] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   21.080251] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[   21.082998] systemd[1]: Starting Show Plymouth Boot Screen...
[   21.096182] systemd[1]: Started Journal Service.
[   21.119463] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input9
[   21.122734] ACPI: Sleep Button [SLPB]
[   21.124911] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input10
[   21.127105] ACPI: Lid Switch [LID]
[   21.129901] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input11
[   21.133309] ACPI: Power Button [PWRF]
[   21.141918] tpm_tis IFX0763:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   21.161481] ACPI: AC Adapter [AC] (on-line)
[   21.169704] Non-volatile memory driver v1.3
[   21.175771] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   21.178411] thinkpad_acpi: http://ibm-acpi.sf.net/
[   21.182149] thinkpad_acpi: ThinkPad BIOS N22ET35W (1.12 ), EC N22HT22W
[   21.185426] thinkpad_acpi: Lenovo ThinkPad T480s, model 20L70053GE
[   21.190336] thinkpad_acpi: radio switch found; radios are enabled
[   21.190343] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[   21.190343] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[   21.191851] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[   21.192498] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[   21.199140] thinkpad_acpi: Standard ACPI backlight interface available, =
not loading native one
[   21.214347] thinkpad_acpi: volume: disabled as there is no ALSA support =
in this kernel
[   21.220420] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[   21.220424] battery: new extension: ThinkPad Battery Extension
[   21.220481] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input12
[   21.259514] mc: Linux media interface: v0.10
[   21.265695] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   21.269218] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   21.278751] videodev: Linux video capture interface: v2.00
[   21.282896] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   21.286256] intel_rapl_common: Found RAPL domain package
[   21.291068] intel_rapl_common: Found RAPL domain dram
[   21.293780] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THE=
RMAL_PCI
[   21.297375] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   21.333745] elan_i2c 1-0015: supply vcc not found, using dummy regulator
[   21.337968] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   21.341557] elan_i2c 1-0015: Elan Touchpad: Module ID: 0x0020, Firmware:=
 0x0001, Sample: 0x0000, IAP: 0x0000
[   21.343642] cfg80211: loaded regulatory.db is malformed or signature is =
missing/invalid
[   21.346083] input: Elan Touchpad as /devices/pci0000:00/0000:00:1f.4/i2c=
-1/1-0015/input/input13
[   21.350314] input: PC Speaker as /devices/platform/pcspkr/input/input15
[   21.350386] EFI Variables Facility v0.08 2004-May-17
[   21.350630] input: Elan TrackPoint as /devices/pci0000:00/0000:00:1f.4/i=
2c-1/1-0015/input/input14
[   21.397596] pstore: Using crash dump compression: deflate
[   21.397605] pstore: Registered efi as persistent store backend
[   21.417636] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   21.424349] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opt=
s: (null)
[   21.424354] ext2 filesystem being mounted at /boot supports timestamps u=
ntil 2038 (0x7fffffff)
[   21.448150] Intel(R) Wireless WiFi driver for Linux
[   21.448854] iwlwifi 0000:3d:00.0: enabling device (0000 -> 0002)
[   21.451864] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
36.ucode failed with error -2
[   21.451873] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
35.ucode failed with error -2
[   21.451879] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
34.ucode failed with error -2
[   21.451885] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
33.ucode failed with error -2
[   21.451891] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
32.ucode failed with error -2
[   21.456386] iwlwifi 0000:3d:00.0: loaded firmware version 31.532993.0 82=
65-31.ucode op_mode iwlmvm
[   21.456399] iwlwifi 0000:3d:00.0: Direct firmware load for iwl-debug-yoy=
o.bin failed with error -2
[   21.485759] iTCO_vendor_support: vendor-support=3D0
[   21.486428] uvcvideo: Found UVC 1.00 device Integrated IR Camera (04f2:b=
615)
[   21.491445] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   21.491445] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   21.504834] Bluetooth: Core ver 2.22
[   21.504845] NET: Registered protocol family 31
[   21.504845] Bluetooth: HCI device and connection manager initialized
[   21.504848] Bluetooth: HCI socket layer initialized
[   21.504849] Bluetooth: L2CAP socket layer initialized
[   21.504851] Bluetooth: SCO socket layer initialized
[   21.529074] uvcvideo 1-5:1.0: Entity type for entity Extension 6 was not=
 initialized!
[   21.529075] uvcvideo 1-5:1.0: Entity type for entity Extension 5 was not=
 initialized!
[   21.529076] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   21.529076] uvcvideo 1-5:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   21.529077] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   21.529078] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   21.529397] input: Integrated IR Camera: Integrate as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-5/1-5:1.0/input/input16
[   21.530379] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b614)
[   21.530379] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   21.530380] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   21.548441] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   21.548443] uvcvideo 1-8:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   21.548444] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   21.548445] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   21.548498] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-8/1-8:1.0/input/input17
[   21.548557] usbcore: registered new interface driver uvcvideo
[   21.548558] USB Video Class driver (1.1.1)
[   21.548834] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   21.548896] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   21.549135] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   21.550714] usbcore: registered new interface driver btusb
[   21.551560] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 20=
15
[   21.553830] Bluetooth: hci0: Device revision is 16
[   21.553831] Bluetooth: hci0: Secure boot is enabled
[   21.553832] Bluetooth: hci0: OTP lock is enabled
[   21.553832] Bluetooth: hci0: API lock is enabled
[   21.553832] Bluetooth: hci0: Debug lock is disabled
[   21.553833] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   21.559230] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[   21.580914] iwlwifi 0000:3d:00.0: Detected Intel(R) Dual Band Wireless A=
C 8265, REV=3D0x230
[   21.625766] resource sanity check: requesting [mem 0xfed10000-0xfed15fff=
], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
[   21.625773] caller snb_uncore_imc_init_box+0x6c/0xb0 [intel_uncore] mapp=
ing multiple BARs
[   21.632740] Adding 16531452k swap on /dev/mapper/linus--work--vg-swap_1.=
  Priority:-2 extents:1 across:16531452k SSFS
[   21.641877] intel_rapl_common: Found RAPL domain package
[   21.641878] intel_rapl_common: Found RAPL domain core
[   21.641879] intel_rapl_common: Found RAPL domain uncore
[   21.641879] intel_rapl_common: Found RAPL domain dram
[   21.643892] iwlwifi 0000:3d:00.0: base HW address: 7c:76:35:14:e6:d7
[   21.721460] iwlwifi 0000:3d:00.0: iwlmvm doesn't allow to disable BT Coe=
x, check bt_coex_active module parameter
[   21.721568] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   21.721796] thermal thermal_zone6: failed to read out thermal zone (-61)
[   21.754354] iwlwifi 0000:3d:00.0 wlp61s0: renamed from wlan0
[   21.789820] intel_pmc_core intel_pmc_core.0:  initialized
[   22.162580] new mount options do not match the existing superblock, will=
 be ignored
[   22.443193] new mount options do not match the existing superblock, will=
 be ignored
[   22.637575] new mount options do not match the existing superblock, will=
 be ignored
[   22.872855] new mount options do not match the existing superblock, will=
 be ignored
[   22.984948] new mount options do not match the existing superblock, will=
 be ignored
[   22.987820] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   22.988633] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   22.990923] IPv6: ADDRCONF(NETDEV_CHANGE): veth3: link becomes ready
[   23.000464] br0: port 1(enp0s31f6) entered blocking state
[   23.001279] br0: port 1(enp0s31f6) entered disabled state
[   23.002131] device enp0s31f6 entered promiscuous mode
[   23.097170] Bluetooth: hci0: Waiting for firmware download to complete
[   23.098024] Bluetooth: hci0: Firmware loaded in 1511042 usecs
[   23.098903] Bluetooth: hci0: Waiting for device to boot
[   23.110586] Bluetooth: hci0: Device booted in 11435 usecs
[   23.112040] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16=
=2Eddc
[   23.114631] Bluetooth: hci0: Applying Intel DDC parameters completed
[   23.116610] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   23.189488] br0: port 2(veth0) entered blocking state
[   23.189489] br0: port 2(veth0) entered disabled state
[   23.189532] device veth0 entered promiscuous mode
[   23.193651] br0: port 3(veth2) entered blocking state
[   23.193653] br0: port 3(veth2) entered disabled state
[   23.193695] device veth2 entered promiscuous mode
[   23.198679] br0: port 3(veth2) entered blocking state
[   23.198680] br0: port 3(veth2) entered forwarding state
[   23.198691] br0: port 2(veth0) entered blocking state
[   23.198692] br0: port 2(veth0) entered forwarding state
[   25.758008] i915 0000:00:02.0: [drm] not enough stolen space for compres=
sed buffer (need 58982400 more bytes), disabling. Hint: you may be able to =
increase stolen memory size in the BIOS to avoid this.
[   27.184727] ucsi_acpi USBC000:00: con1: failed to register alternate mod=
es
[   28.093179] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full=
 Duplex, Flow Control: Rx/Tx
[   28.093218] br0: port 1(enp0s31f6) entered blocking state
[   28.093220] br0: port 1(enp0s31f6) entered forwarding state
[   75.771993] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   75.771995] Bluetooth: BNEP filters: protocol multicast
[   75.771998] Bluetooth: BNEP socket layer initialized
[   75.775362] NET: Registered protocol family 38
[   82.325887] Bluetooth: RFCOMM TTY layer initialized
[   82.325893] Bluetooth: RFCOMM socket layer initialized
[   82.325897] Bluetooth: RFCOMM ver 1.11
[   93.319341] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input18
[  160.185474] wlp61s0: authenticate with 32:67:04:07:ac:80
[  160.199149] wlp61s0: send auth to 32:67:04:07:ac:80 (try 1/3)
[  160.206307] wlp61s0: authenticated
[  160.208825] wlp61s0: associate with 32:67:04:07:ac:80 (try 1/3)
[  160.212308] wlp61s0: RX AssocResp from 32:67:04:07:ac:80 (capab=3D0x421 =
status=3D0 aid=3D1)
[  160.229344] wlp61s0: associated
[  160.229447] IPv6: ADDRCONF(NETDEV_CHANGE): wlp61s0: link becomes ready
[  245.688331] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input19
[  245.917091] wlp61s0: Connection to AP 32:67:04:07:ac:80 lost
[  293.637252] general protection fault, probably for non-canonical address=
 0xe41ab26087c4a9c1: 0000 [#1] SMP PTI
[  293.637264] CPU: 5 PID: 3154 Comm: Xorg Kdump: loaded Tainted: G        =
    E     5.7.0+ #14
[  293.637268] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  293.637283] RIP: 0010:kmem_cache_alloc_trace+0x7e/0x220
[  293.637289] Code: 89 01 00 00 4d 8b 07 65 49 8b 50 08 65 4c 03 05 20 78 =
b9 68 4d 8b 20 4d 85 e4 0f 84 75 01 00 00 41 8b 47 20 49 8b 3f 4c 01 e0 <48=
> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c 89 e0 48 0f c9 48 31 cb
[  293.637293] RSP: 0018:ffffaf0140babd28 EFLAGS: 00010282
[  293.637299] RAX: e41ab26087c4a9c1 RBX: 0000000000000000 RCX: 00000000000=
00000
[  293.637303] RDX: 000000000000535e RSI: 0000000000000cc0 RDI: 00000000000=
2ff80
[  293.637306] RBP: 0000000000000cc0 R08: ffff9e856276ff80 R09: ffff9e8530a=
022b8
[  293.637309] R10: ffff9e8515b8fd78 R11: 00000000001029e8 R12: e41ab26087c=
4a9a1
[  293.637312] R13: 0000000000000028 R14: ffff9e8207c07640 R15: ffff9e8207c=
07640
[  293.637317] FS:  00007fac50415580(0000) GS:ffff9e8562740000(0000) knlGS:=
0000000000000000
[  293.637321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  293.637324] CR2: 00007fac3e57d000 CR3: 000000044b44a005 CR4: 00000000003=
606e0
[  293.637327] Call Trace:
[  293.637390]  ? drm_vma_node_allow+0x27/0xd0 [drm]
[  293.637433]  drm_vma_node_allow+0x27/0xd0 [drm]
[  293.637559]  __assign_mmap_offset+0xee/0x320 [i915]
[  293.637667]  ? i915_gem_dumb_mmap_offset+0x40/0x40 [i915]
[  293.637705]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[  293.637740]  drm_ioctl+0x206/0x390 [drm]
[  293.637842]  ? i915_gem_dumb_mmap_offset+0x40/0x40 [i915]
[  293.637851]  ? do_setitimer+0x179/0x220
[  293.637860]  ? __sys_recvmsg+0x85/0xa0
[  293.637868]  ksys_ioctl+0x82/0xc0
[  293.637876]  __x64_sys_ioctl+0x16/0x20
[  293.637884]  do_syscall_64+0x49/0xd0
[  293.637892]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  293.637899] RIP: 0033:0x7fac5085cc27
[  293.637905] Code: 00 00 00 48 8b 05 69 92 0c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 92 0c 00 f7 d8 64 89 01 48
[  293.637909] RSP: 002b:00007ffce29569a8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  293.637914] RAX: ffffffffffffffda RBX: 00007ffce29569b0 RCX: 00007fac508=
5cc27
[  293.637917] RDX: 00007ffce29569b0 RSI: 00000000c0206464 RDI: 00000000000=
00013
[  293.637920] RBP: 0000000000000013 R08: 0000000000000000 R09: 0000563a262=
9aee0
[  293.637924] R10: 0000fffef9505000 R11: 0000000000000246 R12: 0000563a262=
be6a0
[  293.637927] R13: 00000000c0206464 R14: 0000563a255648c0 R15: 00000000000=
01000
[  293.637932] Modules linked in: uinput(E) rfcomm(E) cmac(E) algif_hash(E)=
 algif_skcipher(E) af_alg(E) bnep(E) typec_displayport(E) bridge(E) stp(E) =
llc(E) veth(E) intel_pmc_core_pltdrv(E) intel_pmc_core(E) binfmt_misc(E) in=
tel_rapl_msr(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) intel_cstate(E)=
 intel_uncore(E) nls_ascii(E) iwlmvm(E) btusb(E) iTCO_wdt(E) btrtl(E) btbcm=
(E) intel_pmc_bxt(E) nls_cp437(E) btintel(E) vfat(E) mac80211(E) libarc4(E)=
 fat(E) bluetooth(E) iTCO_vendor_support(E) iwlwifi(E) uvcvideo(E) efi_psto=
re(E) videobuf2_vmalloc(E) videobuf2_memops(E) jitterentropy_rng(E) videobu=
f2_v4l2(E) serio_raw(E) efivars(E) pcspkr(E) wmi_bmof(E) intel_wmi_thunderb=
olt(E) watchdog(E) elan_i2c(E) videobuf2_common(E) drbg(E) cfg80211(E) ansi=
_cprng(E) videodev(E) ecdh_generic(E) mei_me(E) joydev(E) processor_thermal=
_device(E) mc(E) thunderbolt(E) ecc(E) ucsi_acpi(E) mei(E) intel_pch_therma=
l(E) intel_rapl_common(E) typec_ucsi(E) thinkpad_acpi(E) intel_soc_dts_iosf=
(E) typec(E) tpm_crb(E) nvram(E)
[  293.637996]  ledtrig_audio(E) int3403_thermal(E) rfkill(E) ac(E) int340x=
_thermal_zone(E) tpm_tis(E) evdev(E) tpm_tis_core(E) tpm(E) int3400_thermal=
(E) acpi_thermal_rel(E) rng_core(E) acpi_pad(E) button(E) coretemp(E) efiva=
rfs(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) hid=
_lenovo(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E) async_raid6_recov(E) =
async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E) raid6_pq(E) lib=
crc32c(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) hid_generic(E)=
 usbhid(E) hid(E) crc32_pclmul(E) crc32c_intel(E) i915(E) i2c_algo_bit(E) g=
hash_clmulni_intel(E) drm_kms_helper(E) e1000e(E) cec(E) nvme(E) xhci_pci(E=
) aesni_intel(E) nvme_core(E) libaes(E) xhci_hcd(E) t10_pi(E) i2c_i801(E) p=
tp(E) crc_t10dif(E) crypto_simd(E) psmouse(E) cryptd(E) crct10dif_generic(E=
) glue_helper(E) intel_lpss_pci(E) pps_core(E) crct10dif_pclmul(E) crct10di=
f_common(E) intel_lpss(E) drm(E) usbcore(E) idma64(E) wmi(E) battery(E) vid=
eo(E)
[  293.638071] ---[ end trace 9b7ccc835b20a82e ]---
[  293.798533] RIP: 0010:kmem_cache_alloc_trace+0x7e/0x220
[  293.798537] Code: 89 01 00 00 4d 8b 07 65 49 8b 50 08 65 4c 03 05 20 78 =
b9 68 4d 8b 20 4d 85 e4 0f 84 75 01 00 00 41 8b 47 20 49 8b 3f 4c 01 e0 <48=
> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c 89 e0 48 0f c9 48 31 cb
[  293.798538] RSP: 0018:ffffaf0140babd28 EFLAGS: 00010282
[  293.798539] RAX: e41ab26087c4a9c1 RBX: 0000000000000000 RCX: 00000000000=
00000
[  293.798540] RDX: 000000000000535e RSI: 0000000000000cc0 RDI: 00000000000=
2ff80
[  293.798540] RBP: 0000000000000cc0 R08: ffff9e856276ff80 R09: ffff9e8530a=
022b8
[  293.798541] R10: ffff9e8515b8fd78 R11: 00000000001029e8 R12: e41ab26087c=
4a9a1
[  293.798541] R13: 0000000000000028 R14: ffff9e8207c07640 R15: ffff9e8207c=
07640
[  293.798542] FS:  00007fac50415580(0000) GS:ffff9e8562740000(0000) knlGS:=
0000000000000000
[  293.798543] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  293.798544] CR2: 00007fac3e57d000 CR3: 000000044b44a005 CR4: 00000000003=
606e0
[  293.798545] Kernel panic - not syncing: Fatal exception
[  293.799545] Kernel Offset: 0x16200000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)


# dmesg 4/5

[    0.000000] Linux version 5.9.0-1-amd64 (debian-kernel@lists.debian.org)=
 (gcc-10 (Debian 10.2.0-15) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1=
) #1 SMP Debian 5.9.1-1 (2020-10-17)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64 root=3D/de=
v/mapper/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G-:512M
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000074f9cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000074f9d000-0x0000000074f9dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000074f9e000-0x0000000074f9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000074f9f000-0x000000007e8f7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e8f8000-0x000000007e9bdfff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007e9be000-0x000000007ff2bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ff2c000-0x000000007ff99fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007ff9a000-0x000000007fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x0000000087ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000088600000-0x000000008c7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004727fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=3D0x7ff92000 SMBIOS=3D0x7f052000 SMBIOS 3.0=
=3D0x7f04f000 ACPI=3D0x7fffe000 ACPI 2.0=3D0x7fffe014 ESRT=3D0x7eeca000 MEM=
ATTR=3D0x7971d298=20
[    0.000000] secureboot: Secure boot could not be determined (mode 0)
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (1.12 ) 04/=
09/2018
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.001016] tsc: Detected 1999.968 MHz TSC
[    0.001016] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001019] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001027] last_pfn =3D 0x472800 max_arch_pfn =3D 0x400000000
[    0.001031] MTRR default type: write-back
[    0.001032] MTRR fixed ranges enabled:
[    0.001033]   00000-9FFFF write-back
[    0.001034]   A0000-BFFFF uncachable
[    0.001035]   C0000-FFFFF write-protect
[    0.001036] MTRR variable ranges enabled:
[    0.001038]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001039]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001040]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001041]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.001042]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.001042]   5 disabled
[    0.001043]   6 disabled
[    0.001044]   7 disabled
[    0.001044]   8 disabled
[    0.001045]   9 disabled
[    0.001718] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001954] last_pfn =3D 0x80000 max_arch_pfn =3D 0x400000000
[    0.018655] esrt: Reserving ESRT space from 0x000000007eeca000 to 0x0000=
00007eeca088.
[    0.018663] kexec: Reserving the low 1M of memory for crashkernel
[    0.018667] Using GB pages for direct mapping
[    0.019287] RAMDISK: [mem 0x3161d000-0x34b05fff]
[    0.019293] ACPI: Early table checksum verification disabled
[    0.019296] ACPI: RSDP 0x000000007FFFE014 000024 (v02 LENOVO)
[    0.019300] ACPI: XSDT 0x000000007FFAD188 000124 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019306] ACPI: FACP 0x000000007FFE1000 0000F4 (v05 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019312] ACPI: DSDT 0x000000007FFBB000 0218A6 (v02 LENOVO SKL      00=
000000 INTL 20160527)
[    0.019315] ACPI: FACS 0x000000007FF3D000 000040
[    0.019318] ACPI: SSDT 0x000000007FFE9000 01320E (v02 LENOVO DptfTabl 00=
001000 INTL 20160527)
[    0.019321] ACPI: SSDT 0x000000007FFE8000 0003DB (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20160527)
[    0.019324] ACPI: TPM2 0x000000007FFE7000 000034 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019327] ACPI: UEFI 0x000000007FF53000 000042 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019331] ACPI: SSDT 0x000000007FFE3000 0030A3 (v02 LENOVO SaSsdt   00=
003000 INTL 20160527)
[    0.019334] ACPI: SSDT 0x000000007FFE2000 0005C6 (v02 LENOVO PerfTune 00=
001000 INTL 20160527)
[    0.019337] ACPI: HPET 0x000000007FFE0000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019340] ACPI: APIC 0x000000007FFDF000 00012C (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019343] ACPI: MCFG 0x000000007FFDE000 00003C (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019346] ACPI: ECDT 0x000000007FFDD000 000053 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019349] ACPI: SSDT 0x000000007FFB9000 001C9C (v02 LENOVO RVP7Rtd3 00=
001000 INTL 20160527)
[    0.019352] ACPI: SSDT 0x000000007FFB7000 00163C (v02 LENOVO ProjSsdt 00=
000010 INTL 20160527)
[    0.019355] ACPI: BOOT 0x000000007FFB6000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019358] ACPI: BATB 0x000000007FFB5000 00004A (v02 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019361] ACPI: SLIC 0x000000007FFB4000 000176 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019364] ACPI: SSDT 0x000000007FFB2000 0017AE (v02 LENOVO CpuSsdt  00=
003000 INTL 20160527)
[    0.019368] ACPI: SSDT 0x000000007FFB1000 00056D (v02 LENOVO CtdpB    00=
001000 INTL 20160527)
[    0.019371] ACPI: SSDT 0x000000007FFB0000 000678 (v02 LENOVO UsbCTabl 00=
001000 INTL 20160527)
[    0.019374] ACPI: LPIT 0x000000007FFAF000 000094 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019377] ACPI: WSMT 0x000000007FFAE000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019380] ACPI: SSDT 0x000000007FFFD000 0001D8 (v02 LENOVO HdaDsp   00=
000000 INTL 20160527)
[    0.019383] ACPI: SSDT 0x000000007FFAC000 0004FC (v02 LENOVO TbtTypeC 00=
000000 INTL 20160527)
[    0.019386] ACPI: SSDT 0x000000007FFAB000 0002D1 (v02 LENOVO Wwan     00=
000001 INTL 20160527)
[    0.019389] ACPI: DBGP 0x000000007FFAA000 000034 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019392] ACPI: DBG2 0x000000007FFA9000 000054 (v00 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019395] ACPI: MSDM 0x000000007FFA8000 000055 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019399] ACPI: DMAR 0x000000007FFA7000 0000CC (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019402] ACPI: ASF! 0x000000007FFA6000 0000A0 (v32 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019405] ACPI: FPDT 0x000000007FFA5000 000044 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019408] ACPI: BGRT 0x000000007FFA4000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019411] ACPI: UEFI 0x000000007FF3A000 00013E (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019419] ACPI: Local APIC address 0xfee00000
[    0.019522] No NUMA configuration found
[    0.019523] Faking a node at [mem 0x0000000000000000-0x00000004727fffff]
[    0.019527] NODE_DATA(0) allocated [mem 0x4727fb000-0x4727fffff]
[    0.019547] Reserving 512MB of memory at 1280MB for crashkernel (System =
RAM: 16144MB)
[    0.019578] Zone ranges:
[    0.019579]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.019580]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.019582]   Normal   [mem 0x0000000100000000-0x00000004727fffff]
[    0.019583]   Device   empty
[    0.019584] Movable zone start for each node
[    0.019585] Early memory node ranges
[    0.019586]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.019587]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.019588]   node   0: [mem 0x0000000000100000-0x0000000074f9cfff]
[    0.019589]   node   0: [mem 0x0000000074f9f000-0x000000007e8f7fff]
[    0.019590]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.019591]   node   0: [mem 0x0000000100000000-0x00000004727fffff]
[    0.019883] Zeroed struct page in unavailable ranges: 28526 pages
[    0.019885] Initmem setup node 0 [mem 0x0000000000001000-0x00000004727ff=
fff]
[    0.019887] On node 0 totalpages: 4133010
[    0.019888]   DMA zone: 64 pages used for memmap
[    0.019889]   DMA zone: 155 pages reserved
[    0.019890]   DMA zone: 3995 pages, LIFO batch:0
[    0.019933]   DMA32 zone: 8036 pages used for memmap
[    0.019934]   DMA32 zone: 514295 pages, LIFO batch:63
[    0.025573]   Normal zone: 56480 pages used for memmap
[    0.025574]   Normal zone: 3614720 pages, LIFO batch:63
[    0.025953] Reserving Intel graphics memory at [mem 0x8a800000-0x8c7ffff=
f]
[    0.026322] ACPI: PM-Timer IO Port: 0x1808
[    0.026324] ACPI: Local APIC address 0xfee00000
[    0.026332] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.026333] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.026334] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.026335] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.026335] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.026336] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.026337] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.026337] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.026338] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.026339] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.026339] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.026340] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.026341] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.026341] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.026342] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.026343] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.026373] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.026376] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026377] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.026379] ACPI: IRQ0 used by override.
[    0.026380] ACPI: IRQ9 used by override.
[    0.026383] Using ACPI (MADT) for SMP configuration information
[    0.026385] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.026392] e820: update [mem 0x783d7000-0x784d6fff] usable =3D=3D> rese=
rved
[    0.026402] TSC deadline timer available
[    0.026403] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.026424] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.026426] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.026428] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x000fffff]
[    0.026430] PM: hibernation: Registered nosave memory: [mem 0x74f9d000-0=
x74f9dfff]
[    0.026431] PM: hibernation: Registered nosave memory: [mem 0x74f9e000-0=
x74f9efff]
[    0.026433] PM: hibernation: Registered nosave memory: [mem 0x783d7000-0=
x784d6fff]
[    0.026434] PM: hibernation: Registered nosave memory: [mem 0x7e8f8000-0=
x7e9bdfff]
[    0.026435] PM: hibernation: Registered nosave memory: [mem 0x7e9be000-0=
x7ff2bfff]
[    0.026436] PM: hibernation: Registered nosave memory: [mem 0x7ff2c000-0=
x7ff99fff]
[    0.026437] PM: hibernation: Registered nosave memory: [mem 0x7ff9a000-0=
x7fffefff]
[    0.026439] PM: hibernation: Registered nosave memory: [mem 0x80000000-0=
x87ffffff]
[    0.026439] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x885fffff]
[    0.026440] PM: hibernation: Registered nosave memory: [mem 0x88600000-0=
x8c7fffff]
[    0.026441] PM: hibernation: Registered nosave memory: [mem 0x8c800000-0=
xf7ffffff]
[    0.026441] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.026442] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfe00ffff]
[    0.026443] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0=
xfe010fff]
[    0.026443] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    0.026445] [mem 0x8c800000-0xf7ffffff] available for PCI devices
[    0.026447] Booting paravirtualized kernel on bare hardware
[    0.026449] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.033060] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.033325] percpu: Embedded 55 pages/cpu s184920 r8192 d32168 u262144
[    0.033333] pcpu-alloc: s184920 r8192 d32168 u262144 alloc=3D1*2097152
[    0.033334] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.033361] Built 1 zonelists, mobility grouping on.  Total pages: 40682=
75
[    0.033362] Policy zone: Normal
[    0.033363] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64 roo=
t=3D/dev/mapper/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G=
-:512M
[    0.034781] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.035417] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.035516] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.057387] Memory: 1494204K/16532040K available (12291K kernel code, 13=
19K rwdata, 3764K rodata, 1636K init, 1752K bss, 1023360K reserved, 0K cma-=
reserved)
[    0.057396] random: get_random_u64 called from __kmem_cache_create+0x2e/=
0x540 with crng_init=3D0
[    0.057563] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.057575] Kernel/User page tables isolation: enabled
[    0.057599] ftrace: allocating 34815 entries in 136 pages
[    0.074947] ftrace: allocated 136 pages with 2 groups
[    0.075093] rcu: Hierarchical RCU implementation.
[    0.075095] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D8.
[    0.075096] 	Rude variant of Tasks RCU enabled.
[    0.075097] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.075097] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.079573] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.079967] random: crng done (trusting CPU's manufacturer)
[    0.079996] Console: colour dummy device 80x25
[    0.080001] printk: console [tty0] enabled
[    0.080023] ACPI: Core revision 20200717
[    0.080507] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    0.080576] APIC: Switch to symmetric I/O mode setup
[    0.080579] DMAR: Host address width 39
[    0.080580] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.080587] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.080589] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.080594] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.080595] DMAR: RMRR base: 0x0000007f47f000 end: 0x0000007f49efff
[    0.080596] DMAR: RMRR base: 0x0000008a000000 end: 0x0000008c7fffff
[    0.080598] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.080600] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.080601] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.080602] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.082211] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082213] x2apic enabled
[    0.082226] Switched APIC routing to cluster x2apic.
[    0.086335] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.104453] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x39a8208cdd2, max_idle_ns: 881590748921 ns
[    0.104458] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3999.93 BogoMIPS (lpj=3D7999872)
[    0.104461] pid_max: default: 32768 minimum: 301
[    0.108489] LSM: Security Framework initializing
[    0.108497] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.108530] AppArmor: AppArmor initialized
[    0.108532] TOMOYO Linux initialized
[    0.108582] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.108631] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.108972] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.109005] process: using mwait in idle threads
[    0.109008] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.109009] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.109012] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.109014] Spectre V2 : Mitigation: Full generic retpoline
[    0.109015] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.109016] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.109017] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.109018] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.109019] Speculative Store Bypass: Vulnerable
[    0.109021] SRBDS: Vulnerable: No microcode
[    0.109022] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.109291] Freeing SMP alternatives memory: 32K
[    0.112556] smpboot: CPU0: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xa)
[    0.112717] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112730] ... version:                4
[    0.112731] ... bit width:              48
[    0.112731] ... generic registers:      4
[    0.112732] ... value mask:             0000ffffffffffff
[    0.112733] ... max period:             00007fffffffffff
[    0.112733] ... fixed-purpose events:   3
[    0.112734] ... event mask:             000000070000000f
[    0.112787] rcu: Hierarchical SRCU implementation.
[    0.113598] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.113694] smp: Bringing up secondary CPUs ...
[    0.113797] x86: Booting SMP configuration:
[    0.113798] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.117327] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.117327]  #5 #6 #7
[    0.117327] smp: Brought up 1 node, 8 CPUs
[    0.117327] smpboot: Max logical packages: 1
[    0.117327] smpboot: Total of 8 processors activated (31999.48 BogoMIPS)
[    0.148528] node 0 deferred pages initialised in 28ms
[    0.148886] devtmpfs: initialized
[    0.148886] x86/mm: Memory block size: 128MB
[    0.149978] PM: Registering ACPI NVS region [mem 0x74f9d000-0x74f9dfff] =
(4096 bytes)
[    0.149978] PM: Registering ACPI NVS region [mem 0x7ff2c000-0x7ff99fff] =
(450560 bytes)
[    0.149978] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.149978] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.149978] pinctrl core: initialized pinctrl subsystem
[    0.149978] NET: Registered protocol family 16
[    0.149978] audit: initializing netlink subsys (disabled)
[    0.149978] audit: type=3D2000 audit(1604761895.068:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.149978] thermal_sys: Registered thermal governor 'fair_share'
[    0.149978] thermal_sys: Registered thermal governor 'bang_bang'
[    0.149978] thermal_sys: Registered thermal governor 'step_wise'
[    0.149978] thermal_sys: Registered thermal governor 'user_space'
[    0.149978] cpuidle: using governor ladder
[    0.149978] cpuidle: using governor menu
[    0.149978] Simple Boot Flag at 0x47 set to 0x1
[    0.149978] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.149978] ACPI: bus type PCI registered
[    0.149978] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.149978] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.149978] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.149978] PCI: Using configuration type 1 for base access
[    0.152585] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.153682] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.153682] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.349049] ACPI: Added _OSI(Module Device)
[    0.349049] ACPI: Added _OSI(Processor Device)
[    0.349049] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.349049] ACPI: Added _OSI(Processor Aggregator Device)
[    0.349049] ACPI: Added _OSI(Linux-Dell-Video)
[    0.349049] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.349049] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.415453] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.421125] ACPI: EC: EC started
[    0.421126] ACPI: EC: interrupt blocked
[    0.423526] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.423527] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.425617] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.497475] ACPI: Dynamic OEM Table Load:
[    0.497492] ACPI: SSDT 0xFFFF969287725800 0005CD (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.499324] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.500803] ACPI: Dynamic OEM Table Load:
[    0.500814] ACPI: SSDT 0xFFFF969415977000 0003FF (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.502644] ACPI: Dynamic OEM Table Load:
[    0.502653] ACPI: SSDT 0xFFFF9695CFD5C9C0 0000BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.504330] ACPI: Dynamic OEM Table Load:
[    0.504339] ACPI: SSDT 0xFFFF969287725000 000628 (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.506513] ACPI: Dynamic OEM Table Load:
[    0.506526] ACPI: SSDT 0xFFFF96941597D000 000D14 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.509165] ACPI: Dynamic OEM Table Load:
[    0.509174] ACPI: SSDT 0xFFFF969415970C00 000317 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.511049] ACPI: Dynamic OEM Table Load:
[    0.511057] ACPI: SSDT 0xFFFF969415975C00 00030A (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.516417] ACPI: Interpreter enabled
[    0.516494] ACPI: (supports S0 S3 S4 S5)
[    0.516497] ACPI: Using IOAPIC for interrupt routing
[    0.516551] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.517438] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.522349] ACPI: Power Resource [PUBS] (on)
[    0.548791] ACPI: Power Resource [PXP] (on)
[    0.570533] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.570540] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.573416] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.575011] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR]
[    0.575012] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.577797] PCI host bridge to bus 0000:00
[    0.577800] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.577801] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.577803] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.577804] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]
[    0.577805] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    0.577806] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]
[    0.577808] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]
[    0.577809] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]
[    0.577810] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]
[    0.577811] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]
[    0.577812] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]
[    0.577813] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]
[    0.577814] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]
[    0.577816] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]
[    0.577817] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]
[    0.577818] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ffff=
f window]
[    0.577819] pci_bus 0000:00: root bus resource [mem 0x8c800000-0xf7fffff=
f window]
[    0.577820] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    0.577822] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.577840] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.578994] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.579008] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.579016] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.579022] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.579044] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.580226] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.580239] pci 0000:00:04.0: reg 0x10: [mem 0xe8240000-0xe8247fff 64bit]
[    0.581508] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.581522] pci 0000:00:08.0: reg 0x10: [mem 0xe8250000-0xe8250fff 64bit]
[    0.582712] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.582733] pci 0000:00:14.0: reg 0x10: [mem 0xe8220000-0xe822ffff 64bit]
[    0.582812] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.584116] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.584135] pci 0000:00:14.2: reg 0x10: [mem 0xe8251000-0xe8251fff 64bit]
[    0.585481] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.585688] pci 0000:00:15.0: reg 0x10: [mem 0xe8252000-0xe8252fff 64bit]
[    0.587744] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.587766] pci 0000:00:16.0: reg 0x10: [mem 0xe8253000-0xe8253fff 64bit]
[    0.587841] pci 0000:00:16.0: PME# supported from D3hot
[    0.589095] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.590263] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.591500] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.592660] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.592679] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround ena=
bled
[    0.593916] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.594006] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.594027] pci 0000:00:1c.6: Intel SPT PCH root port ACS workaround ena=
bled
[    0.595261] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.595366] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.595389] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround ena=
bled
[    0.596651] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.597971] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.597986] pci 0000:00:1f.2: reg 0x10: [mem 0xe824c000-0xe824ffff]
[    0.599235] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.599261] pci 0000:00:1f.3: reg 0x10: [mem 0xe8248000-0xe824bfff 64bit]
[    0.599298] pci 0000:00:1f.3: reg 0x20: [mem 0xe8230000-0xe823ffff 64bit]
[    0.599357] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.600631] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.600683] pci 0000:00:1f.4: reg 0x10: [mem 0xe8254000-0xe82540ff 64bit]
[    0.600734] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.602001] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.602021] pci 0000:00:1f.6: reg 0x10: [mem 0xe8200000-0xe821ffff]
[    0.602134] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.603390] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.603482] pci 0000:04:00.0: [8086:15c0] type 01 class 0x060400
[    0.603540] pci 0000:04:00.0: enabling Extended Tags
[    0.603634] pci 0000:04:00.0: supports D1 D2
[    0.603635] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.603806] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.603811] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.603817] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.603899] pci 0000:05:00.0: [8086:15c0] type 01 class 0x060400
[    0.603961] pci 0000:05:00.0: enabling Extended Tags
[    0.604055] pci 0000:05:00.0: supports D1 D2
[    0.604056] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604194] pci 0000:05:01.0: [8086:15c0] type 01 class 0x060400
[    0.604256] pci 0000:05:01.0: enabling Extended Tags
[    0.604354] pci 0000:05:01.0: supports D1 D2
[    0.604355] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604484] pci 0000:05:02.0: [8086:15c0] type 01 class 0x060400
[    0.604545] pci 0000:05:02.0: enabling Extended Tags
[    0.604639] pci 0000:05:02.0: supports D1 D2
[    0.604640] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.604806] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.604815] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.604822] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.604896] pci 0000:06:00.0: [8086:15bf] type 00 class 0x088000
[    0.604919] pci 0000:06:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.604932] pci 0000:06:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.604999] pci 0000:06:00.0: enabling Extended Tags
[    0.605111] pci 0000:06:00.0: supports D1 D2
[    0.605112] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605287] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.605297] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.605350] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.605360] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.605366] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.605455] pci 0000:3c:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.605479] pci 0000:3c:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.605564] pci 0000:3c:00.0: enabling Extended Tags
[    0.605679] pci 0000:3c:00.0: supports D1 D2
[    0.605680] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.605773] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.605891] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.605900] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.606381] pci 0000:3d:00.0: [8086:24fd] type 00 class 0x028000
[    0.606418] pci 0000:3d:00.0: reg 0x10: [mem 0xe8100000-0xe8101fff 64bit]
[    0.607020] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    0.607772] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.607777] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.608030] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.608054] pci 0000:3e:00.0: reg 0x10: [mem 0xe8000000-0xe8003fff 64bit]
[    0.608495] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.608500] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.611673] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611739] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.611802] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611864] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611925] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.611986] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.612047] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.612108] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.612991] ACPI: EC: interrupt unblocked
[    0.612992] ACPI: EC: event unblocked
[    0.613004] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.613005] ACPI: EC: GPE=3D0x16
[    0.613007] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.613008] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.613114] iommu: Default domain type: Translated=20
[    0.613135] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.613135] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.613135] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.613135] vgaarb: loaded
[    0.613135] EDAC MC: Ver: 3.0.0
[    0.613178] Registered efivars operations
[    0.613178] NetLabel: Initializing
[    0.613178] NetLabel:  domain hash size =3D 128
[    0.613178] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.613178] NetLabel:  unlabeled traffic allowed by default
[    0.613178] PCI: Using ACPI for IRQ routing
[    0.616692] PCI: pci_cache_line_size set to 64 bytes
[    0.617781] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.617783] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.617784] e820: reserve RAM buffer [mem 0x74f9d000-0x77ffffff]
[    0.617785] e820: reserve RAM buffer [mem 0x783d7000-0x7bffffff]
[    0.617786] e820: reserve RAM buffer [mem 0x7e8f8000-0x7fffffff]
[    0.617787] e820: reserve RAM buffer [mem 0x472800000-0x473ffffff]
[    0.617817] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.617821] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.619866] clocksource: Switched to clocksource tsc-early
[    0.629371] VFS: Disk quotas dquot_6.6.0
[    0.629388] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.629541] AppArmor: AppArmor Filesystem Enabled
[    0.629559] pnp: PnP ACPI init
[    0.629815] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.629817] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.629818] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.629820] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.629822] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.629823] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.629825] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.629832] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630291] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.630295] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.630877] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.630879] system 00:02: [io  0xffff] has been reserved
[    0.630880] system 00:02: [io  0xffff] has been reserved
[    0.630881] system 00:02: [io  0xffff] has been reserved
[    0.630883] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.630884] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.630888] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.631031] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.631088] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.631092] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    0.631118] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.631136] pnp 00:06: Plug and Play ACPI device, IDs LEN008f PNP0f13 (a=
ctive)
[    0.631274] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.631275] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.631277] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.631278] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.631280] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.631281] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.631282] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.631284] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.631286] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.631288] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.631289] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.631291] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.631293] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.631295] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.631297] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.631298] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.631300] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.631301] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.631303] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.631304] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.631309] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.633140] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.633141] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.633143] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.633147] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.634374] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.634376] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.634377] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.634379] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.634380] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.634382] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.634384] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.634385] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.634387] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.634388] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.634393] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.634733] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.634735] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.634737] system 00:0a: [mem 0x00100000-0x8c7fffff] could not be reser=
ved
[    0.634739] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.634740] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.634744] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.634925] pnp: PnP ACPI: found 11 devices
[    0.640963] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.641037] NET: Registered protocol family 2
[    0.641203] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.641328] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.641593] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.641696] TCP: Hash tables configured (established 131072 bind 65536)
[    0.641753] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.641816] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.641897] NET: Registered protocol family 1
[    0.641902] NET: Registered protocol family 44
[    0.641912] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    0.641914] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.641916] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    0.641919] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus =
07-3b] add_size 1000
[    0.641922] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus =
05-3c] add_size 1000
[    0.641924] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
04-3c] add_size 2000
[    0.641936] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8c800000-0x8c9ffff=
f]
[    0.641948] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8ca00000-0x8cbffff=
f 64bit pref]
[    0.641952] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.641954] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x4fff]
[    0.641957] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.641961] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.641966] pci 0000:00:1c.0:   bridge window [mem 0x8c800000-0x8c9fffff]
[    0.641969] pci 0000:00:1c.0:   bridge window [mem 0x8ca00000-0x8cbfffff=
 64bit pref]
[    0.641975] pci 0000:04:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.641977] pci 0000:05:01.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.641979] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.641985] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.641994] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.641997] pci 0000:05:01.0:   bridge window [io  0x3000-0x3fff]
[    0.642002] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.642006] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.642013] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.642018] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.642028] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.642030] pci 0000:04:00.0:   bridge window [io  0x3000-0x3fff]
[    0.642035] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.642039] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.642045] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.642047] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.642051] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.642054] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.642059] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.642063] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.642069] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.642075] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.642083] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.642085] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.642086] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.642087] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.642088] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.642089] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.642091] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.642092] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.642093] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.642094] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.642095] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.642096] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.642098] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.642099] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.642100] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.642101] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.642102] pci_bus 0000:00: resource 20 [mem 0x8c800000-0xf7ffffff wind=
ow]
[    0.642104] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.642105] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.642107] pci_bus 0000:01: resource 1 [mem 0x8c800000-0x8c9fffff]
[    0.642108] pci_bus 0000:01: resource 2 [mem 0x8ca00000-0x8cbfffff 64bit=
 pref]
[    0.642109] pci_bus 0000:04: resource 0 [io  0x3000-0x4fff]
[    0.642110] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.642111] pci_bus 0000:04: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.642113] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.642114] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.642115] pci_bus 0000:05: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.642116] pci_bus 0000:06: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.642118] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.642119] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.642120] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.642121] pci_bus 0000:3c: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.642123] pci_bus 0000:3d: resource 1 [mem 0xe8100000-0xe81fffff]
[    0.642124] pci_bus 0000:3e: resource 1 [mem 0xe8000000-0xe80fffff]
[    0.642288] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.642815] pci 0000:04:00.0: enabling device (0006 -> 0007)
[    0.643589] PCI: CLS 128 bytes, default 64
[    0.643636] Trying to unpack rootfs image as initramfs...
[    1.861882] Freeing initrd memory: 54180K
[    1.861934] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:1=
5.0
[    1.861950] DMAR: No ATSR found
[    1.862011] DMAR: dmar0: Using Queued invalidation
[    1.862014] DMAR: dmar1: Using Queued invalidation
[    1.862355] pci 0000:00:00.0: Adding to iommu group 0
[    1.862370] pci 0000:00:02.0: Adding to iommu group 1
[    1.862382] pci 0000:00:04.0: Adding to iommu group 2
[    1.862394] pci 0000:00:08.0: Adding to iommu group 3
[    1.862417] pci 0000:00:14.0: Adding to iommu group 4
[    1.862428] pci 0000:00:14.2: Adding to iommu group 4
[    1.862446] pci 0000:00:15.0: Adding to iommu group 5
[    1.862462] pci 0000:00:16.0: Adding to iommu group 6
[    1.862485] pci 0000:00:1c.0: Adding to iommu group 7
[    1.862498] pci 0000:00:1c.4: Adding to iommu group 8
[    1.862513] pci 0000:00:1c.6: Adding to iommu group 9
[    1.862528] pci 0000:00:1d.0: Adding to iommu group 10
[    1.862568] pci 0000:00:1f.0: Adding to iommu group 11
[    1.862580] pci 0000:00:1f.2: Adding to iommu group 11
[    1.862592] pci 0000:00:1f.3: Adding to iommu group 11
[    1.862606] pci 0000:00:1f.4: Adding to iommu group 11
[    1.862618] pci 0000:00:1f.6: Adding to iommu group 11
[    1.862631] pci 0000:04:00.0: Adding to iommu group 12
[    1.862644] pci 0000:05:00.0: Adding to iommu group 13
[    1.862657] pci 0000:05:01.0: Adding to iommu group 14
[    1.862672] pci 0000:05:02.0: Adding to iommu group 15
[    1.862676] pci 0000:06:00.0: Adding to iommu group 13
[    1.862681] pci 0000:3c:00.0: Adding to iommu group 15
[    1.862694] pci 0000:3d:00.0: Adding to iommu group 16
[    1.862708] pci 0000:3e:00.0: Adding to iommu group 17
[    1.866319] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.866320] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.866323] software IO TLB: mapped [mem 0x79f2f000-0x7df2f000] (64MB)
[    1.866936] Initialise system trusted keyrings
[    1.866945] Key type blacklist registered
[    1.866992] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.868444] zbud: loaded
[    1.868657] integrity: Platform Keyring initialized
[    1.868659] Key type asymmetric registered
[    1.868660] Asymmetric key parser 'x509' registered
[    1.868667] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.868715] io scheduler mq-deadline registered
[    1.869157] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.869190] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.869363] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    1.869388] pcieport 0000:00:1c.4: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.869688] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    1.869943] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.870313] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
[    1.870448] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.870783] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.870803] efifb: probing for efifb
[    1.870820] efifb: framebuffer at 0xc0000000, using 14400k, total 14400k
[    1.870821] efifb: mode is 2560x1440x32, linelength=3D10240, pages=3D1
[    1.870822] efifb: scrolling: redraw
[    1.870823] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.870916] Console: switching to colour frame buffer device 160x45
[    1.880212] fb0: EFI VGA frame buffer device
[    1.880221] intel_idle: MWAIT substates: 0x11142120
[    1.880222] intel_idle: v0.5.1 model 0x8E
[    1.880814] intel_idle: Local APIC timer is reliable in all C-states
[    1.885261] thermal LNXTHERM:00: registered as thermal_zone0
[    1.885262] ACPI: Thermal Zone [THM0] (45 C)
[    1.885507] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.886371] Linux agpgart interface v0.103
[    1.886416] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.886417] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    1.887200] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.889290] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.889294] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.889469] mousedev: PS/2 mouse device common for all mice
[    1.889515] rtc_cmos 00:03: RTC can wake from S4
[    1.890155] rtc_cmos 00:03: registered as rtc0
[    1.890327] rtc_cmos 00:03: setting system clock to 2020-11-07T15:11:37 =
UTC (1604761897)
[    1.890363] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[    1.890372] intel_pstate: Intel P-state driver initializing
[    1.891241] intel_pstate: HWP enabled
[    1.891259] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.891630] ledtrig-cpu: registered to indicate activity on CPUs
[    1.892033] NET: Registered protocol family 10
[    1.899622] Segment Routing with IPv6
[    1.899637] mip6: Mobile IPv6
[    1.899638] NET: Registered protocol family 17
[    1.899670] mpls_gso: MPLS GSO support
[    1.900325] microcode: sig=3D0x806ea, pf=3D0x80, revision=3D0x84
[    1.900420] microcode: Microcode Update Driver: v2.2.
[    1.900422] IPI shorthand broadcast: enabled
[    1.900427] sched_clock: Marking stable (1899735632, 549587)->(190850248=
2, -8217263)
[    1.900547] registered taskstats version 1
[    1.900549] Loading compiled-in X.509 certificates
[    1.921407] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f61=
49f3dd27dfcc5cbb419ea1'
[    1.921416] Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b=
9'
[    1.921433] zswap: loaded using pool lzo/zbud
[    1.921847] Key type ._fscrypt registered
[    1.921847] Key type .fscrypt registered
[    1.921847] Key type fscrypt-provisioning registered
[    1.921870] AppArmor: AppArmor sha1 policy hashing enabled
[    1.922695] integrity: Loading X.509 certificate: UEFI:db
[    1.922723] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.922723] integrity: Loading X.509 certificate: UEFI:db
[    1.922732] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.922732] integrity: Loading X.509 certificate: UEFI:db
[    1.922745] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.922746] integrity: Loading X.509 certificate: UEFI:db
[    1.922755] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.924889] Freeing unused kernel image (initmem) memory: 1636K
[    1.948895] Write protecting the kernel read-only data: 18432k
[    1.949446] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.949611] Freeing unused kernel image (rodata/data gap) memory: 332K
[    1.990714] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.990715] x86/mm: Checking user space page tables
[    2.026438] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.026442] Run /init as init process
[    2.026442]   with arguments:
[    2.026443]     /init
[    2.026443]   with environment:
[    2.026443]     HOME=3D/
[    2.026444]     TERM=3Dlinux
[    2.026444]     BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64
[    2.026444]     crashkernel=3D384M-8G:128M,8G-:512M
[    2.096701] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    2.104279] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.104328] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.106159] pps_core: LinuxPPS API ver. 1 registered
[    2.106160] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.106885] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    2.107014] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.107074] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.108010] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.108526] PTP clock support registered
[    2.108618] i2c i2c-0: Successfully instantiated SPD at 0x51
[    2.108650] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    2.108874] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    2.112487] ACPI: Sleep Button [SLPB]
[    2.112535] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input3
[    2.112564] ACPI: Lid Switch [LID]
[    2.112618] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input4
[    2.112644] ACPI: Power Button [PWRF]
[    2.114597] ACPI: bus type USB registered
[    2.114612] usbcore: registered new interface driver usbfs
[    2.114619] usbcore: registered new interface driver hub
[    2.114677] usbcore: registered new device driver usb
[    2.128278] cryptd: max_cpu_qlen set to 1000
[    2.130801] battery: ACPI: Battery Slot [BAT0] (battery present)
[    2.132540] e1000e: Intel(R) PRO/1000 Network Driver
[    2.132540] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.132704] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    2.133602] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.133606] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    2.134703] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000081109810
[    2.134846] xhci_hcd 0000:00:14.0: cache line size of 128 is not support=
ed
[    2.135010] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.135011] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.135012] usb usb1: Product: xHCI Host Controller
[    2.135013] usb usb1: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.135014] usb usb1: SerialNumber: 0000:00:14.0
[    2.135097] hub 1-0:1.0: USB hub found
[    2.135111] hub 1-0:1.0: 12 ports detected
[    2.136087] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.136090] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    2.136092] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.136127] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.136128] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.136129] usb usb2: Product: xHCI Host Controller
[    2.136130] usb usb2: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.136131] usb usb2: SerialNumber: 0000:00:14.0
[    2.136214] hub 2-0:1.0: USB hub found
[    2.136224] hub 2-0:1.0: 6 ports detected
[    2.136583] usb: port power management may be unreliable
[    2.136813] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.136817] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 3
[    2.137951] xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    2.138135] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.138136] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.138137] usb usb3: Product: xHCI Host Controller
[    2.138138] usb usb3: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.138139] usb usb3: SerialNumber: 0000:3c:00.0
[    2.138217] hub 3-0:1.0: USB hub found
[    2.138223] hub 3-0:1.0: 2 ports detected
[    2.138613] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.138617] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 4
[    2.138618] xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.138649] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.138651] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.138652] usb usb4: Product: xHCI Host Controller
[    2.138652] usb usb4: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.138653] usb usb4: SerialNumber: 0000:3c:00.0
[    2.138730] hub 4-0:1.0: USB hub found
[    2.138736] hub 4-0:1.0: 2 ports detected
[    2.140336] nvme nvme0: pci function 0000:3e:00.0
[    2.142291] AVX2 version of gcm_enc/dec engaged.
[    2.142292] AES CTR mode by8 optimization enabled
[    2.151049] nvme nvme0: Shutdown timeout set to 8 seconds
[    2.159766] nvme nvme0: 8/0/0 default/read/poll queues
[    2.163408]  nvme0n1: p1 p2 p3
[    2.223159] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    2.223802] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.223803] checking generic (c0000000 e10000) vs hw (e7000000 1000000)
[    2.223804] checking generic (c0000000 e10000) vs hw (c0000000 10000000)
[    2.223804] fb0: switching to inteldrmfb from EFI VGA
[    2.223847] Console: switching to colour dummy device 80x25
[    2.223863] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.225125] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    2.225149] i915 0000:00:02.0: firmware: failed to load i915/kbl_dmc_ver=
1_04.bin (-2)
[    2.225151] firmware_class: See https://wiki.debian.org/Firmware for inf=
ormation about missing firmware
[    2.225152] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver=
1_04.bin failed with error -2
[    2.225153] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/kb=
l_dmc_ver1_04.bin. Disabling runtime power management.
[    2.225154] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    2.230803] i915 0000:00:02.0: [drm] Reducing the compressed framebuffer=
 size. This may lead to less power savings than a non-reduced-size. Try to =
increase stolen memory size if available in BIOS.
[    2.250411] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on mi=
nor 0
[    2.252408] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.252705] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input6
[    2.367140] fbcon: i915drmfb (fb0) is primary device
[    2.380250] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    2.447603] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 8c:=
16:45:66:ba:11
[    2.447607] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    2.447706] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    2.449901] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.472590] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.633046] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
9540, bcdDevice=3D 1.20
[    2.633050] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.633053] usb 1-3: Product: EMV Smartcard Reader
[    2.633055] usb 1-3: Manufacturer: Generic
[    2.651406] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x7f3001)
[    2.663400] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0f.
[    2.675351] psmouse serio1: elantech: Elan sample query result 00, 20, c9
[    2.699264] psmouse serio1: elantech: Trying to set up SMBus access
[    2.748830] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    2.787317] usb 2-3: New USB device found, idVendor=3D0bda, idProduct=3D=
0316, bcdDevice=3D 2.04
[    2.787321] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.787324] usb 2-3: Product: USB3.0-CRW
[    2.787326] usb 2-3: Manufacturer: Generic
[    2.787328] usb 2-3: SerialNumber: 20120501030900000
[    2.825502] SCSI subsystem initialized
[    2.831993] usb-storage 2-3:1.0: USB Mass Storage device detected
[    2.832260] scsi host0: usb-storage 2-3:1.0
[    2.832362] usbcore: registered new interface driver usb-storage
[    2.834368] usbcore: registered new interface driver uas
[    2.896658] tsc: Refined TSC clocksource calibration: 1991.999 MHz
[    2.896673] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396=
d4ffc055, max_idle_ns: 881590662783 ns
[    2.896750] clocksource: Switched to clocksource tsc
[    2.904549] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    3.064438] usb 1-5: New USB device found, idVendor=3D04f2, idProduct=3D=
b615, bcdDevice=3D 0.11
[    3.064442] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.064445] usb 1-5: Product: Integrated IR Camera
[    3.064447] usb 1-5: Manufacturer: SunplusIT Inc
[    3.192568] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    3.349922] usb 1-6: New USB device found, idVendor=3D2cb7, idProduct=3D=
0210, bcdDevice=3D 3.33
[    3.349926] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    3.349929] usb 1-6: Product: L830-EB-00
[    3.349932] usb 1-6: Manufacturer: FIBOCOM
[    3.349934] usb 1-6: SerialNumber: 004999010640000
[    3.472336] Console: switching to colour frame buffer device 160x45
[    3.492551] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    3.506669] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    3.641398] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[    3.641399] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    3.652458] raid6: avx2x4   gen() 37681 MB/s
[    3.720458] raid6: avx2x4   xor() 20275 MB/s
[    3.768501] usb 1-8: new high-speed USB device number 6 using xhci_hcd
[    3.788458] raid6: avx2x2   gen() 43649 MB/s
[    3.856458] raid6: avx2x2   xor() 26017 MB/s
[    3.858387] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.=
00 PQ: 0 ANSI: 6
[    3.924459] raid6: avx2x1   gen() 36643 MB/s
[    3.927864] usb 1-8: New USB device found, idVendor=3D04f2, idProduct=3D=
b614, bcdDevice=3D 0.12
[    3.927865] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.927866] usb 1-8: Product: Integrated Camera
[    3.927866] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    3.992458] raid6: avx2x1   xor() 22526 MB/s
[    4.056504] usb 1-9: new full-speed USB device number 7 using xhci_hcd
[    4.060460] raid6: sse2x4   gen() 17999 MB/s
[    4.128458] raid6: sse2x4   xor() 10677 MB/s
[    4.196458] raid6: sse2x2   gen() 18347 MB/s
[    4.205871] usb 1-9: New USB device found, idVendor=3D06cb, idProduct=3D=
009a, bcdDevice=3D 1.64
[    4.205871] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    4.205872] usb 1-9: SerialNumber: 5bb5988684f7
[    4.264458] raid6: sse2x2   xor() 11107 MB/s
[    4.332458] raid6: sse2x1   gen() 15384 MB/s
[    4.400458] raid6: sse2x1   xor()  7515 MB/s
[    4.400459] raid6: using algorithm avx2x2 gen() 43649 MB/s
[    4.400459] raid6: .... xor() 26017 MB/s, rmw enabled
[    4.400460] raid6: using avx2x2 recovery algorithm
[    4.401050] xor: automatically using best checksumming function   avx   =
   =20
[    4.401505] async_tx: api initialized (async)
[    4.434889] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    4.639475] device-mapper: uevent: version 1.0.3
[    4.639640] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[    9.564112] Btrfs loaded, crc32c=3Dcrc32c-intel
[    9.612137] PM: Image not found (code -22)
[    9.718339] EXT4-fs (dm-1): mounted filesystem with ordered data mode. O=
pts: (null)
[    9.747681] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[    9.828029] systemd[1]: Inserted module 'autofs4'
[    9.939209] systemd[1]: systemd 246.6-2 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCR=
E2 default-hierarchy=3Dhybrid)
[    9.956984] systemd[1]: Detected architecture x86-64.
[    9.981560] systemd[1]: Set hostname to <linus-work>.
[   10.047138] systemd[1]: /lib/systemd/system/gpsd.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/g=
psd.sock \xffffffe2\xffffff86\xffffff92 /run/gpsd.sock; please update the u=
nit file accordingly.
[   10.055125] systemd[1]: /lib/systemd/system/plymouth-start.service:16: U=
nit configured to use KillMode=3Dnone. This is unsafe, as it disables syste=
md's process lifecycle management for the service. Please update your servi=
ce to use a safer KillMode=3D, such as 'mixed' or 'control-group'. Support =
for KillMode=3Dnone is deprecated and will eventually be removed.
[   10.062422] systemd[1]: /lib/systemd/system/rpc-statd.service:16: PIDFil=
e=3D references a path below legacy directory /var/run/, updating /var/run/=
rpc.statd.pid \xffffffe2\xffffff86\xffffff92 /run/rpc.statd.pid; please upd=
ate the unit file accordingly.
[   10.068611] systemd[1]: /lib/systemd/system/smartmontools.service:10: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.
[   10.072165] systemd[1]: /lib/systemd/system/kdump-tools.service:6: Stand=
ard output type syslog+console is obsolete, automatically updating to journ=
al+console. Please update your unit file, and consider removing the setting=
 altogether.
[   10.073921] systemd[1]: /lib/systemd/system/fancontrol.service:11: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/fancontrol.pid \xffffffe2\xffffff86\xffffff92 /run/fancontrol.pid; please =
update the unit file accordingly.
[   10.077834] systemd[1]: Queued start job for default target Graphical In=
terface.
[   10.078477] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   10.078854] systemd[1]: Created slice system-getty.slice.
[   10.079014] systemd[1]: Created slice system-modprobe.slice.
[   10.079202] systemd[1]: Created slice Cryptsetup Units Slice.
[   10.079358] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   10.079518] systemd[1]: Created slice system-tor.slice.
[   10.079668] systemd[1]: Created slice User and Session Slice.
[   10.079703] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   10.079802] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   10.079855] systemd[1]: Reached target Slices.
[   10.079871] systemd[1]: Reached target Libvirt guests shutdown.
[   10.079909] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   10.079968] systemd[1]: Listening on LVM2 poll daemon socket.
[   10.082252] systemd[1]: Listening on RPCbind Server Activation Socket.
[   10.082324] systemd[1]: Listening on Syslog Socket.
[   10.082373] systemd[1]: Listening on fsck to fsckd communication Socket.
[   10.082405] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   10.082484] systemd[1]: Listening on Journal Audit Socket.
[   10.082528] systemd[1]: Listening on Journal Socket (/dev/log).
[   10.082583] systemd[1]: Listening on Journal Socket.
[   10.082647] systemd[1]: Listening on udev Control Socket.
[   10.082689] systemd[1]: Listening on udev Kernel Socket.
[   10.083203] systemd[1]: Mounting Huge Pages File System...
[   10.083812] systemd[1]: Mounting POSIX Message Queue File System...
[   10.084339] systemd[1]: Mounting NFSD configuration filesystem...
[   10.084890] systemd[1]: Mounting RPC Pipe File System...
[   10.085494] systemd[1]: Mounting Kernel Debug File System...
[   10.086089] systemd[1]: Mounting Kernel Trace File System...
[   10.086182] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   10.086296] systemd[1]: Finished Availability of block devices.
[   10.087014] systemd[1]: Starting Set the console keyboard layout...
[   10.087729] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   10.088344] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   10.088426] systemd[1]: Condition check resulted in Load Kernel Module d=
rm being skipped.
[   10.088778] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   10.088804] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[   10.089973] systemd[1]: Starting Journal Service...
[   10.091140] systemd[1]: Starting Load Kernel Modules...
[   10.091873] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.092632] systemd[1]: Starting Coldplug All udev Devices...
[   10.094007] systemd[1]: Mounted Huge Pages File System.
[   10.094131] systemd[1]: Mounted POSIX Message Queue File System.
[   10.094236] systemd[1]: Mounted Kernel Debug File System.
[   10.094337] systemd[1]: Mounted Kernel Trace File System.
[   10.094828] systemd[1]: Finished Set the console keyboard layout.
[   10.095329] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   10.100909] EXT4-fs (dm-1): re-mounted. Opts: errors=3Dremount-ro
[   10.102141] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.102606] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.102642] systemd[1]: Condition check resulted in Platform Persistent =
Storage Archival being skipped.
[   10.103442] systemd[1]: Starting Load/Save Random Seed...
[   10.104143] systemd[1]: Starting Create System Users...
[   10.107442] lp: driver loaded but no devices found
[   10.111327] ppdev: user-space parallel port driver
[   10.112405] RPC: Registered named UNIX socket transport module.
[   10.112405] RPC: Registered udp transport module.
[   10.112405] RPC: Registered tcp transport module.
[   10.112406] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.113126] systemd[1]: Mounted RPC Pipe File System.
[   10.113911] systemd[1]: Starting pNFS block layout mapping daemon...
[   10.115595] systemd[1]: Started pNFS block layout mapping daemon.
[   10.117428] systemd[1]: Finished Load/Save Random Seed.
[   10.119103] systemd[1]: Finished Load Kernel Modules.
[   10.119282] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.119327] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.119972] systemd[1]: Starting Apply Kernel Variables...
[   10.123531] systemd[1]: Finished Create System Users.
[   10.124405] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.126698] systemd[1]: Finished Apply Kernel Variables.
[   10.137741] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.139378] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   10.148559] systemd[1]: Finished Coldplug All udev Devices.
[   10.149419] systemd[1]: Starting Helper to synchronize boot up for ifupd=
own...
[   10.151598] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.152508] systemd[1]: Mounted NFSD configuration filesystem.
[   10.181455] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   10.181568] systemd[1]: Reached target Local File Systems (Pre).
[   10.181591] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.181601] systemd[1]: Reached target Containers.
[   10.195415] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[   10.196095] systemd[1]: Starting Show Plymouth Boot Screen...
[   10.215039] systemd[1]: Started Show Plymouth Boot Screen.
[   10.215174] systemd[1]: Condition check resulted in Dispatch Password Re=
quests to Console Directory Watch being skipped.
[   10.215257] systemd[1]: Started Forward Password Requests to Plymouth Di=
rectory Watch.
[   10.242111] tpm_tis IFX0763:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   10.252947] ACPI: AC Adapter [AC] (on-line)
[   10.286504] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   10.288632] intel_rapl_common: Found RAPL domain package
[   10.288633] intel_rapl_common: Found RAPL domain dram
[   10.292627] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THE=
RMAL_PCI
[   10.294492] Non-volatile memory driver v1.3
[   10.296527] systemd[1]: Created slice system-systemd\x2dbacklight.slice.
[   10.297212] systemd[1]: Starting Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight...
[   10.297363] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   10.305082] mc: Linux media interface: v0.10
[   10.305529] systemd[1]: Finished Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight.
[   10.327569] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 1.
[   10.328204] systemd[1]: Starting File System Check on /dev/disk/by-uuid/=
B616-7D5F...
[   10.330578] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 3.
[   10.331360] systemd[1]: Starting Cryptography Setup for nvme0n1p3_crypt.=
=2E.
[   10.333868] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 2.
[   10.334525] systemd[1]: Starting File System Check on /dev/disk/by-uuid/=
0ff272a1-2687-46aa-9042-94763e0efe1b...
[   10.335321] systemd[1]: Started File System Check Daemon to report statu=
s.
[   10.337880] systemd[1]: Finished Cryptography Setup for nvme0n1p3_crypt.
[   10.338004] systemd[1]: Reached target Block Device Preparation for /dev=
/mapper/nvme0n1p3_crypt.
[   10.338018] systemd[1]: Reached target Local Encrypted Volumes.
[   10.346518] systemd[1]: Finished File System Check on /dev/disk/by-uuid/=
B616-7D5F.
[   10.355832] systemd[1]: Finished File System Check on /dev/disk/by-uuid/=
0ff272a1-2687-46aa-9042-94763e0efe1b.
[   10.356468] systemd[1]: Mounting /boot...
[   10.357667] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   10.360169] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opt=
s: (null)
[   10.360172] ext2 filesystem being mounted at /boot supports timestamps u=
ntil 2038 (0x7fffffff)
[   10.360944] systemd[1]: Mounted /boot.
[   10.362013] systemd[1]: Mounting /boot/efi...
[   10.365795] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   10.365795] thinkpad_acpi: http://ibm-acpi.sf.net/
[   10.365796] thinkpad_acpi: ThinkPad BIOS N22ET35W (1.12 ), EC N22HT22W
[   10.365796] thinkpad_acpi: Lenovo ThinkPad T480s, model 20L70053GE
[   10.366109] thinkpad_acpi: radio switch found; radios are enabled
[   10.366119] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[   10.366120] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[   10.366656] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   10.367113] cdc_acm 1-6:1.2: ttyACM0: USB ACM device
[   10.370721] usbcore: registered new interface driver cdc_acm
[   10.370722] cdc_acm: USB Abstract Control Model driver for USB modems an=
d ISDN adapters
[   10.371658] elan_i2c 0-0015: supply vcc not found, using dummy regulator
[   10.375386] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[   10.380262] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[   10.387851] elan_i2c 0-0015: unexpected iap version 0x00 (ic type: 0x20)=
, firmware update will not work
[   10.387855] elan_i2c 0-0015: Elan Touchpad: Module ID: 0x0020, Firmware:=
 0x0001, Sample: 0x0000, IAP: 0x0000
[   10.387944] input: Elan Touchpad as /devices/pci0000:00/0000:00:1f.4/i2c=
-0/0-0015/input/input8
[   10.388021] input: Elan TrackPoint as /devices/pci0000:00/0000:00:1f.4/i=
2c-0/0-0015/input/input9
[   10.401717] videodev: Linux video capture interface: v2.00
[   10.404341] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[   10.404346] battery: new extension: ThinkPad Battery Extension
[   10.406867] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[   10.407987] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   10.433293] usbcore: registered new interface driver cdc_ether
[   10.435531] iTCO_vendor_support: vendor-support=3D0
[   10.439838] usbcore: registered new interface driver cdc_ncm
[   10.443078] systemd[1]: Started Journal Service.
[   10.487949] EFI Variables Facility v0.08 2004-May-17
[   10.488622] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   10.488852] cfg80211: Loaded X.509 cert 'benh@debian.org: 577e021cb980e0=
e820821ba7b54b4961b8b4fadf'
[   10.489050] cfg80211: Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6=
ec146e09d1b6016ab9d6cf71dd233f0328'
[   10.489198] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.489737] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db
[   10.489852] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db.p7s
[   10.489881] input: PC Speaker as /devices/platform/pcspkr/input/input10
[   10.509695] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   10.509761] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   10.510545] usbcore: registered new interface driver cdc_wdm
[   10.510719] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   10.572092] audit: type=3D1400 audit(1604761906.174:2): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/lxc-=
start" pid=3D686 comm=3D"apparmor_parser"
[   10.574604] audit: type=3D1400 audit(1604761906.178:3): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-s=
enddoc" pid=3D685 comm=3D"apparmor_parser"
[   10.574607] audit: type=3D1400 audit(1604761906.178:4): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-o=
opslash" pid=3D692 comm=3D"apparmor_parser"
[   10.575726] audit: type=3D1400 audit(1604761906.178:5): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/gps=
d" pid=3D690 comm=3D"apparmor_parser"
[   10.576119] audit: type=3D1400 audit(1604761906.178:6): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/cup=
s-browsed" pid=3D687 comm=3D"apparmor_parser"
[   10.578182] cdc_mbim 1-6:1.0: setting rx_max =3D 16384
[   10.579137] cdc_mbim 1-6:1.0: cdc-wdm0: USB WDM device
[   10.579305] cdc_mbim 1-6:1.0 wwan0: register 'cdc_mbim' at usb-0000:00:1=
4.0-6, CDC MBIM, 5a:24:41:70:3a:ac
[   10.579333] usbcore: registered new interface driver cdc_mbim
[   10.583695] audit: type=3D1400 audit(1604761906.186:7): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/man"=
 pid=3D689 comm=3D"apparmor_parser"
[   10.583697] audit: type=3D1400 audit(1604761906.186:8): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_filter" p=
id=3D689 comm=3D"apparmor_parser"
[   10.583699] audit: type=3D1400 audit(1604761906.186:9): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_groff" pi=
d=3D689 comm=3D"apparmor_parser"
[   10.586857] audit: type=3D1400 audit(1604761906.190:10): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"libvirtd" pi=
d=3D696 comm=3D"apparmor_parser"
[   10.586859] audit: type=3D1400 audit(1604761906.190:11): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"libvirtd//qe=
mu_bridge_helper" pid=3D696 comm=3D"apparmor_parser"
[   10.668110] resource sanity check: requesting [mem 0xfed10000-0xfed15fff=
], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
[   10.668118] caller snb_uncore_imc_init_box+0x78/0xc0 [intel_uncore] mapp=
ing multiple BARs
[   10.668319] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[   10.673470] Intel(R) Wireless WiFi driver for Linux
[   10.673831] iwlwifi 0000:3d:00.0: enabling device (0000 -> 0002)
[   10.678270] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
36.ucode (-2)
[   10.679084] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
36.ucode failed with error -2
[   10.679098] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
35.ucode (-2)
[   10.679105] uvcvideo: Found UVC 1.00 device Integrated IR Camera (04f2:b=
615)
[   10.679206] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
35.ucode failed with error -2
[   10.679206] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   10.679206] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   10.679219] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
34.ucode (-2)
[   10.679326] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
34.ucode failed with error -2
[   10.679343] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
33.ucode (-2)
[   10.679450] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
33.ucode failed with error -2
[   10.679460] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
32.ucode (-2)
[   10.679568] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
32.ucode failed with error -2
[   10.682930] pstore: Using crash dump compression: deflate
[   10.682946] pstore: Registered efi as persistent store backend
[   10.690101] iwlwifi 0000:3d:00.0: firmware: direct-loading firmware iwlw=
ifi-8265-31.ucode
[   10.691203] iwlwifi 0000:3d:00.0: loaded firmware version 31.532993.0 82=
65-31.ucode op_mode iwlmvm
[   10.691216] iwlwifi 0000:3d:00.0: firmware: failed to load iwl-debug-yoy=
o.bin (-2)
[   10.704161] Bluetooth: Core ver 2.22
[   10.704169] NET: Registered protocol family 31
[   10.704170] Bluetooth: HCI device and connection manager initialized
[   10.704172] Bluetooth: HCI socket layer initialized
[   10.704173] Bluetooth: L2CAP socket layer initialized
[   10.704176] Bluetooth: SCO socket layer initialized
[   10.704249] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360=
 ms ovfl timer
[   10.704250] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.704250] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.704251] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   10.704251] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   10.704251] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   10.707704] uvcvideo 1-5:1.0: Entity type for entity Extension 6 was not=
 initialized!
[   10.707706] uvcvideo 1-5:1.0: Entity type for entity Extension 5 was not=
 initialized!
[   10.707708] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   10.707709] uvcvideo 1-5:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   10.707710] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   10.707711] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   10.710095] input: Integrated IR Camera: Integrate as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-5/1-5:1.0/input/input11
[   10.710996] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b614)
[   10.710998] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   10.710998] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   10.725772] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   10.725774] uvcvideo 1-8:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   10.725774] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   10.725775] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   10.725824] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-8/1-8:1.0/input/input12
[   10.725872] usbcore: registered new interface driver uvcvideo
[   10.725872] USB Video Class driver (1.1.1)
[   10.820453] intel_rapl_common: Found RAPL domain package
[   10.820454] intel_rapl_common: Found RAPL domain core
[   10.820455] intel_rapl_common: Found RAPL domain uncore
[   10.820456] intel_rapl_common: Found RAPL domain dram
[   10.843018] usbcore: registered new interface driver btusb
[   10.852055] iwlwifi 0000:3d:00.0: Detected Intel(R) Dual Band Wireless A=
C 8265, REV=3D0x230
[   10.862344] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC257: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   10.862346] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   10.862348] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   10.862349] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[   10.862349] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   10.862351] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x19
[   10.862352] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[   10.866781] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 20=
15
[   10.867294] Bluetooth: hci0: Device revision is 16
[   10.867295] Bluetooth: hci0: Secure boot is enabled
[   10.867295] Bluetooth: hci0: OTP lock is enabled
[   10.867296] Bluetooth: hci0: API lock is enabled
[   10.867296] Bluetooth: hci0: Debug lock is disabled
[   10.867297] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.870967] bluetooth hci0: firmware: direct-loading firmware intel/ibt-=
12-16.sfi
[   10.870970] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[   10.874257] Adding 16531452k swap on /dev/mapper/linus--work--vg-swap_1.=
  Priority:-2 extents:1 across:16531452k SSFS
[   10.919536] iwlwifi 0000:3d:00.0: base HW address: 7c:76:35:14:e6:d7
[   10.995871] iwlwifi 0000:3d:00.0: iwlmvm doesn't allow to disable BT Coe=
x, check bt_coex_active module parameter
[   10.996706] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   10.996951] thermal thermal_zone5: failed to read out thermal zone (-61)
[   11.004178] iwlwifi 0000:3d:00.0 wlp61s0: renamed from wlan0
[   11.065578] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input13
[   11.065619] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input14
[   11.065720] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input15
[   11.068180] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[   11.068260] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[   11.068312] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input18
[   11.069060] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input19
[   11.069143] input: HDA Intel PCH HDMI/DP,pcm=3D10 as /devices/pci0000:00=
/0000:00:1f.3/sound/card0/input20
[   11.323520] new mount options do not match the existing superblock, will=
 be ignored
[   11.327563] intel_pmc_core intel_pmc_core.0:  initialized
[   11.333684] fuse: init (API version 7.31)
[   12.579804] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   12.579870] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   12.584192] IPv6: ADDRCONF(NETDEV_CHANGE): veth3: link becomes ready
[   12.627222] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   12.632188] br0: port 1(enp0s31f6) entered blocking state
[   12.632191] br0: port 1(enp0s31f6) entered disabled state
[   12.632265] device enp0s31f6 entered promiscuous mode
[   12.785685] Bluetooth: hci0: Waiting for firmware download to complete
[   12.786402] Bluetooth: hci0: Firmware loaded in 1884662 usecs
[   12.786525] Bluetooth: hci0: Waiting for device to boot
[   12.798610] Bluetooth: hci0: Device booted in 11913 usecs
[   12.801880] bluetooth hci0: firmware: direct-loading firmware intel/ibt-=
12-16.ddc
[   12.801886] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16=
=2Eddc
[   12.803435] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.804428] Bluetooth: hci0: Reading supported features failed (-16)
[   12.808392] Bluetooth: hci0: Setting Intel telemetry ddc write event mas=
k failed (-95)
[   12.812446] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   12.823775] br0: port 2(veth0) entered blocking state
[   12.823780] br0: port 2(veth0) entered disabled state
[   12.823930] device veth0 entered promiscuous mode
[   12.829761] br0: port 3(veth2) entered blocking state
[   12.829765] br0: port 3(veth2) entered disabled state
[   12.829906] device veth2 entered promiscuous mode
[   12.835619] br0: port 3(veth2) entered blocking state
[   12.835623] br0: port 3(veth2) entered forwarding state
[   12.835654] br0: port 2(veth0) entered blocking state
[   12.835658] br0: port 2(veth0) entered forwarding state
[   14.575209] NFSD: Using UMH upcall client tracking operations.
[   14.575216] NFSD: starting 90-second grace period (net f00000a8)
[   14.826580] L1TF CPU bug present and SMT on, data leak possible. See CVE=
-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l=
1tf.html for details.
[   58.919208] wlp61s0: authenticate with 8a:04:f3:06:a8:84
[   58.934174] wlp61s0: send auth to 8a:04:f3:06:a8:84 (try 1/3)
[   58.951312] wlp61s0: authenticated
[   58.956594] wlp61s0: associate with 8a:04:f3:06:a8:84 (try 1/3)
[   58.960905] wlp61s0: RX AssocResp from 8a:04:f3:06:a8:84 (capab=3D0x421 =
status=3D0 aid=3D1)
[   58.966039] wlp61s0: associated
[   58.966134] IPv6: ADDRCONF(NETDEV_CHANGE): wlp61s0: link becomes ready
[   67.622542] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   67.622543] Bluetooth: BNEP filters: protocol multicast
[   67.622547] Bluetooth: BNEP socket layer initialized
[   67.628417] NET: Registered protocol family 38
[   71.283992] Bluetooth: RFCOMM TTY layer initialized
[   71.284002] Bluetooth: RFCOMM socket layer initialized
[   71.284013] Bluetooth: RFCOMM ver 1.11
[  202.174691] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input21
[  245.543838] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input22
[  309.579123] general protection fault, probably for non-canonical address=
 0xa0ff333c4445d408: 0000 [#1] SMP PTI
[  309.579135] CPU: 2 PID: 1867 Comm: Xorg Kdump: loaded Not tainted 5.9.0-=
1-amd64 #1 Debian 5.9.1-1
[  309.579139] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  309.579153] RIP: 0010:__kmalloc_track_caller+0xa0/0x260
[  309.579159] Code: 24 65 49 8b 50 08 65 4c 03 05 94 cb 58 42 49 8b 00 48 =
89 04 24 48 85 c0 0f 84 9e 01 00 00 41 8b 4c 24 28 49 8b 3c 24 48 01 c1 <48=
> 8b 19 48 89 ce 49 33 9c 24 b8 00 00 00 48 8d 4a 01 48 0f ce 48
[  309.579164] RSP: 0018:ffffb66641fdf7a0 EFLAGS: 00010282
[  309.579170] RAX: a0ff333c4445d3e8 RBX: ffff9695b2abbc00 RCX: a0ff333c444=
5d408
[  309.579173] RDX: 00000000000092b4 RSI: 0000000000002800 RDI: 00000000000=
2f300
[  309.579177] RBP: 0000000000002800 R08: ffff9695e26af300 R09: ffff9695c28=
86210
[  309.579180] R10: 0000000000000000 R11: 0000000000000000 R12: ffff969287c=
43b00
[  309.579183] R13: 0000000000000028 R14: ffffffffbde1eeff R15: ffff969287c=
43b00
[  309.579188] FS:  00007f70c06ac580(0000) GS:ffff9695e2680000(0000) knlGS:=
0000000000000000
[  309.579192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  309.579196] CR2: 00007f1357354780 CR3: 000000044bcc2003 CR4: 00000000003=
706e0
[  309.579199] Call Trace:
[  309.579214]  krealloc+0x52/0xb0
[  309.579226]  dma_resv_get_fences_rcu+0x25f/0x3d0
[  309.579371]  i915_request_await_object+0x4a/0x2a0 [i915]
[  309.579493]  ? i915_vma_move_to_active+0x93/0x1b0 [i915]
[  309.579598]  i915_gem_do_execbuffer+0x2bb9/0x3230 [i915]
[  309.579615]  ? update_load_avg+0x7a/0x610
[  309.579621]  ? __wake_up_common+0x80/0x180
[  309.579631]  ? __mod_memcg_lruvec_state+0x21/0xe0
[  309.579641]  ? unix_stream_read_generic+0x75c/0x850
[  309.579649]  ? kmem_cache_free+0x25d/0x280
[  309.579655]  ? scm_recv.constprop.0+0x43/0x1a0
[  309.579663]  ? unix_stream_read_generic+0x1d2/0x850
[  309.579672]  ? _cond_resched+0x16/0x40
[  309.579680]  ? aa_sk_perm+0x3e/0x1a0
[  309.579687]  ? sock_def_readable+0x37/0x60
[  309.579787]  ? i915_gem_execbuffer2_ioctl+0xae/0x490 [i915]
[  309.579796]  ? unix_stream_recvmsg+0x53/0x70
[  309.579802]  ? unix_copy_addr+0x30/0x30
[  309.579809]  ? _cond_resched+0x16/0x40
[  309.579816]  ? slab_pre_alloc_hook.constprop.0+0xd0/0x110
[  309.579823]  ? __kmalloc_node+0x140/0x2e0
[  309.579923]  ? i915_gem_execbuffer2_ioctl+0x149/0x490 [i915]
[  309.580023]  i915_gem_execbuffer2_ioctl+0x386/0x490 [i915]
[  309.580124]  ? i915_gem_execbuffer_ioctl+0x2d0/0x2d0 [i915]
[  309.580177]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[  309.580217]  drm_ioctl+0x20f/0x3a0 [drm]
[  309.580319]  ? i915_gem_execbuffer_ioctl+0x2d0/0x2d0 [i915]
[  309.580331]  ? __x64_sys_setitimer+0x105/0x150
[  309.580340]  __x64_sys_ioctl+0x83/0xb0
[  309.580349]  do_syscall_64+0x33/0x80
[  309.580359]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  309.580365] RIP: 0033:0x7f70c0af3c27
[  309.580372] Code: 00 00 00 48 8b 05 69 92 0c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 92 0c 00 f7 d8 64 89 01 48
[  309.580376] RSP: 002b:00007ffd76db4a18 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  309.580381] RAX: ffffffffffffffda RBX: 00005642c07b71b0 RCX: 00007f70c0a=
f3c27
[  309.580385] RDX: 00007ffd76db4a20 RSI: 0000000040406469 RDI: 00000000000=
00013
[  309.580388] RBP: 00007f70bfeb7ff0 R08: 0000000000000007 R09: 00000000000=
01021
[  309.580391] R10: 0000000000001021 R11: 0000000000000246 R12: 00007ffd76d=
b4a20
[  309.580395] R13: 0000000000000000 R14: 0000000000000013 R15: 00005642c09=
06b60
[  309.580400] Modules linked in: uinput rfcomm cmac algif_hash algif_skcip=
her af_alg bnep xt_CHECKSUM xt_tcpudp bridge stp llc veth fuse intel_pmc_co=
re_pltdrv intel_pmc_core nft_chain_nat xt_MASQUERADE x86_pkg_temp_thermal i=
ntel_powerclamp snd_hda_codec_hdmi nf_nat kvm_intel nf_conntrack snd_soc_sk=
l joydev nf_defrag_ipv6 snd_soc_hdac_hda nf_defrag_ipv4 snd_hda_ext_core kv=
m snd_soc_sst_ipc snd_soc_sst_dsp iwlmvm btusb btrtl nft_compat snd_hda_cod=
ec_realtek snd_soc_acpi_intel_match intel_rapl_msr nft_counter btbcm mac802=
11 snd_hda_codec_generic btintel snd_soc_acpi irqbypass libarc4 snd_soc_cor=
e nf_tables snd_compress rapl intel_cstate efi_pstore bluetooth iwlwifi nfn=
etlink snd_hda_intel intel_uncore uvcvideo snd_intel_dspcfg binfmt_misc snd=
_hda_codec cdc_mbim videobuf2_vmalloc iTCO_wdt jitterentropy_rng cdc_wdm vi=
deobuf2_memops snd_hda_core nls_ascii intel_pmc_bxt pcspkr serio_raw efivar=
s nls_cp437 videobuf2_v4l2 snd_hwdep cdc_ncm drbg iTCO_vendor_support video=
buf2_common cdc_ether
[  309.580470]  intel_wmi_thunderbolt ansi_cprng snd_pcm vfat wmi_bmof usbn=
et videodev watchdog cfg80211 fat ecdh_generic cdc_acm mii snd_timer sg ecc=
 elan_i2c thinkpad_acpi mc ucsi_acpi mei_me nvram intel_xhci_usb_role_switc=
h typec_ucsi ledtrig_audio mei processor_thermal_device roles snd intel_rap=
l_common intel_pch_thermal intel_soc_dts_iosf soundcore tpm_crb typec int34=
03_thermal rfkill ac int340x_thermal_zone int3400_thermal tpm_tis tpm_tis_c=
ore acpi_thermal_rel tpm evdev rng_core acpi_pad nfsd auth_rpcgss nfs_acl l=
ockd coretemp parport_pc grace ppdev lp sunrpc parport efivarfs ip_tables x=
_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic btrfs zstd_compress =
dm_crypt dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq asyn=
c_xor async_tx xor sd_mod raid6_pq libcrc32c raid1 raid0 multipath linear m=
d_mod uas usb_storage scsi_mod i915 crc32_pclmul crc32c_intel ghash_clmulni=
_intel i2c_algo_bit drm_kms_helper aesni_intel nvme cec libaes xhci_pci cry=
pto_simd e1000e xhci_hcd drm
[  309.580553]  thunderbolt psmouse nvme_core cryptd glue_helper t10_pi crc=
_t10dif usbcore intel_lpss_pci ptp i2c_i801 crct10dif_generic intel_lpss pp=
s_core crct10dif_pclmul i2c_smbus idma64 crct10dif_common usb_common wmi ba=
ttery video button
[  309.580650] ---[ end trace a45ad813a0e97015 ]---
[  309.697883] RIP: 0010:__kmalloc_track_caller+0xa0/0x260
[  309.697887] Code: 24 65 49 8b 50 08 65 4c 03 05 94 cb 58 42 49 8b 00 48 =
89 04 24 48 85 c0 0f 84 9e 01 00 00 41 8b 4c 24 28 49 8b 3c 24 48 01 c1 <48=
> 8b 19 48 89 ce 49 33 9c 24 b8 00 00 00 48 8d 4a 01 48 0f ce 48
[  309.697888] RSP: 0018:ffffb66641fdf7a0 EFLAGS: 00010282
[  309.697889] RAX: a0ff333c4445d3e8 RBX: ffff9695b2abbc00 RCX: a0ff333c444=
5d408
[  309.697889] RDX: 00000000000092b4 RSI: 0000000000002800 RDI: 00000000000=
2f300
[  309.697890] RBP: 0000000000002800 R08: ffff9695e26af300 R09: ffff9695c28=
86210
[  309.697891] R10: 0000000000000000 R11: 0000000000000000 R12: ffff969287c=
43b00
[  309.697891] R13: 0000000000000028 R14: ffffffffbde1eeff R15: ffff969287c=
43b00
[  309.697893] FS:  00007f70c06ac580(0000) GS:ffff9695e2680000(0000) knlGS:=
0000000000000000
[  309.697894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  309.697894] CR2: 00007f1357354780 CR3: 000000044bcc2003 CR4: 00000000003=
706e0
[  309.697896] Kernel panic - not syncing: Fatal exception
[  309.698896] Kernel Offset: 0x3c800000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)


# dmesg 5/5

[    0.000000] Linux version 5.9.0-1-amd64 (debian-kernel@lists.debian.org)=
 (gcc-10 (Debian 10.2.0-15) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1=
) #1 SMP Debian 5.9.1-1 (2020-10-17)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64 root=3D/de=
v/mapper/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G-:512M
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000074f9cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000074f9d000-0x0000000074f9dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000074f9e000-0x0000000074f9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000074f9f000-0x000000007e8f7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e8f8000-0x000000007e9bdfff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007e9be000-0x000000007ff2bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ff2c000-0x000000007ff99fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007ff9a000-0x000000007fffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x0000000087ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000088600000-0x000000008c7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004727fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=3D0x7ff92000 SMBIOS=3D0x7f052000 SMBIOS 3.0=
=3D0x7f04f000 ACPI=3D0x7fffe000 ACPI 2.0=3D0x7fffe014 ESRT=3D0x7eeca000 MEM=
ATTR=3D0x7971d298=20
[    0.000000] secureboot: Secure boot could not be determined (mode 0)
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (1.12 ) 04/=
09/2018
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.001001] tsc: Detected 1999.968 MHz TSC
[    0.001001] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001003] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001011] last_pfn =3D 0x472800 max_arch_pfn =3D 0x400000000
[    0.001015] MTRR default type: write-back
[    0.001016] MTRR fixed ranges enabled:
[    0.001017]   00000-9FFFF write-back
[    0.001019]   A0000-BFFFF uncachable
[    0.001020]   C0000-FFFFF write-protect
[    0.001021] MTRR variable ranges enabled:
[    0.001022]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001024]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001025]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.001026]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.001027]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.001027]   5 disabled
[    0.001028]   6 disabled
[    0.001029]   7 disabled
[    0.001029]   8 disabled
[    0.001030]   9 disabled
[    0.001714] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001931] last_pfn =3D 0x80000 max_arch_pfn =3D 0x400000000
[    0.018627] esrt: Reserving ESRT space from 0x000000007eeca000 to 0x0000=
00007eeca088.
[    0.018635] kexec: Reserving the low 1M of memory for crashkernel
[    0.018639] Using GB pages for direct mapping
[    0.019307] RAMDISK: [mem 0x3161d000-0x34b05fff]
[    0.019316] ACPI: Early table checksum verification disabled
[    0.019319] ACPI: RSDP 0x000000007FFFE014 000024 (v02 LENOVO)
[    0.019323] ACPI: XSDT 0x000000007FFAD188 000124 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019329] ACPI: FACP 0x000000007FFE1000 0000F4 (v05 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019335] ACPI: DSDT 0x000000007FFBB000 0218A6 (v02 LENOVO SKL      00=
000000 INTL 20160527)
[    0.019338] ACPI: FACS 0x000000007FF3D000 000040
[    0.019341] ACPI: SSDT 0x000000007FFE9000 01320E (v02 LENOVO DptfTabl 00=
001000 INTL 20160527)
[    0.019345] ACPI: SSDT 0x000000007FFE8000 0003DB (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20160527)
[    0.019348] ACPI: TPM2 0x000000007FFE7000 000034 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019351] ACPI: UEFI 0x000000007FF53000 000042 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019354] ACPI: SSDT 0x000000007FFE3000 0030A3 (v02 LENOVO SaSsdt   00=
003000 INTL 20160527)
[    0.019357] ACPI: SSDT 0x000000007FFE2000 0005C6 (v02 LENOVO PerfTune 00=
001000 INTL 20160527)
[    0.019360] ACPI: HPET 0x000000007FFE0000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019363] ACPI: APIC 0x000000007FFDF000 00012C (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019366] ACPI: MCFG 0x000000007FFDE000 00003C (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019369] ACPI: ECDT 0x000000007FFDD000 000053 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019372] ACPI: SSDT 0x000000007FFB9000 001C9C (v02 LENOVO RVP7Rtd3 00=
001000 INTL 20160527)
[    0.019375] ACPI: SSDT 0x000000007FFB7000 00163C (v02 LENOVO ProjSsdt 00=
000010 INTL 20160527)
[    0.019378] ACPI: BOOT 0x000000007FFB6000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019382] ACPI: BATB 0x000000007FFB5000 00004A (v02 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019385] ACPI: SLIC 0x000000007FFB4000 000176 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019388] ACPI: SSDT 0x000000007FFB2000 0017AE (v02 LENOVO CpuSsdt  00=
003000 INTL 20160527)
[    0.019391] ACPI: SSDT 0x000000007FFB1000 00056D (v02 LENOVO CtdpB    00=
001000 INTL 20160527)
[    0.019394] ACPI: SSDT 0x000000007FFB0000 000678 (v02 LENOVO UsbCTabl 00=
001000 INTL 20160527)
[    0.019397] ACPI: LPIT 0x000000007FFAF000 000094 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019400] ACPI: WSMT 0x000000007FFAE000 000028 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019403] ACPI: SSDT 0x000000007FFFD000 0001D8 (v02 LENOVO HdaDsp   00=
000000 INTL 20160527)
[    0.019407] ACPI: SSDT 0x000000007FFAC000 0004FC (v02 LENOVO TbtTypeC 00=
000000 INTL 20160527)
[    0.019410] ACPI: SSDT 0x000000007FFAB000 0002D1 (v02 LENOVO Wwan     00=
000001 INTL 20160527)
[    0.019413] ACPI: DBGP 0x000000007FFAA000 000034 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019416] ACPI: DBG2 0x000000007FFA9000 000054 (v00 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019419] ACPI: MSDM 0x000000007FFA8000 000055 (v03 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019422] ACPI: DMAR 0x000000007FFA7000 0000CC (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019425] ACPI: ASF! 0x000000007FFA6000 0000A0 (v32 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019428] ACPI: FPDT 0x000000007FFA5000 000044 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019431] ACPI: BGRT 0x000000007FFA4000 000038 (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019434] ACPI: UEFI 0x000000007FF3A000 00013E (v01 LENOVO TP-N22   00=
001120 PTEC 00000002)
[    0.019442] ACPI: Local APIC address 0xfee00000
[    0.019546] No NUMA configuration found
[    0.019547] Faking a node at [mem 0x0000000000000000-0x00000004727fffff]
[    0.019551] NODE_DATA(0) allocated [mem 0x4727fb000-0x4727fffff]
[    0.019578] Reserving 512MB of memory at 1280MB for crashkernel (System =
RAM: 16144MB)
[    0.019609] Zone ranges:
[    0.019610]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.019612]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.019613]   Normal   [mem 0x0000000100000000-0x00000004727fffff]
[    0.019614]   Device   empty
[    0.019615] Movable zone start for each node
[    0.019616] Early memory node ranges
[    0.019617]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.019618]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.019619]   node   0: [mem 0x0000000000100000-0x0000000074f9cfff]
[    0.019620]   node   0: [mem 0x0000000074f9f000-0x000000007e8f7fff]
[    0.019621]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.019622]   node   0: [mem 0x0000000100000000-0x00000004727fffff]
[    0.019910] Zeroed struct page in unavailable ranges: 28526 pages
[    0.019912] Initmem setup node 0 [mem 0x0000000000001000-0x00000004727ff=
fff]
[    0.019914] On node 0 totalpages: 4133010
[    0.019915]   DMA zone: 64 pages used for memmap
[    0.019916]   DMA zone: 155 pages reserved
[    0.019917]   DMA zone: 3995 pages, LIFO batch:0
[    0.019960]   DMA32 zone: 8036 pages used for memmap
[    0.019961]   DMA32 zone: 514295 pages, LIFO batch:63
[    0.025581]   Normal zone: 56480 pages used for memmap
[    0.025582]   Normal zone: 3614720 pages, LIFO batch:63
[    0.025977] Reserving Intel graphics memory at [mem 0x8a800000-0x8c7ffff=
f]
[    0.026345] ACPI: PM-Timer IO Port: 0x1808
[    0.026347] ACPI: Local APIC address 0xfee00000
[    0.026355] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.026356] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.026357] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.026357] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.026358] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.026359] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.026359] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.026360] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.026361] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.026361] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.026362] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.026363] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.026363] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.026364] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.026365] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.026366] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.026393] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.026395] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026397] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.026399] ACPI: IRQ0 used by override.
[    0.026400] ACPI: IRQ9 used by override.
[    0.026402] Using ACPI (MADT) for SMP configuration information
[    0.026404] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.026421] e820: update [mem 0x783d7000-0x784d6fff] usable =3D=3D> rese=
rved
[    0.026430] TSC deadline timer available
[    0.026432] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.026453] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.026455] PM: hibernation: Registered nosave memory: [mem 0x00058000-0=
x00058fff]
[    0.026457] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x000fffff]
[    0.026459] PM: hibernation: Registered nosave memory: [mem 0x74f9d000-0=
x74f9dfff]
[    0.026460] PM: hibernation: Registered nosave memory: [mem 0x74f9e000-0=
x74f9efff]
[    0.026462] PM: hibernation: Registered nosave memory: [mem 0x783d7000-0=
x784d6fff]
[    0.026463] PM: hibernation: Registered nosave memory: [mem 0x7e8f8000-0=
x7e9bdfff]
[    0.026464] PM: hibernation: Registered nosave memory: [mem 0x7e9be000-0=
x7ff2bfff]
[    0.026465] PM: hibernation: Registered nosave memory: [mem 0x7ff2c000-0=
x7ff99fff]
[    0.026466] PM: hibernation: Registered nosave memory: [mem 0x7ff9a000-0=
x7fffefff]
[    0.026467] PM: hibernation: Registered nosave memory: [mem 0x80000000-0=
x87ffffff]
[    0.026468] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x885fffff]
[    0.026469] PM: hibernation: Registered nosave memory: [mem 0x88600000-0=
x8c7fffff]
[    0.026470] PM: hibernation: Registered nosave memory: [mem 0x8c800000-0=
xf7ffffff]
[    0.026470] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]
[    0.026471] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfe00ffff]
[    0.026472] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0=
xfe010fff]
[    0.026472] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xffffffff]
[    0.026474] [mem 0x8c800000-0xf7ffffff] available for PCI devices
[    0.026476] Booting paravirtualized kernel on bare hardware
[    0.026479] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.033068] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.033334] percpu: Embedded 55 pages/cpu s184920 r8192 d32168 u262144
[    0.033342] pcpu-alloc: s184920 r8192 d32168 u262144 alloc=3D1*2097152
[    0.033343] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.033370] Built 1 zonelists, mobility grouping on.  Total pages: 40682=
75
[    0.033370] Policy zone: Normal
[    0.033372] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64 roo=
t=3D/dev/mapper/linus--work--vg-root ro quiet crashkernel=3D384M-8G:128M,8G=
-:512M
[    0.034787] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.035425] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.035534] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.057381] Memory: 1494204K/16532040K available (12291K kernel code, 13=
19K rwdata, 3764K rodata, 1636K init, 1752K bss, 1023360K reserved, 0K cma-=
reserved)
[    0.057391] random: get_random_u64 called from __kmem_cache_create+0x2e/=
0x540 with crng_init=3D0
[    0.057547] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.057561] Kernel/User page tables isolation: enabled
[    0.057584] ftrace: allocating 34815 entries in 136 pages
[    0.075079] ftrace: allocated 136 pages with 2 groups
[    0.075238] rcu: Hierarchical RCU implementation.
[    0.075239] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D8.
[    0.075240] 	Rude variant of Tasks RCU enabled.
[    0.075241] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.075242] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.079715] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.080109] random: crng done (trusting CPU's manufacturer)
[    0.080138] Console: colour dummy device 80x25
[    0.080143] printk: console [tty0] enabled
[    0.080165] ACPI: Core revision 20200717
[    0.080652] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    0.080721] APIC: Switch to symmetric I/O mode setup
[    0.080723] DMAR: Host address width 39
[    0.080725] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.080731] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 19e2ff0505e
[    0.080733] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.080738] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.080739] DMAR: RMRR base: 0x0000007f47f000 end: 0x0000007f49efff
[    0.080741] DMAR: RMRR base: 0x0000008a000000 end: 0x0000008c7fffff
[    0.080742] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.080744] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.080745] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.080746] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.082372] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082374] x2apic enabled
[    0.082387] Switched APIC routing to cluster x2apic.
[    0.086511] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.104597] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x39a8208cdd2, max_idle_ns: 881590748921 ns
[    0.104602] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3999.93 BogoMIPS (lpj=3D7999872)
[    0.104605] pid_max: default: 32768 minimum: 301
[    0.108632] LSM: Security Framework initializing
[    0.108640] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.108686] AppArmor: AppArmor initialized
[    0.108688] TOMOYO Linux initialized
[    0.108739] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.108769] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.109098] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.109131] process: using mwait in idle threads
[    0.109135] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.109136] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.109139] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.109141] Spectre V2 : Mitigation: Full generic retpoline
[    0.109141] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.109142] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.109143] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.109144] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.109145] Speculative Store Bypass: Vulnerable
[    0.109147] SRBDS: Vulnerable: No microcode
[    0.109148] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.109418] Freeing SMP alternatives memory: 32K
[    0.112695] smpboot: CPU0: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz (fam=
ily: 0x6, model: 0x8e, stepping: 0xa)
[    0.112843] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112867] ... version:                4
[    0.112868] ... bit width:              48
[    0.112868] ... generic registers:      4
[    0.112869] ... value mask:             0000ffffffffffff
[    0.112870] ... max period:             00007fffffffffff
[    0.112870] ... fixed-purpose events:   3
[    0.112871] ... event mask:             000000070000000f
[    0.112925] rcu: Hierarchical SRCU implementation.
[    0.113732] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.113827] smp: Bringing up secondary CPUs ...
[    0.113941] x86: Booting SMP configuration:
[    0.113942] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.117268] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.117268]  #5 #6 #7
[    0.117428] smp: Brought up 1 node, 8 CPUs
[    0.117428] smpboot: Max logical packages: 1
[    0.117428] smpboot: Total of 8 processors activated (31999.48 BogoMIPS)
[    0.148908] node 0 deferred pages initialised in 28ms
[    0.149021] devtmpfs: initialized
[    0.149021] x86/mm: Memory block size: 128MB
[    0.150137] PM: Registering ACPI NVS region [mem 0x74f9d000-0x74f9dfff] =
(4096 bytes)
[    0.150137] PM: Registering ACPI NVS region [mem 0x7ff2c000-0x7ff99fff] =
(450560 bytes)
[    0.150137] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.150137] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.150137] pinctrl core: initialized pinctrl subsystem
[    0.150137] NET: Registered protocol family 16
[    0.150137] audit: initializing netlink subsys (disabled)
[    0.150137] audit: type=3D2000 audit(1604762306.068:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.150137] thermal_sys: Registered thermal governor 'fair_share'
[    0.150137] thermal_sys: Registered thermal governor 'bang_bang'
[    0.150137] thermal_sys: Registered thermal governor 'step_wise'
[    0.150137] thermal_sys: Registered thermal governor 'user_space'
[    0.150137] cpuidle: using governor ladder
[    0.150137] cpuidle: using governor menu
[    0.150137] Simple Boot Flag at 0x47 set to 0x1
[    0.150137] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.150137] ACPI: bus type PCI registered
[    0.150137] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.150137] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.150137] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.150137] PCI: Using configuration type 1 for base access
[    0.152626] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.153824] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.153824] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.349155] ACPI: Added _OSI(Module Device)
[    0.349155] ACPI: Added _OSI(Processor Device)
[    0.349155] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.349155] ACPI: Added _OSI(Processor Aggregator Device)
[    0.349155] ACPI: Added _OSI(Linux-Dell-Video)
[    0.349155] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.349155] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.415465] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.417138] ACPI: EC: EC started
[    0.417138] ACPI: EC: interrupt blocked
[    0.419538] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.419539] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.421625] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.497490] ACPI: Dynamic OEM Table Load:
[    0.497507] ACPI: SSDT 0xFFFF9387477D8800 0005CD (v02 PmRef  Cpu0Ist  00=
003000 INTL 20160527)
[    0.499342] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.500805] ACPI: Dynamic OEM Table Load:
[    0.500816] ACPI: SSDT 0xFFFF93874726D000 0003FF (v02 PmRef  Cpu0Cst  00=
003001 INTL 20160527)
[    0.502643] ACPI: Dynamic OEM Table Load:
[    0.502652] ACPI: SSDT 0xFFFF9387472AE240 0000BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20160527)
[    0.504340] ACPI: Dynamic OEM Table Load:
[    0.504349] ACPI: SSDT 0xFFFF9387477DD000 000628 (v02 PmRef  HwpLvt   00=
003000 INTL 20160527)
[    0.506517] ACPI: Dynamic OEM Table Load:
[    0.506530] ACPI: SSDT 0xFFFF938747266000 000D14 (v02 PmRef  ApIst    00=
003000 INTL 20160527)
[    0.509158] ACPI: Dynamic OEM Table Load:
[    0.509167] ACPI: SSDT 0xFFFF93874726D800 000317 (v02 PmRef  ApHwp    00=
003000 INTL 20160527)
[    0.511039] ACPI: Dynamic OEM Table Load:
[    0.511047] ACPI: SSDT 0xFFFF93874726AC00 00030A (v02 PmRef  ApCst    00=
003000 INTL 20160527)
[    0.516328] ACPI: Interpreter enabled
[    0.516400] ACPI: (supports S0 S3 S4 S5)
[    0.516401] ACPI: Using IOAPIC for interrupt routing
[    0.516455] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.517337] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.522155] ACPI: Power Resource [PUBS] (on)
[    0.552877] ACPI: Power Resource [PXP] (on)
[    0.574281] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.574288] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.577095] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.578693] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR]
[    0.578694] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.581400] PCI host bridge to bus 0000:00
[    0.581403] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.581405] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.581406] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.581408] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]
[    0.581409] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]
[    0.581410] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]
[    0.581411] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]
[    0.581412] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]
[    0.581413] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]
[    0.581414] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]
[    0.581415] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]
[    0.581417] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]
[    0.581418] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]
[    0.581419] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]
[    0.581420] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]
[    0.581421] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ffff=
f window]
[    0.581423] pci_bus 0000:00: root bus resource [mem 0x8c800000-0xf7fffff=
f window]
[    0.581424] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    0.581425] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.581443] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.582569] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.582584] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.582592] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.582598] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.582621] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.583766] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.583779] pci 0000:00:04.0: reg 0x10: [mem 0xe8240000-0xe8247fff 64bit]
[    0.585015] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.585030] pci 0000:00:08.0: reg 0x10: [mem 0xe8250000-0xe8250fff 64bit]
[    0.586191] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.586211] pci 0000:00:14.0: reg 0x10: [mem 0xe8220000-0xe822ffff 64bit]
[    0.586291] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.587567] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.587588] pci 0000:00:14.2: reg 0x10: [mem 0xe8251000-0xe8251fff 64bit]
[    0.592898] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.593105] pci 0000:00:15.0: reg 0x10: [mem 0xe8252000-0xe8252fff 64bit]
[    0.595133] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.595157] pci 0000:00:16.0: reg 0x10: [mem 0xe8253000-0xe8253fff 64bit]
[    0.595228] pci 0000:00:16.0: PME# supported from D3hot
[    0.596437] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.597576] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.598781] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.599899] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.599919] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround ena=
bled
[    0.601129] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.601219] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.601240] pci 0000:00:1c.6: Intel SPT PCH root port ACS workaround ena=
bled
[    0.602442] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.602547] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.602571] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround ena=
bled
[    0.603800] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.605095] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.605110] pci 0000:00:1f.2: reg 0x10: [mem 0xe824c000-0xe824ffff]
[    0.606328] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.606354] pci 0000:00:1f.3: reg 0x10: [mem 0xe8248000-0xe824bfff 64bit]
[    0.606391] pci 0000:00:1f.3: reg 0x20: [mem 0xe8230000-0xe823ffff 64bit]
[    0.606449] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.607681] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.607733] pci 0000:00:1f.4: reg 0x10: [mem 0xe8254000-0xe82540ff 64bit]
[    0.607784] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.609024] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.609044] pci 0000:00:1f.6: reg 0x10: [mem 0xe8200000-0xe821ffff]
[    0.609156] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.610377] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.610466] pci 0000:04:00.0: [8086:15c0] type 01 class 0x060400
[    0.610525] pci 0000:04:00.0: enabling Extended Tags
[    0.610618] pci 0000:04:00.0: supports D1 D2
[    0.610619] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.610790] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.610795] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.610800] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.610882] pci 0000:05:00.0: [8086:15c0] type 01 class 0x060400
[    0.610944] pci 0000:05:00.0: enabling Extended Tags
[    0.611039] pci 0000:05:00.0: supports D1 D2
[    0.611040] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.611173] pci 0000:05:01.0: [8086:15c0] type 01 class 0x060400
[    0.611234] pci 0000:05:01.0: enabling Extended Tags
[    0.611332] pci 0000:05:01.0: supports D1 D2
[    0.611333] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.611466] pci 0000:05:02.0: [8086:15c0] type 01 class 0x060400
[    0.611528] pci 0000:05:02.0: enabling Extended Tags
[    0.611621] pci 0000:05:02.0: supports D1 D2
[    0.611622] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.611783] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.611793] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.611799] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.611874] pci 0000:06:00.0: [8086:15bf] type 00 class 0x088000
[    0.611897] pci 0000:06:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.611910] pci 0000:06:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.611977] pci 0000:06:00.0: enabling Extended Tags
[    0.612089] pci 0000:06:00.0: supports D1 D2
[    0.612090] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.612266] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.612275] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.612327] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.612337] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.612343] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.612432] pci 0000:3c:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.612456] pci 0000:3c:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.612541] pci 0000:3c:00.0: enabling Extended Tags
[    0.612657] pci 0000:3c:00.0: supports D1 D2
[    0.612658] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.612751] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limit=
ed by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    0.612870] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.612880] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.613195] pci 0000:3d:00.0: [8086:24fd] type 00 class 0x028000
[    0.613232] pci 0000:3d:00.0: reg 0x10: [mem 0xe8100000-0xe8101fff 64bit]
[    0.613670] pci 0000:3d:00.0: PME# supported from D0 D3hot D3cold
[    0.614256] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.614260] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.614512] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    0.614535] pci 0000:3e:00.0: reg 0x10: [mem 0xe8000000-0xe8003fff 64bit]
[    0.614995] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.614999] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.618108] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618175] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.618237] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618298] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618360] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618421] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618481] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.618543] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.619422] ACPI: EC: interrupt unblocked
[    0.619423] ACPI: EC: event unblocked
[    0.619436] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.619436] ACPI: EC: GPE=3D0x16
[    0.619439] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.619440] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.619539] iommu: Default domain type: Translated=20
[    0.619555] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.619555] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.619555] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.619555] vgaarb: loaded
[    0.619555] EDAC MC: Ver: 3.0.0
[    0.619555] Registered efivars operations
[    0.619555] NetLabel: Initializing
[    0.619555] NetLabel:  domain hash size =3D 128
[    0.619555] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.619555] NetLabel:  unlabeled traffic allowed by default
[    0.619555] PCI: Using ACPI for IRQ routing
[    0.622944] PCI: pci_cache_line_size set to 64 bytes
[    0.623701] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.623702] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.623703] e820: reserve RAM buffer [mem 0x74f9d000-0x77ffffff]
[    0.623705] e820: reserve RAM buffer [mem 0x783d7000-0x7bffffff]
[    0.623706] e820: reserve RAM buffer [mem 0x7e8f8000-0x7fffffff]
[    0.623707] e820: reserve RAM buffer [mem 0x472800000-0x473ffffff]
[    0.623748] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.623752] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.626654] clocksource: Switched to clocksource tsc-early
[    0.637561] VFS: Disk quotas dquot_6.6.0
[    0.637593] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.637736] AppArmor: AppArmor Filesystem Enabled
[    0.637754] pnp: PnP ACPI init
[    0.638014] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.638017] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.638018] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.638021] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.638022] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.638024] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.638025] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.638031] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.638478] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.638482] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.639009] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.639010] system 00:02: [io  0xffff] has been reserved
[    0.639012] system 00:02: [io  0xffff] has been reserved
[    0.639013] system 00:02: [io  0xffff] has been reserved
[    0.639014] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.639016] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.639020] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.639161] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.639219] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.639223] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    0.639246] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.639268] pnp 00:06: Plug and Play ACPI device, IDs LEN008f PNP0f13 (a=
ctive)
[    0.639402] system 00:07: [io  0x1800-0x189f] could not be reserved
[    0.639404] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.639405] system 00:07: [io  0x0880-0x08ff] has been reserved
[    0.639407] system 00:07: [io  0x0900-0x097f] has been reserved
[    0.639408] system 00:07: [io  0x0980-0x09ff] has been reserved
[    0.639410] system 00:07: [io  0x0a00-0x0a7f] has been reserved
[    0.639411] system 00:07: [io  0x0a80-0x0aff] has been reserved
[    0.639413] system 00:07: [io  0x0b00-0x0b7f] has been reserved
[    0.639414] system 00:07: [io  0x0b80-0x0bff] has been reserved
[    0.639415] system 00:07: [io  0x15e0-0x15ef] has been reserved
[    0.639417] system 00:07: [io  0x1600-0x167f] could not be reserved
[    0.639418] system 00:07: [io  0x1640-0x165f] could not be reserved
[    0.639421] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.639423] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.639424] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.639426] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.639427] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.639429] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.639430] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.639432] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.639436] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.641199] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.641201] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.641202] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.641207] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.642387] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reser=
ved
[    0.642388] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.642390] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.642392] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.642393] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.642395] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.642396] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.642398] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.642399] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.642401] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.642405] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.642753] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.642754] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.642756] system 00:0a: [mem 0x00100000-0x8c7fffff] could not be reser=
ved
[    0.642758] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.642759] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.642763] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.642936] pnp: PnP ACPI: found 11 devices
[    0.648963] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.649033] NET: Registered protocol family 2
[    0.649209] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.649321] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.649570] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.649676] TCP: Hash tables configured (established 131072 bind 65536)
[    0.649735] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.649796] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.649877] NET: Registered protocol family 1
[    0.649883] NET: Registered protocol family 44
[    0.649892] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000
[    0.649895] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.649897] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000
[    0.649900] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus =
07-3b] add_size 1000
[    0.649903] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus =
05-3c] add_size 1000
[    0.649904] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus =
04-3c] add_size 2000
[    0.649934] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8c800000-0x8c9ffff=
f]
[    0.649946] pci 0000:00:1c.0: BAR 15: assigned [mem 0x8ca00000-0x8cbffff=
f 64bit pref]
[    0.649949] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.649951] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x4fff]
[    0.649954] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.649959] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.649963] pci 0000:00:1c.0:   bridge window [mem 0x8c800000-0x8c9fffff]
[    0.649967] pci 0000:00:1c.0:   bridge window [mem 0x8ca00000-0x8cbfffff=
 64bit pref]
[    0.649973] pci 0000:04:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.649975] pci 0000:05:01.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.649977] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.649983] pci 0000:05:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.649992] pci 0000:05:01.0: PCI bridge to [bus 07-3b]
[    0.649995] pci 0000:05:01.0:   bridge window [io  0x3000-0x3fff]
[    0.650000] pci 0000:05:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.650004] pci 0000:05:01.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.650011] pci 0000:05:02.0: PCI bridge to [bus 3c]
[    0.650017] pci 0000:05:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.650026] pci 0000:04:00.0: PCI bridge to [bus 05-3c]
[    0.650029] pci 0000:04:00.0:   bridge window [io  0x3000-0x3fff]
[    0.650034] pci 0000:04:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.650038] pci 0000:04:00.0:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.650044] pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
[    0.650046] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.650050] pci 0000:00:1c.4:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.650053] pci 0000:00:1c.4:   bridge window [mem 0x90000000-0xb1ffffff=
 64bit pref]
[    0.650058] pci 0000:00:1c.6: PCI bridge to [bus 3d]
[    0.650062] pci 0000:00:1c.6:   bridge window [mem 0xe8100000-0xe81fffff]
[    0.650068] pci 0000:00:1d.0: PCI bridge to [bus 3e]
[    0.650074] pci 0000:00:1d.0:   bridge window [mem 0xe8000000-0xe80fffff]
[    0.650083] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.650084] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.650085] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.650087] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.650088] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.650089] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.650090] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.650092] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.650093] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.650094] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.650095] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.650096] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.650098] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.650099] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.650100] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.650101] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff wind=
ow]
[    0.650102] pci_bus 0000:00: resource 20 [mem 0x8c800000-0xf7ffffff wind=
ow]
[    0.650104] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.650105] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.650106] pci_bus 0000:01: resource 1 [mem 0x8c800000-0x8c9fffff]
[    0.650107] pci_bus 0000:01: resource 2 [mem 0x8ca00000-0x8cbfffff 64bit=
 pref]
[    0.650109] pci_bus 0000:04: resource 0 [io  0x3000-0x4fff]
[    0.650110] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.650111] pci_bus 0000:04: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.650112] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.650114] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.650115] pci_bus 0000:05: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.650116] pci_bus 0000:06: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.650117] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.650119] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.650120] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit=
 pref]
[    0.650121] pci_bus 0000:3c: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.650123] pci_bus 0000:3d: resource 1 [mem 0xe8100000-0xe81fffff]
[    0.650124] pci_bus 0000:3e: resource 1 [mem 0xe8000000-0xe80fffff]
[    0.650302] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.650834] pci 0000:04:00.0: enabling device (0006 -> 0007)
[    0.651426] PCI: CLS 128 bytes, default 64
[    0.651476] Trying to unpack rootfs image as initramfs...
[    1.870562] Freeing initrd memory: 54180K
[    1.870714] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:1=
5.0
[    1.870731] DMAR: No ATSR found
[    1.870791] DMAR: dmar0: Using Queued invalidation
[    1.870797] DMAR: dmar1: Using Queued invalidation
[    1.871144] pci 0000:00:00.0: Adding to iommu group 0
[    1.871157] pci 0000:00:02.0: Adding to iommu group 1
[    1.871169] pci 0000:00:04.0: Adding to iommu group 2
[    1.871181] pci 0000:00:08.0: Adding to iommu group 3
[    1.871204] pci 0000:00:14.0: Adding to iommu group 4
[    1.871216] pci 0000:00:14.2: Adding to iommu group 4
[    1.871232] pci 0000:00:15.0: Adding to iommu group 5
[    1.871249] pci 0000:00:16.0: Adding to iommu group 6
[    1.871297] pci 0000:00:1c.0: Adding to iommu group 7
[    1.871310] pci 0000:00:1c.4: Adding to iommu group 8
[    1.871326] pci 0000:00:1c.6: Adding to iommu group 9
[    1.871341] pci 0000:00:1d.0: Adding to iommu group 10
[    1.871382] pci 0000:00:1f.0: Adding to iommu group 11
[    1.871394] pci 0000:00:1f.2: Adding to iommu group 11
[    1.871406] pci 0000:00:1f.3: Adding to iommu group 11
[    1.871419] pci 0000:00:1f.4: Adding to iommu group 11
[    1.871431] pci 0000:00:1f.6: Adding to iommu group 11
[    1.871444] pci 0000:04:00.0: Adding to iommu group 12
[    1.871459] pci 0000:05:00.0: Adding to iommu group 13
[    1.871472] pci 0000:05:01.0: Adding to iommu group 14
[    1.871485] pci 0000:05:02.0: Adding to iommu group 15
[    1.871490] pci 0000:06:00.0: Adding to iommu group 13
[    1.871494] pci 0000:3c:00.0: Adding to iommu group 15
[    1.871508] pci 0000:3d:00.0: Adding to iommu group 16
[    1.871523] pci 0000:3e:00.0: Adding to iommu group 17
[    1.875221] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.875222] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.875224] software IO TLB: mapped [mem 0x79f2f000-0x7df2f000] (64MB)
[    1.875838] Initialise system trusted keyrings
[    1.875850] Key type blacklist registered
[    1.875914] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.877349] zbud: loaded
[    1.877553] integrity: Platform Keyring initialized
[    1.877555] Key type asymmetric registered
[    1.877557] Asymmetric key parser 'x509' registered
[    1.877565] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    1.877618] io scheduler mq-deadline registered
[    1.878057] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.878090] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.878270] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    1.878294] pcieport 0000:00:1c.4: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.878587] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    1.878838] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.879208] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
[    1.879348] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.879675] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.879695] efifb: probing for efifb
[    1.879713] efifb: framebuffer at 0xc0000000, using 14400k, total 14400k
[    1.879714] efifb: mode is 2560x1440x32, linelength=3D10240, pages=3D1
[    1.879714] efifb: scrolling: redraw
[    1.879716] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.879826] Console: switching to colour frame buffer device 160x45
[    1.889316] fb0: EFI VGA frame buffer device
[    1.889345] intel_idle: MWAIT substates: 0x11142120
[    1.889346] intel_idle: v0.5.1 model 0x8E
[    1.889999] intel_idle: Local APIC timer is reliable in all C-states
[    1.894824] thermal LNXTHERM:00: registered as thermal_zone0
[    1.894825] ACPI: Thermal Zone [THM0] (50 C)
[    1.895084] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.895842] Linux agpgart interface v0.103
[    1.895889] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.895890] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    1.896683] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.898600] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.898605] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.898930] mousedev: PS/2 mouse device common for all mice
[    1.898987] rtc_cmos 00:03: RTC can wake from S4
[    1.899648] rtc_cmos 00:03: registered as rtc0
[    1.899817] rtc_cmos 00:03: setting system clock to 2020-11-07T15:18:28 =
UTC (1604762308)
[    1.899852] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[    1.899863] intel_pstate: Intel P-state driver initializing
[    1.900814] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.900867] intel_pstate: HWP enabled
[    1.900993] ledtrig-cpu: registered to indicate activity on CPUs
[    1.901387] NET: Registered protocol family 10
[    1.908490] Segment Routing with IPv6
[    1.908509] mip6: Mobile IPv6
[    1.908513] NET: Registered protocol family 17
[    1.908544] mpls_gso: MPLS GSO support
[    1.909144] microcode: sig=3D0x806ea, pf=3D0x80, revision=3D0x84
[    1.909356] microcode: Microcode Update Driver: v2.2.
[    1.909358] IPI shorthand broadcast: enabled
[    1.909365] sched_clock: Marking stable (1908523815, 545488)->(191586503=
5, -6795732)
[    1.909611] registered taskstats version 1
[    1.909612] Loading compiled-in X.509 certificates
[    1.930930] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f61=
49f3dd27dfcc5cbb419ea1'
[    1.930940] Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b=
9'
[    1.930976] zswap: loaded using pool lzo/zbud
[    1.931372] Key type ._fscrypt registered
[    1.931372] Key type .fscrypt registered
[    1.931373] Key type fscrypt-provisioning registered
[    1.931393] AppArmor: AppArmor sha1 policy hashing enabled
[    1.932143] integrity: Loading X.509 certificate: UEFI:db
[    1.932155] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.932155] integrity: Loading X.509 certificate: UEFI:db
[    1.932180] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.932180] integrity: Loading X.509 certificate: UEFI:db
[    1.932192] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.932192] integrity: Loading X.509 certificate: UEFI:db
[    1.932202] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.934228] Freeing unused kernel image (initmem) memory: 1636K
[    1.961017] Write protecting the kernel read-only data: 18432k
[    1.961536] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.961725] Freeing unused kernel image (rodata/data gap) memory: 332K
[    1.999676] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.999676] x86/mm: Checking user space page tables
[    2.035698] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.035701] Run /init as init process
[    2.035702]   with arguments:
[    2.035702]     /init
[    2.035702]   with environment:
[    2.035703]     HOME=3D/
[    2.035703]     TERM=3Dlinux
[    2.035703]     BOOT_IMAGE=3D/vmlinuz-5.9.0-1-amd64
[    2.035704]     crashkernel=3D384M-8G:128M,8G-:512M
[    2.106461] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    2.113988] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.114048] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:01)
[    2.120625] ACPI: Sleep Button [SLPB]
[    2.120668] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input3
[    2.120693] ACPI: Lid Switch [LID]
[    2.120726] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input4
[    2.120751] ACPI: Power Button [PWRF]
[    2.123127] ACPI: bus type USB registered
[    2.123136] usbcore: registered new interface driver usbfs
[    2.123140] usbcore: registered new interface driver hub
[    2.123159] usbcore: registered new device driver usb
[    2.123224] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    2.123464] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    2.129946] battery: ACPI: Battery Slot [BAT0] (battery present)
[    2.130931] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.130936] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    2.132018] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000081109810
[    2.132163] xhci_hcd 0000:00:14.0: cache line size of 128 is not support=
ed
[    2.132327] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.132328] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.132329] usb usb1: Product: xHCI Host Controller
[    2.132330] usb usb1: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.132331] usb usb1: SerialNumber: 0000:00:14.0
[    2.132418] hub 1-0:1.0: USB hub found
[    2.132432] hub 1-0:1.0: 12 ports detected
[    2.133265] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.133267] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    2.133269] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.133292] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.133293] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.133294] usb usb2: Product: xHCI Host Controller
[    2.133294] usb usb2: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.133295] usb usb2: SerialNumber: 0000:00:14.0
[    2.133374] hub 2-0:1.0: USB hub found
[    2.133383] hub 2-0:1.0: 6 ports detected
[    2.133670] usb: port power management may be unreliable
[    2.133844] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.133847] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 3
[    2.134979] xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    2.135163] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    2.135164] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.135165] usb usb3: Product: xHCI Host Controller
[    2.135166] usb usb3: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.135167] usb usb3: SerialNumber: 0000:3c:00.0
[    2.135243] hub 3-0:1.0: USB hub found
[    2.135250] hub 3-0:1.0: 2 ports detected
[    2.135576] xhci_hcd 0000:3c:00.0: xHCI Host Controller
[    2.135578] xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus =
number 4
[    2.135580] xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.135607] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    2.135608] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.135609] usb usb4: Product: xHCI Host Controller
[    2.135609] usb usb4: Manufacturer: Linux 5.9.0-1-amd64 xhci-hcd
[    2.135610] usb usb4: SerialNumber: 0000:3c:00.0
[    2.135662] hub 4-0:1.0: USB hub found
[    2.135668] hub 4-0:1.0: 2 ports detected
[    2.136025] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    2.136107] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.136137] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.137201] i2c i2c-1: 2/2 memory slots populated (from DMI)
[    2.137870] i2c i2c-1: Successfully instantiated SPD at 0x51
[    2.138322] pps_core: LinuxPPS API ver. 1 registered
[    2.138323] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.139438] PTP clock support registered
[    2.140567] cryptd: max_cpu_qlen set to 1000
[    2.145155] nvme nvme0: pci function 0000:3e:00.0
[    2.147046] AVX2 version of gcm_enc/dec engaged.
[    2.147046] AES CTR mode by8 optimization enabled
[    2.152160] e1000e: Intel(R) PRO/1000 Network Driver
[    2.152161] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.152383] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    2.155181] nvme nvme0: Shutdown timeout set to 8 seconds
[    2.174621] nvme nvme0: 8/0/0 default/read/poll queues
[    2.178273]  nvme0n1: p1 p2 p3
[    2.220132] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    2.220740] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.220741] checking generic (c0000000 e10000) vs hw (e7000000 1000000)
[    2.220742] checking generic (c0000000 e10000) vs hw (c0000000 10000000)
[    2.220742] fb0: switching to inteldrmfb from EFI VGA
[    2.220784] Console: switching to colour dummy device 80x25
[    2.220803] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.222009] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    2.222051] i915 0000:00:02.0: firmware: failed to load i915/kbl_dmc_ver=
1_04.bin (-2)
[    2.222053] firmware_class: See https://wiki.debian.org/Firmware for inf=
ormation about missing firmware
[    2.222054] i915 0000:00:02.0: Direct firmware load for i915/kbl_dmc_ver=
1_04.bin failed with error -2
[    2.222055] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/kb=
l_dmc_ver1_04.bin. Disabling runtime power management.
[    2.222056] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    2.227667] i915 0000:00:02.0: [drm] Reducing the compressed framebuffer=
 size. This may lead to less power savings than a non-reduced-size. Try to =
increase stolen memory size if available in BIOS.
[    2.238199] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on mi=
nor 0
[    2.239921] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.240133] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input6
[    2.353862] fbcon: i915drmfb (fb0) is primary device
[    2.396354] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[    2.463699] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 8c:=
16:45:66:ba:11
[    2.463702] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    2.463798] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0=
FF
[    2.465774] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.468716] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.629777] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
9540, bcdDevice=3D 1.20
[    2.629780] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.629783] usb 1-3: Product: EMV Smartcard Reader
[    2.629785] usb 1-3: Manufacturer: Generic
[    2.642289] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x7f3001)
[    2.653287] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0f.
[    2.664766] psmouse serio1: elantech: Elan sample query result 00, 20, c9
[    2.687566] psmouse serio1: elantech: Trying to set up SMBus access
[    2.744977] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    2.779669] usb 2-3: New USB device found, idVendor=3D0bda, idProduct=3D=
0316, bcdDevice=3D 2.04
[    2.779673] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.779675] usb 2-3: Product: USB3.0-CRW
[    2.779677] usb 2-3: Manufacturer: Generic
[    2.779680] usb 2-3: SerialNumber: 20120501030900000
[    2.816933] SCSI subsystem initialized
[    2.824425] usb-storage 2-3:1.0: USB Mass Storage device detected
[    2.824747] scsi host0: usb-storage 2-3:1.0
[    2.824937] usbcore: registered new interface driver usb-storage
[    2.827562] usbcore: registered new interface driver uas
[    2.896705] tsc: Refined TSC clocksource calibration: 1991.999 MHz
[    2.896720] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396=
d4ffc055, max_idle_ns: 881590662783 ns
[    2.896726] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    2.896805] clocksource: Switched to clocksource tsc
[    3.056869] usb 1-5: New USB device found, idVendor=3D04f2, idProduct=3D=
b615, bcdDevice=3D 0.11
[    3.056873] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.056876] usb 1-5: Product: Integrated IR Camera
[    3.056878] usb 1-5: Manufacturer: SunplusIT Inc
[    3.184870] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    3.341996] usb 1-6: New USB device found, idVendor=3D2cb7, idProduct=3D=
0210, bcdDevice=3D 3.33
[    3.342000] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    3.342003] usb 1-6: Product: L830-EB-00
[    3.342005] usb 1-6: Manufacturer: FIBOCOM
[    3.342008] usb 1-6: SerialNumber: 004999010640000
[    3.472434] Console: switching to colour frame buffer device 160x45
[    3.480700] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    3.506871] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    3.629597] usb 1-7: New USB device found, idVendor=3D8087, idProduct=3D=
0a2b, bcdDevice=3D 0.10
[    3.629598] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    3.656638] raid6: avx2x4   gen() 41711 MB/s
[    3.724665] raid6: avx2x4   xor() 20012 MB/s
[    3.760608] usb 1-8: new high-speed USB device number 6 using xhci_hcd
[    3.792645] raid6: avx2x2   gen() 41811 MB/s
[    3.858553] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.=
00 PQ: 0 ANSI: 6
[    3.860627] raid6: avx2x2   xor() 24937 MB/s
[    3.924029] usb 1-8: New USB device found, idVendor=3D04f2, idProduct=3D=
b614, bcdDevice=3D 0.12
[    3.924030] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.924030] usb 1-8: Product: Integrated Camera
[    3.924031] usb 1-8: Manufacturer: Chicony Electronics Co.,Ltd.
[    3.928655] raid6: avx2x1   gen() 35142 MB/s
[    3.996661] raid6: avx2x1   xor() 21421 MB/s
[    4.052652] usb 1-9: new full-speed USB device number 7 using xhci_hcd
[    4.064651] raid6: sse2x4   gen() 17507 MB/s
[    4.132603] raid6: sse2x4   xor() 10337 MB/s
[    4.200604] raid6: sse2x2   gen() 17344 MB/s
[    4.202123] usb 1-9: New USB device found, idVendor=3D06cb, idProduct=3D=
009a, bcdDevice=3D 1.64
[    4.202124] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    4.202124] usb 1-9: SerialNumber: 5bb5988684f7
[    4.268603] raid6: sse2x2   xor() 10678 MB/s
[    4.336605] raid6: sse2x1   gen() 14630 MB/s
[    4.404603] raid6: sse2x1   xor()  7448 MB/s
[    4.404603] raid6: using algorithm avx2x2 gen() 41811 MB/s
[    4.404604] raid6: .... xor() 24937 MB/s, rmw enabled
[    4.404604] raid6: using avx2x2 recovery algorithm
[    4.405177] xor: automatically using best checksumming function   avx   =
   =20
[    4.405683] async_tx: api initialized (async)
[    4.451081] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    4.627750] device-mapper: uevent: version 1.0.3
[    4.628000] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised:=
 dm-devel@redhat.com
[   10.144373] Btrfs loaded, crc32c=3Dcrc32c-intel
[   10.192417] PM: Image not found (code -22)
[   10.322218] EXT4-fs (dm-1): mounted filesystem with ordered data mode. O=
pts: (null)
[   10.350984] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   10.422484] systemd[1]: Inserted module 'autofs4'
[   10.546730] systemd[1]: systemd 246.6-2 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCR=
E2 default-hierarchy=3Dhybrid)
[   10.565122] systemd[1]: Detected architecture x86-64.
[   10.593279] systemd[1]: Set hostname to <linus-work>.
[   10.670894] systemd[1]: /lib/systemd/system/gpsd.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/g=
psd.sock \xffffffe2\xffffff86\xffffff92 /run/gpsd.sock; please update the u=
nit file accordingly.
[   10.679560] systemd[1]: /lib/systemd/system/plymouth-start.service:16: U=
nit configured to use KillMode=3Dnone. This is unsafe, as it disables syste=
md's process lifecycle management for the service. Please update your servi=
ce to use a safer KillMode=3D, such as 'mixed' or 'control-group'. Support =
for KillMode=3Dnone is deprecated and will eventually be removed.
[   10.687212] systemd[1]: /lib/systemd/system/rpc-statd.service:16: PIDFil=
e=3D references a path below legacy directory /var/run/, updating /var/run/=
rpc.statd.pid \xffffffe2\xffffff86\xffffff92 /run/rpc.statd.pid; please upd=
ate the unit file accordingly.
[   10.693570] systemd[1]: /lib/systemd/system/smartmontools.service:10: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.
[   10.697109] systemd[1]: /lib/systemd/system/kdump-tools.service:6: Stand=
ard output type syslog+console is obsolete, automatically updating to journ=
al+console. Please update your unit file, and consider removing the setting=
 altogether.
[   10.698866] systemd[1]: /lib/systemd/system/fancontrol.service:11: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/fancontrol.pid \xffffffe2\xffffff86\xffffff92 /run/fancontrol.pid; please =
update the unit file accordingly.
[   10.702783] systemd[1]: Queued start job for default target Graphical In=
terface.
[   10.703427] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   10.703802] systemd[1]: Created slice system-getty.slice.
[   10.703965] systemd[1]: Created slice system-modprobe.slice.
[   10.704152] systemd[1]: Created slice Cryptsetup Units Slice.
[   10.704306] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   10.704464] systemd[1]: Created slice system-tor.slice.
[   10.704662] systemd[1]: Created slice User and Session Slice.
[   10.704712] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   10.704814] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   10.704861] systemd[1]: Reached target Slices.
[   10.704880] systemd[1]: Reached target Libvirt guests shutdown.
[   10.704919] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   10.704972] systemd[1]: Listening on LVM2 poll daemon socket.
[   10.707251] systemd[1]: Listening on RPCbind Server Activation Socket.
[   10.707329] systemd[1]: Listening on Syslog Socket.
[   10.707381] systemd[1]: Listening on fsck to fsckd communication Socket.
[   10.707411] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   10.707490] systemd[1]: Listening on Journal Audit Socket.
[   10.707531] systemd[1]: Listening on Journal Socket (/dev/log).
[   10.707585] systemd[1]: Listening on Journal Socket.
[   10.707646] systemd[1]: Listening on udev Control Socket.
[   10.707688] systemd[1]: Listening on udev Kernel Socket.
[   10.708202] systemd[1]: Mounting Huge Pages File System...
[   10.708872] systemd[1]: Mounting POSIX Message Queue File System...
[   10.709405] systemd[1]: Mounting NFSD configuration filesystem...
[   10.709937] systemd[1]: Mounting RPC Pipe File System...
[   10.710654] systemd[1]: Mounting Kernel Debug File System...
[   10.711256] systemd[1]: Mounting Kernel Trace File System...
[   10.711345] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.
[   10.711477] systemd[1]: Finished Availability of block devices.
[   10.712406] systemd[1]: Starting Set the console keyboard layout...
[   10.713099] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[   10.713696] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   10.713742] systemd[1]: Condition check resulted in Load Kernel Module d=
rm being skipped.
[   10.714097] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   10.714138] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[   10.715394] systemd[1]: Starting Journal Service...
[   10.716487] systemd[1]: Starting Load Kernel Modules...
[   10.717177] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.717866] systemd[1]: Starting Coldplug All udev Devices...
[   10.719241] systemd[1]: Mounted Huge Pages File System.
[   10.719367] systemd[1]: Mounted POSIX Message Queue File System.
[   10.719479] systemd[1]: Mounted Kernel Debug File System.
[   10.719582] systemd[1]: Mounted Kernel Trace File System.
[   10.720088] systemd[1]: Finished Set the console keyboard layout.
[   10.720620] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[   10.725785] EXT4-fs (dm-1): re-mounted. Opts: errors=3Dremount-ro
[   10.726848] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.727269] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.727295] systemd[1]: Condition check resulted in Platform Persistent =
Storage Archival being skipped.
[   10.728043] systemd[1]: Starting Load/Save Random Seed...
[   10.728821] systemd[1]: Starting Create System Users...
[   10.730503] lp: driver loaded but no devices found
[   10.734144] ppdev: user-space parallel port driver
[   10.740403] systemd[1]: Finished Load/Save Random Seed.
[   10.741537] RPC: Registered named UNIX socket transport module.
[   10.741538] RPC: Registered udp transport module.
[   10.741538] RPC: Registered tcp transport module.
[   10.741539] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.742390] systemd[1]: Mounted RPC Pipe File System.
[   10.742809] systemd[1]: Finished Load Kernel Modules.
[   10.742956] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.743000] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.743735] systemd[1]: Starting pNFS block layout mapping daemon...
[   10.744491] systemd[1]: Starting Apply Kernel Variables...
[   10.745515] systemd[1]: Started pNFS block layout mapping daemon.
[   10.746850] systemd[1]: Finished Create System Users.
[   10.747709] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.751964] systemd[1]: Finished Apply Kernel Variables.
[   10.761715] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.762790] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   10.777997] systemd[1]: Finished Coldplug All udev Devices.
[   10.778820] systemd[1]: Starting Helper to synchronize boot up for ifupd=
own...
[   10.780818] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.781674] systemd[1]: Mounted NFSD configuration filesystem.
[   10.793665] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   10.793787] systemd[1]: Reached target Local File Systems (Pre).
[   10.793810] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.793820] systemd[1]: Reached target Containers.
[   10.819489] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[   10.820158] systemd[1]: Starting Show Plymouth Boot Screen...
[   10.837679] systemd[1]: Started Show Plymouth Boot Screen.
[   10.837812] systemd[1]: Condition check resulted in Dispatch Password Re=
quests to Console Directory Watch being skipped.
[   10.837893] systemd[1]: Started Forward Password Requests to Plymouth Di=
rectory Watch.
[   10.870780] tpm_tis IFX0763:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   10.901765] ACPI: AC Adapter [AC] (on-line)
[   10.912733] Non-volatile memory driver v1.3
[   10.912903] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   10.915329] systemd[1]: Created slice system-systemd\x2dbacklight.slice.
[   10.916014] systemd[1]: Starting Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight...
[   10.920048] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   10.925152] systemd[1]: Finished Load/Save Screen Backlight Brightness o=
f backlight:intel_backlight.
[   10.926370] intel_rapl_common: Found RAPL domain package
[   10.926371] intel_rapl_common: Found RAPL domain dram
[   10.927368] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   10.927368] thinkpad_acpi: http://ibm-acpi.sf.net/
[   10.927369] thinkpad_acpi: ThinkPad BIOS N22ET35W (1.12 ), EC N22HT22W
[   10.927370] thinkpad_acpi: Lenovo ThinkPad T480s, model 20L70053GE
[   10.929223] thinkpad_acpi: radio switch found; radios are enabled
[   10.929234] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[   10.929234] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[   10.931007] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[   10.932677] mc: Linux media interface: v0.10
[   10.933940] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unbloc=
ked
[   10.938653] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THE=
RMAL_PCI
[   10.956499] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[   10.956504] battery: new extension: ThinkPad Battery Extension
[   10.957010] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[   10.967181] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 1.
[   10.969219] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 2.
[   10.970598] systemd[1]: Found device SAMSUNG MZVLB1T0HALR-000L7 3.
[   10.971213] systemd[1]: Starting Cryptography Setup for nvme0n1p3_crypt.=
=2E.
[   10.971797] systemd[1]: Starting File System Check on /dev/disk/by-uuid/=
0ff272a1-2687-46aa-9042-94763e0efe1b...
[   10.972411] systemd[1]: Starting File System Check on /dev/disk/by-uuid/=
B616-7D5F...
[   10.977053] systemd[1]: Started File System Check Daemon to report statu=
s.
[   10.977866] systemd[1]: Finished Cryptography Setup for nvme0n1p3_crypt.
[   10.977989] systemd[1]: Reached target Block Device Preparation for /dev=
/mapper/nvme0n1p3_crypt.
[   10.978001] systemd[1]: Reached target Local Encrypted Volumes.
[   10.985035] cdc_acm 1-6:1.2: ttyACM0: USB ACM device
[   10.986466] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   10.990639] usbcore: registered new interface driver cdc_acm
[   10.990640] cdc_acm: USB Abstract Control Model driver for USB modems an=
d ISDN adapters
[   10.990771] videodev: Linux video capture interface: v2.00
[   10.992049] systemd[1]: Finished File System Check on /dev/disk/by-uuid/=
B616-7D5F.
[   10.992723] usbcore: registered new interface driver cdc_ether
[   10.993550] elan_i2c 1-0015: supply vcc not found, using dummy regulator
[   10.994662] iTCO_vendor_support: vendor-support=3D0
[   10.994902] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   10.995216] usbcore: registered new interface driver cdc_ncm
[   11.003776] elan_i2c 1-0015: unexpected iap version 0x00 (ic type: 0x20)=
, firmware update will not work
[   11.003779] elan_i2c 1-0015: Elan Touchpad: Module ID: 0x0020, Firmware:=
 0x0001, Sample: 0x0000, IAP: 0x0000
[   11.004969] input: Elan Touchpad as /devices/pci0000:00/0000:00:1f.4/i2c=
-1/1-0015/input/input8
[   11.005056] input: Elan TrackPoint as /devices/pci0000:00/0000:00:1f.4/i=
2c-1/1-0015/input/input9
[   11.005291] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.005347] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.008452] usbcore: registered new interface driver cdc_wdm
[   11.010937] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.041736] EFI Variables Facility v0.08 2004-May-17
[   11.042374] input: PC Speaker as /devices/platform/pcspkr/input/input10
[   11.051193] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   11.054712] cfg80211: Loaded X.509 cert 'benh@debian.org: 577e021cb980e0=
e820821ba7b54b4961b8b4fadf'
[   11.054917] cfg80211: Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6=
ec146e09d1b6016ab9d6cf71dd233f0328'
[   11.055113] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.055487] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db
[   11.055605] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db.p7s
[   11.067671] uvcvideo: Found UVC 1.00 device Integrated IR Camera (04f2:b=
615)
[   11.067674] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   11.067675] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   11.076642] systemd[1]: Finished File System Check on /dev/disk/by-uuid/=
0ff272a1-2687-46aa-9042-94763e0efe1b.
[   11.085988] systemd[1]: Mounting /boot...
[   11.086820] cdc_mbim 1-6:1.0: setting rx_max =3D 16384
[   11.087835] uvcvideo 1-5:1.0: Entity type for entity Extension 6 was not=
 initialized!
[   11.087837] uvcvideo 1-5:1.0: Entity type for entity Extension 5 was not=
 initialized!
[   11.087838] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   11.087839] uvcvideo 1-5:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   11.087840] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   11.087841] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   11.088032] cdc_mbim 1-6:1.0: cdc-wdm0: USB WDM device
[   11.088260] input: Integrated IR Camera: Integrate as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-5/1-5:1.0/input/input11
[   11.089070] cdc_mbim 1-6:1.0 wwan0: register 'cdc_mbim' at usb-0000:00:1=
4.0-6, CDC MBIM, b2:c9:3d:8b:12:4a
[   11.089277] usbcore: registered new interface driver cdc_mbim
[   11.089922] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b614)
[   11.089922] uvcvideo: Forcing device quirks to 0x100 by module parameter=
 for testing purpose.
[   11.089923] uvcvideo: Please report required quirks to the linux-uvc-dev=
el mailing list.
[   11.095578] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   11.096624] systemd[1]: Reached target Smart Card.
[   11.098509] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opt=
s: (null)
[   11.098514] ext2 filesystem being mounted at /boot supports timestamps u=
ntil 2038 (0x7fffffff)
[   11.100781] systemd[1]: Mounted /boot.
[   11.103182] systemd[1]: Mounting /boot/efi...
[   11.104519] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not=
 initialized!
[   11.104520] uvcvideo 1-8:1.0: Entity type for entity Extension 3 was not=
 initialized!
[   11.104521] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was no=
t initialized!
[   11.104523] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not in=
itialized!
[   11.105246] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb1/1-8/1-8:1.0/input/input12
[   11.105311] usbcore: registered new interface driver uvcvideo
[   11.105312] USB Video Class driver (1.1.1)
[   11.105451] Intel(R) Wireless WiFi driver for Linux
[   11.105643] iwlwifi 0000:3d:00.0: enabling device (0000 -> 0002)
[   11.107211] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
36.ucode (-2)
[   11.107346] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
36.ucode failed with error -2
[   11.107360] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
35.ucode (-2)
[   11.107488] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
35.ucode failed with error -2
[   11.107498] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
34.ucode (-2)
[   11.107626] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
34.ucode failed with error -2
[   11.107635] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
33.ucode (-2)
[   11.107763] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
33.ucode failed with error -2
[   11.107772] iwlwifi 0000:3d:00.0: firmware: failed to load iwlwifi-8265-=
32.ucode (-2)
[   11.107900] iwlwifi 0000:3d:00.0: Direct firmware load for iwlwifi-8265-=
32.ucode failed with error -2
[   11.112600] iwlwifi 0000:3d:00.0: firmware: direct-loading firmware iwlw=
ifi-8265-31.ucode
[   11.113044] iwlwifi 0000:3d:00.0: loaded firmware version 31.532993.0 82=
65-31.ucode op_mode iwlmvm
[   11.113057] iwlwifi 0000:3d:00.0: firmware: failed to load iwl-debug-yoy=
o.bin (-2)
[   11.113712] systemd[1]: Started Journal Service.
[   11.176942] pstore: Using crash dump compression: deflate
[   11.184312] pstore: Registered efi as persistent store backend
[   11.186184] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[   11.193653] Bluetooth: Core ver 2.22
[   11.193664] NET: Registered protocol family 31
[   11.193664] Bluetooth: HCI device and connection manager initialized
[   11.193668] Bluetooth: HCI socket layer initialized
[   11.193670] Bluetooth: L2CAP socket layer initialized
[   11.193672] Bluetooth: SCO socket layer initialized
[   11.200592] resource sanity check: requesting [mem 0xfed10000-0xfed15fff=
], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
[   11.200599] caller snb_uncore_imc_init_box+0x78/0xc0 [intel_uncore] mapp=
ing multiple BARs
[   11.248029] usbcore: registered new interface driver btusb
[   11.248521] audit: type=3D1400 audit(1604762317.841:2): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/lxc-=
start" pid=3D710 comm=3D"apparmor_parser"
[   11.249846] audit: type=3D1400 audit(1604762317.845:3): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-s=
enddoc" pid=3D709 comm=3D"apparmor_parser"
[   11.250621] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 20=
15
[   11.251625] Bluetooth: hci0: Device revision is 16
[   11.251626] Bluetooth: hci0: Secure boot is enabled
[   11.251626] Bluetooth: hci0: OTP lock is enabled
[   11.251627] Bluetooth: hci0: API lock is enabled
[   11.251627] Bluetooth: hci0: Debug lock is disabled
[   11.251628] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   11.253460] bluetooth hci0: firmware: direct-loading firmware intel/ibt-=
12-16.sfi
[   11.253462] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[   11.253968] audit: type=3D1400 audit(1604762317.849:4): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/cup=
s-browsed" pid=3D711 comm=3D"apparmor_parser"
[   11.254997] audit: type=3D1400 audit(1604762317.849:5): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"lsb_release" =
pid=3D719 comm=3D"apparmor_parser"
[   11.256014] audit: type=3D1400 audit(1604762317.849:6): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/gps=
d" pid=3D714 comm=3D"apparmor_parser"
[   11.256481] audit: type=3D1400 audit(1604762317.849:7): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-o=
opslash" pid=3D716 comm=3D"apparmor_parser"
[   11.256528] audit: type=3D1400 audit(1604762317.849:8): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/man"=
 pid=3D713 comm=3D"apparmor_parser"
[   11.256530] audit: type=3D1400 audit(1604762317.849:9): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_filter" p=
id=3D713 comm=3D"apparmor_parser"
[   11.256531] audit: type=3D1400 audit(1604762317.849:10): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_groff" p=
id=3D713 comm=3D"apparmor_parser"
[   11.258537] audit: type=3D1400 audit(1604762317.853:11): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/lib/x86=
_64-linux-gnu/lightdm/lightdm-guest-session" pid=3D712 comm=3D"apparmor_par=
ser"
[   11.353541] intel_rapl_common: Found RAPL domain package
[   11.353542] intel_rapl_common: Found RAPL domain core
[   11.353543] intel_rapl_common: Found RAPL domain uncore
[   11.353543] intel_rapl_common: Found RAPL domain dram
[   11.354931] iwlwifi 0000:3d:00.0: Detected Intel(R) Dual Band Wireless A=
C 8265, REV=3D0x230
[   11.357901] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC257: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   11.357902] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   11.357903] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   11.357904] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[   11.357905] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   11.357906] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x19
[   11.357907] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[   11.359932] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360=
 ms ovfl timer
[   11.359933] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   11.359934] RAPL PMU: hw unit of domain package 2^-14 Joules
[   11.359934] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   11.359934] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   11.359935] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   11.361323] Adding 16531452k swap on /dev/mapper/linus--work--vg-swap_1.=
  Priority:-2 extents:1 across:16531452k SSFS
[   11.415758] iwlwifi 0000:3d:00.0: base HW address: 7c:76:35:14:e6:d7
[   11.491111] iwlwifi 0000:3d:00.0: iwlmvm doesn't allow to disable BT Coe=
x, check bt_coex_active module parameter
[   11.491246] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   11.491489] thermal thermal_zone5: failed to read out thermal zone (-61)
[   11.492973] iwlwifi 0000:3d:00.0 wlp61s0: renamed from wlan0
[   11.602619] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input13
[   11.602672] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input14
[   11.602720] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input15
[   11.602764] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[   11.602794] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[   11.602826] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input18
[   11.602869] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input19
[   11.602910] input: HDA Intel PCH HDMI/DP,pcm=3D10 as /devices/pci0000:00=
/0000:00:1f.3/sound/card0/input20
[   11.942966] intel_pmc_core intel_pmc_core.0:  initialized
[   11.949276] new mount options do not match the existing superblock, will=
 be ignored
[   11.957342] fuse: init (API version 7.31)
[   13.188670] Bluetooth: hci0: Waiting for firmware download to complete
[   13.189691] Bluetooth: hci0: Firmware loaded in 1896141 usecs
[   13.189746] Bluetooth: hci0: Waiting for device to boot
[   13.201648] Bluetooth: hci0: Device booted in 11669 usecs
[   13.202839] bluetooth hci0: firmware: direct-loading firmware intel/ibt-=
12-16.ddc
[   13.202848] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-12-16=
=2Eddc
[   13.204701] Bluetooth: hci0: Applying Intel DDC parameters completed
[   13.205770] Bluetooth: hci0: Reading supported features failed (-16)
[   13.209735] Bluetooth: hci0: Setting Intel telemetry ddc write event mas=
k failed (-95)
[   13.214956] Bluetooth: hci0: Firmware revision 0.1 build 103 week 50 2016
[   13.237108] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   13.237177] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   13.241602] IPv6: ADDRCONF(NETDEV_CHANGE): veth3: link becomes ready
[   13.283869] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   13.288721] br0: port 1(enp0s31f6) entered blocking state
[   13.288723] br0: port 1(enp0s31f6) entered disabled state
[   13.288795] device enp0s31f6 entered promiscuous mode
[   13.485406] br0: port 2(veth0) entered blocking state
[   13.485411] br0: port 2(veth0) entered disabled state
[   13.485575] device veth0 entered promiscuous mode
[   13.492993] br0: port 3(veth2) entered blocking state
[   13.492997] br0: port 3(veth2) entered disabled state
[   13.493148] device veth2 entered promiscuous mode
[   13.499672] br0: port 3(veth2) entered blocking state
[   13.499677] br0: port 3(veth2) entered forwarding state
[   13.499714] br0: port 2(veth0) entered blocking state
[   13.499717] br0: port 2(veth0) entered forwarding state
[   15.252077] NFSD: Using UMH upcall client tracking operations.
[   15.252084] NFSD: starting 90-second grace period (net f00000a8)
[   15.503758] L1TF CPU bug present and SMT on, data leak possible. See CVE=
-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l=
1tf.html for details.
[   69.357185] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   69.357186] Bluetooth: BNEP filters: protocol multicast
[   69.357189] Bluetooth: BNEP socket layer initialized
[   69.361249] NET: Registered protocol family 38
[   80.233514] Bluetooth: RFCOMM TTY layer initialized
[   80.233521] Bluetooth: RFCOMM socket layer initialized
[   80.233529] Bluetooth: RFCOMM ver 1.11
[  191.882680] input: PLT BB PRO 2 (AVRCP) as /devices/virtual/input/input21
[  284.009675] wlp61s0: authenticate with 8a:04:f3:06:a8:84
[  284.025838] wlp61s0: send auth to 8a:04:f3:06:a8:84 (try 1/3)
[  284.035142] wlp61s0: authenticated
[  284.036734] wlp61s0: associate with 8a:04:f3:06:a8:84 (try 1/3)
[  284.038207] wlp61s0: RX AssocResp from 8a:04:f3:06:a8:84 (capab=3D0x421 =
status=3D0 aid=3D1)
[  284.047532] wlp61s0: associated
[  284.047609] IPv6: ADDRCONF(NETDEV_CHANGE): wlp61s0: link becomes ready
[  336.738221] Bluetooth: hci0: link tx timeout
[  336.738232] Bluetooth: hci0: killing stalled connection e4:22:a5:be:d8:a1
[  464.525590] general protection fault, probably for non-canonical address=
 0x5d837135c4428991: 0000 [#1] SMP PTI
[  464.525595] CPU: 7 PID: 1844 Comm: Xorg Kdump: loaded Not tainted 5.9.0-=
1-amd64 #1 Debian 5.9.1-1
[  464.525596] Hardware name: LENOVO 20L70053GE/20L70053GE, BIOS N22ET35W (=
1.12 ) 04/09/2018
[  464.525602] RIP: 0010:kmem_cache_alloc_trace+0x84/0x210
[  464.525604] Code: 24 65 49 8b 50 08 65 4c 03 05 60 de 58 47 49 8b 00 48 =
89 04 24 48 85 c0 0f 84 64 01 00 00 41 8b 4c 24 28 49 8b 3c 24 48 01 c1 <48=
> 8b 19 48 89 ce 49 33 9c 24 b8 00 00 00 48 8d 4a 01 48 0f ce 48
[  464.525605] RSP: 0018:ffffb3abc1b9bd30 EFLAGS: 00010202
[  464.525607] RAX: 5d837135c4428971 RBX: 0000000000000020 RCX: 5d837135c44=
28991
[  464.525608] RDX: 00000000000051c2 RSI: 0000000000000dc0 RDI: 00000000000=
2f300
[  464.525610] RBP: 0000000000000030 R08: ffff938aa27ef300 R09: 00000000000=
00001
[  464.525611] R10: 0000000000004000 R11: 0000000000000013 R12: ffff938747c=
43b00
[  464.525612] R13: ffffffffc01b1c8a R14: 0000000000000dc0 R15: ffff938747c=
43b00
[  464.525614] FS:  00007f27ae621580(0000) GS:ffff938aa27c0000(0000) knlGS:=
0000000000000000
[  464.525615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.525616] CR2: 00007f27adff3002 CR3: 00000003ee5ce001 CR4: 00000000003=
706e0
[  464.525617] Call Trace:
[  464.525641]  drm_syncobj_create+0x2a/0xc0 [drm]
[  464.525658]  drm_syncobj_create_ioctl+0x69/0xe0 [drm]
[  464.525673]  ? drm_syncobj_release+0x30/0x30 [drm]
[  464.525684]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[  464.525696]  drm_ioctl+0x20f/0x3a0 [drm]
[  464.525711]  ? drm_syncobj_release+0x30/0x30 [drm]
[  464.525715]  ? __x64_sys_setitimer+0x105/0x150
[  464.525718]  __x64_sys_ioctl+0x83/0xb0
[  464.525721]  do_syscall_64+0x33/0x80
[  464.525725]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  464.525727] RIP: 0033:0x7f27aea68c27
[  464.525729] Code: 00 00 00 48 8b 05 69 92 0c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 92 0c 00 f7 d8 64 89 01 48
[  464.525730] RSP: 002b:00007ffc27135d08 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  464.525732] RAX: ffffffffffffffda RBX: 00000000c00864bf RCX: 00007f27aea=
68c27
[  464.525733] RDX: 00007ffc27135d10 RSI: 00000000c00864bf RDI: 00000000000=
00013
[  464.525734] RBP: 00007ffc27135d10 R08: 0000555b97928880 R09: 00000000000=
00001
[  464.525735] R10: 00007ffc27168080 R11: 0000000000000246 R12: 00000000000=
00013
[  464.525736] R13: 0000555b97928880 R14: 0000000000000016 R15: 0000555b96e=
71ac0
[  464.525739] Modules linked in: uinput rfcomm cmac algif_hash algif_skcip=
her af_alg bnep xt_CHECKSUM xt_tcpudp bridge stp llc veth fuse intel_pmc_co=
re_pltdrv intel_pmc_core x86_pkg_temp_thermal intel_powerclamp nft_chain_na=
t kvm_intel xt_MASQUERADE snd_hda_codec_hdmi nf_nat snd_soc_skl kvm nf_conn=
track nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nft_counter snd_soc_hdac_hda=
 irqbypass snd_hda_ext_core snd_soc_sst_ipc joydev rapl snd_soc_sst_dsp int=
el_rapl_msr nf_tables snd_hda_codec_realtek iwlmvm snd_soc_acpi_intel_match=
 binfmt_misc snd_hda_codec_generic snd_soc_acpi nfnetlink mac80211 intel_cs=
tate snd_soc_core btusb intel_uncore btrtl btbcm btintel nls_ascii snd_comp=
ress nls_cp437 vfat bluetooth fat libarc4 snd_hda_intel efi_pstore snd_inte=
l_dspcfg iwlwifi snd_hda_codec snd_hda_core serio_raw pcspkr efivars uvcvid=
eo wmi_bmof cdc_mbim intel_wmi_thunderbolt snd_hwdep videobuf2_vmalloc jitt=
erentropy_rng cdc_wdm videobuf2_memops iTCO_wdt videobuf2_v4l2 drbg intel_p=
mc_bxt cdc_ncm
[  464.525766]  iTCO_vendor_support videobuf2_common watchdog elan_i2c cdc_=
ether cfg80211 snd_pcm ansi_cprng usbnet snd_timer sg videodev ecdh_generic=
 cdc_acm mii mc ecc ucsi_acpi typec_ucsi mei_me thinkpad_acpi mei processor=
_thermal_device nvram typec ledtrig_audio intel_rapl_common intel_xhci_usb_=
role_switch snd roles intel_soc_dts_iosf intel_pch_thermal soundcore tpm_cr=
b int3403_thermal rfkill ac int340x_thermal_zone tpm_tis tpm_tis_core tpm e=
vdev int3400_thermal acpi_pad acpi_thermal_rel rng_core nfsd auth_rpcgss nf=
s_acl lockd grace coretemp parport_pc ppdev sunrpc lp parport efivarfs ip_t=
ables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic btrfs zstd_co=
mpress dm_crypt dm_mod raid10 raid456 async_raid6_recov async_memcpy async_=
pq async_xor async_tx xor sd_mod raid6_pq libcrc32c raid1 raid0 multipath l=
inear md_mod uas usb_storage scsi_mod i915 crc32_pclmul crc32c_intel ghash_=
clmulni_intel e1000e aesni_intel psmouse libaes crypto_simd cryptd nvme glu=
e_helper ptp i2c_algo_bit
[  464.525800]  pps_core nvme_core i2c_i801 drm_kms_helper t10_pi i2c_smbus=
 crc_t10dif thunderbolt crct10dif_generic crct10dif_pclmul crct10dif_common=
 xhci_pci cec xhci_hcd drm intel_lpss_pci intel_lpss usbcore idma64 usb_com=
mon wmi battery video button
[  464.525811] ---[ end trace 864e22c7d2630d50 ]---
[  464.642000] RIP: 0010:kmem_cache_alloc_trace+0x84/0x210
[  464.642004] Code: 24 65 49 8b 50 08 65 4c 03 05 60 de 58 47 49 8b 00 48 =
89 04 24 48 85 c0 0f 84 64 01 00 00 41 8b 4c 24 28 49 8b 3c 24 48 01 c1 <48=
> 8b 19 48 89 ce 49 33 9c 24 b8 00 00 00 48 8d 4a 01 48 0f ce 48
[  464.642005] RSP: 0018:ffffb3abc1b9bd30 EFLAGS: 00010202
[  464.642006] RAX: 5d837135c4428971 RBX: 0000000000000020 RCX: 5d837135c44=
28991
[  464.642007] RDX: 00000000000051c2 RSI: 0000000000000dc0 RDI: 00000000000=
2f300
[  464.642007] RBP: 0000000000000030 R08: ffff938aa27ef300 R09: 00000000000=
00001
[  464.642008] R10: 0000000000004000 R11: 0000000000000013 R12: ffff938747c=
43b00
[  464.642009] R13: ffffffffc01b1c8a R14: 0000000000000dc0 R15: ffff938747c=
43b00
[  464.642010] FS:  00007f27ae621580(0000) GS:ffff938aa27c0000(0000) knlGS:=
0000000000000000
[  464.642011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.642011] CR2: 00007f27adff3002 CR3: 00000003ee5ce001 CR4: 00000000003=
706e0
[  464.642013] Kernel panic - not syncing: Fatal exception
[  464.643012] Kernel Offset: 0x37800000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
