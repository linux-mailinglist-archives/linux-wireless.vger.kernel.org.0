Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087BB25AE0C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIBO6g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 10:58:36 -0400
Received: from mail.yujinakao.com ([107.191.43.40]:55130 "EHLO
        mail.yujinakao.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBNzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 09:55:54 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2020 09:55:43 EDT
Received: from localhost (p1493061-omed01.osaka.ocn.ne.jp [153.249.196.60])
        by mail.yujinakao.com (Postfix) with ESMTPSA id C844C7D013
        for <linux-wireless@vger.kernel.org>; Wed,  2 Sep 2020 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yujinakao.com;
        s=201707; t=1599054491;
        bh=iaDwSu31puB139lZXPEBGGxzXRoZSJ5NRRIC4OpCFHs=;
        h=From:To:Subject:Date:From;
        b=qWEuTKHtP9WCUQ8ydV2916hal1uYfB0xY7pEcxPrI3wjrKypyMEQQTv6c4hIP7I0v
         MtNfsU5TOdc4hXBH8v3d580YMgn/9tpgK+WwgRmsYu5NN3J5IEpzDe4SPUkN4GfflY
         rOBeyeKKRQ9orMbBMHceeVqTSGEdNhot8EdNjvaNe6mCNZDR8HVRLRqI6MWGMNPBS2
         fCESCGoLuZtWZCvWxORI3M1NJq1mOpq/8YFNcPSVxIdjulDUH/+SR+aG5hHJSt8MNn
         dZIgxl56RV1y/oMTxdjvM88np4IsIaQXKMKAMDyaMiwW+1PU+/FVR77Df8L+20HxsP
         5l84yofC44bfA==
From:   Yuji Nakao <contact@yujinakao.com>
To:     linux-wireless@vger.kernel.org
Subject: kernel panic caused by brcmsmac Broadcom driver?
Date:   Wed, 02 Sep 2020 22:48:00 +0900
Message-ID: <87tuwgi92n.fsf@yujinakao.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hello,

Around this one or two weeks, my MacBook Air 2010 installed in Arch
Linux has been caught in kernel panic during data transmission over
wireless connection.

At first, I encountered this issue after upgrading kernel to v5.8, so
I thought the issue was specific to that version. But the issue is
persistent even after downgrading kernel to v5.7.12 and linux-lts
(v5.4.61). I found the similar issue in Arch Forum[0] and this mailing
list[1].

So now, my assumption is this issue comes from other Broadcom driver
updates or my broken hardware.

Here's my kernel panic log and other information with reference to
Kdump ArchWiki[2]. Any suggestions?

[0] https://bbs.archlinux.org/viewtopic.php?id=3D258428
[1] https://lore.kernel.org/linux-wireless/CAGzOMfGZ9nYk7ESvWYspBOQMWre7WnC=
VLO4Q6+8mvSQOkoXUKg@mail.gmail.com/
[2] https://wiki.archlinux.org/index.php/Kdump


# Wireless device
% lspci -vnn -d 14e4:
01:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries BCM43224 =
802.11a/b/g/n [14e4:4353] (rev 01)
        Subsystem: Apple Inc. AirPort Extreme [106b:00d1]
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at 93100000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: <access denied>
        Kernel driver in use: bcma-pci-bridge
        Kernel modules: bcma

# Analyze dump file using crash
% crash vmlinux_kdump crash_kdump_200902.dump
...
This GDB was configured as "x86_64-unknown-linux-gnu"...

WARNING: kernel relocated [10MB]: patching 116700 gdb minimal_symbol values

      KERNEL: vmlinux_kdump
    DUMPFILE: crash_kdump_200902.dump  [PARTIAL DUMP]
        CPUS: 2
        DATE: Wed Sep  2 15:21:00 2020
      UPTIME: 00:03:49
LOAD AVERAGE: 0.09, 0.31, 0.16
       TASKS: 145
    NODENAME: archmba
     RELEASE: 5.8.5-arch1-1-kdump
     VERSION: #1 SMP PREEMPT Tue, 01 Sep 2020 03:08:29 +0000
     MACHINE: x86_64  (1397 Mhz)
      MEMORY: 1.7 GB
       PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" (check log for details)
         PID: 0
     COMMAND: "swapper/1"
        TASK: ffff8fc6aa5b0000  (1 of 2)  [THREAD_INFO: ffff8fc6aa5b0000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

# Backtrace
crash> bt
PID: 0      TASK: ffff8fc6aa5b0000  CPU: 1   COMMAND: "swapper/1"
 #0 [ffffa742800ecab0] machine_kexec at ffffffff81a69fb0
 #1 [ffffa742800ecb10] __crash_kexec at ffffffff81b4b8f8
 #2 [ffffa742800ecbd8] panic at ffffffff81a9270f
 #3 [ffffa742800ecc58] oops_end.cold at ffffffff81a2ef51
 #4 [ffffa742800ecc78] no_context at ffffffff81a792a9
 #5 [ffffa742800eccf0] exc_page_fault at ffffffff823fe47d
 #6 [ffffa742800ecd20] asm_exc_page_fault at ffffffff82600ade
 #7 [ffffa742800ecda8] brcms_c_ampdu_dotxstatus at ffffffffc0e4ac33 [brcmsm=
ac]
 #8 [ffffa742800ece60] brcms_c_dpc at ffffffffc0e551b6 [brcmsmac]
 #9 [ffffa742800ecf48] brcms_dpc at ffffffffc0e49297 [brcmsmac]
#10 [ffffa742800ecf70] tasklet_action_common.constprop.0 at ffffffff81a99531
#11 [ffffa742800ecf98] __softirqentry_text_start at ffffffff828000ff
#12 [ffffa742800ecff0] asm_call_on_stack at ffffffff826010b2
--- <IRQ stack> ---
#13 [ffffa742800a7d38] asm_call_on_stack at ffffffff826010b2
    RIP: 0000000000000000  RSP: 0000000000000003  RFLAGS: 358667742e
    RAX: ffffffff823fbb91  RBX: ffffa742800a7dc8  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffffa742800a7dc8   R8: 0000000000000001   R9: ffffffff81a992ab
    R10: 0000000000000040  R11: ffffffff81a2e3cf  R12: ffffa742800ed000
    R13: ffff8fc6aa5b0000  R14: 0000000000018740  R15: 0000000000000046
    ORIG_RAX: 0000000000000000  CS: ffffffff82600c1e  SS: ffff8fc6aad36700
bt: WARNING: possibly bogus exception frame

# Crash log (trancated)
crash> log
...
[  229.888324] BUG: unable to handle page fault for address: ffffa742800ed0=
1f
[  229.888471] #PF: supervisor read access in kernel mode
[  229.888549] #PF: error_code(0x0000) - not-present page
[  229.888625] PGD 6a4e9067 P4D 6a4e9067 PUD 6a4ec067 PMD 6a4ed067 PTE 0
[  229.888726] Oops: 0000 [#1] PREEMPT SMP PTI
[  229.888793] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted 5.8.=
5-arch1-1-kdump #1
[  229.888906] Hardware name: Apple Inc. MacBookAir3,1/Mac-942452F5819B1C1B=
, BIOS    MBA31.88Z.0061.B07.1201241641 01/24/12
[  229.889087] RIP: 0010:brcms_c_ampdu_dotxstatus+0x343/0x9f0 [brcmsmac]
[  229.889182] Code: 54 24 20 66 81 e2 ff 0f 41 83 e4 07 89 d1 0f b7 d2 66 =
c1 e9 03 0f b7 c9 4c 8d 5c 0c 48 49 8b 4d 10 48 8b 79 68 41 57 44 89 e1 <41=
> 0f b6 33 41 d3 e0 48 c7 c1 38 e0 ea c0 48 83 c7 10 44 21 c6 4c
[  229.889421] RSP: 0018:ffffa742800ecdd0 EFLAGS: 00010207
[  229.889499] RAX: 0000000000000019 RBX: 000000000000000b RCX: 00000000000=
00006
[  229.889596] RDX: 0000000000000ffe RSI: 0000000000000004 RDI: ffff8fc6ad7=
76800
[  229.889693] RBP: ffff8fc6855acb00 R08: 0000000000000001 R09: 00000000000=
005d9
[  229.889791] R10: 00000000fffffffe R11: ffffa742800ed01f R12: 00000000000=
00006
[  229.889889] R13: ffff8fc68d75a000 R14: 00000000000005db R15: 00000000000=
00019
[  229.889989] FS:  0000000000000000(0000) GS:ffff8fc6aad00000(0000) knlGS:=
0000000000000000
[  229.890100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.890181] CR2: ffffa742800ed01f CR3: 000000002480a000 CR4: 00000000000=
406e0
[  229.890279] Call Trace:
[  229.890327]  <IRQ>
[  229.890399]  brcms_c_dpc+0xb46/0x1020 [brcmsmac]
[  229.890499]  ? wlc_intstatus+0xc8/0x180 [brcmsmac]
[  229.890583]  ? __raise_softirq_irqoff+0x1a/0x80
[  229.890674]  brcms_dpc+0x37/0xd0 [brcmsmac]
[  229.890743]  tasklet_action_common.constprop.0+0x51/0xb0
[  229.890828]  __do_softirq+0xff/0x340
[  229.890892]  ? handle_level_irq+0x1a0/0x1a0
[  229.890956]  asm_call_on_stack+0x12/0x20
[  229.891017]  </IRQ>
[  229.891061]  do_softirq_own_stack+0x5f/0x80
[  229.891127]  irq_exit_rcu+0xcb/0x120
[  229.891186]  common_interrupt+0xd1/0x200
[  229.891251]  asm_common_interrupt+0x1e/0x40
[  229.891320] RIP: 0010:cpuidle_enter_state+0xb3/0x420
[  229.891396] Code: 65 8b 3d d0 de e1 7d e8 8b a3 8d ff 49 89 c7 66 66 66 =
66 90 31 ff e8 bc b1 8d ff 80 7c 24 0f 00 0f 85 06 02 00 00 fb 66 66 90 <66=
> 66 90 45 85 e4 0f 88 e9 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d
[  229.891534] RSP: 0018:ffffa742800a7e78 EFLAGS: 00000246
[  229.891534] RAX: ffff8fc6aad00000 RBX: ffff8fc6aad36700 RCX: 00000035866=
772ed
[  229.891534] RDX: 0000000000000141 RSI: ffffffff82d6accf RDI: ffffffff82d=
74e41
[  229.891534] RBP: ffffffff830c9f20 R08: 000000358667742e R09: 00000000000=
00018
[  229.891534] R10: 0000000000000442 R11: 00000000000008fb R12: 00000000000=
00003
[  229.891534] R13: ffff8fc6aad36700 R14: 0000000000000003 R15: 00000035866=
7742e
[  229.891534]  ? cpuidle_enter_state+0xa4/0x420
[  229.891534]  cpuidle_enter+0x29/0x40
[  229.891534]  do_idle+0x1fb/0x2c0
[  229.910611]  cpu_startup_entry+0x19/0x20
[  229.910611]  start_secondary+0x178/0x1c0
[  229.917360]  secondary_startup_64+0xb6/0xc0
[  229.920686] Modules linked in: btusb btrtl btbcm btintel bluetooth ecdh_=
generic input_leds ecc crc16 mousedev hid_generic usbhid hid brcmsmac brcmu=
til uvcvideo b43 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf=
2_common videodev mc cordic apple_mfi_fastcharge nouveau mac80211 cpufreq_o=
ndemand ssb mmc_core cfg80211 pcmcia rfkill ccm algif_aead pcmcia_core des_=
generic libdes rng_core arc4 libarc4 nft_ct cbc nf_conntrack nf_defrag_ipv6=
 nf_defrag_ipv4 ecb algif_skcipher kvm_intel nft_limit cmac nf_tables md4 a=
lgif_hash nfnetlink af_alg coretemp mxm_wmi wmi i2c_algo_bit kvm ttm drm_km=
s_helper snd_hda_codec_hdmi applesmc snd_hda_codec_cirrus snd_hda_codec_gen=
eric ledtrig_audio nls_iso8859_1 nls_cp437 vfat snd_hda_intel snd_intel_dsp=
cfg fat snd_hda_codec snd_hda_core cec irqbypass snd_hwdep pcspkr rc_core s=
nd_pcm snd_timer syscopyarea sysfillrect snd bcma sysimgblt fb_sys_fops sou=
ndcore sbs sbshc evdev mac_hid ac acpi_cpufreq drm fuse pkcs8_key_parser cr=
ypto_user agpgart ip_tables
[  229.920686]  x_tables xfs libcrc32c crc32c_generic ohci_pci ehci_pci ehc=
i_hcd ohci_hcd
[  229.950604] CR2: ffffa742800ed01f
[  229.950604] ---[ end trace c95ca5e232e4ae06 ]---
[  229.950604] RIP: 0010:brcms_c_ampdu_dotxstatus+0x343/0x9f0 [brcmsmac]
[  229.960606] Code: 54 24 20 66 81 e2 ff 0f 41 83 e4 07 89 d1 0f b7 d2 66 =
c1 e9 03 0f b7 c9 4c 8d 5c 0c 48 49 8b 4d 10 48 8b 79 68 41 57 44 89 e1 <41=
> 0f b6 33 41 d3 e0 48 c7 c1 38 e0 ea c0 48 83 c7 10 44 21 c6 4c
[  229.967258] RSP: 0018:ffffa742800ecdd0 EFLAGS: 00010207
[  229.967258] RAX: 0000000000000019 RBX: 000000000000000b RCX: 00000000000=
00006
[  229.967258] RDX: 0000000000000ffe RSI: 0000000000000004 RDI: ffff8fc6ad7=
76800
[  229.967258] RBP: ffff8fc6855acb00 R08: 0000000000000001 R09: 00000000000=
005d9
[  229.967258] R10: 00000000fffffffe R11: ffffa742800ed01f R12: 00000000000=
00006
[  229.967258] R13: ffff8fc68d75a000 R14: 00000000000005db R15: 00000000000=
00019
[  229.967258] FS:  0000000000000000(0000) GS:ffff8fc6aad00000(0000) knlGS:=
0000000000000000
[  229.967258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.967258] CR2: ffffa742800ed01f CR3: 000000002480a000 CR4: 00000000000=
406e0
[  229.967258] Kernel panic - not syncing: Fatal exception in interrupt
[  229.967258] Kernel Offset: 0xa00000 from 0xffffffff81000000 (relocation =
range: 0xffffffff80000000-0xffffffffbfffffff)


--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEETYVHHTrlVWkmzOhy22IiAuK1hSMFAl9PopEACgkQ22IiAuK1
hSOBeRAAl8z3pqodyfhXksCPVsk972spSQWGi6eE43cLkrtvhRonWPfI5XHY0hSM
wOmYnaIgTcfpuKp2WJ+3r/u5m5LbicgihK7/UQpfN+EheLwab95SlegUdnvqTio0
MoTJNPcOjCnzOumEh/nlOo/ymCVUDgVmd6ASFw8eF0i4DC/pAaTVCD7qelh5CDQ2
ltwMcUWofvihGThlbnXUlz9inSvDyo11KDpoRSReFHrm2iBgtWs9SMfTR77msONW
emGgOnUxisa4r9vR5q1k+KeodgSQNJ1RfGg/0AqCNDIdLObbi+Q5s8wXcU7vuUNJ
Vn/cVN3/jFzdJlzsq89fWVcil8aIisErziQWJhN7uxk52V2DUnkmNGStpBxi3fpc
RHVC7YfI11wTNKTmYY1dBYD+yGYcBmzd8xAVg3K+B2xd8QMcKYGPKIFibsggP2JK
PNam0xCgJ5zuxd+A1c9iYgoIpltYFKjLuyoMtQp6pcn9fuoDOqU11KdCaNgr/RWe
uJ34PYU5DzAUk8gEfU6UCLG1fbwe22bU1qc3yp+/P4v0bp4YZc9Uj55ldVfjGjoV
gcO3pi6Tu0LxWc0vHyJmfHE+9LoszSWkRLqNnfo3VzGjAJgacA5ZuX5OvE3kMNqL
UgOy9WgOU/KH2LnLO8C0SJ1CPFR4d4uoN/Je1vzXXdKUTfZOWik=
=WKya
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
