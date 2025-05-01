Return-Path: <linux-wireless+bounces-22304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49432AA5CE1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F823BB0DB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6DF22D785;
	Thu,  1 May 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaFnh8PI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4522D4D0
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093612; cv=none; b=uLQ68NuCsciHhkV8WsU/iDo6mzPnjngMzcvhJcOdSkqV7ov2QV4g2tJLcBbkj1BlKMVL0F64jj5SZY15E+n6l8DrAgCr9Zxo4Xdkd2rsftC54uOt35WdI43zuT7VtO80S//0aDOfHLroGrMtFvLUeQqIYlgWieyH2f8PFwzMtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093612; c=relaxed/simple;
	bh=lyd/HnSPIfCTaOyDvWvtpoVJWwvSX/bZZvQjREJAc9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuvlZji5e9E7syFPPZHij1TahMEqOq7x9JnWUeYGt2meaQUXGrahFHI+fdlDVm19kmwLh5AYYccHxuTVolJJwpixUFkNmg/iTvljR64LoJCOZ+agJ5vzkM8ZrEZKClmKv9jQMuXW5HZf8CKHmojyYCvKPjPkdmLzIjjCTze7+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaFnh8PI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093610; x=1777629610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyd/HnSPIfCTaOyDvWvtpoVJWwvSX/bZZvQjREJAc9M=;
  b=CaFnh8PIstkjYKzUDiLtndPI0X0ktvZYodUvu8jEgeyQ2UJtum/mQ4Zp
   tarHwwvY0ZoZfZOPu1MqjD6ahqcNT1TXM1o0vIq4unC4E9wjxiYJM0cgG
   orH5SE/tyU1qlE5aizlZRKxgqlkFUS9XnNKi0rXZ4WYJeMnnAfxP3dtf8
   1+jKcXEUIOmJoSmwQQF9XattHxE1YJRlMq3c4jTXqIen6wqQG6UNX4QC/
   8P1G4xCAlc852WPMop2pJmpAikulRDjS/wL4DZ5KqsOKJf98bt0JhWjBR
   JTh7I/yosYBNVWNGENRNi91nuKrfP0d3vk0tbFPsNYaZeRWP7IIn6Aacn
   A==;
X-CSE-ConnectionGUID: 7nXb5rK+Q4mZ9xDr2Tdsgw==
X-CSE-MsgGUID: +D6/jLEMR3eRF0PsFypKug==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962848"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962848"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:10 -0700
X-CSE-ConnectionGUID: iKg773roShuarC50zrUCog==
X-CSE-MsgGUID: KWshjbYESEaVTiGGh8ay6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135318015"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: cfg: remove max_tx_agg_size
Date: Thu,  1 May 2025 12:59:34 +0300
Message-Id: <20250501125731.a437d63e9540.I8274b29ca64d9ef9d1e357bbe34ca3a4b97aeb7a@changeid>
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


