Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD474A5FE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jul 2023 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGFVjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jul 2023 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFVjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jul 2023 17:39:40 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 14:39:34 PDT
Received: from ci74p00im-qukt09081702.me.com (ci74p00im-qukt09081702.me.com [17.57.156.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984CF1995
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jul 2023 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1688679200;
        bh=8mBQgl5qY1d/Gespk0lE7yShK+UOgKQDPTfVPQwPcII=;
        h=Content-Type:from:Mime-Version:Subject:Message-Id:Date:to;
        b=n+FkXBMW+cYZ4LPKGWDlu1EGth8rPbmM8v5yuMi78o4tu410dF6bhMZcqgIpsPwvU
         o3eNndlZvc8+5ICs57Btp5xrFwp9blmibxmAS7QIwyBEDtxMDEjgGezJqoYRhD6OcR
         JQVQ4sRTWBedE93JvtVca6HgM9JeR8Lw4BPLZF1ObqibziZvvaTygLs5Rklhb/Cb6+
         LKx6wrLBp4k864hj5RD6R1mElj8041s7bOH67OIw0Ao7OovBfANJETIsl5CZoEpG7x
         pSdLuNRfdUDyMWS7rMC0IhW7zRrSXVYXHKClFFlVDX0J1jGrYpbofkduILZlB9xlnO
         V86OLrxegjEJw==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09081702.me.com (Postfix) with ESMTPSA id 865ED3BC0295
        for <linux-wireless_at_vger_kernel_org_r951af2q59fdg4_937j3445@icloud.com>; Thu,  6 Jul 2023 21:33:18 +0000 (UTC)
Content-Type: multipart/mixed; boundary=Apple-Mail-556BA95D-9864-4713-964A-6D8F27E6F8BE
Content-Transfer-Encoding: 7bit
from:   sepali_ardimento0e@icloud.com
Mime-Version: 1.0 (1.0)
Subject: Intel WiFi 6E AX210
Message-Id: <C9D9A9C3-4D15-4387-9A10-1FD291AD15C1@icloud.com>
Date:   Thu, 6 Jul 2023 23:33:04 +0200
to:     linux-wireless@vger.kernel.org
X-Mailer: iPhone Mail (20F75)
X-MANTSH: 1TEIXSUMdHVoaGkNHB1tfQV4aEhsaGBsaGxEKTEMXGxoEGxwSBBscGgQfGhAbHho
 fGhEKTFkXBx4fEQpZRBdoZVJSARl/ZkZraBEKWU0XbVhPUxEKWUkXBxkacRsGBxwadwYHGx8GG
 gYaBhoGGnEaEBp3BhoGGgYaBhoGGgYacRoQGncGGhEKWV4XaGN5EQpDThdwaR5DaFhTbB9wXwd
 rT0lGUHBNZEh5HVhOfV9TQ2RTexEKWFwXGQQaBB8aBRsaGgQSGAQeGAQYExAbHhofGhEKXlkXS
 BlkTxwRCkxaF2hba29rEQpDWhcbGhsEHxIEHQQcGxEKQl4XGxEKRF4XGBEKXk4XGxEKQkUXbEV
 PTm96a3odY34RCkJOF2tFGlJQHkNcWVxoEQpCTBdibktsTlN/AX5rGREKQmwXYh1DW2tkbU5uR
 lARCkJAF2Qbbx58Wx4BaWEaEQpCWBdgbk1vTE9hX3sYfREKRUMXGxEKcGgXY1NQbWdMUH54S2I
 QBxkaEQpwaBdkWHJ8XFpeWW1OZRAHGRoRCnBoF29ZQHlkUlhTSWRSEAcZGhEKcGgXZURue01ga
 XkfW1MQBxkaEQpwaBduQUxaSBtEY21eUBAHGRoRCnBsF2JTU2dpH2BSSRJOEAcZGhEKcEwXaW9
 aXm5mch8bHU4QBxkaEQptfhcaEQpYTRdLEQ==
X-CLX-Shades: Grey
X-CLX-UShades: None
X-CLX-Score: -45
X-CLX-UnSpecialScore: None
X-CLX-Spam: true
X-Proofpoint-ORIG-GUID: ZC4iBryF5Zu-AeclzZgNbS7rdWuyiNyQ
X-Proofpoint-GUID: ZC4iBryF5Zu-AeclzZgNbS7rdWuyiNyQ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=-45 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307060188
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Apple-Mail-556BA95D-9864-4713-964A-6D8F27E6F8BE
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I recently installed some distribution (like Fedora 38) with kernel 6.3.=
11 and I have one issue with Intel WiFi 6E AX210

I don=E2=80=99t have specific steps for reproducing it but it happens mostly=
 when I start using it intensively (like when downloading big files), after s=
ome minutes it stop working, even in WiFi settings it disappears everything

I did a dmesg, logs start to appear on line 1789

HWInfo if needed:
CPU: Ryzen 9 7950x3d
GPU: RX 7900 xtx
Motherboard: Asus rog strix x670E-E Gaming WiFi
RAM: 32GB DDR5 G.Skill

--Apple-Mail-556BA95D-9864-4713-964A-6D8F27E6F8BE
Content-Type: text/plain;
	name=log6.txt;
	x-apple-part-url=63492B6F-CA98-456D-9B88-7F4BDDAAC3E7
Content-Disposition: attachment;
	filename=log6.txt
Content-Transfer-Encoding: quoted-printable

[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20fff=
f] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a210000-0x000000000afffff=
f] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b020ff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b021000-0x000000005208601=
7] usable
[    0.000000] reserve setup_data: [mem 0x0000000052086018-0x0000000052090e5=
7] usable
[    0.000000] reserve setup_data: [mem 0x0000000052090e58-0x000000005209101=
7] usable
[    0.000000] reserve setup_data: [mem 0x0000000052091018-0x00000000520a005=
7] usable
[    0.000000] reserve setup_data: [mem 0x00000000520a0058-0x00000000520a101=
7] usable
[    0.000000] reserve setup_data: [mem 0x00000000520a1018-0x00000000520bc25=
7] usable
[    0.000000] reserve setup_data: [mem 0x00000000520bc258-0x000000006f611ff=
f] usable
[    0.000000] reserve setup_data: [mem 0x000000006f612000-0x0000000075e5dff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x0000000075e5e000-0x000000007603dff=
f] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007603e000-0x000000007803dff=
f] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007803e000-0x000000007a1feff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a1ff000-0x000000007bffaff=
f] usable
[    0.000000] reserve setup_data: [mem 0x000000007bffb000-0x000000007cfffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x000000007d7f3000-0x000000007ffffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7fffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000fffffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x0000000857fffff=
f] usable
[    0.000000] reserve setup_data: [mem 0x0000000858000000-0x0000000877fffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x000000087eec0000-0x00000008a01ffff=
f] reserved
[    0.000000] reserve setup_data: [mem 0x000000fd00000000-0x000000fffffffff=
f] reserved
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x7603d000 ACPI 2.0=3D0x7603d014 TPMFinalLog=3D0x=
77ff4000 SMBIOS=3D0x796a6000 SMBIOS 3.0=3D0x796a5000 MEMATTR=3D0x66ffa698 ES=
RT=3D0x6b5c6418 MOKvar=3D0x79736000 RNG=3D0x7601bc18 TPMEventLog=3D0x520bd01=
8=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem53: MMIO range=3D[0xf0000000-0xf7ffffff] (128M=
B) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem54: MMIO range=3D[0xfd000000-0xfedfffff] (30MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem55: MMIO range=3D[0xfee00000-0xfee00fff]=
 (4KB) from e820 map
[    0.000000] efi: Remove mem56: MMIO range=3D[0xfee01000-0xffffffff] (17MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem59: MMIO range=3D[0x880000000-0x8a01fffff] (51=
4MB) from e820 map
[    0.000000] e820: remove [mem 0x880000000-0x8a01fffff] reserved
[    0.000000] secureboot: Secure boot enabled
[    0.000000] Kernel is locked down from EFI Secure Boot mode; see man kern=
el_lockdown.7
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX X670E-E GAMING WIFI, B=
IOS 1416 05/16/2023
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4200.001 MHz processor
[    0.000117] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reser=
ved
[    0.000119] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000123] last_pfn =3D 0x858000 max_arch_pfn =3D 0x400000000
[    0.000126] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =
=20
[    0.001133] last_pfn =3D 0x7bffb max_arch_pfn =3D 0x400000000
[    0.003534] esrt: Reserving ESRT space from 0x000000006b5c6418 to 0x00000=
0006b5c6450.
[    0.003538] e820: update [mem 0x6b5c6000-0x6b5c6fff] usable =3D=3D> reser=
ved
[    0.003548] Using GB pages for direct mapping
[    0.003828] secureboot: Secure boot enabled
[    0.003828] RAMDISK: [mem 0x530c9000-0x5631efff]
[    0.003831] ACPI: Early table checksum verification disabled
[    0.003833] ACPI: RSDP 0x000000007603D014 000024 (v02 ALASKA)
[    0.003835] ACPI: XSDT 0x000000007603C728 000114 (v01 ALASKA A M I    010=
72009 AMI  01000013)
[    0.003839] ACPI: FACP 0x0000000076030000 000114 (v06 ALASKA A M I    010=
72009 AMI  00010013)
[    0.003842] ACPI: DSDT 0x0000000076021000 00E1A2 (v02 ALASKA A M I    010=
72009 INTL 20120913)
[    0.003843] ACPI: FACS 0x0000000078024000 000040
[    0.003844] ACPI: SSDT 0x000000007603B000 000FB0 (v01 AMD    PTUP     000=
00001 ASUS 00000001)
[    0.003845] ACPI: SSDT 0x000000007603A000 000308 (v01 AMD    HBUP     000=
00001 ASUS 00000001)
[    0.003846] ACPI: SSDT 0x0000000076032000 007B85 (v02 AMD    Splinter 000=
00002 MSFT 05000000)
[    0.003847] ACPI: SSDT 0x0000000076031000 0003F1 (v02 ALASKA CPUSSDT  010=
72009 AMI  01072009)
[    0.003848] ACPI: FIDT 0x0000000076020000 00009C (v01 ALASKA A M I    010=
72009 AMI  00010013)
[    0.003849] ACPI: MCFG 0x000000007601E000 00003C (v01 ALASKA A M I    010=
72009 MSFT 00010013)
[    0.003850] ACPI: HPET 0x000000007601D000 000038 (v01 ALASKA A M I    010=
72009 AMI  00000005)
[    0.003851] ACPI: WDRT 0x000000007601C000 000047 (v01 ALASKA A M I    010=
72009 AMI  00000005)
[    0.003852] ACPI: FPDT 0x000000007601A000 000044 (v01 ALASKA A M I    010=
72009 AMI  01000013)
[    0.003854] ACPI: VFCT 0x0000000076000000 0190A0 (v01 ALASKA A M I    000=
00001 AMD  31504F47)
[    0.003855] ACPI: BGRT 0x0000000075FFF000 000038 (v01 ALASKA A M I    010=
72009 AMI  00010013)
[    0.003856] ACPI: TPM2 0x0000000075FFE000 00004C (v04 ALASKA A M I    000=
00001 AMI  00000000)
[    0.003857] ACPI: SSDT 0x0000000075FF4000 009BAE (v02 AMD    AmdTable 000=
00001 AMD  00000001)
[    0.003858] ACPI: CRAT 0x0000000075FF2000 001D28 (v01 AMD    AmdTable 000=
00001 AMD  00000001)
[    0.003859] ACPI: CDIT 0x0000000075FF1000 000029 (v01 AMD    AmdTable 000=
00001 AMD  00000001)
[    0.003860] ACPI: SSDT 0x0000000075FF0000 000E0D (v02 AMD    CPMDFIG2 000=
00001 INTL 20120913)
[    0.003861] ACPI: SSDT 0x0000000075FED000 00250B (v02 AMD    CDFAAIG2 000=
00001 INTL 20120913)
[    0.003862] ACPI: SSDT 0x0000000075FEC000 000450 (v02 AMD    CPMDFDG2 000=
00001 INTL 20120913)
[    0.003863] ACPI: SSDT 0x0000000075FE3000 008879 (v02 AMD    CPMCMN   000=
00001 INTL 20120913)
[    0.003864] ACPI: SSDT 0x0000000075FE0000 0022C3 (v02 AMD    AOD      000=
00001 INTL 20120913)
[    0.003865] ACPI: WSMT 0x0000000075FDF000 000028 (v01 ALASKA A M I    010=
72009 AMI  00010013)
[    0.003866] ACPI: APIC 0x0000000075FDE000 00015E (v05 ALASKA A M I    010=
72009 AMI  00010013)
[    0.003867] ACPI: IVRS 0x0000000075FDD000 0000D0 (v02 AMD    AmdTable 000=
00001 AMD  00000001)
[    0.003868] ACPI: SSDT 0x0000000075FDC000 0000BC (v02 AMD    MEMTOOL0 000=
00002 INTL 20120913)
[    0.003869] ACPI: SSDT 0x0000000075FDB000 0004E7 (v02 AMD    CPMMSOSC 000=
00001 INTL 20120913)
[    0.003870] ACPI: SSDT 0x0000000075FDA000 000042 (v02 AMD    AMDWOV   000=
00001 INTL 20120913)
[    0.003871] ACPI: SSDT 0x0000000075FD9000 00010D (v01 AMD    CPMAPMFD 000=
00001 INTL 20120913)
[    0.003872] ACPI: SSDT 0x0000000075FD8000 000085 (v02 AMD    AmdTable 000=
00001 INTL 20120913)
[    0.003873] ACPI: SSDT 0x0000000075FD7000 0000B3 (v02 AMD    AmdTable 000=
00001 INTL 20120913)
[    0.003874] ACPI: Reserving FACP table memory at [mem 0x76030000-0x760301=
13]
[    0.003875] ACPI: Reserving DSDT table memory at [mem 0x76021000-0x7602f1=
a1]
[    0.003875] ACPI: Reserving FACS table memory at [mem 0x78024000-0x780240=
3f]
[    0.003875] ACPI: Reserving SSDT table memory at [mem 0x7603b000-0x7603bf=
af]
[    0.003876] ACPI: Reserving SSDT table memory at [mem 0x7603a000-0x7603a3=
07]
[    0.003876] ACPI: Reserving SSDT table memory at [mem 0x76032000-0x76039b=
84]
[    0.003876] ACPI: Reserving SSDT table memory at [mem 0x76031000-0x760313=
f0]
[    0.003877] ACPI: Reserving FIDT table memory at [mem 0x76020000-0x760200=
9b]
[    0.003877] ACPI: Reserving MCFG table memory at [mem 0x7601e000-0x7601e0=
3b]
[    0.003877] ACPI: Reserving HPET table memory at [mem 0x7601d000-0x7601d0=
37]
[    0.003877] ACPI: Reserving WDRT table memory at [mem 0x7601c000-0x7601c0=
46]
[    0.003878] ACPI: Reserving FPDT table memory at [mem 0x7601a000-0x7601a0=
43]
[    0.003878] ACPI: Reserving VFCT table memory at [mem 0x76000000-0x760190=
9f]
[    0.003878] ACPI: Reserving BGRT table memory at [mem 0x75fff000-0x75fff0=
37]
[    0.003879] ACPI: Reserving TPM2 table memory at [mem 0x75ffe000-0x75ffe0=
4b]
[    0.003879] ACPI: Reserving SSDT table memory at [mem 0x75ff4000-0x75ffdb=
ad]
[    0.003879] ACPI: Reserving CRAT table memory at [mem 0x75ff2000-0x75ff3d=
27]
[    0.003880] ACPI: Reserving CDIT table memory at [mem 0x75ff1000-0x75ff10=
28]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x75ff0000-0x75ff0e=
0c]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x75fed000-0x75fef5=
0a]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x75fec000-0x75fec4=
4f]
[    0.003881] ACPI: Reserving SSDT table memory at [mem 0x75fe3000-0x75feb8=
78]
[    0.003881] ACPI: Reserving SSDT table memory at [mem 0x75fe0000-0x75fe22=
c2]
[    0.003881] ACPI: Reserving WSMT table memory at [mem 0x75fdf000-0x75fdf0=
27]
[    0.003882] ACPI: Reserving APIC table memory at [mem 0x75fde000-0x75fde1=
5d]
[    0.003882] ACPI: Reserving IVRS table memory at [mem 0x75fdd000-0x75fdd0=
cf]
[    0.003882] ACPI: Reserving SSDT table memory at [mem 0x75fdc000-0x75fdc0=
bb]
[    0.003882] ACPI: Reserving SSDT table memory at [mem 0x75fdb000-0x75fdb4=
e6]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x75fda000-0x75fda0=
41]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x75fd9000-0x75fd91=
0c]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x75fd8000-0x75fd80=
84]
[    0.003884] ACPI: Reserving SSDT table memory at [mem 0x75fd7000-0x75fd70=
b2]
[    0.003929] No NUMA configuration found
[    0.003930] Faking a node at [mem 0x0000000000000000-0x0000000857ffffff]
[    0.003933] NODE_DATA(0) allocated [mem 0x857fd5000-0x857ffffff]
[    0.021148] Zone ranges:
[    0.021150]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.021152]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.021153]   Normal   [mem 0x0000000100000000-0x0000000857ffffff]
[    0.021153]   Device   empty
[    0.021154] Movable zone start for each node
[    0.021154] Early memory node ranges
[    0.021154]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.021155]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
[    0.021156]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.021156]   node   0: [mem 0x000000000a210000-0x000000000affffff]
[    0.021156]   node   0: [mem 0x000000000b021000-0x000000006f611fff]
[    0.021157]   node   0: [mem 0x000000007a1ff000-0x000000007bffafff]
[    0.021157]   node   0: [mem 0x0000000100000000-0x0000000857ffffff]
[    0.021159] Initmem setup node 0 [mem 0x0000000000001000-0x0000000857ffff=
ff]
[    0.021162] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.021172] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.021257] On node 0, zone DMA32: 1281 pages in unavailable ranges
[    0.021266] On node 0, zone DMA32: 16 pages in unavailable ranges
[    0.022201] On node 0, zone DMA32: 33 pages in unavailable ranges
[    0.022251] On node 0, zone DMA32: 11245 pages in unavailable ranges
[    0.039665] On node 0, zone Normal: 16389 pages in unavailable ranges
[    0.040976] ACPI: PM-Timer IO Port: 0x808
[    0.040981] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.040991] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-=
23
[    0.040995] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24=
-55
[    0.040996] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.040997] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.040998] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.040999] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.041004] e820: update [mem 0x696b0000-0x697a3fff] usable =3D=3D> reser=
ved
[    0.041011] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.041022] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x=
00000fff]
[    0.041023] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x=
000fffff]
[    0.041024] PM: hibernation: Registered nosave memory: [mem 0x09aff000-0x=
09ffffff]
[    0.041024] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x=
0a20ffff]
[    0.041025] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0x=
0b020fff]
[    0.041026] PM: hibernation: Registered nosave memory: [mem 0x52086000-0x=
52086fff]
[    0.041026] PM: hibernation: Registered nosave memory: [mem 0x52090000-0x=
52090fff]
[    0.041027] PM: hibernation: Registered nosave memory: [mem 0x52091000-0x=
52091fff]
[    0.041027] PM: hibernation: Registered nosave memory: [mem 0x520a0000-0x=
520a0fff]
[    0.041028] PM: hibernation: Registered nosave memory: [mem 0x520a1000-0x=
520a1fff]
[    0.041028] PM: hibernation: Registered nosave memory: [mem 0x520bc000-0x=
520bcfff]
[    0.041029] PM: hibernation: Registered nosave memory: [mem 0x696b0000-0x=
697a3fff]
[    0.041030] PM: hibernation: Registered nosave memory: [mem 0x6b5c6000-0x=
6b5c6fff]
[    0.041030] PM: hibernation: Registered nosave memory: [mem 0x6f612000-0x=
75e5dfff]
[    0.041031] PM: hibernation: Registered nosave memory: [mem 0x75e5e000-0x=
7603dfff]
[    0.041031] PM: hibernation: Registered nosave memory: [mem 0x7603e000-0x=
7803dfff]
[    0.041031] PM: hibernation: Registered nosave memory: [mem 0x7803e000-0x=
7a1fefff]
[    0.041032] PM: hibernation: Registered nosave memory: [mem 0x7bffb000-0x=
7cffffff]
[    0.041032] PM: hibernation: Registered nosave memory: [mem 0x7d000000-0x=
7d7f2fff]
[    0.041032] PM: hibernation: Registered nosave memory: [mem 0x7d7f3000-0x=
7fffffff]
[    0.041033] PM: hibernation: Registered nosave memory: [mem 0x80000000-0x=
fedfffff]
[    0.041033] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0x=
fee00fff]
[    0.041033] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0x=
ffffffff]
[    0.041034] [mem 0x80000000-0xfedfffff] available for PCI devices
[    0.041035] Booting paravirtualized kernel on bare hardware
[    0.041036] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 1910969940391419 ns
[    0.044036] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 n=
r_node_ids:1
[    0.044562] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
[    0.044565] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=3D1*2097152
[    0.044566] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13=
 14 15=20
[    0.044570] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29=
 30 31=20
[    0.044586] Fallback order for Node 0: 0=20
[    0.044588] Built 1 zonelists, mobility grouping on.  Total pages: 803523=
2
[    0.044589] Policy zone: Normal
[    0.044590] Kernel command line: BOOT_IMAGE=3D(hd1,gpt2)/vmlinuz-6.3.11-2=
00.fc38.x86_64 root=3DUUID=3Da04909e6-6957-4157-90d3-c6a177250694 ro rootfla=
gs=3Dsubvol=3Droot rhgb quiet
[    0.044628] Unknown kernel command line parameters "rhgb BOOT_IMAGE=3D(hd=
1,gpt2)/vmlinuz-6.3.11-200.fc38.x86_64", will be passed to user space.
[    0.045871] Dentry cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, linear)
[    0.046405] Inode-cache hash table entries: 2097152 (order: 12, 16777216 b=
ytes, linear)
[    0.046577] mem auto-init: stack:all(zero), heap alloc:off, heap free:off=

[    0.046609] software IO TLB: area num 32.
[    0.074776] Memory: 31814052K/32651756K available (18432K kernel code, 32=
57K rwdata, 14144K rodata, 4460K init, 17440K bss, 837444K reserved, 0K cma-=
reserved)
[    0.074837] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D32, N=
odes=3D1
[    0.074852] ftrace: allocating 52015 entries in 204 pages
[    0.081003] ftrace: allocated 204 pages with 4 groups
[    0.081516] Dynamic Preempt: voluntary
[    0.081548] rcu: Preemptible hierarchical RCU implementation.
[    0.081549] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_=
ids=3D32.
[    0.081550] 	Trampoline variant of Tasks RCU enabled.
[    0.081550] 	Rude variant of Tasks RCU enabled.
[    0.081550] 	Tracing variant of Tasks RCU enabled.
[    0.081550] rcu: RCU calculated value of scheduler-enlistment delay is 10=
0 jiffies.
[    0.081551] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D=
32
[    0.082917] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.083074] rcu: srcu_init: Setting srcu_struct sizes based on contention=
.
[    0.083199] kfence: initialized - using 2097152 bytes for 255 objects at 0=
x(____ptrval____)-0x(____ptrval____)
[    0.083223] Console: colour dummy device 80x25
[    0.083224] printk: console [tty0] enabled
[    0.083248] ACPI: Core revision 20221020
[    0.083380] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, m=
ax_idle_ns: 133484873504 ns
[    0.083392] APIC: Switch to symmetric I/O mode setup
[    0.083829] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.084032] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.084034] Switched APIC routing to physical flat.
[    0.084620] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-=
1
[    0.089397] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0=
x3c8a6238495, max_idle_ns: 440795233402 ns
[    0.089399] Calibrating delay loop (skipped), value calculated using time=
r frequency.. 8400.00 BogoMIPS (lpj=3D4200001)
[    0.089400] pid_max: default: 32768 minimum: 301
[    0.090383] LSM: initializing lsm=3Dlockdown,capability,yama,integrity,se=
linux,bpf,landlock
[    0.090388] Yama: becoming mindful.
[    0.090391] SELinux:  Initializing.
[    0.090405] LSM support for eBPF active
[    0.090405] landlock: Up and running.
[    0.090431] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes=
, linear)
[    0.090447] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 b=
ytes, linear)
[    0.090550] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.090587] LVT offset 1 assigned for vector 0xf9
[    0.090710] LVT offset 2 assigned for vector 0xf4
[    0.090747] process: using mwait in idle threads
[    0.090748] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.090749] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.090751] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user p=
ointer sanitization
[    0.090752] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.090752] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB o=
n context switch
[    0.090753] Spectre V2 : mitigation: Enabling conditional Indirect Branch=
 Prediction Barrier
[    0.090754] Speculative Store Bypass: Mitigation: Speculative Store Bypas=
s disabled via prctl
[    0.102324] Freeing SMP alternatives memory: 44K
[    0.205282] smpboot: CPU0: AMD Ryzen 9 7950X3D 16-Core Processor (family:=
 0x19, model: 0x61, stepping: 0x2)
[    0.205343] cblist_init_generic: Setting adjustable number of callback qu=
eues.
[    0.205345] cblist_init_generic: Setting shift to 5 and lim to 1.
[    0.205352] cblist_init_generic: Setting shift to 5 and lim to 1.
[    0.205358] cblist_init_generic: Setting shift to 5 and lim to 1.
[    0.205363] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PM=
U driver.
[    0.205373] ... version:                2
[    0.205373] ... bit width:              48
[    0.205374] ... generic registers:      6
[    0.205374] ... value mask:             0000ffffffffffff
[    0.205374] ... max period:             00007fffffffffff
[    0.205375] ... fixed-purpose events:   0
[    0.205375] ... event mask:             000000000000003f
[    0.205398] rcu: Hierarchical SRCU implementation.
[    0.205398] rcu: 	Max phase no-delay instances is 400.
[    0.205398] NMI watchdog: Enabled. Permanently consumes one hw-PMU counte=
r.
[    0.205398] smp: Bringing up secondary CPUs ...
[    0.205398] x86: Booting SMP configuration:
[    0.205398] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #=
9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #2=
8 #29 #30 #31
[    0.243421] smp: Brought up 1 node, 32 CPUs
[    0.243421] smpboot: Max logical packages: 1
[    0.243421] smpboot: Total of 32 processors activated (268800.06 BogoMIPS=
)
[    0.245626] devtmpfs: initialized
[    0.245626] x86/mm: Memory block size: 128MB
[    0.246567] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20f=
fff] (65536 bytes)
[    0.246567] ACPI: PM: Registering ACPI NVS region [mem 0x7603e000-0x7803d=
fff] (33554432 bytes)
[    0.246582] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 1911260446275000 ns
[    0.246585] futex hash table entries: 8192 (order: 7, 524288 bytes, linea=
r)
[    0.246625] pinctrl core: initialized pinctrl subsystem
[    0.246688] PM: RTC time: 20:10:50, date: 2023-07-06
[    0.246831] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.246876] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.246880] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations
[    0.246883] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.246888] audit: initializing netlink subsys (disabled)
[    0.246891] audit: type=3D2000 audit(1688674250.162:1): state=3Dinitializ=
ed audit_enabled=3D0 res=3D1
[    0.246891] thermal_sys: Registered thermal governor 'fair_share'
[    0.246891] thermal_sys: Registered thermal governor 'bang_bang'
[    0.246891] thermal_sys: Registered thermal governor 'step_wise'
[    0.246891] thermal_sys: Registered thermal governor 'user_space'
[    0.246891] cpuidle: using governor menu
[    0.246891] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.246891] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-=
0xf7ffffff] (base 0xf0000000)
[    0.246891] PCI: not using MMCONFIG
[    0.246891] PCI: Using configuration type 1 for base access
[    0.246891] PCI: Using configuration type 1 for extended access
[    0.247741] kprobes: kprobe jump-optimization is enabled. All kprobes are=
 optimized if possible.
[    0.256438] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages=

[    0.256438] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.256438] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages=

[    0.256438] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.256727] cryptd: max_cpu_qlen set to 1000
[    0.256727] raid6: skipped pq benchmark and selected avx512x4
[    0.256727] raid6: using avx512x2 recovery algorithm
[    0.256727] ACPI: Added _OSI(Module Device)
[    0.256727] ACPI: Added _OSI(Processor Device)
[    0.256727] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.256727] ACPI: Added _OSI(Processor Aggregator Device)
[    0.260416] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP=
P7.UP00.DP40.UP00.DP68], AE_NOT_FOUND (20221020/dswload2-162)
[    0.260419] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (2022102=
0/psobject-220)
[    0.260420] ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0=
x0010)
[    0.260446] ACPI: 17 ACPI AML tables successfully acquired and loaded
[    0.261066] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.263932] ACPI: EC: EC started
[    0.263932] ACPI: EC: interrupt blocked
[    0.263932] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.263932] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle trans=
actions
[    0.263932] ACPI: Interpreter enabled
[    0.263932] ACPI: PM: (supports S0 S3 S4 S5)
[    0.263932] ACPI: Using IOAPIC for interrupt routing
[    0.264111] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-=
0xf7ffffff] (base 0xf0000000)
[    0.264131] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved as ACPI=
 motherboard resource
[    0.264139] PCI: Using host bridge windows from ACPI; if necessary, use "=
pci=3Dnocrs" and report a bug
[    0.264139] PCI: Ignoring E820 reservations for host bridge windows
[    0.264321] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.265432] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.265447] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    0.265465] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    0.267949] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.267952] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Clock=
PM Segments MSI EDR HPX-Type3]
[    0.267999] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotpl=
ug PME AER PCIeCapability LTR DPC]
[    0.268005] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [b=
us 00-7f] only partially covers this bridge
[    0.268178] PCI host bridge to bus 0000:00
[    0.268178] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]=

[    0.268179] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]=

[    0.268179] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]=

[    0.268180] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]=

[    0.268180] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff=
 window]
[    0.268181] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfcffffff=
 window]
[    0.268181] pci_bus 0000:00: root bus resource [mem 0x880000000-0xfffffff=
fff window]
[    0.268182] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.268191] pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000
[    0.268249] pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600
[    0.268300] pci 0000:00:01.0: [1022:14da] type 00 class 0x060000
[    0.268336] pci 0000:00:01.1: [1022:14db] type 01 class 0x060400
[    0.268395] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.268480] pci 0000:00:01.2: [1022:14db] type 01 class 0x060400
[    0.268580] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.268712] pci 0000:00:02.0: [1022:14da] type 00 class 0x060000
[    0.268752] pci 0000:00:02.1: [1022:14db] type 01 class 0x060400
[    0.268785] pci 0000:00:02.1: enabling Extended Tags
[    0.268854] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.269003] pci 0000:00:03.0: [1022:14da] type 00 class 0x060000
[    0.269046] pci 0000:00:04.0: [1022:14da] type 00 class 0x060000
[    0.269092] pci 0000:00:08.0: [1022:14da] type 00 class 0x060000
[    0.269129] pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400
[    0.269143] pci 0000:00:08.1: enabling Extended Tags
[    0.269164] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.269221] pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400
[    0.269235] pci 0000:00:08.3: enabling Extended Tags
[    0.269256] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.269319] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.269395] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.269484] pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000
[    0.269502] pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000
[    0.269520] pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000
[    0.269537] pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000
[    0.269555] pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000
[    0.269573] pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000
[    0.269590] pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000
[    0.269607] pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000
[    0.269674] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400
[    0.269684] pci 0000:01:00.0: reg 0x10: [mem 0xfcd00000-0xfcd03fff]
[    0.269756] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.269868] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.269870] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.269871] pci 0000:00:01.1:   bridge window [mem 0xfcb00000-0xfcdfffff]=

[    0.269874] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.269906] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400
[    0.269983] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.270173] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.270176] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.270178] pci 0000:01:00.0:   bridge window [mem 0xfcb00000-0xfccfffff]=

[    0.270181] pci 0000:01:00.0:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.270214] pci 0000:03:00.0: [1002:744c] type 00 class 0x030000
[    0.270226] pci 0000:03:00.0: reg 0x10: [mem 0xf000000000-0xf7ffffffff 64=
bit pref]
[    0.270234] pci 0000:03:00.0: reg 0x18: [mem 0xf800000000-0xf80fffffff 64=
bit pref]
[    0.270239] pci 0000:03:00.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.270244] pci 0000:03:00.0: reg 0x24: [mem 0xfcb00000-0xfcbfffff]
[    0.270249] pci 0000:03:00.0: reg 0x30: [mem 0xfcc00000-0xfcc1ffff pref]
[    0.270265] pci 0000:03:00.0: BAR 0: assigned to efifb
[    0.270311] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.270417] pci 0000:03:00.1: [1002:ab30] type 00 class 0x040300
[    0.270425] pci 0000:03:00.1: reg 0x10: [mem 0xfcc20000-0xfcc23fff]
[    0.270487] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.270562] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.270566] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.270567] pci 0000:02:00.0:   bridge window [mem 0xfcb00000-0xfccfffff]=

[    0.270570] pci 0000:02:00.0:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.270870] pci 0000:04:00.0: [c0a9:540a] type 00 class 0x010802
[    0.270918] pci 0000:04:00.0: reg 0x10: [mem 0xfcf00000-0xfcf03fff 64bit]=

[    0.271676] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.271679] pci 0000:00:01.2:   bridge window [mem 0xfcf00000-0xfcffffff]=

[    0.271951] pci 0000:05:00.0: [1022:43f4] type 01 class 0x060400
[    0.271978] pci 0000:05:00.0: enabling Extended Tags
[    0.272018] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.272734] pci 0000:00:02.1: PCI bridge to [bus 05-13]
[    0.272737] pci 0000:00:02.1:   bridge window [mem 0xfbf00000-0xfc6fffff]=

[    0.272770] pci 0000:06:00.0: [1022:43f5] type 01 class 0x060400
[    0.272799] pci 0000:06:00.0: enabling Extended Tags
[    0.272840] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.273236] pci 0000:06:08.0: [1022:43f5] type 01 class 0x060400
[    0.273264] pci 0000:06:08.0: enabling Extended Tags
[    0.273304] pci 0000:06:08.0: PME# supported from D0 D3hot D3cold
[    0.273747] pci 0000:06:0c.0: [1022:43f5] type 01 class 0x060400
[    0.273774] pci 0000:06:0c.0: enabling Extended Tags
[    0.273803] pci 0000:06:0c.0: PME# supported from D0 D3hot D3cold
[    0.274715] pci 0000:06:0d.0: [1022:43f5] type 01 class 0x060400
[    0.274742] pci 0000:06:0d.0: enabling Extended Tags
[    0.274771] pci 0000:06:0d.0: PME# supported from D0 D3hot D3cold
[    0.274814] pci 0000:05:00.0: PCI bridge to [bus 06-13]
[    0.274818] pci 0000:05:00.0:   bridge window [mem 0xfbf00000-0xfc6fffff]=

[    0.274841] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.274952] pci 0000:08:00.0: [1022:43f4] type 01 class 0x060400
[    0.274996] pci 0000:08:00.0: enabling Extended Tags
[    0.275061] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.275219] pci 0000:06:08.0: PCI bridge to [bus 08-11]
[    0.275224] pci 0000:06:08.0:   bridge window [mem 0xfbf00000-0xfc4fffff]=

[    0.275274] pci 0000:09:00.0: [1022:43f5] type 01 class 0x060400
[    0.275319] pci 0000:09:00.0: enabling Extended Tags
[    0.275388] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    0.275511] pci 0000:09:04.0: [1022:43f5] type 01 class 0x060400
[    0.275556] pci 0000:09:04.0: enabling Extended Tags
[    0.275622] pci 0000:09:04.0: PME# supported from D0 D3hot D3cold
[    0.275746] pci 0000:09:05.0: [1022:43f5] type 01 class 0x060400
[    0.275792] pci 0000:09:05.0: enabling Extended Tags
[    0.275858] pci 0000:09:05.0: PME# supported from D0 D3hot D3cold
[    0.275983] pci 0000:09:06.0: [1022:43f5] type 01 class 0x060400
[    0.276029] pci 0000:09:06.0: enabling Extended Tags
[    0.276097] pci 0000:09:06.0: PME# supported from D0 D3hot D3cold
[    0.276216] pci 0000:09:07.0: [1022:43f5] type 01 class 0x060400
[    0.276262] pci 0000:09:07.0: enabling Extended Tags
[    0.276330] pci 0000:09:07.0: PME# supported from D0 D3hot D3cold
[    0.276450] pci 0000:09:08.0: [1022:43f5] type 01 class 0x060400
[    0.276496] pci 0000:09:08.0: enabling Extended Tags
[    0.276562] pci 0000:09:08.0: PME# supported from D0 D3hot D3cold
[    0.276696] pci 0000:09:0c.0: [1022:43f5] type 01 class 0x060400
[    0.276740] pci 0000:09:0c.0: enabling Extended Tags
[    0.276786] pci 0000:09:0c.0: PME# supported from D0 D3hot D3cold
[    0.276864] pci 0000:09:0d.0: [1022:43f5] type 01 class 0x060400
[    0.276908] pci 0000:09:0d.0: enabling Extended Tags
[    0.276954] pci 0000:09:0d.0: PME# supported from D0 D3hot D3cold
[    0.277023] pci 0000:08:00.0: PCI bridge to [bus 09-11]
[    0.277029] pci 0000:08:00.0:   bridge window [mem 0xfbf00000-0xfc4fffff]=

[    0.277060] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.277158] pci 0000:0b:00.0: [8086:2725] type 00 class 0x028000
[    0.277187] pci 0000:0b:00.0: reg 0x10: [mem 0xfc400000-0xfc403fff 64bit]=

[    0.277340] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[    0.277643] pci 0000:09:04.0: PCI bridge to [bus 0b]
[    0.277650] pci 0000:09:04.0:   bridge window [mem 0xfc400000-0xfc4fffff]=

[    0.277738] pci 0000:0c:00.0: [8086:15f3] type 00 class 0x020000
[    0.277760] pci 0000:0c:00.0: reg 0x10: [mem 0xfbf00000-0xfbffffff]
[    0.277796] pci 0000:0c:00.0: reg 0x1c: [mem 0xfc000000-0xfc003fff]
[    0.277940] pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
[    0.278144] pci 0000:09:05.0: PCI bridge to [bus 0c]
[    0.278150] pci 0000:09:05.0:   bridge window [mem 0xfbf00000-0xfc0fffff]=

[    0.278182] pci 0000:09:06.0: PCI bridge to [bus 0d]
[    0.278220] pci 0000:09:07.0: PCI bridge to [bus 0e]
[    0.278358] pci 0000:0f:00.0: [c0a9:540a] type 00 class 0x010802
[    0.278411] pci 0000:0f:00.0: reg 0x10: [mem 0xfc300000-0xfc303fff 64bit]=

[    0.278538] pci 0000:0f:00.0: enabling Extended Tags
[    0.279038] pci 0000:09:08.0: PCI bridge to [bus 0f]
[    0.279045] pci 0000:09:08.0:   bridge window [mem 0xfc300000-0xfc3fffff]=

[    0.279093] pci 0000:10:00.0: [1022:43f7] type 00 class 0x0c0330
[    0.279110] pci 0000:10:00.0: reg 0x10: [mem 0xfc200000-0xfc207fff 64bit]=

[    0.279150] pci 0000:10:00.0: enabling Extended Tags
[    0.279200] pci 0000:10:00.0: PME# supported from D0 D3hot D3cold
[    0.279309] pci 0000:09:0c.0: PCI bridge to [bus 10]
[    0.279314] pci 0000:09:0c.0:   bridge window [mem 0xfc200000-0xfc2fffff]=

[    0.279358] pci 0000:11:00.0: [1022:43f6] type 00 class 0x010601
[    0.279407] pci 0000:11:00.0: reg 0x24: [mem 0xfc180000-0xfc1803ff]
[    0.279414] pci 0000:11:00.0: reg 0x30: [mem 0xfc100000-0xfc17ffff pref]
[    0.279421] pci 0000:11:00.0: enabling Extended Tags
[    0.279461] pci 0000:11:00.0: PME# supported from D0 D3hot D3cold
[    0.279531] pci 0000:09:0d.0: PCI bridge to [bus 11]
[    0.279536] pci 0000:09:0d.0:   bridge window [mem 0xfc100000-0xfc1fffff]=

[    0.279605] pci 0000:12:00.0: [1022:43f7] type 00 class 0x0c0330
[    0.279616] pci 0000:12:00.0: reg 0x10: [mem 0xfc600000-0xfc607fff 64bit]=

[    0.279641] pci 0000:12:00.0: enabling Extended Tags
[    0.279672] pci 0000:12:00.0: PME# supported from D0 D3hot D3cold
[    0.279739] pci 0000:06:0c.0: PCI bridge to [bus 12]
[    0.279742] pci 0000:06:0c.0:   bridge window [mem 0xfc600000-0xfc6fffff]=

[    0.279770] pci 0000:13:00.0: [1022:43f6] type 00 class 0x010601
[    0.279799] pci 0000:13:00.0: reg 0x24: [mem 0xfc580000-0xfc5803ff]
[    0.279804] pci 0000:13:00.0: reg 0x30: [mem 0xfc500000-0xfc57ffff pref]
[    0.279808] pci 0000:13:00.0: enabling Extended Tags
[    0.279833] pci 0000:13:00.0: PME# supported from D0 D3hot D3cold
[    0.279877] pci 0000:06:0d.0: PCI bridge to [bus 13]
[    0.279880] pci 0000:06:0d.0:   bridge window [mem 0xfc500000-0xfc5fffff]=

[    0.279940] pci 0000:14:00.0: [1002:164e] type 00 class 0x030000
[    0.279947] pci 0000:14:00.0: reg 0x10: [mem 0xf820000000-0xf82fffffff 64=
bit pref]
[    0.279951] pci 0000:14:00.0: reg 0x18: [mem 0xf830000000-0xf8301fffff 64=
bit pref]
[    0.279954] pci 0000:14:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.279957] pci 0000:14:00.0: reg 0x24: [mem 0xfca00000-0xfca7ffff]
[    0.279962] pci 0000:14:00.0: enabling Extended Tags
[    0.279991] pci 0000:14:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.280049] pci 0000:14:00.1: [1002:1640] type 00 class 0x040300
[    0.280054] pci 0000:14:00.1: reg 0x10: [mem 0xfca80000-0xfca83fff]
[    0.280067] pci 0000:14:00.1: enabling Extended Tags
[    0.280086] pci 0000:14:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.280120] pci 0000:14:00.2: [1022:1649] type 00 class 0x108000
[    0.280147] pci 0000:14:00.2: reg 0x18: [mem 0xfc900000-0xfc9fffff]
[    0.280153] pci 0000:14:00.2: reg 0x24: [mem 0xfca84000-0xfca85fff]
[    0.280157] pci 0000:14:00.2: enabling Extended Tags
[    0.280209] pci 0000:14:00.3: [1022:15b6] type 00 class 0x0c0330
[    0.280215] pci 0000:14:00.3: reg 0x10: [mem 0xfc800000-0xfc8fffff 64bit]=

[    0.280231] pci 0000:14:00.3: enabling Extended Tags
[    0.280251] pci 0000:14:00.3: PME# supported from D0 D3hot D3cold
[    0.280286] pci 0000:14:00.4: [1022:15b7] type 00 class 0x0c0330
[    0.280292] pci 0000:14:00.4: reg 0x10: [mem 0xfc700000-0xfc7fffff 64bit]=

[    0.280307] pci 0000:14:00.4: enabling Extended Tags
[    0.280327] pci 0000:14:00.4: PME# supported from D0 D3hot D3cold
[    0.280370] pci 0000:00:08.1: PCI bridge to [bus 14]
[    0.280371] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.280372] pci 0000:00:08.1:   bridge window [mem 0xfc700000-0xfcafffff]=

[    0.280374] pci 0000:00:08.1:   bridge window [mem 0xf820000000-0xf8301ff=
fff 64bit pref]
[    0.280393] pci 0000:15:00.0: [1022:15b8] type 00 class 0x0c0330
[    0.280404] pci 0000:15:00.0: reg 0x10: [mem 0xfce00000-0xfcefffff 64bit]=

[    0.280425] pci 0000:15:00.0: enabling Extended Tags
[    0.280449] pci 0000:15:00.0: PME# supported from D0 D3hot D3cold
[    0.280497] pci 0000:00:08.3: PCI bridge to [bus 15]
[    0.280499] pci 0000:00:08.3:   bridge window [mem 0xfce00000-0xfcefffff]=

[    0.280728] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.280745] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.280758] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.280776] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.280791] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.280803] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.280815] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.280827] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.281235] ACPI: EC: interrupt unblocked
[    0.281236] ACPI: EC: event unblocked
[    0.281241] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.281242] ACPI: EC: GPE=3D0x4
[    0.281242] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC initialization compl=
ete
[    0.281243] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle transactions a=
nd events
[    0.281408] iommu: Default domain type: Translated=20
[    0.281408] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.281483] SCSI subsystem initialized
[    0.281488] libata version 3.00 loaded.
[    0.281488] ACPI: bus type USB registered
[    0.281488] usbcore: registered new interface driver usbfs
[    0.281488] usbcore: registered new interface driver hub
[    0.281488] usbcore: registered new device driver usb
[    0.282123] pps_core: LinuxPPS API ver. 1 registered
[    0.282124] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo G=
iometti <giometti@linux.it>
[    0.282125] PTP clock support registered
[    0.282406] EDAC MC: Ver: 3.0.0
[    0.282808] efivars: Registered efivars operations
[    0.282808] NetLabel: Initializing
[    0.282808] NetLabel:  domain hash size =3D 128
[    0.282808] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.282808] NetLabel:  unlabeled traffic allowed by default
[    0.282808] mctp: management component transport protocol core
[    0.282808] NET: Registered PF_MCTP protocol family
[    0.282808] PCI: Using ACPI for IRQ routing
[    0.285769] PCI: pci_cache_line_size set to 64 bytes
[    0.286418] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
[    0.286419] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.286419] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.286420] e820: reserve RAM buffer [mem 0x52086018-0x53ffffff]
[    0.286420] e820: reserve RAM buffer [mem 0x52091018-0x53ffffff]
[    0.286421] e820: reserve RAM buffer [mem 0x520a1018-0x53ffffff]
[    0.286421] e820: reserve RAM buffer [mem 0x696b0000-0x6bffffff]
[    0.286421] e820: reserve RAM buffer [mem 0x6b5c6000-0x6bffffff]
[    0.286422] e820: reserve RAM buffer [mem 0x6f612000-0x6fffffff]
[    0.286422] e820: reserve RAM buffer [mem 0x7bffb000-0x7bffffff]
[    0.286438] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.286438] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.286438] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem,=
owns=3Dnone,locks=3Dnone
[    0.286438] pci 0000:14:00.0: vgaarb: bridge control possible
[    0.286438] pci 0000:14:00.0: vgaarb: VGA device added: decodes=3Dio+mem,=
owns=3Dnone,locks=3Dnone
[    0.286438] vgaarb: loaded
[    0.286438] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.286438] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.288439] clocksource: Switched to clocksource tsc-early
[    0.288466] VFS: Disk quotas dquot_6.6.0
[    0.288469] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    0.288538] pnp: PnP ACPI init
[    0.288576] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.288597] system 00:01: [mem 0x858000000-0x877ffffff window] has been r=
eserved
[    0.288684] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.288684] system 00:03: [io  0x0200-0x023f] has been reserved
[    0.288766] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.288766] system 00:04: [io  0x040b] has been reserved
[    0.288767] system 00:04: [io  0x04d6] has been reserved
[    0.288767] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.288768] system 00:04: [io  0x0c14] has been reserved
[    0.288768] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.288769] system 00:04: [io  0x0c52] has been reserved
[    0.288769] system 00:04: [io  0x0c6c] has been reserved
[    0.288770] system 00:04: [io  0x0c6f] has been reserved
[    0.288770] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.288770] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.288771] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.288771] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.288772] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.288772] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.288773] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserv=
ed
[    0.288773] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserv=
ed
[    0.288774] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.288775] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.288775] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserv=
ed
[    0.288776] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.288776] system 00:04: [mem 0xfeb00000-0xfeb00fff] has been reserved
[    0.288777] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.289002] pnp: PnP ACPI: found 5 devices
[    0.294064] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, ma=
x_idle_ns: 2085701024 ns
[    0.294086] NET: Registered PF_INET protocol family
[    0.294142] IP idents hash table entries: 262144 (order: 9, 2097152 bytes=
, linear)
[    0.295341] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6,=
 262144 bytes, linear)
[    0.295352] Table-perturb hash table entries: 65536 (order: 6, 262144 byt=
es, linear)
[    0.295355] TCP established hash table entries: 262144 (order: 9, 2097152=
 bytes, linear)
[    0.295447] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, l=
inear)
[    0.295509] TCP: Hash tables configured (established 262144 bind 65536)
[    0.295563] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes=
, linear)
[    0.295583] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear=
)
[    0.295605] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, l=
inear)
[    0.295650] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.295653] NET: Registered PF_XDP protocol family
[    0.295660] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.295666] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.295669] pci 0000:02:00.0:   bridge window [mem 0xfcb00000-0xfccfffff]=

[    0.295671] pci 0000:02:00.0:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.295674] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.295676] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.295678] pci 0000:01:00.0:   bridge window [mem 0xfcb00000-0xfccfffff]=

[    0.295680] pci 0000:01:00.0:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.295683] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.295684] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.295685] pci 0000:00:01.1:   bridge window [mem 0xfcb00000-0xfcdfffff]=

[    0.295687] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf80ffff=
fff 64bit pref]
[    0.295695] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.295697] pci 0000:00:01.2:   bridge window [mem 0xfcf00000-0xfcffffff]=

[    0.295706] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.295716] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.295725] pci 0000:09:04.0: PCI bridge to [bus 0b]
[    0.295729] pci 0000:09:04.0:   bridge window [mem 0xfc400000-0xfc4fffff]=

[    0.295735] pci 0000:09:05.0: PCI bridge to [bus 0c]
[    0.295738] pci 0000:09:05.0:   bridge window [mem 0xfbf00000-0xfc0fffff]=

[    0.295744] pci 0000:09:06.0: PCI bridge to [bus 0d]
[    0.295753] pci 0000:09:07.0: PCI bridge to [bus 0e]
[    0.295763] pci 0000:09:08.0: PCI bridge to [bus 0f]
[    0.295766] pci 0000:09:08.0:   bridge window [mem 0xfc300000-0xfc3fffff]=

[    0.295772] pci 0000:09:0c.0: PCI bridge to [bus 10]
[    0.295775] pci 0000:09:0c.0:   bridge window [mem 0xfc200000-0xfc2fffff]=

[    0.295781] pci 0000:09:0d.0: PCI bridge to [bus 11]
[    0.295785] pci 0000:09:0d.0:   bridge window [mem 0xfc100000-0xfc1fffff]=

[    0.295791] pci 0000:08:00.0: PCI bridge to [bus 09-11]
[    0.295794] pci 0000:08:00.0:   bridge window [mem 0xfbf00000-0xfc4fffff]=

[    0.295800] pci 0000:06:08.0: PCI bridge to [bus 08-11]
[    0.295803] pci 0000:06:08.0:   bridge window [mem 0xfbf00000-0xfc4fffff]=

[    0.295806] pci 0000:06:0c.0: PCI bridge to [bus 12]
[    0.295809] pci 0000:06:0c.0:   bridge window [mem 0xfc600000-0xfc6fffff]=

[    0.295812] pci 0000:06:0d.0: PCI bridge to [bus 13]
[    0.295815] pci 0000:06:0d.0:   bridge window [mem 0xfc500000-0xfc5fffff]=

[    0.295818] pci 0000:05:00.0: PCI bridge to [bus 06-13]
[    0.295820] pci 0000:05:00.0:   bridge window [mem 0xfbf00000-0xfc6fffff]=

[    0.295824] pci 0000:00:02.1: PCI bridge to [bus 05-13]
[    0.295826] pci 0000:00:02.1:   bridge window [mem 0xfbf00000-0xfc6fffff]=

[    0.295835] pci 0000:00:08.1: PCI bridge to [bus 14]
[    0.295840] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.295842] pci 0000:00:08.1:   bridge window [mem 0xfc700000-0xfcafffff]=

[    0.295842] pci 0000:00:08.1:   bridge window [mem 0xf820000000-0xf8301ff=
fff 64bit pref]
[    0.295844] pci 0000:00:08.3: PCI bridge to [bus 15]
[    0.295845] pci 0000:00:08.3:   bridge window [mem 0xfce00000-0xfcefffff]=

[    0.295848] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.295849] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.295849] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.295850] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.295850] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window=
]
[    0.295850] pci_bus 0000:00: resource 9 [mem 0x80000000-0xfcffffff window=
]
[    0.295851] pci_bus 0000:00: resource 10 [mem 0x880000000-0xffffffffff wi=
ndow]
[    0.295851] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.295852] pci_bus 0000:01: resource 1 [mem 0xfcb00000-0xfcdfffff]
[    0.295852] pci_bus 0000:01: resource 2 [mem 0xf000000000-0xf80fffffff 64=
bit pref]
[    0.295853] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.295853] pci_bus 0000:02: resource 1 [mem 0xfcb00000-0xfccfffff]
[    0.295853] pci_bus 0000:02: resource 2 [mem 0xf000000000-0xf80fffffff 64=
bit pref]
[    0.295854] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.295854] pci_bus 0000:03: resource 1 [mem 0xfcb00000-0xfccfffff]
[    0.295854] pci_bus 0000:03: resource 2 [mem 0xf000000000-0xf80fffffff 64=
bit pref]
[    0.295855] pci_bus 0000:04: resource 1 [mem 0xfcf00000-0xfcffffff]
[    0.295855] pci_bus 0000:05: resource 1 [mem 0xfbf00000-0xfc6fffff]
[    0.295855] pci_bus 0000:06: resource 1 [mem 0xfbf00000-0xfc6fffff]
[    0.295856] pci_bus 0000:08: resource 1 [mem 0xfbf00000-0xfc4fffff]
[    0.295856] pci_bus 0000:09: resource 1 [mem 0xfbf00000-0xfc4fffff]
[    0.295857] pci_bus 0000:0b: resource 1 [mem 0xfc400000-0xfc4fffff]
[    0.295857] pci_bus 0000:0c: resource 1 [mem 0xfbf00000-0xfc0fffff]
[    0.295857] pci_bus 0000:0f: resource 1 [mem 0xfc300000-0xfc3fffff]
[    0.295858] pci_bus 0000:10: resource 1 [mem 0xfc200000-0xfc2fffff]
[    0.295858] pci_bus 0000:11: resource 1 [mem 0xfc100000-0xfc1fffff]
[    0.295858] pci_bus 0000:12: resource 1 [mem 0xfc600000-0xfc6fffff]
[    0.295859] pci_bus 0000:13: resource 1 [mem 0xfc500000-0xfc5fffff]
[    0.295859] pci_bus 0000:14: resource 0 [io  0xe000-0xefff]
[    0.295859] pci_bus 0000:14: resource 1 [mem 0xfc700000-0xfcafffff]
[    0.295860] pci_bus 0000:14: resource 2 [mem 0xf820000000-0xf8301fffff 64=
bit pref]
[    0.295860] pci_bus 0000:15: resource 1 [mem 0xfce00000-0xfcefffff]
[    0.295911] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.296439] pci 0000:14:00.1: D0 power state depends on 0000:14:00.0
[    0.296558] PCI: CLS 64 bytes, default 64
[    0.296563] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supporte=
d
[    0.296581] pci 0000:00:01.0: Adding to iommu group 0
[    0.296586] Trying to unpack rootfs image as initramfs...
[    0.296586] pci 0000:00:01.1: Adding to iommu group 1
[    0.296592] pci 0000:00:01.2: Adding to iommu group 2
[    0.296599] pci 0000:00:02.0: Adding to iommu group 3
[    0.296604] pci 0000:00:02.1: Adding to iommu group 4
[    0.296610] pci 0000:00:03.0: Adding to iommu group 5
[    0.296617] pci 0000:00:04.0: Adding to iommu group 6
[    0.296625] pci 0000:00:08.0: Adding to iommu group 7
[    0.296630] pci 0000:00:08.1: Adding to iommu group 8
[    0.296634] pci 0000:00:08.3: Adding to iommu group 9
[    0.296643] pci 0000:00:14.0: Adding to iommu group 10
[    0.296647] pci 0000:00:14.3: Adding to iommu group 10
[    0.296669] pci 0000:00:18.0: Adding to iommu group 11
[    0.296673] pci 0000:00:18.1: Adding to iommu group 11
[    0.296678] pci 0000:00:18.2: Adding to iommu group 11
[    0.296682] pci 0000:00:18.3: Adding to iommu group 11
[    0.296686] pci 0000:00:18.4: Adding to iommu group 11
[    0.296690] pci 0000:00:18.5: Adding to iommu group 11
[    0.296694] pci 0000:00:18.6: Adding to iommu group 11
[    0.296698] pci 0000:00:18.7: Adding to iommu group 11
[    0.296703] pci 0000:01:00.0: Adding to iommu group 12
[    0.296708] pci 0000:02:00.0: Adding to iommu group 13
[    0.296716] pci 0000:03:00.0: Adding to iommu group 14
[    0.296724] pci 0000:03:00.1: Adding to iommu group 15
[    0.296728] pci 0000:04:00.0: Adding to iommu group 16
[    0.296735] pci 0000:05:00.0: Adding to iommu group 17
[    0.296740] pci 0000:06:00.0: Adding to iommu group 18
[    0.296745] pci 0000:06:08.0: Adding to iommu group 19
[    0.296750] pci 0000:06:0c.0: Adding to iommu group 20
[    0.296756] pci 0000:06:0d.0: Adding to iommu group 21
[    0.296759] pci 0000:08:00.0: Adding to iommu group 19
[    0.296760] pci 0000:09:00.0: Adding to iommu group 19
[    0.296762] pci 0000:09:04.0: Adding to iommu group 19
[    0.296763] pci 0000:09:05.0: Adding to iommu group 19
[    0.296764] pci 0000:09:06.0: Adding to iommu group 19
[    0.296766] pci 0000:09:07.0: Adding to iommu group 19
[    0.296767] pci 0000:09:08.0: Adding to iommu group 19
[    0.296768] pci 0000:09:0c.0: Adding to iommu group 19
[    0.296770] pci 0000:09:0d.0: Adding to iommu group 19
[    0.296772] pci 0000:0b:00.0: Adding to iommu group 19
[    0.296773] pci 0000:0c:00.0: Adding to iommu group 19
[    0.296775] pci 0000:0f:00.0: Adding to iommu group 19
[    0.296776] pci 0000:10:00.0: Adding to iommu group 19
[    0.296777] pci 0000:11:00.0: Adding to iommu group 19
[    0.296779] pci 0000:12:00.0: Adding to iommu group 20
[    0.296780] pci 0000:13:00.0: Adding to iommu group 21
[    0.296794] pci 0000:14:00.0: Adding to iommu group 22
[    0.296799] pci 0000:14:00.1: Adding to iommu group 23
[    0.296804] pci 0000:14:00.2: Adding to iommu group 24
[    0.296809] pci 0000:14:00.3: Adding to iommu group 25
[    0.296815] pci 0000:14:00.4: Adding to iommu group 26
[    0.296820] pci 0000:15:00.0: Adding to iommu group 27
[    0.298780] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.298781] pci 0000:00:00.2: PCI INT A: not connected
[    0.298855] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.298856] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX G=
T [5] IA GA PC GA_vAPIC
[    0.298859] AMD-Vi: Interrupt remapping enabled
[    0.369481] AMD-Vi: Virtual APIC enabled
[    0.369532] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.369534] software IO TLB: mapped [mem 0x0000000062ffa000-0x0000000066f=
fa000] (64MB)
[    0.369557] LVT offset 0 assigned for vector 0x400
[    0.369711] perf: AMD IBS detected (0x00000bff)
[    0.369714] amd_uncore: 16  amd_df counters detected
[    0.369717] amd_uncore: 6  amd_l3 counters detected
[    0.370155] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/ba=
nk).
[    0.371673] Initialise system trusted keyrings
[    0.371679] Key type blacklist registered
[    0.371696] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=3D=
0
[    0.371704] zbud: loaded
[    0.371895] integrity: Platform Keyring initialized
[    0.371897] integrity: Machine keyring initialized
[    0.373604] NET: Registered PF_ALG protocol family
[    0.373606] xor: automatically using best checksumming function   avx    =
  =20
[    0.373607] Key type asymmetric registered
[    0.373607] Asymmetric key parser 'x509' registered
[    0.500075] Freeing initrd memory: 51544K
[    0.501797] Block layer SCSI generic (bsg) driver version 0.4 loaded (maj=
or 245)
[    0.501823] io scheduler mq-deadline registered
[    0.501823] io scheduler kyber registered
[    0.501828] io scheduler bfq registered
[    0.502783] atomic64_test: passed for x86-64 platform with CX8 and with S=
SE
[    0.503649] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
[    0.503727] pcieport 0000:00:01.2: PME: Signaling with IRQ 28
[    0.503803] pcieport 0000:00:02.1: PME: Signaling with IRQ 29
[    0.503884] pcieport 0000:00:08.1: PME: Signaling with IRQ 30
[    0.503946] pcieport 0000:00:08.3: PME: Signaling with IRQ 31
[    0.505168] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.505216] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C=
0C:00/input/input0
[    0.505224] ACPI: button: Power Button [PWRB]
[    0.505237] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input=
/input1
[    0.505253] ACPI: button: Power Button [PWRF]
[    0.505301] Estimated ratio of average max frequency by base frequency (t=
imes 1024): 1214
[    0.505307] Monitor-Mwait will be used to enter C-1 state
[    0.505311] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.505379] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.505438] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.505492] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.505546] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.505599] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.505654] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[    0.505708] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[    0.505746] ACPI: \_SB_.PLTF.C010: Found 3 idle states
[    0.505786] ACPI: \_SB_.PLTF.C012: Found 3 idle states
[    0.505819] ACPI: \_SB_.PLTF.C014: Found 3 idle states
[    0.505867] ACPI: \_SB_.PLTF.C016: Found 3 idle states
[    0.505917] ACPI: \_SB_.PLTF.C018: Found 3 idle states
[    0.505973] ACPI: \_SB_.PLTF.C01A: Found 3 idle states
[    0.506025] ACPI: \_SB_.PLTF.C01C: Found 3 idle states
[    0.506079] ACPI: \_SB_.PLTF.C01E: Found 3 idle states
[    0.506118] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.506172] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.506224] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.506274] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.506326] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.506376] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.506421] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[    0.506468] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[    0.506520] ACPI: \_SB_.PLTF.C011: Found 3 idle states
[    0.506569] ACPI: \_SB_.PLTF.C013: Found 3 idle states
[    0.506617] ACPI: \_SB_.PLTF.C015: Found 3 idle states
[    0.506661] ACPI: \_SB_.PLTF.C017: Found 3 idle states
[    0.506706] ACPI: \_SB_.PLTF.C019: Found 3 idle states
[    0.506753] ACPI: \_SB_.PLTF.C01B: Found 3 idle states
[    0.506804] ACPI: \_SB_.PLTF.C01D: Found 3 idle states
[    0.506848] ACPI: \_SB_.PLTF.C01F: Found 3 idle states
[    0.506975] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.507062] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 1152=
00) is a 16550A
[    0.507544] Non-volatile memory driver v1.3
[    0.507546] Linux agpgart interface v0.103
[    0.532614] ACPI: bus type drm_connector registered
[    0.533307] ahci 0000:11:00.0: version 3.0
[    0.533378] ahci 0000:11:00.0: SSS flag set, parallel bus scan disabled
[    0.533414] ahci 0000:11:00.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0xf=
 impl SATA mode
[    0.533415] ahci 0000:11:00.0: flags: 64bit ncq sntf stag pm led clo only=
 pmp pio slum part sxs deso sadm sds apst=20
[    0.533582] scsi host0: ahci
[    0.533630] scsi host1: ahci
[    0.533669] scsi host2: ahci
[    0.533705] scsi host3: ahci
[    0.533739] scsi host4: ahci
[    0.533775] scsi host5: ahci
[    0.533789] ata1: SATA max UDMA/133 abar m1024@0xfc180000 port 0xfc180100=
 irq 45
[    0.533791] ata2: SATA max UDMA/133 abar m1024@0xfc180000 port 0xfc180180=
 irq 45
[    0.533794] ata3: SATA max UDMA/133 abar m1024@0xfc180000 port 0xfc180200=
 irq 45
[    0.533794] ata4: SATA max UDMA/133 abar m1024@0xfc180000 port 0xfc180280=
 irq 45
[    0.533796] ata5: DUMMY
[    0.533796] ata6: DUMMY
[    0.533860] ahci 0000:13:00.0: SSS flag set, parallel bus scan disabled
[    0.533883] ahci 0000:13:00.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0xf=
 impl SATA mode
[    0.533884] ahci 0000:13:00.0: flags: 64bit ncq sntf stag pm led clo only=
 pmp pio slum part sxs deso sadm sds apst=20
[    0.534039] scsi host6: ahci
[    0.534077] scsi host7: ahci
[    0.534110] scsi host8: ahci
[    0.534144] scsi host9: ahci
[    0.534179] scsi host10: ahci
[    0.534216] scsi host11: ahci
[    0.534228] ata7: SATA max UDMA/133 abar m1024@0xfc580000 port 0xfc580100=
 irq 46
[    0.534229] ata8: SATA max UDMA/133 abar m1024@0xfc580000 port 0xfc580180=
 irq 46
[    0.534230] ata9: SATA max UDMA/133 abar m1024@0xfc580000 port 0xfc580200=
 irq 46
[    0.534231] ata10: SATA max UDMA/133 abar m1024@0xfc580000 port 0xfc58028=
0 irq 46
[    0.534232] ata11: DUMMY
[    0.534232] ata12: DUMMY
[    0.534371] xhci_hcd 0000:10:00.0: xHCI Host Controller
[    0.534383] xhci_hcd 0000:10:00.0: new USB bus registered, assigned bus n=
umber 1
[    0.590363] xhci_hcd 0000:10:00.0: hcc params 0x0200ef81 hci version 0x11=
0 quirks 0x0000000000000410
[    0.590682] xhci_hcd 0000:10:00.0: xHCI Host Controller
[    0.590694] xhci_hcd 0000:10:00.0: new USB bus registered, assigned bus n=
umber 2
[    0.590695] xhci_hcd 0000:10:00.0: Host supports USB 3.2 Enhanced SuperSp=
eed
[    0.591272] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002, bcdDevice=3D 6.03
[    0.591273] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.591273] usb usb1: Product: xHCI Host Controller
[    0.591274] usb usb1: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.591274] usb usb1: SerialNumber: 0000:10:00.0
[    0.591320] hub 1-0:1.0: USB hub found
[    0.591333] hub 1-0:1.0: 12 ports detected
[    0.591939] usb usb2: We don't know the algorithms for LPM for this host,=
 disabling LPM.
[    0.591945] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D=
0003, bcdDevice=3D 6.03
[    0.591946] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.591947] usb usb2: Product: xHCI Host Controller
[    0.591947] usb usb2: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.591947] usb usb2: SerialNumber: 0000:10:00.0
[    0.591971] hub 2-0:1.0: USB hub found
[    0.591977] hub 2-0:1.0: 5 ports detected
[    0.592264] xhci_hcd 0000:12:00.0: xHCI Host Controller
[    0.592275] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus n=
umber 3
[    0.648253] xhci_hcd 0000:12:00.0: hcc params 0x0200ef81 hci version 0x11=
0 quirks 0x0000000000000410
[    0.648517] xhci_hcd 0000:12:00.0: xHCI Host Controller
[    0.648527] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus n=
umber 4
[    0.648529] xhci_hcd 0000:12:00.0: Host supports USB 3.2 Enhanced SuperSp=
eed
[    0.649164] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002, bcdDevice=3D 6.03
[    0.649165] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.649165] usb usb3: Product: xHCI Host Controller
[    0.649166] usb usb3: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.649166] usb usb3: SerialNumber: 0000:12:00.0
[    0.649212] hub 3-0:1.0: USB hub found
[    0.649221] hub 3-0:1.0: 12 ports detected
[    0.649787] usb usb4: We don't know the algorithms for LPM for this host,=
 disabling LPM.
[    0.649792] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D=
0003, bcdDevice=3D 6.03
[    0.649793] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.649793] usb usb4: Product: xHCI Host Controller
[    0.649794] usb usb4: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.649794] usb usb4: SerialNumber: 0000:12:00.0
[    0.649817] hub 4-0:1.0: USB hub found
[    0.649821] hub 4-0:1.0: 5 ports detected
[    0.650088] xhci_hcd 0000:14:00.3: xHCI Host Controller
[    0.650099] xhci_hcd 0000:14:00.3: new USB bus registered, assigned bus n=
umber 5
[    0.650426] xhci_hcd 0000:14:00.3: hcc params 0x0120ffc5 hci version 0x12=
0 quirks 0x0000000200000410
[    0.650701] xhci_hcd 0000:14:00.3: xHCI Host Controller
[    0.650711] xhci_hcd 0000:14:00.3: new USB bus registered, assigned bus n=
umber 6
[    0.650711] xhci_hcd 0000:14:00.3: Host supports USB 3.1 Enhanced SuperSp=
eed
[    0.650721] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002, bcdDevice=3D 6.03
[    0.650722] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.650723] usb usb5: Product: xHCI Host Controller
[    0.650723] usb usb5: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.650724] usb usb5: SerialNumber: 0000:14:00.3
[    0.650749] hub 5-0:1.0: USB hub found
[    0.650751] hub 5-0:1.0: 2 ports detected
[    0.650887] usb usb6: We don't know the algorithms for LPM for this host,=
 disabling LPM.
[    0.650892] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=3D=
0003, bcdDevice=3D 6.03
[    0.650893] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.650893] usb usb6: Product: xHCI Host Controller
[    0.650893] usb usb6: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.650894] usb usb6: SerialNumber: 0000:14:00.3
[    0.650915] hub 6-0:1.0: USB hub found
[    0.650917] hub 6-0:1.0: 2 ports detected
[    0.651050] xhci_hcd 0000:14:00.4: xHCI Host Controller
[    0.651063] xhci_hcd 0000:14:00.4: new USB bus registered, assigned bus n=
umber 7
[    0.651410] xhci_hcd 0000:14:00.4: hcc params 0x0120ffc5 hci version 0x12=
0 quirks 0x0000000200000410
[    0.651662] xhci_hcd 0000:14:00.4: xHCI Host Controller
[    0.651672] xhci_hcd 0000:14:00.4: new USB bus registered, assigned bus n=
umber 8
[    0.651672] xhci_hcd 0000:14:00.4: Host supports USB 3.1 Enhanced SuperSp=
eed
[    0.651682] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002, bcdDevice=3D 6.03
[    0.651682] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.651683] usb usb7: Product: xHCI Host Controller
[    0.651683] usb usb7: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.651683] usb usb7: SerialNumber: 0000:14:00.4
[    0.651707] hub 7-0:1.0: USB hub found
[    0.651709] hub 7-0:1.0: 2 ports detected
[    0.651822] usb usb8: We don't know the algorithms for LPM for this host,=
 disabling LPM.
[    0.651827] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=3D=
0003, bcdDevice=3D 6.03
[    0.651828] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.651828] usb usb8: Product: xHCI Host Controller
[    0.651829] usb usb8: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.651829] usb usb8: SerialNumber: 0000:14:00.4
[    0.651849] hub 8-0:1.0: USB hub found
[    0.651851] hub 8-0:1.0: 2 ports detected
[    0.651982] xhci_hcd 0000:15:00.0: xHCI Host Controller
[    0.651991] xhci_hcd 0000:15:00.0: new USB bus registered, assigned bus n=
umber 9
[    0.653261] xhci_hcd 0000:15:00.0: USB3 root hub has no ports
[    0.653263] xhci_hcd 0000:15:00.0: hcc params 0x0110ffc5 hci version 0x12=
0 quirks 0x0000000200000410
[    0.653537] xhci_hcd 0000:15:00.0: xHCI Host Controller
[    0.653545] xhci_hcd 0000:15:00.0: new USB bus registered, assigned bus n=
umber 10
[    0.653545] xhci_hcd 0000:15:00.0: Host supports USB 3.0 SuperSpeed
[    0.653560] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002, bcdDevice=3D 6.03
[    0.653560] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[    0.653561] usb usb9: Product: xHCI Host Controller
[    0.653561] usb usb9: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hcd=

[    0.653561] usb usb9: SerialNumber: 0000:15:00.0
[    0.653587] hub 9-0:1.0: USB hub found
[    0.653589] hub 9-0:1.0: 1 port detected
[    0.653654] usb usb10: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.653659] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=3D=
0003, bcdDevice=3D 6.03
[    0.653660] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.653660] usb usb10: Product: xHCI Host Controller
[    0.653660] usb usb10: Manufacturer: Linux 6.3.11-200.fc38.x86_64 xhci-hc=
d
[    0.653661] usb usb10: SerialNumber: 0000:15:00.0
[    0.653682] hub 10-0:1.0: USB hub found
[    0.653683] hub 10-0:1.0: config failed, hub doesn't have any ports! (err=
 -19)
[    0.653699] usbcore: registered new interface driver usbserial_generic
[    0.653701] usbserial: USB Serial support registered for generic
[    0.653710] i8042: PNP: No PS/2 controller found.
[    0.653719] mousedev: PS/2 mouse device common for all mice
[    0.653745] rtc_cmos 00:02: RTC can wake from S4
[    0.653884] rtc_cmos 00:02: registered as rtc0
[    0.653906] rtc_cmos 00:02: setting system clock to 2023-07-06T20:10:50 U=
TC (1688674250)
[    0.653919] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram,=
 hpet irqs
[    0.653927] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. D=
uplicate IMA measurements will not be recorded in the IMA log.
[    0.653929] device-mapper: uevent: version 1.0.3
[    0.653945] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: d=
m-devel@redhat.com
[    0.653974] amd_pstate: driver load is disabled, boot with specific mode t=
o enable this
[    0.654104] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebu=
ffer.0 on minor 0
[    0.654479] fbcon: Deferring console take-over
[    0.654480] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrm=
drmfb frame buffer device
[    0.654505] hid: raw HID events driver (C) Jiri Kosina
[    0.654519] usbcore: registered new interface driver usbhid
[    0.654520] usbhid: USB HID core driver
[    0.654610] drop_monitor: Initializing network drop monitor service
[    0.660054] Initializing XFRM netlink socket
[    0.660063] NET: Registered PF_INET6 protocol family
[    0.661758] Segment Routing with IPv6
[    0.661759] RPL Segment Routing with IPv6
[    0.661761] In-situ OAM (IOAM) with IPv6
[    0.661768] mip6: Mobile IPv6
[    0.661769] NET: Registered PF_PACKET protocol family
[    0.662716] microcode: CPU1: patch_level=3D0x0a601203
[    0.662716] microcode: CPU0: patch_level=3D0x0a601203
[    0.662717] microcode: CPU2: patch_level=3D0x0a601203
[    0.662717] microcode: CPU3: patch_level=3D0x0a601203
[    0.662717] microcode: CPU4: patch_level=3D0x0a601203
[    0.662718] microcode: CPU5: patch_level=3D0x0a601203
[    0.662718] microcode: CPU8: patch_level=3D0x0a601203
[    0.662718] microcode: CPU9: patch_level=3D0x0a601203
[    0.662718] microcode: CPU6: patch_level=3D0x0a601203
[    0.662719] microcode: CPU7: patch_level=3D0x0a601203
[    0.662719] microcode: CPU13: patch_level=3D0x0a601203
[    0.662719] microcode: CPU14: patch_level=3D0x0a601203
[    0.662720] microcode: CPU12: patch_level=3D0x0a601203
[    0.662719] microcode: CPU11: patch_level=3D0x0a601203
[    0.662720] microcode: CPU15: patch_level=3D0x0a601203
[    0.662721] microcode: CPU16: patch_level=3D0x0a601203
[    0.662722] microcode: CPU17: patch_level=3D0x0a601203
[    0.662722] microcode: CPU18: patch_level=3D0x0a601203
[    0.662723] microcode: CPU19: patch_level=3D0x0a601203
[    0.662723] microcode: CPU20: patch_level=3D0x0a601203
[    0.662724] microcode: CPU21: patch_level=3D0x0a601203
[    0.662725] microcode: CPU22: patch_level=3D0x0a601203
[    0.662726] microcode: CPU25: patch_level=3D0x0a601203
[    0.662726] microcode: CPU24: patch_level=3D0x0a601203
[    0.662726] microcode: CPU23: patch_level=3D0x0a601203
[    0.662727] microcode: CPU26: patch_level=3D0x0a601203
[    0.662727] microcode: CPU28: patch_level=3D0x0a601203
[    0.662727] microcode: CPU27: patch_level=3D0x0a601203
[    0.662728] microcode: CPU10: patch_level=3D0x0a601203
[    0.662728] microcode: CPU29: patch_level=3D0x0a601203
[    0.662728] microcode: CPU30: patch_level=3D0x0a601203
[    0.662729] microcode: CPU31: patch_level=3D0x0a601203
[    0.662755] microcode: Microcode Update Driver: v2.2.
[    0.662887] resctrl: L3 allocation detected
[    0.662888] resctrl: MB allocation detected
[    0.662888] resctrl: SMBA allocation detected
[    0.662888] resctrl: L3 monitoring detected
[    0.662890] IPI shorthand broadcast: enabled
[    0.662893] AVX2 version of gcm_enc/dec engaged.
[    0.663003] AES CTR mode by8 optimization enabled
[    0.663541] sched_clock: Marking stable (661581643, 1302118)->(700635712,=
 -37751951)
[    0.663921] registered taskstats version 1
[    0.664191] Loading compiled-in X.509 certificates
[    0.668144] Loaded X.509 cert 'Fedora kernel signing key: 0051eda10f5b2ef=
a45b5ee9ab5488aa75690e61c'
[    0.668389] zswap: loaded using pool lzo/zbud
[    0.669221] page_owner is disabled
[    0.669245] Key type .fscrypt registered
[    0.669246] Key type fscrypt-provisioning registered
[    0.669385] Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3Dyes, fsverity=3D=
yes
[    0.669391] Key type big_key registered
[    0.669575] Key type trusted registered
[    0.670592] Key type encrypted registered
[    0.670637] integrity: Loading X.509 certificate: UEFI:db
[    0.674108] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key Cert=
ificate: da83b990422ebc8c441f8d8b039a65a2'
[    0.674109] integrity: Loading X.509 certificate: UEFI:db
[    0.674180] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certifi=
cate: b8e581e4df77a5bb4282d5ccfc00c071'
[    0.674181] integrity: Loading X.509 certificate: UEFI:db
[    0.674188] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2=
011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.674188] integrity: Loading X.509 certificate: UEFI:db
[    0.674195] integrity: Loaded X.509 cert 'Microsoft Windows Production PC=
A 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.674195] integrity: Loading X.509 certificate: UEFI:db
[    0.674306] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certifica=
te Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.675031] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar t=
able)
[    0.675138] integrity: Loaded X.509 cert 'Fedora Secure Boot CA: fde32599=
c2d61db1bf5807335d7b20e4cd963b42'
[    0.675141] Loading compiled-in module X.509 certificates
[    0.675382] Loaded X.509 cert 'Fedora kernel signing key: 0051eda10f5b2ef=
a45b5ee9ab5488aa75690e61c'
[    0.675383] ima: Allocated hash algorithm: sha256
[    0.707759] audit: type=3D1807 audit(1688674250.552:2): action=3Dmeasure f=
unc=3DKEXEC_KERNEL_CHECK res=3D1
[    0.707761] audit: type=3D1807 audit(1688674250.552:3): action=3Dmeasure f=
unc=3DMODULE_CHECK res=3D1
[    0.707762] evm: Initialising EVM extended attributes:
[    0.707762] evm: security.selinux
[    0.707763] evm: security.SMACK64 (disabled)
[    0.707763] evm: security.SMACK64EXEC (disabled)
[    0.707763] evm: security.SMACK64TRANSMUTE (disabled)
[    0.707763] evm: security.SMACK64MMAP (disabled)
[    0.707764] evm: security.apparmor (disabled)
[    0.707764] evm: security.ima
[    0.707764] evm: security.capability
[    0.707764] evm: HMAC attrs: 0x1
[    0.723180] alg: No test for 842 (842-scomp)
[    0.723195] alg: No test for 842 (842-generic)
[    0.773920] PM:   Magic number: 15:195:194
[    0.775452] RAS: Correctable Errors collector initialized.
[    0.775464] Lockdown: swapper/0: hibernation is restricted; see man kerne=
l_lockdown.7
[    0.840972] ata7: SATA link down (SStatus 0 SControl 300)
[    0.846611] ata1: SATA link down (SStatus 0 SControl 330)
[    0.894662] usb 7-2: new full-speed USB device number 2 using xhci_hcd
[    0.932415] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    0.948620] usb 3-5: new high-speed USB device number 2 using xhci_hcd
[    1.046790] usb 7-2: New USB device found, idVendor=3D3151, idProduct=3D4=
003, bcdDevice=3D 3.01
[    1.046791] usb 7-2: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D0
[    1.046792] usb 7-2: Product: Akko Keyboard
[    1.046792] usb 7-2: Manufacturer: ROYUAN
[    1.058739] input: ROYUAN Akko Keyboard as /devices/pci0000:00/0000:00:08=
.1/0000:14:00.4/usb7/7-2/7-2:1.0/0003:3151:4003.0001/input/input2
[    1.110379] hid-generic 0003:3151:4003.0001: input,hidraw0: USB HID v1.11=
 Keyboard [ROYUAN Akko Keyboard] on usb-0000:14:00.4-2/input0
[    1.113740] input: ROYUAN Akko Keyboard Consumer Control as /devices/pci0=
000:00/0000:00:08.1/0000:14:00.4/usb7/7-2/7-2:1.1/0003:3151:4003.0002/input/=
input3
[    1.156385] ata2: SATA link down (SStatus 0 SControl 330)
[    1.165374] input: ROYUAN Akko Keyboard System Control as /devices/pci000=
0:00/0000:00:08.1/0000:14:00.4/usb7/7-2/7-2:1.1/0003:3151:4003.0002/input/in=
put4
[    1.165404] input: ROYUAN Akko Keyboard as /devices/pci0000:00/0000:00:08=
.1/0000:14:00.4/usb7/7-2/7-2:1.1/0003:3151:4003.0002/input/input5
[    1.165425] input: ROYUAN Akko Keyboard Mouse as /devices/pci0000:00/0000=
:00:08.1/0000:14:00.4/usb7/7-2/7-2:1.1/0003:3151:4003.0002/input/input6
[    1.165452] input: ROYUAN Akko Keyboard as /devices/pci0000:00/0000:00:08=
.1/0000:14:00.4/usb7/7-2/7-2:1.1/0003:3151:4003.0002/input/input7
[    1.165501] hid-generic 0003:3151:4003.0002: input,hiddev96,hidraw1: USB H=
ID v1.11 Keyboard [ROYUAN Akko Keyboard] on usb-0000:14:00.4-2/input1
[    1.175033] usb 3-5: New USB device found, idVendor=3D05e3, idProduct=3D0=
610, bcdDevice=3D70.31
[    1.175034] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D0
[    1.175035] usb 3-5: Product: USB2.1 Hub
[    1.175036] usb 3-5: Manufacturer: GenesysLogic
[    1.183067] hub 3-5:1.0: USB hub found
[    1.187021] hub 3-5:1.0: 4 ports detected
[    1.272561] usb 4-5: new SuperSpeed Plus Gen 2x1 USB device number 2 usin=
g xhci_hcd
[    1.288822] usb 4-5: New USB device found, idVendor=3D05e3, idProduct=3D0=
625, bcdDevice=3D70.31
[    1.288825] usb 4-5: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D0
[    1.288826] usb 4-5: Product: USB3.2 Hub
[    1.288827] usb 4-5: Manufacturer: GenesysLogic
[    1.295378] hub 4-5:1.0: USB hub found
[    1.295657] hub 4-5:1.0: 4 ports detected
[    1.304828] usb 1-2: New USB device found, idVendor=3D046d, idProduct=3Dc=
095, bcdDevice=3D27.00
[    1.304830] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D3
[    1.304830] usb 1-2: Product: G502 X PLUS
[    1.304831] usb 1-2: Manufacturer: Logitech
[    1.304831] usb 1-2: SerialNumber: A1E093D3
[    1.329934] input: Logitech G502 X PLUS as /devices/pci0000:00/0000:00:02=
.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-2=
/1-2:1.0/0003:046D:C095.0003/input/input8
[    1.330005] hid-generic 0003:046D:C095.0003: input,hidraw2: USB HID v1.11=
 Mouse [Logitech G502 X PLUS] on usb-0000:10:00.0-2/input0
[    1.339000] input: Logitech G502 X PLUS Keyboard as /devices/pci0000:00/0=
000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0=
/usb1/1-2/1-2:1.1/0003:046D:C095.0004/input/input9
[    1.390595] hid-generic 0003:046D:C095.0004: input,hidraw3: USB HID v1.11=
 Keyboard [Logitech G502 X PLUS] on usb-0000:10:00.0-2/input1
[    1.396336] tsc: Refined TSC clocksource calibration: 4199.978 MHz
[    1.396342] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3c8a=
4cbe93a, max_idle_ns: 440795327229 ns
[    1.396380] clocksource: Switched to clocksource tsc
[    1.397663] hid-generic 0003:046D:C095.0005: hiddev97,hidraw4: USB HID v1=
.11 Device [Logitech G502 X PLUS] on usb-0000:10:00.0-2/input2
[    1.462709] usb 3-6: new high-speed USB device number 3 using xhci_hcd
[    1.468026] ata3: SATA link down (SStatus 0 SControl 330)
[    1.573541] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[    1.782055] ata4: SATA link down (SStatus 0 SControl 330)
[    1.927318] usb 1-4: New USB device found, idVendor=3D046d, idProduct=3D0=
ab7, bcdDevice=3D 0.20
[    1.927323] usb 1-4: New USB device strings: Mfr=3D3, Product=3D1, Serial=
Number=3D2
[    1.927324] usb 1-4: Product: Blue Microphones
[    1.927325] usb 1-4: Manufacturer: Generic
[    1.927326] usb 1-4: SerialNumber: 2149BAH07JQ8
[    1.974181] input: Generic Blue Microphones Consumer Control as /devices/=
pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/=
0000:10:00.0/usb1/1-4/1-4:1.3/0003:046D:0AB7.0006/input/input10
[    2.025642] input: Generic Blue Microphones as /devices/pci0000:00/0000:0=
0:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1=
/1-4/1-4:1.3/0003:046D:0AB7.0006/input/input11
[    2.025697] hid-generic 0003:046D:0AB7.0006: input,hiddev98,hidraw5: USB H=
ID v1.11 Device [Generic Blue Microphones] on usb-0000:10:00.0-4/input3
[    2.094517] ata8: SATA link down (SStatus 0 SControl 300)
[    2.202564] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    2.406546] ata9: SATA link down (SStatus 0 SControl 300)
[    2.582815] usb 1-9: New USB device found, idVendor=3D8087, idProduct=3D0=
032, bcdDevice=3D 0.00
[    2.582820] usb 1-9: New USB device strings: Mfr=3D0, Product=3D0, Serial=
Number=3D0
[    2.718542] ata10: SATA link down (SStatus 0 SControl 300)
[    2.719153] Freeing unused decrypted memory: 2036K
[    2.719405] Freeing unused kernel image (initmem) memory: 4460K
[    2.719407] Write protecting the kernel read-only data: 32768k
[    2.719527] Freeing unused kernel image (rodata/data gap) memory: 192K
[    2.736961] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.736964] Run /init as init process
[    2.736965]   with arguments:
[    2.736965]     /init
[    2.736966]     rhgb
[    2.736966]   with environment:
[    2.736966]     HOME=3D/
[    2.736967]     TERM=3Dlinux
[    2.736967]     BOOT_IMAGE=3D(hd1,gpt2)/vmlinuz-6.3.11-200.fc38.x86_64
[    2.742887] systemd[1]: systemd 253.5-1.fc38 running in system mode (+PAM=
 +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +AC=
L +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFD=
ISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +B=
PF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[    2.742889] systemd[1]: Detected architecture x86-64.
[    2.742890] systemd[1]: Running in initrd.
[    2.742928] systemd[1]: No hostname configured, using default hostname.
[    2.742946] systemd[1]: Hostname set to <fedora>.
[    2.789475] systemd[1]: bpf-lsm: LSM BPF program attached
[    2.811215] systemd[1]: Queued start job for default target initrd.target=
.
[    2.828474] systemd[1]: Reached target initrd-usr-fs.target - Initrd /usr=
 File System.
[    2.828502] systemd[1]: Reached target local-fs.target - Local File Syste=
ms.
[    2.828512] systemd[1]: Reached target slices.target - Slice Units.
[    2.828521] systemd[1]: Reached target swap.target - Swaps.
[    2.828527] systemd[1]: Reached target timers.target - Timer Units.
[    2.828571] systemd[1]: Listening on dbus.socket - D-Bus System Message B=
us Socket.
[    2.828617] systemd[1]: Listening on systemd-journald-dev-log.socket - Jo=
urnal Socket (/dev/log).
[    2.828659] systemd[1]: Listening on systemd-journald.socket - Journal So=
cket.
[    2.828705] systemd[1]: Listening on systemd-udevd-control.socket - udev C=
ontrol Socket.
[    2.828739] systemd[1]: Listening on systemd-udevd-kernel.socket - udev K=
ernel Socket.
[    2.828745] systemd[1]: Reached target sockets.target - Socket Units.
[    2.829238] systemd[1]: Starting kmod-static-nodes.service - Create List o=
f Static Device Nodes...
[    2.829263] systemd[1]: memstrack.service - Memstrack Anylazing Service w=
as skipped because no trigger condition checks were met.
[    2.830126] systemd[1]: Starting systemd-journald.service - Journal Servi=
ce...
[    2.830434] systemd[1]: Starting systemd-modules-load.service - Load Kern=
el Modules...
[    2.830678] systemd[1]: Starting systemd-sysusers.service - Create System=
 Users...
[    2.830957] systemd[1]: Starting systemd-vconsole-setup.service - Setup V=
irtual Console...
[    2.834484] systemd-journald[481]: Collecting audit messages is disabled.=

[    2.839746] fuse: init (API version 7.38)
[    2.846392] systemd[1]: Finished kmod-static-nodes.service - Create List o=
f Static Device Nodes.
[    2.866387] systemd[1]: Finished systemd-modules-load.service - Load Kern=
el Modules.
[    2.866450] systemd[1]: Started systemd-journald.service - Journal Servic=
e.
[    3.083920] acpi PNP0C14:03: duplicate WMI GUID 97845ED0-4E6D-11DE-8A39-0=
800200C9A66 (first instance was on PNP0C14:00)
[    3.086363] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  po=
st: no)
[    3.087946] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:=
00/device:20/LNXVIDEO:00/input/input12
[    3.092287] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    3.092351] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO add=
ress
[    3.092392] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (noway=
out=3D0)
[    3.093695] Intel(R) 2.5G Ethernet Linux Driver
[    3.093697] Copyright(c) 2018 Intel Corporation.
[    3.093775] igc 0000:0c:00.0: PCIe PTM not supported by PCIe bus/controll=
er
[    3.097634] ccp 0000:14:00.2: enabling device (0000 -> 0002)
[    3.099569] nvme nvme1: pci function 0000:0f:00.0
[    3.099971] nvme nvme0: pci function 0000:04:00.0
[    3.104861] nvme nvme0: missing or invalid SUBNQN field.
[    3.107899] ccp 0000:14:00.2: tee enabled
[    3.107905] ccp 0000:14:00.2: psp enabled
[    3.129784] nvme nvme0: allocated 32 MiB host memory buffer.
[    3.142621] pps pps0: new PPS source ptp0
[    3.142643] igc 0000:0c:00.0 (unnamed net_device) (uninitialized): PHC ad=
ded
[    3.166703] nvme nvme0: 8/0/0 default/read/poll queues
[    3.169323] nvme nvme0: Ignoring bogus Namespace Identifiers
[    3.169464] igc 0000:0c:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT=
/s PCIe x1 link)
[    3.169466] igc 0000:0c:00.0 eth0: MAC: a0:36:bc:ac:c1:34
[    3.170524]  nvme0n1:
[    3.192057] nvme nvme1: missing or invalid SUBNQN field.
[    3.250160] nvme nvme1: allocated 128 MiB host memory buffer.
[    3.339997] nvme nvme1: 8/0/0 default/read/poll queues
[    3.346796] nvme nvme1: Ignoring bogus Namespace Identifiers
[    3.350024]  nvme1n1: p1 p2 p3
[    3.351499] igc 0000:0c:00.0 eno1: renamed from eth0
[    3.351740] AMD-Vi: AMD IOMMUv2 loaded and initialized
[    3.356334] BTRFS: device label fedora_localhost-live devid 1 transid 176=
 /dev/nvme1n1p3 scanned by (udev-worker) (659)
[    3.765996] usb 3-6: New USB device found, idVendor=3D0b05, idProduct=3D1=
a52, bcdDevice=3D 0.05
[    3.766000] usb 3-6: New USB device strings: Mfr=3D3, Product=3D1, Serial=
Number=3D0
[    3.766002] usb 3-6: Product: USB Audio
[    3.766003] usb 3-6: Manufacturer: Generic
[    3.822115] hid-generic 0003:0B05:1A52.0007: hiddev99,hidraw6: USB HID v1=
.11 Device [Generic USB Audio] on usb-0000:12:00.0-6/input7
[    3.997314] usb 3-7: new full-speed USB device number 4 using xhci_hcd
[    4.127430] [drm] amdgpu kernel modesetting enabled.
[    4.127442] amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0.=
GP17.VGA_.ATPX handle
[    4.127492] ATPX version 1, functions 0x00000000
[    4.129698] amdgpu: Ignoring ACPI CRAT on non-APU system
[    4.129700] amdgpu: Virtual CRAT table created for CPU
[    4.129704] amdgpu: Topology: Add CPU node
[    4.129761] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    4.129778] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x=
744C 0x1EAE:0x7901 0xC8).
[    4.129783] [drm] register mmio base: 0xFCB00000
[    4.129783] [drm] register mmio size: 1048576
[    4.131524] [drm] add ip block number 0 <soc21_common>
[    4.131525] [drm] add ip block number 1 <gmc_v11_0>
[    4.131525] [drm] add ip block number 2 <ih_v6_0>
[    4.131525] [drm] add ip block number 3 <psp>
[    4.131526] [drm] add ip block number 4 <smu>
[    4.131526] [drm] add ip block number 5 <dm>
[    4.131526] [drm] add ip block number 6 <gfx_v11_0>
[    4.131527] [drm] add ip block number 7 <sdma_v6_0>
[    4.131527] [drm] add ip block number 8 <vcn_v4_0>
[    4.131527] [drm] add ip block number 9 <jpeg_v4_0>
[    4.131528] [drm] add ip block number 10 <mes_v11_0>
[    4.131538] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.131539] amdgpu: ATOM BIOS: 113-31XFSHBS1-L01
[    4.149182] amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
[    4.154935] [drm] VCN(0) encode/decode are enabled in VM mode
[    4.154936] [drm] VCN(1) encode/decode are enabled in VM mode
[    4.163553] amdgpu 0000:03:00.0: [drm:jpeg_v4_0_early_init [amdgpu]] JPEG=
 decode is enabled in VM mode
[    4.185442] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    4.185444] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featur=
e not supported
[    4.185471] amdgpu 0000:03:00.0: amdgpu: MEM ECC is not presented.
[    4.185472] amdgpu 0000:03:00.0: amdgpu: SRAM ECC is not presented.
[    4.185506] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fr=
agment size is 9-bit
[    4.185509] amdgpu 0000:03:00.0: amdgpu: VRAM: 24560M 0x0000008000000000 -=
 0x00000085FEFFFFFF (24560M used)
[    4.185511] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0=
x000000001FFFFFFF
[    4.185512] amdgpu 0000:03:00.0: amdgpu: AGP: 267878400M 0x00000088000000=
00 - 0x0000FFFFFFFFFFFF
[    4.185518] [drm] Detected VRAM RAM=3D24560M, BAR=3D32768M
[    4.185518] [drm] RAM width 384bits GDDR6
[    4.185597] [drm] amdgpu: 24560M of VRAM memory ready
[    4.185598] [drm] amdgpu: 15602M of GTT memory ready.
[    4.185606] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    4.185663] [drm] PCIE GART of 512M enabled (table at 0x00000085FEB00000)=
.
[    4.185854] [drm] Loading DMUB firmware via PSP: version=3D0x07001900
[    4.187480] [drm] Found VCN firmware Version ENC: 1.11 DEC: 5 VEP: 0 Revi=
sion: 12
[    4.187484] amdgpu 0000:03:00.0: amdgpu: Will use PSP to load VCN firmwar=
e
[    4.187573] [drm] max_doorbell_slices=3D32767
[    4.344429] [drm] reserve 0x1300000 from 0x85fc000000 for PSP TMR
[    4.358771] usb 3-7: config 1 has an invalid interface number: 2 but max i=
s 1
[    4.358774] usb 3-7: config 1 has no interface number 1
[    4.370745] usb 3-7: New USB device found, idVendor=3D0b05, idProduct=3D1=
9af, bcdDevice=3D 1.00
[    4.370748] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D3
[    4.370750] usb 3-7: Product: AURA LED Controller
[    4.370751] usb 3-7: Manufacturer: AsusTek Computer Inc.
[    4.370752] usb 3-7: SerialNumber: 9876543210
[    4.386596] hid-generic 0003:0B05:19AF.0008: hiddev100,hidraw7: USB HID v=
1.11 Device [AsusTek Computer Inc. AURA LED Controller] on usb-0000:12:00.0-=
7/input2
[    4.471837] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is no=
t available
[    4.471838] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta u=
code is not available
[    4.471865] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000=
0037, smu fw if version =3D 0x0000003b, smu fw program =3D 0, smu fw version=
 =3D 0x004e5500 (78.85.0)
[    4.471867] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matche=
d
[    4.653694] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!=

[    4.653862] [drm] Display Core initialized with v3.2.223!
[    4.653863] [drm] DP-HDMI FRL PCON supported
[    4.655822] [drm] DMUB hardware initialized: version=3D0x07001900
[    4.768942] [drm] kiq ring mec 3 pipe 1 q 0
[    4.776318] [drm] VCN decode and encode initialized successfully(under DP=
G Mode).
[    4.776487] amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]] JPEG de=
code initialized successfully.
[    4.777761] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.777766] amdgpu: sdma_bitmap: fff0
[    4.813506] memmap_init_zone_device initialised 6291456 pages in 16ms
[    4.813510] amdgpu: HMM registered 24560MB device memory
[    4.813519] amdgpu: SRAT table not found
[    4.813519] amdgpu: Virtual CRAT table created for GPU
[    4.813783] amdgpu: Topology: Add dGPU node [0x744c:0x1002]
[    4.813784] kfd kfd: amdgpu: added device 1002:744c
[    4.813795] amdgpu 0000:03:00.0: amdgpu: SE 6, SH per SE 2, CU per SH 8, a=
ctive_cu_number 96
[    4.813845] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0=
 on hub 0
[    4.813846] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1=
 on hub 0
[    4.813846] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4=
 on hub 0
[    4.813847] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6=
 on hub 0
[    4.813847] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7=
 on hub 0
[    4.813848] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8=
 on hub 0
[    4.813848] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9=
 on hub 0
[    4.813848] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 1=
0 on hub 0
[    4.813849] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 1=
1 on hub 0
[    4.813849] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on=
 hub 0
[    4.813850] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on=
 hub 0
[    4.813850] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv e=
ng 0 on hub 1
[    4.813851] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_1 uses VM inv e=
ng 1 on hub 1
[    4.813851] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 4 o=
n hub 1
[    4.813851] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv e=
ng 14 on hub 0
[    4.814793] [drm] ring gfx_32768.1.1 was added
[    4.815299] [drm] ring compute_32768.2.2 was added
[    4.815699] [drm] ring sdma_32768.3.3 was added
[    4.815707] [drm] ring gfx_32768.1.1 test pass
[    4.815748] [drm] ring gfx_32768.1.1 ib test pass
[    4.815749] [drm] ring compute_32768.2.2 test pass
[    4.815802] [drm] ring compute_32768.2.2 ib test pass
[    4.815806] [drm] ring sdma_32768.3.3 test pass
[    4.815827] [drm] ring sdma_32768.3.3 ib test pass
[    4.816904] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    4.817104] [drm] Initialized amdgpu 3.52.0 20150101 for 0000:03:00.0 on m=
inor 1
[    4.824852] fbcon: amdgpudrmfb (fb0) is primary device
[    4.824854] fbcon: Deferring console take-over
[    4.824855] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer devi=
ce
[    4.836866] amdgpu 0000:14:00.0: enabling device (0006 -> 0007)
[    4.836919] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x=
164E 0x1043:0x8877 0xC9).
[    4.836929] [drm] register mmio base: 0xFCA00000
[    4.836930] [drm] register mmio size: 524288
[    4.837643] [drm] add ip block number 0 <nv_common>
[    4.837644] [drm] add ip block number 1 <gmc_v10_0>
[    4.837644] [drm] add ip block number 2 <navi10_ih>
[    4.837644] [drm] add ip block number 3 <psp>
[    4.837645] [drm] add ip block number 4 <smu>
[    4.837645] [drm] add ip block number 5 <dm>
[    4.837646] [drm] add ip block number 6 <gfx_v10_0>
[    4.837647] [drm] add ip block number 7 <sdma_v5_2>
[    4.837647] [drm] add ip block number 8 <vcn_v3_0>
[    4.837648] [drm] add ip block number 9 <jpeg_v3_0>
[    4.837656] amdgpu 0000:14:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.837658] amdgpu: ATOM BIOS: 102-RAPHAEL-008
[    4.853483] [drm] VCN(0) decode is enabled in VM mode
[    4.853485] [drm] VCN(0) encode is enabled in VM mode
[    4.865930] [drm] JPEG decode is enabled in VM mode
[    4.865932] amdgpu 0000:14:00.0: amdgpu: Trusted Memory Zone (TMZ) featur=
e disabled as experimental (default)
[    4.865957] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fr=
agment size is 9-bit
[    4.865960] amdgpu 0000:14:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0=
x000000F41FFFFFFF (512M used)
[    4.865961] amdgpu 0000:14:00.0: amdgpu: GART: 1024M 0x0000000000000000 -=
 0x000000003FFFFFFF
[    4.865962] amdgpu 0000:14:00.0: amdgpu: AGP: 267419648M 0x000000F8000000=
00 - 0x0000FFFFFFFFFFFF
[    4.865965] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    4.865966] [drm] RAM width 128bits DDR5
[    4.866027] [drm] amdgpu: 512M of VRAM memory ready
[    4.866028] [drm] amdgpu: 15602M of GTT memory ready.
[    4.866031] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    4.866126] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000=
).
[    4.866260] [drm] Loading DMUB firmware via PSP: version=3D0x08001B00
[    4.867041] [drm] use_doorbell being set to: [true]
[    4.867059] [drm] Found VCN firmware Version ENC: 1.27 DEC: 2 VEP: 0 Revi=
sion: 0
[    4.867062] amdgpu 0000:14:00.0: amdgpu: Will use PSP to load VCN firmwar=
e
[    4.889129] [drm] reserve 0xa00000 from 0xf41e000000 for PSP TMR
[    4.952913] amdgpu 0000:14:00.0: amdgpu: RAS: optional ras ta ucode is no=
t available
[    4.958507] amdgpu 0000:14:00.0: amdgpu: RAP: optional rap ta ucode is no=
t available
[    4.958508] amdgpu 0000:14:00.0: amdgpu: SECUREDISPLAY: securedisplay ta u=
code is not available
[    4.958574] amdgpu 0000:14:00.0: amdgpu: smu driver if version =3D 0x0000=
0004, smu fw if version =3D 0x00000005, smu fw program =3D 0, smu fw version=
 =3D 0x00544fdd (84.79.221)
[    4.958575] amdgpu 0000:14:00.0: amdgpu: SMU driver if version not matche=
d
[    4.959689] amdgpu 0000:14:00.0: amdgpu: SMU is initialized successfully!=

[    4.959836] [drm] Display Core initialized with v3.2.223!
[    4.959836] [drm] DP-HDMI FRL PCON supported
[    4.962049] [drm] DMUB hardware initialized: version=3D0x08001B00
[    4.963051] [drm] kiq ring mec 2 pipe 1 q 0
[    4.964909] [drm] VCN decode and encode initialized successfully(under DP=
G Mode).
[    4.964931] [drm] JPEG decode initialized successfully.
[    4.965897] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.965962] amdgpu: sdma_bitmap: 3
[    4.973939] memmap_init_zone_device initialised 131072 pages in 0ms
[    4.973940] amdgpu: HMM registered 512MB device memory
[    4.974000] amdgpu: SRAT table not found
[    4.974001] amdgpu: Virtual CRAT table created for GPU
[    4.974704] amdgpu: Topology: Add dGPU node [0x164e:0x1002]
[    4.974705] kfd kfd: amdgpu: added device 1002:164e
[    4.974711] amdgpu 0000:14:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 2, a=
ctive_cu_number 2
[    4.974736] amdgpu 0000:14:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0=
 on hub 0
[    4.974737] amdgpu 0000:14:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1=
 on hub 0
[    4.974738] amdgpu 0000:14:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4=
 on hub 0
[    4.974738] amdgpu 0000:14:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5=
 on hub 0
[    4.974739] amdgpu 0000:14:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6=
 on hub 0
[    4.974739] amdgpu 0000:14:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7=
 on hub 0
[    4.974739] amdgpu 0000:14:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8=
 on hub 0
[    4.974740] amdgpu 0000:14:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9=
 on hub 0
[    4.974740] amdgpu 0000:14:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 1=
0 on hub 0
[    4.974740] amdgpu 0000:14:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 1=
1 on hub 0
[    4.974741] amdgpu 0000:14:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on=
 hub 0
[    4.974741] amdgpu 0000:14:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0=
 on hub 1
[    4.974741] amdgpu 0000:14:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng=
 1 on hub 1
[    4.974742] amdgpu 0000:14:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng=
 4 on hub 1
[    4.974742] amdgpu 0000:14:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 o=
n hub 1
[    4.975018] [drm] Initialized amdgpu 3.52.0 20150101 for 0000:14:00.0 on m=
inor 0
[    4.976964] amdgpu 0000:14:00.0: [drm] Cannot find any crtc or sizes
[    4.976970] [drm] DSC precompute is not needed.
[    5.035591] BTRFS info (device nvme1n1p3): using crc32c (crc32c-intel) ch=
ecksum algorithm
[    5.035595] BTRFS info (device nvme1n1p3): using free space tree
[    5.039306] BTRFS info (device nvme1n1p3): enabling ssd optimizations
[    5.039308] BTRFS info (device nvme1n1p3): auto enabling async discard
[    5.165923] ------------[ cut here ]------------
[    5.165924] WARNING: CPU: 3 PID: 713 at drivers/gpu/drm/amd/amdgpu/../dis=
play/dc/dcn32/dcn32_resource_helpers.c:329 dcn32_determine_det_override+0x11=
f/0x350 [amdgpu]
[    5.166069] Modules linked in: amdgpu i2c_algo_bit drm_ttm_helper ttm iom=
mu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy polyval_clmulni p=
olyval_generic gpu_sched nvme ghash_clmulni_intel ccp drm_display_helper nvm=
e_core sha512_ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_t=
ables fuse
[    5.166076] CPU: 3 PID: 713 Comm: plymouthd Not tainted 6.3.11-200.fc38.x=
86_64 #1
[    5.166077] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[    5.166078] RIP: 0010:dcn32_determine_det_override+0x11f/0x350 [amdgpu]
[    5.166187] Code: 02 00 00 48 83 c4 50 5b 5d 41 5c 41 5d 41 5e 41 5f c3 c=
c cc cc cc 44 8b 44 24 24 44 8b 54 24 28 45 85 c0 74 07 45 85 d2 74 02 <0f> 0=
b 45 39 d0 0f 8c 6a 01 00 00 44 89 c0 c7 44 24 0c 01 00 00 00
[    5.166188] RSP: 0018:ffffbc8ac0b2f6b8 EFLAGS: 00010206
[    5.166189] RAX: 0000000000000002 RBX: 0000000000000002 RCX: ffff9ac7e952=
0000
[    5.166189] RDX: 000000000008d9f0 RSI: 0000000000000002 RDI: ffff9ac7c0cd=
e000
[    5.166190] RBP: ffff9ac7e9980000 R08: 000000000003661e R09: ffff9ac7e998=
0000
[    5.166190] R10: 000000000008d9f0 R11: 0000000000000002 R12: ffff9ac7c0cd=
e000
[    5.166191] R13: ffff9ac7c0cde298 R14: 0000000000000004 R15: ffff9ac7e998=
25b0
[    5.166191] FS:  00007f61cc430740(0000) GS:ffff9acf176c0000(0000) knlGS:0=
000000000000000
[    5.166192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.166192] CR2: 00007f61c99dd000 CR3: 00000001121b6000 CR4: 000000000075=
0ee0
[    5.166193] PKRU: 55555554
[    5.166193] Call Trace:
[    5.166195]  <TASK>
[    5.166195]  ? dcn32_determine_det_override+0x11f/0x350 [amdgpu]
[    5.166296]  ? __warn+0x81/0x130
[    5.166299]  ? dcn32_determine_det_override+0x11f/0x350 [amdgpu]
[    5.166399]  ? report_bug+0x171/0x1a0
[    5.166401]  ? handle_bug+0x3c/0x80
[    5.166403]  ? exc_invalid_op+0x17/0x70
[    5.166404]  ? asm_exc_invalid_op+0x1a/0x20
[    5.166406]  ? dcn32_determine_det_override+0x11f/0x350 [amdgpu]
[    5.166508]  ? dcn32_predict_pipe_split+0x187/0x230 [amdgpu]
[    5.166637]  dcn32_populate_dml_pipes_from_context+0x28e/0x320 [amdgpu]
[    5.166746]  dcn32_internal_validate_bw+0x122/0x1d70 [amdgpu]
[    5.166861]  dcn32_validate_bandwidth+0x213/0x320 [amdgpu]
[    5.166966]  dc_validate_global_state+0x307/0x3e0 [amdgpu]
[    5.167074]  amdgpu_dm_atomic_check+0xf8d/0x1190 [amdgpu]
[    5.167200]  ? idr_alloc_u32+0xa3/0xe0
[    5.167202]  drm_atomic_check_only+0x5c2/0xa40
[    5.167205]  drm_atomic_commit+0x5a/0xd0
[    5.167206]  ? __pfx___drm_printfn_info+0x10/0x10
[    5.167208]  drm_atomic_helper_set_config+0x74/0xb0
[    5.167210]  drm_mode_setcrtc+0x3c5/0x7f0
[    5.167212]  ? __pfx_drm_mode_setcrtc+0x10/0x10
[    5.167214]  drm_ioctl_kernel+0xca/0x170
[    5.167216]  drm_ioctl+0x26d/0x4b0
[    5.167217]  ? __pfx_drm_mode_setcrtc+0x10/0x10
[    5.167218]  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
[    5.167310]  __x64_sys_ioctl+0x91/0xd0
[    5.167313]  do_syscall_64+0x5d/0x90
[    5.167314]  ? amdgpu_drm_ioctl+0x71/0x90 [amdgpu]
[    5.167401]  ? __x64_sys_ioctl+0x91/0xd0
[    5.167403]  ? syscall_exit_to_user_mode+0x1b/0x40
[    5.167404]  ? do_syscall_64+0x6c/0x90
[    5.167405]  ? do_user_addr_fault+0x237/0x600
[    5.167407]  ? exc_page_fault+0x7c/0x180
[    5.167408]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    5.167410] RIP: 0033:0x7f61cc67eedd
[    5.167413] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b=
0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c=
2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[    5.167414] RSP: 002b:00007ffe124f0b90 EFLAGS: 00000246 ORIG_RAX: 0000000=
000000010
[    5.167415] RAX: ffffffffffffffda RBX: 00007f61cc4306c8 RCX: 00007f61cc67=
eedd
[    5.167416] RDX: 00007ffe124f0c20 RSI: 00000000c06864a2 RDI: 000000000000=
0009
[    5.167416] RBP: 00007ffe124f0be0 R08: 0000000000000000 R09: 000055cc454c=
d3b0
[    5.167417] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe124f=
0c20
[    5.167417] R13: 00000000c06864a2 R14: 0000000000000009 R15: 000055cc454c=
ade0
[    5.167418]  </TASK>
[    5.167419] ---[ end trace 0000000000000000 ]---
[    5.368487] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D1 '=
systemd'
[    5.428818] systemd-journald[481]: Received SIGTERM from PID 1 (systemd).=

[    5.481394] audit: type=3D1404 audit(1688674255.326:4): enforcing=3D1 old=
_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-enabled=3D=
1 lsm=3Dselinux res=3D1
[    5.502160] SELinux:  policy capability network_peer_controls=3D1
[    5.502162] SELinux:  policy capability open_perms=3D1
[    5.502162] SELinux:  policy capability extended_socket_class=3D1
[    5.502162] SELinux:  policy capability always_check_network=3D0
[    5.502163] SELinux:  policy capability cgroup_seclabel=3D1
[    5.502163] SELinux:  policy capability nnp_nosuid_transition=3D1
[    5.502163] SELinux:  policy capability genfs_seclabel_symlinks=3D1
[    5.502163] SELinux:  policy capability ioctl_skip_cloexec=3D0
[    5.525726] audit: type=3D1403 audit(1688674255.370:5): auid=3D4294967295=
 ses=3D4294967295 lsm=3Dselinux res=3D1
[    5.526024] systemd[1]: Successfully loaded SELinux policy in 44.778ms.
[    5.530034] systemd[1]: RTC configured in localtime, applying delta of 12=
0 minutes to system time.
[    5.547475] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup i=
n 16.612ms.
[    5.549547] systemd[1]: systemd 253.5-1.fc38 running in system mode (+PAM=
 +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +AC=
L +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFD=
ISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +B=
PF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[    5.549549] systemd[1]: Detected architecture x86-64.
[    5.774097] systemd[1]: bpf-lsm: LSM BPF program attached
[    5.865182] zram: Added device: zram0
[    5.865392] (sd-execu[834]: /usr/lib/systemd/system-generators/ostree-sys=
tem-generator failed with exit status 1.
[    5.949553] systemd[1]: initrd-switch-root.service: Deactivated successfu=
lly.
[    5.955658] systemd[1]: Stopped initrd-switch-root.service - Switch Root.=

[    5.956013] systemd[1]: systemd-journald.service: Scheduled restart job, r=
estart counter is at 1.
[    5.956193] systemd[1]: Created slice machine.slice - Virtual Machine and=
 Container Slice.
[    5.956417] systemd[1]: Created slice system-getty.slice - Slice /system/=
getty.
[    5.956561] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slic=
e /system/systemd-fsck.
[    5.956693] systemd[1]: Created slice system-systemd\x2dzram\x2dsetup.sli=
ce - Slice /system/systemd-zram-setup.
[    5.956797] systemd[1]: Created slice user.slice - User and Session Slice=
.
[    5.956810] systemd[1]: systemd-ask-password-console.path - Dispatch Pass=
word Requests to Console Directory Watch was skipped because of an unmet con=
dition check (ConditionPathExists=3D!/run/plymouth/pid).
[    5.956852] systemd[1]: Started systemd-ask-password-wall.path - Forward P=
assword Requests to Wall Directory Watch.
[    5.957056] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automoun=
t - Arbitrary Executable File Formats File System Automount Point.
[    5.957076] systemd[1]: Reached target cryptsetup.target - Local Encrypte=
d Volumes.
[    5.957085] systemd[1]: Reached target getty.target - Login Prompts.
[    5.957096] systemd[1]: Stopped target initrd-switch-root.target - Switch=
 Root.
[    5.957105] systemd[1]: Stopped target initrd-fs.target - Initrd File Sys=
tems.
[    5.957112] systemd[1]: Stopped target initrd-root-fs.target - Initrd Roo=
t File System.
[    5.957120] systemd[1]: Reached target integritysetup.target - Local Inte=
grity Protected Volumes.
[    5.957141] systemd[1]: Reached target slices.target - Slice Units.
[    5.957155] systemd[1]: Reached target veritysetup.target - Local Verity P=
rotected Volumes.
[    5.957597] systemd[1]: Listening on dm-event.socket - Device-mapper even=
t daemon FIFOs.
[    5.958451] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll dae=
mon socket.
[    5.959099] systemd[1]: Listening on systemd-coredump.socket - Process Co=
re Dump Socket.
[    5.959147] systemd[1]: Listening on systemd-initctl.socket - initctl Com=
patibility Named Pipe.
[    5.959368] systemd[1]: Listening on systemd-oomd.socket - Userspace Out-=
Of-Memory (OOM) Killer Socket.
[    5.959915] systemd[1]: Listening on systemd-udevd-control.socket - udev C=
ontrol Socket.
[    5.960019] systemd[1]: Listening on systemd-udevd-kernel.socket - udev K=
ernel Socket.
[    5.960286] systemd[1]: Listening on systemd-userdbd.socket - User Databa=
se Manager Socket.
[    5.972360] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File Sy=
stem...
[    5.973056] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue Fi=
le System...
[    5.973718] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug Fi=
le System...
[    5.974485] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace =
File System...
[    5.974551] systemd[1]: auth-rpcgss-module.service - Kernel Module suppor=
ting RPCSEC_GSS was skipped because of an unmet condition check (ConditionPa=
thExists=3D/etc/krb5.keytab).
[    5.974784] systemd[1]: iscsi-starter.service was skipped because of an u=
nmet condition check (ConditionDirectoryNotEmpty=3D/var/lib/iscsi/nodes).
[    5.975306] systemd[1]: Starting kmod-static-nodes.service - Create List o=
f Static Device Nodes...
[    5.976106] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM=
2 mirrors, snapshots etc. using dmeventd or progress polling...
[    5.976796] systemd[1]: Starting modprobe@configfs.service - Load Kernel M=
odule configfs...
[    5.977619] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Mo=
dule dm_mod...
[    5.978423] systemd[1]: Starting modprobe@drm.service - Load Kernel Modul=
e drm...
[    5.978955] systemd[1]: Starting modprobe@fuse.service - Load Kernel Modu=
le fuse...
[    5.979777] systemd[1]: Starting modprobe@loop.service - Load Kernel Modu=
le loop...
[    5.979806] systemd[1]: plymouth-switch-root.service: Deactivated success=
fully.
[    5.982800] loop: module loaded
[    5.995377] systemd[1]: Stopped plymouth-switch-root.service - Plymouth s=
witch root service.
[    5.995445] systemd[1]: systemd-fsck-root.service: Deactivated successful=
ly.
[    6.003345] systemd[1]: Stopped systemd-fsck-root.service - File System C=
heck on Root Device.
[    6.003380] systemd[1]: Stopped systemd-journald.service - Journal Servic=
e.
[    6.003551] systemd[1]: Listening on systemd-journald-audit.socket - Jour=
nal Audit Socket.
[    6.015383] systemd[1]: Starting systemd-journald.service - Journal Servi=
ce...
[    6.016264] systemd[1]: Starting systemd-modules-load.service - Load Kern=
el Modules...
[    6.016915] systemd[1]: Starting systemd-network-generator.service - Gene=
rate network units from Kernel command line...
[    6.016948] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID M=
easurement was skipped because of an unmet condition check (ConditionPathExi=
sts=3D/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6c7-4=
40b29bb8c4f).
[    6.017565] systemd[1]: Starting systemd-remount-fs.service - Remount Roo=
t and Kernel File Systems...
[    6.018478] systemd[1]: Starting systemd-udev-trigger.service - Coldplug A=
ll udev Devices...
[    6.019223] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File Sys=
tem.
[    6.019309] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue Fi=
le System.
[    6.019389] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug Fil=
e System.
[    6.019463] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace Fi=
le System.
[    6.020627] BTRFS info (device nvme1n1p3: state M): use zstd compression,=
 level 1
[    6.021866] systemd-journald[884]: Collecting audit messages is enabled.
[    6.022128] systemd-journald[884]: File /run/log/journal/4c681c9659a24750=
b64bbc2514f1a066/system.journal corrupted or uncleanly shut down, renaming a=
nd replacing.
[    6.040376] systemd[1]: Finished kmod-static-nodes.service - Create List o=
f Static Device Nodes.
[    6.040406] audit: type=3D1130 audit(1688667055.886:6): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dkmod-static-nodes comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.040758] systemd[1]: Started systemd-journald.service - Journal Servic=
e.
[    6.040787] audit: type=3D1130 audit(1688667055.886:7): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" ho=
stname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.052465] audit: type=3D1130 audit(1688667055.898:8): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostna=
me=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.064407] audit: type=3D1130 audit(1688667055.910:9): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.064410] audit: type=3D1131 audit(1688667055.910:10): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.076384] audit: type=3D1130 audit(1688667055.922:11): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.076386] audit: type=3D1131 audit(1688667055.922:12): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.088381] audit: type=3D1130 audit(1688667055.934:13): pid=3D1 uid=3D0 a=
uid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'=
unit=3Dmodprobe@drm comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostna=
me=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    6.157229] systemd-journald[884]: Received client request to flush runti=
me journal.
[    6.177397] systemd-journald[884]: /var/log/journal/4c681c9659a24750b64bb=
c2514f1a066/system.journal: Monotonic clock jumped backwards relative to las=
t journal entry, rotating.
[    6.177400] systemd-journald[884]: Rotating system journal.
[    6.237367] systemd-journald[884]: /var/log/journal/4c681c9659a24750b64bb=
c2514f1a066/system.journal: Realtime clock jumped backwards relative to last=
 journal entry, rotating.
[    6.237370] systemd-journald[884]: Rotating system journal.
[    6.305212] zram0: detected capacity change from 0 to 16777216
[    6.355664] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, rev=
ision 0
[    6.355667] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port s=
election
[    6.356011] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0=
xb20
[    6.356207] input: PC Speaker as /devices/platform/pcspkr/input/input13
[    6.359470] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 m=
s ovfl timer
[    6.359472] RAPL PMU: hw unit of domain package 2^-16 Joules
[    6.392553] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 a=
cross:8388604k SSDscFS
[    6.401165] Bluetooth: Core ver 2.22
[    6.401182] NET: Registered PF_BLUETOOTH protocol family
[    6.401183] Bluetooth: HCI device and connection manager initialized
[    6.401186] Bluetooth: HCI socket layer initialized
[    6.401188] Bluetooth: L2CAP socket layer initialized
[    6.401191] Bluetooth: SCO socket layer initialized
[    6.419575] cfg80211: Loading compiled-in X.509 certificates for regulato=
ry database
[    6.419939] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.448594] asus_wmi: ASUS WMI generic driver loaded
[    6.448899] Intel(R) Wireless WiFi driver for Linux
[    6.448967] iwlwifi 0000:0b:00.0: enabling device (0000 -> 0002)
[    6.449892] asus_wmi: SFUN value: 0x1
[    6.449895] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    6.449897] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[    6.449898] asus_wmi: Failed to get WMI notify code: AE_NOT_FOUND
[    6.449899] asus_wmi: Failed to get event during flush: -5
[    6.451186] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/inpu=
t/input14
[    6.460227] kvm_amd: TSC scaling supported
[    6.460228] kvm_amd: Nested Virtualization enabled
[    6.460229] kvm_amd: Nested Paging enabled
[    6.460238] kvm_amd: Virtual VMLOAD VMSAVE supported
[    6.460238] kvm_amd: Virtual GIF supported
[    6.460239] kvm_amd: LBR virtualization supported
[    6.466757] usbcore: registered new interface driver btusb
[    6.467191] mc: Linux media interface: v0.10
[    6.469733] MCE: In-kernel MCE decoding enabled.
[    6.472026] Bluetooth: hci0: Firmware timestamp 2023.13 buildtype 1 build=
 62562
[    6.485205] iwlwifi 0000:0b:00.0: api flags index 2 larger than supported=
 by driver
[    6.485215] iwlwifi 0000:0b:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.=
2.36
[    6.485358] iwlwifi 0000:0b:00.0: loaded firmware version 74.fe17486e.0 t=
y-a0-gf-a0-74.ucode op_mode iwlmvm
[    6.494618] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.s=
fi
[    6.494638] Bluetooth: hci0: Boot Address: 0x100800
[    6.494639] Bluetooth: hci0: Firmware Version: 98-13.23
[    6.494639] Bluetooth: hci0: Firmware already loaded
[    6.514419] intel_rapl_common: Found RAPL domain package
[    6.514421] intel_rapl_common: Found RAPL domain core
[    6.523154] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[    6.523217] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio clien=
t
[    6.523218] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    6.523512] snd_hda_intel 0000:14:00.1: enabling device (0000 -> 0002)
[    6.523533] snd_hda_intel 0000:14:00.1: Handle vga_switcheroo audio clien=
t
[    6.530295] snd_hda_intel 0000:14:00.1: bound 0000:14:00.0 (ops amdgpu_dm=
_audio_component_bind_ops [amdgpu])
[    6.531137] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm=
_audio_component_bind_ops [amdgpu])
[    6.531431] snd_hda_codec_hdmi hdaudioC1D0: HDMI: Unknown ELD version 0
[    6.531709] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:0=
0/0000:00:08.1/0000:14:00.1/sound/card2/input15
[    6.531740] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:0=
0/0000:00:08.1/0000:14:00.1/sound/card2/input16
[    6.531823] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/00=
00:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input17
[    6.531838] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/00=
00:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input18
[    6.531856] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/00=
00:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input19
[    6.531869] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/00=
00:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input20
[    6.606041] iwlwifi 0000:0b:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz,=
 REV=3D0x420
[    6.606066] thermal thermal_zone0: failed to read out thermal zone (-61)
[    6.612451] iwlwifi 0000:0b:00.0: WRT: Invalid buffer destination
[    6.756594] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[    6.756615] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    6.756628] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x90
[    6.756639] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    6.758117] iwlwifi 0000:0b:00.0: loaded PNVM version e4a49534
[    6.769156] iwlwifi 0000:0b:00.0: Detected RF GF, rfid=3D0x10d000
[    6.838290] iwlwifi 0000:0b:00.0: base HW address: bc:09:1b:cb:f3:4f
[    6.855920] iwlwifi 0000:0b:00.0 wlp11s0: renamed from wlan0
[    7.032477] EXT4-fs (nvme1n1p2): mounted filesystem d254cc04-fabb-4b88-a4=
e4-0151eb15ca8d with ordered data mode. Quota mode: none.
[    7.344384] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.344386] Bluetooth: BNEP filters: protocol multicast
[    7.344388] Bluetooth: BNEP socket layer initialized
[    7.344799] Bluetooth: MGMT ver 1.22
[    7.527772] NET: Registered PF_QIPCRTR protocol family
[    7.790973] iwlwifi 0000:0b:00.0: WRT: Invalid buffer destination
[    7.935270] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[    7.935283] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    7.935297] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x90
[    7.935315] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    8.056665] iwlwifi 0000:0b:00.0: WRT: Invalid buffer destination
[    8.079101] RPC: Registered named UNIX socket transport module.
[    8.079103] RPC: Registered udp transport module.
[    8.079103] RPC: Registered tcp transport module.
[    8.079104] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.200526] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[    8.200539] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    8.200551] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x90
[    8.200564] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    9.228844] Lockdown: systemd-logind: hibernation is restricted; see man k=
ernel_lockdown.7
[    9.288088] rfkill: input handler disabled
[    9.836901] Bluetooth: RFCOMM TTY layer initialized
[    9.836906] Bluetooth: RFCOMM socket layer initialized
[    9.836908] Bluetooth: RFCOMM ver 1.11
[   11.947816] wlp11s0: authenticate with 9c:31:c3:d0:d9:15
[   11.951524] wlp11s0: send auth to 9c:31:c3:d0:d9:15 (try 1/3)
[   12.011599] wlp11s0: authenticated
[   12.012305] wlp11s0: associate with 9c:31:c3:d0:d9:15 (try 1/3)
[   12.013501] wlp11s0: RX AssocResp from 9c:31:c3:d0:d9:15 (capab=3D0x11 st=
atus=3D0 aid=3D5)
[   12.019846] wlp11s0: associated
[   12.088655] IPv6: ADDRCONF(NETDEV_CHANGE): wlp11s0: link becomes ready
[   12.940218] usbcore: registered new interface driver snd-usb-audio
[   14.198268] systemd-journald[884]: /var/log/journal/4c681c9659a24750b64bb=
c2514f1a066/user-1000.journal: Monotonic clock jumped backwards relative to l=
ast journal entry, rotating.
[   14.464699] rfkill: input handler enabled
[   15.254592] Lockdown: systemd-logind: hibernation is restricted; see man k=
ernel_lockdown.7
[   15.431382] rfkill: input handler disabled
[   34.289162] warning: `ThreadPoolForeg' uses wireless extensions which wil=
l stop working for Wi-Fi 7 hardware; use nl80211
[  215.706714] Lockdown: systemd-logind: hibernation is restricted; see man k=
ernel_lockdown.7
[  216.761467] wlp11s0: deauthenticating from 9c:31:c3:d0:d9:15 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[  217.770708] iwlwifi 0000:0b:00.0: WRT: Invalid buffer destination
[  217.915147] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[  217.915163] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  217.915175] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x90
[  217.915188] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  221.661331] wlp11s0: authenticate with 9c:31:c3:d0:d9:15
[  221.664325] wlp11s0: send auth to 9c:31:c3:d0:d9:15 (try 1/3)
[  221.719955] wlp11s0: authenticated
[  221.720221] wlp11s0: associate with 9c:31:c3:d0:d9:15 (try 1/3)
[  221.721383] wlp11s0: RX AssocResp from 9c:31:c3:d0:d9:15 (capab=3D0x11 st=
atus=3D0 aid=3D5)
[  221.726830] wlp11s0: associated
[  221.779614] IPv6: ADDRCONF(NETDEV_CHANGE): wlp11s0: link becomes ready
[  345.616156] Lockdown: systemd-logind: hibernation is restricted; see man k=
ernel_lockdown.7
[  378.615111] show_signal_msg: 48 callbacks suppressed
[  378.615113] Composite Threa[4786]: segfault at 0 ip 0000000000000000 sp 0=
0007f94504b66b8 error 14 in steamwebhelper[400000+10000] likely on CPU 30 (c=
ore 14, socket 0)
[  378.615120] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  382.370802] Composite Threa[5161]: segfault at 0 ip 0000000000000000 sp 0=
0007f8cd4c8c6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  382.370812] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  392.533811] Composite Threa[5864]: segfault at 0 ip 0000000000000000 sp 0=
0007f45cdccb6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  392.533819] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  402.760329] Composite Threa[6695]: segfault at 0 ip 0000000000000000 sp 0=
0007ff2952dc6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 25 (c=
ore 9, socket 0)
[  402.760339] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  412.093116] Composite Threa[7469]: segfault at 0 ip 0000000000000000 sp 0=
0007f230e3976b8 error 14 in steamwebhelper[400000+10000] likely on CPU 11 (c=
ore 11, socket 0)
[  412.093126] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  423.116427] Composite Threa[8952]: segfault at 0 ip 0000000000000000 sp 0=
0007fa2a05356b8 error 14 in steamwebhelper[400000+10000] likely on CPU 29 (c=
ore 13, socket 0)
[  423.116435] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  432.584222] Composite Threa[10607]: segfault at 0 ip 0000000000000000 sp 0=
0007f9327e786b8 error 14 in steamwebhelper[400000+10000] likely on CPU 22 (c=
ore 6, socket 0)
[  432.584235] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  442.749758] Composite Threa[12459]: segfault at 0 ip 0000000000000000 sp 0=
0007f90e55736b8 error 14 in steamwebhelper[400000+10000] likely on CPU 0 (co=
re 0, socket 0)
[  442.749767] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  453.605207] Composite Threa[14314]: segfault at 0 ip 0000000000000000 sp 0=
0007f4d2529d6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 18 (c=
ore 2, socket 0)
[  453.605215] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  463.054626] Composite Threa[16357]: segfault at 0 ip 0000000000000000 sp 0=
0007fe5031156b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  463.054633] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  473.352935] Composite Threa[18630]: segfault at 0 ip 0000000000000000 sp 0=
0007fa68b8566b8 error 14 in steamwebhelper[400000+10000] likely on CPU 1 (co=
re 1, socket 0)
[  473.352941] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  483.523102] Composite Threa[21066]: segfault at 0 ip 0000000000000000 sp 0=
0007f167252e6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  483.523111] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  493.826815] Composite Threa[23669]: segfault at 0 ip 0000000000000000 sp 0=
0007f37f48396b8 error 14 in steamwebhelper[400000+10000] likely on CPU 9 (co=
re 9, socket 0)
[  493.826824] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  504.030537] Composite Threa[26411]: segfault at 0 ip 0000000000000000 sp 0=
0007f3c1059d6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 12 (c=
ore 12, socket 0)
[  504.030544] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  514.184238] Composite Threa[29132]: segfault at 0 ip 0000000000000000 sp 0=
0007f33d5a7b6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  514.184248] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  524.600294] Composite Threa[31852]: segfault at 0 ip 0000000000000000 sp 0=
0007f100550c6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  524.600304] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  534.464604] Composite Threa[34538]: segfault at 0 ip 0000000000000000 sp 0=
0007ff6c3baf6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 24 (c=
ore 8, socket 0)
[  534.464613] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  544.635793] Composite Threa[37252]: segfault at 0 ip 0000000000000000 sp 0=
0007f67dfe416b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  544.635803] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  554.963111] Composite Threa[39957]: segfault at 0 ip 0000000000000000 sp 0=
0007f3441c526b8 error 14 in steamwebhelper[400000+10000] likely on CPU 11 (c=
ore 11, socket 0)
[  554.963121] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  565.096578] Composite Threa[42665]: segfault at 0 ip 0000000000000000 sp 0=
0007fe1f8aca6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 13 (c=
ore 13, socket 0)
[  565.096588] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  575.295958] Composite Threa[45348]: segfault at 0 ip 0000000000000000 sp 0=
0007f15d2e0e6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  575.295967] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  585.494385] Composite Threa[48067]: segfault at 0 ip 0000000000000000 sp 0=
0007f2bf5ff86b8 error 14 in steamwebhelper[400000+10000] likely on CPU 10 (c=
ore 10, socket 0)
[  585.494394] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  595.704040] Composite Threa[50749]: segfault at 0 ip 0000000000000000 sp 0=
0007f21a2e5b6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 25 (c=
ore 9, socket 0)
[  595.704050] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  605.946269] Composite Threa[53445]: segfault at 0 ip 0000000000000000 sp 0=
0007fc8014956b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  605.946279] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  615.989827] Composite Threa[56145]: segfault at 0 ip 0000000000000000 sp 0=
0007f592f6b06b8 error 14 in steamwebhelper[400000+10000] likely on CPU 24 (c=
ore 8, socket 0)
[  615.989837] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  626.424946] Composite Threa[58838]: segfault at 0 ip 0000000000000000 sp 0=
0007f099cd846b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  626.424956] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  636.550993] Composite Threa[61563]: segfault at 0 ip 0000000000000000 sp 0=
0007f71af7706b8 error 14 in steamwebhelper[400000+10000] likely on CPU 23 (c=
ore 7, socket 0)
[  636.551001] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  646.761707] Composite Threa[64251]: segfault at 0 ip 0000000000000000 sp 0=
0007f1d44f586b8 error 14 in steamwebhelper[400000+10000] likely on CPU 27 (c=
ore 11, socket 0)
[  646.761715] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  656.760813] Composite Threa[66937]: segfault at 0 ip 0000000000000000 sp 0=
0007f1a1fe556b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (co=
re 8, socket 0)
[  656.760820] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  666.946101] Composite Threa[69627]: segfault at 0 ip 0000000000000000 sp 0=
0007fd66ff6f6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 30 (c=
ore 14, socket 0)
[  666.946109] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  677.173898] Composite Threa[72293]: segfault at 0 ip 0000000000000000 sp 0=
0007fcececf46b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  677.173904] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  687.430271] Composite Threa[74958]: segfault at 0 ip 0000000000000000 sp 0=
0007f5d345756b8 error 14 in steamwebhelper[400000+10000] likely on CPU 15 (c=
ore 15, socket 0)
[  687.430278] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  697.701136] Composite Threa[77636]: segfault at 0 ip 0000000000000000 sp 0=
0007fb3972716b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  697.701149] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  707.715973] Composite Threa[80305]: segfault at 0 ip 0000000000000000 sp 0=
0007f2ec9a576b8 error 14 in steamwebhelper[400000+10000] likely on CPU 15 (c=
ore 15, socket 0)
[  707.715983] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  718.018282] Composite Threa[82986]: segfault at 0 ip 0000000000000000 sp 0=
0007fc7d00476b8 error 14 in steamwebhelper[400000+10000] likely on CPU 16 (c=
ore 0, socket 0)
[  718.018287] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  728.065672] Composite Threa[85659]: segfault at 0 ip 0000000000000000 sp 0=
0007f619ace36b8 error 14 in steamwebhelper[400000+10000] likely on CPU 7 (co=
re 7, socket 0)
[  728.065678] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  738.217776] Composite Threa[88330]: segfault at 0 ip 0000000000000000 sp 0=
0007f53f271e6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  738.217783] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  748.448001] Composite Threa[91023]: segfault at 0 ip 0000000000000000 sp 0=
0007f3c767ec6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 24 (c=
ore 8, socket 0)
[  748.448011] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  758.637260] Composite Threa[93697]: segfault at 0 ip 0000000000000000 sp 0=
0007fa07dc5b6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 19 (c=
ore 3, socket 0)
[  758.637267] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  768.827945] Composite Threa[96377]: segfault at 0 ip 0000000000000000 sp 0=
0007f7ee233c6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 26 (c=
ore 10, socket 0)
[  768.827953] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  779.169139] Composite Threa[99046]: segfault at 0 ip 0000000000000000 sp 0=
0007fb8178ef6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (c=
ore 15, socket 0)
[  779.169146] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  789.244182] Composite Threa[101712]: segfault at 0 ip 0000000000000000 sp=
 00007fc1121cc6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (=
core 15, socket 0)
[  789.244190] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  799.525537] Composite Threa[104367]: segfault at 0 ip 0000000000000000 sp=
 00007f9f3d4a76b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (=
core 8, socket 0)
[  799.525544] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  809.427591] Composite Threa[107057]: segfault at 0 ip 0000000000000000 sp=
 00007fc5662216b8 error 14 in steamwebhelper[400000+10000] likely on CPU 30 (=
core 14, socket 0)
[  809.427601] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  819.728923] Composite Threa[110001]: segfault at 0 ip 0000000000000000 sp=
 00007f9eaa6996b8 error 14 in steamwebhelper[400000+10000] likely on CPU 31 (=
core 15, socket 0)
[  819.728938] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  830.020678] Composite Threa[112666]: segfault at 0 ip 0000000000000000 sp=
 00007f49d8b766b8 error 14 in steamwebhelper[400000+10000] likely on CPU 1 (=
core 1, socket 0)
[  830.020687] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  840.254209] Composite Threa[115340]: segfault at 0 ip 0000000000000000 sp=
 00007f0c70ccd6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 10 (=
core 10, socket 0)
[  840.254216] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  855.249132] Composite Threa[116009]: segfault at 0 ip 0000000000000000 sp=
 00007f7d3f0b66b8 error 14 in steamwebhelper[400000+10000] likely on CPU 14 (=
core 14, socket 0)
[  855.249138] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  863.972104] Composite Threa[116604]: segfault at 0 ip 0000000000000000 sp=
 00007ff7de5fa6b8 error 14 in steamwebhelper[400000+10000] likely on CPU 8 (=
core 8, socket 0)
[  863.972111] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  874.083812] Composite Threa[117406]: segfault at 0 ip 0000000000000000 sp=
 00007fd592b616b8 error 14 in steamwebhelper[400000+10000] likely on CPU 9 (=
core 9, socket 0)
[  874.083818] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 1195.781386] EXT4-fs (nvme0n1p1): mounted filesystem bd435986-0277-4695-8d=
62-83fdfb0fb858 with ordered data mode. Quota mode: none.
[ 1195.786481] EXT4-fs (nvme0n1p1): unmounting filesystem bd435986-0277-4695=
-8d62-83fdfb0fb858.
[ 1221.122937] EXT4-fs (nvme0n1p1): mounted filesystem bd435986-0277-4695-8d=
62-83fdfb0fb858 with ordered data mode. Quota mode: none.
[ 1412.135507] iwlwifi 0000:0b:00.0: Error sending STATISTICS_CMD: time out a=
fter 2000ms.
[ 1412.135511] iwlwifi 0000:0b:00.0: Current CMD queue read_ptr 1564 write_p=
tr 1565
[ 1412.153468] ------------[ cut here ]------------
[ 1412.153470] Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)=

[ 1412.153491] WARNING: CPU: 17 PID: 1350 at drivers/net/wireless/intel/iwlw=
ifi/pcie/trans.c:2170 __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]=

[ 1412.153514] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1412.153562]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1412.153568] CPU: 17 PID: 1350 Comm: NetworkManager Tainted: G        W   =
       6.3.11-200.fc38.x86_64 #1
[ 1412.153570] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1412.153571] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwi=
fi]
[ 1412.153582] Code: 00 00 00 48 89 df e8 b5 99 fe ff 4c 89 f7 e8 ed 5a 80 c=
a eb 8c 89 c6 48 c7 c7 e0 1c 7e c4 c6 05 33 53 04 00 01 e8 46 cf 95 c9 <0f> 0=
b eb a9 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 1412.153583] RSP: 0018:ffffbc8ad5c6b4c8 EFLAGS: 00010286
[ 1412.153585] RAX: 0000000000000000 RBX: ffff9ac7c9eb0028 RCX: 000000000000=
0027
[ 1412.153586] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1412.153586] RBP: 00000000ffffffff R08: 0000000000000000 R09: ffffbc8ad5c6=
b358
[ 1412.153587] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000000=
0001
[ 1412.153588] R13: 0000000000000000 R14: ffff9ac7c9eb2984 R15: 000000000000=
0011
[ 1412.153589] FS:  00007f7db6ddf500(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1412.153590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1412.153590] CR2: 0000556612f51560 CR3: 0000000121634000 CR4: 000000000075=
0ee0
[ 1412.153591] PKRU: 55555554
[ 1412.153592] Call Trace:
[ 1412.153593]  <TASK>
[ 1412.153594]  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
[ 1412.153604]  ? __warn+0x81/0x130
[ 1412.153608]  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
[ 1412.153619]  ? report_bug+0x171/0x1a0
[ 1412.153621]  ? prb_read_valid+0x1b/0x30
[ 1412.153623]  ? handle_bug+0x3c/0x80
[ 1412.153626]  ? exc_invalid_op+0x17/0x70
[ 1412.153627]  ? asm_exc_invalid_op+0x1a/0x20
[ 1412.153631]  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
[ 1412.153640]  ? __iwl_trans_pcie_grab_nic_access+0x14a/0x150 [iwlwifi]
[ 1412.153650]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[ 1412.153659]  iwl_force_nmi+0xdf/0x110 [iwlwifi]
[ 1412.153669]  iwl_trans_sync_nmi_with_addr+0x14b/0x170 [iwlwifi]
[ 1412.153680]  iwl_trans_txq_send_hcmd+0x401/0x450 [iwlwifi]
[ 1412.153693]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1412.153695]  iwl_trans_send_cmd+0x98/0x100 [iwlwifi]
[ 1412.153706]  iwl_mvm_send_cmd+0x1f/0x60 [iwlmvm]
[ 1412.153719]  iwl_mvm_request_statistics+0x124/0x1b0 [iwlmvm]
[ 1412.153731]  ? __pfx_iwl_wait_stats_complete+0x10/0x10 [iwlmvm]
[ 1412.153741]  iwl_mvm_mac_sta_statistics+0x185/0x3a0 [iwlmvm]
[ 1412.153752]  sta_set_sinfo+0xc0/0xbb0 [mac80211]
[ 1412.153781]  ieee80211_dump_station+0x6f/0x90 [mac80211]
[ 1412.153810]  nl80211_dump_station+0x13f/0x290 [cfg80211]
[ 1412.153839]  ? __alloc_skb+0x8c/0x1a0
[ 1412.153844]  netlink_dump+0x126/0x320
[ 1412.153847]  __netlink_dump_start+0x1b4/0x270
[ 1412.153849]  genl_family_rcv_msg_dumpit+0x104/0x110
[ 1412.153851]  ? __pfx_genl_start+0x10/0x10
[ 1412.153853]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[ 1412.153874]  ? __pfx_genl_parallel_done+0x10/0x10
[ 1412.153876]  genl_rcv_msg+0x146/0x2c0
[ 1412.153878]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[ 1412.153899]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 1412.153901]  netlink_rcv_skb+0x58/0x110
[ 1412.153903]  genl_rcv+0x28/0x40
[ 1412.153905]  netlink_unicast+0x19e/0x290
[ 1412.153907]  netlink_sendmsg+0x254/0x4d0
[ 1412.153909]  sock_sendmsg+0x93/0xa0
[ 1412.153912]  ____sys_sendmsg+0x270/0x300
[ 1412.153914]  ? copy_msghdr_from_user+0x7d/0xc0
[ 1412.153916]  ___sys_sendmsg+0x9a/0xe0
[ 1412.153919]  __sys_sendmsg+0x7a/0xd0
[ 1412.153921]  do_syscall_64+0x5d/0x90
[ 1412.153923]  ? exit_to_user_mode_prepare+0x142/0x1f0
[ 1412.153926]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 1412.153928]  ? do_syscall_64+0x6c/0x90
[ 1412.153929]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 1412.153931]  ? do_syscall_64+0x6c/0x90
[ 1412.153932]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1412.153934] RIP: 0033:0x7f7db7dfa8eb
[ 1412.153950] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 a=
9 41 f7 ff 8b 55 ec 48 8b 75 f0 41 89 c0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3=
d 00 f0 ff ff 77 2d 44 89 c7 48 89 45 f8 e8 01 42 f7 ff 48 8b
[ 1412.153951] RSP: 002b:00007fff271d4a70 EFLAGS: 00000293 ORIG_RAX: 0000000=
00000002e
[ 1412.153952] RAX: ffffffffffffffda RBX: 0000565071eeeea0 RCX: 00007f7db7df=
a8eb
[ 1412.153953] RDX: 0000000000000000 RSI: 00007fff271d4ab0 RDI: 000000000000=
000b
[ 1412.153953] RBP: 00007fff271d4a90 R08: 0000000000000000 R09: 000000000000=
0001
[ 1412.153954] R10: 0000000000000003 R11: 0000000000000293 R12: 00007f7d9800=
3220
[ 1412.153955] R13: 00007fff271d4b40 R14: 0000565071eeeea0 R15: 00007fff271d=
4d94
[ 1412.153956]  </TASK>
[ 1412.153957] ---[ end trace 0000000000000000 ]---
[ 1412.153958] iwlwifi 0000:0b:00.0: iwlwifi transaction failed, dumping reg=
isters
[ 1412.153960] iwlwifi 0000:0b:00.0: iwlwifi device config registers:
[ 1412.154133] iwlwifi 0000:0b:00.0: 00000000: 27258086 00100000 0280001a 00=
000000 00000004 00000000 00000000 00000000
[ 1412.154135] iwlwifi 0000:0b:00.0: 00000020: 00000000 00000000 00000000 00=
248086 00000000 000000c8 00000000 00000100
[ 1412.154137] iwlwifi 0000:0b:00.0: 00000040: 00028010 10008ec0 001b0c10 00=
45e812 10120000 00000000 00000000 00000000
[ 1412.154138] iwlwifi 0000:0b:00.0: 00000060: 00000000 00080812 00000005 00=
000006 00000002 00000000 00000000 00000000
[ 1412.154139] iwlwifi 0000:0b:00.0: 00000080: 000f0011 00002000 00003000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154140] iwlwifi 0000:0b:00.0: 000000a0: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154140] iwlwifi 0000:0b:00.0: 000000c0: 00000000 00000000 c823d001 0d=
000008 00804005 00000000 00000000 00000000
[ 1412.154141] iwlwifi 0000:0b:00.0: 000000e0: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154142] iwlwifi 0000:0b:00.0: 00000100: 14c10001 00100000 00000000 00=
462031 00003100 00000000 00000014 40001001
[ 1412.154143] iwlwifi 0000:0b:00.0: 00000120: 0000000f fc400460 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154144] iwlwifi 0000:0b:00.0: 00000140: 14c00000 ff000000 000000ff 15=
410018 00000000 0001001e 00481e1f 00000000
[ 1412.154145] iwlwifi 0000:0b:00.0: iwlwifi device memory mapped registers:=

[ 1412.154173] iwlwifi 0000:0b:00.0: 00000000: ffffffff ffffffff ffffffff ff=
ffffff ffffffff ffffffff ffffffff ffffffff
[ 1412.154174] iwlwifi 0000:0b:00.0: 00000020: ffffffff ffffffff ffffffff ff=
ffffff ffffffff ffffffff ffffffff ffffffff
[ 1412.154176] iwlwifi 0000:0b:00.0: iwlwifi device AER capability structure=
:
[ 1412.154197] iwlwifi 0000:0b:00.0: 00000000: 14c10001 00100000 00000000 00=
462031 00003100 00000000 00000014 40001001
[ 1412.154198] iwlwifi 0000:0b:00.0: 00000020: 0000000f fc400460 00000000
[ 1412.154199] iwlwifi 0000:0b:00.0: iwlwifi parent port (0000:09:04.0) conf=
ig registers:
[ 1412.154327] iwlwifi 0000:09:04.0: 00000000: 43f51022 00100407 06040001 00=
010010 00000000 00000000 000b0b09 800001f1
[ 1412.154328] iwlwifi 0000:09:04.0: 00000020: fc40fc40 0001fff1 00000000 00=
000000 00000000 00000050 00000000 001201ff
[ 1412.154329] iwlwifi 0000:09:04.0: 00000040: 00000000 00000000 00000000 00=
000000 00817005 fee00000 00000000 00000000
[ 1412.154330] iwlwifi 0000:09:04.0: 00000060: 00000000 00000000 00000000 00=
000000 c8238001 00000000 00000000 00000000
[ 1412.154331] iwlwifi 0000:09:04.0: 00000080: 0162c010 00008022 0005291f 00=
7ae813 70120042 00000d00 01480000 00000000
[ 1412.154332] iwlwifi 0000:09:04.0: 000000a0: 00000000 00010800 00000000 01=
870e0e 00000004 00000000 00000000 00000000
[ 1412.154332] iwlwifi 0000:09:04.0: 000000c0: 0000000d 33281b21 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154333] iwlwifi 0000:09:04.0: 000000e0: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154334] iwlwifi 0000:09:04.0: 00000100: 1c010001 00000000 00400000 00=
462030 00000040 0000e000 00000000 00000000
[ 1412.154335] iwlwifi 0000:09:04.0: 00000120: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154336] iwlwifi 0000:09:04.0: 00000140: 00000000 00000000 00000000 00=
000000 1801000d 0000005f 00000000 00000000
[ 1412.154337] iwlwifi 0000:09:04.0: 00000160: 1c010018 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154338] iwlwifi 0000:09:04.0: 00000180: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154339] iwlwifi 0000:09:04.0: 000001a0: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154340] iwlwifi 0000:09:04.0: 000001c0: 20010019 00000000 00000000 73=
787378 73787378 00000000 00000000 00000000
[ 1412.154340] iwlwifi 0000:09:04.0: 000001e0: 00000000 00000000 00000000 00=
000000 00000000 00000000 00000000 00000000
[ 1412.154341] iwlwifi 0000:09:04.0: 00000200: 2201001e 0079801f 41168000
[ 1412.172278] ------------[ cut here ]------------
[ 1412.172279] WARNING: CPU: 17 PID: 1350 at drivers/net/wireless/intel/iwlw=
ifi/iwl-trans.h:1422 iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1412.172297] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1412.172321]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1412.172326] CPU: 17 PID: 1350 Comm: NetworkManager Tainted: G        W   =
       6.3.11-200.fc38.x86_64 #1
[ 1412.172327] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1412.172328] RIP: 0010:iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1412.172338] Code: 7d 40 e8 e8 d8 fd ff 48 8b 03 48 8b 7d 40 31 f6 44 8b 4=
4 24 08 48 c7 c2 28 3d 7e c4 48 8b 48 38 e8 ca d8 fd ff e9 6a fc ff ff <0f> 0=
b 48 8b 7d 40 48 c7 c2 00 3d 7e c4 31 f6 e8 b1 d8 fd ff 48 8b
[ 1412.172339] RSP: 0018:ffffbc8ad5c6b410 EFLAGS: 00010286
[ 1412.172340] RAX: 00000000fffffff0 RBX: ffff9ac7e754af58 RCX: 000000000000=
0000
[ 1412.172341] RDX: 0000000000000000 RSI: fffffff6a5f6c1e7 RDI: 000000000000=
0002
[ 1412.172342] RBP: ffff9ac7c9eb0028 R08: 0000000000000002 R09: 000000001e79=
f215
[ 1412.172343] R10: ffffffff90006110 R11: ffffbc8ac0620ff8 R12: 00000000004f=
1f08
[ 1412.172343] R13: 0000000000000000 R14: ffffbc8ad5c6b418 R15: 000000000000=
0000
[ 1412.172344] FS:  00007f7db6ddf500(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1412.172345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1412.172346] CR2: 0000556612f51560 CR3: 0000000121634000 CR4: 000000000075=
0ee0
[ 1412.172347] PKRU: 55555554
[ 1412.172347] Call Trace:
[ 1412.172348]  <TASK>
[ 1412.172349]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1412.172359]  ? __warn+0x81/0x130
[ 1412.172361]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1412.172371]  ? report_bug+0x171/0x1a0
[ 1412.172373]  ? handle_bug+0x3c/0x80
[ 1412.172375]  ? exc_invalid_op+0x17/0x70
[ 1412.172376]  ? asm_exc_invalid_op+0x1a/0x20
[ 1412.172379]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1412.172390]  iwl_fwrt_dump_error_logs+0x28/0x1f0 [iwlwifi]
[ 1412.172400]  iwl_mvm_nic_error+0x61/0xe0 [iwlmvm]
[ 1412.172412]  iwl_trans_sync_nmi_with_addr+0x79/0x170 [iwlwifi]
[ 1412.172423]  iwl_trans_txq_send_hcmd+0x401/0x450 [iwlwifi]
[ 1412.172434]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1412.172436]  iwl_trans_send_cmd+0x98/0x100 [iwlwifi]
[ 1412.172447]  iwl_mvm_send_cmd+0x1f/0x60 [iwlmvm]
[ 1412.172459]  iwl_mvm_request_statistics+0x124/0x1b0 [iwlmvm]
[ 1412.172470]  ? __pfx_iwl_wait_stats_complete+0x10/0x10 [iwlmvm]
[ 1412.172480]  iwl_mvm_mac_sta_statistics+0x185/0x3a0 [iwlmvm]
[ 1412.172497]  sta_set_sinfo+0xc0/0xbb0 [mac80211]
[ 1412.172541]  ieee80211_dump_station+0x6f/0x90 [mac80211]
[ 1412.172587]  nl80211_dump_station+0x13f/0x290 [cfg80211]
[ 1412.172630]  ? __alloc_skb+0x8c/0x1a0
[ 1412.172636]  netlink_dump+0x126/0x320
[ 1412.172639]  __netlink_dump_start+0x1b4/0x270
[ 1412.172642]  genl_family_rcv_msg_dumpit+0x104/0x110
[ 1412.172645]  ? __pfx_genl_start+0x10/0x10
[ 1412.172647]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[ 1412.172684]  ? __pfx_genl_parallel_done+0x10/0x10
[ 1412.172687]  genl_rcv_msg+0x146/0x2c0
[ 1412.172690]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[ 1412.172727]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 1412.172730]  netlink_rcv_skb+0x58/0x110
[ 1412.172733]  genl_rcv+0x28/0x40
[ 1412.172736]  netlink_unicast+0x19e/0x290
[ 1412.172738]  netlink_sendmsg+0x254/0x4d0
[ 1412.172741]  sock_sendmsg+0x93/0xa0
[ 1412.172744]  ____sys_sendmsg+0x270/0x300
[ 1412.172747]  ? copy_msghdr_from_user+0x7d/0xc0
[ 1412.172750]  ___sys_sendmsg+0x9a/0xe0
[ 1412.172755]  __sys_sendmsg+0x7a/0xd0
[ 1412.172758]  do_syscall_64+0x5d/0x90
[ 1412.172760]  ? exit_to_user_mode_prepare+0x142/0x1f0
[ 1412.172763]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 1412.172766]  ? do_syscall_64+0x6c/0x90
[ 1412.172768]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 1412.172770]  ? do_syscall_64+0x6c/0x90
[ 1412.172772]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1412.172775] RIP: 0033:0x7f7db7dfa8eb
[ 1412.172782] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 a=
9 41 f7 ff 8b 55 ec 48 8b 75 f0 41 89 c0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3=
d 00 f0 ff ff 77 2d 44 89 c7 48 89 45 f8 e8 01 42 f7 ff 48 8b
[ 1412.172783] RSP: 002b:00007fff271d4a70 EFLAGS: 00000293 ORIG_RAX: 0000000=
00000002e
[ 1412.172785] RAX: ffffffffffffffda RBX: 0000565071eeeea0 RCX: 00007f7db7df=
a8eb
[ 1412.172787] RDX: 0000000000000000 RSI: 00007fff271d4ab0 RDI: 000000000000=
000b
[ 1412.172788] RBP: 00007fff271d4a90 R08: 0000000000000000 R09: 000000000000=
0001
[ 1412.172789] R10: 0000000000000003 R11: 0000000000000293 R12: 00007f7d9800=
3220
[ 1412.172790] R13: 00007fff271d4b40 R14: 0000565071eeeea0 R15: 00007fff271d=
4d94
[ 1412.172792]  </TASK>
[ 1412.172793] ---[ end trace 0000000000000000 ]---
[ 1412.172795] iwlwifi 0000:0b:00.0: HW error, resetting before reading
[ 1412.196774] iwlwifi 0000:0b:00.0: Loaded firmware version: 74.fe17486e.0 t=
y-a0-gf-a0-74.ucode
[ 1412.196777] iwlwifi 0000:0b:00.0: 0x00000000 | ADVANCED_SYSASSERT        =
 =20
[ 1412.196779] iwlwifi 0000:0b:00.0: 0x00000000 | trm_hw_status0
[ 1412.196780] iwlwifi 0000:0b:00.0: 0x00000000 | trm_hw_status1
[ 1412.196781] iwlwifi 0000:0b:00.0: 0x00000000 | branchlink2
[ 1412.196781] iwlwifi 0000:0b:00.0: 0x00000000 | interruptlink1
[ 1412.196782] iwlwifi 0000:0b:00.0: 0x00000000 | interruptlink2
[ 1412.196782] iwlwifi 0000:0b:00.0: 0x00000000 | data1
[ 1412.196783] iwlwifi 0000:0b:00.0: 0x00000000 | data2
[ 1412.196783] iwlwifi 0000:0b:00.0: 0x00000000 | data3
[ 1412.196784] iwlwifi 0000:0b:00.0: 0x00000000 | beacon time
[ 1412.196785] iwlwifi 0000:0b:00.0: 0x00000000 | tsf low
[ 1412.196785] iwlwifi 0000:0b:00.0: 0x00000000 | tsf hi
[ 1412.196786] iwlwifi 0000:0b:00.0: 0x00000000 | time gp1
[ 1412.196786] iwlwifi 0000:0b:00.0: 0x00000000 | time gp2
[ 1412.196787] iwlwifi 0000:0b:00.0: 0x00000000 | uCode revision type
[ 1412.196787] iwlwifi 0000:0b:00.0: 0x00000000 | uCode version major
[ 1412.196788] iwlwifi 0000:0b:00.0: 0x00000000 | uCode version minor
[ 1412.196788] iwlwifi 0000:0b:00.0: 0x00000000 | hw version
[ 1412.196789] iwlwifi 0000:0b:00.0: 0x00000000 | board version
[ 1412.196790] iwlwifi 0000:0b:00.0: 0x00000000 | hcmd
[ 1412.196790] iwlwifi 0000:0b:00.0: 0x00000000 | isr0
[ 1412.196791] iwlwifi 0000:0b:00.0: 0x00000000 | isr1
[ 1412.196791] iwlwifi 0000:0b:00.0: 0x00000000 | isr2
[ 1412.196792] iwlwifi 0000:0b:00.0: 0x00000000 | isr3
[ 1412.196792] iwlwifi 0000:0b:00.0: 0x00000000 | isr4
[ 1412.196793] iwlwifi 0000:0b:00.0: 0x00000000 | last cmd Id
[ 1412.196793] iwlwifi 0000:0b:00.0: 0x00000000 | wait_event
[ 1412.196794] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_control
[ 1412.196794] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_duration
[ 1412.196795] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_mhvalid
[ 1412.196795] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_addr_match
[ 1412.196796] iwlwifi 0000:0b:00.0: 0x00000000 | lmpm_pmg_sel
[ 1412.196796] iwlwifi 0000:0b:00.0: 0x00000000 | timestamp
[ 1412.196797] iwlwifi 0000:0b:00.0: 0x00000000 | flow_handler
[ 1412.214645] iwlwifi 0000:0b:00.0: 0x00000000 | ADVANCED_SYSASSERT
[ 1412.214646] iwlwifi 0000:0b:00.0: 0x00000000 | umac branchlink1
[ 1412.214647] iwlwifi 0000:0b:00.0: 0x00000000 | umac branchlink2
[ 1412.214647] iwlwifi 0000:0b:00.0: 0x00000000 | umac interruptlink1
[ 1412.214647] iwlwifi 0000:0b:00.0: 0x00000000 | umac interruptlink2
[ 1412.214648] iwlwifi 0000:0b:00.0: 0x00000000 | umac data1
[ 1412.214648] iwlwifi 0000:0b:00.0: 0x00000000 | umac data2
[ 1412.214648] iwlwifi 0000:0b:00.0: 0x00000000 | umac data3
[ 1412.214649] iwlwifi 0000:0b:00.0: 0x00000000 | umac major
[ 1412.214649] iwlwifi 0000:0b:00.0: 0x00000000 | umac minor
[ 1412.214649] iwlwifi 0000:0b:00.0: 0x00000000 | frame pointer
[ 1412.214650] iwlwifi 0000:0b:00.0: 0x00000000 | stack pointer
[ 1412.214650] iwlwifi 0000:0b:00.0: 0x00000000 | last host cmd
[ 1412.214650] iwlwifi 0000:0b:00.0: 0x00000000 | isr status reg
[ 1412.232524] iwlwifi 0000:0b:00.0: IML/ROM dump:
[ 1412.232525] iwlwifi 0000:0b:00.0: 0x5A5A | IML/ROM SYSASSERT
[ 1412.232526] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM error/state
[ 1412.250412] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM data1
[ 1412.268306] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM WFPM_AUTH_KEY_0
[ 1412.304076] iwlwifi 0000:0b:00.0: WRT: Collecting data: ini trigger 4 fir=
ed (delay=3D0ms).
[ 1412.304079] ieee80211 phy0: Hardware restart was requested
[ 1419.432471] iwlwifi 0000:0b:00.0: Queue 5 is stuck 8330 8446
[ 1435.526763] iwlwifi 0000:0b:00.0: WRT: Failed to dump region: id=3D2, typ=
e=3D11
[ 1435.635199] iwlwifi 0000:0b:00.0: Failed to get monitor header
[ 1435.635200] iwlwifi 0000:0b:00.0: WRT: Failed to fill region header: id=3D=
16, type=3D2
[ 1443.240091] iwlwifi 0000:0b:00.0: WRT: Invalid buffer destination
[ 1444.281323] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x5a5a5a5a
[ 1444.299208] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x5a5a5a5a
[ 1444.317102] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x5a5a5a5a
[ 1444.335005] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x5a5a5a5a
[ 1444.370815] iwlwifi 0000:0b:00.0: SecBoot CPU1 Status: 0x5a5a5a5a, CPU2 S=
tatus: 0x5a5a5a5a
[ 1444.388711] iwlwifi 0000:0b:00.0: WFPM_LMAC1_PD_NOTIFICATION: 0x5a5a5a5a
[ 1444.406633] iwlwifi 0000:0b:00.0: HPM_SECONDARY_DEVICE_STATE: 0x5a5a5a5a
[ 1444.424535] iwlwifi 0000:0b:00.0: WFPM_MAC_OTP_CFG7_ADDR: 0x5a5a5a5a
[ 1444.442432] iwlwifi 0000:0b:00.0: WFPM_MAC_OTP_CFG7_DATA: 0x5a5a5a5a
[ 1444.460323] iwlwifi 0000:0b:00.0: UMAC PC: 0x5a5a5a5a
[ 1444.478229] iwlwifi 0000:0b:00.0: LMAC PC: 0x5a5a5a5a
[ 1444.478231] iwlwifi 0000:0b:00.0: WRT: Collecting data: ini trigger 13 fi=
red (delay=3D0ms).
[ 1444.514028] ------------[ cut here ]------------
[ 1444.514029] WARNING: CPU: 17 PID: 4288 at drivers/net/wireless/intel/iwlw=
ifi/iwl-trans.h:1422 iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1444.514042] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1444.514065]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1444.514070] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W     =
     6.3.11-200.fc38.x86_64 #1
[ 1444.514071] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1444.514072] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1444.514088] RIP: 0010:iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1444.514095] Code: 7d 40 e8 e8 d8 fd ff 48 8b 03 48 8b 7d 40 31 f6 44 8b 4=
4 24 08 48 c7 c2 28 3d 7e c4 48 8b 48 38 e8 ca d8 fd ff e9 6a fc ff ff <0f> 0=
b 48 8b 7d 40 48 c7 c2 00 3d 7e c4 31 f6 e8 b1 d8 fd ff 48 8b
[ 1444.514095] RSP: 0018:ffffbc8ad6a47a18 EFLAGS: 00010286
[ 1444.514096] RAX: 00000000fffffff0 RBX: ffff9ac7e754af58 RCX: 000000000000=
0011
[ 1444.514097] RDX: 0000000000000002 RSI: 00000000fffffe01 RDI: ffffffffc47b=
26e4
[ 1444.514097] RBP: ffff9ac7c9eb0028 R08: 0000000000003a98 R09: 000000000000=
0000
[ 1444.514098] R10: ffffbc8ad6a47b68 R11: 0000000000000000 R12: 00000000004f=
1f08
[ 1444.514098] R13: 0000000000000000 R14: ffffbc8ad6a47a20 R15: ffff9ac7c9eb=
0028
[ 1444.514099] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1444.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1444.514100] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1444.514100] PKRU: 55555554
[ 1444.514101] Call Trace:
[ 1444.514102]  <TASK>
[ 1444.514102]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1444.514108]  ? __warn+0x81/0x130
[ 1444.514111]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1444.514117]  ? report_bug+0x171/0x1a0
[ 1444.514119]  ? handle_bug+0x3c/0x80
[ 1444.514121]  ? exc_invalid_op+0x17/0x70
[ 1444.514122]  ? asm_exc_invalid_op+0x1a/0x20
[ 1444.514124]  ? iwl_trans_pcie_grab_nic_access+0x24/0x40 [iwlwifi]
[ 1444.514131]  ? iwl_fwrt_dump_lmac_error_log+0x49b/0x560 [iwlwifi]
[ 1444.514137]  ? iwl_fwrt_dump_lmac_error_log+0xb3/0x560 [iwlwifi]
[ 1444.514143]  iwl_fwrt_dump_error_logs+0x28/0x1f0 [iwlwifi]
[ 1444.514149]  iwl_mvm_nic_error+0x61/0xe0 [iwlmvm]
[ 1444.514157]  iwl_trans_sync_nmi_with_addr+0x79/0x170 [iwlwifi]
[ 1444.514163]  iwl_fw_dbg_error_collect+0x5f/0xe0 [iwlwifi]
[ 1444.514169]  iwl_mvm_load_ucode_wait_alive+0x539/0x5c0 [iwlmvm]
[ 1444.514175]  ? __pfx_iwl_alive_fn+0x10/0x10 [iwlmvm]
[ 1444.514181]  iwl_run_unified_mvm_ucode+0xbb/0x250 [iwlmvm]
[ 1444.514186]  ? __pfx_iwl_wait_init_complete+0x10/0x10 [iwlmvm]
[ 1444.514192]  iwl_mvm_up+0x200/0xc10 [iwlmvm]
[ 1444.514198]  ? __iterate_interfaces+0x9d/0x110 [mac80211]
[ 1444.514217]  ? __iwl_mvm_mac_start+0x5f/0x1c0 [iwlmvm]
[ 1444.514223]  __iwl_mvm_mac_start+0x5f/0x1c0 [iwlmvm]
[ 1444.514228]  iwl_mvm_mac_start+0x79/0x130 [iwlmvm]
[ 1444.514234]  drv_start+0x3f/0x100 [mac80211]
[ 1444.514248]  ieee80211_reconfig+0xbe/0x16f0 [mac80211]
[ 1444.514265]  ieee80211_restart_work+0xf5/0x150 [mac80211]
[ 1444.514278]  process_one_work+0x1c4/0x3d0
[ 1444.514280]  worker_thread+0x51/0x390
[ 1444.514280]  ? __pfx_worker_thread+0x10/0x10
[ 1444.514281]  kthread+0xdb/0x110
[ 1444.514283]  ? __pfx_kthread+0x10/0x10
[ 1444.514284]  ret_from_fork+0x29/0x50
[ 1444.514287]  </TASK>
[ 1444.514287] ---[ end trace 0000000000000000 ]---
[ 1444.514288] iwlwifi 0000:0b:00.0: HW error, resetting before reading
[ 1444.538192] iwlwifi 0000:0b:00.0: Loaded firmware version: 74.fe17486e.0 t=
y-a0-gf-a0-74.ucode
[ 1444.538194] iwlwifi 0000:0b:00.0: 0x00000000 | ADVANCED_SYSASSERT        =
 =20
[ 1444.538195] iwlwifi 0000:0b:00.0: 0x00000000 | trm_hw_status0
[ 1444.538196] iwlwifi 0000:0b:00.0: 0x00000000 | trm_hw_status1
[ 1444.538196] iwlwifi 0000:0b:00.0: 0x00000000 | branchlink2
[ 1444.538197] iwlwifi 0000:0b:00.0: 0x00000000 | interruptlink1
[ 1444.538197] iwlwifi 0000:0b:00.0: 0x00000000 | interruptlink2
[ 1444.538197] iwlwifi 0000:0b:00.0: 0x00000000 | data1
[ 1444.538198] iwlwifi 0000:0b:00.0: 0x00000000 | data2
[ 1444.538198] iwlwifi 0000:0b:00.0: 0x00000000 | data3
[ 1444.538198] iwlwifi 0000:0b:00.0: 0x00000000 | beacon time
[ 1444.538198] iwlwifi 0000:0b:00.0: 0x00000000 | tsf low
[ 1444.538199] iwlwifi 0000:0b:00.0: 0x00000000 | tsf hi
[ 1444.538199] iwlwifi 0000:0b:00.0: 0x00000000 | time gp1
[ 1444.538199] iwlwifi 0000:0b:00.0: 0x00000000 | time gp2
[ 1444.538200] iwlwifi 0000:0b:00.0: 0x00000000 | uCode revision type
[ 1444.538200] iwlwifi 0000:0b:00.0: 0x00000000 | uCode version major
[ 1444.538200] iwlwifi 0000:0b:00.0: 0x00000000 | uCode version minor
[ 1444.538201] iwlwifi 0000:0b:00.0: 0x00000000 | hw version
[ 1444.538201] iwlwifi 0000:0b:00.0: 0x00000000 | board version
[ 1444.538201] iwlwifi 0000:0b:00.0: 0x00000000 | hcmd
[ 1444.538202] iwlwifi 0000:0b:00.0: 0x00000000 | isr0
[ 1444.538202] iwlwifi 0000:0b:00.0: 0x00000000 | isr1
[ 1444.538202] iwlwifi 0000:0b:00.0: 0x00000000 | isr2
[ 1444.538202] iwlwifi 0000:0b:00.0: 0x00000000 | isr3
[ 1444.538203] iwlwifi 0000:0b:00.0: 0x00000000 | isr4
[ 1444.538203] iwlwifi 0000:0b:00.0: 0x00000000 | last cmd Id
[ 1444.538203] iwlwifi 0000:0b:00.0: 0x00000000 | wait_event
[ 1444.538204] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_control
[ 1444.538204] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_duration
[ 1444.538204] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_mhvalid
[ 1444.538205] iwlwifi 0000:0b:00.0: 0x00000000 | l2p_addr_match
[ 1444.538205] iwlwifi 0000:0b:00.0: 0x00000000 | lmpm_pmg_sel
[ 1444.538205] iwlwifi 0000:0b:00.0: 0x00000000 | timestamp
[ 1444.538206] iwlwifi 0000:0b:00.0: 0x00000000 | flow_handler
[ 1444.556069] iwlwifi 0000:0b:00.0: 0x00000000 | ADVANCED_SYSASSERT
[ 1444.556070] iwlwifi 0000:0b:00.0: 0x00000000 | umac branchlink1
[ 1444.556071] iwlwifi 0000:0b:00.0: 0x00000000 | umac branchlink2
[ 1444.556071] iwlwifi 0000:0b:00.0: 0x00000000 | umac interruptlink1
[ 1444.556071] iwlwifi 0000:0b:00.0: 0x00000000 | umac interruptlink2
[ 1444.556072] iwlwifi 0000:0b:00.0: 0x00000000 | umac data1
[ 1444.556072] iwlwifi 0000:0b:00.0: 0x00000000 | umac data2
[ 1444.556072] iwlwifi 0000:0b:00.0: 0x00000000 | umac data3
[ 1444.556073] iwlwifi 0000:0b:00.0: 0x00000000 | umac major
[ 1444.556073] iwlwifi 0000:0b:00.0: 0x00000000 | umac minor
[ 1444.556073] iwlwifi 0000:0b:00.0: 0x00000000 | frame pointer
[ 1444.556074] iwlwifi 0000:0b:00.0: 0x00000000 | stack pointer
[ 1444.556074] iwlwifi 0000:0b:00.0: 0x00000000 | last host cmd
[ 1444.556074] iwlwifi 0000:0b:00.0: 0x00000000 | isr status reg
[ 1444.573956] iwlwifi 0000:0b:00.0: IML/ROM dump:
[ 1444.573957] iwlwifi 0000:0b:00.0: 0x5A5A | IML/ROM SYSASSERT
[ 1444.573958] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM error/state
[ 1444.592102] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM data1
[ 1444.609994] iwlwifi 0000:0b:00.0: 0x5A5A5A5A | IML/ROM WFPM_AUTH_KEY_0
[ 1444.627887] iwlwifi 0000:0b:00.0: Failed to start RT ucode: -110
[ 1444.627888] iwlwifi 0000:0b:00.0: Failed to start RT ucode: -110
[ 1444.627889] iwlwifi 0000:0b:00.0: WRT: Collecting data: ini trigger 13 fi=
red (delay=3D0ms).
[ 1467.914087] iwlwifi 0000:0b:00.0: Failed to get monitor header
[ 1467.914088] iwlwifi 0000:0b:00.0: WRT: Failed to fill region header: id=3D=
16, type=3D2
[ 1492.342390] watchdog: BUG: soft lockup - CPU#17 stuck for 21s! [kworker/1=
7:0:4288]
[ 1492.342393] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1492.342415]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1492.342418] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W     =
     6.3.11-200.fc38.x86_64 #1
[ 1492.342419] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1492.342420] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1492.342438] RIP: 0010:delay_halt_mwaitx+0x3d/0x50
[ 1492.342441] Code: 48 89 d1 65 48 03 05 1a 35 08 71 0f 01 fa b8 ff ff ff f=
f b9 02 00 00 00 48 39 c6 48 0f 46 c6 48 89 c3 b8 f0 00 00 00 0f 01 fb <5b> c=
3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90
[ 1492.342442] RSP: 0018:ffffbc8ad6a47a60 EFLAGS: 00000297
[ 1492.342443] RAX: 00000000000000f0 RBX: 0000000000001d0b RCX: 000000000000=
0002
[ 1492.342443] RDX: 0000000000000000 RSI: 0000000000001d0b RDI: 000005daa6a7=
05b4
[ 1492.342444] RBP: 000005daa6a705b4 R08: 0000000000003a98 R09: 000000001e79=
f215
[ 1492.342444] R10: ffffffff900060f8 R11: ffff9ac95625af00 R12: 000000000000=
0011
[ 1492.342445] R13: 0000000000000001 R14: 0000000000000024 R15: 000000000000=
3a98
[ 1492.342445] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1492.342446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1492.342447] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1492.342447] PKRU: 55555554
[ 1492.342448] Call Trace:
[ 1492.342448]  <IRQ>
[ 1492.342449]  ? watchdog_timer_fn+0x1a8/0x210
[ 1492.342451]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 1492.342452]  ? __hrtimer_run_queues+0x10f/0x2b0
[ 1492.342454]  ? hrtimer_interrupt+0xf8/0x230
[ 1492.342455]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
[ 1492.342457]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[ 1492.342458]  </IRQ>
[ 1492.342459]  <TASK>
[ 1492.342459]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1492.342461]  ? delay_halt_mwaitx+0x3d/0x50
[ 1492.342463]  delay_halt+0x3c/0x70
[ 1492.342464]  iwl_poll_bit+0x33/0x80 [iwlwifi]
[ 1492.342472]  __iwl_trans_pcie_grab_nic_access+0xb7/0x150 [iwlwifi]
[ 1492.342480]  iwl_trans_pcie_grab_nic_access+0x1a/0x40 [iwlwifi]
[ 1492.342486]  iwl_read_prph+0x1d/0x70 [iwlwifi]
[ 1492.342492]  iwl_dump_ini_prph_mac_iter+0x5b/0x90 [iwlwifi]
[ 1492.342500]  iwl_dump_ini_mem+0x1d9/0x340 [iwlwifi]
[ 1492.342507]  iwl_fw_dbg_collect_sync+0xd7f/0x1c50 [iwlwifi]
[ 1492.342514]  iwl_fw_dbg_stop_sync+0x25/0x40 [iwlwifi]
[ 1492.342521]  iwl_mvm_stop_device+0x3a/0x80 [iwlmvm]
[ 1492.342529]  iwl_mvm_up+0x157/0xc10 [iwlmvm]
[ 1492.342536]  ? __iterate_interfaces+0x9d/0x110 [mac80211]
[ 1492.342557]  ? __iwl_mvm_mac_start+0x5f/0x1c0 [iwlmvm]
[ 1492.342564]  __iwl_mvm_mac_start+0x5f/0x1c0 [iwlmvm]
[ 1492.342571]  iwl_mvm_mac_start+0x79/0x130 [iwlmvm]
[ 1492.342577]  drv_start+0x3f/0x100 [mac80211]
[ 1492.342593]  ieee80211_reconfig+0xbe/0x16f0 [mac80211]
[ 1492.342612]  ieee80211_restart_work+0xf5/0x150 [mac80211]
[ 1492.342627]  process_one_work+0x1c4/0x3d0
[ 1492.342629]  worker_thread+0x51/0x390
[ 1492.342630]  ? __pfx_worker_thread+0x10/0x10
[ 1492.342630]  kthread+0xdb/0x110
[ 1492.342631]  ? __pfx_kthread+0x10/0x10
[ 1492.342632]  ret_from_fork+0x29/0x50
[ 1492.342635]  </TASK>
[ 1493.213763] iwlwifi 0000:0b:00.0: Failed to get monitor header
[ 1493.213765] iwlwifi 0000:0b:00.0: WRT: Failed to fill region header: id=3D=
16, type=3D2
[ 1497.029498] iwlwifi 0000:0b:00.0: mac start retry 0
[ 1497.029500] ------------[ cut here ]------------
[ 1497.029501] Hardware became unavailable during restart.
[ 1497.029508] WARNING: CPU: 17 PID: 4288 at net/mac80211/util.c:2542 ieee80=
211_reconfig+0xdd/0x16f0 [mac80211]
[ 1497.029534] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.029554]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.029557] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.029558] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.029559] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.029576] RIP: 0010:ieee80211_reconfig+0xdd/0x16f0 [mac80211]
[ 1497.029594] Code: 00 00 48 89 3c 24 e8 22 93 fb ff 4c 8b 14 24 85 c0 41 8=
9 c6 0f 84 e5 02 00 00 48 c7 c7 20 d2 c1 c1 4c 89 14 24 e8 73 41 56 cc <0f> 0=
b 4c 8b 14 24 4c 89 d7 e8 05 c5 ff ff e9 0d 01 00 00 45 31 ff
[ 1497.029595] RSP: 0018:ffffbc8ad6a47df0 EFLAGS: 00010282
[ 1497.029596] RAX: 0000000000000000 RBX: ffff9ac7e7549ab0 RCX: 000000000000=
0027
[ 1497.029596] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.029597] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffbc8ad6a4=
7c80
[ 1497.029597] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
9ab0
[ 1497.029598] R13: ffff9ac7e75488e0 R14: 00000000ffffff92 R15: ffff9ac7e754=
9f28
[ 1497.029598] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.029599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.029600] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.029600] PKRU: 55555554
[ 1497.029601] Call Trace:
[ 1497.029601]  <TASK>
[ 1497.029602]  ? ieee80211_reconfig+0xdd/0x16f0 [mac80211]
[ 1497.029620]  ? __warn+0x81/0x130
[ 1497.029622]  ? ieee80211_reconfig+0xdd/0x16f0 [mac80211]
[ 1497.029639]  ? report_bug+0x171/0x1a0
[ 1497.029640]  ? prb_read_valid+0x1b/0x30
[ 1497.029642]  ? handle_bug+0x3c/0x80
[ 1497.029643]  ? exc_invalid_op+0x17/0x70
[ 1497.029645]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.029647]  ? ieee80211_reconfig+0xdd/0x16f0 [mac80211]
[ 1497.029665]  ieee80211_restart_work+0xf5/0x150 [mac80211]
[ 1497.029681]  process_one_work+0x1c4/0x3d0
[ 1497.029682]  worker_thread+0x51/0x390
[ 1497.029683]  ? __pfx_worker_thread+0x10/0x10
[ 1497.029683]  kthread+0xdb/0x110
[ 1497.029685]  ? __pfx_kthread+0x10/0x10
[ 1497.029686]  ret_from_fork+0x29/0x50
[ 1497.029688]  </TASK>
[ 1497.029688] ---[ end trace 0000000000000000 ]---
[ 1497.039301] ------------[ cut here ]------------
[ 1497.039302] p2p-dev-wlp11s0: Failed check-sdata-in-driver check, flags: 0=
x0
[ 1497.039312] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:99 dr=
v_remove_interface+0x114/0x120 [mac80211]
[ 1497.039334] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.039355]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.039358] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.039359] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.039360] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.039378] RIP: 0010:drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.039396] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 cd e1 10 00 01 48 85 c0 48 0f 45 f0 e8 ac a8 5a cc <0f> 0=
b e9 2f ff ff ff 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
[ 1497.039397] RSP: 0018:ffffbc8ad6a47d80 EFLAGS: 00010282
[ 1497.039398] RAX: 0000000000000000 RBX: ffff9ac7c0dc4000 RCX: 000000000000=
0027
[ 1497.039399] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.039399] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
7c10
[ 1497.039400] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
88e0
[ 1497.039400] R13: ffff9ac7c0dc5230 R14: ffff9ac7e75491e0 R15: 000000000000=
0000
[ 1497.039401] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.039402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.039402] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.039403] PKRU: 55555554
[ 1497.039403] Call Trace:
[ 1497.039404]  <TASK>
[ 1497.039404]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.039423]  ? __warn+0x81/0x130
[ 1497.039425]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.039443]  ? report_bug+0x171/0x1a0
[ 1497.039444]  ? prb_read_valid+0x1b/0x30
[ 1497.039445]  ? handle_bug+0x3c/0x80
[ 1497.039446]  ? exc_invalid_op+0x17/0x70
[ 1497.039448]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.039450]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.039468]  ieee80211_do_stop+0x597/0x890 [mac80211]
[ 1497.039491]  cfg80211_stop_p2p_device+0x50/0x150 [cfg80211]
[ 1497.039511]  cfg80211_shutdown_all_interfaces+0xae/0xf0 [cfg80211]
[ 1497.039528]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.039546]  process_one_work+0x1c4/0x3d0
[ 1497.039547]  worker_thread+0x51/0x390
[ 1497.039548]  ? __pfx_worker_thread+0x10/0x10
[ 1497.039549]  kthread+0xdb/0x110
[ 1497.039550]  ? __pfx_kthread+0x10/0x10
[ 1497.039551]  ret_from_fork+0x29/0x50
[ 1497.039554]  </TASK>
[ 1497.039554] ---[ end trace 0000000000000000 ]---
[ 1497.039557] iwlwifi 0000:0b:00.0: Failed to synchronize multicast groups u=
pdate
[ 1497.039565] wlp11s0: deauthenticating from 9c:31:c3:d0:d9:15 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[ 1497.039568] ------------[ cut here ]------------
[ 1497.039569] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.039575] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:156 i=
eee80211_vif_cfg_change_notify+0x178/0x180 [mac80211]
[ 1497.039594] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.039614]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.039618] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.039619] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.039619] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.039637] RIP: 0010:ieee80211_vif_cfg_change_notify+0x178/0x180 [mac802=
11]
[ 1497.039655] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 68 bb c1 c1 c6 05 67 08 11 00 01 48 85 c0 48 0f 45 f0 e8 58 cf 5a cc <0f> 0=
b e9 f4 fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 1497.039655] RSP: 0018:ffffbc8ad6a479e8 EFLAGS: 00010286
[ 1497.039656] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.039657] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.039657] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
7878
[ 1497.039658] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000002=
0000
[ 1497.039658] R13: 0000000000000001 R14: ffff9ac7e7549b10 R15: ffff9ac7c732=
49c0
[ 1497.039659] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.039660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.039660] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.039661] PKRU: 55555554
[ 1497.039661] Call Trace:
[ 1497.039662]  <TASK>
[ 1497.039662]  ? ieee80211_vif_cfg_change_notify+0x178/0x180 [mac80211]
[ 1497.039680]  ? __warn+0x81/0x130
[ 1497.039681]  ? ieee80211_vif_cfg_change_notify+0x178/0x180 [mac80211]
[ 1497.039699]  ? report_bug+0x171/0x1a0
[ 1497.039700]  ? prb_read_valid+0x1b/0x30
[ 1497.039701]  ? handle_bug+0x3c/0x80
[ 1497.039702]  ? exc_invalid_op+0x17/0x70
[ 1497.039704]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.039705]  ? ieee80211_vif_cfg_change_notify+0x178/0x180 [mac80211]
[ 1497.039723]  ? ieee80211_vif_cfg_change_notify+0x178/0x180 [mac80211]
[ 1497.039741]  ieee80211_set_disassoc+0x485/0x620 [mac80211]
[ 1497.039768]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.039791]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.039814]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.039831]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.039852]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.039870]  ? _dev_err+0x79/0xa0
[ 1497.039873]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.039893]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.039901]  ? rtnl_is_locked+0x15/0x20
[ 1497.039903]  ? inetdev_event+0x3d/0x6a0
[ 1497.039906]  raw_notifier_call_chain+0x45/0x60
[ 1497.039907]  __dev_close_many+0x5f/0x110
[ 1497.039909]  dev_close_many+0x8f/0x150
[ 1497.039911]  dev_close+0x83/0xb0
[ 1497.039912]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.039929]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.039944]  process_one_work+0x1c4/0x3d0
[ 1497.039945]  worker_thread+0x51/0x390
[ 1497.039946]  ? __pfx_worker_thread+0x10/0x10
[ 1497.039947]  kthread+0xdb/0x110
[ 1497.039948]  ? __pfx_kthread+0x10/0x10
[ 1497.039949]  ret_from_fork+0x29/0x50
[ 1497.039950]  </TASK>
[ 1497.039951] ---[ end trace 0000000000000000 ]---
[ 1497.039956] ------------[ cut here ]------------
[ 1497.039957] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.039962] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:627 _=
_ieee80211_flush_queues+0x237/0x240 [mac80211]
[ 1497.039980] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.039993]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.039995] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.039996] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.039996] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.040009] RIP: 0010:__ieee80211_flush_queues+0x237/0x240 [mac80211]
[ 1497.040022] Code: 49 8b 84 24 70 07 00 00 49 8d b4 24 90 07 00 00 48 c7 c=
7 78 d1 c1 c1 c6 05 da 8c 0c 00 01 48 85 c0 48 0f 45 f0 e8 69 53 56 cc <0f> 0=
b e9 79 fe ff ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 1497.040023] RSP: 0018:ffffbc8ad6a479d0 EFLAGS: 00010282
[ 1497.040023] RAX: 0000000000000000 RBX: 000000000000000f RCX: 000000000000=
0027
[ 1497.040024] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.040024] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
7860
[ 1497.040024] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7c732=
49c0
[ 1497.040025] R13: 000000000000000f R14: 0000000000000001 R15: ffff9ac7c732=
5bf0
[ 1497.040025] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.040026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.040026] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.040026] PKRU: 55555554
[ 1497.040027] Call Trace:
[ 1497.040027]  <TASK>
[ 1497.040027]  ? __ieee80211_flush_queues+0x237/0x240 [mac80211]
[ 1497.040041]  ? __warn+0x81/0x130
[ 1497.040042]  ? __ieee80211_flush_queues+0x237/0x240 [mac80211]
[ 1497.040055]  ? report_bug+0x171/0x1a0
[ 1497.040056]  ? prb_read_valid+0x1b/0x30
[ 1497.040057]  ? handle_bug+0x3c/0x80
[ 1497.040058]  ? exc_invalid_op+0x17/0x70
[ 1497.040059]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.040061]  ? __ieee80211_flush_queues+0x237/0x240 [mac80211]
[ 1497.040074]  ieee80211_set_disassoc+0x4a3/0x620 [mac80211]
[ 1497.040089]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.040104]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.040118]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.040130]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.040143]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.040155]  ? _dev_err+0x79/0xa0
[ 1497.040156]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.040170]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.040176]  ? rtnl_is_locked+0x15/0x20
[ 1497.040177]  ? inetdev_event+0x3d/0x6a0
[ 1497.040178]  raw_notifier_call_chain+0x45/0x60
[ 1497.040179]  __dev_close_many+0x5f/0x110
[ 1497.040180]  dev_close_many+0x8f/0x150
[ 1497.040181]  dev_close+0x83/0xb0
[ 1497.040182]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.040194]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.040207]  process_one_work+0x1c4/0x3d0
[ 1497.040207]  worker_thread+0x51/0x390
[ 1497.040208]  ? __pfx_worker_thread+0x10/0x10
[ 1497.040209]  kthread+0xdb/0x110
[ 1497.040210]  ? __pfx_kthread+0x10/0x10
[ 1497.040211]  ret_from_fork+0x29/0x50
[ 1497.040212]  </TASK>
[ 1497.040213] ---[ end trace 0000000000000000 ]---
[ 1497.040215] ------------[ cut here ]------------
[ 1497.040215] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.040220] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:1206 i=
eee80211_queue_skb+0x649/0x660 [mac80211]
[ 1497.040237] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.040251]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.040253] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.040254] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.040254] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.040266] RIP: 0010:ieee80211_queue_skb+0x649/0x660 [mac80211]
[ 1497.040280] Code: 48 8b 88 40 f5 ff ff 48 2d a0 0a 00 00 48 c7 c7 30 ce c=
1 c1 c6 05 c0 76 0d 00 01 48 85 c9 48 0f 44 c8 48 89 ce e8 57 3d 57 cc <0f> 0=
b e9 20 fe ff ff 31 d2 83 b8 30 12 00 00 02 74 8e e9 d4 fb ff
[ 1497.040280] RSP: 0018:ffffbc8ad6a478c0 EFLAGS: 00010282
[ 1497.040281] RAX: 0000000000000000 RBX: ffff9ac823bfd2e8 RCX: 000000000000=
0027
[ 1497.040281] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.040281] RBP: ffff9ac95625a800 R08: 0000000000000000 R09: ffffbc8ad6a4=
7750
[ 1497.040282] R10: 0000000000000003 R11: ffffffff90146108 R12: ffffbc8ad6a4=
7928
[ 1497.040283] R13: 0000000000000000 R14: ffff9ac7e75488e0 R15: ffff9ac7e754=
88e0
[ 1497.040283] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.040283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.040284] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.040284] PKRU: 55555554
[ 1497.040284] Call Trace:
[ 1497.040285]  <TASK>
[ 1497.040285]  ? ieee80211_queue_skb+0x649/0x660 [mac80211]
[ 1497.040301]  ? __warn+0x81/0x130
[ 1497.040303]  ? ieee80211_queue_skb+0x649/0x660 [mac80211]
[ 1497.040326]  ? report_bug+0x171/0x1a0
[ 1497.040327]  ? prb_read_valid+0x1b/0x30
[ 1497.040329]  ? handle_bug+0x3c/0x80
[ 1497.040330]  ? exc_invalid_op+0x17/0x70
[ 1497.040332]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.040334]  ? ieee80211_queue_skb+0x649/0x660 [mac80211]
[ 1497.040358]  ieee80211_tx+0xd3/0x130 [mac80211]
[ 1497.040384]  __ieee80211_tx_skb_tid_band+0x98/0x150 [mac80211]
[ 1497.040409]  ieee80211_tx_skb_tid+0x51/0x90 [mac80211]
[ 1497.040433]  ieee80211_set_disassoc+0x5a3/0x620 [mac80211]
[ 1497.040458]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.040483]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.040506]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.040528]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.040551]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.040573]  ? _dev_err+0x79/0xa0
[ 1497.040574]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.040598]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.040608]  ? rtnl_is_locked+0x15/0x20
[ 1497.040609]  ? inetdev_event+0x3d/0x6a0
[ 1497.040612]  raw_notifier_call_chain+0x45/0x60
[ 1497.040613]  __dev_close_many+0x5f/0x110
[ 1497.040615]  dev_close_many+0x8f/0x150
[ 1497.040617]  dev_close+0x83/0xb0
[ 1497.040618]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.040639]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.040661]  process_one_work+0x1c4/0x3d0
[ 1497.040663]  worker_thread+0x51/0x390
[ 1497.040664]  ? __pfx_worker_thread+0x10/0x10
[ 1497.040665]  kthread+0xdb/0x110
[ 1497.040666]  ? __pfx_kthread+0x10/0x10
[ 1497.040668]  ret_from_fork+0x29/0x50
[ 1497.040670]  </TASK>
[ 1497.040671] ---[ end trace 0000000000000000 ]---
[ 1497.040672] ------------[ cut here ]------------
[ 1497.040672] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.040680] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:839 d=
rv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040705] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.040731]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.040735] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.040736] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.040737] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.040759] RIP: 0010:drv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040782] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 60 e7 c1 c1 c6 05 f7 5b 09 00 01 48 85 c0 48 0f 45 f0 e8 76 22 53 cc <0f> 0=
b e9 25 ff ff ff 0f 0b e9 e6 fe ff ff 0f 1f 84 00 00 00 00 00
[ 1497.040783] RSP: 0018:ffffbc8ad6a479e8 EFLAGS: 00010286
[ 1497.040784] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.040785] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.040785] RBP: ffffbc8ad6a47a1a R08: 0000000000000000 R09: ffffbc8ad6a4=
7878
[ 1497.040786] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
88e0
[ 1497.040787] R13: 0000000000000001 R14: ffff9ac7e7549b10 R15: ffff9ac7c732=
49c0
[ 1497.040787] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.040788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.040789] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.040789] PKRU: 55555554
[ 1497.040790] Call Trace:
[ 1497.040791]  <TASK>
[ 1497.040791]  ? drv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040815]  ? __warn+0x81/0x130
[ 1497.040817]  ? drv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040841]  ? report_bug+0x171/0x1a0
[ 1497.040842]  ? prb_read_valid+0x1b/0x30
[ 1497.040843]  ? handle_bug+0x3c/0x80
[ 1497.040844]  ? exc_invalid_op+0x17/0x70
[ 1497.040846]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.040848]  ? drv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040873]  ? drv_mgd_complete_tx+0x13a/0x150 [mac80211]
[ 1497.040900]  ieee80211_set_disassoc+0x12a/0x620 [mac80211]
[ 1497.040932]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.040957]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.040983]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.041009]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.041034]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.041059]  ? _dev_err+0x79/0xa0
[ 1497.041061]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.041090]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.041101]  ? rtnl_is_locked+0x15/0x20
[ 1497.041102]  ? inetdev_event+0x3d/0x6a0
[ 1497.041105]  raw_notifier_call_chain+0x45/0x60
[ 1497.041106]  __dev_close_many+0x5f/0x110
[ 1497.041108]  dev_close_many+0x8f/0x150
[ 1497.041110]  dev_close+0x83/0xb0
[ 1497.041111]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.041136]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.041164]  process_one_work+0x1c4/0x3d0
[ 1497.041165]  worker_thread+0x51/0x390
[ 1497.041166]  ? __pfx_worker_thread+0x10/0x10
[ 1497.041167]  kthread+0xdb/0x110
[ 1497.041169]  ? __pfx_kthread+0x10/0x10
[ 1497.041171]  ret_from_fork+0x29/0x50
[ 1497.041173]  </TASK>
[ 1497.041174] ---[ end trace 0000000000000000 ]---
[ 1497.041175] ------------[ cut here ]------------
[ 1497.041176] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.041185] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:399 d=
rv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041213] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.041244]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.041249] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.041250] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.041251] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.041278] RIP: 0010:drv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041307] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 22 cc 10 00 01 48 85 c0 48 0f 45 f0 e8 0d 93 5a cc <0f> 0=
b eb c9 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
[ 1497.041308] RSP: 0018:ffffbc8ad6a47898 EFLAGS: 00010282
[ 1497.041309] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.041309] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.041310] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
7728
[ 1497.041311] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000000=
0000
[ 1497.041311] R13: ffffbc8ad6a478c8 R14: ffff9ac7c0dc2ab0 R15: 000000000000=
0000
[ 1497.041312] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.041313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.041314] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.041315] PKRU: 55555554
[ 1497.041315] Call Trace:
[ 1497.041316]  <TASK>
[ 1497.041317]  ? drv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041344]  ? __warn+0x81/0x130
[ 1497.041346]  ? drv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041374]  ? report_bug+0x171/0x1a0
[ 1497.041375]  ? prb_read_valid+0x1b/0x30
[ 1497.041377]  ? handle_bug+0x3c/0x80
[ 1497.041379]  ? exc_invalid_op+0x17/0x70
[ 1497.041380]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.041383]  ? drv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041413]  ? drv_ampdu_action+0x163/0x170 [mac80211]
[ 1497.041441]  ___ieee80211_stop_rx_ba_session+0xb5/0x180 [mac80211]
[ 1497.041471]  ieee80211_sta_tear_down_BA_sessions+0x4e/0xf0 [mac80211]
[ 1497.041500]  __sta_info_destroy_part1+0x45/0x4f0 [mac80211]
[ 1497.041529]  __sta_info_flush+0xd0/0x1b0 [mac80211]
[ 1497.041558]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.041588]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.041618]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.041645]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.041671]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.041698]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.041723]  ? _dev_err+0x79/0xa0
[ 1497.041725]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.041753]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.041764]  ? rtnl_is_locked+0x15/0x20
[ 1497.041766]  ? inetdev_event+0x3d/0x6a0
[ 1497.041768]  raw_notifier_call_chain+0x45/0x60
[ 1497.041770]  __dev_close_many+0x5f/0x110
[ 1497.041771]  dev_close_many+0x8f/0x150
[ 1497.041773]  dev_close+0x83/0xb0
[ 1497.041775]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.041800]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.041827]  process_one_work+0x1c4/0x3d0
[ 1497.041829]  worker_thread+0x51/0x390
[ 1497.041830]  ? __pfx_worker_thread+0x10/0x10
[ 1497.041831]  kthread+0xdb/0x110
[ 1497.041833]  ? __pfx_kthread+0x10/0x10
[ 1497.041834]  ret_from_fork+0x29/0x50
[ 1497.041837]  </TASK>
[ 1497.041838] ---[ end trace 0000000000000000 ]---
[ 1497.041838] wlp11s0: HW problem - can not stop rx aggregation for 9c:31:c=
3:d0:d9:15 tid 0
[ 1497.041840] wlp11s0: HW problem - can not stop rx aggregation for 9c:31:c=
3:d0:d9:15 tid 6
[ 1497.041840] wlp11s0: HW problem - can not stop rx aggregation for 9c:31:c=
3:d0:d9:15 tid 7
[ 1497.041843] iwlwifi 0000:0b:00.0: Failed to trigger RX queues sync (-5)
[ 1497.041845] ------------[ cut here ]------------
[ 1497.041845] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.041855] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:508 _=
_sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.041888] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.041920]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.041925] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.041926] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.041927] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.041953] RIP: 0010:__sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.041980] Code: ff ff 49 8b 85 70 07 00 00 49 8d b5 90 07 00 00 48 c7 c=
7 e0 bc c1 c1 c6 05 79 9f 10 00 01 48 85 c0 48 0f 45 f0 e8 4d 66 5a cc <0f> 0=
b e9 9c fc ff ff 80 3d 5d 9f 10 00 00 0f 85 46 fe ff ff 48 8b
[ 1497.041981] RSP: 0018:ffffbc8ad6a47958 EFLAGS: 00010286
[ 1497.041982] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000=
0027
[ 1497.041982] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.041983] RBP: ffff9ac7c0dc2000 R08: 0000000000000000 R09: ffffbc8ad6a4=
77e8
[ 1497.041984] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
88e0
[ 1497.041984] R13: ffff9ac7c73249c0 R14: ffff9ac7c7d01420 R15: ffff9ac7c0dc=
2030
[ 1497.041985] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.041986] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.041987] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.041988] PKRU: 55555554
[ 1497.041988] Call Trace:
[ 1497.041989]  <TASK>
[ 1497.041989]  ? __sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.042016]  ? __warn+0x81/0x130
[ 1497.042017]  ? __sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.042044]  ? report_bug+0x171/0x1a0
[ 1497.042045]  ? prb_read_valid+0x1b/0x30
[ 1497.042046]  ? handle_bug+0x3c/0x80
[ 1497.042048]  ? exc_invalid_op+0x17/0x70
[ 1497.042050]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.042052]  ? __sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.042079]  ? __sta_info_destroy_part1+0x493/0x4f0 [mac80211]
[ 1497.042105]  __sta_info_flush+0xd0/0x1b0 [mac80211]
[ 1497.042132]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.042160]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.042188]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.042213]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.042237]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.042262]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.042291]  ? _dev_err+0x79/0xa0
[ 1497.042293]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.042320]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.042330]  ? rtnl_is_locked+0x15/0x20
[ 1497.042331]  ? inetdev_event+0x3d/0x6a0
[ 1497.042334]  raw_notifier_call_chain+0x45/0x60
[ 1497.042335]  __dev_close_many+0x5f/0x110
[ 1497.042337]  dev_close_many+0x8f/0x150
[ 1497.042339]  dev_close+0x83/0xb0
[ 1497.042340]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.042364]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.042390]  process_one_work+0x1c4/0x3d0
[ 1497.042392]  worker_thread+0x51/0x390
[ 1497.042393]  ? __pfx_worker_thread+0x10/0x10
[ 1497.042394]  kthread+0xdb/0x110
[ 1497.042396]  ? __pfx_kthread+0x10/0x10
[ 1497.042397]  ret_from_fork+0x29/0x50
[ 1497.042400]  </TASK>
[ 1497.042400] ---[ end trace 0000000000000000 ]---
[ 1497.042411] ------------[ cut here ]------------
[ 1497.042411] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.042420] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:120 d=
rv_sta_state+0x471/0x540 [mac80211]
[ 1497.042447] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.042476]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.042481] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.042482] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.042483] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.042509] RIP: 0010:drv_sta_state+0x471/0x540 [mac80211]
[ 1497.042534] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 3f dd 10 00 01 48 85 c0 48 0f 45 f0 e8 1f a4 5a cc <0f> 0=
b e9 1d fe ff ff 80 3d 2a dd 10 00 00 74 71 41 bc fb ff ff ff
[ 1497.042535] RSP: 0018:ffffbc8ad6a47928 EFLAGS: 00010286
[ 1497.042536] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.042537] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.042538] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
77b8
[ 1497.042538] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000000=
0004
[ 1497.042539] R13: 0000000000000003 R14: ffff9ac7c0dc2000 R15: ffff9ac7e754=
8f28
[ 1497.042540] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.042541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.042541] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.042542] PKRU: 55555554
[ 1497.042543] Call Trace:
[ 1497.042543]  <TASK>
[ 1497.042544]  ? drv_sta_state+0x471/0x540 [mac80211]
[ 1497.042570]  ? __warn+0x81/0x130
[ 1497.042571]  ? drv_sta_state+0x471/0x540 [mac80211]
[ 1497.042597]  ? report_bug+0x171/0x1a0
[ 1497.042598]  ? prb_read_valid+0x1b/0x30
[ 1497.042599]  ? handle_bug+0x3c/0x80
[ 1497.042601]  ? exc_invalid_op+0x17/0x70
[ 1497.042602]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.042604]  ? drv_sta_state+0x471/0x540 [mac80211]
[ 1497.042631]  ? drv_sta_state+0x471/0x540 [mac80211]
[ 1497.042656]  sta_info_move_state+0x1c2/0x290 [mac80211]
[ 1497.042683]  __sta_info_destroy_part2+0x14a/0x160 [mac80211]
[ 1497.042710]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.042737]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.042765]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.042793]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.042819]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.042843]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.042868]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.042897]  ? _dev_err+0x79/0xa0
[ 1497.042899]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.042927]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.042938]  ? rtnl_is_locked+0x15/0x20
[ 1497.042939]  ? inetdev_event+0x3d/0x6a0
[ 1497.042942]  raw_notifier_call_chain+0x45/0x60
[ 1497.042943]  __dev_close_many+0x5f/0x110
[ 1497.042945]  dev_close_many+0x8f/0x150
[ 1497.042947]  dev_close+0x83/0xb0
[ 1497.042948]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.042970]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.042992]  process_one_work+0x1c4/0x3d0
[ 1497.042994]  worker_thread+0x51/0x390
[ 1497.042995]  ? __pfx_worker_thread+0x10/0x10
[ 1497.042996]  kthread+0xdb/0x110
[ 1497.042997]  ? __pfx_kthread+0x10/0x10
[ 1497.042999]  ret_from_fork+0x29/0x50
[ 1497.043001]  </TASK>
[ 1497.043002] ---[ end trace 0000000000000000 ]---
[ 1497.043009] ------------[ cut here ]------------
[ 1497.043009] WARNING: CPU: 17 PID: 4288 at net/mac80211/sta_info.c:1294 __=
sta_info_destroy_part2+0x152/0x160 [mac80211]
[ 1497.043034] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.043060]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.043064] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.043065] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.043066] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.043088] RIP: 0010:__sta_info_destroy_part2+0x152/0x160 [mac80211]
[ 1497.043112] Code: ef e8 d2 8b ff ff 85 c0 0f 84 4b ff ff ff 0f 0b e9 44 f=
f ff ff be 03 00 00 00 48 89 df e8 76 e8 ff ff 85 c0 0f 84 d4 fe ff ff <0f> 0=
b e9 cd fe ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[ 1497.043113] RSP: 0018:ffffbc8ad6a47978 EFLAGS: 00010282
[ 1497.043114] RAX: 00000000fffffffb RBX: ffff9ac7c0dc2000 RCX: 000000000000=
0027
[ 1497.043115] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.043116] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
77b8
[ 1497.043116] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7c732=
49c0
[ 1497.043117] R13: 0000000000000000 R14: ffff9ac7c73249c0 R15: ffff9ac7e754=
8f28
[ 1497.043118] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.043118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.043119] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.043120] PKRU: 55555554
[ 1497.043120] Call Trace:
[ 1497.043121]  <TASK>
[ 1497.043121]  ? __sta_info_destroy_part2+0x152/0x160 [mac80211]
[ 1497.043145]  ? __warn+0x81/0x130
[ 1497.043147]  ? __sta_info_destroy_part2+0x152/0x160 [mac80211]
[ 1497.043171]  ? report_bug+0x171/0x1a0
[ 1497.043172]  ? handle_bug+0x3c/0x80
[ 1497.043174]  ? exc_invalid_op+0x17/0x70
[ 1497.043175]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.043178]  ? __sta_info_destroy_part2+0x152/0x160 [mac80211]
[ 1497.043202]  ? __sta_info_destroy_part2+0x14a/0x160 [mac80211]
[ 1497.043226]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.043251]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.043277]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.043304]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.043327]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.043350]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.043372]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.043395]  ? _dev_err+0x79/0xa0
[ 1497.043396]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.043420]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.043430]  ? rtnl_is_locked+0x15/0x20
[ 1497.043432]  ? inetdev_event+0x3d/0x6a0
[ 1497.043434]  raw_notifier_call_chain+0x45/0x60
[ 1497.043435]  __dev_close_many+0x5f/0x110
[ 1497.043437]  dev_close_many+0x8f/0x150
[ 1497.043439]  dev_close+0x83/0xb0
[ 1497.043440]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.043461]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.043484]  process_one_work+0x1c4/0x3d0
[ 1497.043485]  worker_thread+0x51/0x390
[ 1497.043486]  ? __pfx_worker_thread+0x10/0x10
[ 1497.043487]  kthread+0xdb/0x110
[ 1497.043489]  ? __pfx_kthread+0x10/0x10
[ 1497.043490]  ret_from_fork+0x29/0x50
[ 1497.043493]  </TASK>
[ 1497.043493] ---[ end trace 0000000000000000 ]---
[ 1497.043500] ------------[ cut here ]------------
[ 1497.043500] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.043508] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:462 d=
rv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043532] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.043558]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.043562] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.043563] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.043563] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.043585] RIP: 0010:drv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043609] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 89 c8 10 00 01 48 85 c0 48 0f 45 f0 e8 76 8f 5a cc <0f> 0=
b eb ca 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 1497.043610] RSP: 0018:ffffbc8ad6a47878 EFLAGS: 00010286
[ 1497.043611] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.043612] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.043612] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: ffffbc8ad6a4=
7708
[ 1497.043613] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac8d61f=
5230
[ 1497.043614] R13: 0000000000000001 R14: ffff9ac7c0dc2ab0 R15: ffff9ac8d61f=
5000
[ 1497.043614] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.043615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.043616] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.043616] PKRU: 55555554
[ 1497.043617] Call Trace:
[ 1497.043617]  <TASK>
[ 1497.043618]  ? drv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043642]  ? __warn+0x81/0x130
[ 1497.043643]  ? drv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043667]  ? report_bug+0x171/0x1a0
[ 1497.043668]  ? prb_read_valid+0x1b/0x30
[ 1497.043670]  ? handle_bug+0x3c/0x80
[ 1497.043671]  ? exc_invalid_op+0x17/0x70
[ 1497.043673]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.043675]  ? drv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043700]  ? drv_set_key+0x19a/0x1a0 [mac80211]
[ 1497.043725]  ieee80211_key_disable_hw_accel+0x92/0x100 [mac80211]
[ 1497.043753]  ieee80211_key_replace+0x4b3/0x9d0 [mac80211]
[ 1497.043778]  ieee80211_free_sta_keys+0xb2/0xf0 [mac80211]
[ 1497.043804]  __sta_info_destroy_part2+0x31/0x160 [mac80211]
[ 1497.043829]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.043854]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.043882]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.043907]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.043936]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.043958]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.043981]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.044003]  ? _dev_err+0x79/0xa0
[ 1497.044004]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.044028]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.044038]  ? rtnl_is_locked+0x15/0x20
[ 1497.044039]  ? inetdev_event+0x3d/0x6a0
[ 1497.044041]  raw_notifier_call_chain+0x45/0x60
[ 1497.044043]  __dev_close_many+0x5f/0x110
[ 1497.044044]  dev_close_many+0x8f/0x150
[ 1497.044046]  dev_close+0x83/0xb0
[ 1497.044047]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.044068]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.044090]  process_one_work+0x1c4/0x3d0
[ 1497.044091]  worker_thread+0x51/0x390
[ 1497.044092]  ? __pfx_worker_thread+0x10/0x10
[ 1497.044093]  kthread+0xdb/0x110
[ 1497.044095]  ? __pfx_kthread+0x10/0x10
[ 1497.044096]  ret_from_fork+0x29/0x50
[ 1497.044099]  </TASK>
[ 1497.044099] ---[ end trace 0000000000000000 ]---
[ 1497.044100] wlp11s0: failed to remove key (0, 9c:31:c3:d0:d9:15) from har=
dware (-5)
[ 1497.044125] ------------[ cut here ]------------
[ 1497.044126] WARNING: CPU: 17 PID: 4288 at net/mac80211/sta_info.c:1311 __=
sta_info_destroy_part2+0x109/0x160 [mac80211]
[ 1497.044150] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.044176]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.044180] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.044181] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.044182] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.044204] RIP: 0010:__sta_info_destroy_part2+0x109/0x160 [mac80211]
[ 1497.044227] Code: 05 00 00 e8 99 74 02 00 48 8b 43 50 48 89 df 48 8b a8 7=
8 07 00 00 e8 e6 be ff ff 48 89 de 5b 48 89 ef 5d 41 5c e9 57 eb ff ff <0f> 0=
b 80 bb d4 00 00 00 00 0f 84 69 ff ff ff 45 31 c0 b9 01 00 00
[ 1497.044228] RSP: 0018:ffffbc8ad6a47978 EFLAGS: 00010282
[ 1497.044229] RAX: 00000000fffffffb RBX: ffff9ac7c0dc2000 RCX: 000000000000=
0004
[ 1497.044230] RDX: 0000000000000000 RSI: ffff9ac7c73249c0 RDI: ffff9ac7e754=
88e0
[ 1497.044230] RBP: ffff9ac7e75488e0 R08: 0000000000000003 R09: 000000000020=
0016
[ 1497.044231] R10: ffff9ac7c7325848 R11: ffff9ac7c73249c0 R12: ffff9ac7c732=
49c0
[ 1497.044232] R13: 0000000000000000 R14: ffff9ac7c73249c0 R15: ffff9ac7e754=
8f28
[ 1497.044232] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.044233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.044234] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.044234] PKRU: 55555554
[ 1497.044235] Call Trace:
[ 1497.044235]  <TASK>
[ 1497.044236]  ? __sta_info_destroy_part2+0x109/0x160 [mac80211]
[ 1497.044259]  ? __warn+0x81/0x130
[ 1497.044261]  ? __sta_info_destroy_part2+0x109/0x160 [mac80211]
[ 1497.044287]  ? report_bug+0x171/0x1a0
[ 1497.044288]  ? handle_bug+0x3c/0x80
[ 1497.044290]  ? exc_invalid_op+0x17/0x70
[ 1497.044291]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.044293]  ? __sta_info_destroy_part2+0x109/0x160 [mac80211]
[ 1497.044317]  ? __sta_info_destroy_part2+0x61/0x160 [mac80211]
[ 1497.044341]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.044366]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.044392]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.044417]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.044440]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.044461]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.044484]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.044506]  ? _dev_err+0x79/0xa0
[ 1497.044507]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.044530]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.044540]  ? rtnl_is_locked+0x15/0x20
[ 1497.044541]  ? inetdev_event+0x3d/0x6a0
[ 1497.044544]  raw_notifier_call_chain+0x45/0x60
[ 1497.044545]  __dev_close_many+0x5f/0x110
[ 1497.044547]  dev_close_many+0x8f/0x150
[ 1497.044548]  dev_close+0x83/0xb0
[ 1497.044550]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.044571]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.044593]  process_one_work+0x1c4/0x3d0
[ 1497.044594]  worker_thread+0x51/0x390
[ 1497.044595]  ? __pfx_worker_thread+0x10/0x10
[ 1497.044596]  kthread+0xdb/0x110
[ 1497.044597]  ? __pfx_kthread+0x10/0x10
[ 1497.044599]  ret_from_fork+0x29/0x50
[ 1497.044601]  </TASK>
[ 1497.044602] ---[ end trace 0000000000000000 ]---
[ 1497.044609] ------------[ cut here ]------------
[ 1497.044609] WARNING: CPU: 17 PID: 4288 at net/mac80211/sta_info.c:1319 __=
sta_info_destroy_part2+0x136/0x160 [mac80211]
[ 1497.044633] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.044658]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.044662] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.044663] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.044664] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.044686] RIP: 0010:__sta_info_destroy_part2+0x136/0x160 [mac80211]
[ 1497.044709] Code: bb d4 00 00 00 00 0f 84 69 ff ff ff 45 31 c0 b9 01 00 0=
0 00 48 89 da 4c 89 e6 48 89 ef e8 d2 8b ff ff 85 c0 0f 84 4b ff ff ff <0f> 0=
b e9 44 ff ff ff be 03 00 00 00 48 89 df e8 76 e8 ff ff 85 c0
[ 1497.044710] RSP: 0018:ffffbc8ad6a47978 EFLAGS: 00010282
[ 1497.044711] RAX: 00000000fffffffb RBX: ffff9ac7c0dc2000 RCX: 000000000000=
0001
[ 1497.044712] RDX: 0000000000000000 RSI: ffff9ac7c73249c0 RDI: ffff9ac7e754=
88e0
[ 1497.044712] RBP: ffff9ac7e75488e0 R08: 0000000000000000 R09: 000000000020=
0016
[ 1497.044713] R10: ffff9ac7c7325848 R11: ffff9ac7c73249c0 R12: ffff9ac7c732=
49c0
[ 1497.044714] R13: 0000000000000000 R14: ffff9ac7c73249c0 R15: ffff9ac7e754=
8f28
[ 1497.044714] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.044715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.044715] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.044716] PKRU: 55555554
[ 1497.044717] Call Trace:
[ 1497.044717]  <TASK>
[ 1497.044717]  ? __sta_info_destroy_part2+0x136/0x160 [mac80211]
[ 1497.044741]  ? __warn+0x81/0x130
[ 1497.044742]  ? __sta_info_destroy_part2+0x136/0x160 [mac80211]
[ 1497.044766]  ? report_bug+0x171/0x1a0
[ 1497.044767]  ? handle_bug+0x3c/0x80
[ 1497.044769]  ? exc_invalid_op+0x17/0x70
[ 1497.044770]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.044773]  ? __sta_info_destroy_part2+0x136/0x160 [mac80211]
[ 1497.044796]  ? __sta_info_destroy_part2+0x12e/0x160 [mac80211]
[ 1497.044820]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.044844]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.044869]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.044898]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.044922]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.044945]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.044968]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.044990]  ? _dev_err+0x79/0xa0
[ 1497.044992]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.045016]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.045026]  ? rtnl_is_locked+0x15/0x20
[ 1497.045028]  ? inetdev_event+0x3d/0x6a0
[ 1497.045030]  raw_notifier_call_chain+0x45/0x60
[ 1497.045031]  __dev_close_many+0x5f/0x110
[ 1497.045033]  dev_close_many+0x8f/0x150
[ 1497.045035]  dev_close+0x83/0xb0
[ 1497.045036]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.045057]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.045080]  process_one_work+0x1c4/0x3d0
[ 1497.045081]  worker_thread+0x51/0x390
[ 1497.045082]  ? __pfx_worker_thread+0x10/0x10
[ 1497.045083]  kthread+0xdb/0x110
[ 1497.045085]  ? __pfx_kthread+0x10/0x10
[ 1497.045086]  ret_from_fork+0x29/0x50
[ 1497.045089]  </TASK>
[ 1497.045089] ---[ end trace 0000000000000000 ]---
[ 1497.045090] ------------[ cut here ]------------
[ 1497.045091] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.045098] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:555 s=
ta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045123] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.045148]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.045152] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.045153] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.045154] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.045176] RIP: 0010:sta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045201] Code: ff ff 49 8b 85 70 07 00 00 49 8d b5 90 07 00 00 48 c7 c=
7 e0 bc c1 c1 c6 05 fe 6f 10 00 01 48 85 c0 48 0f 45 f0 e8 d3 36 5a cc <0f> 0=
b e9 44 f6 ff ff 48 83 f9 04 0f 84 9c 00 00 00 48 83 f9 06 75
[ 1497.045202] RSP: 0018:ffffbc8ad6a47928 EFLAGS: 00010286
[ 1497.045202] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.045203] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.045204] RBP: ffffdc8abe747310 R08: 0000000000000000 R09: ffffbc8ad6a4=
77b8
[ 1497.045204] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000000=
0001
[ 1497.045205] R13: ffff9ac7c73249c0 R14: ffff9ac7c0dc2000 R15: ffff9ac99ece=
5000
[ 1497.045205] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.045206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.045207] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.045207] PKRU: 55555554
[ 1497.045208] Call Trace:
[ 1497.045208]  <TASK>
[ 1497.045209]  ? sta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045233]  ? __warn+0x81/0x130
[ 1497.045235]  ? sta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045259]  ? report_bug+0x171/0x1a0
[ 1497.045260]  ? prb_read_valid+0x1b/0x30
[ 1497.045261]  ? handle_bug+0x3c/0x80
[ 1497.045263]  ? exc_invalid_op+0x17/0x70
[ 1497.045265]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.045267]  ? sta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045294]  ? sta_set_sinfo+0xa7d/0xbb0 [mac80211]
[ 1497.045318]  __sta_info_destroy_part2+0xaf/0x160 [mac80211]
[ 1497.045343]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.045369]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.045395]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.045421]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.045444]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.045466]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.045489]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.045512]  ? _dev_err+0x79/0xa0
[ 1497.045513]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.045537]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.045548]  ? rtnl_is_locked+0x15/0x20
[ 1497.045549]  ? inetdev_event+0x3d/0x6a0
[ 1497.045551]  raw_notifier_call_chain+0x45/0x60
[ 1497.045552]  __dev_close_many+0x5f/0x110
[ 1497.045554]  dev_close_many+0x8f/0x150
[ 1497.045556]  dev_close+0x83/0xb0
[ 1497.045557]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.045578]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.045601]  process_one_work+0x1c4/0x3d0
[ 1497.045602]  worker_thread+0x51/0x390
[ 1497.045603]  ? __pfx_worker_thread+0x10/0x10
[ 1497.045604]  kthread+0xdb/0x110
[ 1497.045606]  ? __pfx_kthread+0x10/0x10
[ 1497.045607]  ret_from_fork+0x29/0x50
[ 1497.045610]  </TASK>
[ 1497.045610] ---[ end trace 0000000000000000 ]---
[ 1497.045711] ------------[ cut here ]------------
[ 1497.045711] WARNING: CPU: 17 PID: 4288 at net/mac80211/sta_info.c:417 sta=
_info_free+0xab/0x120 [mac80211]
[ 1497.045742] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.045768]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.045772] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.045773] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.045774] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.045796] RIP: 0010:sta_info_free+0xab/0x120 [mac80211]
[ 1497.045820] Code: 0a 00 00 e8 f7 cf 80 cc 48 8b bd a8 00 00 00 e8 eb cf 8=
0 cc 48 8b bd 00 07 00 00 e8 2f 84 80 cc 48 89 ef 5b 5d e9 d5 cf 80 cc <0f> 0=
b 83 ee 01 48 89 ef e8 a8 fc ff ff 85 c0 75 2c 8b b5 d8 00 00
[ 1497.045821] RSP: 0018:ffffbc8ad6a47980 EFLAGS: 00010206
[ 1497.045822] RAX: 000000000410018b RBX: 000000000000000f RCX: 000000000000=
0000
[ 1497.045823] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff9ac7e754=
88e0
[ 1497.045823] RBP: ffff9ac7c0dc2000 R08: 0000000000000001 R09: 000000001e79=
f215
[ 1497.045824] R10: ffffffff900060f8 R11: ffffbc8ac0620ff8 R12: ffffbc8ad6a4=
79b8
[ 1497.045825] R13: 0000000000000000 R14: ffff9ac7c73249c0 R15: ffff9ac7e754=
8f28
[ 1497.045825] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.045826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.045827] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.045827] PKRU: 55555554
[ 1497.045828] Call Trace:
[ 1497.045828]  <TASK>
[ 1497.045830]  ? sta_info_free+0xab/0x120 [mac80211]
[ 1497.045856]  ? __warn+0x81/0x130
[ 1497.045858]  ? sta_info_free+0xab/0x120 [mac80211]
[ 1497.045883]  ? report_bug+0x171/0x1a0
[ 1497.045884]  ? handle_bug+0x3c/0x80
[ 1497.045885]  ? exc_invalid_op+0x17/0x70
[ 1497.045887]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.045889]  ? sta_info_free+0xab/0x120 [mac80211]
[ 1497.045914]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.045943]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.045968]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.045993]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.046016]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.046037]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.046059]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.046081]  ? _dev_err+0x79/0xa0
[ 1497.046083]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.046106]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.046116]  ? rtnl_is_locked+0x15/0x20
[ 1497.046117]  ? inetdev_event+0x3d/0x6a0
[ 1497.046119]  raw_notifier_call_chain+0x45/0x60
[ 1497.046121]  __dev_close_many+0x5f/0x110
[ 1497.046122]  dev_close_many+0x8f/0x150
[ 1497.046124]  dev_close+0x83/0xb0
[ 1497.046125]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.046146]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.046168]  process_one_work+0x1c4/0x3d0
[ 1497.046169]  worker_thread+0x51/0x390
[ 1497.046170]  ? __pfx_worker_thread+0x10/0x10
[ 1497.046171]  kthread+0xdb/0x110
[ 1497.046173]  ? __pfx_kthread+0x10/0x10
[ 1497.046174]  ret_from_fork+0x29/0x50
[ 1497.046176]  </TASK>
[ 1497.046177] ---[ end trace 0000000000000000 ]---
[ 1497.046177] ------------[ cut here ]------------
[ 1497.046178] sta_info_move_state() returned -5
[ 1497.046185] WARNING: CPU: 17 PID: 4288 at net/mac80211/sta_info.c:420 sta=
_info_free+0x10a/0x120 [mac80211]
[ 1497.046209] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.046233]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.046237] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.046238] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.046238] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.046260] RIP: 0010:sta_info_free+0x10a/0x120 [mac80211]
[ 1497.046286] Code: 7c fc ff ff 85 c0 74 d4 80 3d 5d 81 10 00 00 0f 85 4b f=
f ff ff 89 c6 48 c7 c7 50 bd c1 c1 c6 05 47 81 10 00 01 e8 26 48 5a cc <0f> 0=
b e9 2f ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
[ 1497.046287] RSP: 0018:ffffbc8ad6a47980 EFLAGS: 00010282
[ 1497.046288] RAX: 0000000000000000 RBX: 000000000000000f RCX: 000000000000=
0027
[ 1497.046288] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.046289] RBP: ffff9ac7c0dc2000 R08: 0000000000000000 R09: ffffbc8ad6a4=
7810
[ 1497.046289] R10: 0000000000000003 R11: ffffffff90146108 R12: ffffbc8ad6a4=
79b8
[ 1497.046290] R13: 0000000000000000 R14: ffff9ac7c73249c0 R15: ffff9ac7e754=
8f28
[ 1497.046291] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.046291] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.046292] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.046293] PKRU: 55555554
[ 1497.046293] Call Trace:
[ 1497.046293]  <TASK>
[ 1497.046294]  ? sta_info_free+0x10a/0x120 [mac80211]
[ 1497.046317]  ? __warn+0x81/0x130
[ 1497.046319]  ? sta_info_free+0x10a/0x120 [mac80211]
[ 1497.046342]  ? report_bug+0x171/0x1a0
[ 1497.046343]  ? prb_read_valid+0x1b/0x30
[ 1497.046345]  ? handle_bug+0x3c/0x80
[ 1497.046346]  ? exc_invalid_op+0x17/0x70
[ 1497.046348]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.046350]  ? sta_info_free+0x10a/0x120 [mac80211]
[ 1497.046374]  __sta_info_flush+0x14b/0x1b0 [mac80211]
[ 1497.046398]  ieee80211_set_disassoc+0x16c/0x620 [mac80211]
[ 1497.046424]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.046448]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.046470]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.046492]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.046514]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.046536]  ? _dev_err+0x79/0xa0
[ 1497.046537]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.046561]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.046570]  ? rtnl_is_locked+0x15/0x20
[ 1497.046572]  ? inetdev_event+0x3d/0x6a0
[ 1497.046574]  raw_notifier_call_chain+0x45/0x60
[ 1497.046575]  __dev_close_many+0x5f/0x110
[ 1497.046577]  dev_close_many+0x8f/0x150
[ 1497.046579]  dev_close+0x83/0xb0
[ 1497.046580]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.046601]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.046623]  process_one_work+0x1c4/0x3d0
[ 1497.046624]  worker_thread+0x51/0x390
[ 1497.046625]  ? __pfx_worker_thread+0x10/0x10
[ 1497.046626]  kthread+0xdb/0x110
[ 1497.046627]  ? __pfx_kthread+0x10/0x10
[ 1497.046629]  ret_from_fork+0x29/0x50
[ 1497.046631]  </TASK>
[ 1497.046632] ---[ end trace 0000000000000000 ]---
[ 1497.046635] ------------[ cut here ]------------
[ 1497.046635] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.046642] WARNING: CPU: 17 PID: 4288 at net/mac80211/main.c:235 ieee802=
11_bss_info_change_notify+0x2a4/0x2b0 [mac80211]
[ 1497.046665] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.046690]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.046694] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.046695] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.046695] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.046717] RIP: 0010:ieee80211_bss_info_change_notify+0x2a4/0x2b0 [mac80=
211]
[ 1497.046739] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 68 bb c1 c1 c6 05 fa 09 11 00 01 48 85 c0 48 0f 45 f0 e8 ec d0 5a cc <0f> 0=
b e9 9e fd ff ff 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
[ 1497.046740] RSP: 0018:ffffbc8ad6a479d8 EFLAGS: 00010282
[ 1497.046740] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.046741] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.046742] RBP: 000000000080309f R08: 0000000000000000 R09: ffffbc8ad6a4=
7868
[ 1497.046742] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
88e0
[ 1497.046743] R13: 0000000000000001 R14: ffff9ac7e7549b10 R15: ffff9ac7c732=
49c0
[ 1497.046743] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.046744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.046745] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.046745] PKRU: 55555554
[ 1497.046746] Call Trace:
[ 1497.046746]  <TASK>
[ 1497.046747]  ? ieee80211_bss_info_change_notify+0x2a4/0x2b0 [mac80211]
[ 1497.046769]  ? __warn+0x81/0x130
[ 1497.046771]  ? ieee80211_bss_info_change_notify+0x2a4/0x2b0 [mac80211]
[ 1497.046793]  ? report_bug+0x171/0x1a0
[ 1497.046794]  ? prb_read_valid+0x1b/0x30
[ 1497.046795]  ? handle_bug+0x3c/0x80
[ 1497.046797]  ? exc_invalid_op+0x17/0x70
[ 1497.046798]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.046800]  ? ieee80211_bss_info_change_notify+0x2a4/0x2b0 [mac80211]
[ 1497.046823]  ? ieee80211_bss_info_change_notify+0x2a4/0x2b0 [mac80211]
[ 1497.046845]  ieee80211_set_disassoc+0x2e9/0x620 [mac80211]
[ 1497.046872]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.046897]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.046919]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.046941]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.046963]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.046984]  ? _dev_err+0x79/0xa0
[ 1497.046986]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.047009]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.047019]  ? rtnl_is_locked+0x15/0x20
[ 1497.047020]  ? inetdev_event+0x3d/0x6a0
[ 1497.047022]  raw_notifier_call_chain+0x45/0x60
[ 1497.047024]  __dev_close_many+0x5f/0x110
[ 1497.047025]  dev_close_many+0x8f/0x150
[ 1497.047027]  dev_close+0x83/0xb0
[ 1497.047028]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.047049]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.047071]  process_one_work+0x1c4/0x3d0
[ 1497.047072]  worker_thread+0x51/0x390
[ 1497.047073]  ? __pfx_worker_thread+0x10/0x10
[ 1497.047074]  kthread+0xdb/0x110
[ 1497.047075]  ? __pfx_kthread+0x10/0x10
[ 1497.047077]  ret_from_fork+0x29/0x50
[ 1497.047079]  </TASK>
[ 1497.047080] ---[ end trace 0000000000000000 ]---
[ 1497.047082] ------------[ cut here ]------------
[ 1497.047082] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.047089] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:193 d=
rv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047113] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.047137]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.047142] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.047142] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.047143] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.047165] RIP: 0010:drv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047188] Code: ff ff 49 8b 85 70 07 00 00 49 8d b5 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 9d d7 10 00 01 48 85 c0 48 0f 45 f0 e8 80 9e 5a cc <0f> 0=
b eb ad 80 3d 85 d7 10 00 00 75 c0 0f b7 4d 04 0f b7 d0 49 8d
[ 1497.047188] RSP: 0018:ffffbc8ad6a47958 EFLAGS: 00010286
[ 1497.047189] RAX: 0000000000000000 RBX: ffff9ac7c7325848 RCX: 000000000000=
0027
[ 1497.047190] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.047190] RBP: ffffbc8ad6a479ba R08: 0000000000000000 R09: ffffbc8ad6a4=
77e8
[ 1497.047191] R10: 0000000000000003 R11: ffffffff90146108 R12: 000000000000=
0000
[ 1497.047192] R13: ffff9ac7c73249c0 R14: ffff9ac7e75488e0 R15: 000000000000=
0000
[ 1497.047192] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.047193] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.047194] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.047194] PKRU: 55555554
[ 1497.047195] Call Trace:
[ 1497.047195]  <TASK>
[ 1497.047196]  ? drv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047218]  ? __warn+0x81/0x130
[ 1497.047220]  ? drv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047243]  ? report_bug+0x171/0x1a0
[ 1497.047244]  ? prb_read_valid+0x1b/0x30
[ 1497.047245]  ? handle_bug+0x3c/0x80
[ 1497.047247]  ? exc_invalid_op+0x17/0x70
[ 1497.047248]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.047251]  ? drv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047274]  ? drv_conf_tx+0x1c0/0x200 [mac80211]
[ 1497.047299]  ieee80211_set_wmm_default+0x261/0x3a0 [mac80211]
[ 1497.047328]  ieee80211_set_disassoc+0x2f9/0x620 [mac80211]
[ 1497.047354]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.047380]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.047403]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.047425]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.047447]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.047468]  ? _dev_err+0x79/0xa0
[ 1497.047470]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.047497]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.047507]  ? rtnl_is_locked+0x15/0x20
[ 1497.047508]  ? inetdev_event+0x3d/0x6a0
[ 1497.047511]  raw_notifier_call_chain+0x45/0x60
[ 1497.047512]  __dev_close_many+0x5f/0x110
[ 1497.047513]  dev_close_many+0x8f/0x150
[ 1497.047515]  dev_close+0x83/0xb0
[ 1497.047517]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.047537]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.047559]  process_one_work+0x1c4/0x3d0
[ 1497.047561]  worker_thread+0x51/0x390
[ 1497.047562]  ? __pfx_worker_thread+0x10/0x10
[ 1497.047563]  kthread+0xdb/0x110
[ 1497.047564]  ? __pfx_kthread+0x10/0x10
[ 1497.047566]  ret_from_fork+0x29/0x50
[ 1497.047568]  </TASK>
[ 1497.047569] ---[ end trace 0000000000000000 ]---
[ 1497.047570] ------------[ cut here ]------------
[ 1497.047570] wlp11s0: Failed check-sdata-in-driver check, flags: 0x0
[ 1497.047577] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:316 d=
rv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047601] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.047626]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.047630] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.047631] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.047632] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.047653] RIP: 0010:drv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047677] Code: ff ff 48 8b 83 70 07 00 00 48 8d b3 90 07 00 00 48 c7 c=
7 f8 bb c1 c1 c6 05 5e cf 10 00 01 48 85 c0 48 0f 45 f0 e8 48 96 5a cc <0f> 0=
b e9 1e ff ff ff 0f 0b e9 ff fe ff ff 66 2e 0f 1f 84 00 00 00
[ 1497.047678] RSP: 0018:ffffbc8ad6a47948 EFLAGS: 00010282
[ 1497.047678] RAX: 0000000000000000 RBX: ffff9ac7c73249c0 RCX: 000000000000=
0027
[ 1497.047679] RDX: ffff9acf17a61548 RSI: 0000000000000001 RDI: ffff9acf17a6=
1540
[ 1497.047680] RBP: ffff9ac804b14900 R08: 0000000000000000 R09: ffffbc8ad6a4=
77d8
[ 1497.047680] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7e754=
88e0
[ 1497.047681] R13: ffff9ac7c7325c48 R14: ffff9ac7c7325848 R15: ffff9ac804b1=
4900
[ 1497.047682] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.047683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.047683] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.047684] PKRU: 55555554
[ 1497.047684] Call Trace:
[ 1497.047685]  <TASK>
[ 1497.047685]  ? drv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047709]  ? __warn+0x81/0x130
[ 1497.047711]  ? drv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047734]  ? report_bug+0x171/0x1a0
[ 1497.047735]  ? prb_read_valid+0x1b/0x30
[ 1497.047737]  ? handle_bug+0x3c/0x80
[ 1497.047738]  ? exc_invalid_op+0x17/0x70
[ 1497.047740]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.047742]  ? drv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047765]  ? drv_unassign_vif_chanctx+0x158/0x170 [mac80211]
[ 1497.047788]  ieee80211_assign_link_chanctx+0x56/0x230 [mac80211]
[ 1497.047816]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[ 1497.047840]  ieee80211_link_release_channel+0x3f/0x60 [mac80211]
[ 1497.047864]  ieee80211_set_disassoc+0x38e/0x620 [mac80211]
[ 1497.047893]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.047920]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.047944]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.047968]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.047992]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.048016]  ? _dev_err+0x79/0xa0
[ 1497.048018]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.048043]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.048053]  ? rtnl_is_locked+0x15/0x20
[ 1497.048054]  ? inetdev_event+0x3d/0x6a0
[ 1497.048057]  raw_notifier_call_chain+0x45/0x60
[ 1497.048058]  __dev_close_many+0x5f/0x110
[ 1497.048059]  dev_close_many+0x8f/0x150
[ 1497.048061]  dev_close+0x83/0xb0
[ 1497.048063]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.048085]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.048108]  process_one_work+0x1c4/0x3d0
[ 1497.048109]  worker_thread+0x51/0x390
[ 1497.048110]  ? __pfx_worker_thread+0x10/0x10
[ 1497.048111]  kthread+0xdb/0x110
[ 1497.048113]  ? __pfx_kthread+0x10/0x10
[ 1497.048114]  ret_from_fork+0x29/0x50
[ 1497.048117]  </TASK>
[ 1497.048118] ---[ end trace 0000000000000000 ]---
[ 1497.048126] ------------[ cut here ]------------
[ 1497.048126] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.h:888 i=
eee80211_del_chanctx+0x16d/0x180 [mac80211]
[ 1497.048153] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.048180]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.048184] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.048185] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.048186] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.048209] RIP: 0010:ieee80211_del_chanctx+0x16d/0x180 [mac80211]
[ 1497.048234] Code: 1c 48 3e 0f 85 49 ff ff ff 0f 1f 44 00 00 e9 3f ff ff f=
f e8 85 2f d3 ff 48 8b bb 80 13 00 00 89 83 88 13 00 00 e9 c0 fe ff ff <0f> 0=
b e9 03 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
[ 1497.048235] RSP: 0018:ffffbc8ad6a47998 EFLAGS: 00010246
[ 1497.048236] RAX: 0000000000000000 RBX: ffff9ac7e75488e0 RCX: ffff9ac7e754=
9c88
[ 1497.048237] RDX: 0000000080000000 RSI: ffff9ac804b14900 RDI: ffff9ac7e754=
88e0
[ 1497.048237] RBP: ffff9ac804b14900 R08: ffff9ac804b14930 R09: ffffbc8ad6a4=
77d8
[ 1497.048238] R10: 0000000000000003 R11: ffffffff90146108 R12: ffff9ac7c732=
5848
[ 1497.048239] R13: ffff9ac804b14958 R14: ffff9ac7e7549b10 R15: ffff9ac7c732=
49c0
[ 1497.048240] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.048241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.048241] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.048242] PKRU: 55555554
[ 1497.048243] Call Trace:
[ 1497.048243]  <TASK>
[ 1497.048244]  ? ieee80211_del_chanctx+0x16d/0x180 [mac80211]
[ 1497.048269]  ? __warn+0x81/0x130
[ 1497.048270]  ? ieee80211_del_chanctx+0x16d/0x180 [mac80211]
[ 1497.048297]  ? report_bug+0x171/0x1a0
[ 1497.048299]  ? handle_bug+0x3c/0x80
[ 1497.048300]  ? exc_invalid_op+0x17/0x70
[ 1497.048302]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.048304]  ? ieee80211_del_chanctx+0x16d/0x180 [mac80211]
[ 1497.048330]  ? ieee80211_del_chanctx+0x89/0x180 [mac80211]
[ 1497.048355]  ieee80211_free_chanctx+0x91/0xc0 [mac80211]
[ 1497.048381]  __ieee80211_link_release_channel+0xea/0x120 [mac80211]
[ 1497.048406]  ieee80211_link_release_channel+0x3f/0x60 [mac80211]
[ 1497.048431]  ieee80211_set_disassoc+0x38e/0x620 [mac80211]
[ 1497.048458]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.048484]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.048508]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.048531]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.048554]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.048577]  ? _dev_err+0x79/0xa0
[ 1497.048579]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.048604]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.048615]  ? rtnl_is_locked+0x15/0x20
[ 1497.048616]  ? inetdev_event+0x3d/0x6a0
[ 1497.048618]  raw_notifier_call_chain+0x45/0x60
[ 1497.048620]  __dev_close_many+0x5f/0x110
[ 1497.048622]  dev_close_many+0x8f/0x150
[ 1497.048624]  dev_close+0x83/0xb0
[ 1497.048625]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.048647]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.048670]  process_one_work+0x1c4/0x3d0
[ 1497.048672]  worker_thread+0x51/0x390
[ 1497.048673]  ? __pfx_worker_thread+0x10/0x10
[ 1497.048674]  kthread+0xdb/0x110
[ 1497.048675]  ? __pfx_kthread+0x10/0x10
[ 1497.048677]  ret_from_fork+0x29/0x50
[ 1497.048679]  </TASK>
[ 1497.048680] ---[ end trace 0000000000000000 ]---
[ 1497.048688] ------------[ cut here ]------------
[ 1497.048688] WARNING: CPU: 17 PID: 4288 at drivers/net/wireless/intel/iwlw=
ifi/mvm/../iwl-trans.h:1362 iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]=

[ 1497.048702] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.048728]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.048733] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.048734] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.048734] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.048757] RIP: 0010:iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
[ 1497.048767] Code: c3 28 49 39 dd 75 b4 31 c0 5b 5d 41 5c 41 5d 41 5e c3 c=
c cc cc cc 0f 0b b8 f4 fd ff ff 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f> 0=
b 48 8b 7f 40 48 c7 c1 a0 5b 53 c1 48 c7 c2 bf 61 54 c1 31 f6
[ 1497.048768] RSP: 0018:ffffbc8ad6a478e0 EFLAGS: 00010293
[ 1497.048769] RAX: ffffffffc47ad9a0 RBX: ffff9ac7c0dc2d10 RCX: 000000000000=
0000
[ 1497.048770] RDX: 0000000000000001 RSI: 0000000000000005 RDI: ffff9ac7c9eb=
0028
[ 1497.048770] RBP: 0000000000000005 R08: 0000000000000000 R09: ffffbc8ad6a4=
77d8
[ 1497.048771] R10: 000000000000000f R11: ffffffff90146108 R12: ffff9ac7c0dc=
2cfc
[ 1497.048772] R13: ffff9ac7c0dc2e78 R14: ffff9ac7e754a088 R15: 000000000000=
0000
[ 1497.048772] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.048773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.048774] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.048775] PKRU: 55555554
[ 1497.048775] Call Trace:
[ 1497.048776]  <TASK>
[ 1497.048776]  ? iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
[ 1497.048786]  ? __warn+0x81/0x130
[ 1497.048788]  ? iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
[ 1497.048798]  ? report_bug+0x171/0x1a0
[ 1497.048800]  ? handle_bug+0x3c/0x80
[ 1497.048801]  ? exc_invalid_op+0x17/0x70
[ 1497.048803]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.048805]  ? __pfx_iwl_trans_pcie_wait_txq_empty+0x10/0x10 [iwlwifi]
[ 1497.048816]  ? iwl_mvm_wait_sta_queues_empty+0x92/0xc0 [iwlmvm]
[ 1497.048827]  iwl_mvm_mac_flush+0x2a0/0x2e0 [iwlmvm]
[ 1497.048837]  ? ieee80211_stop_queues_by_reason+0x73/0x90 [mac80211]
[ 1497.048866]  __ieee80211_flush_queues+0xaf/0x240 [mac80211]
[ 1497.048893]  __ieee80211_recalc_idle+0xce/0x110 [mac80211]
[ 1497.048925]  ieee80211_recalc_idle+0x14/0x30 [mac80211]
[ 1497.048949]  ieee80211_free_chanctx+0x91/0xc0 [mac80211]
[ 1497.048975]  __ieee80211_link_release_channel+0xea/0x120 [mac80211]
[ 1497.048999]  ieee80211_link_release_channel+0x3f/0x60 [mac80211]
[ 1497.049023]  ieee80211_set_disassoc+0x38e/0x620 [mac80211]
[ 1497.049050]  ieee80211_mgd_deauth+0x13f/0x3d0 [mac80211]
[ 1497.049075]  cfg80211_mlme_deauth+0xba/0x1e0 [cfg80211]
[ 1497.049099]  cfg80211_mlme_down+0x65/0x90 [cfg80211]
[ 1497.049121]  cfg80211_disconnect+0x180/0x1f0 [cfg80211]
[ 1497.049144]  cfg80211_netdev_notifier_call+0x141/0x4b0 [cfg80211]
[ 1497.049166]  ? _dev_err+0x79/0xa0
[ 1497.049168]  ? drv_remove_interface+0x114/0x120 [mac80211]
[ 1497.049192]  ? __iwl_err+0x125/0x130 [iwlwifi]
[ 1497.049202]  ? rtnl_is_locked+0x15/0x20
[ 1497.049203]  ? inetdev_event+0x3d/0x6a0
[ 1497.049205]  raw_notifier_call_chain+0x45/0x60
[ 1497.049207]  __dev_close_many+0x5f/0x110
[ 1497.049208]  dev_close_many+0x8f/0x150
[ 1497.049210]  dev_close+0x83/0xb0
[ 1497.049211]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.049232]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.049255]  process_one_work+0x1c4/0x3d0
[ 1497.049256]  worker_thread+0x51/0x390
[ 1497.049257]  ? __pfx_worker_thread+0x10/0x10
[ 1497.049258]  kthread+0xdb/0x110
[ 1497.049260]  ? __pfx_kthread+0x10/0x10
[ 1497.049261]  ret_from_fork+0x29/0x50
[ 1497.049264]  </TASK>
[ 1497.049264] ---[ end trace 0000000000000000 ]---
[ 1497.049265] iwlwifi 0000:0b:00.0: iwl_trans_wait_txq_empty bad state =3D 0=

[ 1497.049271] wlp11s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[ 1497.049297] wlp11s0: failed to remove key (5, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[ 1497.062309] ------------[ cut here ]------------
[ 1497.062310] WARNING: CPU: 17 PID: 4288 at net/mac80211/driver-ops.c:38 dr=
v_stop+0xf5/0x100 [mac80211]
[ 1497.062335] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer su=
nrpc nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv=
4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
p_set nf_tables nfnetlink qrtr bnep binfmt_misc vfat fat iwlmvm mac80211 snd=
_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 sn=
d_usb_audio snd_hda_codec intel_rapl_msr intel_rapl_common snd_usbmidi_lib s=
nd_hda_core snd_rawmidi edac_mce_amd mc btusb snd_hwdep kvm_amd snd_seq snd_=
seq_device btrtl asus_nb_wmi btbcm iwlwifi snd_pcm asus_wmi btintel kvm btmt=
k snd_timer ledtrig_audio sparse_keymap irqbypass cfg80211 bluetooth snd pla=
tform_profile rapl wmi_bmof pcspkr i2c_piix4 k10temp rfkill soundcore joydev=
 gpio_amdpt gpio_generic acpi_cpufreq loop zram amdgpu i2c_algo_bit drm_ttm_=
helper ttm iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy pol=
yval_clmulni polyval_generic gpu_sched nvme
[ 1497.062361]  ghash_clmulni_intel ccp drm_display_helper nvme_core sha512_=
ssse3 igc sp5100_tco cec nvme_common video wmi ip6_tables ip_tables fuse
[ 1497.062365] CPU: 17 PID: 4288 Comm: kworker/17:0 Tainted: G        W    L=
     6.3.11-200.fc38.x86_64 #1
[ 1497.062367] Hardware name: ASUS System Product Name/ROG STRIX X670E-E GAM=
ING WIFI, BIOS 1416 05/16/2023
[ 1497.062367] Workqueue: events_freezable ieee80211_restart_work [mac80211]=

[ 1497.062389] RIP: 0010:drv_stop+0xf5/0x100 [mac80211]
[ 1497.062407] Code: 11 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 62 fc 04 0=
0 65 ff 0d 13 e9 4c 3e 0f 85 39 ff ff ff 0f 1f 44 00 00 e9 2f ff ff ff <0f> 0=
b 5b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
[ 1497.062408] RSP: 0018:ffffbc8ad6a47cd0 EFLAGS: 00010246
[ 1497.062409] RAX: 0000000000000000 RBX: ffff9ac7e75488e0 RCX: ffff9ac804b5=
2e68
[ 1497.062410] RDX: 0000000080000000 RSI: 0000000000000282 RDI: ffff9ac7e754=
88e0
[ 1497.062410] RBP: ffff9ac7e7549b10 R08: ffff9ac7c04034a0 R09: ffffffff9005=
d6e0
[ 1497.062411] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac7e754=
88e0
[ 1497.062411] R13: ffff9ac7c7325bf0 R14: ffff9ac7e75491e0 R15: 000000000000=
0000
[ 1497.062411] FS:  0000000000000000(0000) GS:ffff9acf17a40000(0000) knlGS:0=
000000000000000
[ 1497.062412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1497.062413] CR2: 0000556612f51560 CR3: 0000000851022000 CR4: 000000000075=
0ee0
[ 1497.062413] PKRU: 55555554
[ 1497.062413] Call Trace:
[ 1497.062414]  <TASK>
[ 1497.062414]  ? drv_stop+0xf5/0x100 [mac80211]
[ 1497.062427]  ? __warn+0x81/0x130
[ 1497.062429]  ? drv_stop+0xf5/0x100 [mac80211]
[ 1497.062442]  ? report_bug+0x171/0x1a0
[ 1497.062443]  ? handle_bug+0x3c/0x80
[ 1497.062444]  ? exc_invalid_op+0x17/0x70
[ 1497.062445]  ? asm_exc_invalid_op+0x1a/0x20
[ 1497.062447]  ? drv_stop+0xf5/0x100 [mac80211]
[ 1497.062460]  ieee80211_do_stop+0x5c9/0x890 [mac80211]
[ 1497.062476]  ieee80211_stop+0x4d/0x180 [mac80211]
[ 1497.062490]  __dev_close_many+0x9b/0x110
[ 1497.062491]  dev_close_many+0x8f/0x150
[ 1497.062492]  dev_close+0x83/0xb0
[ 1497.062493]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
[ 1497.062505]  ieee80211_restart_work+0x120/0x150 [mac80211]
[ 1497.062518]  process_one_work+0x1c4/0x3d0
[ 1497.062519]  worker_thread+0x51/0x390
[ 1497.062520]  ? __pfx_worker_thread+0x10/0x10
[ 1497.062520]  kthread+0xdb/0x110
[ 1497.062521]  ? __pfx_kthread+0x10/0x10
[ 1497.062522]  ret_from_fork+0x29/0x50
[ 1497.062524]  </TASK>
[ 1497.062524] ---[ end trace 0000000000000000 ]---

--Apple-Mail-556BA95D-9864-4713-964A-6D8F27E6F8BE
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit





--Apple-Mail-556BA95D-9864-4713-964A-6D8F27E6F8BE--
