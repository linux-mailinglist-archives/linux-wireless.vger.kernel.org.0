Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC01A8AB5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504742AbgDNT2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 15:28:39 -0400
Received: from mout01.posteo.de ([185.67.36.65]:55749 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504730AbgDNT2a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 15:28:30 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 80403160061
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 21:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1586892502; bh=AgIxPWSPwSsbBltP5IaTHA0VNesC1dvvlyr6hSCsxvg=;
        h=Date:From:To:Subject:From;
        b=UTRg4ckFr6z4ONeGU1xrJ5yOkv8r1hXYXTEH7gk4jU6SmUVovlHZweEyNu0KWhsLc
         ceKDUdaDgra+W7zEpiQW7B98HH3xk5/20WlGWkowAJY0R0aScKnhdrARGE8/LN771c
         JT/Abh9+0v1w6hOZY4q8l/QVe1H9+JwaLclu8fISEc8XW9+KI1t3jLj8ypPFH1JLSl
         jiSCVMXGvXXiB+QxWn58IYMdPdQLHxKLzDMEHwPXwiRO1MWsKiGtzIl0Tp2ePJsR1V
         B5z2wNhugmYCLIIgM/G+hoJhIRYch4j5u9mBX4vFRJamvaTBuYKXzIoigokQ312Pqf
         q6ZllAG72D2RA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 491wWT6MS3z9rxc
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 21:28:21 +0200 (CEST)
Date:   Tue, 14 Apr 2020 21:32:12 +0200
From:   Ivan Stankovic <istankovic@posteo.net>
To:     linux-wireless@vger.kernel.org
Subject: iwlwifi not working properly with 5.6.3
Message-ID: <20200414193212.GA8489@alpha3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've just upgraded to 5.6.3 hoping that the iwlwifi issue I've been
seeing is fixed, however, that is not the case. The driver manages to
associate and at first all seems well, but it quickly runs into trouble
and my wifi becomes terribly slow, basically unusable.

The device:

  Intel Corporation Wireless 8265 / 8275 [8086:24fd] (rev 78).

I've been seeing the message

    BIOS contains WGDS but no WRDS

(please see attached log for details) similar to what others had
reported, but it does not seem like the recent fixes helped with my
issue.  Do you know what might be causing this?

-- 
Ivan Stankovic, istankovic@posteo.net

"Protect your digital freedom and privacy, eliminate DRM, 
learn more at http://www.defectivebydesign.org/what_is_drm"

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: quoted-printable

[11210.713858] iwlwifi 0000:02:00.0: Queue 11 is active on fifo 1 and stuck=
 for 10000 ms. SW [72, 116] HW [72, 116] FH TRB=3D0x0c010b057
[11210.714064] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarti=
ng 0x2000000.
[11210.714298] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[11210.714301] iwlwifi 0000:02:00.0: Status: 0x00000040, count: 6
[11210.714303] iwlwifi 0000:02:00.0: Loaded firmware version: 36.77d01142.0=
 8265-36.ucode
[11210.714306] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN    =
  =20
[11210.714309] iwlwifi 0000:02:00.0: 0x008006B4 | trm_hw_status0
[11210.714311] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[11210.714313] iwlwifi 0000:02:00.0: 0x000248EC | branchlink2
[11210.714314] iwlwifi 0000:02:00.0: 0x0003A862 | interruptlink1
[11210.714316] iwlwifi 0000:02:00.0: 0x00026F5A | interruptlink2
[11210.714318] iwlwifi 0000:02:00.0: 0x00000000 | data1
[11210.714320] iwlwifi 0000:02:00.0: 0x00000080 | data2
[11210.714322] iwlwifi 0000:02:00.0: 0x07830000 | data3
[11210.714324] iwlwifi 0000:02:00.0: 0x08415D42 | beacon time
[11210.714325] iwlwifi 0000:02:00.0: 0x7E07B2C5 | tsf low
[11210.714327] iwlwifi 0000:02:00.0: 0x00000054 | tsf hi
[11210.714329] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[11210.714331] iwlwifi 0000:02:00.0: 0x9B52CEFC | time gp2
[11210.714332] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[11210.714334] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
[11210.714336] iwlwifi 0000:02:00.0: 0x77D01142 | uCode version minor
[11210.714338] iwlwifi 0000:02:00.0: 0x00000230 | hw version
[11210.714340] iwlwifi 0000:02:00.0: 0x00C89000 | board version
[11210.714341] iwlwifi 0000:02:00.0: 0x0B48001C | hcmd
[11210.714343] iwlwifi 0000:02:00.0: 0x80022002 | isr0
[11210.714345] iwlwifi 0000:02:00.0: 0x01800000 | isr1
[11210.714346] iwlwifi 0000:02:00.0: 0x0800180A | isr2
[11210.714348] iwlwifi 0000:02:00.0: 0x004128C4 | isr3
[11210.714350] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[11210.714352] iwlwifi 0000:02:00.0: 0x00D7019C | last cmd Id
[11210.714353] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[11210.714355] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[11210.714357] iwlwifi 0000:02:00.0: 0x00012020 | l2p_duration
[11210.714359] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[11210.714360] iwlwifi 0000:02:00.0: 0x000000CE | l2p_addr_match
[11210.714362] iwlwifi 0000:02:00.0: 0x0000000D | lmpm_pmg_sel
[11210.714364] iwlwifi 0000:02:00.0: 0x08081421 | timestamp
[11210.714365] iwlwifi 0000:02:00.0: 0x00347080 | flow_handler
[11210.714501] iwlwifi 0000:02:00.0: 0x00000000 | ADVANCED_SYSASSERT
[11210.714503] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
[11210.714505] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink2
[11210.714507] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink1
[11210.714508] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink2
[11210.714510] iwlwifi 0000:02:00.0: 0x00000000 | umac data1
[11210.714512] iwlwifi 0000:02:00.0: 0x00000000 | umac data2
[11210.714514] iwlwifi 0000:02:00.0: 0x00000000 | umac data3
[11210.714515] iwlwifi 0000:02:00.0: 0x00000000 | umac major
[11210.714517] iwlwifi 0000:02:00.0: 0x00000000 | umac minor
[11210.714519] iwlwifi 0000:02:00.0: 0x00000000 | frame pointer
[11210.714520] iwlwifi 0000:02:00.0: 0x00000000 | stack pointer
[11210.714522] iwlwifi 0000:02:00.0: 0x00000000 | last host cmd
[11210.714524] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
[11210.714610] iwlwifi 0000:02:00.0: Fseq Registers:
[11210.714655] iwlwifi 0000:02:00.0: 0xD3453234 | FSEQ_ERROR_CODE
[11210.714700] iwlwifi 0000:02:00.0: 0x4301EA9D | FSEQ_TOP_INIT_VERSION
[11210.714746] iwlwifi 0000:02:00.0: 0x01566238 | FSEQ_CNVIO_INIT_VERSION
[11210.714792] iwlwifi 0000:02:00.0: 0x0000A10B | FSEQ_OTP_VERSION
[11210.714838] iwlwifi 0000:02:00.0: 0x6197D1BF | FSEQ_TOP_CONTENT_VERSION
[11210.714875] iwlwifi 0000:02:00.0: 0x39D5AFF5 | FSEQ_ALIVE_TOKEN
[11210.714913] iwlwifi 0000:02:00.0: 0x86E2FAAB | FSEQ_CNVI_ID
[11210.714951] iwlwifi 0000:02:00.0: 0xF95C9403 | FSEQ_CNVR_ID
[11210.714956] iwlwifi 0000:02:00.0: 0x00000010 | CNVI_AUX_MISC_CHIP
[11210.714964] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[11210.714972] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[11210.715010] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[11210.715050] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[11210.715055] ieee80211 phy0: Hardware restart was requested
[11211.305452] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[11211.438723] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[11211.503933] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[11211.515541] iwlwifi 0000:02:00.0: BIOS contains WGDS but no WRDS
[11222.020519] iwlwifi 0000:02:00.0: Queue 11 is active on fifo 1 and stuck=
 for 10000 ms. SW [196, 56] HW [196, 56] FH TRB=3D0x0c010b0d3
[11222.020664] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarti=
ng 0x2000000.
[11222.021016] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[11222.021018] iwlwifi 0000:02:00.0: Status: 0x00000040, count: 6
[11222.021019] iwlwifi 0000:02:00.0: Loaded firmware version: 36.77d01142.0=
 8265-36.ucode
[11222.021020] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN    =
  =20
[11222.021022] iwlwifi 0000:02:00.0: 0x008006B4 | trm_hw_status0
[11222.021022] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[11222.021023] iwlwifi 0000:02:00.0: 0x000248EC | branchlink2
[11222.021024] iwlwifi 0000:02:00.0: 0x0003A862 | interruptlink1
[11222.021025] iwlwifi 0000:02:00.0: 0x000188A6 | interruptlink2
[11222.021026] iwlwifi 0000:02:00.0: 0x00000000 | data1
[11222.021027] iwlwifi 0000:02:00.0: 0x00000080 | data2
[11222.021028] iwlwifi 0000:02:00.0: 0x07830000 | data3
[11222.021029] iwlwifi 0000:02:00.0: 0x1980B6F1 | beacon time
[11222.021029] iwlwifi 0000:02:00.0: 0x7EB43916 | tsf low
[11222.021030] iwlwifi 0000:02:00.0: 0x00000054 | tsf hi
[11222.021031] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[11222.021032] iwlwifi 0000:02:00.0: 0x00A0CE58 | time gp2
[11222.021033] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[11222.021033] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
[11222.021034] iwlwifi 0000:02:00.0: 0x77D01142 | uCode version minor
[11222.021035] iwlwifi 0000:02:00.0: 0x00000230 | hw version
[11222.021036] iwlwifi 0000:02:00.0: 0x00C89000 | board version
[11222.021036] iwlwifi 0000:02:00.0: 0x0BC4001C | hcmd
[11222.021037] iwlwifi 0000:02:00.0: 0x80022002 | isr0
[11222.021038] iwlwifi 0000:02:00.0: 0x01800000 | isr1
[11222.021039] iwlwifi 0000:02:00.0: 0x0800180A | isr2
[11222.021039] iwlwifi 0000:02:00.0: 0x0041BCC5 | isr3
[11222.021040] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[11222.021041] iwlwifi 0000:02:00.0: 0x005F019C | last cmd Id
[11222.021042] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[11222.021042] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[11222.021043] iwlwifi 0000:02:00.0: 0x00012020 | l2p_duration
[11222.021044] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[11222.021045] iwlwifi 0000:02:00.0: 0x000000CE | l2p_addr_match
[11222.021045] iwlwifi 0000:02:00.0: 0x0000000D | lmpm_pmg_sel
[11222.021046] iwlwifi 0000:02:00.0: 0x08081421 | timestamp
[11222.021047] iwlwifi 0000:02:00.0: 0x00345060 | flow_handler
[11222.021183] iwlwifi 0000:02:00.0: 0x00000000 | ADVANCED_SYSASSERT
[11222.021184] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
[11222.021185] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink2
[11222.021185] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink1
[11222.021186] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink2
[11222.021187] iwlwifi 0000:02:00.0: 0x00000000 | umac data1
[11222.021188] iwlwifi 0000:02:00.0: 0x00000000 | umac data2
[11222.021188] iwlwifi 0000:02:00.0: 0x00000000 | umac data3
[11222.021189] iwlwifi 0000:02:00.0: 0x00000000 | umac major
[11222.021190] iwlwifi 0000:02:00.0: 0x00000000 | umac minor
[11222.021191] iwlwifi 0000:02:00.0: 0x00000000 | frame pointer
[11222.021191] iwlwifi 0000:02:00.0: 0x00000000 | stack pointer
[11222.021192] iwlwifi 0000:02:00.0: 0x00000000 | last host cmd
[11222.021193] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
[11222.021271] iwlwifi 0000:02:00.0: Fseq Registers:
[11222.021318] iwlwifi 0000:02:00.0: 0xD3453234 | FSEQ_ERROR_CODE
[11222.021364] iwlwifi 0000:02:00.0: 0x4301EA9D | FSEQ_TOP_INIT_VERSION
[11222.021410] iwlwifi 0000:02:00.0: 0x01566238 | FSEQ_CNVIO_INIT_VERSION
[11222.021456] iwlwifi 0000:02:00.0: 0x0000A10B | FSEQ_OTP_VERSION
[11222.021503] iwlwifi 0000:02:00.0: 0x6197D1BF | FSEQ_TOP_CONTENT_VERSION
[11222.021548] iwlwifi 0000:02:00.0: 0x39D5AFF5 | FSEQ_ALIVE_TOKEN
[11222.021586] iwlwifi 0000:02:00.0: 0x86E2FAAB | FSEQ_CNVI_ID
[11222.021624] iwlwifi 0000:02:00.0: 0xF95C9403 | FSEQ_CNVR_ID
[11222.021661] iwlwifi 0000:02:00.0: 0x00000010 | CNVI_AUX_MISC_CHIP
[11222.021698] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
[11222.021736] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[11222.021786] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[11222.021832] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[11222.021838] ieee80211 phy0: Hardware restart was requested
[11222.607642] ------------[ cut here ]------------
[11222.607643] ieee80211_restart_work called with hardware scan in progress
[11222.607684] WARNING: CPU: 4 PID: 4462 at net/mac80211/main.c:253 ieee802=
11_restart_work+0xd5/0xe0 [mac80211]
[11222.607687] iwlwifi 0000:02:00.0: Scan failed! ret -5
[11222.607688] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq fus=
e 8021q garp mrp stp llc amdgpu snd_hda_codec_conexant snd_hda_codec_generi=
c iwlmvm ledtrig_audio snd_hda_codec_hdmi uvcvideo snd_hda_intel videobuf2_=
vmalloc videobuf2_memops snd_intel_dspcfg videobuf2_v4l2 hp_wmi edac_mce_am=
d mac80211 hid_multitouch btusb sparse_keymap snd_hda_codec snd_usb_audio w=
mi_bmof videobuf2_common libarc4 btrtl btbcm btintel iwlwifi snd_hda_core s=
nd_usbmidi_lib gpu_sched bluetooth i2c_algo_bit snd_rawmidi videodev snd_se=
q_device kvm ttm snd_hwdep irqbypass sp5100_tco cfg80211 ecdh_generic psmou=
se k10temp mc mousedev i2c_piix4 ecc input_leds drm_kms_helper snd_pcm pcsp=
kr r8169 joydev cec snd_timer tpm_crb rc_core snd ucsi_acpi syscopyarea ipm=
i_devintf sysfillrect realtek sysimgblt fb_sys_fops soundcore rfkill ipmi_m=
sghandler libphy typec_ucsi typec battery tpm_tis wmi i2c_hid tpm_tis_core =
i2c_amd_mp2_plat evdev tpm hp_wireless i2c_amd_mp2_pci pinctrl_amd mac_hid =
ac acpi_cpufreq drm agpgart
[11222.607718]  ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 u=
as usb_storage hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid dm=
_crypt dm_mod serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_i=
ntel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper xhci_pc=
i xhci_hcd ccp rng_core ehci_pci ehci_hcd i8042 serio loop
[11222.607732] CPU: 4 PID: 4462 Comm: kworker/4:3 Not tainted 5.6.3-arch1-1=
 #1
[11222.607733] Hardware name: HP HP EliteBook 755 G5/83D5, BIOS Q81 Ver. 01=
=2E03.01 07/26/2018
[11222.607743] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[11222.607753] RIP: 0010:ieee80211_restart_work+0xd5/0xe0 [mac80211]
[11222.607754] Code: 31 5e b1 f5 4c 89 ef e8 d9 c6 03 00 5b 5d 41 5c 41 5d =
e9 6e c3 b2 f5 48 c7 c6 30 26 d5 c0 48 c7 c7 58 ca d5 c0 e8 fd ad 3b f5 <0f=
> 0b e9 60 ff ff ff 0f 1f 40 00 0f 1f 44 00 00 53 48 89 fb 48 81
[11222.607755] RSP: 0018:ffffa30b82043e58 EFLAGS: 00010282
[11222.607756] RAX: 0000000000000000 RBX: ffff8b642def9cf8 RCX: 00000000000=
00000
[11222.607757] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 00000000fff=
fffff
[11222.607758] RBP: ffff8b642def9cf8 R08: 000000000000059c R09: 00000000000=
00001
[11222.607758] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b645ff=
32a00
[11222.607759] R13: ffff8b642def87c0 R14: 0000000000000000 R15: ffff8b64547=
21ec0
[11222.607760] FS:  0000000000000000(0000) GS:ffff8b645ff00000(0000) knlGS:=
0000000000000000
[11222.607760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11222.607761] CR2: 00007f086ff0b000 CR3: 00000003e085e000 CR4: 00000000003=
406e0
[11222.607762] Call Trace:
[11222.607772]  process_one_work+0x1da/0x3d0
[11222.607774]  worker_thread+0x4a/0x3d0
[11222.607776]  kthread+0xfb/0x130
[11222.607778]  ? process_one_work+0x3d0/0x3d0
[11222.607779]  ? kthread_park+0x90/0x90
[11222.607782]  ret_from_fork+0x22/0x40
[11222.607786] ---[ end trace 7448b23fe49424b0 ]---
[11222.628397] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[11222.761924] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[11222.827235] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring


--fdj2RfSjLxBAspz7--
