Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B71629DD
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRPwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 10:52:19 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:57276 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBRPwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 10:52:19 -0500
Received: from [141.24.111.139] (unknown [141.24.111.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id CC4FB580068;
        Tue, 18 Feb 2020 16:52:15 +0100 (CET)
To:     linux-wireless@vger.kernel.org
Cc:     linuxwifi@intel.com
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Subject: BUG: iwlwifi (dvm) queue mapping inconsistent with nl80211
 tx_control_port
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <7b5d5ebd-a2da-b76d-0e03-c7f3c7a08318@tu-ilmenau.de>
Date:   Tue, 18 Feb 2020 16:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I currently run a wpa_supplicant version which uses nl80211 control port
tx. The following warning in the iwlwifi driver was triggered:

WARN_ON_ONCE(is_agg &&
             priv->queue_to_mac80211[txq_id] != info->hw_queue);

Kind regards,
Markus

Feb 17 17:52:31 isengard kernel: iwlwifi 0000:03:00.0: loaded firmware
version 9.221.4.1 build 25532 op_mode iwldvm
Feb 17 17:52:32 isengard kernel: iwlwifi 0000:03:00.0:
CONFIG_IWLWIFI_DEBUG enabled
Feb 17 17:52:32 isengard kernel: iwlwifi 0000:03:00.0:
CONFIG_IWLWIFI_DEBUGFS enabled
Feb 17 17:52:32 isengard kernel: iwlwifi 0000:03:00.0:
CONFIG_IWLWIFI_DEVICE_TRACING enabled
Feb 17 17:52:32 isengard kernel: iwlwifi 0000:03:00.0: Detected Intel(R)
Centrino(R) Ultimate-N 6300 AGN, REV=0x74
Feb 17 17:52:32 isengard kernel: ieee80211 phy0: Selected rate control
algorithm 'iwl-agn-rs'

[ 9872.425322] ------------[ cut here ]------------
[ 9872.425343] WARNING: CPU: 3 PID: 504 at drivers/net/wireless/intel/iwlwifi/dvm/tx.c:431 iwlagn_tx_skb+0x850/0xc00 [iwldvm]
[ 9872.425344] Modules linked in: hid_generic usbhid hid mt76x2u mt76x2_common mt76x02_usb mt76_usb mt76x02_lib mt76 usb_storage fuse ccm snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic joydev mousedev nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject intel_rapl_msr intel_rapl_common nft_ct x86_pkg_temp_thermal nf_conntrack intel_powerclamp coretemp nf_defrag_ipv6 nf_defrag_ipv4 kvm_intel libcrc32c kvm nf_tables_set nf_tables nfnetlink irqbypass crct10dif_pclmul crc32_pclmul iwldvm i915 ghash_clmulni_intel mac80211 mei_wdt uvcvideo mei_hdcp iTCO_wdt i2c_algo_bit iTCO_vendor_support libarc4 wmi_bmof drm_kms_helper aesni_intel iwlwifi videobuf2_vmalloc snd_hda_intel snd_intel_dspcfg btusb crypto_simd cryptd videobuf2_memops glue_helper btrtl btbcm snd_hda_codec videobuf2_v4l2 btintel intel_cstate drm psmouse intel_uncore videobuf2_common snd_hda_core bluetooth intel_rapl_perf videodev pcspkr snd_hwdep intel_gtt ecdh_generic input_leds i2c_i801 mc cfg80211 ecc snd_pcm
[ 9872.425395]  thinkpad_acpi agpgart tpm_tis syscopyarea mei_me nvram tpm_tis_core sysfillrect ledtrig_audio snd_timer sysimgblt mei e1000e lpc_ich fb_sys_fops rfkill snd tpm wmi soundcore battery ac rng_core mac_hid evdev usbip_host usbip_core pkcs8_key_parser sg crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod serio_raw atkbd libps2 ahci libahci libata crc32c_intel sdhci_pci cqhci scsi_mod xhci_pci sdhci xhci_hcd ehci_pci mmc_core ehci_hcd i8042 serio
[ 9872.425436] CPU: 3 PID: 504 Comm: wpa_supplicant Not tainted 5.5.4-arch1-1 #1
[ 9872.425438] Hardware name: LENOVO 2349QM6/2349QM6, BIOS G1ETC2WW (2.82 ) 08/07/2019
[ 9872.425448] RIP: 0010:iwlagn_tx_skb+0x850/0xc00 [iwldvm]
[ 9872.425452] Code: 00 48 8d 04 80 4b 8d 14 9b 41 0f b6 5c 24 2d 48 c1 e0 05 48 8d 04 90 41 0f b7 84 07 5c 19 00 00 49 89 c3 41 38 5c 07 61 74 02 <0f> 0b 44 88 6c 24 27 e9 e0 fd ff ff 83 c8 48 e9 56 f9 ff ff 49 8b
[ 9872.425454] RSP: 0018:ffffa035006ef768 EFLAGS: 00010202
[ 9872.425456] RAX: 000000000000000c RBX: 0000000000000000 RCX: 0000000000000000
[ 9872.425458] RDX: 0000000000000000 RSI: ffff89f29f074ff8 RDI: ffff89f1e867d7d0
[ 9872.425459] RBP: ffff89f1e867d780 R08: 000000000000bc30 R09: 0000000040000050
[ 9872.425461] R10: 0000000000000000 R11: 000000000000000c R12: ffff89f2bd48a500
[ 9872.425462] R13: ffff89f297172801 R14: ffff89f2c7571eb8 R15: ffff89f2c7571e88
[ 9872.425465] FS:  00007f5331a7e7c0(0000) GS:ffff89f2d66c0000(0000) knlGS:0000000000000000
[ 9872.425467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9872.425469] CR2: 00003f8a15c28000 CR3: 00000002000d4006 CR4: 00000000001606e0
[ 9872.425471] Call Trace:
[ 9872.425488]  iwlagn_mac_tx+0x1e/0x40 [iwldvm]
[ 9872.425535]  ieee80211_tx_frags+0x162/0x240 [mac80211]
[ 9872.425569]  __ieee80211_tx+0x7a/0x130 [mac80211]
[ 9872.425601]  ieee80211_tx+0x11a/0x150 [mac80211]
[ 9872.425634]  __ieee80211_subif_start_xmit+0x82a/0xce0 [mac80211]
[ 9872.425666]  ? ieee80211_key_link+0x187/0x370 [mac80211]
[ 9872.425693]  ? aead_key_setup_encrypt+0x62/0x80 [mac80211]
[ 9872.425726]  ieee80211_tx_control_port+0x126/0x160 [mac80211]
[ 9872.425763]  nl80211_tx_control_port+0x12e/0x280 [cfg80211]
[ 9872.425772]  genl_rcv_msg+0x1d2/0x480
[ 9872.425777]  ? __netlink_sendskb+0x3b/0x50
[ 9872.425780]  ? netlink_unicast+0x200/0x240
[ 9872.425785]  ? genl_family_rcv_msg_attrs_parse+0x100/0x100
[ 9872.425788]  netlink_rcv_skb+0x75/0x140
[ 9872.425793]  genl_rcv+0x24/0x40
[ 9872.425796]  netlink_unicast+0x199/0x240
[ 9872.425799]  netlink_sendmsg+0x243/0x480
[ 9872.425806]  sock_sendmsg+0x5e/0x60
[ 9872.425809]  ____sys_sendmsg+0x21b/0x290
[ 9872.425812]  ? copy_msghdr_from_user+0xe1/0x160
[ 9872.425818]  ___sys_sendmsg+0x9e/0xe0
[ 9872.425827]  ? do_vfs_ioctl+0x491/0x730
[ 9872.425831]  __sys_sendmsg+0x81/0xd0
[ 9872.425839]  do_syscall_64+0x4e/0x150
[ 9872.425846]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 9872.425849] RIP: 0033:0x7f5331dd8887
[ 9872.425852] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 9872.425854] RSP: 002b:00007ffc6a56f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 9872.425857] RAX: ffffffffffffffda RBX: 00005584511a4600 RCX: 00007f5331dd8887
[ 9872.425858] RDX: 0000000000000000 RSI: 00007ffc6a56f080 RDI: 0000000000000006
[ 9872.425860] RBP: 00005584511a4510 R08: 0000000000000004 R09: 000055845119a010
[ 9872.425861] R10: 00007ffc6a56f164 R11: 0000000000000246 R12: 00005584512c30a0
[ 9872.425863] R13: 00007ffc6a56f080 R14: 0000000000000000 R15: 00007ffc6a56f164
[ 9872.425868] ---[ end trace df37e6f36a266e33 ]---


