Return-Path: <linux-wireless+bounces-5420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6788F4F6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 02:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4404C1F2D384
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE072554B;
	Thu, 28 Mar 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rVV6WBE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460E24A06;
	Thu, 28 Mar 2024 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590925; cv=none; b=mveNO9oCwpNSrRE2ReoTol/zQsntHWm8FeRD/ZS/hyPGrLwiU1438chovZzIM6gnkZzAefQWIGK5x3WLMtYG/KYbXOKPtpifNzojgq3mHMURnCr79h0THHJb/2LJ0TSKUwOx+YnY8Eg6wjKPVRpmwkyid78BLRGaBLVV9/iHwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590925; c=relaxed/simple;
	bh=pmr+WPqtCsQua3sjPpbXW5V6dOiWJsHlhDnfRUVDHos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jB5sEAa4GkrwHCV2lvx2dH9oYdYf45S5JmtV6giOzgdhE/jlXew69KAAtvsy6xLOSFc894+tGO0aT8qZf/mV0LpUbPqCaTnyKb+V+2jtB6CVPY9PyI3ofDnzPkLQfrxOcFjr1gGjontqwMkkbje7IiWJ8vevyoUd6zE0p8Wm5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rVV6WBE+; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [222.129.33.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8456440EAA;
	Thu, 28 Mar 2024 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711590919;
	bh=ZqgB80NWcdUzNzyGD++4sR71ZNFT82CKoSczGCdIvR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=rVV6WBE+LXJe2Q/JU8TsOhVEyATfxDt5uM0jE/IRHOV8p49ua3rjlVnZHFWq7M7pq
	 i0lkp+hzB5y/EpQ4Se49USfNRvn0sJLo9F+X6eEIbtzIPoEWJFIcR7ZjGFXfm39r1o
	 a1htomAfGZ/NW2vkjdAxIKlY9KK9tWHItoYz4iVNk+ppwbNTZSLAgfUP7x4X1GySbu
	 iw6OV6X38ciNlFhg3y0I7erNmj0+aYyKUdv+ajS06h6o0bDXfV4rqBp9I2dYSrjKTo
	 5MPYjznazFF3j7hiB+uXUjSttjltplsOd5lK3BfvJfoQZfSRddKxi5cv+eO3uHoZW4
	 sZdyTRGaB2pFQ==
From: Aaron Ma <aaron.ma@canonical.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregory.greenman@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCHi 6.6 0/1] Cherrypick one more commit to fix iwlwifi crash on BE200
Date: Thu, 28 Mar 2024 09:54:01 +0800
Message-Id: <20240328015402.114435-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Levin,

On Stable 6.6.23 kernel, iwlwifi crashed with the following error:

[  290.279712] ------------[ cut here ]------------
[  290.279726] Invalid rxb from HW 0
[  290.279816] WARNING: CPU: 19 PID: 477 at
drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1489
iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.279885] Modules linked in: snd_ctl_led snd_soc_skl_hda_dsp
snd_soc_intel_hda_dsp_common snd_soc_hdac_hdmi snd_sof_probes
snd_hda_codec_realtek snd_hda_codec_generic rfcomm nvme_fabrics ccm cmac
algif_hash algif_skcipher af_alg bnep uvcvideo videobuf2_vmalloc uvc
videobuf2_memops videobuf2_v4l2 videodev btusb btrtl btintel btbcm btmtk
videobuf2_common bluetooth mc ecdh_generic ecc joydev snd_soc_dmic
intel_uncore_frequency intel_uncore_frequency_common
snd_sof_pci_intel_mtl snd_sof_intel_hda_common x86_pkg_temp_thermal
soundwire_intel intel_powerclamp soundwire_generic_allocation
snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_sof_pci
snd_sof_xtensa_dsp coretemp snd_sof snd_sof_utils snd_soc_hdac_hda
snd_hda_ext_core kvm_intel snd_soc_acpi_intel_match snd_soc_acpi
soundwire_bus kvm snd_soc_core irqbypass snd_compress crct10dif_pclmul
ac97_bus crc32_pclmul snd_pcm_dmaengine polyval_clmulni polyval_generic
ghash_clmulni_intel sha512_ssse3 iwlmvm snd_hda_intel sha256_ssse3
binfmt_misc sha1_ssse3 i915
[  290.279973]  snd_intel_dspcfg drm_buddy aesni_intel
snd_intel_sdw_acpi ttm mac80211 crypto_simd processor_thermal_device_pci
snd_hda_codec drm_display_helper spi_nor hid_multitouch
processor_thermal_device cryptd think_lmi pmt_telemetry hid_generic
libarc4 mtd intel_rapl_msr pmt_class iwlwifi firmware_attributes_class
wmi_bmof snd_hda_core cec processor_thermal_rfim rapl snd_hwdep psmouse
thinkpad_acpi input_leds rc_core mei_me snd_seq_midi ucsi_acpi
processor_thermal_mbox intel_cstate intel_lpss_pci snd_seq_midi_event
typec_ucsi processor_thermal_rapl nvram i2c_i801 intel_lpss xhci_pci
drm_kms_helper spi_intel_pci ledtrig_audio cfg80211 snd_pcm e1000e
thunderbolt serio_raw platform_profile mei i2c_smbus spi_intel typec
idma64 xhci_pci_renesas i2c_algo_bit intel_vsec intel_rapl_common
snd_rawmidi mac_hid snd_seq snd_seq_device snd_timer i2c_hid_acpi
i2c_hid hid snd soundcore video int3403_thermal int340x_thermal_zone wmi
acpi_tad acpi_pad intel_pmc_core intel_hid int3400_thermal
pinctrl_meteorlake sparse_keymap
[  290.280076]  acpi_thermal_rel sch_fq_codel msr parport_pc ppdev lp
parport drm efi_pstore ip_tables x_tables autofs4
[  290.280097] CPU: 19 PID: 477 Comm: irq/182-iwlwifi Not tainted 6.6.23
#75
[  290.280104] Hardware name: LENOVO 21ML0SIT12/21ML0SIT12, BIOS
N47ET13W (1.02 ) 02/17/2024
[  290.280108] RIP: 0010:iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.280156] Code: 8b 8d 6c ff ff ff 4c 89 f2 4c 89 e6 4c 89 ef e8 4a
f4 ff ff e9 08 fe ff ff 4d 89 ef 89 d6 48 c7 c7 c5 6c bf c0 e8 44 1d 36
fb <0f> 0b 4c 89 ff e8 1a 48 ff ff e9 9e fe ff ff 0f 1f 44 00 00 e9 f6
[  290.280161] RSP: 0018:ffffc900004e0de8 EFLAGS: 00010246
[  290.280167] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[  290.280170] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  290.280173] RBP: ffffc900004e0e98 R08: 0000000000000000 R09:
0000000000000000
[  290.280176] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff88811dd27f88
[  290.280179] R13: ffff888119ae8028 R14: ffff88812c4a0000 R15:
ffff888119ae8028
[  290.280182] FS:  0000000000000000(0000) GS:ffff8882214c0000(0000)
knlGS:0000000000000000
[  290.280187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  290.280191] CR2: 00007f914800ba8c CR3: 000000020e83a005 CR4:
0000000000770ee0
[  290.280195] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  290.280198] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
0000000000000400
[  290.280201] PKRU: 55555554
[  290.280204] Call Trace:
[  290.280208]  <IRQ>
[  290.280214]  ? show_regs+0x72/0x90
[  290.280225]  ? iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.280269]  ? __warn+0x8d/0x160
[  290.280278]  ? iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.280324]  ? report_bug+0x1bb/0x1d0
[  290.280335]  ? console_unlock+0x77/0x130
[  290.280346]  ? handle_bug+0x46/0x90
[  290.280354]  ? exc_invalid_op+0x19/0x80
[  290.280360]  ? asm_exc_invalid_op+0x1b/0x20
[  290.280369]  ? iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.280412]  ? iwl_pcie_rx_handle+0x80c/0xad0 [iwlwifi]
[  290.280457]  iwl_pcie_napi_poll_msix+0x30/0x100 [iwlwifi]
[  290.280500]  ? try_to_wake_up+0x278/0x6c0
[  290.280507]  __napi_poll+0x30/0x1f0
[  290.280515]  net_rx_action+0x190/0x300
[  290.280521]  ? __irq_wake_thread+0x42/0x50
[  290.280529]  __do_softirq+0xda/0x330
[  290.280533]  ? handle_edge_irq+0xda/0x250
[  290.280540]  ? __pfx_irq_thread_fn+0x10/0x10
[  290.280547]  do_softirq.part.0+0x41/0x80
[  290.280557]  </IRQ>
[  290.280559]  <TASK>
[  290.280562]  __local_bh_enable_ip+0x72/0x80
[  290.280570]  iwl_pcie_irq_rx_msix_handler+0xd7/0x1c0 [iwlwifi]
[  290.280644]  irq_thread_fn+0x25/0x70
[  290.280653]  irq_thread+0xea/0x1c0
[  290.280660]  ? __pfx_irq_thread_dtor+0x10/0x10
[  290.280668]  ? __pfx_irq_thread+0x10/0x10
[  290.280675]  kthread+0xf4/0x130
[  290.280683]  ? __pfx_kthread+0x10/0x10
[  290.280690]  ret_from_fork+0x43/0x70
[  290.280697]  ? __pfx_kthread+0x10/0x10
[  290.280704]  ret_from_fork_asm+0x1b/0x30
[  290.280712]  </TASK>
[  290.280715] ---[ end trace 0000000000000000 ]---
[  290.281118] iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.

Found the first bad
commit c1c1039135c3 ("wifi: iwlwifi: increase number of RX buffers for EHT devices")
Another commit should be along with it:
commit 9f9797c7de18 ("wifi: iwlwifi: pcie: fix RB status reading")

BugLink: https://bugs.launchpad.net/bugs/2058808

Johannes Berg (1):
  wifi: iwlwifi: pcie: fix RB status reading

 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


