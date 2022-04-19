Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D280506A69
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiDSLgO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiDSLgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 07:36:13 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1D2E9C9
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 04:33:27 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650368006; bh=5kuylz8NW4PjljUjWkD/1sMJZao4Le8z02BJk3TZqnw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QbUn6+C0HAD4RUuysULMMJsGIkdmKBbL3UX5WPA+M3IroWe7hgwAUWp+OzMtTARVP
         DGwASAR9Zz7M2KKFpOrsCI5eaeaNQqITN3xBDaME5VOLjfBZV/Q35Gg5hBMvtKlDmO
         4yA69LyLj6/m4JHagIIFzeK8coXZgDd6o0EgfxGDMttyFMuCKm51QjuBpqhax+gIxo
         zy2y7Fc1sr9yUFoAj4ZDLy/aBplSni9snOuddamEezF3o++drVKPVuQ2F//RYjVeoI
         gnCfW5hEygfXnWFqahuc9szU09+Rf0uVwK6VkXRRD4ncBfoqTTd9YKB5KGtSTr3uy0
         iCIl0EyqVwVMA==
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
 <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
 <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
 <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
Date:   Tue, 19 Apr 2022 13:33:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mtghs3y2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

> On Tue, 2022-04-19 at 09:41 +0300, Grumbach, Emmanuel wrote:
>> Hi Toke,
>>=20
>> On Tue, 2022-04-19 at 06:24 +0000, Coelho, Luciano wrote:
>> > On Mon, 2022-04-18 at 13:36 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > > Hi Luca
>> >=20
>> > Hi Toke,
>> >=20
>> > > I've started seeing issues with my iwlwifi interface going away after
>> > > suspend. I get errors like these in dmesg:
>> > >=20
>> > > [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by lo=
cal choice (Reason:
>> > > 3=3DDEAUTH_LEAVING)
>> > > [104393.347775] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1=
e865: Couldn't get ACK
>> > > from
>> > > CSME on HOST_GOES_DOWN message
>> > > [104393.347876] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1=
e865: failed to send the
>> > > SAP_ME_MSG_CHECK_SHARED_AREA message -19
>> > >=20
>> > > And when the host comes back up, there is no connectivity. Restarting
>> > > iwd fixes the problem.
>> > >=20
>> > > This is on a 5.17.3 kernel (Arch Linux distribution kernel), and lsp=
ci
>> > > says the WiFi device is an "Intel Corporation Wi-Fi 6 AX201".
>> > >=20
>> > > Any ideas? :)
>> >=20
>> > This seems to be related to iwlmei, so I added Emmanuel to the thread.
>> >=20
>>=20
>> Can we have the full dmesg output?
>> What NIC / platform do you have?
>> Do you have AMT configured in the BIOS?
>> Did you enable wireless operation in AMT?
>
> Ah - this is AX201, ok, but I still need the platform and thefull dmesg :=
-)

It's a Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS3HC26; AMT is set to
"Disabled" in the BIOS. I rebooted and did a suspend/wake cycle after
connecting to the WiFi network, which produced the dmesg below.

-Toke

[    0.000000] Linux version 5.17.3-arch1-1 (linux@archlinux) (gcc (GCC) 11=
.2.0, GNU ld (GNU Binutils) 2.38) #1 SMP PREEMPT Thu, 14 Apr 2022 01:18:36 =
+0000
[    0.000000] Command line: root=3D/dev/mapper/cryptroot rootflags=3Dsubvo=
l=3D/root init=3D/usr/lib/systemd/systemd cryptdevice=3D/dev/disk/by-uuid/x=
xxx-xxxx-xxxx-xxxx-xxxxxx:cryptroot:allow-discards rw quiet
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel=
 split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440=
 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008df6efff] usable
[    0.000000] BIOS-e820: [mem 0x000000008df6f000-0x0000000092f2efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000092f2f000-0x0000000093b2efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000093b2f000-0x0000000093bfefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x0000000093bff000-0x0000000093bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000093c00000-0x0000000097ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000099400000-0x00000000995fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000099e00000-0x00000000a07fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000085f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by Lenovo
[    0.000000] efi: ACPI=3D0x93bfe000 ACPI 2.0=3D0x93bfe014 SMBIOS=3D0x8fcb=
c000 SMBIOS 3.0=3D0x8fcaf000 TPMFinalLog=3D0x93990000 MEMATTR=3D0x8a432018 =
ESRT=3D0x87ec1c18 RNG=3D0x8fe2eb18 TPMEventLog=3D0x6cb68018=20
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: LENOVO 20XXS3HC26/20XXS3HC26, BIOS N32ET75W (1.51 ) 12/=
02/2021
[    0.000000] tsc: Detected 3000.000 MHz processor
[    0.000000] tsc: Detected 2995.200 MHz TSC
[    0.000006] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000008] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000012] last_pfn =3D 0x85f800 max_arch_pfn =3D 0x400000000
[    0.000157] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
=20=20
[    0.001195] last_pfn =3D 0x93c00 max_arch_pfn =3D 0x400000000
[    0.011509] esrt: Reserving ESRT space from 0x0000000087ec1c18 to 0x0000=
000087ec1e30.
[    0.011524] e820: update [mem 0x87ec1000-0x87ec1fff] usable =3D=3D> rese=
rved
[    0.011806] Using GB pages for direct mapping
[    0.011941] Secure boot enabled
[    0.011941] RAMDISK: [mem 0x65719000-0x6698bfff]
[    0.011945] ACPI: Early table checksum verification disabled
[    0.011949] ACPI: RSDP 0x0000000093BFE014 000024 (v02 LENOVO)
[    0.011953] ACPI: XSDT 0x0000000093BFC188 00012C (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011958] ACPI: FACP 0x000000008FC9D000 000114 (v06 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011964] ACPI: DSDT 0x000000008FC63000 0349A1 (v02 LENOVO ICL      00=
000002      01000013)
[    0.011967] ACPI: FACS 0x000000009396F000 000040
[    0.011970] ACPI: SSDT 0x000000008FD4A000 00255D (v02 LENOVO CpuSsdt  00=
003000 INTL 20191018)
[    0.011973] ACPI: SSDT 0x000000008FD49000 00059B (v02 LENOVO CtdpB    00=
001000 INTL 20191018)
[    0.011976] ACPI: SSDT 0x000000008FCCE000 00400C (v02 LENOVO DptfTabl 00=
001000 INTL 20191018)
[    0.011978] ACPI: SSDT 0x000000008FCA1000 00060E (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20191018)
[    0.011981] ACPI: TPM2 0x000000008FCA0000 00004C (v04 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011984] ACPI: SSDT 0x000000008FC9F000 000564 (v02 LENOVO PerfTune 00=
001000 INTL 20191018)
[    0.011987] ACPI: ECDT 0x000000008FC9E000 000053 (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011990] ACPI: HPET 0x000000008FC9C000 000038 (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011992] ACPI: APIC 0x000000008FC9B000 00012C (v04 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.011995] ACPI: SSDT 0x000000008FC9A000 0000F2 (v02 LENOVO PID1Ssdt 00=
000010 INTL 20191018)
[    0.011998] ACPI: SSDT 0x000000008FC98000 0014F8 (v02 LENOVO ProjSsdt 00=
000010 INTL 20191018)
[    0.012001] ACPI: SSDT 0x000000008FC60000 0028C0 (v02 LENOVO TglU_Rvp 00=
001000 INTL 20191018)
[    0.012004] ACPI: NHLT 0x000000008FC5E000 001B80 (v00 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012006] ACPI: SSDT 0x000000008FC5A000 002CD7 (v02 LENOVO SaSsdt   00=
003000 INTL 20191018)
[    0.012009] ACPI: SSDT 0x000000008FC56000 003573 (v02 LENOVO IgfxSsdt 00=
003000 INTL 20191018)
[    0.012012] ACPI: SSDT 0x000000008FC4A000 00B339 (v02 LENOVO TcssSsdt 00=
001000 INTL 20191018)
[    0.012015] ACPI: LPIT 0x000000008FC48000 0000CC (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012018] ACPI: WSMT 0x000000008FC47000 000028 (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012020] ACPI: SSDT 0x000000008FC46000 00012A (v02 LENOVO TbtTypeC 00=
000000 INTL 20191018)
[    0.012023] ACPI: DBGP 0x000000008FC45000 000034 (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012026] ACPI: DBG2 0x000000008FC44000 000054 (v00 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012033] ACPI: POAT 0x000000008FC43000 000055 (v03 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012038] ACPI: SSDT 0x000000008FC2C000 000B9C (v02 LENOVO UsbCTabl 00=
001000 INTL 20191018)
[    0.012040] ACPI: BATB 0x000000008FC2B000 00004A (v02 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012043] ACPI: DMAR 0x000000008E429000 0000B8 (v02 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012046] ACPI: MCFG 0x000000008E427000 00003C (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012049] ACPI: SSDT 0x000000008E426000 000144 (v02 LENOVO ADebTabl 00=
001000 INTL 20191018)
[    0.012052] ACPI: ASF! 0x000000008E425000 0000A0 (v32 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012054] ACPI: BGRT 0x000000008FC2D000 000038 (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012058] ACPI: PTDT 0x000000008E424000 000986 (v00 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012060] ACPI: UEFI 0x00000000930C3000 00008A (v01 LENOVO TP-N32   00=
001510 PTEC 00000002)
[    0.012063] ACPI: FPDT 0x000000008E423000 000034 (v01 LENOVO TP-N32   00=
001510 PTEC 00001510)
[    0.012065] ACPI: Reserving FACP table memory at [mem 0x8fc9d000-0x8fc9d=
113]
[    0.012068] ACPI: Reserving DSDT table memory at [mem 0x8fc63000-0x8fc97=
9a0]
[    0.012070] ACPI: Reserving FACS table memory at [mem 0x9396f000-0x9396f=
03f]
[    0.012072] ACPI: Reserving SSDT table memory at [mem 0x8fd4a000-0x8fd4c=
55c]
[    0.012074] ACPI: Reserving SSDT table memory at [mem 0x8fd49000-0x8fd49=
59a]
[    0.012076] ACPI: Reserving SSDT table memory at [mem 0x8fcce000-0x8fcd2=
00b]
[    0.012077] ACPI: Reserving SSDT table memory at [mem 0x8fca1000-0x8fca1=
60d]
[    0.012079] ACPI: Reserving TPM2 table memory at [mem 0x8fca0000-0x8fca0=
04b]
[    0.012081] ACPI: Reserving SSDT table memory at [mem 0x8fc9f000-0x8fc9f=
563]
[    0.012083] ACPI: Reserving ECDT table memory at [mem 0x8fc9e000-0x8fc9e=
052]
[    0.012085] ACPI: Reserving HPET table memory at [mem 0x8fc9c000-0x8fc9c=
037]
[    0.012087] ACPI: Reserving APIC table memory at [mem 0x8fc9b000-0x8fc9b=
12b]
[    0.012089] ACPI: Reserving SSDT table memory at [mem 0x8fc9a000-0x8fc9a=
0f1]
[    0.012091] ACPI: Reserving SSDT table memory at [mem 0x8fc98000-0x8fc99=
4f7]
[    0.012093] ACPI: Reserving SSDT table memory at [mem 0x8fc60000-0x8fc62=
8bf]
[    0.012095] ACPI: Reserving NHLT table memory at [mem 0x8fc5e000-0x8fc5f=
b7f]
[    0.012097] ACPI: Reserving SSDT table memory at [mem 0x8fc5a000-0x8fc5c=
cd6]
[    0.012098] ACPI: Reserving SSDT table memory at [mem 0x8fc56000-0x8fc59=
572]
[    0.012100] ACPI: Reserving SSDT table memory at [mem 0x8fc4a000-0x8fc55=
338]
[    0.012102] ACPI: Reserving LPIT table memory at [mem 0x8fc48000-0x8fc48=
0cb]
[    0.012104] ACPI: Reserving WSMT table memory at [mem 0x8fc47000-0x8fc47=
027]
[    0.012106] ACPI: Reserving SSDT table memory at [mem 0x8fc46000-0x8fc46=
129]
[    0.012108] ACPI: Reserving DBGP table memory at [mem 0x8fc45000-0x8fc45=
033]
[    0.012110] ACPI: Reserving DBG2 table memory at [mem 0x8fc44000-0x8fc44=
053]
[    0.012112] ACPI: Reserving POAT table memory at [mem 0x8fc43000-0x8fc43=
054]
[    0.012114] ACPI: Reserving SSDT table memory at [mem 0x8fc2c000-0x8fc2c=
b9b]
[    0.012116] ACPI: Reserving BATB table memory at [mem 0x8fc2b000-0x8fc2b=
049]
[    0.012118] ACPI: Reserving DMAR table memory at [mem 0x8e429000-0x8e429=
0b7]
[    0.012120] ACPI: Reserving MCFG table memory at [mem 0x8e427000-0x8e427=
03b]
[    0.012122] ACPI: Reserving SSDT table memory at [mem 0x8e426000-0x8e426=
143]
[    0.012124] ACPI: Reserving ASF! table memory at [mem 0x8e425000-0x8e425=
09f]
[    0.012126] ACPI: Reserving BGRT table memory at [mem 0x8fc2d000-0x8fc2d=
037]
[    0.012128] ACPI: Reserving PTDT table memory at [mem 0x8e424000-0x8e424=
985]
[    0.012130] ACPI: Reserving UEFI table memory at [mem 0x930c3000-0x930c3=
089]
[    0.012132] ACPI: Reserving FPDT table memory at [mem 0x8e423000-0x8e423=
033]
[    0.012661] No NUMA configuration found
[    0.012661] Faking a node at [mem 0x0000000000000000-0x000000085f7fffff]
[    0.012670] NODE_DATA(0) allocated [mem 0x85f7fc000-0x85f7fffff]
[    0.012716] Zone ranges:
[    0.012717]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012718]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012720]   Normal   [mem 0x0000000100000000-0x000000085f7fffff]
[    0.012721]   Device   empty
[    0.012722] Movable zone start for each node
[    0.012723] Early memory node ranges
[    0.012723]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.012724]   node   0: [mem 0x0000000000100000-0x000000008df6efff]
[    0.012725]   node   0: [mem 0x0000000093bff000-0x0000000093bfffff]
[    0.012726]   node   0: [mem 0x0000000100000000-0x000000085f7fffff]
[    0.012729] Initmem setup node 0 [mem 0x0000000000001000-0x000000085f7ff=
fff]
[    0.012733] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.012758] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.016312] On node 0, zone DMA32: 23696 pages in unavailable ranges
[    0.056913] On node 0, zone Normal: 17408 pages in unavailable ranges
[    0.056928] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.056986] Reserving Intel graphics memory at [mem 0x9c800000-0xa07ffff=
f]
[    0.058165] ACPI: PM-Timer IO Port: 0x1808
[    0.058171] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.058173] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.058174] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.058174] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.058175] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.058176] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.058176] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.058177] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.058177] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.058178] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.058178] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.058179] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.058179] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.058180] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.058181] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.058181] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.058300] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.058303] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.058304] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.058308] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.058309] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.058331] e820: update [mem 0x88e80000-0x88f10fff] usable =3D=3D> rese=
rved
[    0.058338] TSC deadline timer available
[    0.058338] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.058369] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.058372] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.058375] PM: hibernation: Registered nosave memory: [mem 0x87ec1000-0=
x87ec1fff]
[    0.058378] PM: hibernation: Registered nosave memory: [mem 0x88e80000-0=
x88f10fff]
[    0.058380] PM: hibernation: Registered nosave memory: [mem 0x8df6f000-0=
x92f2efff]
[    0.058381] PM: hibernation: Registered nosave memory: [mem 0x92f2f000-0=
x93b2efff]
[    0.058382] PM: hibernation: Registered nosave memory: [mem 0x93b2f000-0=
x93bfefff]
[    0.058384] PM: hibernation: Registered nosave memory: [mem 0x93c00000-0=
x97ffffff]
[    0.058385] PM: hibernation: Registered nosave memory: [mem 0x98000000-0=
x993fffff]
[    0.058385] PM: hibernation: Registered nosave memory: [mem 0x99400000-0=
x995fffff]
[    0.058386] PM: hibernation: Registered nosave memory: [mem 0x99600000-0=
x99dfffff]
[    0.058387] PM: hibernation: Registered nosave memory: [mem 0x99e00000-0=
xa07fffff]
[    0.058387] PM: hibernation: Registered nosave memory: [mem 0xa0800000-0=
xbfffffff]
[    0.058388] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0=
xcfffffff]
[    0.058388] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xfed1ffff]
[    0.058389] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]
[    0.058390] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xffffffff]
[    0.058391] [mem 0xd0000000-0xfed1ffff] available for PCI devices
[    0.058392] Booting paravirtualized kernel on bare hardware
[    0.058394] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.063525] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:8 n=
r_node_ids:1
[    0.063735] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
[    0.063745] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=3D1*2097152
[    0.063748] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.063777] Fallback order for Node 0: 0=20
[    0.063780] Built 1 zonelists, mobility grouping on.  Total pages: 81825=
46
[    0.063781] Policy zone: Normal
[    0.063782] Kernel command line: root=3D/dev/mapper/cryptroot rootflags=
=3Dsubvol=3D/root init=3D/usr/lib/systemd/systemd cryptdevice=3D/dev/disk/b=
y-uuid/xxxx-xxxx-xxxx-xxxx-xxxx:cryptroot:allow-discards rw quiet
[    0.063831] Unknown kernel command line parameters "cryptdevice=3D/dev/d=
isk/by-uuid/xxxx-xxxx-xxxx-xxxx-xxxx:cryptroot:allow-discards", will be pas=
sed to user space.
[    0.065069] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.065638] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.065794] mem auto-init: stack:byref_all(zero), heap alloc:on, heap fr=
ee:off
[    0.124880] Memory: 32440388K/33250360K available (14343K kernel code, 2=
092K rwdata, 10936K rodata, 1792K init, 3852K bss, 809712K reserved, 0K cma=
-reserved)
[    0.124884] random: get_random_u64 called from __kmem_cache_create+0x2a/=
0x550 with crng_init=3D1
[    0.124976] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.124985] ftrace: allocating 44931 entries in 176 pages
[    0.132205] ftrace: allocated 176 pages with 3 groups
[    0.132275] Dynamic Preempt: full
[    0.132303] rcu: Preemptible hierarchical RCU implementation.
[    0.132303] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D8.
[    0.132304] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.132305] 	Trampoline variant of Tasks RCU enabled.
[    0.132306] 	Rude variant of Tasks RCU enabled.
[    0.132306] 	Tracing variant of Tasks RCU enabled.
[    0.132307] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.132308] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.135937] NR_IRQS: 20736, nr_irqs: 2048, preallocated irqs: 16
[    0.136890] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.136971] random: crng init done (trusting CPU's manufacturer)
[    0.137004] Console: colour dummy device 80x25
[    0.137016] printk: console [tty0] enabled
[    0.137033] ACPI: Core revision 20211217
[    0.137288] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.137289] APIC: Switch to symmetric I/O mode setup
[    0.137290] DMAR: Host address width 39
[    0.137291] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.137296] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660=
462 ecap 29a00f0505e
[    0.137298] DMAR: DRHD base: 0x000000fed85000 flags: 0x0
[    0.137302] DMAR: dmar1: reg_base_addr fed85000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.137304] DMAR: DRHD base: 0x000000fed86000 flags: 0x0
[    0.137307] DMAR: dmar2: reg_base_addr fed86000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.137309] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.137314] DMAR: dmar3: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.137315] DMAR: RMRR base: 0x0000009c000000 end: 0x000000a07fffff
[    0.137318] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 3
[    0.137319] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.137320] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.143124] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.143126] x2apic enabled
[    0.143196] Switched APIC routing to cluster x2apic.
[    0.157724] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b2c8ec87c7, max_idle_ns: 440795278598 ns
[    0.157730] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5992.00 BogoMIPS (lpj=3D9984000)
[    0.157732] pid_max: default: 32768 minimum: 301
[    0.161061] LSM: Security Framework initializing
[    0.161061] landlock: Up and running.
[    0.161061] Yama: becoming mindful.
[    0.161061] LSM support for eBPF active
[    0.161061] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.161061] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.161061] x86/tme: not enabled by BIOS
[    0.161061] CPU0: Thermal monitoring enabled (TM1)
[    0.161061] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.161061] process: using mwait in idle threads
[    0.161061] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.161061] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.161061] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.161061] Spectre V2 : Mitigation: Enhanced IBRS
[    0.161061] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.161061] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.161061] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.161061] Freeing SMP alternatives memory: 36K
[    0.161061] smpboot: Estimated ratio of average max frequency by base fr=
equency (times 1024): 1467
[    0.161061] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GH=
z (family: 0x6, model: 0x8c, stepping: 0x1)
[    0.161061] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.161061] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.161061] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.161061] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.161061] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecat=
ed, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.161061] ... version:                5
[    0.161061] ... bit width:              48
[    0.161061] ... generic registers:      8
[    0.161061] ... value mask:             0000ffffffffffff
[    0.161061] ... max period:             00007fffffffffff
[    0.161061] ... fixed-purpose events:   4
[    0.161061] ... event mask:             0001000f000000ff
[    0.161061] rcu: Hierarchical SRCU implementation.
[    0.161061] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.161061] smp: Bringing up secondary CPUs ...
[    0.161061] x86: Booting SMP configuration:
[    0.161061] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.175082] smp: Brought up 1 node, 8 CPUs
[    0.175082] smpboot: Max logical packages: 1
[    0.175082] smpboot: Total of 8 processors activated (47942.00 BogoMIPS)
[    0.178942] devtmpfs: initialized
[    0.178942] x86/mm: Memory block size: 128MB
[    0.179003] ACPI: PM: Registering ACPI NVS region [mem 0x92f2f000-0x93b2=
efff] (12582912 bytes)
[    0.179003] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.179003] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.179003] pinctrl core: initialized pinctrl subsystem
[    0.181063] PM: RTC time: 11:20:36, date: 2022-04-19
[    0.181169] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.181558] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.181877] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.182213] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.182226] audit: initializing netlink subsys (disabled)
[    0.182232] audit: type=3D2000 audit(1650367235.023:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.182232] thermal_sys: Registered thermal governor 'fair_share'
[    0.182232] thermal_sys: Registered thermal governor 'bang_bang'
[    0.182232] thermal_sys: Registered thermal governor 'step_wise'
[    0.182232] thermal_sys: Registered thermal governor 'user_space'
[    0.182232] thermal_sys: Registered thermal governor 'power_allocator'
[    0.182232] cpuidle: using governor ladder
[    0.182232] cpuidle: using governor menu
[    0.182232] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576kB
[    0.182232] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.182232] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.182232] PCI: MMCONFIG for domain 0000 [bus 00-79] at [mem 0xc0000000=
-0xc79fffff] (base 0xc0000000)
[    0.182232] PCI: MMCONFIG at [mem 0xc0000000-0xc79fffff] reserved in E820
[    0.182232] PCI: Using configuration type 1 for base access
[    0.182232] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.182232] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.184413] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.184413] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.184413] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.184472] ACPI: Added _OSI(Module Device)
[    0.184473] ACPI: Added _OSI(Processor Device)
[    0.184474] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.184474] ACPI: Added _OSI(Processor Aggregator Device)
[    0.184475] ACPI: Added _OSI(Linux-Dell-Video)
[    0.184476] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.184477] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.259925] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.270678] ACPI: 15 ACPI AML tables successfully acquired and loaded
[    0.271931] ACPI: EC: EC started
[    0.271932] ACPI: EC: interrupt blocked
[    0.273178] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.273179] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.290169] ACPI: Dynamic OEM Table Load:
[    0.290176] ACPI: SSDT 0xFFFF95F88027AE00 0001CB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20191018)
[    0.290833] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.291488] ACPI: Dynamic OEM Table Load:
[    0.291493] ACPI: SSDT 0xFFFF95F881875800 000394 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20191018)
[    0.292257] ACPI: Dynamic OEM Table Load:
[    0.292262] ACPI: SSDT 0xFFFF95F881883000 000689 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20191018)
[    0.293082] ACPI: Dynamic OEM Table Load:
[    0.293086] ACPI: SSDT 0xFFFF95F881874000 00028B (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20191018)
[    0.293971] ACPI: Dynamic OEM Table Load:
[    0.293976] ACPI: SSDT 0xFFFF95F88012B000 0008E7 (v02 PmRef  ApIst    00=
003000 INTL 20191018)
[    0.294838] ACPI: Dynamic OEM Table Load:
[    0.294842] ACPI: SSDT 0xFFFF95F881884800 00048A (v02 PmRef  ApHwp    00=
003000 INTL 20191018)
[    0.295623] ACPI: Dynamic OEM Table Load:
[    0.295626] ACPI: SSDT 0xFFFF95F881881800 0004D4 (v02 PmRef  ApPsd    00=
003000 INTL 20191018)
[    0.296410] ACPI: Dynamic OEM Table Load:
[    0.296414] ACPI: SSDT 0xFFFF95F881883800 00048A (v02 PmRef  ApCst    00=
003000 INTL 20191018)
[    0.299211] ACPI: Interpreter enabled
[    0.299254] ACPI: PM: (supports S0 S4 S5)
[    0.299254] ACPI: Using IOAPIC for interrupt routing
[    0.299284] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.299697] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.300472] ACPI: PM: Power Resource [PXP]
[    0.302598] ACPI: PM: Power Resource [PUBS]
[    0.306091] ACPI: PM: Power Resource [BTPR]
[    0.307109] ACPI: PM: Power Resource [PXP]
[    0.307330] ACPI: PM: Power Resource [MRST]
[    0.307341] ACPI: PM: Power Resource [DRST]
[    0.308141] ACPI: PM: Power Resource [PXP]
[    0.312470] ACPI: PM: Power Resource [V0PR]
[    0.312561] ACPI: PM: Power Resource [V1PR]
[    0.312649] ACPI: PM: Power Resource [V2PR]
[    0.314415] ACPI: PM: Power Resource [WRST]
[    0.314575] ACPI: PM: Power Resource [TBT0]
[    0.314602] ACPI: PM: Power Resource [TBT1]
[    0.314625] ACPI: PM: Power Resource [D3C]
[    0.549528] ACPI: PM: Power Resource [PIN]
[    0.549541] ACPI: PM: Power Resource [PINP]
[    0.549879] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-79])
[    0.549883] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.554324] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.562813] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR DPC]
[    0.562814] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.566551] PCI host bridge to bus 0000:00
[    0.566552] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.566553] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.566554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.566555] pci_bus 0000:00: root bus resource [mem 0xa0800000-0xbffffff=
f window]
[    0.566556] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.566557] pci_bus 0000:00: root bus resource [bus 00-79]
[    0.566621] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000
[    0.566916] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000
[    0.566923] pci 0000:00:02.0: reg 0x10: [mem 0x603c000000-0x603cffffff 6=
4bit]
[    0.566927] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x401fffffff 6=
4bit pref]
[    0.566931] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.566943] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.566944] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.566946] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.566969] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bi=
t]
[    0.566970] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffff=
ff 64bit] (contains BAR0 for 7 VFs)
[    0.566973] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bi=
t pref]
[    0.566974] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffff=
ff 64bit pref] (contains BAR2 for 7 VFs)
[    0.567111] pci 0000:00:04.0: [8086:9a03] type 00 class 0x118000
[    0.567126] pci 0000:00:04.0: reg 0x10: [mem 0x603d180000-0x603d19ffff 6=
4bit]
[    0.567460] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400
[    0.567528] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.567554] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.568077] pci 0000:00:07.0: [8086:9a25] type 01 class 0x060400
[    0.568143] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.568165] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
[    0.568743] pci 0000:00:07.2: [8086:9a27] type 01 class 0x060400
[    0.568808] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.568830] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid
[    0.569463] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000
[    0.569470] pci 0000:00:08.0: reg 0x10: [mem 0x603d1da000-0x603d1dafff 6=
4bit]
[    0.569560] pci 0000:00:0a.0: [8086:9a0d] type 00 class 0x118000
[    0.569567] pci 0000:00:0a.0: reg 0x10: [mem 0x603d1c0000-0x603d1c7fff 6=
4bit]
[    0.569586] pci 0000:00:0a.0: enabling Extended Tags
[    0.569684] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330
[    0.569695] pci 0000:00:0d.0: reg 0x10: [mem 0x603d1b0000-0x603d1bffff 6=
4bit]
[    0.569746] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.570060] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340
[    0.570070] pci 0000:00:0d.2: reg 0x10: [mem 0x603d140000-0x603d17ffff 6=
4bit]
[    0.570077] pci 0000:00:0d.2: reg 0x18: [mem 0x603d1d9000-0x603d1d9fff 6=
4bit]
[    0.570109] pci 0000:00:0d.2: supports D1 D2
[    0.570109] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.570203] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340
[    0.570213] pci 0000:00:0d.3: reg 0x10: [mem 0x603d100000-0x603d13ffff 6=
4bit]
[    0.570220] pci 0000:00:0d.3: reg 0x18: [mem 0x603d1d8000-0x603d1d8fff 6=
4bit]
[    0.570251] pci 0000:00:0d.3: supports D1 D2
[    0.570252] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.570521] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330
[    0.570542] pci 0000:00:14.0: reg 0x10: [mem 0x603d1a0000-0x603d1affff 6=
4bit]
[    0.570645] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.570966] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000
[    0.570986] pci 0000:00:14.2: reg 0x10: [mem 0x603d1d0000-0x603d1d3fff 6=
4bit]
[    0.570999] pci 0000:00:14.2: reg 0x18: [mem 0x603d1d7000-0x603d1d7fff 6=
4bit]
[    0.571505] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000
[    0.571862] pci 0000:00:14.3: reg 0x10: [mem 0x603d1cc000-0x603d1cffff 6=
4bit]
[    0.573724] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.575200] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000
[    0.576083] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.579963] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000
[    0.579986] pci 0000:00:16.0: reg 0x10: [mem 0x603d1d5000-0x603d1d5fff 6=
4bit]
[    0.580080] pci 0000:00:16.0: PME# supported from D3hot
[    0.580583] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100
[    0.580999] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040380
[    0.581067] pci 0000:00:1f.3: reg 0x10: [mem 0x603d1c8000-0x603d1cbfff 6=
4bit]
[    0.581164] pci 0000:00:1f.3: reg 0x20: [mem 0x603d000000-0x603d0fffff 6=
4bit]
[    0.581334] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.581652] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500
[    0.581678] pci 0000:00:1f.4: reg 0x10: [mem 0x603d1d4000-0x603d1d40ff 6=
4bit]
[    0.581704] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.582029] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000
[    0.582047] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.582568] pci 0000:04:00.0: [1bb1:5018] type 00 class 0x010802
[    0.582609] pci 0000:04:00.0: reg 0x10: [mem 0xbc200000-0xbc203fff 64bit]
[    0.583487] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.583490] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.583520] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.583523] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.583526] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bff=
ffff 64bit pref]
[    0.583552] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.583556] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.583559] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bff=
ffff 64bit pref]
[    0.598231] ACPI: EC: interrupt unblocked
[    0.598232] ACPI: EC: event unblocked
[    0.598261] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.598262] ACPI: EC: GPE=3D0x6e
[    0.598262] ACPI: \_SB_.PC00.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.598263] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.598309] iommu: Default domain type: Translated=20
[    0.598310] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.598318] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dmem,locks=3Dnone
[    0.598318] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.598318] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.598318] vgaarb: loaded
[    0.598318] SCSI subsystem initialized
[    0.598318] libata version 3.00 loaded.
[    0.598318] ACPI: bus type USB registered
[    0.598318] usbcore: registered new interface driver usbfs
[    0.598318] usbcore: registered new interface driver hub
[    0.598318] usbcore: registered new device driver usb
[    0.598318] pps_core: LinuxPPS API ver. 1 registered
[    0.598318] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.598318] PTP clock support registered
[    0.598318] EDAC MC: Ver: 3.0.0
[    0.598341] Registered efivars operations
[    0.598341] NetLabel: Initializing
[    0.598341] NetLabel:  domain hash size =3D 128
[    0.598341] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.598341] NetLabel:  unlabeled traffic allowed by default
[    0.598341] mctp: management component transport protocol core
[    0.598341] NET: Registered PF_MCTP protocol family
[    0.598341] PCI: Using ACPI for IRQ routing
[    0.620928] PCI: pci_cache_line_size set to 64 bytes
[    0.621221] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010f=
ff]: no compatible bridge window
[    0.621689] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.621690] e820: reserve RAM buffer [mem 0x87ec1000-0x87ffffff]
[    0.621690] e820: reserve RAM buffer [mem 0x88e80000-0x8bffffff]
[    0.621691] e820: reserve RAM buffer [mem 0x8df6f000-0x8fffffff]
[    0.621691] e820: reserve RAM buffer [mem 0x93c00000-0x93ffffff]
[    0.621692] e820: reserve RAM buffer [mem 0x85f800000-0x85fffffff]
[    0.621882] clocksource: Switched to clocksource tsc-early
[    0.625453] VFS: Disk quotas dquot_6.6.0
[    0.625460] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.625510] pnp: PnP ACPI init
[    0.627704] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.627706] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.627795] system 00:01: [io  0x1854-0x1857] has been reserved
[    0.627829] pnp 00:04: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.627849] system 00:04: [io  0x1800-0x189f] could not be reserved
[    0.627850] system 00:04: [io  0x0800-0x087f] has been reserved
[    0.627851] system 00:04: [io  0x0880-0x08ff] has been reserved
[    0.627852] system 00:04: [io  0x0900-0x097f] has been reserved
[    0.627852] system 00:04: [io  0x0980-0x09ff] has been reserved
[    0.627853] system 00:04: [io  0x0a00-0x0a7f] has been reserved
[    0.627854] system 00:04: [io  0x0a80-0x0aff] has been reserved
[    0.627854] system 00:04: [io  0x0b00-0x0b7f] has been reserved
[    0.627855] system 00:04: [io  0x0b80-0x0bff] has been reserved
[    0.627856] system 00:04: [io  0x15e0-0x15ef] has been reserved
[    0.627856] system 00:04: [io  0x1600-0x167f] could not be reserved
[    0.627857] system 00:04: [io  0x1640-0x165f] could not be reserved
[    0.627859] system 00:04: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.627860] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.627861] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.627862] system 00:04: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.627862] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.627863] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.628399] pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.628410] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.628411] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.628412] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.628413] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.628414] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.628415] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.628416] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.628802] system 00:06: [io  0x1800-0x18fe] could not be reserved
[    0.628803] system 00:06: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.628804] system 00:06: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    0.628805] system 00:06: [mem 0xfe050000-0xfe0affff] has been reserved
[    0.628806] system 00:06: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    0.628807] system 00:06: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.628808] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.628809] system 00:06: [mem 0xfd000000-0xfd68ffff] has been reserved
[    0.628810] system 00:06: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    0.628810] system 00:06: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.629029] system 00:07: [io  0x2000-0x20fe] has been reserved
[    0.629398] pnp 00:09: disabling [mem 0x000c0000-0x000c3fff] because it =
overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.629399] pnp 00:09: disabling [mem 0x000c8000-0x000cbfff] because it =
overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.629400] pnp 00:09: disabling [mem 0x000d0000-0x000d3fff] because it =
overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.629401] pnp 00:09: disabling [mem 0x000d8000-0x000dbfff] because it =
overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.629402] pnp 00:09: disabling [mem 0x00000000-0x0009ffff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629403] pnp 00:09: disabling [mem 0x000c0000-0x000c3fff disabled] be=
cause it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629404] pnp 00:09: disabling [mem 0x000c8000-0x000cbfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629405] pnp 00:09: disabling [mem 0x000d0000-0x000d3fff disabled] be=
cause it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629406] pnp 00:09: disabling [mem 0x000d8000-0x000dbfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629407] pnp 00:09: disabling [mem 0x000e0000-0x000e3fff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629408] pnp 00:09: disabling [mem 0x000e8000-0x000ebfff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629409] pnp 00:09: disabling [mem 0x000f0000-0x000fffff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629409] pnp 00:09: disabling [mem 0x00100000-0xa07fffff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]
[    0.629410] pnp 00:09: disabling [mem 0x00000000-0x0009ffff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629411] pnp 00:09: disabling [mem 0x000c0000-0x000c3fff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629412] pnp 00:09: disabling [mem 0x000c8000-0x000cbfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629413] pnp 00:09: disabling [mem 0x000d0000-0x000d3fff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629414] pnp 00:09: disabling [mem 0x000d8000-0x000dbfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629415] pnp 00:09: disabling [mem 0x000e0000-0x000e3fff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629415] pnp 00:09: disabling [mem 0x000e8000-0x000ebfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629416] pnp 00:09: disabling [mem 0x000f0000-0x000fffff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629417] pnp 00:09: disabling [mem 0x00100000-0xa07fffff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.629426] system 00:09: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.629427] system 00:09: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.629643] pnp: PnP ACPI: found 10 devices
[    0.634710] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.634740] NET: Registered PF_INET protocol family
[    0.634896] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.635846] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.636025] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.636257] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.636292] TCP: Hash tables configured (established 262144 bind 65536)
[    0.636396] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)
[    0.636486] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.636548] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.636595] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.636599] NET: Registered PF_XDP protocol family
[    0.636603] pci 0000:00:07.0: bridge window [io  0x1000-0x0fff] to [bus =
20-49] add_size 1000
[    0.636606] pci 0000:00:07.2: bridge window [io  0x1000-0x0fff] to [bus =
50-79] add_size 1000
[    0.636612] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffff=
ffff 64bit pref]
[    0.636615] pci 0000:00:02.0: BAR 7: assigned [mem 0x4100000000-0x4106ff=
ffff 64bit]
[    0.636618] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.636619] pci 0000:00:07.2: BAR 13: assigned [io  0x5000-0x5fff]
[    0.636620] pci 0000:00:15.0: BAR 0: assigned [mem 0x4107000000-0x410700=
0fff 64bit]
[    0.637049] pci 0000:00:1f.5: BAR 0: assigned [mem 0xa0800000-0xa0800fff]
[    0.637077] pci 0000:00:06.0: PCI bridge to [bus 04]
[    0.637083] pci 0000:00:06.0:   bridge window [mem 0xbc200000-0xbc2fffff]
[    0.637091] pci 0000:00:07.0: PCI bridge to [bus 20-49]
[    0.637093] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    0.637095] pci 0000:00:07.0:   bridge window [mem 0xb0000000-0xbc1fffff]
[    0.637097] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bff=
ffff 64bit pref]
[    0.637101] pci 0000:00:07.2: PCI bridge to [bus 50-79]
[    0.637102] pci 0000:00:07.2:   bridge window [io  0x5000-0x5fff]
[    0.637104] pci 0000:00:07.2:   bridge window [mem 0xa2000000-0xae1fffff]
[    0.637106] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bff=
ffff 64bit pref]
[    0.637111] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.637111] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.637112] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.637113] pci_bus 0000:00: resource 7 [mem 0xa0800000-0xbfffffff windo=
w]
[    0.637113] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.637114] pci_bus 0000:04: resource 1 [mem 0xbc200000-0xbc2fffff]
[    0.637115] pci_bus 0000:20: resource 0 [io  0x4000-0x4fff]
[    0.637116] pci_bus 0000:20: resource 1 [mem 0xb0000000-0xbc1fffff]
[    0.637116] pci_bus 0000:20: resource 2 [mem 0x6000000000-0x601bffffff 6=
4bit pref]
[    0.637117] pci_bus 0000:50: resource 0 [io  0x5000-0x5fff]
[    0.637118] pci_bus 0000:50: resource 1 [mem 0xa2000000-0xae1fffff]
[    0.637118] pci_bus 0000:50: resource 2 [mem 0x6020000000-0x603bffffff 6=
4bit pref]
[    0.638019] PCI: CLS 0 bytes, default 64
[    0.638026] DMAR: Intel-IOMMU force enabled due to platform opt in
[    0.638034] DMAR: No ATSR found
[    0.638034] DMAR: No SATC found
[    0.638035] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.638036] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.638037] DMAR: IOMMU feature nwfs inconsistent
[    0.638037] DMAR: IOMMU feature dit inconsistent
[    0.638037] DMAR: IOMMU feature sc_support inconsistent
[    0.638038] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.638038] DMAR: dmar2: Using Queued invalidation
[    0.638041] DMAR: dmar1: Using Queued invalidation
[    0.638043] DMAR: dmar0: Using Queued invalidation
[    0.638044] DMAR: dmar3: Using Queued invalidation
[    0.638070] Trying to unpack rootfs image as initramfs...
[    0.638165] pci 0000:00:00.0: Adding to iommu group 0
[    0.638170] pci 0000:00:02.0: Adding to iommu group 1
[    0.638176] pci 0000:00:04.0: Adding to iommu group 2
[    0.638186] pci 0000:00:06.0: Adding to iommu group 3
[    0.638192] pci 0000:00:07.0: Adding to iommu group 4
[    0.638198] pci 0000:00:07.2: Adding to iommu group 5
[    0.638203] pci 0000:00:08.0: Adding to iommu group 6
[    0.638208] pci 0000:00:0a.0: Adding to iommu group 7
[    0.638216] pci 0000:00:0d.0: Adding to iommu group 8
[    0.638221] pci 0000:00:0d.2: Adding to iommu group 8
[    0.638225] pci 0000:00:0d.3: Adding to iommu group 8
[    0.638233] pci 0000:00:14.0: Adding to iommu group 9
[    0.638237] pci 0000:00:14.2: Adding to iommu group 9
[    0.638242] pci 0000:00:14.3: Adding to iommu group 10
[    0.638247] pci 0000:00:15.0: Adding to iommu group 11
[    0.638254] pci 0000:00:16.0: Adding to iommu group 12
[    0.638263] pci 0000:00:1f.0: Adding to iommu group 13
[    0.638268] pci 0000:00:1f.3: Adding to iommu group 13
[    0.638273] pci 0000:00:1f.4: Adding to iommu group 13
[    0.638278] pci 0000:00:1f.5: Adding to iommu group 13
[    0.638287] pci 0000:04:00.0: Adding to iommu group 14
[    0.638379] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.638380] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.638381] software IO TLB: mapped [mem 0x0000000083ce2000-0x0000000087=
ce2000] (64MB)
[    0.638403] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b2=
c8ec87c7, max_idle_ns: 440795278598 ns
[    0.638436] clocksource: Switched to clocksource tsc
[    0.638449] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.644949] Initialise system trusted keyrings
[    0.644956] Key type blacklist registered
[    0.644985] workingset: timestamp_bits=3D41 max_order=3D23 bucket_order=
=3D0
[    0.645555] zbud: loaded
[    0.651949] Key type asymmetric registered
[    0.651951] Asymmetric key parser 'x509' registered
[    0.682763] Freeing initrd memory: 18892K
[    0.684030] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.684038] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 242)
[    0.684055] io scheduler mq-deadline registered
[    0.684055] io scheduler kyber registered
[    0.684066] io scheduler bfq registered
[    0.809476] pcieport 0000:00:06.0: PME: Signaling with IRQ 124
[    0.809884] pcieport 0000:00:07.0: PME: Signaling with IRQ 125
[    0.809917] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.810386] pcieport 0000:00:07.2: PME: Signaling with IRQ 126
[    0.810413] pcieport 0000:00:07.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.810599] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.811111] Monitor-Mwait will be used to enter C-1 state
[    0.811118] Monitor-Mwait will be used to enter C-2 state
[    0.811123] Monitor-Mwait will be used to enter C-3 state
[    0.811127] ACPI: \_SB_.PR00: Found 3 idle states
[    0.812700] ACPI: AC: AC Adapter [AC] (off-line)
[    0.812803] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.814530] ACPI: button: Sleep Button [SLPB]
[    0.814611] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    0.817807] ACPI: button: Lid Switch [LID]
[    0.817848] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input2
[    0.817872] ACPI: button: Power Button [PWRB]
[    0.818211] smpboot: Estimated ratio of average max frequency by base fr=
equency (times 1024): 1467
[    0.833954] thermal LNXTHERM:00: registered as thermal_zone0
[    0.833956] ACPI: thermal: Thermal Zone [THM0] (51 C)
[    0.834069] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.835070] hpet_acpi_add: no address or irqs in _CRS
[    0.835090] Non-volatile memory driver v1.3
[    0.835090] Linux agpgart interface v0.103
[    0.835091] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em - This is not a bug.
[    0.835669] ACPI: bus type drm_connector registered
[    0.837049] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.837051] ehci-pci: EHCI PCI platform driver
[    0.837054] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.837055] ohci-pci: OHCI PCI platform driver
[    0.837058] uhci_hcd: USB Universal Host Controller Interface driver
[    0.837076] usbcore: registered new interface driver usbserial_generic
[    0.837078] usbserial: USB Serial support registered for generic
[    0.837255] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.839385] rtc_cmos rtc_cmos: registered as rtc0
[    0.839837] rtc_cmos rtc_cmos: setting system clock to 2022-04-19T11:20:=
36 UTC (1650367236)
[    0.839844] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.840418] intel_pstate: Intel P-state driver initializing
[    0.842028] intel_pstate: HWP enabled
[    0.842881] ledtrig-cpu: registered to indicate activity on CPUs
[    0.843028] efifb: probing for efifb
[    0.843040] efifb: showing boot graphics
[    0.844603] efifb: framebuffer at 0x4000000000, using 9000k, total 9000k
[    0.844604] efifb: mode is 1920x1200x32, linelength=3D7680, pages=3D1
[    0.844605] efifb: scrolling: redraw
[    0.844605] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.844625] fbcon: Deferring console take-over
[    0.844626] fb0: EFI VGA frame buffer device
[    0.844654] hid: raw HID events driver (C) Jiri Kosina
[    0.844728] intel_pmc_core INT33A1:00:  initialized
[    0.844758] drop_monitor: Initializing network drop monitor service
[    0.844793] Initializing XFRM netlink socket
[    0.844841] NET: Registered PF_INET6 protocol family
[    0.848302] Segment Routing with IPv6
[    0.848303] RPL Segment Routing with IPv6
[    0.848308] In-situ OAM (IOAM) with IPv6
[    0.848329] NET: Registered PF_PACKET protocol family
[    0.849351] microcode: sig=3D0x806c1, pf=3D0x80, revision=3D0x9a
[    0.850363] microcode: Microcode Update Driver: v2.2.
[    0.852967] resctrl: L2 allocation detected
[    0.852972] IPI shorthand broadcast: enabled
[    0.852979] sched_clock: Marking stable (831691890, 20948342)->(86942093=
0, -16780698)
[    0.858090] registered taskstats version 1
[    0.859247] Loading compiled-in X.509 certificates
[    0.861118] Loaded X.509 cert 'Build time autogenerated kernel key: e41b=
103d992e7165164c88f6deb03f61f089d7db'
[    0.861465] zswap: loaded using pool lz4/z3fold
[    0.861859] Key type ._fscrypt registered
[    0.861860] Key type .fscrypt registered
[    0.861860] Key type fscrypt-provisioning registered
[    0.864611] PM:   Magic number: 2:851:327
[    0.864831] RAS: Correctable Errors collector initialized.
[    0.969790] ACPI: battery: Slot [BAT0] (battery present)
[    0.977323] Freeing unused decrypted memory: 2036K
[    0.977694] Freeing unused kernel image (initmem) memory: 1792K
[    0.977695] Write protecting the kernel read-only data: 28672k
[    0.978176] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    0.978500] Freeing unused kernel image (rodata/data gap) memory: 1352K
[    0.984002] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.984005] rodata_test: all tests were successful
[    0.984008] Run /init as init process
[    0.984009]   with arguments:
[    0.984009]     /init
[    0.984010]   with environment:
[    0.984010]     HOME=3D/
[    0.984010]     TERM=3Dlinux
[    0.984011]     cryptdevice=3D/dev/disk/by-uuid/xxxx-xxxx-xxxx-xxxx-xxxx=
:cryptroot:allow-discards
[    1.069379] systemd[1]: systemd 250.4-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF=
_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    1.084650] systemd[1]: Detected architecture x86-64.
[    1.084655] systemd[1]: Running in initial RAM disk.
[    1.084718] systemd[1]: Initializing machine ID from random generator.
[    1.101742] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    1.102523] systemd[1]: Created slice Slice /system/systemd-cryptsetup.
[    1.102565] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    1.102586] systemd[1]: Reached target Local File Systems.
[    1.102591] systemd[1]: Reached target Path Units.
[    1.102597] systemd[1]: Reached target Slice Units.
[    1.102603] systemd[1]: Reached target Swaps.
[    1.102610] systemd[1]: Reached target Timer Units.
[    1.102664] systemd[1]: Listening on Journal Audit Socket.
[    1.102700] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.102733] systemd[1]: Listening on Journal Socket.
[    1.102768] systemd[1]: Listening on udev Control Socket.
[    1.102788] systemd[1]: Listening on udev Kernel Socket.
[    1.102796] systemd[1]: Reached target Socket Units.
[    1.103097] systemd[1]: Starting Create List of Static Device Nodes...
[    1.103769] systemd[1]: Starting Journal Service...
[    1.104076] systemd[1]: Starting Load Kernel Modules...
[    1.104371] systemd[1]: Starting Coldplug All udev Devices...
[    1.104595] systemd[1]: Finished Create List of Static Device Nodes.
[    1.104964] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.106003] systemd[1]: Finished Load Kernel Modules.
[    1.106855] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.107442] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    1.114042] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[    1.114079] audit: type=3D1130 audit(1650367236.769:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"syst=
emd" exe=3D"/init" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    1.122524] systemd[1]: Started Journal Service.
[    1.122557] audit: type=3D1130 audit(1650367236.779:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd" exe=3D"/init" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    1.145272] audit: type=3D1130 audit(1650367236.803:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-trigger comm=
=3D"systemd" exe=3D"/init" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    1.149500] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.149811] i8042: Warning: Keylock active
[    1.151563] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.151574] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.163158] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.163165] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus =
number 1
[    1.164234] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000000200009810
[    1.164401] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.17
[    1.164403] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.164405] usb usb1: Product: xHCI Host Controller
[    1.164406] usb usb1: Manufacturer: Linux 5.17.3-arch1-1 xhci-hcd
[    1.164407] usb usb1: SerialNumber: 0000:00:0d.0
[    1.165714] hub 1-0:1.0: USB hub found
[    1.165723] hub 1-0:1.0: 1 port detected
[    1.166151] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.166153] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus =
number 2
[    1.166156] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.166190] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.17
[    1.166192] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.166193] usb usb2: Product: xHCI Host Controller
[    1.166194] usb usb2: Manufacturer: Linux 5.17.3-arch1-1 xhci-hcd
[    1.166195] usb usb2: SerialNumber: 0000:00:0d.0
[    1.167451] hub 2-0:1.0: USB hub found
[    1.167461] hub 2-0:1.0: 4 ports detected
[    1.168561] usb: port power management may be unreliable
[    1.168874] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.168878] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 3
[    1.170057] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000000000009810
[    1.170337] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.17
[    1.170340] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.170342] usb usb3: Product: xHCI Host Controller
[    1.170343] usb usb3: Manufacturer: Linux 5.17.3-arch1-1 xhci-hcd
[    1.170344] usb usb3: SerialNumber: 0000:00:14.0
[    1.170455] hub 3-0:1.0: USB hub found
[    1.170494] hub 3-0:1.0: 12 ports detected
[    1.171386] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    1.171478] nvme nvme0: pci function 0000:04:00.0
[    1.172289] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.172292] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 4
[    1.172293] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.172354] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.17
[    1.172355] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.172356] usb usb4: Product: xHCI Host Controller
[    1.172357] usb usb4: Manufacturer: Linux 5.17.3-arch1-1 xhci-hcd
[    1.172358] usb usb4: SerialNumber: 0000:00:14.0
[    1.172410] hub 4-0:1.0: USB hub found
[    1.172440] hub 4-0:1.0: 4 ports detected
[    1.172859] cryptd: max_cpu_qlen set to 1000
[    1.176611] nvme nvme0: missing or invalid SUBNQN field.
[    1.176639] nvme nvme0: Shutdown timeout set to 10 seconds
[    1.178486] nvme nvme0: 8/0/0 default/read/poll queues
[    1.178523] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    1.180007]  nvme0n1: p1 p2
[    1.188736] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[    1.190726] AVX2 version of gcm_enc/dec engaged.
[    1.190759] AES CTR mode by8 optimization enabled
[    1.316020] device-mapper: uevent: version 1.0.3
[    1.316154] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised:=
 dm-devel@redhat.com
[    1.424416] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    1.566969] usb 3-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00fc, bcdDevice=3D 0.00
[    1.566977] usb 3-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    1.566980] usb 3-3: SerialNumber: 7b571cd95cd2
[    1.691087] usb 3-4: new high-speed USB device number 3 using xhci_hcd
[    1.834296] usb 3-4: New USB device found, idVendor=3D04f2, idProduct=3D=
b6ea, bcdDevice=3D62.18
[    1.834301] usb 3-4: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    1.834302] usb 3-4: Product: Integrated Camera
[    1.834303] usb 3-4: Manufacturer: Chicony Electronics Co.,Ltd.
[    1.834304] usb 3-4: SerialNumber: 0001
[    1.957785] usb 3-7: new full-speed USB device number 4 using xhci_hcd
[    2.100909] usb 3-7: New USB device found, idVendor=3D1050, idProduct=3D=
0407, bcdDevice=3D 5.12
[    2.100917] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.100919] usb 3-7: Product: YubiKey OTP+FIDO+CCID
[    2.100921] usb 3-7: Manufacturer: Yubico
[    2.112072] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0=
000:00:14.0/usb3/3-7/3-7:1.0/0003:1050:0407.0001/input/input5
[    2.168212] hid-generic 0003:1050:0407.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-7/input0
[    2.169628] hid-generic 0003:1050:0407.0002: hiddev96,hidraw1: USB HID v=
1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:14.0-7/input1
[    2.169670] usbcore: registered new interface driver usbhid
[    2.169672] usbhid: USB HID core driver
[    2.227948] usb 3-10: new full-speed USB device number 5 using xhci_hcd
[    2.348972] Key type trusted registered
[    2.355349] Key type encrypted registered
[    2.359677] audit: type=3D1338 audit(1650367238.016:5): module=3Dcrypt o=
p=3Dctr ppid=3D1 pid=3D242 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 co=
mm=3D"systemd-cryptse" exe=3D"/usr/lib/systemd/systemd-cryptsetup" dev=3D25=
4:0 error_msg=3D'success' res=3D1
[    2.359772] audit: type=3D1300 audit(1650367238.016:5): arch=3Dc000003e =
syscall=3D16 success=3Dyes exit=3D0 a0=3D4 a1=3Dc138fd09 a2=3D55d13e02d660 =
a3=3D7ffd54b9eab2 items=3D6 ppid=3D1 pid=3D242 auid=3D4294967295 uid=3D0 gi=
d=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) =
ses=3D4294967295 comm=3D"systemd-cryptse" exe=3D"/usr/lib/systemd/systemd-c=
ryptsetup" key=3D(null)
[    2.359774] audit: type=3D1307 audit(1650367238.016:5): cwd=3D"/"
[    2.359775] audit: type=3D1302 audit(1650367238.016:5): item=3D0 name=3D=
(null) inode=3D38 dev=3D00:07 mode=3D040755 ouid=3D0 ogid=3D0 rdev=3D00:00 =
nametype=3DPARENT cap_fp=3D0 cap_fi=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=
=3D0
[    2.359776] audit: type=3D1302 audit(1650367238.016:5): item=3D1 name=3D=
(null) inode=3D13402 dev=3D00:07 mode=3D040755 ouid=3D0 ogid=3D0 rdev=3D00:=
00 nametype=3DCREATE cap_fp=3D0 cap_fi=3D0 cap_fe=3D0 cap_fver=3D0 cap_froo=
tid=3D0
[    2.359778] audit: type=3D1302 audit(1650367238.016:5): item=3D2 name=3D=
(null) inode=3D27 dev=3D00:07 mode=3D040755 ouid=3D0 ogid=3D0 rdev=3D00:00 =
nametype=3DPARENT cap_fp=3D0 cap_fi=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=
=3D0
[    2.370510] raid6: skipped pq benchmark and selected avx512x4
[    2.370511] raid6: using avx512x2 recovery algorithm
[    2.372602] xor: automatically using best checksumming function   avx=20=
=20=20=20=20=20=20
[    2.376214] usb 3-10: New USB device found, idVendor=3D8087, idProduct=
=3D0026, bcdDevice=3D 0.02
[    2.376217] usb 3-10: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    2.399980] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes, fsverity=
=3Dyes
[    2.400494] BTRFS: device fsid 4f5e23f0-3f92-46e9-bc0b-7e986256ce7b devi=
d 1 transid 138155 /dev/dm-0 scanned by systemd-udevd (207)
[    2.475365] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[    2.475369] BTRFS info (device dm-0): using free space tree
[    2.475370] BTRFS info (device dm-0): has skinny extents
[    2.559252] BTRFS info (device dm-0): enabling ssd optimizations
[    2.694297] systemd-journald[171]: Received SIGTERM from PID 1 (systemd).
[    2.758486] systemd[1]: systemd 250.4-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF=
_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    2.774747] systemd[1]: Detected architecture x86-64.
[    2.775428] systemd[1]: Hostname set to <alrua-x1>.
[    3.862415] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    2.862464] systemd[1]: Stopped Switch Root.
[    2.862592] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    2.862733] systemd[1]: Created slice Slice /system/getty.
[    2.862847] systemd[1]: Created slice Slice /system/loadkeys.
[    2.862951] systemd[1]: Created slice Slice /system/modprobe.
[    2.863057] systemd[1]: Created slice Slice /system/netns.
[    2.863187] systemd[1]: Created slice Slice /system/openvpn-client.
[    2.863302] systemd[1]: Created slice Slice /system/rfkill-block.
[    2.863409] systemd[1]: Created slice Slice /system/syncthing.
[    2.863486] systemd[1]: Created slice User and Session Slice.
[    2.863514] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    2.863531] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    2.863602] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    2.863614] systemd[1]: Reached target Local Encrypted Volumes.
[    2.863625] systemd[1]: Stopped target Switch Root.
[    2.863631] systemd[1]: Stopped target Initrd File Systems.
[    2.863635] systemd[1]: Stopped target Initrd Root File System.
[    2.863642] systemd[1]: Reached target Local Integrity Protected Volumes.
[    2.863656] systemd[1]: Reached target Remote File Systems.
[    2.863663] systemd[1]: Reached target Slice Units.
[    2.863670] systemd[1]: Reached target Swaps.
[    2.863680] systemd[1]: Reached target Local Verity Protected Volumes.
[    2.863707] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.863985] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.865652] systemd[1]: Listening on RPCbind Server Activation Socket.
[    2.865669] systemd[1]: Reached target RPC Port Mapper.
[    2.866132] systemd[1]: Listening on Process Core Dump Socket.
[    2.866185] systemd[1]: Listening on Network Service Netlink Socket.
[    2.866676] systemd[1]: Listening on udev Control Socket.
[    2.866708] systemd[1]: Listening on udev Kernel Socket.
[    2.867107] systemd[1]: Mounting Huge Pages File System...
[    2.867425] systemd[1]: Mounting POSIX Message Queue File System...
[    2.867754] systemd[1]: Mounting Kernel Debug File System...
[    2.868086] systemd[1]: Mounting Kernel Trace File System...
[    2.868140] systemd[1]: tmp.mount: Directory /tmp to mount over is not e=
mpty, mounting anyway.
[    2.868555] systemd[1]: Mounting Temporary Directory /tmp...
[    2.869107] systemd[1]: Starting Create List of Static Device Nodes...
[    2.869522] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    2.869943] systemd[1]: Starting Load Kernel Module configfs...
[    2.870288] systemd[1]: Starting Load Kernel Module drm...
[    2.870632] systemd[1]: Starting Load Kernel Module fuse...
[    2.870711] systemd[1]: systemd-cryptsetup@cryptroot.service: Deactivate=
d successfully.
[    2.870739] systemd[1]: Stopped systemd-cryptsetup@cryptroot.service.
[    2.870801] systemd[1]: systemd-fsck-root.service: Deactivated successfu=
lly.
[    2.870824] systemd[1]: Stopped File System Check on Root Device.
[    2.870872] systemd[1]: Stopped Journal Service.
[    2.871721] systemd[1]: Starting Journal Service...
[    2.872740] systemd[1]: Starting Load Kernel Modules...
[    2.873241] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.873283] systemd[1]: Repartition Root Disk was skipped because all tr=
igger condition checks failed.
[    2.873752] systemd[1]: Starting Coldplug All udev Devices...
[    2.874607] systemd[1]: Mounted Huge Pages File System.
[    2.874660] systemd[1]: Mounted POSIX Message Queue File System.
[    2.874698] systemd[1]: Mounted Kernel Debug File System.
[    2.874734] systemd[1]: Mounted Kernel Trace File System.
[    2.874770] systemd[1]: Mounted Temporary Directory /tmp.
[    2.874876] systemd[1]: Finished Create List of Static Device Nodes.
[    2.875011] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    2.875077] systemd[1]: Finished Load Kernel Module configfs.
[    2.875206] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    2.875267] systemd[1]: Finished Load Kernel Module drm.
[    2.875706] systemd[1]: Mounting Kernel Configuration File System...
[    2.877722] fuse: init (API version 7.36)
[    2.878065] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    2.878132] systemd[1]: Finished Load Kernel Module fuse.
[    2.878481] systemd[1]: Mounting FUSE Control File System...
[    2.883845] systemd[1]: Mounted Kernel Configuration File System.
[    2.883896] systemd[1]: Mounted FUSE Control File System.
[    2.939090] systemd[1]: Started Journal Service.
[    2.939689] IPMI message handler: version 39.2
[    2.941538] BTRFS info (device dm-0): turning on async discard
[    2.941541] BTRFS info (device dm-0): use zstd compression, level 3
[    2.941543] BTRFS info (device dm-0): using free space tree
[    2.942205] ipmi device interface
[    2.945025] Asymmetric key parser 'pkcs8' registered
[    2.946613] systemd-journald[346]: Received client request to flush runt=
ime journal.
[    2.947721] vboxdrv: loading out-of-tree module taints kernel.
[    2.947852] vboxdrv: module verification failed: signature and/or requir=
ed key missing - tainting kernel
[    2.949246] vboxdrv: Found 8 processor cores
[    2.971329] vboxdrv: TSC mode is Invariant, tentative frequency 29951907=
14 Hz
[    2.971332] vboxdrv: Successfully loaded version 6.1.32 r149290 (interfa=
ce 0x00320000)
[    2.972419] VBoxNetAdp: Successfully started.
[    2.973501] VBoxNetFlt: Successfully started.
[    2.986856] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some =
data may be corrupt. Please run fsck.
[    3.322330] Userspace governor deprecated: use thermal netlink notificat=
ion instead
[    3.325131] input: Intel HID events as /devices/platform/INTC1051:00/inp=
ut/input6
[    3.637226] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.637348] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.637698] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.638658] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.639604] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.640447] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.640454] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.640456] thinkpad_acpi: ThinkPad BIOS N32ET75W (1.51 ), EC N32HT52W
[    3.640458] thinkpad_acpi: Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS3=
HC26
[    3.640912] acpi PNP0C14:06: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.642532] acpi PNP0C14:07: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.642664] thinkpad_acpi: radio switch found; radios are enabled
[    3.643309] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[    3.643312] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[    3.648230] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    3.675457] thinkpad_acpi: battery 1 registered (start 0, stop 100, beha=
viours: 0x7)
[    3.675468] ACPI: battery: new extension: ThinkPad Battery Extension
[    3.681971] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[    3.684918] EDAC igen6: v2.5
[    3.754065] ACPI: bus type thunderbolt registered
[    3.853481] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    3.854327] Setting dangerous option enable_guc - tainting kernel
[    3.854330] Setting dangerous option enable_fbc - tainting kernel
[    3.854576] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    3.855068] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    3.855070] checking generic (4000000000 8ca000) vs hw (603c000000 10000=
00)
[    3.855071] checking generic (4000000000 8ca000) vs hw (4000000000 20000=
000)
[    3.855072] fb0: switching to i915 from EFI VGA
[    3.855153] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.855187] i915 0000:00:02.0: [drm] Transparent Hugepage mode 'huge=3Dw=
ithin_size'
[    3.857177] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dmem
[    3.859865] intel_rapl_common: Found RAPL domain package
[    3.861751] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
tgl_dmc_ver2_12.bin (v2.12)
[    3.927088] usb usb3-port10: disabled by hub (EMI?), re-enabling...
[    3.927094] usb 3-10: USB disconnect, device number 5
[    4.042709] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    4.043469] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.046144] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.079430] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.079698] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.079771] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.081033] i2c i2c-10: 8/8 memory slots populated (from DMI)
[    4.081035] i2c i2c-10: Systems with more than 4 memory slots not suppor=
ted yet, not instantiating SPD
[    4.082985] i915 0000:00:02.0: [drm] GuC firmware i915/tgl_guc_62.0.0.bi=
n version 62.0 submission:disabled
[    4.082989] i915 0000:00:02.0: [drm] GuC SLPC: disabled
[    4.082990] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc_7.9.3.bin=
 version 7.9 authenticated:yes
[    4.084795] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected c=
ontent support initialized
[    4.089587] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
[    4.092572] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    4.092837] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input8
[    4.095641] fbcon: i915drmfb (fb0) is primary device
[    4.095643] fbcon: Deferring console take-over
[    4.095645] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    4.152102] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.154190] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.213799] input: PC Speaker as /devices/platform/pcspkr/input/input10
[    4.217723] input: SYNA8008:00 06CB:CE58 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-9/i2c-SYNA8008:00/0018:06CB:CE58.0003/input=
/input11
[    4.217808] input: SYNA8008:00 06CB:CE58 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-9/i2c-SYNA8008:00/0018:06CB:CE58.0003/in=
put/input12
[    4.217842] hid-generic 0018:06CB:CE58.0003: input,hidraw2: I2C HID v1.0=
0 Mouse [SYNA8008:00 06CB:CE58] on i2c-SYNA8008:00
[    4.297502] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff=
], which spans more than pnp 00:05 [mem 0xfedc0000-0xfedc7fff]
[    4.297508] caller __uncore_imc_init_box+0xc9/0x100 [intel_uncore] mappi=
ng multiple BARs
[    4.299979] intel-spi 0000:00:1f.5: BFPT parsing failed. Please consider=
 using SPI_NOR_SKIP_SFDP when declaring the flash
[    4.299982] intel-spi 0000:00:1f.5: failed to locate the chip
[    4.300026] intel-spi: probe of 0000:00:1f.5 failed with error -22
[    4.305197] zram: Added device: zram0
[    4.318708] typec port0: bound usb3-port5 (ops connector_ops)
[    4.318719] typec port0: bound usb2-port2 (ops connector_ops)
[    4.362371] Intel(R) Wireless WiFi driver for Linux
[    4.364599] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for=
 information.
[    4.364601] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    4.400110] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    4.458289] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a=
0-hr-b0-69.ucode failed with error -2
[    4.505425] iwlwifi 0000:00:14.3: api flags index 2 larger than supporte=
d by driver
[    4.505443] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[    4.506052] iwlwifi 0000:00:14.3: loaded firmware version 68.01d30b0c.0 =
QuZ-a0-hr-b0-68.ucode op_mode iwlmvm
[    4.550434] zram0: detected capacity change from 0 to 2035848
[    4.612716] BTRFS info (device dm-0): devid 1 device path /dev/mapper/cr=
yptroot changed to /dev/dm-0 scanned by systemd-udevd (404)
[    4.628698] BTRFS info (device dm-0): devid 1 device path /dev/dm-0 chan=
ged to /dev/mapper/cryptroot scanned by systemd-udevd (404)
[    4.663607] intel_tcc_cooling: Programmable TCC Offset detected
[    4.671319] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040380
[    4.671426] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ p=
latform, using SOF driver
[    4.697811] psmouse serio1: trackpoint: Elan TrackPoint firmware: 0x92, =
buttons: 3/3
[    4.710568] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/ser=
io1/input/input9
[    4.751935] intel_rapl_msr: PL4 support detected.
[    4.752585] intel_rapl_common: Found RAPL domain package
[    4.752588] intel_rapl_common: Found RAPL domain core
[    4.752590] intel_rapl_common: Found RAPL domain uncore
[    4.752591] intel_rapl_common: Found RAPL domain psys
[    4.752886] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz=
, REV=3D0x351
[    4.752992] thermal thermal_zone7: failed to read out thermal zone (-61)
[    4.785397] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    4.833059] iTCO_vendor_support: vendor-support=3D0
[    4.841576] Bluetooth: Core ver 2.22
[    4.846695] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.851919] NET: Registered PF_BLUETOOTH protocol family
[    4.851921] Bluetooth: HCI device and connection manager initialized
[    4.851926] Bluetooth: HCI socket layer initialized
[    4.851928] Bluetooth: L2CAP socket layer initialized
[    4.851931] Bluetooth: SCO socket layer initialized
[    4.886190] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[    4.886473] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    4.888186] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    4.925236] Adding 1017920k swap on /dev/zram0.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    4.927600] zram: Added device: zram1
[    4.928710] zram1: detected capacity change from 0 to 2035848
[    4.951225] iwlwifi 0000:00:14.3: base HW address: f4:a4:75:a3:7a:91
[    5.011196] mousedev: PS/2 mouse device common for all mice
[    5.026301] input: SYNA8008:00 06CB:CE58 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-9/i2c-SYNA8008:00/0018:06CB:CE58.0003/input=
/input14
[    5.026374] input: SYNA8008:00 06CB:CE58 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-9/i2c-SYNA8008:00/0018:06CB:CE58.0003/in=
put/input15
[    5.026430] hid-multitouch 0018:06CB:CE58.0003: input,hidraw2: I2C HID v=
1.00 Mouse [SYNA8008:00 06CB:CE58] on i2c-SYNA8008:00
[    5.030592] usbcore: registered new interface driver btusb
[    5.075305] typec port1: bound usb3-port6 (ops connector_ops)
[    5.075316] typec port1: bound usb2-port3 (ops connector_ops)
[    5.181209] kauditd_printk_skb: 196 callbacks suppressed
[    5.181214] audit: type=3D1334 audit(1650367240.839:194): prog-id=3D69 o=
p=3DLOAD
[    5.186064] audit: type=3D1334 audit(1650367240.843:195): prog-id=3D70 o=
p=3DLOAD
[    5.187925] Adding 1017920k swap on /dev/zram1.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    5.188239] audit: type=3D1334 audit(1650367240.846:196): prog-id=3D71 o=
p=3DLOAD
[    5.189697] audit: type=3D1334 audit(1650367240.846:197): prog-id=3D72 o=
p=3DLOAD
[    5.190102] audit: type=3D1130 audit(1650367240.846:198): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dpolipo comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[    5.190915] audit: type=3D1334 audit(1650367240.846:199): prog-id=3D73 o=
p=3DLOAD
[    5.197226] audit: type=3D1130 audit(1650367240.853:200): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsshd comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
[    5.199088] audit: type=3D1130 audit(1650367240.856:201): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsyncthing@alrua comm=3D"=
systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D=
? res=3Dsuccess'
[    5.213214] zram: Added device: zram2
[    5.213408] audit: type=3D1130 audit(1650367240.869:202): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Drpc-statd-notify comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[    5.214041] audit: type=3D1130 audit(1650367240.869:203): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-user-sessions co=
mm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termi=
nal=3D? res=3Dsuccess'
[    5.215124] zram2: detected capacity change from 0 to 2035848
[    5.268206] NET: Registered PF_ALG protocol family
[    5.286361] mc: Linux media interface: v0.10
[    5.364649] videodev: Linux video capture interface: v2.00
[    5.483103] Adding 1017920k swap on /dev/zram2.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    5.490782] zram: Added device: zram3
[    5.491940] zram3: detected capacity change from 0 to 2035848
[    5.553322] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI =
class/subclass/prog-if info 0x040380
[    5.573986] sof-audio-pci-intel-tgl 0000:00:1f.3: Digital mics found on =
Skylake+ platform, using SOF driver
[    5.580304] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI =
class/subclass/prog-if 0x040380
[    5.580806] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (op=
s i915_audio_component_bind_ops [i915])
[    5.589821] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[    5.670107] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask=
 5
[    5.670113] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driv=
er skl_hda_dsp_generic now
[    5.670118] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT=
 tables: 4
[    5.672271] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version=
 2:1:1-3964a
[    5.672276] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:21:0 K=
ernel ABI 3:18:0
[    5.672279] sof-audio-pci-intel-tgl 0000:00:1f.3: warn: FW ABI is more r=
ecent than kernel
[    5.672284] sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man he=
ader type 3 size 0x30
[    5.720157] usb 3-4: Found UVC 1.10 device Integrated Camera (04f2:b6ea)
[    5.728119] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:14.0/usb3/3-4/3-4:1.0/input/input17
[    5.728529] usb 3-4: Found UVC 1.50 device Integrated Camera (04f2:b6ea)
[    5.729010] input: Integrated Camera: Integrated I as /devices/pci0000:0=
0/0000:00:14.0/usb3/3-4/3-4:1.2/input/input18
[    5.729275] usbcore: registered new interface driver uvcvideo
[    5.769169] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version=
 2:1:1-3964a
[    5.769178] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:21:0 K=
ernel ABI 3:18:0
[    5.769180] sof-audio-pci-intel-tgl 0000:00:1f.3: warn: FW ABI is more r=
ecent than kernel
[    5.785297] Adding 1017920k swap on /dev/zram3.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    5.792296] zram: Added device: zram4
[    5.793566] zram4: detected capacity change from 0 to 2035848
[    5.825464] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:21:0 K=
ernel ABI 3:18:0
[    5.825471] sof-audio-pci-intel-tgl 0000:00:1f.3: warn: topology ABI is =
more recent than kernel
[    5.826478] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Parent card n=
ot yet available, widget card binding deferred
[    5.861588] snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC287: li=
ne_outs=3D2 (0x14/0x17/0x0/0x0/0x0) type:speaker
[    5.861595] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    5.861597] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    5.861600] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=3D0x0
[    5.861601] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[    5.861602] snd_hda_codec_realtek ehdaudio0D0:      Mic=3D0x19
[    5.948546] snd_hda_codec_realtek ehdaudio0D0: ASoC: sink widget AIF1TX =
overwritten
[    5.948556] snd_hda_codec_realtek ehdaudio0D0: ASoC: source widget AIF1R=
X overwritten
[    5.948716] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget h=
ifi3 overwritten
[    5.948720] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget h=
ifi2 overwritten
[    5.948725] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget h=
ifi1 overwritten
[    5.948728] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget=
 Codec Output Pin1 overwritten
[    5.948731] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget C=
odec Input Pin1 overwritten
[    5.948737] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget A=
nalog Codec Playback overwritten
[    5.948743] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget D=
igital Codec Playback overwritten
[    5.948748] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget A=
lt Analog Codec Playback overwritten
[    5.948755] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget=
 Analog Codec Capture overwritten
[    5.948760] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget=
 Digital Codec Capture overwritten
[    5.948766] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget=
 Alt Analog Codec Capture overwritten
[    5.948779] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 3
[    5.948781] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 4
[    5.948783] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 5
[    5.948785] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 6
[    5.948787] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 7
[    5.948788] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_=
controls: no PCM in topology for HDMI converter 8
[    5.976682] input: sof-hda-dsp Mic as /devices/pci0000:00/0000:00:1f.3/s=
kl_hda_dsp_generic/sound/card0/input19
[    5.976778] input: sof-hda-dsp Headphone as /devices/pci0000:00/0000:00:=
1f.3/skl_hda_dsp_generic/sound/card0/input20
[    5.977362] input: sof-hda-dsp HDMI/DP,pcm=3D3 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input21
[    5.977423] input: sof-hda-dsp HDMI/DP,pcm=3D4 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input22
[    5.977455] input: sof-hda-dsp HDMI/DP,pcm=3D5 as /devices/pci0000:00/00=
00:00:1f.3/skl_hda_dsp_generic/sound/card0/input23
[    6.113718] Adding 1017920k swap on /dev/zram4.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    6.126610] zram: Added device: zram5
[    6.127933] zram5: detected capacity change from 0 to 2035848
[    6.430793] Adding 1017920k swap on /dev/zram5.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    6.435794] zram: Added device: zram6
[    6.437635] zram6: detected capacity change from 0 to 2035848
[    6.700632] Adding 1017920k swap on /dev/zram6.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[    6.704505] zram: Added device: zram7
[    6.705803] zram7: detected capacity change from 0 to 2035848
[    6.826028] wlan0: authenticate with 4c:60:de:ea:b8:58
[    6.826043] wlan0: bad VHT capabilities, disabling VHT
[    6.826044] wlan0: 80 MHz not supported, disabling VHT
[    6.832644] wlan0: send auth to 4c:60:de:ea:b8:58 (try 1/3)
[    6.859513] wlan0: authenticated
[    6.864403] wlan0: associate with 4c:60:de:ea:b8:58 (try 1/3)
[    6.866131] wlan0: RX AssocResp from 4c:60:de:ea:b8:58 (capab=3D0x431 st=
atus=3D0 aid=3D2)
[    6.873864] wlan0: associated
[    6.991026] Adding 1017920k swap on /dev/zram7.  Priority:32767 extents:=
1 across:1017920k SSDscFS
[   10.477842] kauditd_printk_skb: 244 callbacks suppressed
[   10.477845] audit: type=3D1334 audit(1650367246.136:446): prog-id=3D0 op=
=3DUNLOAD
[   10.477850] audit: type=3D1334 audit(1650367246.136:447): prog-id=3D0 op=
=3DUNLOAD
[   10.477852] audit: type=3D1334 audit(1650367246.136:448): prog-id=3D0 op=
=3DUNLOAD
[   10.477855] audit: type=3D1334 audit(1650367246.136:449): prog-id=3D0 op=
=3DUNLOAD
[   10.477857] audit: type=3D1334 audit(1650367246.136:450): prog-id=3D0 op=
=3DUNLOAD
[   10.477860] audit: type=3D1334 audit(1650367246.136:451): prog-id=3D0 op=
=3DUNLOAD
[   10.477862] audit: type=3D1334 audit(1650367246.136:452): prog-id=3D0 op=
=3DUNLOAD
[   10.477864] audit: type=3D1334 audit(1650367246.136:453): prog-id=3D0 op=
=3DUNLOAD
[   10.477866] audit: type=3D1334 audit(1650367246.136:454): prog-id=3D0 op=
=3DUNLOAD
[   10.477869] audit: type=3D1334 audit(1650367246.136:455): prog-id=3D0 op=
=3DUNLOAD
[   10.499417] fbcon: Taking over console
[   10.519406] Console: switching to colour frame buffer device 240x75
[   15.357563] wlan0: disconnect from AP 4c:60:de:ea:b8:58 for new auth to =
4c:60:de:ea:b8:5a
[   15.445521] wlan0: authenticate with 4c:60:de:ea:b8:5a
[   15.445542] wlan0: bad VHT capabilities, disabling VHT
[   15.451251] wlan0: send auth to 4c:60:de:ea:b8:5a (try 1/3)
[   15.479061] wlan0: authenticated
[   15.479111] wlan0: VHT capa missing/short, disabling VHT/HE
[   15.481221] wlan0: associate with 4c:60:de:ea:b8:5a (try 1/3)
[   15.483186] wlan0: RX ReassocResp from 4c:60:de:ea:b8:5a (capab=3D0x11 s=
tatus=3D0 aid=3D3)
[   15.487392] wlan0: associated
[   18.163950] kauditd_printk_skb: 9 callbacks suppressed
[   18.163955] audit: type=3D1100 audit(1650367253.819:465): pid=3D1069 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication gran=
tors=3Dpam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct=
=3D"alrua" exe=3D"/usr/bin/login" hostname=3Dalrua-x1 addr=3D? terminal=3D/=
dev/tty1 res=3Dsuccess'
[   18.164107] audit: type=3D1101 audit(1650367253.819:466): pid=3D1069 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"alrua" exe=3D"/usr/bin/l=
ogin" hostname=3Dalrua-x1 addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
[   18.164821] audit: type=3D1103 audit(1650367253.823:467): pid=3D1069 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct=3D"alrua=
" exe=3D"/usr/bin/login" hostname=3Dalrua-x1 addr=3D? terminal=3D/dev/tty1 =
res=3Dsuccess'
[   18.164916] audit: type=3D1006 audit(1650367253.823:468): pid=3D1069 uid=
=3D0 old-auid=3D4294967295 auid=3D1000 tty=3Dtty1 old-ses=3D4294967295 ses=
=3D2 res=3D1
[   18.164925] audit: type=3D1300 audit(1650367253.823:468): arch=3Dc000003=
e syscall=3D1 success=3Dyes exit=3D4 a0=3D5 a1=3D7ffe88ebc820 a2=3D4 a3=3D0=
 items=3D0 ppid=3D1 pid=3D1069 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0 egid=3D0 sgid=3D100 fsgid=3D0 tty=3Dtty1 ses=3D2 comm=3D"login"=
 exe=3D"/usr/bin/login" key=3D(null)
[   18.164929] audit: type=3D1327 audit(1650367253.823:468): proctitle=3D2F=
62696E2F6C6F67696E002D70002D2D
[   18.178413] audit: type=3D1105 audit(1650367253.836:469): pid=3D1069 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginu=
id,pam_keyinit,pam_systemd_home,pam_limits,pam_unix,pam_permit,pam_mail,pam=
_systemd,pam_env acct=3D"alrua" exe=3D"/usr/bin/login" hostname=3Dalrua-x1 =
addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
[   18.178499] audit: type=3D1110 audit(1650367253.836:470): pid=3D1069 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred grantors=3Dpam_securetty,p=
am_shells,pam_faillock,pam_permit,pam_faillock acct=3D"alrua" exe=3D"/usr/b=
in/login" hostname=3Dalrua-x1 addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
[   18.798844] tun: Universal TUN/TAP device driver, 1.6
[   19.440933] audit: type=3D1130 audit(1650367255.098:471): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Drtkit-daemon comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[   20.008303] audit: type=3D1130 audit(1650367255.677:472): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dbluetooth comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   20.014723] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.014725] Bluetooth: BNEP filters: protocol multicast
[   20.014729] Bluetooth: BNEP socket layer initialized
[   39.112761] kauditd_printk_skb: 7 callbacks suppressed
[   39.112766] audit: type=3D1130 audit(1650367274.932:480): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dkill-scdaemon comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
[   39.112775] audit: type=3D1131 audit(1650367274.932:481): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dkill-scdaemon comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
[   39.169171] PM: suspend entry (s2idle)
[   39.191854] Filesystems sync: 0.022 seconds
[   39.261199] audit: type=3D1130 audit(1650367275.079:482): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dautorandr comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   39.261211] audit: type=3D1131 audit(1650367275.079:483): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dautorandr comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   39.278244] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[   39.279971] OOM killer disabled.
[   39.279972] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[   39.281129] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   39.282288] wlan0: deauthenticating from 4c:60:de:ea:b8:5a by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[   39.471272] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Co=
uldn't get ACK from CSME on HOST_GOES_DOWN message
[   39.471376] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: fa=
iled to send the SAP_ME_MSG_CHECK_SHARED_AREA message -19
[   39.992947] ACPI: EC: interrupt blocked
[   44.455046] ACPI: EC: interrupt unblocked
[   44.987409] nvme nvme0: Shutdown timeout set to 10 seconds
[   44.988776] nvme nvme0: 8/0/0 default/read/poll queues
[   45.102503] i915 0000:00:02.0: [drm] GuC firmware i915/tgl_guc_62.0.0.bi=
n version 62.0 submission:disabled
[   45.102508] i915 0000:00:02.0: [drm] GuC SLPC: disabled
[   45.102509] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc_7.9.3.bin=
 version 7.9 authenticated:yes
[   45.474077] OOM killer enabled.
[   45.474079] Restarting tasks ...=20
[   45.474278] usb 3-3: USB disconnect, device number 2
[   45.477951] done.
[   45.488574] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[   45.489897] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[   45.490234] thermal thermal_zone7: failed to read out thermal zone (-61)
[   45.558079] PM: suspend exit
[   45.628544] usb 3-3: new full-speed USB device number 6 using xhci_hcd
[   45.774171] usb 3-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00fc, bcdDevice=3D 0.00
[   45.774179] usb 3-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[   45.774182] usb 3-3: SerialNumber: 7b571cd95cd2
[   45.822570] audit: type=3D1130 audit(1650367281.402:484): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"=
systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D=
? res=3Dsuccess'
[   45.822581] audit: type=3D1131 audit(1650367281.402:485): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"=
systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D=
? res=3Dsuccess'
[   45.824684] audit: type=3D1130 audit(1650367281.402:486): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dwg-reload comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   45.838867] audit: type=3D1131 audit(1650367281.418:487): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dwg-reload comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   49.278479] audit: type=3D1100 audit(1650367284.862:488): pid=3D2437 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:unix_chkpwd acct=3D"alrua" exe=
=3D"/usr/bin/unix_chkpwd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   56.895620] audit: type=3D1131 audit(1650367292.483:489): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   56.897628] audit: type=3D1334 audit(1650367292.486:490): prog-id=3D187 =
op=3DLOAD
[   56.910135] audit: type=3D1130 audit(1650367292.496:491): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   56.923952] audit: type=3D1334 audit(1650367292.513:492): prog-id=3D0 op=
=3DUNLOAD
[   58.212917] wlan0: authenticate with 4c:60:de:ea:b8:58
[   58.212938] wlan0: bad VHT capabilities, disabling VHT
[   58.212940] wlan0: 80 MHz not supported, disabling VHT
[   58.220279] wlan0: send auth to 4c:60:de:ea:b8:58 (try 1/3)
[   58.247170] wlan0: authenticated
[   58.250141] wlan0: associate with 4c:60:de:ea:b8:58 (try 1/3)
[   58.252280] wlan0: RX AssocResp from 4c:60:de:ea:b8:58 (capab=3D0x431 st=
atus=3D0 aid=3D2)
[   58.259536] wlan0: associated
[   60.181028] audit: type=3D1100 audit(1650367295.770:493): pid=3D2459 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:authentication grantors=3Dpam_f=
aillock,pam_permit,pam_faillock acct=3D"alrua" exe=3D"/usr/bin/sudo" hostna=
me=3D? addr=3D? terminal=3D/dev/pts/1 res=3Dsuccess'
[   60.181034] audit: type=3D1101 audit(1650367295.770:494): pid=3D2459 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,=
pam_permit,pam_time acct=3D"alrua" exe=3D"/usr/bin/sudo" hostname=3D? addr=
=3D? terminal=3D/dev/pts/1 res=3Dsuccess'
[   60.181595] audit: type=3D1110 audit(1650367295.770:495): pid=3D2459 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock=
,pam_permit,pam_faillock acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? a=
ddr=3D? terminal=3D/dev/pts/1 res=3Dsuccess'
[   60.183268] audit: type=3D1105 audit(1650367295.774:496): pid=3D2459 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_sys=
temd_home,pam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin/sudo=
" hostname=3D? addr=3D? terminal=3D/dev/pts/1 res=3Dsuccess'
