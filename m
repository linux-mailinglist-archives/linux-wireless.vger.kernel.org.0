Return-Path: <linux-wireless+bounces-25276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D462B02083
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002D6A602C4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D22ED149;
	Fri, 11 Jul 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cubAYyr1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFD2E2EE7
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248093; cv=none; b=jf1D5HgQ9K1ngbNOIyet0jRzhZJNYGnR/syoL3LqlQqOE28wksFLsyxeNierHMgOIY2AnhBScEQtofffGxEl13phJoMiwOq784dO0O0J9cl8ESzwW/FGEq2+Q0hzD3qgZQHfAp4cOrwhyKsYfk5wBneHz6cIVT4usmT6SRG1zR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248093; c=relaxed/simple;
	bh=X9U18EgLa602de8T/ya+JiJ/yjX4wGq4yusIeeWxSIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgXacr2qJFM0++BGHp5bJ9G3dMxAh6eEuKQupD2hsRkeSXvgbdGhsWjc9c04YeUIt47UXfe2wQe0EEHgEtGky5sTr+cwL2cjWtiHSq+pDf3ic+R8pZrg+Qt18sEBpuAcZtXuNiVtbKEgyxkT/CenE1qPGRdSZoWWXaBFGJsFmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cubAYyr1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248092; x=1783784092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9U18EgLa602de8T/ya+JiJ/yjX4wGq4yusIeeWxSIc=;
  b=cubAYyr1staKYDMM1/2AedbgYqVrWd979daEpRcO0qJg0E/1u5oSahcr
   BNNYB9M9dXlH9ZGFloHLA+Woh/oLVVzcEyc+EvvBgUi1ZSY0WIdqtHuGB
   xj7ERy4x4gb0t+llwhiNu/+G+UNq7nR+jL5rb5EIGLBc6/RzM6b0+zXiP
   WxWVsHsnSZzs+eLxCa63sD1uLxnWsNdp2rDTP3/7tmNAAy4RMzqZPnIgD
   0nymsdMcZmMydnBOFVAgaq58iunrcYJkeukXNuJwKw/S68Yp9UCzMUh9m
   EyDWCoEawrVSxC6NO+J/k6R6lp+38KCTgy24r5J5KyuO67lY+sELUPnPJ
   A==;
X-CSE-ConnectionGUID: lUAjNrPsR7+yG1p7QigDJw==
X-CSE-MsgGUID: 7KPnivPxQ9yja6b+XXLBhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264150"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264150"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:52 -0700
X-CSE-ConnectionGUID: iQILVBvlQRSVQfYK9r3Mew==
X-CSE-MsgGUID: 0j+Rhd0PQSGMxWPuZlEtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485080"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mvm: remove IWL_MVM_ESR_EXIT_FAIL_ENTRY
Date: Fri, 11 Jul 2025 18:34:15 +0300
Message-Id: <20250711183056.a69dc9c6ba49.I7f9fbc1f954b4c118625a4b8d51c72f3c84936da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

EHT capable devices will only use iwlmld. So we can remove EMLSR code
from iwlmvm.
As part of removal, remove IWL_MVM_ESR_EXIT_FAIL_ENTRY EMLSR state.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 42 -------------------
 3 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 851869c0bd50..9e46ac3e573a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -18,8 +18,7 @@
 	HOW(EXIT_COEX)			\
 	HOW(EXIT_BANDWIDTH)		\
 	HOW(EXIT_CSA)			\
-	HOW(EXIT_LINK_USAGE)		\
-	HOW(EXIT_FAIL_ENTRY)
+	HOW(EXIT_LINK_USAGE)
 
 static const char *const iwl_mvm_esr_states_names[] = {
 #define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cf6177b43262..5754e83c6fcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -374,7 +374,6 @@ struct iwl_mvm_vif_link_info {
  *	preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
  * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
- * @IWL_MVM_ESR_EXIT_FAIL_ENTRY: Exit EMLSR due to entry failure
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -390,7 +389,6 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
 	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
-	IWL_MVM_ESR_EXIT_FAIL_ENTRY	= 0x400000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index eb1b2f182be5..c7a3fbc49b59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -161,43 +161,6 @@ static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
 				  iwl_mvm_get_primary_link(vif));
 }
 
-static void iwl_mvm_rx_esr_trans_fail_notif(struct iwl_mvm *mvm,
-					    struct iwl_rx_cmd_buffer *rxb)
-{
-	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_esr_trans_fail_notif *notif = (void *)pkt->data;
-	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
-	u8 fw_link_id = le32_to_cpu(notif->link_id);
-	struct ieee80211_bss_conf *bss_conf;
-
-	if (IS_ERR_OR_NULL(vif))
-		return;
-
-	IWL_DEBUG_INFO(mvm, "Failed to %s eSR on link %d, reason %d\n",
-		       le32_to_cpu(notif->activation) ? "enter" : "exit",
-		       le32_to_cpu(notif->link_id),
-		       le32_to_cpu(notif->err_code));
-
-	/* we couldn't go back to single link, disconnect */
-	if (!le32_to_cpu(notif->activation)) {
-		iwl_mvm_connection_loss(mvm, vif, "emlsr exit failed");
-		return;
-	}
-
-	bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, fw_link_id, false);
-	if (IWL_FW_CHECK(mvm, !bss_conf,
-			 "FW reported failure to activate EMLSR on a non-existing link: %d\n",
-			 fw_link_id))
-		return;
-
-	/*
-	 * We failed to activate the second link and enter EMLSR, we need to go
-	 * back to single link.
-	 */
-	iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_FAIL_ENTRY,
-			 bss_conf->link_id);
-}
-
 static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -526,10 +489,6 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
 		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_umac_scan_channel_survey_notif),
-	RX_HANDLER_GRP(MAC_CONF_GROUP, EMLSR_TRANS_FAIL_NOTIF,
-		       iwl_mvm_rx_esr_trans_fail_notif,
-		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		       struct iwl_esr_trans_fail_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -660,7 +619,6 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(STA_DISABLE_TX_CMD),
 	HCMD_NAME(ROC_CMD),
-	HCMD_NAME(EMLSR_TRANS_FAIL_NOTIF),
 	HCMD_NAME(ROC_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_ERROR_NOTIF),
 	HCMD_NAME(MISSED_VAP_NOTIF),
-- 
2.34.1


