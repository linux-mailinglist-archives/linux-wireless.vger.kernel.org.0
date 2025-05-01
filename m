Return-Path: <linux-wireless+bounces-22301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23AAA5CDE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FED54A5AC8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F022D4F0;
	Thu,  1 May 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLLE2ldk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A812AEE1
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093607; cv=none; b=EYm1PqKshg18r5bQyU37syRUAtX47CfgNhbtjMmPGmTrRwnUyi22y2c5S97pXd8QfED7X9VEm9HxTeiN4NgWnp7tErRt7so5dkfYSzx73Yk2s7lj8Ywi98bMDFNKoBvKmrM0Aljlr8R+BhOLhHg+okr81b5vXiw37whbdU23Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093607; c=relaxed/simple;
	bh=7VEpvNLEF9ScdKYKKDdpBPBdIII88KqAaCugKcuwRe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqLF9iCFEQMr68pAZ2bWoG1xkn0CLQyfbe+DgLzhxmzpX6afe1LThrQikFSvblw8ClGQiFsEl1ocPTLaNGZlfH6TQbnpCwMlxfbFc46GMSf6YgImAjBd3EBAEvrUaQTPKYd+wtoHYA2NThQ0f0EDuSIC8YgkwuAAaEYT+KygPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLLE2ldk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093606; x=1777629606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7VEpvNLEF9ScdKYKKDdpBPBdIII88KqAaCugKcuwRe8=;
  b=QLLE2ldkih4pcj/RUJwINKtIsxgdesNt9RGDbgke/tFbM1lzE0TU6G+i
   9UTNsyKBwgOxatkWvAEqt0sKBtFzuXfkvL51LhDYwXHxTy6wQ3QBY/kVI
   i+x5yYpGRcyJSTZM0xlhZlOXx2GgBswimQQ7GNfNGEyI/RBrYuMJD0Smo
   q4Z6Zk9XO0v9uC+BBGVp6PmDIhGtTtqMiYAhldoNPJ1frjt0bQkhhBoi5
   R/H7WVcm35y8riGBFkalIJTRhHtwwlBug1fCOCAmP+hsltpsJ4wOuys+u
   JHqnRaS+3RfU9AMmdj2y8+R3cSrCx8QgF8F3fKjvi9l2oTmZ4rZ904JLf
   w==;
X-CSE-ConnectionGUID: 3HhScaeGTEqbj2Nqcpht+A==
X-CSE-MsgGUID: 0S19sBa/R/yxOUdnLKBkLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962835"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962835"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:06 -0700
X-CSE-ConnectionGUID: +NL/0OOURhGQIXH3VBIf+g==
X-CSE-MsgGUID: Ccrc4AVSTvWOlvTx3zwUUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317992"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: cfg: unify Qu/QuZ configs
Date: Thu,  1 May 2025 12:59:31 +0300
Message-Id: <20250501125731.02f426870a2e.If51ad0b2c8afaaa131208125af3bc292793613bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
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
index 903f62032a28..bc7a3197c6f4 100644
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


