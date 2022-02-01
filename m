Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455054A54A5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 02:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiBAB1D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 20:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiBAB1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 20:27:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA66C061714
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 17:27:02 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 71so13843215qkf.4
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 17:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flyzipline.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vL0XcPRigAc+yHA08yppVaXgPXVaHTYxuzbzyfp623U=;
        b=HCmSjc2ktt36PJL06od/jbuSDqpKbeVxa5IjXcQJ6wRo5BIaqK5H9a8bOCqwtTe+U4
         Crb/nGMF5Uv5WVfNc+ZQ2YnuWWCBWwZtA2WonS0PJt6pDHUoZ4E7I3r+1UDGvXN9+Rai
         y3BoxDm6eABLeUhZgl4YGKxU25MXSvWdQ7rvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vL0XcPRigAc+yHA08yppVaXgPXVaHTYxuzbzyfp623U=;
        b=6o8z5KecdziVHilTl8aq7eX0Q8TEB6dyxlVMM12nvId5o7zCxihSFo3XjEy+QpSrHL
         o4qw3+FPijJGoSrDTlKVdvSonT8Nt3BJUpRA82PSPMmcYbvpJpSCp20Lf8ibpmw2LB1C
         U2P9TwkCgoKehNQ0adHBD3HIiPzDwoi6E6Q8eK45j5/FuzvXNC56aGDTWNlSVALUbSq4
         b3TtpSsK/0EOaGw+TTwKC3EZ+N16yN9P1G/5w1cIXFdeDfUWAs6ukAYHDhjxon40HnRV
         ehRuA+ki9G2Diwa1A5xHOw4N1YZ9FOclz3lO1dUmmGmaGFO/ie52tSu3MMXDpFqSzbSz
         kWSg==
X-Gm-Message-State: AOAM531GUhUItdBCGIS6M9SDlSrGtQturOC3xc3JcDR3HiTAJ6+HER1W
        4F+zlvzwM4XEmbg1FRFjoOO+FOCFEfO95qLYy1E2zahn3cSwq1TtQKQ=
X-Google-Smtp-Source: ABdhPJwM8i735GKnKxZlYvir2UnlgKf7RfXj9Uufaa51HuxHiZ/XZOMm3+fCnEjo+LAjiEYS9iGYfgOliONGZ8C8YR8=
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr10898476qkp.701.1643678821880;
 Mon, 31 Jan 2022 17:27:01 -0800 (PST)
MIME-Version: 1.0
From:   Kevin Kellar <kevin.kellar@flyzipline.com>
Date:   Mon, 31 Jan 2022 17:26:51 -0800
Message-ID: <CAJyMcLWcoCAHOmoNUT2=oVUWj7Lj5R1O-57KNX_5VXHfBr91OQ@mail.gmail.com>
Subject: iwlwifi: Beacon frame injection at higher modulation in kernel 5.13+?
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have been experimenting with injecting 802.11 beacon frames using
the Intel ax201 and the iwlwifi driver on Ubuntu 20.04 with linux
kernel versions 5.11 and 5.13. My use case involves measuring receive
performance for frames injected at 802.11b, g and n modulations.

When running linux kernel version 5.11, it seemed the driver would
allow beacon frame injection for 802.11b and g datarates, but
submitting a frame with an 802.11n MCS (using RADIOTAP) for frame
injection would print a warning message on the host machine=E2=80=99s dmesg
(see end of message). Running pcap on a separate interface showed the
frame was sent using 802.11g rates, rather than 802.11n.

Now that my kernel is updated to 5.13, I observe frames are always
transmitted using 802.11b 1Mb/s=E2=80=93regardless of whether attempting to
send at an 802.11b or g datarate or an 802.11n  MCS. Strangely, I
observed that the warning message in dmesg is now absent.

My investigation suggests this commit
[https://github.com/torvalds/linux/commit/6761a718263a0cff8b31c30b61c92acc1=
4db853f]
changed the behavior of the warning message for the iwlwifi driver.
This may be related to the different behavior I observed between
kernel versions 5.11 and 5.13, yet it is not apparent to me how this
commit could further restrict supported frame injection rates from
802.11g to 802.11b 1Mb/s exclusively.

Would anyone here be able to weigh in on:
If frame injection while the interface is in monitor mode is supported
by the iwlwifi driver
Whether the iwlwifi team intentionally limits supported
modulations/datarates for injected frames to be 802.11b 1Mb/s
Whether injection at 802.11n MCSs is supported by Intel wireless
device firmware, and if we could use this feature through the iwlwifi
driver.


[  +0.036404] ------------[ cut here ]------------
[  +0.000005] Got an HT rate (flags:0x8/mcs:2) for a non data frame
[  +0.000028] WARNING: CPU: 7 PID: 23060 at
drivers/net/wireless/intel/iwlwifi/mvm/tx.c:273
iwl_mvm_get_tx_rate.isra.0+0xd0/0xe0 [iwlmvm]
[  +0.000031] Modules linked in: iwlmvm iwlwifi hid_logitech_hidpp
hid_logitech_dj hid_generic usbhid ath9k_htc hid ath9k_common ath9k_hw
ath rt2800usb rt2x00usb rt2800lib rt2x00lib ip6table_filter ip6_tables
xt_tcpudp xt_owner iptable_filter bpfilter rfcomm ccm cmac algif_hash
algif_skcipher af_alg bnep binfmt_misc snd_soc_skl_hda_dsp
snd_soc_intel_hda_dsp_common snd_soc_hdac_hdmi snd_hda_codec_hdmi
snd_hda_codec_realtek nls_iso8859_1 snd_hda_codec_generic snd_soc_dmic
snd_sof_pci snd_sof_intel_hda_common snd_sof_intel_hda
snd_sof_intel_byt snd_sof_intel_ipc snd_sof snd_sof_xtensa_dsp
snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match
snd_soc_acpi snd_hda_intel snd_intel_dspcfg mei_hdcp soundwire_intel
soundwire_generic_allocation soundwire_cadence intel_rapl_msr mac80211
snd_hda_codec libarc4 snd_seq_midi snd_seq_midi_event
x86_pkg_temp_thermal intel_powerclamp coretemp uvcvideo snd_hda_core
videobuf2_vmalloc kvm_intel videobuf2_memops snd_hwdep snd_rawmidi
btusb videobuf2_v4l2
[  +0.000074]  joydev input_leds btrtl kvm soundwire_bus
videobuf2_common snd_soc_core btbcm serio_raw videodev btintel
intel_cstate snd_compress efi_pstore snd_seq ac97_bus bluetooth
wmi_bmof snd_pcm_dmaengine mc processor_thermal_device cfg80211 ee1004
snd_pcm processor_thermal_rfim thinkpad_acpi processor_thermal_mbox
mei_me processor_thermal_rapl ecdh_generic intel_rapl_common nvram ecc
mei intel_soc_dts_iosf ledtrig_audio ucsi_acpi snd_seq_device
typec_ucsi snd_timer typec snd soundcore int3403_thermal
int340x_thermal_zone mac_hid acpi_pad int3400_thermal intel_hid
acpi_tad acpi_thermal_rel sparse_keymap sch_fq_codel msr parport_pc
ppdev lp parport ip_tables x_tables autofs4 dm_crypt mmc_block i915
crct10dif_pclmul i2c_algo_bit crc32_pclmul ghash_clmulni_intel
drm_kms_helper aesni_intel syscopyarea sysfillrect crypto_simd
sysimgblt fb_sys_fops i2c_i801 psmouse e1000e cryptd i2c_smbus
glue_helper cec sdhci_pci rc_core cqhci sdhci thunderbolt nvme drm
xhci_pci nvme_core
[  +0.000084]  xhci_pci_renesas wmi video pinctrl_tigerlake [last
unloaded: iwlwifi]
[  +0.000007] CPU: 7 PID: 23060 Comm: python3 Not tainted
5.11.0-41-generic #45~20.04.1-Ubuntu
[  +0.000004] Hardware name: LENOVO 20W6001NUS/20W6001NUS, BIOS
N34ET40W (1.40 ) 06/25/2021
[  +0.000002] RIP: 0010:iwl_mvm_get_tx_rate.isra.0+0xd0/0xe0 [iwlmvm]
[  +0.000016] Code: c3 0f 0b 31 db eb d2 80 3d 8d f3 03 00 00 0f 85 76
ff ff ff 0f b7 f1 48 c7 c7 98 6e 3e c1 c6 05 76 f3 03 00 01 e8 76 98
fe c9 <0f> 0b 41 0f be 54 24 08 89 d3 e9 51 ff ff ff 90 0f 1f 44 00 00
40
[  +0.000003] RSP: 0018:ffffa2ce44a7f940 EFLAGS: 00010286
[  +0.000004] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 000000000000=
0027
[  +0.000002] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff965e3f7d=
8ac8
[  +0.000002] RBP: ffffa2ce44a7f960 R08: ffff965e3f7d8ac0 R09: ffffa2ce44a7=
f700
[  +0.000002] R10: 0000000000000001 R11: 0000000000000001 R12: ffffa2ce44a7=
f9f0
[  +0.000002] R13: 0000000000000000 R14: ffff965702f7acd8 R15: ffff96570526=
9b00
[  +0.000001] FS:  00007f79d3533740(0000) GS:ffff965e3f7c0000(0000)
knlGS:0000000000000000
[  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007f79d3551018 CR3: 00000001a4814004 CR4: 000000000077=
0ee0
[  +0.000003] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000005]  iwl_mvm_set_tx_params+0x1f3/0x4d0 [iwlmvm]
[  +0.000017]  iwl_mvm_tx_skb_non_sta+0x182/0x3a0 [iwlmvm]
[  +0.000015]  iwl_mvm_tx_skb+0x2a/0x40 [iwlmvm]
[  +0.000013]  iwl_mvm_mac_tx+0xca/0x130 [iwlmvm]
[  +0.000013]  ieee80211_tx_frags+0x16b/0x240 [mac80211]
[  +0.000052]  __ieee80211_tx+0x7f/0x140 [mac80211]
[  +0.000040]  ieee80211_tx+0x112/0x140 [mac80211]
[  +0.000041]  ieee80211_xmit+0xc0/0xf0 [mac80211]
[  +0.000038]  ieee80211_monitor_start_xmit+0x1f9/0x2c0 [mac80211]
[  +0.000036]  dev_hard_start_xmit+0xcf/0x1f0
[  +0.000006]  __dev_queue_xmit+0x798/0x9d0
[  +0.000002]  ? packet_parse_headers.isra.0+0xd2/0x110
[  +0.000006]  dev_queue_xmit+0x10/0x20
[  +0.000002]  packet_snd+0x47e/0xb70
[  +0.000004]  packet_sendmsg+0x26/0x30
[  +0.000004]  sock_sendmsg+0x65/0x70
[  +0.000003]  __sys_sendto+0x113/0x190
[  +0.000004]  ? handle_mm_fault+0xd7/0x2b0
[  +0.000005]  __x64_sys_sendto+0x29/0x30
[  +0.000003]  do_syscall_64+0x38/0x90
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000005] RIP: 0033:0x7f79d38226dc
[  +0.000008] Code: 89 4c 24 1c e8 a5 40 f7 ff 44 8b 54 24 1c 8b 3c 24
45 31 c9 89 c5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00 00
0f 05 <48> 3d 00 f0 ff ff 77 30 89 ef 48 89 04 24 e8 d1 40 f7 ff 48 8b
04
[  +0.000002] RSP: 002b:00007ffde32051e0 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[  +0.000004] RAX: ffffffffffffffda RBX: 00007ffde32052a0 RCX: 00007f79d382=
26dc
[  +0.000002] RDX: 0000000000000033 RSI: 00007f79b71a06b0 RDI: 000000000000=
0003
[  +0.000002] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000=
0000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000=
0000
[  +0.000002] R13: 0000000000000000 R14: 00007ffde32052a0 R15: 000000000062=
3d60
[  +0.000005] ---[ end trace 857a738ee9d8d01c ]---
