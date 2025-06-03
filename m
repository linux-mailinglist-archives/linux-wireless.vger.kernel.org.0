Return-Path: <linux-wireless+bounces-23575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419FACCC56
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A293A17B5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9521C54AF;
	Tue,  3 Jun 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="MmNL1mfx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JDOzg0Cg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from b224-17.smtp-out.eu-central-1.amazonses.com (b224-17.smtp-out.eu-central-1.amazonses.com [69.169.224.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A91361;
	Tue,  3 Jun 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972583; cv=none; b=NyyrBW+56lOISfKXQS4JwtPtRxpFlI6k7eZLtxNVRZJFmocv2lF/LmGpHDzgOKOOHg09xL2+zgpuGeEC4Vjl1P+RwaISH0fJgh+rtN4IPv3BG5y/YYCTwuDhR7VzzZrH8jNsjYgFs/vBt5ZjVwtB5hBER8NOU+0KELMDdkc74iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972583; c=relaxed/simple;
	bh=hKGYfvlJxweczRRYlxKKsLZLtXS51ZdVOGBkabKEgCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DP4YFpDVoiQbOJnSoJma0OWBANuamRoZE1LUvqE6Rdj8+0akvi9M67j21sc4gkDl2jo/zVzP/UX4qRzuY3jW874MRG7dHF6cTnUxPvwkMGfdo0xVXQHaQNR9c9oT1aWqM2DLZTMxW1cAMNXnC0E5ZR+pbzY8LevvjPFi6Endmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=MmNL1mfx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JDOzg0Cg; arc=none smtp.client-ip=69.169.224.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2kaovp6zxy5nzp5wqunvdq5vkiqbeqln; d=riscv-rocks.de; t=1748972578;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hKGYfvlJxweczRRYlxKKsLZLtXS51ZdVOGBkabKEgCM=;
	b=MmNL1mfxlO/BQy8PH4lxAHXo+dEE+gpedV8xgENjh8q6aZhDPA7hX6EahW7+nA22
	rG7djHsXatiuc2Ky8GH5KjPp23tl1idodklC+y/a3duejDMkwp4ORztA3X7Hfr5PJ3M
	xruSPqrEdKwig/ntrTwhXZ83yKJ1BhIFlRWnwehxNZU11RRCiaXrZuuvY9CjlzfSDkm
	cjoUeE3l8itRVdKulVGzjRZOZHY+gh3kYeHcDn7QKUpi9XM9sDaJj+ipi1UsAOcxaVZ
	CmkjW34ityPMeV6c8/xIAlctRwGlMVqSi6Rt3+XD7+p5/MELpaaypY7Dglg5avHDe6G
	aH3jxLnI6g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1748972578;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=hKGYfvlJxweczRRYlxKKsLZLtXS51ZdVOGBkabKEgCM=;
	b=JDOzg0Cg+9zQea6+I7owsUeRwAd41/jcnqOI+7gCBgSMbXiZGDM22XOjPaHnZ7xG
	bXBQ2+vmsYdqTwrC0TS7UDgu2p7ACOBVPPl8AEwA+2CuQt6ib8mAwWfU/knJkNLKpqi
	RDOy/PlNPPU0PEnFE5Cjh7q7l4inPGFHMdh5ChOA=
Date: Tue, 3 Jun 2025 17:42:58 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Message-ID: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt
X-Operating-System: Linux Fedora release 42 (Adams) (Kernel
 6.14.9-300.fc42.x86_64)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.06.03-69.169.224.17

Hello together,
in the current build tree from linus i get the followinng warning:=20
On kernel 6.15.0+  (PREEMPT, tainted: G U W), I repeatedly get the followin=
g warning in iwl_mvm_sta_rx_agg():

WARNING: CPU: 4 PID: 4724 at drivers/net/wireless/intel/iwlwifi/mvm/sta.c:2=
990 iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]a
Reproducibility:
Happens intermittently during normal WiFi use (triggers after suspend).

[   87.639112] ------------[ cut here ]------------
[   87.639114] WARNING: CPU: 4 PID: 4724 at drivers/net/wireless/intel/iwlw=
ifi/mvm/sta.c:2990 iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
[   87.639151] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer n=
f_conntrack_netlink veth xt_conntrack xt_MASQUERADE bridge stp llc xt_set x=
t_addrtype nls_utf8 cifs cifs_arc4 nls_ucs2_utils cifs_md4 dns_resolver net=
fs overlay xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broad=
cast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje=
ct_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc qrtr snd_soc_skl_hda_=
dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_co=
mmon snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component b=
infmt_misc snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof=
_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt vfat snd_sof_i=
ntel_hda_common fat snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_=
hda snd_hda_codec_hdmi soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd=
_sof snd_sof_utils snd_soc_acpi_intel_match
[   87.639208]  snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation=
 snd_soc_acpi crc8 soundwire_bus snd_soc_sdca snd_soc_avs snd_soc_hda_codec=
 snd_hda_ext_core snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_=
hda_intel iwlmvm snd_intel_dspcfg snd_intel_sdw_acpi uvcvideo snd_hda_codec=
 intel_uncore_frequency uvc intel_uncore_frequency_common videobuf2_vmalloc=
 intel_tcc_cooling videobuf2_memops x86_pkg_temp_thermal snd_hda_core video=
buf2_v4l2 intel_powerclamp snd_hwdep mac80211 videobuf2_common coretemp rap=
l snd_seq iTCO_wdt snd_seq_device intel_pmc_bxt videodev processor_thermal_=
device_pci_legacy think_lmi iTCO_vendor_support spi_nor processor_thermal_d=
evice intel_cstate mtd mei_pxp mei_hdcp intel_rapl_msr libarc4 intel_uncore=
 pcspkr mc firmware_attributes_class processor_thermal_wt_hint snd_pcm wmi_=
bmof iwlwifi platform_temperature_control processor_thermal_rfim i2c_i801 p=
rocessor_thermal_rapl spi_intel_pci snd_ctl_led spi_intel cfg80211 intel_ra=
pl_common snd_timer i2c_smbus mei_me thunderbolt mei
[   87.639266]  thinkpad_acpi idma64 processor_thermal_wt_req processor_the=
rmal_power_floor processor_thermal_mbox igen6_edac intel_soc_dts_iosf platf=
orm_profile snd int3403_thermal soundcore int340x_thermal_zone soc_button_a=
rray intel_pmc_core intel_hid pmt_telemetry sparse_keymap int3400_thermal a=
cpi_thermal_rel pmt_class intel_pmc_ssram_telemetry acpi_pad acpi_tad joyde=
v loop nfnetlink zram lz4hc_compress lz4_compress xe drm_ttm_helper drm_sub=
alloc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btint=
el btbcm btmtk bluetooth rfkill i915 i2c_algo_bit hid_multitouch drm_buddy =
nvme ttm nvme_core drm_display_helper polyval_clmulni ghash_clmulni_intel v=
ideo sha512_ssse3 nvme_keyring sha1_ssse3 nvme_auth cec intel_vsec i2c_hid_=
acpi i2c_hid ucsi_acpi typec_ucsi typec wmi pinctrl_tigerlake serio_raw fuse
[   87.639324] CPU: 4 UID: 0 PID: 4724 Comm: kworker/u32:20 Tainted: G     =
U  W           6.15.0 #422 PREEMPT(lazy)=20
[   87.639328] Tainted: [U]=3DUSER, [W]=3DWARN
[   87.639330] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   87.639331] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[   87.639391] RIP: 0010:iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
[   87.639424] Code: e9 f3 fc ff ff 79 c4 31 db e9 54 fa ff ff 0f 89 e0 fc =
ff ff e9 49 fa ff ff 0f 0b 41 b9 ea ff ff ff e9 f6 f9 ff ff 0f 0b eb f1 <0f=
> 0b e9 e9 fe ff ff 48 8b 3f 48 c7 c6 34 96 dd c1 e8 f7 0e a1 ff
[   87.639426] RSP: 0018:ffffcb03e11dfb80 EFLAGS: 00010286
[   87.639429] RAX: ffff896a05ce0000 RBX: ffff896c6b2c0000 RCX: ffffffffc1d=
c5940
[   87.639431] RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff896a028=
020c8
[   87.639432] RBP: ffffcb03e11dfc40 R08: ffffffffc1dd0210 R09: 00000000000=
00000
[   87.639434] R10: 0000000000000005 R11: ffffcb03e11dfb30 R12: ffff896a0c9=
daa90
[   87.639436] R13: ffff896a0b89a008 R14: 0000000000000009 R15: 00000000000=
00000
[   87.639438] FS:  0000000000000000(0000) GS:ffff896daf6af000(0000) knlGS:=
0000000000000000
[   87.639440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.639441] CR2: 00007f8e0980b460 CR3: 0000000129aa8006 CR4: 0000000000f=
70ef0
[   87.639443] PKRU: 55555554
[   87.639445] Call Trace:
[   87.639446]  <TASK>
[   87.639450]  ? iwl_mvm_mac_ampdu_action+0xf9/0x270 [iwlmvm]
[   87.639477]  iwl_mvm_mac_ampdu_action+0xf9/0x270 [iwlmvm]
[   87.639504]  drv_ampdu_action+0xdc/0x1a0 [mac80211]
[   87.639605]  __ieee80211_start_rx_ba_session+0x4c6/0x760 [mac80211]
[   87.639719]  ieee80211_process_addba_request+0x9b/0xd0 [mac80211]
[   87.639804]  ieee80211_iface_work+0x6f/0x1b0 [mac80211]
[   87.639882]  cfg80211_wiphy_work+0x11e/0x190 [cfg80211]
[   87.639944]  process_one_work+0x18f/0x350
[   87.639950]  worker_thread+0x25a/0x3a0
[   87.639954]  ? __pfx_worker_thread+0x10/0x10
[   87.639958]  kthread+0xfc/0x240
[   87.639961]  ? __pfx_kthread+0x10/0x10
[   87.639964]  ? __pfx_kthread+0x10/0x10
[   87.639967]  ret_from_fork+0x14f/0x180
[   87.639971]  ? __pfx_kthread+0x10/0x10
[   87.639973]  ret_from_fork_asm+0x1a/0x30
[   87.639979]  </TASK>
[   87.639980] ---[ end trace 0000000000000000 ]---
[   87.640455] ------------[ cut here ]------------
[   87.640456] WARNING: CPU: 4 PID: 4724 at drivers/net/wireless/intel/iwlw=
ifi/mvm/sta.c:2990 iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
[   87.640495] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer n=
f_conntrack_netlink veth xt_conntrack xt_MASQUERADE bridge stp llc xt_set x=
t_addrtype nls_utf8 cifs cifs_arc4 nls_ucs2_utils cifs_md4 dns_resolver net=
fs overlay xt_comment nft_compat nf_conntrack_netbios_ns nf_conntrack_broad=
cast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje=
ct_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc qrtr snd_soc_skl_hda_=
dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_co=
mmon snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component b=
infmt_misc snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof=
_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt vfat snd_sof_i=
ntel_hda_common fat snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_=
hda snd_hda_codec_hdmi soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd=
_sof snd_sof_utils snd_soc_acpi_intel_match
[   87.640552]  snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation=
 snd_soc_acpi crc8 soundwire_bus snd_soc_sdca snd_soc_avs snd_soc_hda_codec=
 snd_hda_ext_core snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_=
hda_intel iwlmvm snd_intel_dspcfg snd_intel_sdw_acpi uvcvideo snd_hda_codec=
 intel_uncore_frequency uvc intel_uncore_frequency_common videobuf2_vmalloc=
 intel_tcc_cooling videobuf2_memops x86_pkg_temp_thermal snd_hda_core video=
buf2_v4l2 intel_powerclamp snd_hwdep mac80211 videobuf2_common coretemp rap=
l snd_seq iTCO_wdt snd_seq_device intel_pmc_bxt videodev processor_thermal_=
device_pci_legacy think_lmi iTCO_vendor_support spi_nor processor_thermal_d=
evice intel_cstate mtd mei_pxp mei_hdcp intel_rapl_msr libarc4 intel_uncore=
 pcspkr mc firmware_attributes_class processor_thermal_wt_hint snd_pcm wmi_=
bmof iwlwifi platform_temperature_control processor_thermal_rfim i2c_i801 p=
rocessor_thermal_rapl spi_intel_pci snd_ctl_led spi_intel cfg80211 intel_ra=
pl_common snd_timer i2c_smbus mei_me thunderbolt mei
[   87.640611]  thinkpad_acpi idma64 processor_thermal_wt_req processor_the=
rmal_power_floor processor_thermal_mbox igen6_edac intel_soc_dts_iosf platf=
orm_profile snd int3403_thermal soundcore int340x_thermal_zone soc_button_a=
rray intel_pmc_core intel_hid pmt_telemetry sparse_keymap int3400_thermal a=
cpi_thermal_rel pmt_class intel_pmc_ssram_telemetry acpi_pad acpi_tad joyde=
v loop nfnetlink zram lz4hc_compress lz4_compress xe drm_ttm_helper drm_sub=
alloc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm bnep btusb btrtl btint=
el btbcm btmtk bluetooth rfkill i915 i2c_algo_bit hid_multitouch drm_buddy =
nvme ttm nvme_core drm_display_helper polyval_clmulni ghash_clmulni_intel v=
ideo sha512_ssse3 nvme_keyring sha1_ssse3 nvme_auth cec intel_vsec i2c_hid_=
acpi i2c_hid ucsi_acpi typec_ucsi typec wmi pinctrl_tigerlake serio_raw fuse
[   87.640669] CPU: 4 UID: 0 PID: 4724 Comm: kworker/u32:20 Tainted: G     =
U  W           6.15.0 #422 PREEMPT(lazy)=20
[   87.640674] Tainted: [U]=3DUSER, [W]=3DWARN
[   87.640675] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET96W (=
1.72 ) 03/04/2025
[   87.640677] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[   87.640726] RIP: 0010:iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
[   87.640757] Code: e9 f3 fc ff ff 79 c4 31 db e9 54 fa ff ff 0f 89 e0 fc =
ff ff e9 49 fa ff ff 0f 0b 41 b9 ea ff ff ff e9 f6 f9 ff ff 0f 0b eb f1 <0f=
> 0b e9 e9 fe ff ff 48 8b 3f 48 c7 c6 34 96 dd c1 e8 f7 0e a1 ff
[   87.640760] RSP: 0018:ffffcb03e11dfb80 EFLAGS: 00010286
[   87.640762] RAX: ffff896a052a0000 RBX: ffff896c69260000 RCX: ffffffffc1d=
c5940
[   87.640764] RDX: 0000000000000006 RSI: 0000000000000000 RDI: ffff896a028=
020c8
[   87.640766] RBP: ffffcb03e11dfc40 R08: ffffffffc1dd0210 R09: 00000000000=
00000
[   87.640767] R10: 0000000000000006 R11: ffffcb03e11dfb30 R12: ffff896a0c9=
daa90
[   87.640769] R13: ffff896a0b89a008 R14: 0000000000000009 R15: 00000000000=
00000
[   87.640771] FS:  0000000000000000(0000) GS:ffff896daf6af000(0000) knlGS:=
0000000000000000
[   87.640773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.640775] CR2: 00007f8e0980b460 CR3: 0000000129aa8006 CR4: 0000000000f=
70ef0
[   87.640777] PKRU: 55555554
[   87.640778] Call Trace:
[   87.640780]  <TASK>
[   87.640784]  ? iwl_mvm_mac_ampdu_action+0xf9/0x270 [iwlmvm]
[   87.640820]  iwl_mvm_mac_ampdu_action+0xf9/0x270 [iwlmvm]
[   87.640853]  drv_ampdu_action+0xdc/0x1a0 [mac80211]
[   87.640928]  __ieee80211_start_rx_ba_session+0x4c6/0x760 [mac80211]
[   87.641007]  ieee80211_process_addba_request+0x9b/0xd0 [mac80211]
[   87.641103]  ieee80211_iface_work+0x6f/0x1b0 [mac80211]
[   87.641182]  cfg80211_wiphy_work+0x11e/0x190 [cfg80211]
[   87.641236]  process_one_work+0x18f/0x350
[   87.641242]  worker_thread+0x25a/0x3a0
[   87.641246]  ? __pfx_worker_thread+0x10/0x10
[   87.641250]  kthread+0xfc/0x240
[   87.641253]  ? __pfx_kthread+0x10/0x10
[   87.641256]  ? __pfx_kthread+0x10/0x10
[   87.641259]  ret_from_fork+0x14f/0x180
[   87.641262]  ? __pfx_kthread+0x10/0x10
[   87.641265]  ret_from_fork_asm+0x1a/0x30
[   87.641271]  </TASK>
[   87.641272] ---[ end trace 0000000000000000 ]---

--=20
VG
Damian Tometzki

