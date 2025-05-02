Return-Path: <linux-wireless+bounces-22336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B632AA71A0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D2D980642
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B3253F04;
	Fri,  2 May 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klWcVAMH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDD252905
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188461; cv=none; b=p+7MvLZY2kNjyz5fPm12Wfj3MF8xJhhrCXX/8VK4j7PBqyhp+nEN1lBD8LeEZLY4wczrkGdYq2mS21P6EFkegXzEIzAYSrlbELe8fZvg2KlAujZXMvYxqJQFzk7dB9R8Cw2SfVkPW2wqVL+JVeWEsHPI3HCt4AMfwG4NOEOoEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188461; c=relaxed/simple;
	bh=FsGfnvSn2g9EIj3yPceqHI2iHULBDRLBJ/382hIUgRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6a6/hwvBPMm7EqQhUukzcBBazcDeYJlVnyyPCUu7eSARQje3FXaIA2JaistyLK+nk4iz3AjUizjksbUE1o1T8W+dYMKsy0JX778+cSUH2tmldk20DPcfAPEJnBAetFN6p0EvRRy9e9R2xbif9Ens5e7aJcXyVa0uVgaJi0oVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klWcVAMH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188458; x=1777724458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsGfnvSn2g9EIj3yPceqHI2iHULBDRLBJ/382hIUgRc=;
  b=klWcVAMHGg67a9Gk1cEH7plS1Se0XQfnW/e3Qsi11ko6dhZJvnWBBFcP
   WdddyExvJ00x84WyxSyDrkC5yCOif3Vk5Va7er8amidTlaIK3xD9ygAo1
   TNKgtjnHagCxgq+VV6EKFDnWO2oML1Qy9VRPDa6Ue2du01bLq6iEI0Yng
   k0cgn5hGOV1hEpTg/sv7HxWMDzNUlC1GbIJVum/ceg+bnD6mO+jH9Becw
   Mx+nlXvx19lOp2rSwB4LlF0AmO72wUSL7jUsnkiuwLfe9Dd8sABDyQZ1/
   Z9q6EgYoe1VVZd8ImkeuaKXhIUxXTAndhJAt21SBO6Qzl2ribTW60MPSO
   g==;
X-CSE-ConnectionGUID: fQ/hVdvQQ+qFR6OWnqJPuQ==
X-CSE-MsgGUID: sNloimlCTbOp7iRvVUI7aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010365"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010365"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:58 -0700
X-CSE-ConnectionGUID: RDfGNMGoRnOQIpZ0J6Igmw==
X-CSE-MsgGUID: Mauvr1UXS42OfUsa70tLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586129"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: cfg: unify Qu/QuZ configs
Date: Fri,  2 May 2025 15:20:24 +0300
Message-Id: <20250502151751.957fbb5437ce.If51ad0b2c8afaaa131208125af3bc292793613bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that the fw_name_mac is no longer around and derived
from the MAC type automatically, we no longer need to have
different configurations for Qu/QuZ. Combine them. For the
killer AX1650s/i, also fix the names, there was a mixup.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 63 +------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 --
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 60 +++++++-----------
 4 files changed, 26 insertions(+), 104 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b2d24a49234c..ac137c82f7c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -245,54 +245,6 @@ const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_quz_hr1 = {
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.tx_with_siso_diversity = true,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
-	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	IWL_DEVICE_22500,
-	/*
-         * This device doesn't support receiving BlockAck with a large bitmap
-         * so we need to restrict the size of transmitted aggregation to the
-         * HT size; mac80211 would otherwise pick the HE max (256) by default.
-         */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
-	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
-	IWL_DEVICE_22500,
-	/*
-         * This device doesn't support receiving BlockAck with a large bitmap
-         * so we need to restrict the size of transmitted aggregation to the
-         * HT size; mac80211 would otherwise pick the HE max (256) by default.
-         */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
-	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
-	IWL_DEVICE_22500,
-	/*
-         * This device doesn't support receiving BlockAck with a large bitmap
-         * so we need to restrict the size of transmitted aggregation to the
-         * HT size; mac80211 would otherwise pick the HE max (256) by default.
-         */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.fw_name_pre = IWL_CC_A_FW_PRE,
 	IWL_DEVICE_22500,
@@ -306,7 +258,7 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 };
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
-	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
+	.name = iwl_ax201_killer_1650s_name,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -318,18 +270,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
 };
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_hr = {
-	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg iwl_cfg_quz_hr = {
+	.name = iwl_ax201_killer_1650i_name,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 82ca7faf3fe0..127d4dd548ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -623,13 +623,9 @@ extern const struct iwl_cfg iwl9560_qu_jf_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl_qu_hr1;
-extern const struct iwl_cfg iwl_quz_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
-extern const struct iwl_cfg iwl_ax201_cfg_quz_hr;
-extern const struct iwl_cfg iwl_ax1650i_cfg_quz_hr;
-extern const struct iwl_cfg iwl_ax1650s_cfg_quz_hr;
 extern const struct iwl_cfg killer1650s_2ax_cfg_qu_hr;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_hr;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
@@ -644,7 +640,6 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_quz_hr;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 0b208d973585..7ff97fb71905 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -201,6 +201,8 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		break;
 	case IWL_CFG_MAC_TYPE_QUZ:
 		mac = "QuZ";
+		/* all QuZ use A0 firmware */
+		mac_step = 'a';
 		break;
 	case IWL_CFG_MAC_TYPE_SO:
 	case IWL_CFG_MAC_TYPE_SOF:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6852a2214936..deff291a43ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -685,43 +685,43 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0xA0F0), SUBDEV(0x4070), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x6074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x6074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax1650s_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax1650i_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax1650s_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax1650i_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_quz_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x4070), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x0070), BW_NO_LIMIT),
@@ -1025,11 +1025,11 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
 	/* QuZ */
-	IWL_DEV_INFO(iwl_quz_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
 		     RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_quz_hr, iwl_ax203_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_quz_hr, iwl_ax201_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
 /* Ma */
@@ -1520,22 +1520,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (cfg_7265d &&
 	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
 		iwl_trans->cfg = cfg_7265d;
-
-	/*
-	 * This is a hack to switch from QuZ to Qu C0.  We need to
-	 * do this for all cfgs that use QuZ, except for those using
-	 * Jf, which have already been moved to the new table.  The
-	 * rest must be removed once we convert Qu with Hr as well.
-	 */
-	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-		if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
-		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax1650s_cfg_quz_hr;
-		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax1650i_cfg_quz_hr;
-	}
-
 #endif
 	/*
 	 * If we didn't set the cfg yet, the PCI ID table entry should have
-- 
2.34.1


