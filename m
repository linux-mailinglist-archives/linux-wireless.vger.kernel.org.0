Return-Path: <linux-wireless+bounces-8126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE68D07FB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238FF1F21722
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED2167296;
	Mon, 27 May 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3Ve53sq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57A15F30F
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826003; cv=none; b=pOOlmY2GKr2YxUJlkfQKR5zOpfrlWJPc+lNM5UH5CfpPGKi8g2Sb5xL5gJtP44cVodnEzdEi6qE+SaHvB257m3txepZFDz4Yjz+g3FB6sAao3S/f4ikHiiHEOI+PXZfpFWuc5O7udsubFVp01cz47jpm2N+gUyEGdRuYGgENNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826003; c=relaxed/simple;
	bh=7PCte07guXq7+2spuBHPimIrI1hxFGWu0Nna3yGo7z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqV7I+e6x3b0RMcZtyFBitrsH50Om4GnK7B7a+NoR829AGIVumtnNj4FJWs0+SiAv2UBzGWICzEF8YL6t2J1sbdQL6p2prIH7svqdnpovpOzAlgiEDxJL4CqZcZdAOWnxrr/Gyy6X3g6labkEs9J4v5VSGQfjoFkmHluuS+MS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3Ve53sq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826002; x=1748362002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PCte07guXq7+2spuBHPimIrI1hxFGWu0Nna3yGo7z4=;
  b=V3Ve53sq8qByCkPC0gxqFAZi2Mukcm2GcL9Ktb9y+jmkkxmftmVN1Y5M
   YaN0EnhsX1EwTEWFhLKrOBuT3VFImir1Au3TDMf8lqxt6FHVjML8KjGBN
   tcqAVCFW4+2i7GHeGffJmOMnT75k0MaH5FGRxp/TvwMyiblOnL2Xs9feJ
   R61MwJ/WgV3O1i17w0fH2gtd2t1G22uyNZ+Ab+QtdxxO4rheogVE0xyBg
   G9Bq/jToavK2esAx06pOwIe1pib5XsXbbhRjR0/eElT4+QH4ovjPeVNI/
   auhpLeL0bM9cVbea+3aHbA3pSvf/K35j4FFS98GEXnRfTtiTS3xQNhBWS
   w==;
X-CSE-ConnectionGUID: YEsmGOaQQ1G5itI7w83i6A==
X-CSE-MsgGUID: ufbs+aUmR1Ce4KsmPAeXPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002098"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002098"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:42 -0700
X-CSE-ConnectionGUID: 2xgj8iN4R1CF5+TO/B+MOg==
X-CSE-MsgGUID: PLUlTswxTSGGJTVNSXJrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407113"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 12/20] wifi: iwlwifi: mvm: add support for version 10 of the responder config command
Date: Mon, 27 May 2024 19:06:07 +0300
Message-Id: <20240527190228.af09129ebd74.I9356e2504a4c19961d4856494416ae49b36bfe62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

This version adds the band to the responder config command.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 52 +++++++++++++++++++
 .../intel/iwlwifi/mvm/ftm-responder.c         | 15 ++++--
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index c20bb289a623..7c158a8dfed0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -391,6 +391,58 @@ struct iwl_tof_responder_config_cmd_v9 {
 	__le16 max_time_between_msr;
 } __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_8 */
 
+/**
+ * struct iwl_tof_responder_config_cmd - ToF AP mode
+ * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
+ * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @bss_color: current AP bss_color
+ * @channel_num: current AP Channel
+ * @ctrl_ch_position: coding of the control channel position relative to
+ *	the center frequency, see iwl_mvm_get_ctrl_pos()
+ * @sta_id: index of the AP STA when in AP mode
+ * @band: current AP band
+ * @toa_offset: Artificial addition [pSec] for the ToA - to be used for debug
+ *	purposes, simulating station movement by adding various values
+ *	to this field
+ * @common_calib: XVT: common calibration value
+ * @specific_calib: XVT: specific calibration value
+ * @bssid: Current AP BSSID
+ * @r2i_ndp_params: parameters for R2I NDP.
+ *	bits 0 - 2: max number of LTF repetitions
+ *	bits 3 - 5: max number of spatial streams (supported values are < 2)
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
+ * @i2r_ndp_params: parameters for I2R NDP.
+ *	bits 0 - 2: max number of LTF repetitions
+ *	bits 3 - 5: max number of spatial streams
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
+ * @min_time_between_msr: for non trigger based NDP ranging, minimum time
+ *	between measurements in milliseconds.
+ * @max_time_between_msr: for non trigger based NDP ranging, maximum time
+ *	between measurements in milliseconds.
+ */
+struct iwl_tof_responder_config_cmd {
+	__le32 cmd_valid_fields;
+	__le32 responder_cfg_flags;
+	u8 format_bw;
+	u8 bss_color;
+	u8 channel_num;
+	u8 ctrl_ch_position;
+	u8 sta_id;
+	u8 band;
+	__le16 toa_offset;
+	__le16 common_calib;
+	__le16 specific_calib;
+	u8 bssid[ETH_ALEN];
+	u8 r2i_ndp_params;
+	u8 i2r_ndp_params;
+	__le16 min_time_between_msr;
+	__le16 max_time_between_msr;
+} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_10 */
+
 #define IWL_LCI_CIVIC_IE_MAX_SIZE	400
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 8e760300a1ab..e4caa362f597 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -88,7 +88,7 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 
 static void
 iwl_mvm_ftm_responder_set_ndp(struct iwl_mvm *mvm,
-			      struct iwl_tof_responder_config_cmd_v9 *cmd)
+			      struct iwl_tof_responder_config_cmd *cmd)
 {
 	/* Up to 2 R2I STS are allowed on the responder */
 	u32 r2i_max_sts = IWL_MVM_FTM_R2I_MAX_STS < 2 ?
@@ -117,7 +117,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 	 * field interpretation is different), so the same struct can be use
 	 * for all cases.
 	 */
-	struct iwl_tof_responder_config_cmd_v9 cmd = {
+	struct iwl_tof_responder_config_cmd cmd = {
 		.channel_num = chandef->chan->hw_value,
 		.cmd_valid_fields =
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO |
@@ -131,8 +131,13 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (cmd_ver == 10) {
+		cmd.band =
+			iwl_mvm_phy_band_from_nl80211(chandef->chan->band);
+	}
+
 	/* Use a default of bss_color=1 for now */
-	if (cmd_ver == 9) {
+	if (cmd_ver >= 9) {
 		cmd.cmd_valid_fields |=
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_BSS_COLOR |
 				    IWL_TOF_RESPONDER_CMD_VALID_MIN_MAX_TIME_BETWEEN_MSR);
@@ -148,7 +153,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 	}
 
 	if (cmd_ver >= 8)
-		iwl_mvm_ftm_responder_set_ndp(mvm, &cmd);
+		iwl_mvm_ftm_responder_set_ndp(mvm, (void *)&cmd);
 
 	if (cmd_ver >= 7)
 		err = iwl_mvm_ftm_responder_set_bw_v2(chandef, &cmd.format_bw,
-- 
2.34.1


