Return-Path: <linux-wireless+bounces-22338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31843AA719C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D416A029
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70826253F1B;
	Fri,  2 May 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZokfXFf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401A252905
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188465; cv=none; b=qqJdxEuloKfM9yiOv6WAtfnmFZdV46QYw9rUK2aIWZStxTmV4L1Pl+z/cNSXobi2OJiXTGiCFsSy1J2CRse3yG8PalTzUpkDhLAVK2dUqkevR18Gnz9yiuB5CASPvg5UEs0+FgyrVF+bkjhOk3hNoJr+WniSovH24HHCFbTB5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188465; c=relaxed/simple;
	bh=lyd/HnSPIfCTaOyDvWvtpoVJWwvSX/bZZvQjREJAc9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0dpc8vHrKnhTodFVXqRLpU3j+c+0C50h1B9OmK/iZHIZLmjhNhw6HV6BTVQiZhi5G0zp36dDqBCiwjtMTSdTIZFjjhcDmHQIVEdPq07MOmdly8ZcR2OgdBCh967MbKKQqC0Xa3MKOVN3vNwwQjYvqWGObt10oeRZS2/hjr6CSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZokfXFf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188462; x=1777724462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyd/HnSPIfCTaOyDvWvtpoVJWwvSX/bZZvQjREJAc9M=;
  b=bZokfXFfY7d3NLzXR6f+L74hTmDZdGt94S17ktPz8B6OLXQPagf4RKK4
   5t7EaFyz+fFTD5RTT7T6K4eMcMPAQBFZzOjy+/jR+OhZ8vF7JPzLABjdc
   22a/Q2qKeMJPZCBEN5DmBhvtEjmPZafuJkKRUQ4yqTIbDVWMdIOdJqOyG
   sjzMqgMdWO1SIUwCoxy2x2OF4OfcdR6JB7WiJJDBWPxa4IztXZVIT/9bN
   w2K/WyrbkyafVnaivBJUQrIy9mkmVDr1/VinYzRwOYY1RKj+z+bDARYQ5
   h6AvvMacx9ZleaIWE7Yg3IEUEkDND+t8eAXlTXpVFuQXSnJCySQKmMH8F
   A==;
X-CSE-ConnectionGUID: JtnaslMkQZ6We57HeDuujg==
X-CSE-MsgGUID: oj7cZdx6Tc+KTaQU6GAuMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010368"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010368"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:02 -0700
X-CSE-ConnectionGUID: 8ai7BgkKSHOc88VYjeuQeg==
X-CSE-MsgGUID: PFTUewkqQe+gqWNtRB+EWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586141"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/15] wifi: iwlwifi: cfg: remove max_tx_agg_size
Date: Fri,  2 May 2025 15:20:27 +0300
Message-Id: <20250502151751.9c2689e2ca8e.I8274b29ca64d9ef9d1e357bbe34ca3a4b97aeb7a@changeid>
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

This was used in some really old devices, and then got
carried forward to Qu devices, even though on those we
don't need it at all since the TX aggregation start is
offloaded to the firmware. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 30 -------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 ----
 3 files changed, 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 4affcf079a85..70005e6b2d57 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -178,12 +178,6 @@ const struct iwl_cfg iwl9560_qu_jf_cfg = {
 const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
 	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -212,48 +206,24 @@ const char iwl_ax201_killer_1650i_name[] =
 
 const struct iwl_cfg iwl_qu_hr1 = {
 	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.tx_with_siso_diversity = true,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_qu_hr = {
 	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
 	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.fw_name_pre = IWL_CC_A_FW_PRE,
 	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b9f6f122e752..26d0faa44695 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -334,7 +334,6 @@ struct iwl_fw_mon_regs {
  * @mac_addr_from_csr: read HW address from CSR registers at this offset
  * @features: hw features, any combination of feature_passlist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
- * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
  * @dccm_offset: offset from which DCCM begins
  * @dccm_len: length of DCCM (including runtime stack CCM)
  * @dccm2_offset: offset from which the second DCCM begins
@@ -397,7 +396,6 @@ struct iwl_cfg {
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
 	u8 nvm_hw_section_num;
-	u8 max_tx_agg_size;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
 	u16 num_rbds;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 76603ef02704..14932700c6f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1313,11 +1313,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	hw->max_rx_aggregation_subframes = max_agg;
 
-	if (cfg->max_tx_agg_size)
-		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
-	else
-		hw->max_tx_aggregation_subframes = max_agg;
-
 	op_mode = hw->priv;
 
 	mvm = IWL_OP_MODE_GET_MVM(op_mode);
-- 
2.34.1


