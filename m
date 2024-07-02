Return-Path: <linux-wireless+bounces-9818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F50923BC0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6021C23DE9
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36669158DC4;
	Tue,  2 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="XZZV3zqu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BC129E66
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917250; cv=none; b=N+kcUWE5UL5IENS3NNGzlJiFh9oNdmu9wlBMnWP0CRMKVXb//qX6uYJhJxCk2LRWUOy0Ycv1N3Gr8AiPwn/r3rvzPyJ6aA8/A3YZt/YRyw9cNJaFBCL93v7pHVpNj9+vVhCVCrKXDblD+xJV1N1GnhrX0Xuge4UYAa28n2ZKR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917250; c=relaxed/simple;
	bh=lM4uQPLD/J7y6ahZZlliEK1SYaUpk8RBAFD0iWLh9tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epataQFO/TJp95ar5OSxtCeoXk7L4wn6qcJnQSbWWb49QEFl6YWQf5ssUWYvKH/iV46tHnuRFHi/itUPo/uh1a7A70dTS2lmd6uUBdSboK2QD1EnHFzrEsgqMRCOqiQKudO+h69uPAp7Bazna6H5GQZwTa9P1SkgnsQPOnZ8OKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=XZZV3zqu; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1719916892;
	bh=lM4uQPLD/J7y6ahZZlliEK1SYaUpk8RBAFD0iWLh9tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZZV3zqutIMmwMdTiAdsq/37tEcVr568rAzViheFuk5od1UqvlCwhMblwzcJ3a7mb
	 XCsDfondeUVs5MfF0tJMs8cvRw2K93SeFRTkNuKwStGzgoweZDuWL2I5IEIJHTY7Ak
	 5phC6oNQTf8zUcwNZSlkHEpORiquapHlFwxGWXwI=
To: miriam.rachel.korenblit@intel.com
Cc: ilan.peer@intel.com,
	johannes.berg@intel.com,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [REGRESSION] wiphy_register fails for mvm (AX211)
Date: Tue,  2 Jul 2024 12:41:28 +0200
Message-ID: <20240702104128.26394-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618200104.3213638262ef.I2a0031b37623d7763fd0c5405477ea7206a3e923@changeid>
References: <20240618200104.3213638262ef.I2a0031b37623d7763fd0c5405477ea7206a3e923@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The commit 5c38bedac16a ("wifi: iwlwifi: mvm: unify and fix interface
combinations") breaks mvm hard. wlan interface can't be created and even
rmmod fails.

On driver load I get:

WARNING: CPU: 5 PID: 1358 at net/wireless/core.c:689 wiphy_register+0x8ee/0=
x920 [cfg80211]
Modules linked in: snd_ctl_led snd_soc_skl_hda_dsp(+) snd_soc_hdac_hdmi snd=
_soc_intel_hda_dsp_common snd_sof_probes snd_hda_codec_realtek snd_hda_code=
c_generic snd_hda_scodec_compon ent snd_soc_dmic snd_sof_pci_intel_tgl snd_=
sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_caden=
ce snd_sof_intel_hda_common snd_sof_intel_hda_mlink snd_sof_intel_hda snd_s=
of_pci snd_sof_x tensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_a=
cpi_intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus snd=
_soc_avs snd_soc_hda_codec snd_hda_ext_core intel_uncore_frequency intel_un=
c ore_frequency_common intel_tcc_cooling snd_soc_core x86_pkg_temp_thermal =
intel_powerclamp coretemp snd_compress snd_hda_codec_hdmi ac97_bus iwlmvm(+=
) snd_pcm_dmaengine kvm_intel snd_hda_intel vfat kvm mac80211 snd_intel_dsp=
cfg fat snd_intel_sdw_acpi snd_hda_codec iTCO_wdt nouveau(+) intel_pmc_bxt =
libarc4 rapl processor_thermal_device_pci intel_rapl_msr mei_wdt iTCO_vendo=
r_support snd_hda_core processor_thermal_devi ce Jul 01 16:15:41 Ohm kernel=
:  snd_hwdep processor_thermal_wt_hint iwlwifi intel_cstate processor_therm=
al_rfim snd_pcm drm_ttm_helper processor_thermal_rapl gpu_sched intel_rapl_=
common nxp_nci_i2c snd_timer thin k_lmi(+) intel_uncore pcspkr firmware_att=
ributes_class wmi_bmof nxp_nci snd mei_me processor_thermal_wt_req nci drm_=
gpuvm cfg80211 i2c_i801 soundcore mei drm_exec processor_thermal_power_floo=
r idma64 i2c_smbus mxm_wmi processor_thermal_mbox nfc intel_pmc_core rfkill=
 int3403_thermal intel_vsec int340x_thermal_zone int3400_thermal pmt_teleme=
try intel_hid acpi_thermal_rel pmt_class acpi_tad acpi_pad sparse_keymap jo=
yd ev loop fuse nfnetlink mmc_block nvme nvme_core crct10dif_pclmul crc32_p=
clmul crc32c_intel rtsx_pci_sdmmc polyval_clmulni polyval_generic ghash_clm=
ulni_intel sha512_ssse3 mmc_core sha256_ssse3 hid_multitouch u csi_acpi sha=
1_ssse3 typec_ucsi thunderbolt rtsx_pci vmd typec i2c_hid_acpi i2c_hid pinc=
trl_alderlake serio_raw
CPU: 5 PID: 1358 Comm: modprobe Not tainted 6.10.0-rc5-wt+ #17
Hardware name: LENOVO 21D6CTO1WW/21D6CTO1WW, BIOS N3FET34W (1.19 ) 03/10/20=
23
RIP: 0010:wiphy_register+0x8ee/0x920 [cfg80211]
Code: ef f8 ff ff 0f 0b e9 e8 f8 ff ff 0f 0b e9 e1 f8 ff ff 0f 0b e9 da f8 =
ff ff bf 01 00 00 00 e9 a4 fc ff ff 0f 0b e9 c9 f8 ff ff <0f> 0b e9 c2 f8 f=
f ff 0f 0b e9 f1 fe ff ff f7 d1 e9 d4 fe ff ff 0f
RSP: 0018:ffffc9000167f7d0 EFLAGS: 00010297
skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PC=
M in topology for HDMI converter 3
RAX: 0000000000000300 RBX: ffff888121b983c0 RCX: 0000000000000300
RDX: ffffffffc11f2b28 RSI: ffffffffc11f2ae0 RDI: 0000000000000000
RBP: ffffc9000167f840 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000003 R11: ffffffffc11f2b10 R12: ffffffffc11f2b28
R13: 0000000000000001 R14: 0000000000000005 R15: 000000000000000c
FS:  00007f9b91560080(0000) GS:ffff88902ee80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbe4015608 CR3: 00000001454da000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? wiphy_register+0x8ee/0x920 [cfg80211]
 ? __warn.cold+0x8e/0xe8
 ? wiphy_register+0x8ee/0x920 [cfg80211]
 ? report_bug+0xfb/0x140
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x13/0x60
 ? asm_exc_invalid_op+0x16/0x20
 ? wiphy_register+0x8ee/0x920 [cfg80211]
 ? netdev_run_todo+0x60/0x4f0
 ? kvmalloc_node_noprof+0x36/0xc0
 ieee80211_register_hw+0x832/0xd60 [mac80211]
 iwl_mvm_mac_setup_register+0xb62/0xd50 [iwlmvm]
 iwl_mvm_start_post_nvm+0x5f/0xe0 [iwlmvm]
 iwl_op_mode_mvm_start+0x86a/0x990 [iwlmvm]
 _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
 iwl_opmode_register+0x6d/0xe0 [iwlwifi]
 ? __pfx_iwl_mvm_init+0x10/0x10 [iwlmvm]
 iwl_mvm_init+0x34/0xff0 [iwlmvm]
 ? __pfx_iwl_mvm_init+0x10/0x10 [iwlmvm]
 do_one_initcall+0x54/0x2e0
 do_init_module+0x82/0x230
 init_module_from_file+0x86/0xc0
 idempotent_init_module+0x121/0x2b0
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x7e/0x190
 ? vfs_read+0x152/0x370
 ? __rseq_handle_notify_resume+0xa2/0x480
 ? sysvec_call_function+0xa/0x90
 ? asm_sysvec_call_function+0x16/0x20
 ? __pfx_generic_file_llseek+0x10/0x10
 ? syscall_exit_to_user_mode+0x76/0x210
 ? do_syscall_64+0x8a/0x190
 ? __pfx_page_put_link+0x10/0x10
 ? do_sys_openat2+0x9c/0xe0
 ? syscall_exit_to_user_mode+0x76/0x210
 ? do_syscall_64+0x8a/0x190
 ? do_syscall_64+0x8a/0x190
 ? exc_page_fault+0x7a/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9b9167275d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 9b 16 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffff874b378 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b8e84a7ee0 RCX: 00007f9b9167275d
RDX: 0000000000000000 RSI: 000055b8d1da19ca RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000070 R09: 000055b8e84aa7e0
R10: 00007f9b91744b20 R11: 0000000000000246 R12: 000055b8d1da19ca
R13: 0000000000040000 R14: 000055b8e84a7ff0 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---

After bisecting the issue and reverting the identified commit service is re=
stored.



