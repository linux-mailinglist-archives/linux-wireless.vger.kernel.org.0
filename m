Return-Path: <linux-wireless+bounces-12623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97156970256
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 15:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132301F22620
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EA156227;
	Sat,  7 Sep 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H93KmeZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83720148FFC
	for <linux-wireless@vger.kernel.org>; Sat,  7 Sep 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725715182; cv=none; b=eElhOEJIkExIBY3Tcdg4Jg//hFa2lOu9osEKeA3IVwqjNZsLCxe9vR7KjtCiP5015u4TWxzIe7jUS4wkjc458NFHTZXWfPfRO3UR0+G9xPcN3eBCScMhYLYNheRN4x8WHpDK0pSfXXvj3pRqTLoOqypGjf0YvUGoVwwy7IhWRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725715182; c=relaxed/simple;
	bh=DS697sJmLmTSCt1dNT3KrY/CfZRlu6g9DAMEESd6WG0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y4QwI+RborLFU+uZ6QlMIxB1M141zVX7YasLNzNPob1DXrR6Q62lJlpek9apIrAn6NhNCYWPDSNZ5gCNPoVdN3RTYG2PRleHM7XrQmcjrbL/Re8+oSL9U3WDGJ/ZmcJLU+EDc80sqqiKkTOqC13y+qkIy9IsuvLwb0z+CMW2EPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H93KmeZl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b47ff8a59aso28598537b3.2
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2024 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725715178; x=1726319978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFd+EBMR2XaYhcd6IhtHAuavCPTVJK+4qXFTmt0rg4Q=;
        b=H93KmeZl12/Sct4hGm643DmElUeUdB6wMGM9pOHAWLpr3bI0x5WQ0mwCDS1N0wT6xt
         8b1oj+A0Zku/zVItrdklAqj89RzjBcPMmLCM787MHIfYk3xtn0Vf0YqfOLVD8bzMoNzs
         RqXUo+d2cJphmeBKuRdQvU4XVhKcirTQ5OIuS6N3RgqpvFGO4qy5uRuTOXAaTw0PpCem
         UDzuz8YfpXt758YVL4Guscn1FCCF/AmSB4Q9Cjw4DtcVxwqO8UkiYPDl5kceU/IG0VuR
         fzLD91BXAukkicjU5JNOuI8StPbhm9Gk4cT3X1Ic33OGFmQL9PDontZmm6Alul4v3PTg
         AbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725715178; x=1726319978;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFd+EBMR2XaYhcd6IhtHAuavCPTVJK+4qXFTmt0rg4Q=;
        b=veIsi2Oc7x1jOMy/FGkKA50ZmRCHQukl7dUAPXKIiuE5jEDeJBkY3vuzYTmcL+WllT
         TseuRj+v14w9WId98JvrM1zhxeIWMW6H9aUxPBBLV5bxdHcyEjdbPnQ5Zeu67uPVHYSp
         qE1HKloYHnODywXZgD0DIglfotAAYXXGV3vQn0314tfzw1qfFZLnaz2XahFRl1F4+If3
         umUfhk64bPUOdlGxj1SuYov9xKLzzCrOxxGjXY3cmGNblF+VTS3/ow5pv4OPUIjAqnHc
         eQRENrvE86UoYLkvcGH+v0QPL45fzKI47cx0PHpYDCXo5gkkTCuZ+oi4+dTShFYZLTTa
         x2XA==
X-Gm-Message-State: AOJu0Yy2hZklgDOIQI3f38OOjrymLSPkmtsrRMTOQLYSkla9S9BgDfoV
	0rA0ptQx8cy/ApW7mU59P02/26TPtmCza9sobda+iO8wkicOtMDgCmkiAGIakNz9T9iAto2xjUe
	Zr3O2kAvhXxRJLfb9xxVvBtSI8+L/v2pr7p4=
X-Google-Smtp-Source: AGHT+IFfpxZYXmNnJ7q8YjfUYKmgWmhfeZDMk321ES2nqGya9q5bI30/BQ9wIVrWTvFWbDzcrfepQsOeVbBpQktjfG4=
X-Received: by 2002:a05:690c:2e84:b0:6b1:2a9e:4002 with SMTP id
 00721157ae682-6db61c5de6cmr8098867b3.24.1725715178410; Sat, 07 Sep 2024
 06:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Sat, 7 Sep 2024 14:19:27 +0100
Message-ID: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
Subject: [REGRESSION] iwlwifi resume error, bisected
To: linux-wireless@vger.kernel.org
Cc: emmanuel.grumbach@intel.com, Benjamin Berg <benjamin@sipsolutions.net>, 
	miriam.rachel.korenblit@intel.com, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Kalle Valo <kvalo@kernel.org>, johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"

Commit e8bb19c1d5906d2f31ae61853fea2a9abc71e951 ("wifi: iwlwifi:
support fast resume"), present in v6.11-rc1 up to latest rc6, causes
an error on resume in the case:

1. Connect mains PSU
2. systemctl suspend
3. Unplug PSU
4. Resume by pressing keyboard key

#regzbot introduced: e8bb19c1d5906d2f31ae61853fea2a9abc71e951

The error:

[  103.155788] ------------[ cut here ]------------
[  103.155790] Timeout waiting for hardware access (CSR_GP_CNTRL 0x08040008)
[  103.155817] WARNING: CPU: 15 PID: 796 at
drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2245
__iwl_trans_pcie_grab_nic_access+0x198/0x1a0 [iwlwifi]
[  103.155832] Modules linked in: rfcomm xt_conntrack nft_chain_nat
xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables
nfnetlink br_netfilter bridge stp llc nvme_fabrics ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device overlay qrtr cmac algif_hash
algif_skcipher af_alg bnep binfmt_misc iwlmvm mac80211 snd_acp3x_rn
snd_soc_dmic snd_acp3x_pdm_dma snd_sof_amd_rembrandt
snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp
snd_ctl_led snd_sof snd_hda_codec_realtek libarc4 snd_sof_utils
snd_hda_codec_generic snd_soc_core snd_hda_scodec_component
snd_compress snd_pci_ps snd_hda_codec_hdmi intel_rapl_msr
intel_rapl_common snd_rpl_pci_acp6x snd_acp_pci snd_hda_intel
snd_acp_legacy_common snd_intel_dspcfg uvcvideo snd_hda_codec
snd_pci_acp6x videobuf2_vmalloc kvm_amd btusb videobuf2_memops
snd_pci_acp5x snd_hwdep uvc btrtl videobuf2_v4l2 snd_hda_core btintel
kvm snd_pcm iwlwifi snd_rn_pci_acp3x videodev snd_acp_config btbcm
[  103.155865]  videobuf2_common ucsi_acpi btmtk mc snd_soc_acpi
snd_timer hp_wmi typec_ucsi cfg80211 bluetooth sparse_keymap snd rapl
platform_profile snd_pci_acp3x wmi_bmof ccp typec soundcore pcspkr
sp5100_tco k10temp input_leds joydev serio_raw mac_hid acpi_tad
amd_pmc msr parport_pc ppdev lp parport efi_pstore dmi_sysfs ip_tables
x_tables autofs4 btrfs blake2b_generic libcrc32c xor raid6_pq dm_crypt
uas usb_storage amdgpu i2c_algo_bit drm_ttm_helper ttm drm_exec
drm_suballoc_helper nvme amdxcp hid_multitouch drm_buddy hid_generic
crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic
ghash_clmulni_intel gpu_sched i2c_hid_acpi video amd_sfh i2c_hid
nvme_core drm_display_helper xhci_pci nvme_auth i2c_piix4
xhci_pci_renesas hid wmi aesni_intel crypto_simd cryptd
[  103.155899] CPU: 15 PID: 796 Comm: kworker/u64:14 Tainted: G
W          6.10.0-rc2-00787-g334496c50593 #182
[  103.155900] Hardware name: HP HP Pavilion Aero Laptop
13-be0xxx/8916, BIOS F.12 04/11/2023
[  103.155901] Workqueue: async async_run_entry_fn
[  103.155906] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x198/0x1a0 [iwlwifi]
[  103.155914] Code: c7 31 c0 e9 6f ff ff ff 31 f6 48 89 df e8 f0 fc
ff ff eb e5 44 89 e6 48 c7 c7 40 66 02 c2 c6 05 1a f5 02 00 01 e8 78
ce 91 c6 <0f> 0b eb 93 0f 1f 40 00 0f 1f 44 00 00 55 be 00 02 00 00 48
89 e5
[  103.155915] RSP: 0018:ffffad7704737a38 EFLAGS: 00010246
[  103.155917] RAX: 0000000000000000 RBX: ffff95f38e448028 RCX: 0000000000000000
[  103.155917] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  103.155918] RBP: ffffad7704737a60 R08: 0000000000000000 R09: 0000000000000000
[  103.155919] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000008040008
[  103.155919] R13: 0000000000000000 R14: ffff95f38e449e30 R15: 0000000000000011
[  103.155920] FS:  0000000000000000(0000) GS:ffff95f68e980000(0000)
knlGS:0000000000000000
[  103.155921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  103.155921] CR2: 00007672f0000020 CR3: 0000000197456000 CR4: 0000000000f50ef0
[  103.155923] PKRU: 55555554
[  103.155923] Call Trace:
[  103.155924]  <TASK>
[  103.155926]  ? show_regs+0x68/0x80
[  103.155929]  ? __warn+0x8e/0x1b0
[  103.155932]  ? __iwl_trans_pcie_grab_nic_access+0x198/0x1a0 [iwlwifi]
[  103.155941]  ? report_bug+0x17e/0x1b0
[  103.155944]  ? handle_bug+0x46/0x80
[  103.155946]  ? exc_invalid_op+0x18/0x80
[  103.155947]  ? asm_exc_invalid_op+0x1b/0x20
[  103.155952]  ? __iwl_trans_pcie_grab_nic_access+0x198/0x1a0 [iwlwifi]
[  103.155959]  ? __iwl_trans_pcie_grab_nic_access+0x198/0x1a0 [iwlwifi]
[  103.155967]  ? iwl_trans_pcie_grab_nic_access+0x1b/0x50 [iwlwifi]
[  103.155975]  iwl_trans_pcie_grab_nic_access+0x2b/0x50 [iwlwifi]
[  103.155982]  _iwl_trans_grab_nic_access+0xe/0x20 [iwlwifi]
[  103.155991]  iwl_trans_pcie_read_mem+0x47/0x150 [iwlwifi]
[  103.156000]  iwl_trans_read_mem+0xe/0x20 [iwlwifi]
[  103.156009]  iwl_mvm_check_rt_status+0xcd/0x140 [iwlmvm]
[  103.156022]  ? lock_acquire+0x296/0x300
[  103.156025]  iwl_mvm_fast_resume+0xa3/0x181 [iwlmvm]
[  103.156033]  __iwl_mvm_mac_start+0xfe/0x2d0 [iwlmvm]
[  103.156044]  iwl_mvm_mac_start+0x59/0xf0 [iwlmvm]
[  103.156052]  drv_start+0x85/0x170 [mac80211]
[  103.156077]  ieee80211_reconfig+0xe1/0x1ea0 [mac80211]
[  103.156103]  ? trace_contention_end+0x7a/0xb0
[  103.156105]  ? __mutex_lock+0x123/0x8a0
[  103.156107]  ? lock_release+0x1f0/0x2b0
[  103.156108]  ? rtnl_lock+0x17/0x20
[  103.156112]  ? wiphy_resume+0x62/0x1e0 [cfg80211]
[  103.156134]  ieee80211_resume+0x55/0x70 [mac80211]
[  103.156156]  wiphy_resume+0xbc/0x1e0 [cfg80211]
[  103.156175]  ? wiphy_suspend+0x170/0x170 [cfg80211]
[  103.156192]  dpm_run_callback+0x5b/0x110
[  103.156195]  device_resume+0xc7/0x2d0
[  103.156197]  async_resume+0x1d/0x40
[  103.156198]  async_run_entry_fn+0x2d/0x120
[  103.156199]  process_one_work+0x21b/0x750
[  103.156202]  worker_thread+0x193/0x370
[  103.156204]  ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
[  103.156205]  kthread+0xf3/0x120
[  103.156206]  ? kthread_insert_work_sanity_check+0x60/0x60
[  103.156208]  ret_from_fork+0x40/0x70
[  103.156210]  ? kthread_insert_work_sanity_check+0x60/0x60
[  103.156212]  ret_from_fork_asm+0x11/0x20
[  103.156216]  </TASK>
[  103.156216] irq event stamp: 0
[  103.156217] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  103.156218] hardirqs last disabled at (0): [<ffffffff888dd624>]
copy_process+0xa64/0x2d10
[  103.156220] softirqs last  enabled at (0): [<ffffffff888dd624>]
copy_process+0xa64/0x2d10
[  103.156221] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  103.156222] ---[ end trace 0000000000000000 ]---
[  103.156224] iwlwifi 0000:01:00.0: iwlwifi transaction failed,
dumping registers
[  103.156225] iwlwifi 0000:01:00.0: iwlwifi device config registers:
[  103.156574] iwlwifi 0000:01:00.0: 00000000: 27258086 00100406
0280001a 00000010 fcf00004 00000000 00000000 00000000
[  103.156575] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000
00000000 00248086 00000000 000000c8 00000000 000001ff
[  103.156576] iwlwifi 0000:01:00.0: 00000040: 00028010 10008ec0
00100c1f 0545e812 10120142 00000000 00000000 00000000
[  103.156577] iwlwifi 0000:01:00.0: 00000060: 00000000 00080812
00000405 00000006 00000002 00000000 00000000 00000000
[  103.156578] iwlwifi 0000:01:00.0: 00000080: 800f0011 00002000
00003000 00000000 00000000 00000000 00000000 00000000
[  103.156579] iwlwifi 0000:01:00.0: 000000a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156579] iwlwifi 0000:01:00.0: 000000c0: 00000000 00000000
c823d001 0d000008 00804005 00000000 00000000 00000000
[  103.156580] iwlwifi 0000:01:00.0: 000000e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156581] iwlwifi 0000:01:00.0: 00000100: 14c10001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[  103.156582] iwlwifi 0000:01:00.0: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156583] iwlwifi 0000:01:00.0: 00000140: 14c00000 ff000000
000000ff 15410018 10011001 0001001e 00481e1f 40b6000f
[  103.156583] iwlwifi 0000:01:00.0: iwlwifi device memory mapped registers:
[  103.156825] iwlwifi 0000:01:00.0: 00000000: 40880000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156826] iwlwifi 0000:01:00.0: 00000020: 00000011 08040008
00000420 d55555d5 d55555d5 d55555d5 80008040 041f0042
[  103.156886] iwlwifi 0000:01:00.0: iwlwifi device AER capability structure:
[  103.156898] iwlwifi 0000:01:00.0: 00000000: 14c10001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[  103.156898] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
[  103.156899] iwlwifi 0000:01:00.0: iwlwifi parent port
(0000:00:02.2) config registers:
[  103.156988] iwlwifi 0000:00:02.2: 00000000: 16341022 00100407
06040000 00810010 00000000 00000000 00010100 000001f1
[  103.156989] iwlwifi 0000:00:02.2: 00000020: fcf0fcf0 0001fff1
00000000 00000000 00000000 00000050 00000000 001200ff
[  103.156990] iwlwifi 0000:00:02.2: 00000040: 00000000 00000000
00000000 00000000 c8035801 00000000 0142a010 00008022
[  103.156991] iwlwifi 0000:00:02.2: 00000060: 00002910 05737813
30120042 00042580 01400000 00010018 00000000 007019bf
[  103.156991] iwlwifi 0000:00:02.2: 00000080: 00000406 0000000e
00010002 00000000 00000000 00000000 00000000 00000000
[  103.156992] iwlwifi 0000:00:02.2: 000000a0: 0081c005 fee00000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156993] iwlwifi 0000:00:02.2: 000000c0: 0000c80d 14531022
a8030008 00000000 00000000 00000000 00000000 00000000
[  103.156994] iwlwifi 0000:00:02.2: 000000e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156995] iwlwifi 0000:00:02.2: 00000100: 2701000b 01010001
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156995] iwlwifi 0000:00:02.2: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156996] iwlwifi 0000:00:02.2: 00000140: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156997] iwlwifi 0000:00:02.2: 00000160: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156998] iwlwifi 0000:00:02.2: 00000180: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156998] iwlwifi 0000:00:02.2: 000001a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.156999] iwlwifi 0000:00:02.2: 000001c0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.157000] iwlwifi 0000:00:02.2: 000001e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  103.157000] iwlwifi 0000:00:02.2: 00000200: 00000000 00000000 00000000
[  103.511993] iwlwifi 0000:01:00.0: Device was reset during suspend
[  103.511996] iwlwifi 0000:01:00.0: Couldn't get the d3 notif -2
[  103.512122] iwlwifi 0000:01:00.0: Hardware error detected. Restarting.
[  103.512330] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  103.512331] iwlwifi 0000:01:00.0: Transport status: 0x0000004B,
valid: -469788063
[  103.512333] iwlwifi 0000:01:00.0: Loaded firmware version:
89.202a2f7b.0 ty-a0-gf-a0-89.ucode
[  103.512334] iwlwifi 0000:01:00.0: 0xD7DF3FDA | ADVANCED_SYSASSERT
[  103.512336] iwlwifi 0000:01:00.0: 0xBBDDEF0F | trm_hw_status0
[  103.512337] iwlwifi 0000:01:00.0: 0x527BE62B | trm_hw_status1
[  103.512337] iwlwifi 0000:01:00.0: 0xBE17FF9A | branchlink2
[  103.512338] iwlwifi 0000:01:00.0: 0x7F361FDB | interruptlink1
[  103.512339] iwlwifi 0000:01:00.0: 0x5BD21D9E | interruptlink2
[  103.512340] iwlwifi 0000:01:00.0: 0x172F3A9C | data1
[  103.512340] iwlwifi 0000:01:00.0: 0x9BF71483 | data2
[  103.512341] iwlwifi 0000:01:00.0: 0xCB6FF43C | data3
[  103.512342] iwlwifi 0000:01:00.0: 0xF8CC0AC9 | beacon time
[  103.512342] iwlwifi 0000:01:00.0: 0x531E6DE5 | tsf low
[  103.512343] iwlwifi 0000:01:00.0: 0x54BF38FC | tsf hi
[  103.512344] iwlwifi 0000:01:00.0: 0xFFFF9FED | time gp1
[  103.512344] iwlwifi 0000:01:00.0: 0xED3B101D | time gp2
[  103.512345] iwlwifi 0000:01:00.0: 0xF148E1EB | uCode revision type
[  103.512346] iwlwifi 0000:01:00.0: 0xDCFBF5F3 | uCode version major
[  103.512346] iwlwifi 0000:01:00.0: 0xFC37E970 | uCode version minor
[  103.512347] iwlwifi 0000:01:00.0: 0xC3C17AEF | hw version
[  103.512348] iwlwifi 0000:01:00.0: 0xEE03C593 | board version
[  103.512348] iwlwifi 0000:01:00.0: 0xF73FB3E8 | hcmd
[  103.512349] iwlwifi 0000:01:00.0: 0x9FCD276E | isr0
[  103.512350] iwlwifi 0000:01:00.0: 0x0F7CDEDF | isr1
[  103.512350] iwlwifi 0000:01:00.0: 0x3FEDDFD7 | isr2
[  103.512351] iwlwifi 0000:01:00.0: 0x33513328 | isr3
[  103.512352] iwlwifi 0000:01:00.0: 0x3845B101 | isr4
[  103.512352] iwlwifi 0000:01:00.0: 0x242204CF | last cmd Id
[  103.512353] iwlwifi 0000:01:00.0: 0x71536B63 | wait_event
[  103.512354] iwlwifi 0000:01:00.0: 0xD0210484 | l2p_control
[  103.512354] iwlwifi 0000:01:00.0: 0x82002669 | l2p_duration
[  103.512355] iwlwifi 0000:01:00.0: 0xD0A43120 | l2p_mhvalid
[  103.512356] iwlwifi 0000:01:00.0: 0xA981A920 | l2p_addr_match
[  103.512356] iwlwifi 0000:01:00.0: 0x8948A153 | lmpm_pmg_sel
[  103.512357] iwlwifi 0000:01:00.0: 0x02978048 | timestamp
[  103.512358] iwlwifi 0000:01:00.0: 0x06D922EA | flow_handler
[  103.512664] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  103.512665] iwlwifi 0000:01:00.0: Transport status: 0x0000004B,
valid: 49788171
[  103.512666] iwlwifi 0000:01:00.0: 0xF54DFA0C | ADVANCED_SYSASSERT
[  103.512667] iwlwifi 0000:01:00.0: 0xCFEDC773 | umac branchlink1
[  103.512668] iwlwifi 0000:01:00.0: 0x5E6AEA8F | umac branchlink2
[  103.512668] iwlwifi 0000:01:00.0: 0xFB5DEE2F | umac interruptlink1
[  103.512669] iwlwifi 0000:01:00.0: 0xF61CE077 | umac interruptlink2
[  103.512670] iwlwifi 0000:01:00.0: 0x5EFF636D | umac data1
[  103.512670] iwlwifi 0000:01:00.0: 0xD97E7FDC | umac data2
[  103.512671] iwlwifi 0000:01:00.0: 0x2D930F84 | umac data3
[  103.512672] iwlwifi 0000:01:00.0: 0x60937F7F | umac major
[  103.512672] iwlwifi 0000:01:00.0: 0xE99FBED6 | umac minor
[  103.512673] iwlwifi 0000:01:00.0: 0xDB5EEB76 | frame pointer
[  103.512674] iwlwifi 0000:01:00.0: 0xC31D7E35 | stack pointer
[  103.512674] iwlwifi 0000:01:00.0: 0x2EE7C3C7 | last host cmd
[  103.512675] iwlwifi 0000:01:00.0: 0xFDCBEBFB | isr status reg
[  103.512953] iwlwifi 0000:01:00.0: IML/ROM dump:
[  103.512953] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM error/state
[  103.513010] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM data1
[  103.513067] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[  103.513121] iwlwifi 0000:01:00.0: Fseq Registers:
[  103.513124] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[  103.513127] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[  103.513129] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[  103.513132] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[  103.513135] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[  103.513138] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  103.513140] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[  103.513143] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[  103.513146] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[  103.513151] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[  103.513155] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  103.513160] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  103.513163] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERSION
[  103.513166] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[  103.513169] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[  103.513171] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[  103.513228] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc00c0000
[  103.513231] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0x0
[  103.513250] iwlwifi 0000:01:00.0: FW error in SYNC CMD DBGC_SUSPEND_RESUME
[  103.513253] CPU: 4 PID: 796 Comm: kworker/u64:14 Tainted: G
W          6.10.0-rc2-00787-g334496c50593 #182
[  103.513255] Hardware name: HP HP Pavilion Aero Laptop
13-be0xxx/8916, BIOS F.12 04/11/2023
[  103.513256] Workqueue: async async_run_entry_fn
[  103.513258] Call Trace:
[  103.513259]  <TASK>
[  103.513260]  dump_stack_lvl+0xb9/0xe0
[  103.513262]  dump_stack+0x10/0x20
[  103.513264]  iwl_trans_pcie_send_hcmd+0x36e/0x470 [iwlwifi]
[  103.513279]  ? destroy_sched_domains_rcu+0x30/0x30
[  103.513283]  iwl_trans_send_cmd+0x89/0x170 [iwlwifi]
[  103.513296]  iwl_fw_dbg_stop_restart_recording+0x21d/0x2a0 [iwlwifi]
[  103.513308]  iwl_fw_dbg_stop_sync+0x3a/0x50 [iwlwifi]
[  103.513319]  iwl_mvm_stop_device+0x46/0xa0 [iwlmvm]
[  103.513334]  __iwl_mvm_mac_start+0x2b4/0x2d0 [iwlmvm]
[  103.513346]  iwl_mvm_mac_start+0x59/0xf0 [iwlmvm]
[  103.513357]  drv_start+0x85/0x170 [mac80211]
[  103.513387]  ieee80211_reconfig+0xe1/0x1ea0 [mac80211]
[  103.513421]  ? trace_contention_end+0x7a/0xb0
[  103.513423]  ? __mutex_lock+0x123/0x8a0
[  103.513424]  ? lock_release+0x1f0/0x2b0
[  103.513426]  ? rtnl_lock+0x17/0x20
[  103.513427]  ? wiphy_resume+0x62/0x1e0 [cfg80211]
[  103.513454]  ieee80211_resume+0x55/0x70 [mac80211]
[  103.513485]  wiphy_resume+0xbc/0x1e0 [cfg80211]
[  103.513510]  ? wiphy_suspend+0x170/0x170 [cfg80211]
[  103.513535]  dpm_run_callback+0x5b/0x110
[  103.513537]  device_resume+0xc7/0x2d0
[  103.513539]  async_resume+0x1d/0x40
[  103.513540]  async_run_entry_fn+0x2d/0x120
[  103.513541]  process_one_work+0x21b/0x750
[  103.513544]  worker_thread+0x193/0x370
[  103.513546]  ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
[  103.513548]  kthread+0xf3/0x120
[  103.513549]  ? kthread_insert_work_sanity_check+0x60/0x60
[  103.513551]  ret_from_fork+0x40/0x70
[  103.513553]  ? kthread_insert_work_sanity_check+0x60/0x60
[  103.513554]  ret_from_fork_asm+0x11/0x20
[  103.513558]  </TASK>

