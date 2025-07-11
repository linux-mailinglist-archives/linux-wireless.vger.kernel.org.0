Return-Path: <linux-wireless+bounces-25297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16358B0260B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 22:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C5566F83
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1F1F30BB;
	Fri, 11 Jul 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpUYgXS2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA013221267
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267469; cv=none; b=qqH120eE2Df0/pZTf6T8nqOejB3Q9XIgrvW061RIbXwc1/ALer2CxZlRMI4vRB+gXSyOZWualPjptESV0Yk1dM4gYd0CANrI80Li9+G0lUOq3rbLpiQ2gIX8MW38S927ZH918IxN/kju1S/H06aHsTF5g+0Oq7ka1HHnNXcVchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267469; c=relaxed/simple;
	bh=GPo56t9auo/cWugkymiaJWoX2WIiC9AkdQW1oXbDFGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3mw8akh/JGnwwda2+Cd7MmXEC37l+MSvaqqSTx0YG6vMKc80R5k2njMnHeKk7NLudUrzxxKrZqJgyd07MnuEpzcWTy1O3m4aSx+yCjwZOd8VHTQNvK5x+kXoYTu5pNkwNrVe9X6fgPotDXg/ehjJvxm3QV7MsA7b/MWIvC/Gdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpUYgXS2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752267468; x=1783803468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPo56t9auo/cWugkymiaJWoX2WIiC9AkdQW1oXbDFGg=;
  b=MpUYgXS21Uk2/wruAw0lIi0Igvc98RYPe/TSUBRZdiQox7JRo2YkBzKI
   HoV8A/9MjiVpc6Vu4nocI8dfztmSMZ0usd2Eu3uxy14Tt8TaN2rMpc5BL
   fP1l5zsbkYpNQAp285ee7DwUhJGcxz4qTqQEO+Isi8xCnhRdkPf9CdXTS
   ni2QI7Xbfz8aHyL+Af/PBTcEV03R4SDADOB/C+Da3t/Igw8wxnWAda/bK
   AGA6HCbzDm4oVLLcu3UkkRPD3eVMGiJIy7bAl272btAUdC2rocHxbHyCr
   MM48sv77XGvfYkR3JwaNrxywoEy8gH8FLcYKkzx4RVKVA1U5wCi1FMplH
   w==;
X-CSE-ConnectionGUID: qlLFNS/BQt6HNJhPcd3dJA==
X-CSE-MsgGUID: LjTrDpVDSj6cc7HpM0owrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66015188"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="66015188"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 13:57:47 -0700
X-CSE-ConnectionGUID: QiXW3JMMQM6ciE9+34LGsw==
X-CSE-MsgGUID: gb4c0mkAThelJ8xKy5xRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="162137845"
Received: from johunt-mobl9.ger.corp.intel.com (HELO stinkbox) ([10.245.245.78])
  by orviesa005.jf.intel.com with SMTP; 11 Jul 2025 13:57:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 11 Jul 2025 23:57:44 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: iwlwifi: Fix botched indexing conversion
Date: Fri, 11 Jul 2025 23:57:44 +0300
Message-ID: <20250711205744.28723-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The conversion from compiler assisted indexing to manual
indexing wasn't done correctly. The array is still made
up of __le16 elements so multiplying the outer index by
the element size is not what we want. Fix it up.

This causes the kernel to oops when trying to transfer any
significant amount of data over wifi:

BUG: unable to handle page fault for address: ffffc900009f5282
PGD 100000067 P4D 100000067 PUD 1000fb067 PMD 102e82067 PTE 0
Oops: Oops: 0002 [#1] SMP
CPU: 1 UID: 0 PID: 99 Comm: kworker/u8:3 Not tainted 6.15.0-rc2-cl-bisect3-00604-g6204d5130a64-dirty #78 PREEMPT
Hardware name: Dell Inc. Latitude E5400                  /0D695C, BIOS A19 06/13/2013
Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
RIP: 0010:iwl_trans_pcie_tx+0x4dd/0xe60 [iwlwifi]
Code: 00 00 66 81 fa ff 0f 0f 87 42 09 00 00 3d ff 00 00 00 0f 8f 37 09 00 00 41 c1 e0 0c 41 09 d0 48 8d 14 b6 48 c1 e2 07 48 01 ca <66> 44 89 04 57 48 8d 0c 12 83 f8 3f 0f 8e 84 01 00 00 41 8b 85 80
RSP: 0018:ffffc900001c3b50 EFLAGS: 00010206
RAX: 00000000000000c1 RBX: ffff88810b180028 RCX: 00000000000000c1
RDX: 0000000000002141 RSI: 000000000000000d RDI: ffffc900009f1000
RBP: 0000000000000002 R08: 0000000000000025 R09: ffffffffa050fa60
R10: 00000000fbdbf4bc R11: 0000000000000082 R12: ffff88810e5ade40
R13: ffff88810af81588 R14: 000000000000001a R15: ffff888100dfe0c8
FS:  0000000000000000(0000) GS:ffff8881998c3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900009f5282 CR3: 0000000001e39000 CR4: 00000000000426f0
Call Trace:
 <TASK>
 ? rcu_is_watching+0xd/0x40
 ? __iwl_dbg+0xb1/0xe0 [iwlwifi]
 iwlagn_tx_skb+0x8e2/0xcb0 [iwldvm]
 iwlagn_mac_tx+0x18/0x30 [iwldvm]
 ieee80211_handle_wake_tx_queue+0x6c/0xc0 [mac80211]
 ieee80211_agg_start_txq+0x140/0x2e0 [mac80211]
 ieee80211_agg_tx_operational+0x126/0x210 [mac80211]
 ieee80211_process_addba_resp+0x27b/0x2a0 [mac80211]
 ieee80211_iface_work+0x4bd/0x4d0 [mac80211]
 ? _raw_spin_unlock_irq+0x1f/0x40
 cfg80211_wiphy_work+0x117/0x1f0 [cfg80211]
 process_one_work+0x1ee/0x570
 worker_thread+0x1c5/0x3b0
 ? bh_worker+0x240/0x240
 kthread+0x110/0x220
 ? kthread_queue_delayed_work+0x90/0x90
 ret_from_fork+0x28/0x40
 ? kthread_queue_delayed_work+0x90/0x90
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: ctr aes_generic ccm sch_fq_codel bnep xt_tcpudp xt_multiport xt_state iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv4 ip_tables x_tables btusb btrtl btintel btbcm bluetooth ecdh_generic ecc libaes hid_generic usbhid hid binfmt_misc joydev mousedev snd_hda_codec_hdmi iwldvm snd_hda_codec_idt snd_hda_codec_generic mac80211 coretemp iTCO_wdt watchdog kvm_intel i2c_dev snd_hda_intel libarc4 kvm snd_intel_dspcfg sdhci_pci sdhci_uhs2 snd_hda_codec iwlwifi sdhci irqbypass cqhci snd_hwdep snd_hda_core cfg80211 firewire_ohci mmc_core psmouse snd_pcm i2c_i801 firewire_core pcspkr led_class uhci_hcd i2c_smbus tg3 crc_itu_t iosf_mbi snd_timer rfkill libphy ehci_pci snd ehci_hcd lpc_ich mfd_core usbcore video intel_agp usb_common soundcore intel_gtt evdev agpgart parport_pc wmi parport backlight
CR2: ffffc900009f5282
---[ end trace 0000000000000000 ]---
RIP: 0010:iwl_trans_pcie_tx+0x4dd/0xe60 [iwlwifi]
Code: 00 00 66 81 fa ff 0f 0f 87 42 09 00 00 3d ff 00 00 00 0f 8f 37 09 00 00 41 c1 e0 0c 41 09 d0 48 8d 14 b6 48 c1 e2 07 48 01 ca <66> 44 89 04 57 48 8d 0c 12 83 f8 3f 0f 8e 84 01 00 00 41 8b 85 80
RSP: 0018:ffffc900001c3b50 EFLAGS: 00010206
RAX: 00000000000000c1 RBX: ffff88810b180028 RCX: 00000000000000c1
RDX: 0000000000002141 RSI: 000000000000000d RDI: ffffc900009f1000
RBP: 0000000000000002 R08: 0000000000000025 R09: ffffffffa050fa60
R10: 00000000fbdbf4bc R11: 0000000000000082 R12: ffff88810e5ade40
R13: ffff88810af81588 R14: 000000000000001a R15: ffff888100dfe0c8
FS:  0000000000000000(0000) GS:ffff8881998c3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900009f5282 CR3: 0000000001e39000 CR4: 00000000000426f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Fixes: 6204d5130a64 ("wifi: iwlwifi: use bc entries instead of bc table also for pre-ax210")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index bb467e2b1779..eee55428749c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2101,10 +2101,10 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 
 	bc_ent = cpu_to_le16(len | (sta_id << 12));
 
-	scd_bc_tbl[txq_id * BC_TABLE_SIZE + write_ptr].tfd_offset = bc_ent;
+	scd_bc_tbl[txq_id * TFD_QUEUE_BC_SIZE + write_ptr].tfd_offset = bc_ent;
 
 	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id * BC_TABLE_SIZE + TFD_QUEUE_SIZE_MAX + write_ptr].tfd_offset =
+		scd_bc_tbl[txq_id * TFD_QUEUE_BC_SIZE + TFD_QUEUE_SIZE_MAX + write_ptr].tfd_offset =
 			bc_ent;
 }
 
@@ -2328,10 +2328,10 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 
 	bc_ent = cpu_to_le16(1 | (sta_id << 12));
 
-	scd_bc_tbl[txq_id * BC_TABLE_SIZE + read_ptr].tfd_offset = bc_ent;
+	scd_bc_tbl[txq_id * TFD_QUEUE_BC_SIZE + read_ptr].tfd_offset = bc_ent;
 
 	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id * BC_TABLE_SIZE + TFD_QUEUE_SIZE_MAX + read_ptr].tfd_offset =
+		scd_bc_tbl[txq_id * TFD_QUEUE_BC_SIZE + TFD_QUEUE_SIZE_MAX + read_ptr].tfd_offset =
 			bc_ent;
 }
 
-- 
2.49.0


