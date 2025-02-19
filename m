Return-Path: <linux-wireless+bounces-19114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE68A3B04F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 05:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512781894588
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC113198E9B;
	Wed, 19 Feb 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="X6W9axhq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eOIvfDNw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389216D9AF
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739938282; cv=none; b=Y+uCg/bsrUiPTZude+ZOWQ3Y4ckEvWBuJOZlREz7VV+M2DcRKpSVtUXImezTskS1i9Y4cFY7YOmrUEXpLl+4masLYS2DXW45y/T004m4jNtzaq6LNyLSH2AAvXKPbVy405rDh5HLhECU49ilurZhcqCwyKeyHeIW6JgM0Y3cl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739938282; c=relaxed/simple;
	bh=FAKVwwCgznN5RFIHmU90FWY0GluhzopmXkqBjlMQIRE=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=NzSceVPvzJ+hZg4R9tNUf9VWNrZyg5PRpYywJPsdSuckoc20N4ohel/S9J8hFkL/hkT/vEVxZC737KCU0f92+d3brFsbJ85GbXGKEH+IH/5qqOX0xj1vaYJtGBslZ1n4YyY50i9hUXYT6idkS1ngk3Azzl/UR3OSOGoRnRUWob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=X6W9axhq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eOIvfDNw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DFC1114019B
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 23:11:18 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 23:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1739938278; x=1740024678; bh=86n08AFGbLJhEqYztPHqtkSiShnYRX52ytG
	Eni5oi78=; b=X6W9axhqcSRI+xA0YdhTwwPEnGmDvezUT5Bc7ui7/T88BuiOyzs
	5n9ju9rbPWNwYigGARDWsIB48dSP1snnRL0biSp0YSUXsO+Jmywm29E+B+zZcdQ/
	+5WS5qP0/Jvunw986XbHGeJ9hVXfxc8K9Fa9vV5fCMNVzu9I1nLOQMMFyEJAWCMS
	DZgGpokxKRnvY5+3aPPGfOImvuvsTnE11Hv3csKWkK+Qb8EJw0e0ksf2iG0O4S3/
	2IWBa6TN6TizKFC4g+bsjN5iNomxh+s7D2naGsS4DWZuuVtHEAMajv/vciiv6l38
	s4lE4PQ2WErsn6bayDeWaEPq70Lr5k+CQSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739938278; x=1740024678; bh=86n08AFGbLJhEqYztPHqtkSiShnYRX52ytG
	Eni5oi78=; b=eOIvfDNwuW7+/6dFc4iPuY6WWa0J5zhkKHj2HpUtkAKV8aRQivc
	TzOPAAFMeMH32B3hniml5spfClOxLH3XhUAEkrfg7jHAkoLUMPisXD1KIQz62WCb
	yufo1RgLOde2oSDAVg4XcE1RomX5Z5qphfv0sJLnV+w0TWqABvAYalioDUclN12+
	qURG+sDXWxapi36IZlhkVTb068qc79BMbWykSt7EZ28c7uoVL4VxD0mcIuGbNcaa
	I6DPL0qtgRM48gVUaF7jC5wNtwc6WVli8ATgiJEjvjdr9Ey47DkebJacEifdwPFA
	OOAJFx8fgCLODRcwDhx/4AsAX3BfcDioKZw==
X-ME-Sender: <xms:5lm1ZwhZhUzmRXHaeZrzA3_WKHkW2QH1IZ1PpDNsPr5x4aHsB8tw9Q>
    <xme:5lm1Z5A0Gq7tepx-oS2byOSR4ydontHXEhmDD2IxFsBZYe0XE4pEqa7jpLwQHf9uX
    yUSjfV9C1EM9tuY6Dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkufgtgfesthhqredtredttdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidf
    uceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvg
    hrnhepudefveeiieeghfdutdevffeiteehtdfgfeejffduteetheegtddtgeevfedvgeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhish
    htshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5lm1Z4EZgvizFryq0QuoDXtR4Z7-XqjG4QK-myrhieZznBTIRl-KPw>
    <xmx:5lm1ZxQuHlh4Ril_TS70qsDDo7-v3IdfpZlJ6YWB7znQWG0pURNwow>
    <xmx:5lm1Z9xa87CbukplYGXEds9848iJtd7n6Iva3uX9zxJkrn-muRZpHg>
    <xmx:5lm1Z_7z9QYfma52WwBR0zYnGulzrp3A56hTamxnRtgwBtl0wIzldw>
    <xmx:5lm1Z7aFjs0wnKgFTThQLN5O1gH5W5DYd__cjh-O-0tgAw5tZKSqkIbD>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A78E1C20066; Tue, 18 Feb 2025 23:11:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 21:10:57 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: linux-wireless@vger.kernel.org
Message-Id: <f08ff316-fb6c-461c-a3d6-bfb0c350ecc0@app.fastmail.com>
Subject: kernel 6.13.3 WARNING: iwlwifi/pcie/tx.c:1889 iwl_pcie_prep_tso
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kernel-6.13.3-200.fc41.x86_64
Wireless-AC 9560
firmware version 46.7e3e4b69.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm

crash:

[14197.852843] wpa_supplicant[1548]: wlp0s20f3: CTRL-EVENT-SIGNAL-CHANGE=
 above=3D1 signal=3D-47 noise=3D9999 txrate=3D0
[14415.247782] geoclue[2142]: Failed to query location: Query location S=
OUP error: Not Found
[14417.128880] geoclue[2142]: Failed to query location: Query location S=
OUP error: Not Found
[14474.835082] kernel: ------------[ cut here ]------------
[14474.835451] kernel: WARNING: CPU: 2 PID: 28007 at drivers/net/wireles=
s/intel/iwlwifi/pcie/tx.c:1889 iwl_pcie_prep_tso+0x29b/0x2c0 [iwlwifi]
[14474.835509] kernel: Modules linked in: vhost_net vhost vhost_iotlb ta=
p tun nft_masq nft_reject_ipv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_c=
onntrack_tftp bridge stp llc uinput rfcomm snd_seq_dummy snd_hrtimer nf_=
conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nf=
t_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ip=
v4 ip_set nf_tables qrtr bnep zstd sunrpc binfmt_misc snd_soc_skl_hda_ds=
p snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_c=
ommon snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_cnl snd_sof_intel_h=
da_generic soundwire_intel soundwire_cadence snd_sof_intel_hda_common sn=
d_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_pci snd=
_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_a=
cpi_intel_sdca_quirks soundwire_generic_allocation snd_soc_acpi soundwir=
e_bus snd_soc_sdca snd_soc_avs
[14474.835729] kernel:  snd_soc_hda_codec snd_hda_ext_core snd_soc_core =
vfat fat snd_compress iwlmvm ac97_bus snd_pcm_dmaengine intel_uncore_fre=
quency intel_uncore_frequency_common intel_pmc_core_pltdrv intel_pmc_cor=
e snd_hda_intel intel_vsec pmt_telemetry pmt_class snd_intel_dspcfg inte=
l_tcc_cooling snd_intel_sdw_acpi x86_pkg_temp_thermal intel_powerclamp s=
nd_hda_codec mac80211 uvcvideo coretemp processor_thermal_device_pci_leg=
acy snd_hda_core kvm_intel uvc snd_ctl_led processor_thermal_device snd_=
hwdep spi_nor snd_seq processor_thermal_wt_hint videobuf2_vmalloc proces=
sor_thermal_rfim libarc4 snd_seq_device intel_rapl_msr processor_thermal=
_rapl videobuf2_memops kvm mtd mei_pxp mei_wdt mei_hdcp btusb thinkpad_a=
cpi intel_rapl_common snd_pcm iTCO_wdt iwlwifi btrtl intel_pmc_bxt video=
buf2_v4l2 btintel processor_thermal_wt_req iTCO_vendor_support videobuf2=
_common think_lmi btbcm mei_me processor_thermal_power_floor spi_intel_p=
ci sparse_keymap cfg80211 rapl btmtk intel_cstate bluetooth videodev int=
el_uncore thunderbolt mc
[14474.835825] kernel:  firmware_attributes_class intel_wmi_thunderbolt =
wmi_bmof platform_profile e1000e spi_intel mei processor_thermal_mbox sn=
d_timer i2c_i801 idma64 i2c_smbus rfkill intel_pch_thermal intel_soc_dts=
_iosf snd int3403_thermal soundcore int340x_thermal_zone int3400_thermal=
 acpi_thermal_rel acpi_pad acpi_tad joydev loop nfnetlink dm_crypt i915 =
i2c_algo_bit drm_buddy ttm nvme drm_display_helper nvme_core crct10dif_p=
clmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic hid_mult=
itouch ucsi_acpi ghash_clmulni_intel sha512_ssse3 sha256_ssse3 typec_ucs=
i sha1_ssse3 cec typec nvme_auth i2c_hid_acpi i2c_hid video wmi pinctrl_=
cannonlake serio_raw fuse
[14474.835928] kernel: CPU: 2 UID: 107 PID: 28007 Comm: vhost-27981 Not =
tainted 6.13.3-200.fc41.x86_64 #1
[14474.835976] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS=
 N2HET77W (1.60 ) 02/06/2024
[14474.836036] kernel: RIP: 0010:iwl_pcie_prep_tso+0x29b/0x2c0 [iwlwifi]
[14474.836078] kernel: Code: 00 00 e8 98 7a 65 da e9 77 fe ff ff 0f 0b 3=
1 ed e9 14 ff ff ff 0f 0b 48 8b 44 24 08 31 ed 48 c7 00 00 00 00 00 e9 f=
f fe ff ff <0f> 0b 31 ed e9 f6 fe ff ff be 02 00 00 00 e8 62 7a 65 da e9=
 41 fe
[14474.836124] kernel: RSP: 0018:ffffaf0e860132a8 EFLAGS: 00010246
[14474.836165] kernel: RAX: 0000000000000000 RBX: ffff9f11435faf00 RCX: =
0000000000000000
[14474.836207] kernel: RDX: 0000000000000000 RSI: ffff9f1177c55900 RDI: =
ffff9f11435faf00
[14474.836247] kernel: RBP: ffff9f1177c558f0 R08: 0000000000000000 R09: =
0000000000000000
[14474.836281] kernel: R10: ffff9f1177c55900 R11: ffff9f13f54db3a4 R12: =
ffff9f14ae74b860
[14474.836322] kernel: R13: ffff9f1148910028 R14: ffff9f1146acca18 R15: =
ffff9f1177c55924
[14474.836371] kernel: FS:  00007f04bdcb31c0(0000) GS:ffff9f14ae700000(0=
000) knlGS:0000000000000000
[14474.836415] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14474.836460] kernel: CR2: 00003862d6b18004 CR3: 0000000113a3a005 CR4: =
00000000003726f0
[14474.836502] kernel: Call Trace:
[14474.836546] kernel:  <TASK>
[14474.836591] kernel:  ? iwl_pcie_prep_tso+0x29b/0x2c0 [iwlwifi]
[14474.836635] kernel:  ? __warn.cold+0x93/0xfa
[14474.836678] kernel:  ? iwl_pcie_prep_tso+0x29b/0x2c0 [iwlwifi]
[14474.836713] kernel:  ? report_bug+0xff/0x140
[14474.836759] kernel:  ? handle_bug+0x58/0x90
[14474.836807] kernel:  ? exc_invalid_op+0x17/0x70
[14474.836840] kernel:  ? asm_exc_invalid_op+0x1a/0x20
[14474.836877] kernel:  ? iwl_pcie_prep_tso+0x29b/0x2c0 [iwlwifi]
[14474.836908] kernel:  ? iwl_pcie_prep_tso+0x15a/0x2c0 [iwlwifi]
[14474.836947] kernel:  iwl_trans_pcie_tx+0x6bf/0xaf0 [iwlwifi]
[14474.836988] kernel:  iwl_mvm_tx_mpdu+0x1fd/0x810 [iwlmvm]
[14474.837055] kernel:  ? ieee80211_xmit_fast_finish+0x22f/0x310 [mac802=
11]
[14474.837101] kernel:  ? iwl_mvm_max_amsdu_size+0xe1/0x200 [iwlmvm]
[14474.837142] kernel:  iwl_mvm_tx_skb_sta+0x1b0/0x5c0 [iwlmvm]
[14474.837182] kernel:  iwl_mvm_tx_skb+0x17/0x40 [iwlmvm]
[14474.837223] kernel:  iwl_mvm_mac_itxq_xmit+0x92/0x100 [iwlmvm]
[14474.837269] kernel:  ieee80211_queue_skb+0x597/0x6d0 [mac80211]
[14474.837312] kernel:  __ieee80211_xmit_fast+0x22c/0x9f0 [mac80211]
[14474.837352] kernel:  ? inet_gso_segment+0x146/0x3d0
[14474.837392] kernel:  __ieee80211_subif_start_xmit+0x3a4/0x420 [mac802=
11]
[14474.837434] kernel:  ieee80211_subif_start_xmit+0x54/0x480 [mac80211]
[14474.837477] kernel:  ? skb_mac_gso_segment+0xbb/0x120
[14474.837515] kernel:  dev_hard_start_xmit+0x61/0x1d0
[14474.837555] kernel:  __dev_queue_xmit+0x23a/0xe80
[14474.837597] kernel:  ? nf_hook_slow+0x42/0xf0
[14474.837640] kernel:  ip_finish_output2+0x2ea/0x650
[14474.837680] kernel:  __netif_receive_skb_one_core+0x87/0xa0
[14474.837722] kernel:  netif_receive_skb+0x11a/0x170
[14474.837763] kernel:  br_handle_frame_finish+0x547/0x650 [bridge]
[14474.837806] kernel:  ? __pfx_br_handle_frame+0x10/0x10 [bridge]
[14474.837849] kernel:  br_handle_frame+0x2eb/0x410 [bridge]
[14474.837891] kernel:  __netif_receive_skb_core.constprop.0+0x205/0x10c0
[14474.837926] kernel:  ? try_to_wake_up+0x306/0x760
[14474.837967] kernel:  ? rcuwait_wake_up+0x2e/0x40
[14474.838019] kernel:  ? kvm_vcpu_kick+0x17/0xf0 [kvm]
[14474.838062] kernel:  ? __apic_accept_irq+0xfd/0x2b0 [kvm]
[14474.838104] kernel:  ? __apic_accept_irq+0xfd/0x2b0 [kvm]
[14474.838131] kernel:  __netif_receive_skb_one_core+0x3a/0xa0
[14474.838166] kernel:  netif_receive_skb+0x11a/0x170
[14474.838198] kernel:  tun_sendmsg+0x48b/0x8ad [tun]
[14474.838246] kernel:  vhost_tx_batch.isra.0+0x6f/0x240 [vhost_net]
[14474.838288] kernel:  handle_tx_copy+0x18e/0x530 [vhost_net]
[14474.838324] kernel:  handle_tx+0xb6/0xd0 [vhost_net]
[14474.838366] kernel:  vhost_run_work_list+0x45/0x70 [vhost]
[14474.838408] kernel:  vhost_task_fn+0x49/0xd0
[14474.838445] kernel:  ? finish_task_switch.isra.0+0x99/0x2e0
[14474.838489] kernel:  ? __pfx_vhost_task_fn+0x10/0x10
[14474.838526] kernel:  ret_from_fork+0x31/0x50
[14474.838567] kernel:  ? __pfx_vhost_task_fn+0x10/0x10
[14474.838602] kernel:  ret_from_fork_asm+0x1a/0x30
[14474.838643] kernel:  </TASK>
[14474.838685] kernel: ---[ end trace 0000000000000000 ]---
[14546.676907] virt-manager[26371]: spice_gtk_session_request_auto_usbre=
dir: assertion 's->auto_usbredir_reqs > 0' failed

$ journalctl -k | grep iwlwifi
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: enabling device=
 (0000 -> 0002)
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: Detected crf-id=
 0x2816, cnv-id 0x1000100 wfpm id 0x80000000
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: PCI dev 9df0/00=
30, rev=3D0x312, rfid=3D0x105110
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: Detected Intel(=
R) Wireless-AC 9560 160MHz
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 0
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 1
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 2
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 3
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 4
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 6
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 8
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 9
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 10
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 11
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 15
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 16
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 18
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 19
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 20
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 21
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: WRT: Overriding=
 region id 28
Feb 18 16:07:43 fovo.local kernel: iwlwifi 0000:00:14.3: loaded firmware=
 version 46.7e3e4b69.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
Feb 18 16:07:44 fovo.local kernel: iwlwifi 0000:00:14.3: base HW address=
: c8:e2:65:04:99:cb, OTP minor version: 0x4
Feb 18 16:07:44 fovo.local kernel: iwlwifi 0000:00:14.3 wlp0s20f3: renam=
ed from wlan0
Feb 18 16:07:46 fovo.local kernel: iwlwifi 0000:00:14.3: Registered PHC =
clock: iwlwifi-PTP, with index: 1
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
19, missed_beacons_since_rx:1
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
19, missed_beacons_since_rx:1
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
20, missed_beacons_since_rx:2
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:27 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
20, missed_beacons_since_rx:0
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
21, missed_beacons_since_rx:1
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
21, missed_beacons_since_rx:0
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
22, missed_beacons_since_rx:1
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
22, missed_beacons_since_rx:0
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
23, missed_beacons_since_rx:1
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
23, missed_beacons_since_rx:0
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
24, missed_beacons_since_rx:1
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
24, missed_beacons_since_rx:1
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:28 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
25, missed_beacons_since_rx:2
Feb 18 18:14:29 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:29 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
25, missed_beacons_since_rx:2
Feb 18 18:14:29 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:29 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
26, missed_beacons_since_rx:3
Feb 18 18:14:55 fovo.local kernel: iwlwifi 0000:00:14.3: missed beacons =
exceeds threshold, but receiving data. Stay connected, Expect bugs.
Feb 18 18:14:55 fovo.local kernel: iwlwifi 0000:00:14.3: missed_beacons:=
19, missed_beacons_since_rx:3


lspci -vvnn

00:14.3 Network controller [0280]: Intel Corporation Cannon Point-LP CNV=
i [Wireless-AC] [8086:9df0] (rev 11)
	Subsystem: Intel Corporation Device [8086:0030]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 172
	IOMMU group: 6
	Region 0: Memory at ea238000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00838  Data: 0000
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, IntMs=
gNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
	Capabilities: [80] MSI-X: Enable- Count=3D16 Masked-
		Vector table: BAR=3D0 offset=3D00002000
		PBA: BAR=3D0 offset=3D00003000
	Capabilities: [100 v0] Null
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [164 v1] Vendor Specific Information: ID=3D0010 Rev=3D0 L=
en=3D014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

