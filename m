Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3587A5734F2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiGMLJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGMLJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 07:09:25 -0400
Received: from smtp-relay-3.sys.kth.se (smtp-relay-3.sys.kth.se [IPv6:2001:6b0:1:1200:250:56ff:fead:700c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C37390D
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 04:09:23 -0700 (PDT)
Received: from exdb3.ug.kth.se (exdb3.ug.kth.se [192.168.32.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-3.sys.kth.se (Postfix) with ESMTPS id 4LjZdF2kR7zPQDY
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 13:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-relay-3.sys.kth.se 4LjZdF2kR7zPQDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
        t=1657710561; bh=dYg3POPRPzlYL0uGo2fSI9Lyl94BQm6xAmqzSRUqPXM=;
        h=From:To:Subject:Date:From;
        b=PJm+crv1pla7cRBgfl3HpXeExHE94IHOdOhhcCea5mZYESsRbwFI5LC5tmuE+Tr4n
         7aYz5NBqkTBW2bzKu8amx4OD8QDbLvqVmtzFJl1rOJKiJ+AZHNKX7II84SqEgjbsfe
         Gh760tIEO77HjSKaKERx7WUL/CZwiFr/A9ylXpvs=
Received: from exdb1.ug.kth.se (192.168.32.56) by exdb3.ug.kth.se
 (192.168.32.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 13 Jul
 2022 13:09:21 +0200
Received: from exdb1.ug.kth.se ([192.168.32.56]) by exdb1.ug.kth.se
 ([192.168.32.56]) with mapi id 15.02.0986.026; Wed, 13 Jul 2022 13:09:21
 +0200
From:   Johan Henning <johennin@kth.se>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [r8188eu driver] Kernel crash report
Thread-Topic: [r8188eu driver] Kernel crash report
Thread-Index: AQHYlqjPGYVnP5xYGk+DWQsF1MhwWQ==
Date:   Wed, 13 Jul 2022 11:09:20 +0000
Message-ID: <6427c533080d46ab870d46ab3654e514@kth.se>
Accept-Language: en-GB, sv-SE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.32.250]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, I found a bug after using the WiFi fuzzer Owfuzz on the TL-WN722N Wi=
reless WiFi USB adapter which has a default driver in the Ubuntu kernel cal=
led r8188eu.

The stack trace from the crash is posted at the end of the email.

The bug itself was caused by 2 different WiFi frames, by first sending a de=
authentication frame and at the same time sending a much larger frame. Afte=
r doing some debugging the cause of the lockup of the CPU was that while th=
e rtw_get_sec_ie attempts to read the beacon frame sent by the router/AP, t=
he size of the beacon is changed since it is a reference and not a copy. By=
 having a "rogue" beacon frame being very large which isn't normal and not =
considered in the design, the computer was stuck in an endless CPU lockup.

Function in question: https://github.com/torvalds/linux/blob/master/drivers=
/staging/r8188eu/core/rtw_ieee80211.c##L468

WPA2 option was used. Otherwise, the driver would not enter the function wh=
ich caused the issue.=20

"in_ie[cnt + 1] + 2" is the value which in the result of the two frames bei=
ng sent, was much larger than originally observed during debugging of the f=
unction.

On a side note, a similar bug/crash was also found in the standalone driver=
 for rtl8188eu chipset adapters in the same function: https://github.com/lw=
finger/rtl8188eu/blob/master/core/rtw_ieee80211.c##L658

Stack trace from syslog before computer was unusable:

Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.743832] watchdog: BUG: soft =
lockup - CPU#2 stuck for 26s! [wpa_supplicant:847]
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.743849] Modules linked in: b=
trfs blake2b_generic xor zstd_compress raid6_pq ufs qnx4 hfsplus hfs minix =
ntfs msdos jfs xfs libcrc32c cpuid nfnetlink_queue nfnetlink_log nfnetlink =
bluetooth ecdh_generic ecc uas usb_storage nls_iso8859_1 snd_hda_codec_real=
tek snd_hda_codec_generic ledtrig_audio uvcvideo videobuf2_vmalloc x86_pkg_=
temp_thermal videobuf2_memops snd_hda_codec_hdmi snd_hda_intel r8188eu(C) v=
ideobuf2_v4l2 intel_powerclamp coretemp kvm_intel kvm snd_intel_dspcfg snd_=
intel_sdw_acpi lib80211 crct10dif_pclmul ghash_clmulni_intel videobuf2_comm=
on videodev mc snd_hda_codec snd_hda_core cfg80211 snd_hwdep snd_pcm snd_se=
q_midi snd_seq_midi_event intel_rapl_msr ak8975 aesni_intel mei_hdcp snd_ra=
wmidi joydev input_leds serio_raw i915 snd_seq crypto_simd cryptd drm_kms_h=
elper rapl snd_seq_device snd_timer intel_cstate cec at24 hid_multitouch in=
v_mpu6050_i2c inv_mpu6050 efi_pstore snd asus_nb_wmi acpi_als i2c_mux rc_co=
re industrialio_triggered_buffer kfifo_buf mei_me mei industrialio
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.743992]  i2c_algo_bit fb_sys=
_fops syscopyarea sysfillrect sysimgblt soundcore processor_thermal_device =
processor_thermal_rfim processor_thermal_mbox processor_thermal_rapl intel_=
rapl_common soc_button_array int340x_thermal_zone intel_soc_dts_iosf mac_hi=
d int3400_thermal acpi_thermal_rel dell_smo8800 asus_wireless sch_fq_codel =
ipmi_devintf ipmi_msghandler msr parport_pc ppdev lp parport drm ip_tables =
x_tables autofs4 hid_generic usbhid hid mfd_aaeon asus_wmi sparse_keymap cr=
c32_pclmul i2c_i801 ahci lpc_ich psmouse libahci xhci_pci i2c_smbus xhci_pc=
i_renesas wmi video pinctrl_lynxpoint
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744071] CPU: 2 PID: 847 Comm=
: wpa_supplicant Tainted: G         C        5.13.0-40-generic #45~20.04.1-=
Ubuntu
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744078] Hardware name: ASUST=
eK COMPUTER INC. TP300LA/TP300LA, BIOS TP300LA.202 05/14/2014
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744081] RIP: 0010:rtw_get_se=
c_ie+0x1e1/0x270 [r8188eu]
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744126] Code: e7 f8 49 89 02=
 89 d0 49 8b 4c 04 f8 49 89 4c 02 f8 4c 89 d1 48 29 f9 48 29 ce 01 d1 c1 e9=
 03 f3 48 a5 45 31 e4 45 31 c0 eb 19 <0f> b6 03 41 83 c4 08 45 0f b6 c4 89 =
c2 83 c0 02 41 39 c0 0f 8d f2
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744131] RSP: 0018:ffffb18540=
953918 EFLAGS: 00000297
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744137] RAX: 000000000000010=
1 RBX: ffffb18541d80cdb RCX: 0000000000000000
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744140] RDX: 00000000000000f=
f RSI: ffffb18541d80dd9 RDI: ffffb18540953c30
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744144] RBP: ffffb1854095397=
8 R08: 00000000000000c0 R09: ffffb185409539ce
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744147] R10: ffffb18540953b3=
1 R11: ffffb18540953a32 R12: 000000000f99e7c0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744151] R13: ffffb18541d80cb=
c R14: 0000000000000020 R15: 000000000000011f
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744154] FS:  00007f461d86514=
0(0000) GS:ffff948a96f00000(0000) knlGS:0000000000000000
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744159] CS:  0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744163] CR2: 00007fb8c636f02=
8 CR3: 000000010c6e4003 CR4: 00000000001706e0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744167] Call Trace:
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744170]  <TASK>
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744173]  ? scnprintf+0x4d/0x=
90
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744187]  translate_scan+0x43=
d/0xa90 [r8188eu]
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744236]  ? poll_select_finis=
h+0x220/0x220
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744248]  ? copyout+0x20/0x30
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744256]  ? _copy_to_iter+0xb=
3/0x7b0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744269]  rtw_wx_get_scan+0xe=
f/0x170 [r8188eu]
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744314]  ioctl_standard_iw_p=
oint+0xf8/0x3a0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744322]  ? translate_scan+0x=
a90/0xa90 [r8188eu]
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744364]  ? __mod_memcg_lruve=
c_state+0x22/0xe0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744371]  ? unix_ioctl+0x9c/0=
x180
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744378]  ioctl_standard_call=
+0x8b/0x100
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744383]  ? netdev_name_node_=
lookup+0x69/0x80
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744392]  ? iw_handler_get_pr=
ivate+0x60/0x60
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744398]  ? ioctl_standard_iw=
_point+0x3a0/0x3a0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744404]  wireless_process_io=
ctl+0x133/0x190
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744409]  wext_handle_ioctl+0=
x9e/0x100
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744416]  sock_ioctl+0x212/0x=
330
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744426]  ? syscall_exit_to_u=
ser_mode+0x27/0x50
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744435]  __x64_sys_ioctl+0x9=
1/0xc0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744444]  do_syscall_64+0x61/=
0xb0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744449]  ? do_syscall_64+0x6=
e/0xb0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744453]  ? syscall_exit_to_u=
ser_mode+0x27/0x50
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744460]  ? __x64_sys_select+=
0x25/0x30
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744468]  ? do_syscall_64+0x6=
e/0xb0
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744472]  ? sysvec_apic_timer=
_interrupt+0x4e/0x90
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744478]  ? asm_sysvec_apic_t=
imer_interrupt+0xa/0x20
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744488]  entry_SYSCALL_64_af=
ter_hwframe+0x44/0xae
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744496] RIP: 0033:0x7f461dbe=
53db
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744501] Code: 0f 1e fa 48 8b=
 05 b5 7a 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00=
 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d =
85 7a 0d 00 f7 d8 64 89 01 48
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744506] RSP: 002b:00007fff39=
df6988 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744512] RAX: ffffffffffffffd=
a RBX: 0000000000000005 RCX: 00007f461dbe53db
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744516] RDX: 00007fff39df69e=
0 RSI: 0000000000008b19 RDI: 0000000000000009
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744519] RBP: 000055aa8f20d0c=
0 R08: 000055aa8f20d0c0 R09: 000055aa8f220c00
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744522] R10: 000055aa8f1cf01=
0 R11: 0000000000000246 R12: 0000000000001000
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744525] R13: 00007fff39df69e=
0 R14: 000055aa8f2249a0 R15: 0000000000000010
Jun  8 14:54:17 subuntu-TP300LA kernel: [93710.744532]  </TASK>=
