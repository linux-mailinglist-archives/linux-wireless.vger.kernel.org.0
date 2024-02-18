Return-Path: <linux-wireless+bounces-3744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6559859851
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DF1B211EC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F1376EE;
	Sun, 18 Feb 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ech2GSN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747429CF8
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278729; cv=none; b=s7gDt6Az9BVmKrlgc+f9CmtkAlEFjnXXSW4kz2+kfCZEZMxCJBzqVMe9s8ZBhDVgLo0mtoeTXSpqvYIhFgkEicujS1cqU8hTmnqRd5zuZRd8IByDwEIUjLiivHlgv6ZFcGhiBjt+WFPsWXRUVqPwtIaWABQdDkJ5uH9TIAFB+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278729; c=relaxed/simple;
	bh=Y75ZXRhJm6LsKhiSOI2p/+PPryjJmAYUsaaNDNR7nyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqKeFY7PuwB1KqpBAsup+ohy4Mw1Hj2sWlH7tVjlMytS9caM8d0g95GVP5Qw8M7L1L674tPD22xFlBG6Ooe5w8t/ztAeY5E5ke6mbSRtP3Z2zjSo4FgneiXPMsa+YuvvECYdL4a1AqGpqOKuLNXWByAVgMsrUZf0nHB6J4v+XQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ech2GSN9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278728; x=1739814728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y75ZXRhJm6LsKhiSOI2p/+PPryjJmAYUsaaNDNR7nyA=;
  b=Ech2GSN9VG7ZvKsE09OljW4MHdbdAT8MG9s5DaiC8nw3tUuadft3Ft/X
   cqlu2TBhK6NFCKQlHgmTdRDzLd9lXYaF1fqpKvtHv2eAUM419ubKWawq/
   2kY9Bl1bE56F/bNB6XcRUPuK4msgNiRXtY8eELk83K6nPMviLooI8sciI
   2vj3A9JB+LpC7eloTyi7nKSxYr7WOQAmXiVdBY1h5Avn0doHkEW8+sW/d
   amFwIix2znV8V4lo/jnLh9MckgyX0vmJQzbynuCWW3oUw+PfX3iWO17et
   DgdcmTrKOSCOm7FIoZpLV8jlN+/2zOXRALbPsSkPAgeZPL+oC0b5Qr9mJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464973"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459421"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: mvm: partially support PHY context version 6
Date: Sun, 18 Feb 2024 19:51:43 +0200
Message-Id: <20240218194912.2156fca5b1a5.I57f47f26ec0d96ecfb1192039f72b1c6d4e8a357@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The version 6 command adds the puncture mask to the PHY
context and is otherwise the same. Support that in the
API definitions, but don't fill it yet.

While at it, also mark the field as removed from the link
context command since it moved from there to PHY context.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h |  9 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c    |  6 +++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 200362e5ceca..c6d1f5644638 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -373,7 +373,7 @@ struct iwl_mac_config_cmd {
  *	iwl_link_ctx_cfg_cmd::bss_color_disable
  * @LINK_CONTEXT_MODIFY_EHT_PARAMS: covers iwl_link_ctx_cfg_cmd::puncture_mask.
  *	This flag can be set only if the MAC that this link relates to has
- *	eht_support set to true.
+ *	eht_support set to true. No longer used since _VER_3 of this command.
  * @LINK_CONTEXT_MODIFY_ALL: set all above flags
  */
 enum iwl_link_ctx_modify_flags {
@@ -462,7 +462,7 @@ enum iwl_link_ctx_flags {
  * @bi: beacon interval in TU, applicable only when associated
  * @dtim_interval: DTIM interval in TU.
  *	Relevant only for GO, otherwise this is offloaded.
- * @puncture_mask: puncture mask for EHT
+ * @puncture_mask: puncture mask for EHT (removed in VER_3)
  * @frame_time_rts_th: HE duration RTS threshold, in units of 32us
  * @flags: a combination from &enum iwl_link_ctx_flags
  * @flags_mask: what of %flags have changed. Also &enum iwl_link_ctx_flags
@@ -505,7 +505,7 @@ struct iwl_link_config_cmd {
 	struct iwl_he_backoff_conf trig_based_txf[AC_NUM];
 	__le32 bi;
 	__le32 dtim_interval;
-	__le16 puncture_mask;
+	__le16 puncture_mask; /* removed in _VER_3 */
 	__le16 frame_time_rts_th;
 	__le32 flags;
 	__le32 flags_mask;
@@ -519,9 +519,7 @@ struct iwl_link_config_cmd {
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
 	__le32 reserved3[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 and
-	     * LINK_CONTEXT_CONFIG_CMD_API_S_VER_2
-	     */
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 205d0413e626..08a2c416ce60 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -156,17 +156,18 @@ struct iwl_phy_context_cmd {
 	__le32 lmac_id;
 	union {
 		__le32 rxchain_info; /* reserved in _VER_4 */
-		struct {             /* used for _VER_5 */
+		struct {             /* used for _VER_5/_VER_6 */
 			u8 sbb_bandwidth;
 			u8 sbb_ctrl_channel_loc;
-			__le16 reserved;
-		} v5;
+			__le16 puncture_mask; /* added in VER_6 */
+		};
 	};
 	__le32 dsp_cfg_flags;
 	__le32 reserved;
 } __packed; /* PHY_CONTEXT_CMD_API_VER_3,
 	     * PHY_CONTEXT_CMD_API_VER_4,
-	     * PHY_CONTEXT_CMD_API_VER_5
+	     * PHY_CONTEXT_CMD_API_VER_5,
+	     * PHY_CONTEXT_CMD_API_VER_6
 	     */
 
 #endif /* __iwl_fw_api_phy_ctxt_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index e208e3c34c25..5db44514d025 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -208,7 +208,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 	if (ver < 5 || !ap || !ap->chan)
 		ap = NULL;
 
-	if (ver >= 3 && ver <= 5) {
+	if (ver >= 3 && ver <= 6) {
 		struct iwl_phy_context_cmd cmd = {};
 
 		/* Set the command header fields */
@@ -220,8 +220,8 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 					  chains_dynamic);
 
 		if (ap) {
-			cmd.v5.sbb_bandwidth = iwl_mvm_get_channel_width(ap);
-			cmd.v5.sbb_ctrl_channel_loc = iwl_mvm_get_ctrl_pos(ap);
+			cmd.sbb_bandwidth = iwl_mvm_get_channel_width(ap);
+			cmd.sbb_ctrl_channel_loc = iwl_mvm_get_ctrl_pos(ap);
 		}
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
-- 
2.34.1


