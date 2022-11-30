Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0414463D6C3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 14:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiK3NbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 08:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiK3Nau (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 08:30:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7CC70474
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 05:30:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5813668AFE; Wed, 30 Nov 2022 14:30:17 +0100 (CET)
Date:   Wed, 30 Nov 2022 14:30:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: failed to insert STA entry for the AP (error -2)
Message-ID: <20221130133016.GC3055@lst.de>
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org> <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k03c4mdb.fsf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm seeing this fun churn of warns when trying to connect to my AP
with a brand new Thinkpad T14s Gen3 AMD that I'm trying to install
Debian on.

The kernel is linux-image-6.0.0-5-amd64 from Debian unstable, which is
identical to the latest 6.0-stable for ath11k.

[  280.585881] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 0x98000000-0x981fffff 64bit]
[  280.586362] ath11k_pci 0000:01:00.0: MSI vectors: 32
[  280.586368] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
[  280.741846] mhi mhi0: Requested to power ON
[  280.741860] mhi mhi0: Power on setup success
[  280.743578] mhi mhi0: firmware: direct-loading firmware ath11k/WCN6855/hw2.1/amss.bin
[  280.834744] mhi mhi0: Wait for device to enter SBL or Mission mode
[  281.468934] ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
[  281.468944] ath11k_pci 0000:01:00.0: fw_version 0x11090c35 fw_build_timestamp 2022-04-18 20:23 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
[  281.469461] ath11k_pci 0000:01:00.0: firmware: direct-loading firmware ath11k/WCN6855/hw2.1/board-2.bin
[  281.469544] ath11k_pci 0000:01:00.0: firmware: direct-loading firmware ath11k/WCN6855/hw2.1/regdb.bin
[  281.479138] ath11k_pci 0000:01:00.0: firmware: direct-loading firmware ath11k/WCN6855/hw2.1/board-2.bin
[  281.510539] ath11k_pci 0000:01:00.0: firmware: direct-loading firmware ath11k/WCN6855/hw2.1/m3.bin
[  281.802394] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
[  341.715380] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  341.730641] wlp1s0: Invalid HE elem, Disable HE
[  341.769475] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  341.769480] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  341.780830] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  341.802515] wlp1s0: failed to insert STA entry for the AP (error -2)
[  341.802537] ------------[ cut here ]------------
[  341.802539] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  341.802574] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  341.802658] CPU: 10 PID: 9220 Comm: wpa_supplicant Not tainted 6.0.0-5-amd64 #1  Debian 6.0.10-1
[  341.802664] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  341.802667] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  341.802682] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  341.802685] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  341.802689] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  341.802691] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  341.802693] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  341.802694] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  341.802696] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  341.802698] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  341.802701] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  341.802703] CR2: 0000564238847118 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  341.802705] PKRU: 55555554
[  341.802707] Call Trace:
[  341.802712]  <TASK>
[  341.802714]  ? __wake_up_klogd.part.0+0x56/0x80
[  341.802726]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  341.802793]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  341.802832]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  341.802870]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  341.802918]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  341.802975]  ? __local_bh_enable_ip+0x37/0x90
[  341.802981]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  341.803038]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  341.803080]  ? do_select+0x764/0x830
[  341.803091]  genl_family_rcv_msg_doit+0x100/0x160
[  341.803101]  genl_rcv_msg+0xee/0x1e0
[  341.803104]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  341.803143]  ? genl_get_cmd+0xe0/0xe0
[  341.803146]  netlink_rcv_skb+0x51/0x100
[  341.803151]  genl_rcv+0x24/0x40
[  341.803154]  netlink_unicast+0x242/0x390
[  341.803158]  netlink_sendmsg+0x250/0x4c0
[  341.803162]  sock_sendmsg+0x5f/0x70
[  341.803170]  ____sys_sendmsg+0x267/0x2b0
[  341.803174]  ? copy_msghdr_from_user+0x7d/0xc0
[  341.803179]  ___sys_sendmsg+0x9a/0xe0
[  341.803188]  __sys_sendmsg+0x76/0xc0
[  341.803194]  do_syscall_64+0x3a/0xc0
[  341.803203]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  341.803210] RIP: 0033:0x7fc157fa3980
[  341.803213] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  341.803216] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  341.803219] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  341.803221] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  341.803223] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  341.803224] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  341.803226] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  341.803230]  </TASK>
[  341.803231] ---[ end trace 0000000000000000 ]---
[  341.805450] ------------[ cut here ]------------
[  341.805451] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:6771 ath11k_mac_vdev_stop+0xae/0xf0 [ath11k]
[  341.805460] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  341.805476] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  341.805477] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  341.805478] RIP: 0010:ath11k_mac_vdev_stop+0xae/0xf0 [ath11k]
[  341.805482] Code: 5d 41 5c c3 cc cc cc cc 41 8b 14 24 48 8b 3b 89 c5 89 c1 48 c7 c6 90 86 9e c0 e8 dd a5 01 00 89 e8 5b 5d 41 5c c3 cc cc cc cc <0f> 0b eb b3 bd 94 ff ff ff 41 8b 14 24 89 e9 48 c7 c6 b0 86 9e c0
[  341.805483] RSP: 0018:ffffa1f584a4f788 EFLAGS: 00010246
[  341.805484] RAX: 0000000000000000 RBX: ffff925766752060 RCX: 0000000000000000
[  341.805484] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 00000000ffffffff
[  341.805485] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  341.805485] R10: 0000000000000001 R11: 000000000000000a R12: ffff9257e320df60
[  341.805486] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  341.805486] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  341.805487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  341.805487] CR2: 0000564238847118 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  341.805488] PKRU: 55555554
[  341.805489] Call Trace:
[  341.805491]  <TASK>
[  341.805491]  ath11k_mac_op_unassign_vif_chanctx+0x60/0x220 [ath11k]
[  341.805497]  ? __wake_up_klogd.part.0+0x56/0x80
[  341.805498]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  341.805514]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  341.805525]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  341.805535]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  341.805549]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  341.805565]  ? __local_bh_enable_ip+0x37/0x90
[  341.805566]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  341.805580]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  341.805592]  ? do_select+0x764/0x830
[  341.805594]  genl_family_rcv_msg_doit+0x100/0x160
[  341.805596]  genl_rcv_msg+0xee/0x1e0
[  341.805597]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  341.805608]  ? genl_get_cmd+0xe0/0xe0
[  341.805609]  netlink_rcv_skb+0x51/0x100
[  341.805610]  genl_rcv+0x24/0x40
[  341.805611]  netlink_unicast+0x242/0x390
[  341.805612]  netlink_sendmsg+0x250/0x4c0
[  341.805613]  sock_sendmsg+0x5f/0x70
[  341.805614]  ____sys_sendmsg+0x267/0x2b0
[  341.805615]  ? copy_msghdr_from_user+0x7d/0xc0
[  341.805617]  ___sys_sendmsg+0x9a/0xe0
[  341.805619]  __sys_sendmsg+0x76/0xc0
[  341.805621]  do_syscall_64+0x3a/0xc0
[  341.805622]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  341.805623] RIP: 0033:0x7fc157fa3980
[  341.805624] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  341.805625] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  341.805626] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  341.805626] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  341.805627] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  341.805627] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  341.805628] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  341.805629]  </TASK>
[  341.805629] ---[ end trace 0000000000000000 ]---
[  341.805631] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  341.805633] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  342.006822] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  342.041124] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  342.041128] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  342.053121] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  342.078726] wlp1s0: failed to insert STA entry for the AP (error -2)
[  342.078748] ------------[ cut here ]------------
[  342.078751] WARNING: CPU: 5 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  342.078776] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  342.078832] CPU: 5 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  342.078836] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  342.078838] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  342.078853] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  342.078856] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  342.078859] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff9257428d0f58
[  342.078861] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  342.078863] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  342.078865] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  342.078866] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff9257428d0f58
[  342.078868] FS:  00007fc157e97c40(0000) GS:ffff925e1ef40000(0000) knlGS:0000000000000000
[  342.078871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  342.078873] CR2: 0000564238848a88 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  342.078875] PKRU: 55555554
[  342.078877] Call Trace:
[  342.078879]  <TASK>
[  342.078880]  ? __wake_up_klogd.part.0+0x56/0x80
[  342.078887]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  342.078941]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  342.078979]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  342.079016]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  342.079063]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  342.079117]  ? __local_bh_enable_ip+0x37/0x90
[  342.079122]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  342.079171]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  342.079213]  ? do_select+0x764/0x830
[  342.079220]  genl_family_rcv_msg_doit+0x100/0x160
[  342.079226]  genl_rcv_msg+0xee/0x1e0
[  342.079229]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  342.079268]  ? genl_get_cmd+0xe0/0xe0
[  342.079271]  netlink_rcv_skb+0x51/0x100
[  342.079275]  genl_rcv+0x24/0x40
[  342.079277]  netlink_unicast+0x242/0x390
[  342.079281]  netlink_sendmsg+0x250/0x4c0
[  342.079285]  sock_sendmsg+0x5f/0x70
[  342.079289]  ____sys_sendmsg+0x267/0x2b0
[  342.079292]  ? copy_msghdr_from_user+0x7d/0xc0
[  342.079297]  ___sys_sendmsg+0x9a/0xe0
[  342.079305]  __sys_sendmsg+0x76/0xc0
[  342.079311]  do_syscall_64+0x3a/0xc0
[  342.079316]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  342.079320] RIP: 0033:0x7fc157fa3980
[  342.079323] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  342.079326] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  342.079329] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  342.079331] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  342.079333] RBP: 0000564238832070 R08: 0000000000000004 R09: 000000000000000d
[  342.079334] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  342.079336] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  342.079340]  </TASK>
[  342.079341] ---[ end trace 0000000000000000 ]---
[  342.081457] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  342.081459] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  347.359642] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  347.401458] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  347.401462] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  347.413694] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  347.442760] wlp1s0: failed to insert STA entry for the AP (error -2)
[  347.442787] ------------[ cut here ]------------
[  347.442789] WARNING: CPU: 5 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  347.442821] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  347.442905] CPU: 5 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  347.442911] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  347.442914] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  347.442928] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  347.442931] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  347.442936] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff9257428d0f58
[  347.442938] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  347.442940] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  347.442942] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  347.442943] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff9257428d0f58
[  347.442945] FS:  00007fc157e97c40(0000) GS:ffff925e1ef40000(0000) knlGS:0000000000000000
[  347.442948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  347.442950] CR2: 0000564238853118 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  347.442953] PKRU: 55555554
[  347.442954] Call Trace:
[  347.442959]  <TASK>
[  347.442961]  ? __wake_up_klogd.part.0+0x56/0x80
[  347.442973]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  347.443032]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  347.443070]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  347.443108]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  347.443157]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  347.443213]  ? __local_bh_enable_ip+0x37/0x90
[  347.443220]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  347.443278]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  347.443321]  ? do_select+0x764/0x830
[  347.443331]  genl_family_rcv_msg_doit+0x100/0x160
[  347.443341]  genl_rcv_msg+0xee/0x1e0
[  347.443344]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  347.443383]  ? genl_get_cmd+0xe0/0xe0
[  347.443386]  netlink_rcv_skb+0x51/0x100
[  347.443391]  genl_rcv+0x24/0x40
[  347.443394]  netlink_unicast+0x242/0x390
[  347.443398]  netlink_sendmsg+0x250/0x4c0
[  347.443402]  sock_sendmsg+0x5f/0x70
[  347.443410]  ____sys_sendmsg+0x267/0x2b0
[  347.443414]  ? copy_msghdr_from_user+0x7d/0xc0
[  347.443419]  ___sys_sendmsg+0x9a/0xe0
[  347.443428]  __sys_sendmsg+0x76/0xc0
[  347.443434]  do_syscall_64+0x3a/0xc0
[  347.443443]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  347.443450] RIP: 0033:0x7fc157fa3980
[  347.443453] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  347.443456] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  347.443460] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  347.443461] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  347.443463] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  347.443465] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  347.443466] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  347.443470]  </TASK>
[  347.443471] ---[ end trace 0000000000000000 ]---
[  347.445540] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  347.445543] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  347.650771] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  347.681744] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  347.681750] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  347.694088] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  347.714787] wlp1s0: failed to insert STA entry for the AP (error -2)
[  347.714808] ------------[ cut here ]------------
[  347.714810] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  347.714836] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  347.714891] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  347.714896] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  347.714898] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  347.714913] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  347.714915] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  347.714919] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  347.714921] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  347.714922] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  347.714924] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  347.714926] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  347.714928] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  347.714930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  347.714932] CR2: 0000564238847118 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  347.714935] PKRU: 55555554
[  347.714936] Call Trace:
[  347.714938]  <TASK>
[  347.714940]  ? __wake_up_klogd.part.0+0x56/0x80
[  347.714947]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  347.715001]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  347.715039]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  347.715076]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  347.715122]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  347.715177]  ? __local_bh_enable_ip+0x37/0x90
[  347.715182]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  347.715231]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  347.715273]  ? do_select+0x764/0x830
[  347.715280]  genl_family_rcv_msg_doit+0x100/0x160
[  347.715285]  genl_rcv_msg+0xee/0x1e0
[  347.715289]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  347.715327]  ? genl_get_cmd+0xe0/0xe0
[  347.715330]  netlink_rcv_skb+0x51/0x100
[  347.715334]  genl_rcv+0x24/0x40
[  347.715337]  netlink_unicast+0x242/0x390
[  347.715341]  netlink_sendmsg+0x250/0x4c0
[  347.715345]  sock_sendmsg+0x5f/0x70
[  347.715349]  ____sys_sendmsg+0x267/0x2b0
[  347.715352]  ? copy_msghdr_from_user+0x7d/0xc0
[  347.715357]  ___sys_sendmsg+0x9a/0xe0
[  347.715365]  __sys_sendmsg+0x76/0xc0
[  347.715371]  do_syscall_64+0x3a/0xc0
[  347.715376]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  347.715380] RIP: 0033:0x7fc157fa3980
[  347.715384] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  347.715386] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  347.715389] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  347.715391] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  347.715393] RBP: 0000564238850740 R08: 0000000000000004 R09: 000000000000000d
[  347.715394] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  347.715396] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  347.715400]  </TASK>
[  347.715401] ---[ end trace 0000000000000000 ]---
[  347.717486] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  347.717493] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  353.287613] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  353.318003] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  353.318008] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  353.329504] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  353.354510] wlp1s0: failed to insert STA entry for the AP (error -2)
[  353.354535] ------------[ cut here ]------------
[  353.354538] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  353.354569] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  353.354656] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  353.354661] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  353.354664] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  353.354679] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  353.354682] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  353.354687] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  353.354689] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  353.354690] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  353.354692] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  353.354694] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  353.354696] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  353.354699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  353.354701] CR2: 000056423885a1d8 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  353.354703] PKRU: 55555554
[  353.354705] Call Trace:
[  353.354710]  <TASK>
[  353.354712]  ? __wake_up_klogd.part.0+0x56/0x80
[  353.354725]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  353.354784]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  353.354822]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  353.354860]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  353.354907]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  353.354963]  ? __local_bh_enable_ip+0x37/0x90
[  353.354969]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  353.355026]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  353.355070]  ? do_select+0x764/0x830
[  353.355080]  genl_family_rcv_msg_doit+0x100/0x160
[  353.355090]  genl_rcv_msg+0xee/0x1e0
[  353.355093]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  353.355132]  ? genl_get_cmd+0xe0/0xe0
[  353.355135]  netlink_rcv_skb+0x51/0x100
[  353.355140]  genl_rcv+0x24/0x40
[  353.355143]  netlink_unicast+0x242/0x390
[  353.355147]  netlink_sendmsg+0x250/0x4c0
[  353.355151]  sock_sendmsg+0x5f/0x70
[  353.355159]  ____sys_sendmsg+0x267/0x2b0
[  353.355163]  ? copy_msghdr_from_user+0x7d/0xc0
[  353.355168]  ___sys_sendmsg+0x9a/0xe0
[  353.355176]  __sys_sendmsg+0x76/0xc0
[  353.355182]  do_syscall_64+0x3a/0xc0
[  353.355191]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  353.355198] RIP: 0033:0x7fc157fa3980
[  353.355201] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  353.355204] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  353.355208] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  353.355209] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  353.355211] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  353.355212] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  353.355214] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  353.355218]  </TASK>
[  353.355219] ---[ end trace 0000000000000000 ]---
[  353.357284] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  353.357287] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  353.482767] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  353.512743] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  353.512749] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  353.517522] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  353.534731] wlp1s0: failed to insert STA entry for the AP (error -2)
[  353.534756] ------------[ cut here ]------------
[  353.534758] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  353.534781] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  353.534836] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  353.534841] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  353.534843] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  353.534857] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  353.534860] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  353.534864] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  353.534866] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  353.534867] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  353.534869] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  353.534871] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  353.534873] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  353.534875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  353.534877] CR2: 000056423885a1d8 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  353.534880] PKRU: 55555554
[  353.534881] Call Trace:
[  353.534883]  <TASK>
[  353.534885]  ? __wake_up_klogd.part.0+0x56/0x80
[  353.534892]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  353.534946]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  353.534984]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  353.535021]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  353.535068]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  353.535122]  ? __local_bh_enable_ip+0x37/0x90
[  353.535127]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  353.535177]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  353.535218]  ? do_select+0x764/0x830
[  353.535225]  genl_family_rcv_msg_doit+0x100/0x160
[  353.535231]  genl_rcv_msg+0xee/0x1e0
[  353.535234]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  353.535273]  ? genl_get_cmd+0xe0/0xe0
[  353.535276]  netlink_rcv_skb+0x51/0x100
[  353.535280]  genl_rcv+0x24/0x40
[  353.535282]  netlink_unicast+0x242/0x390
[  353.535286]  netlink_sendmsg+0x250/0x4c0
[  353.535290]  sock_sendmsg+0x5f/0x70
[  353.535294]  ____sys_sendmsg+0x267/0x2b0
[  353.535297]  ? copy_msghdr_from_user+0x7d/0xc0
[  353.535302]  ___sys_sendmsg+0x9a/0xe0
[  353.535310]  __sys_sendmsg+0x76/0xc0
[  353.535316]  do_syscall_64+0x3a/0xc0
[  353.535321]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  353.535325] RIP: 0033:0x7fc157fa3980
[  353.535329] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  353.535331] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  353.535334] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  353.535336] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  353.535338] RBP: 0000564238851ea0 R08: 0000000000000004 R09: 000000000000000d
[  353.535340] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  353.535341] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  353.535345]  </TASK>
[  353.535346] ---[ end trace 0000000000000000 ]---
[  353.537393] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  353.537401] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  359.639552] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  359.672921] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  359.672927] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  359.685170] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  359.710794] wlp1s0: failed to insert STA entry for the AP (error -2)
[  359.710824] ------------[ cut here ]------------
[  359.710826] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  359.710857] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  359.710941] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  359.710947] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  359.710950] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  359.710964] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  359.710967] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  359.710971] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  359.710974] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  359.710975] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  359.710977] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  359.710979] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  359.710981] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  359.710983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  359.710985] CR2: 000056423885f088 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  359.710988] PKRU: 55555554
[  359.710990] Call Trace:
[  359.710994]  <TASK>
[  359.710996]  ? __wake_up_klogd.part.0+0x56/0x80
[  359.711009]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  359.711069]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  359.711107]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  359.711145]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  359.711192]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  359.711248]  ? __local_bh_enable_ip+0x37/0x90
[  359.711255]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  359.711314]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  359.711357]  ? do_select+0x764/0x830
[  359.711368]  genl_family_rcv_msg_doit+0x100/0x160
[  359.711378]  genl_rcv_msg+0xee/0x1e0
[  359.711381]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  359.711420]  ? genl_get_cmd+0xe0/0xe0
[  359.711423]  netlink_rcv_skb+0x51/0x100
[  359.711428]  genl_rcv+0x24/0x40
[  359.711431]  netlink_unicast+0x242/0x390
[  359.711435]  netlink_sendmsg+0x250/0x4c0
[  359.711439]  sock_sendmsg+0x5f/0x70
[  359.711447]  ____sys_sendmsg+0x267/0x2b0
[  359.711451]  ? copy_msghdr_from_user+0x7d/0xc0
[  359.711456]  ___sys_sendmsg+0x9a/0xe0
[  359.711465]  __sys_sendmsg+0x76/0xc0
[  359.711471]  do_syscall_64+0x3a/0xc0
[  359.711480]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  359.711487] RIP: 0033:0x7fc157fa3980
[  359.711491] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  359.711493] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  359.711497] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  359.711499] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  359.711501] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  359.711503] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  359.711504] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  359.711508]  </TASK>
[  359.711509] ---[ end trace 0000000000000000 ]---
[  359.713550] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  359.713553] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  359.826800] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  359.860435] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  359.860441] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  359.865070] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  359.882503] wlp1s0: failed to insert STA entry for the AP (error -2)
[  359.882522] ------------[ cut here ]------------
[  359.882523] WARNING: CPU: 5 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  359.882549] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  359.882606] CPU: 5 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  359.882611] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  359.882613] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  359.882627] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  359.882630] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  359.882633] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff9257428d0f58
[  359.882636] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  359.882637] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  359.882639] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  359.882640] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff9257428d0f58
[  359.882642] FS:  00007fc157e97c40(0000) GS:ffff925e1ef40000(0000) knlGS:0000000000000000
[  359.882645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  359.882647] CR2: 0000000000412184 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  359.882650] PKRU: 55555554
[  359.882651] Call Trace:
[  359.882653]  <TASK>
[  359.882655]  ? __wake_up_klogd.part.0+0x56/0x80
[  359.882662]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  359.882716]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  359.882754]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  359.882791]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  359.882838]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  359.882892]  ? __local_bh_enable_ip+0x37/0x90
[  359.882896]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  359.882946]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  359.882988]  ? do_select+0x764/0x830
[  359.882995]  genl_family_rcv_msg_doit+0x100/0x160
[  359.883000]  genl_rcv_msg+0xee/0x1e0
[  359.883004]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  359.883042]  ? genl_get_cmd+0xe0/0xe0
[  359.883045]  netlink_rcv_skb+0x51/0x100
[  359.883049]  genl_rcv+0x24/0x40
[  359.883052]  netlink_unicast+0x242/0x390
[  359.883056]  netlink_sendmsg+0x250/0x4c0
[  359.883059]  sock_sendmsg+0x5f/0x70
[  359.883063]  ____sys_sendmsg+0x267/0x2b0
[  359.883067]  ? copy_msghdr_from_user+0x7d/0xc0
[  359.883072]  ___sys_sendmsg+0x9a/0xe0
[  359.883080]  __sys_sendmsg+0x76/0xc0
[  359.883086]  do_syscall_64+0x3a/0xc0
[  359.883091]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  359.883096] RIP: 0033:0x7fc157fa3980
[  359.883099] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  359.883101] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  359.883105] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  359.883106] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  359.883108] RBP: 000056423884a6b0 R08: 0000000000000004 R09: 000000000000000d
[  359.883110] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  359.883111] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  359.883115]  </TASK>
[  359.883117] ---[ end trace 0000000000000000 ]---
[  359.885119] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  359.885123] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  369.975421] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  370.004234] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  370.004340] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  370.008860] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  370.034748] wlp1s0: failed to insert STA entry for the AP (error -2)
[  370.034769] ------------[ cut here ]------------
[  370.034772] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  370.034807] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  370.034892] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  370.034898] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  370.034901] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  370.034916] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  370.034919] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  370.034924] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  370.034926] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  370.034928] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  370.034930] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  370.034931] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  370.034934] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  370.034936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  370.034938] CR2: 00005642388610b8 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  370.034941] PKRU: 55555554
[  370.034942] Call Trace:
[  370.034947]  <TASK>
[  370.034949]  ? __wake_up_klogd.part.0+0x56/0x80
[  370.034962]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  370.035021]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  370.035059]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  370.035096]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  370.035144]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  370.035200]  ? __local_bh_enable_ip+0x37/0x90
[  370.035207]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  370.035264]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  370.035307]  ? do_select+0x764/0x830
[  370.035318]  genl_family_rcv_msg_doit+0x100/0x160
[  370.035327]  genl_rcv_msg+0xee/0x1e0
[  370.035331]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  370.035369]  ? genl_get_cmd+0xe0/0xe0
[  370.035373]  netlink_rcv_skb+0x51/0x100
[  370.035378]  genl_rcv+0x24/0x40
[  370.035381]  netlink_unicast+0x242/0x390
[  370.035385]  netlink_sendmsg+0x250/0x4c0
[  370.035389]  sock_sendmsg+0x5f/0x70
[  370.035397]  ____sys_sendmsg+0x267/0x2b0
[  370.035400]  ? copy_msghdr_from_user+0x7d/0xc0
[  370.035406]  ___sys_sendmsg+0x9a/0xe0
[  370.035415]  __sys_sendmsg+0x76/0xc0
[  370.035421]  do_syscall_64+0x3a/0xc0
[  370.035429]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  370.035436] RIP: 0033:0x7fc157fa3980
[  370.035439] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  370.035442] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  370.035445] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  370.035447] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  370.035449] RBP: 000056423884a6b0 R08: 0000000000000004 R09: 000000000000000d
[  370.035450] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  370.035452] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  370.035456]  </TASK>
[  370.035457] ---[ end trace 0000000000000000 ]---
[  370.037503] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  370.037506] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  370.174753] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  370.208253] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  370.208257] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  370.220099] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  370.250756] wlp1s0: failed to insert STA entry for the AP (error -2)
[  370.250781] ------------[ cut here ]------------
[  370.250783] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  370.250809] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  370.250866] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  370.250871] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  370.250873] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  370.250887] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  370.250890] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  370.250893] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  370.250895] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  370.250897] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  370.250899] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  370.250900] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  370.250902] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  370.250905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  370.250907] CR2: 00005642388610b8 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  370.250909] PKRU: 55555554
[  370.250911] Call Trace:
[  370.250913]  <TASK>
[  370.250914]  ? __wake_up_klogd.part.0+0x56/0x80
[  370.250921]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  370.250975]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  370.251013]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  370.251050]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  370.251097]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  370.251151]  ? __local_bh_enable_ip+0x37/0x90
[  370.251156]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  370.251205]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  370.251247]  ? do_select+0x764/0x830
[  370.251254]  genl_family_rcv_msg_doit+0x100/0x160
[  370.251260]  genl_rcv_msg+0xee/0x1e0
[  370.251263]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  370.251302]  ? genl_get_cmd+0xe0/0xe0
[  370.251305]  netlink_rcv_skb+0x51/0x100
[  370.251309]  genl_rcv+0x24/0x40
[  370.251312]  netlink_unicast+0x242/0x390
[  370.251315]  netlink_sendmsg+0x250/0x4c0
[  370.251319]  sock_sendmsg+0x5f/0x70
[  370.251323]  ____sys_sendmsg+0x267/0x2b0
[  370.251326]  ? copy_msghdr_from_user+0x7d/0xc0
[  370.251332]  ___sys_sendmsg+0x9a/0xe0
[  370.251340]  __sys_sendmsg+0x76/0xc0
[  370.251345]  do_syscall_64+0x3a/0xc0
[  370.251350]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  370.251354] RIP: 0033:0x7fc157fa3980
[  370.251358] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  370.251360] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  370.251364] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  370.251365] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  370.251367] RBP: 0000564238832070 R08: 0000000000000004 R09: 000000000000000d
[  370.251369] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  370.251370] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  370.251374]  </TASK>
[  370.251375] ---[ end trace 0000000000000000 ]---
[  370.253465] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  370.253472] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  407.351484] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  407.384591] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  407.384595] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  407.396362] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  407.414502] wlp1s0: failed to insert STA entry for the AP (error -2)
[  407.414527] ------------[ cut here ]------------
[  407.414530] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  407.414561] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  407.414646] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  407.414651] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  407.414654] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  407.414669] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  407.414672] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  407.414676] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  407.414679] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  407.414681] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  407.414682] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  407.414684] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  407.414686] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  407.414689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.414691] CR2: 0000564238864000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  407.414693] PKRU: 55555554
[  407.414695] Call Trace:
[  407.414700]  <TASK>
[  407.414702]  ? __wake_up_klogd.part.0+0x56/0x80
[  407.414715]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  407.414776]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  407.414815]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  407.414852]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  407.414902]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  407.414958]  ? __local_bh_enable_ip+0x37/0x90
[  407.414965]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  407.415029]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  407.415071]  ? do_select+0x764/0x830
[  407.415082]  genl_family_rcv_msg_doit+0x100/0x160
[  407.415092]  genl_rcv_msg+0xee/0x1e0
[  407.415095]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  407.415134]  ? genl_get_cmd+0xe0/0xe0
[  407.415137]  netlink_rcv_skb+0x51/0x100
[  407.415142]  genl_rcv+0x24/0x40
[  407.415145]  netlink_unicast+0x242/0x390
[  407.415149]  netlink_sendmsg+0x250/0x4c0
[  407.415153]  sock_sendmsg+0x5f/0x70
[  407.415161]  ____sys_sendmsg+0x267/0x2b0
[  407.415165]  ? copy_msghdr_from_user+0x7d/0xc0
[  407.415170]  ___sys_sendmsg+0x9a/0xe0
[  407.415179]  __sys_sendmsg+0x76/0xc0
[  407.415185]  do_syscall_64+0x3a/0xc0
[  407.415194]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  407.415201] RIP: 0033:0x7fc157fa3980
[  407.415205] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  407.415207] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  407.415211] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  407.415213] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  407.415214] RBP: 0000564238832860 R08: 0000000000000004 R09: 000000000000000d
[  407.415216] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  407.415218] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  407.415221]  </TASK>
[  407.415223] ---[ end trace 0000000000000000 ]---
[  407.417306] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  407.417314] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  407.550770] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  407.584381] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  407.584385] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  407.595868] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  407.626873] wlp1s0: failed to insert STA entry for the AP (error -2)
[  407.626898] ------------[ cut here ]------------
[  407.626900] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  407.626924] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  407.626980] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  407.626985] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  407.626987] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  407.627001] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  407.627004] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  407.627008] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  407.627010] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  407.627012] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  407.627014] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  407.627015] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  407.627017] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  407.627020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.627022] CR2: 0000564238864000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  407.627025] PKRU: 55555554
[  407.627026] Call Trace:
[  407.627028]  <TASK>
[  407.627030]  ? __wake_up_klogd.part.0+0x56/0x80
[  407.627037]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  407.627091]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  407.627129]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  407.627166]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  407.627213]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  407.627267]  ? __local_bh_enable_ip+0x37/0x90
[  407.627272]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  407.627322]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  407.627363]  ? do_select+0x764/0x830
[  407.627370]  genl_family_rcv_msg_doit+0x100/0x160
[  407.627376]  genl_rcv_msg+0xee/0x1e0
[  407.627379]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  407.627418]  ? genl_get_cmd+0xe0/0xe0
[  407.627421]  netlink_rcv_skb+0x51/0x100
[  407.627425]  genl_rcv+0x24/0x40
[  407.627428]  netlink_unicast+0x242/0x390
[  407.627431]  netlink_sendmsg+0x250/0x4c0
[  407.627435]  sock_sendmsg+0x5f/0x70
[  407.627439]  ____sys_sendmsg+0x267/0x2b0
[  407.627443]  ? copy_msghdr_from_user+0x7d/0xc0
[  407.627448]  ___sys_sendmsg+0x9a/0xe0
[  407.627456]  __sys_sendmsg+0x76/0xc0
[  407.627462]  do_syscall_64+0x3a/0xc0
[  407.627466]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  407.627471] RIP: 0033:0x7fc157fa3980
[  407.627474] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  407.627477] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  407.627481] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  407.627482] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  407.627484] RBP: 0000564238831bc0 R08: 0000000000000004 R09: 000000000000000d
[  407.627486] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  407.627488] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  407.627492]  </TASK>
[  407.627493] ---[ end trace 0000000000000000 ]---
[  407.629542] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  407.629550] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  470.739563] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  470.772015] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  470.772019] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  470.783707] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  470.806505] wlp1s0: failed to insert STA entry for the AP (error -2)
[  470.806531] ------------[ cut here ]------------
[  470.806533] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  470.806566] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  470.806653] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  470.806659] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  470.806662] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  470.806677] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  470.806680] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  470.806684] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  470.806687] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  470.806688] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  470.806690] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  470.806692] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  470.806694] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  470.806697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  470.806699] CR2: 0000564238867148 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  470.806701] PKRU: 55555554
[  470.806703] Call Trace:
[  470.806708]  <TASK>
[  470.806710]  ? __wake_up_klogd.part.0+0x56/0x80
[  470.806723]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  470.806790]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  470.806829]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  470.806866]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  470.806914]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  470.806971]  ? __local_bh_enable_ip+0x37/0x90
[  470.806978]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  470.807037]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  470.807079]  ? do_select+0x764/0x830
[  470.807090]  genl_family_rcv_msg_doit+0x100/0x160
[  470.807100]  genl_rcv_msg+0xee/0x1e0
[  470.807103]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  470.807142]  ? genl_get_cmd+0xe0/0xe0
[  470.807145]  netlink_rcv_skb+0x51/0x100
[  470.807150]  genl_rcv+0x24/0x40
[  470.807154]  netlink_unicast+0x242/0x390
[  470.807157]  netlink_sendmsg+0x250/0x4c0
[  470.807161]  sock_sendmsg+0x5f/0x70
[  470.807169]  ____sys_sendmsg+0x267/0x2b0
[  470.807173]  ? copy_msghdr_from_user+0x7d/0xc0
[  470.807179]  ___sys_sendmsg+0x9a/0xe0
[  470.807187]  __sys_sendmsg+0x76/0xc0
[  470.807193]  do_syscall_64+0x3a/0xc0
[  470.807202]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  470.807210] RIP: 0033:0x7fc157fa3980
[  470.807213] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  470.807216] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  470.807219] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  470.807221] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  470.807223] RBP: 000056423884a6b0 R08: 0000000000000004 R09: 000000000000000d
[  470.807224] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  470.807226] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  470.807230]  </TASK>
[  470.807231] ---[ end trace 0000000000000000 ]---
[  470.809316] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  470.809325] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  470.938698] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  470.972088] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  470.972091] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  470.984125] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  471.018736] wlp1s0: failed to insert STA entry for the AP (error -2)
[  471.018763] ------------[ cut here ]------------
[  471.018765] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  471.018789] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  471.018846] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  471.018850] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  471.018852] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  471.018867] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  471.018871] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  471.018874] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  471.018876] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  471.018878] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  471.018880] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  471.018881] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  471.018883] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  471.018886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  471.018888] CR2: 0000564238867148 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  471.018890] PKRU: 55555554
[  471.018892] Call Trace:
[  471.018894]  <TASK>
[  471.018895]  ? __wake_up_klogd.part.0+0x56/0x80
[  471.018902]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  471.018957]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  471.018995]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  471.019032]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  471.019079]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  471.019133]  ? __local_bh_enable_ip+0x37/0x90
[  471.019138]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  471.019187]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  471.019229]  ? do_select+0x764/0x830
[  471.019236]  genl_family_rcv_msg_doit+0x100/0x160
[  471.019242]  genl_rcv_msg+0xee/0x1e0
[  471.019245]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  471.019284]  ? genl_get_cmd+0xe0/0xe0
[  471.019287]  netlink_rcv_skb+0x51/0x100
[  471.019291]  genl_rcv+0x24/0x40
[  471.019293]  netlink_unicast+0x242/0x390
[  471.019297]  netlink_sendmsg+0x250/0x4c0
[  471.019301]  sock_sendmsg+0x5f/0x70
[  471.019305]  ____sys_sendmsg+0x267/0x2b0
[  471.019308]  ? copy_msghdr_from_user+0x7d/0xc0
[  471.019313]  ___sys_sendmsg+0x9a/0xe0
[  471.019322]  __sys_sendmsg+0x76/0xc0
[  471.019327]  do_syscall_64+0x3a/0xc0
[  471.019332]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  471.019336] RIP: 0033:0x7fc157fa3980
[  471.019340] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  471.019342] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  471.019346] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  471.019348] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  471.019349] RBP: 0000564238851ea0 R08: 0000000000000004 R09: 000000000000000d
[  471.019351] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  471.019353] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  471.019357]  </TASK>
[  471.019358] ---[ end trace 0000000000000000 ]---
[  471.021403] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  471.021406] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  569.147736] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  569.180080] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  569.180084] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  569.191800] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  569.210727] wlp1s0: failed to insert STA entry for the AP (error -2)
[  569.210752] ------------[ cut here ]------------
[  569.210754] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  569.210786] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  569.210872] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  569.210878] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  569.210881] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  569.210896] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  569.210899] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  569.210904] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  569.210906] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  569.210908] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  569.210910] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  569.210911] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  569.210913] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  569.210916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  569.210918] CR2: 000056423886a000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  569.210920] PKRU: 55555554
[  569.210922] Call Trace:
[  569.210927]  <TASK>
[  569.210929]  ? __wake_up_klogd.part.0+0x56/0x80
[  569.210941]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  569.211002]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  569.211040]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  569.211078]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  569.211125]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  569.211182]  ? __local_bh_enable_ip+0x37/0x90
[  569.211189]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  569.211248]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  569.211290]  ? do_select+0x764/0x830
[  569.211300]  genl_family_rcv_msg_doit+0x100/0x160
[  569.211310]  genl_rcv_msg+0xee/0x1e0
[  569.211313]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  569.211351]  ? genl_get_cmd+0xe0/0xe0
[  569.211354]  netlink_rcv_skb+0x51/0x100
[  569.211359]  genl_rcv+0x24/0x40
[  569.211362]  netlink_unicast+0x242/0x390
[  569.211366]  netlink_sendmsg+0x250/0x4c0
[  569.211370]  sock_sendmsg+0x5f/0x70
[  569.211378]  ____sys_sendmsg+0x267/0x2b0
[  569.211382]  ? copy_msghdr_from_user+0x7d/0xc0
[  569.211387]  ___sys_sendmsg+0x9a/0xe0
[  569.211396]  __sys_sendmsg+0x76/0xc0
[  569.211402]  do_syscall_64+0x3a/0xc0
[  569.211411]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  569.211419] RIP: 0033:0x7fc157fa3980
[  569.211421] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  569.211423] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  569.211426] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  569.211427] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  569.211428] RBP: 0000564238851ea0 R08: 0000000000000004 R09: 000000000000000d
[  569.211429] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  569.211431] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  569.211433]  </TASK>
[  569.211433] ---[ end trace 0000000000000000 ]---
[  569.213486] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  569.213492] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  569.354761] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  569.387777] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  569.387781] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  569.392122] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  569.422496] wlp1s0: failed to insert STA entry for the AP (error -2)
[  569.422514] ------------[ cut here ]------------
[  569.422517] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  569.422541] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  569.422601] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  569.422605] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  569.422608] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  569.422622] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  569.422625] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  569.422629] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  569.422631] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  569.422633] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  569.422635] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  569.422636] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  569.422638] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  569.422641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  569.422643] CR2: 000056423886a000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  569.422645] PKRU: 55555554
[  569.422647] Call Trace:
[  569.422649]  <TASK>
[  569.422650]  ? __wake_up_klogd.part.0+0x56/0x80
[  569.422657]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  569.422711]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  569.422749]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  569.422786]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  569.422833]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  569.422888]  ? __local_bh_enable_ip+0x37/0x90
[  569.422892]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  569.422949]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  569.422991]  ? do_select+0x764/0x830
[  569.422998]  genl_family_rcv_msg_doit+0x100/0x160
[  569.423004]  genl_rcv_msg+0xee/0x1e0
[  569.423007]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  569.423046]  ? genl_get_cmd+0xe0/0xe0
[  569.423049]  netlink_rcv_skb+0x51/0x100
[  569.423053]  genl_rcv+0x24/0x40
[  569.423056]  netlink_unicast+0x242/0x390
[  569.423059]  netlink_sendmsg+0x250/0x4c0
[  569.423063]  sock_sendmsg+0x5f/0x70
[  569.423067]  ____sys_sendmsg+0x267/0x2b0
[  569.423070]  ? copy_msghdr_from_user+0x7d/0xc0
[  569.423076]  ___sys_sendmsg+0x9a/0xe0
[  569.423084]  __sys_sendmsg+0x76/0xc0
[  569.423089]  do_syscall_64+0x3a/0xc0
[  569.423094]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  569.423099] RIP: 0033:0x7fc157fa3980
[  569.423102] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  569.423105] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  569.423108] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  569.423110] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  569.423112] RBP: 0000564238850740 R08: 0000000000000004 R09: 000000000000000d
[  569.423114] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  569.423116] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  569.423120]  </TASK>
[  569.423121] ---[ end trace 0000000000000000 ]---
[  569.425211] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  569.425219] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  658.547507] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  658.579861] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  658.579864] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  658.591587] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  658.626502] wlp1s0: failed to insert STA entry for the AP (error -2)
[  658.626527] ------------[ cut here ]------------
[  658.626530] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  658.626564] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  658.626650] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  658.626656] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  658.626659] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  658.626674] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  658.626677] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  658.626681] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  658.626684] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  658.626686] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  658.626688] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  658.626689] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  658.626691] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  658.626694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  658.626696] CR2: 000056423886a000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  658.626699] PKRU: 55555554
[  658.626700] Call Trace:
[  658.626705]  <TASK>
[  658.626707]  ? __wake_up_klogd.part.0+0x56/0x80
[  658.626719]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  658.626779]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  658.626817]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  658.626855]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  658.626902]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  658.626958]  ? __local_bh_enable_ip+0x37/0x90
[  658.626965]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  658.627022]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  658.627064]  ? do_select+0x764/0x830
[  658.627075]  genl_family_rcv_msg_doit+0x100/0x160
[  658.627085]  genl_rcv_msg+0xee/0x1e0
[  658.627088]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  658.627127]  ? genl_get_cmd+0xe0/0xe0
[  658.627130]  netlink_rcv_skb+0x51/0x100
[  658.627135]  genl_rcv+0x24/0x40
[  658.627138]  netlink_unicast+0x242/0x390
[  658.627142]  netlink_sendmsg+0x250/0x4c0
[  658.627146]  sock_sendmsg+0x5f/0x70
[  658.627154]  ____sys_sendmsg+0x267/0x2b0
[  658.627158]  ? copy_msghdr_from_user+0x7d/0xc0
[  658.627163]  ___sys_sendmsg+0x9a/0xe0
[  658.627172]  __sys_sendmsg+0x76/0xc0
[  658.627178]  do_syscall_64+0x3a/0xc0
[  658.627187]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  658.627194] RIP: 0033:0x7fc157fa3980
[  658.627197] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  658.627200] RSP: 002b:00007ffcf57a6768 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  658.627204] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  658.627206] RDX: 0000000000000000 RSI: 00007ffcf57a67a0 RDI: 000000000000000a
[  658.627207] RBP: 0000564238850740 R08: 0000000000000004 R09: 000000000000000d
[  658.627209] R10: 00007ffcf57a6884 R11: 0000000000000202 R12: 0000564238805e70
[  658.627211] R13: 00007ffcf57a67a0 R14: 0000000000000000 R15: 00007ffcf57a6884
[  658.627214]  </TASK>
[  658.627216] ---[ end trace 0000000000000000 ]---
[  658.629269] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  658.629273] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
[  658.846769] wlp1s0: authenticate with 0c:70:4a:89:bc:64
[  658.880367] ath11k_pci 0000:01:00.0: failed to setup rx defrag context
[  658.880372] ath11k_pci 0000:01:00.0: failed to setup dp for peer 0c:70:4a:89:bc:64 on vdev 0 (-2)
[  658.892166] ath11k_pci 0000:01:00.0: Failed to add station: 0c:70:4a:89:bc:64 for VDEV: 0
[  658.922497] wlp1s0: failed to insert STA entry for the AP (error -2)
[  658.922517] ------------[ cut here ]------------
[  658.922519] WARNING: CPU: 10 PID: 9220 at drivers/net/wireless/ath/ath11k/mac.c:7139 ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  658.922542] Modules linked in: ath11k_pci ath11k qmi_helpers mac80211 libarc4 cfg80211 rfkill isofs cdrom qrtr_mhi qrtr mhi_pci_generic mhi nls_ascii nls_cp437 vfat fat sd_mod uas usb_storage scsi_mod scsi_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_soc_dmic snd_acp6x_pdm_dma snd_soc_acp6x_mach snd_soc_core snd_hda_core nvme snd_compress xhci_pci snd_pci_acp6x snd_hwdep nvme_core xhci_hcd snd_pcm snd_pci_acp5x t10_pi snd_rn_pci_acp3x hid_multitouch snd_acp_config snd_timer crc64_rocksoft hid_generic snd_soc_acpi crc64 psmouse usbcore crc32_pclmul evdev snd usb_common i2c_hid_acpi snd_pci_acp3x soundcore crc_t10dif crct10dif_common i2c_hid wmi fan battery hid video [last unloaded: ath11k_pci]
[  658.922600] CPU: 10 PID: 9220 Comm: wpa_supplicant Tainted: G        W          6.0.0-5-amd64 #1  Debian 6.0.10-1
[  658.922605] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
[  658.922607] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1c5/0x220 [ath11k]
[  658.922621] Code: ff ff ff 48 89 ef e8 ea b2 ff ff 85 c0 0f 84 f5 fe ff ff 48 8b 7d 00 89 c2 48 c7 c6 b8 93 9e c0 e8 30 55 01 00 e9 de fe ff ff <0f> 0b e9 6e fe ff ff 4c 8d b3 c8 04 00 00 8b b3 08 04 00 00 48 89
[  658.922625] RSP: 0018:ffffa1f584a4f7a8 EFLAGS: 00010246
[  658.922628] RAX: 0000000000000000 RBX: ffff9257e320db58 RCX: ffff925700d6ef58
[  658.922630] RDX: ffff9257a00a99c0 RSI: ffff9257e320db58 RDI: ffff925766755138
[  658.922632] RBP: ffff925766752060 R08: 0000000000000000 R09: ffffa1f584a4f710
[  658.922634] R10: 0000000000000003 R11: ffffffffb74d22a8 R12: ffff9257a2e60000
[  658.922636] R13: ffff925766755138 R14: ffff9257e320d860 R15: ffff925700d6ef58
[  658.922638] FS:  00007fc157e97c40(0000) GS:ffff925e1f080000(0000) knlGS:0000000000000000
[  658.922641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  658.922643] CR2: 000056423886a000 CR3: 00000001a2c60000 CR4: 0000000000750ee0
[  658.922645] PKRU: 55555554
[  658.922646] Call Trace:
[  658.922649]  <TASK>
[  658.922650]  ? __wake_up_klogd.part.0+0x56/0x80
[  658.922657]  ieee80211_assign_link_chanctx+0xa1/0x490 [mac80211]
[  658.922711]  __ieee80211_link_release_channel+0x59/0x120 [mac80211]
[  658.922749]  ieee80211_link_release_channel+0x3b/0x50 [mac80211]
[  658.922786]  ieee80211_prep_connection+0x1c7/0x430 [mac80211]
[  658.922833]  ieee80211_mgd_auth.cold+0xed/0x1ea [mac80211]
[  658.922888]  ? __local_bh_enable_ip+0x37/0x90
[  658.922892]  cfg80211_mlme_auth+0x8f/0x170 [cfg80211]
[  658.922942]  nl80211_authenticate+0x33e/0x3b0 [cfg80211]
[  658.922983]  ? do_select+0x764/0x830
[  658.922991]  genl_family_rcv_msg_doit+0x100/0x160
[  658.922996]  genl_rcv_msg+0xee/0x1e0
[  658.923000]  ? nl80211_parse_key+0x320/0x320 [cfg80211]
[  658.923039]  ? genl_get_cmd+0xe0/0xe0
[  658.923042]  netlink_rcv_skb+0x51/0x100
[  658.923046]  genl_rcv+0x24/0x40
[  658.923048]  netlink_unicast+0x242/0x390
[  658.923052]  netlink_sendmsg+0x250/0x4c0
[  658.923056]  sock_sendmsg+0x5f/0x70
[  658.923060]  ____sys_sendmsg+0x267/0x2b0
[  658.923063]  ? copy_msghdr_from_user+0x7d/0xc0
[  658.923069]  ___sys_sendmsg+0x9a/0xe0
[  658.923077]  __sys_sendmsg+0x76/0xc0
[  658.923082]  do_syscall_64+0x3a/0xc0
[  658.923087]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  658.923092] RIP: 0033:0x7fc157fa3980
[  658.923095] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 61 fc 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[  658.923097] RSP: 002b:00007ffcf57a5bf8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  658.923101] RAX: ffffffffffffffda RBX: 0000564238805f60 RCX: 00007fc157fa3980
[  658.923103] RDX: 0000000000000000 RSI: 00007ffcf57a5c30 RDI: 000000000000000a
[  658.923105] RBP: 0000564238832070 R08: 0000000000000004 R09: 000000000000000d
[  658.923106] R10: 00007ffcf57a5d14 R11: 0000000000000202 R12: 0000564238805e70
[  658.923108] R13: 00007ffcf57a5c30 R14: 0000000000000000 R15: 00007ffcf57a5d14
[  658.923112]  </TASK>
[  658.923113] ---[ end trace 0000000000000000 ]---
[  658.925159] ath11k_pci 0000:01:00.0: failed to find peer vdev_id 0 addr 0c:70:4a:89:bc:64 in delete
[  658.925162] ath11k_pci 0000:01:00.0: failed to delete peer 0c:70:4a:89:bc:64 for vdev 0: -22
