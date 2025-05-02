Return-Path: <linux-wireless+bounces-22331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09ABAA7197
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD531C00DBE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B717252904;
	Fri,  2 May 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgtBA1ze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E6254AFA
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188454; cv=none; b=Jiznbs5KRjOTr2p9LgiEF59YGMg6jW4mOUfWmLk5qzRxnepSSOKT0neCWpWMkj1qX3LVeuG8sZwtYTLnKkTJf4iGW8hZWFwyCLhqBJBp1bbfsgRtZI2+kZUXYLe27wz/joaxoneFMJX+83ztl87ImUTjLeFI5vErX+CUWdXMIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188454; c=relaxed/simple;
	bh=Ji7MEh37sJ4BkX4TqC/R7LAcabgHKwqVWHgRkP4uK3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjtD+rJYToJski4ihZHs99MLBpTHcm+3hywGc0jgv5xyzx9TarsdRUndvfqLr1LfSgxFk180qMg+TGhhp/+vvxCrvk3WRKLB6aPNLL6x7ljwLr/3OYATHB5ZIARkQL3piPkFf6dCmGNFNsUSabGVr3nxRL4nUaNMGDhLMvlsv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgtBA1ze; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188452; x=1777724452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ji7MEh37sJ4BkX4TqC/R7LAcabgHKwqVWHgRkP4uK3A=;
  b=OgtBA1zeAFgQXHsChtQECAcxuNbhffKFMYTAhpCoqmYH7L+mtdnKfv+p
   3u7qTVeA5IXWoGvvaX1TbK59oNXTfqDIkinUcEqXTdbHzMHl68VOc45hV
   9hnO+SWutHquIaa059mRgpEtM5QNSymRZlUoFbINvLhnN+Fs7euIwwoCn
   hdOi0Jjyv+poc+ZqUFr0fIje5YLZ4OFtisivqU3QLr7/3/VnZQJrTM0U7
   jpJNB4djXmOsgNaZhzGNPastKcwD4209wgv1gtjZQO6Ge/dWf7gZVx2lR
   DaXPZ4YAoqujszpJ/WYs8mkHN6hesATIkduuLD2PEVeXPTgOf5biElGAf
   w==;
X-CSE-ConnectionGUID: rgXDQZEMSm6bRSJ55FkbsA==
X-CSE-MsgGUID: vQcZ8S0CR9aOVL4hPTxGvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010357"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:52 -0700
X-CSE-ConnectionGUID: Wjmi+uwMTySKcZUmUr+2lA==
X-CSE-MsgGUID: N2PF1DUtR76jJjD0hccWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586115"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: unify some configurations
Date: Fri,  2 May 2025 15:20:20 +0300
Message-Id: <20250502151751.b93f34a65822.I57b8235acb675cb6b4e97df2f4a7365f3d9bff18@changeid>
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

Rather than having individual entries for different MAC
and RF steps, unify the entries by using fw_name_mac and
remove the now duplicated ones.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 108 +++---------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  20 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  86 ++++++--------
 3 files changed, 64 insertions(+), 150 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 67ee3b6e6d85..1237d1b62b65 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -170,14 +170,8 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
  * looks more like 22000.  That's why this device is here, but called
  * 9560 nevertheless.
  */
-const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg = {
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg = {
-	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
+const struct iwl_cfg iwl9560_qu_jf_cfg = {
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
@@ -217,8 +211,8 @@ const char iwl_ax201_killer_1650s_name[] =
 const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
-const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
+const struct iwl_cfg iwl_qu_hr1 = {
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -230,8 +224,8 @@ const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_qu_b0_hr_b0 = {
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
+const struct iwl_cfg iwl_qu_hr = {
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -244,45 +238,7 @@ const struct iwl_cfg iwl_qu_b0_hr_b0 = {
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
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
-const struct iwl_cfg iwl_qu_c0_hr1_b0 = {
-	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
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
-const struct iwl_cfg iwl_qu_c0_hr_b0 = {
-	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
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
-const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0 = {
-	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -293,8 +249,8 @@ const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_quz_a0_hr1_b0 = {
-	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+const struct iwl_cfg iwl_quz_hr1 = {
+	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -308,7 +264,7 @@ const struct iwl_cfg iwl_quz_a0_hr1_b0 = {
 
 const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -321,7 +277,7 @@ const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
 
 const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -334,7 +290,7 @@ const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
 
 const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -357,35 +313,9 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
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
-const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
-	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
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
-const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
+const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -396,9 +326,9 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
+const struct iwl_cfg killer1650i_2ax_cfg_qu_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
+	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -409,8 +339,8 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
-	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
+const struct iwl_cfg iwl_cfg_quz_hr = {
+	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index daf04ae2f9a9..db8dbdde55bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -621,25 +621,19 @@ extern const struct iwl_cfg iwl8265_2ac_cfg;
 extern const struct iwl_cfg iwl8275_2ac_cfg;
 extern const struct iwl_cfg iwl4165_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
-extern const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg;
-extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
+extern const struct iwl_cfg iwl9560_qu_jf_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
-extern const struct iwl_cfg iwl_qu_b0_hr1_b0;
-extern const struct iwl_cfg iwl_qu_c0_hr1_b0;
-extern const struct iwl_cfg iwl_quz_a0_hr1_b0;
-extern const struct iwl_cfg iwl_qu_b0_hr_b0;
-extern const struct iwl_cfg iwl_qu_c0_hr_b0;
+extern const struct iwl_cfg iwl_qu_hr1;
+extern const struct iwl_cfg iwl_quz_hr1;
+extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
-extern const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg iwl_ax201_cfg_quz_hr;
 extern const struct iwl_cfg iwl_ax1650i_cfg_quz_hr;
 extern const struct iwl_cfg iwl_ax1650s_cfg_quz_hr;
-extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
-extern const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0;
-extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
-extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
+extern const struct iwl_cfg killer1650s_2ax_cfg_qu_hr;
+extern const struct iwl_cfg killer1650i_2ax_cfg_qu_hr;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
@@ -652,7 +646,7 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_quz_hr;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 23edb203e983..6e06a7b4223c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -655,10 +655,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x43F0), SUBDEV(0x0078), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x43F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_b0_hr_b0,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr,
 		     iwl_ax201_killer_1650s_name,
 		     DEVICE(0x43F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_b0_hr_b0,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr,
 		     iwl_ax201_killer_1650i_name,
 		     DEVICE(0x43F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
@@ -675,9 +675,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0xA0F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x0A10), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -733,9 +733,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x34F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -752,9 +752,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x3DF0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -771,9 +771,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_b0_hr_b0, NULL,
+	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -925,65 +925,65 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Qu with Jf */
 	/* Qu B step */
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9461_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9462_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9560_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2),
 		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2),
 		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
 
 	/* Qu C step */
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9461_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9462_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9560_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMIT(80), CORES(BT),
 		     NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2),
 		     RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2),
 		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
 
@@ -1011,25 +1011,25 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Qu with Hr */
 	/* Qu B step */
-	IWL_DEV_INFO(iwl_qu_b0_hr1_b0, iwl_ax101_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(B), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_b0_hr_b0, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
 
 	/* Qu C step */
-	IWL_DEV_INFO(iwl_qu_c0_hr1_b0, iwl_ax101_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_c0_hr_b0, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_c0_hr_b0, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
 	/* QuZ */
-	IWL_DEV_INFO(iwl_quz_a0_hr1_b0, iwl_ax101_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_quz_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
 		     RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_quz_a0_hr_b0, iwl_ax203_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_cfg_quz_hr, iwl_ax203_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_quz_a0_hr_b0, iwl_ax201_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_cfg_quz_hr, iwl_ax201_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
 /* Ma */
@@ -1519,27 +1519,17 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		iwl_trans->cfg = cfg_7265d;
 
 	/*
-	 * This is a hack to switch from Qu B0 to Qu C0.  We need to
-	 * do this for all cfgs that use Qu B0, except for those using
+	 * This is a hack to switch from QuZ to Qu C0.  We need to
+	 * do this for all cfgs that use QuZ, except for those using
 	 * Jf, which have already been moved to the new table.  The
 	 * rest must be removed once we convert Qu with Hr as well.
 	 */
-	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
-		if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
-			iwl_trans->cfg = &killer1650s_2ax_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
-			iwl_trans->cfg = &killer1650i_2ax_cfg_qu_c0_hr_b0;
-	}
-
-	/* same thing for QuZ... */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
 		if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
-		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
+		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax1650s_cfg_quz_hr;
-		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
+		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax1650i_cfg_quz_hr;
 	}
 
-- 
2.34.1


