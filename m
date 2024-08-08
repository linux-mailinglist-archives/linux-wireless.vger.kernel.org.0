Return-Path: <linux-wireless+bounces-11142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69E94C5A3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8124BB215BD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3C15B10D;
	Thu,  8 Aug 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSkKja5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F610155A25
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148594; cv=none; b=hMc3KNCko4CXYcoCXRtY7x/pyUrb5uiiD//7Evfw9t41yeq6G7nym6k9JRN9s6i9s9UdaJgJB3rvC5CoCpekZPhx8f+UrbT0xXoTLn2w4mXrL9u31zZSJNTqQ0ec8NvksJ408xoS6n2bu57iSy5pAx7AnpWkjIcqOOUnAeaVgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148594; c=relaxed/simple;
	bh=BuCcH+LtaTBzjNW2HDouyMrko7gU2m6QYP4MueXgsbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tY1nV8YQczfL++pyPLQq8gHSdgTznvzMZVdvjSFnu5vUG1PyD2af6WnmM6KDTaIsE6FieqBNAbkSl2WmNmDFAkG8zMVj7E2GAldnkBTsKNOeMcwg8Dddb77VJQsSt2G+ph4FqzYQwjYpnG0NX5ihx7UlDtpy9vipRHcZzqglHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSkKja5K; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148593; x=1754684593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuCcH+LtaTBzjNW2HDouyMrko7gU2m6QYP4MueXgsbI=;
  b=PSkKja5KRJvVqsi7O2E4PtrhAJc2NxbjlfRc5OlOlTlEiEzmV5vG2dhw
   2lmEbwjWakGnDKcCm3BDc/tELX/bRcJATdx1dVF3qLuLJYNrvmuVmAps1
   C3NjIBB+j9Hd6kLnM9WSzaMHUhpp7u0zAj4lvgJaUCykVlhUERGMGmVWq
   Xr2ig2j7KcVW70wVuxWul0jjCR01kCr3KIeUZtoyqiU1fW5AAnz6j+doA
   9vdcQbZh5pv7rJ8wYldfxf1NQRjhU99rfZbMPZSpohdM+z7sW25lPgTbw
   HOOx1bDGpGCR26JBP8TDDE+uHKjg8i/UCCwoZaosllnEQuZlGN2OwGJzK
   g==;
X-CSE-ConnectionGUID: ML3+gTsnShmJnuu+inhctA==
X-CSE-MsgGUID: YaixQ8CsRriCzwNAZscbqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808847"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808847"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:12 -0700
X-CSE-ConnectionGUID: 9ThThVF/QT63YiaG3ubNXA==
X-CSE-MsgGUID: JtOmN3ovSs2sjLli8PWbwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305311"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/13] wifi: iwlwifi: mvm: handle the new EML OMN failure notification
Date: Thu,  8 Aug 2024 23:22:43 +0300
Message-Id: <20240808232017.273bc77a027b.I9f2d3ea851050f6031ac07bbe69eb38000fd5683@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Take the proper action upon EML OMN frame failure.
ticket=jira:WIFI-428051

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 30 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 3a6e0a90a3ef..d151d935e12a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -17,7 +17,8 @@
 	HOW(EXIT_COEX)			\
 	HOW(EXIT_BANDWIDTH)		\
 	HOW(EXIT_CSA)			\
-	HOW(EXIT_LINK_USAGE)
+	HOW(EXIT_LINK_USAGE)		\
+	HOW(EXIT_FAIL_ENTRY)
 
 static const char *const iwl_mvm_esr_states_names[] = {
 #define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f9e676374daa..65b66f01bef9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -368,6 +368,7 @@ struct iwl_mvm_vif_link_info {
  *	preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
  * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
+ * @IWL_MVM_ESR_EXIT_FAIL_ENTRY: Exit EMLSR due to entry failure
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -382,6 +383,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
 	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
+	IWL_MVM_ESR_EXIT_FAIL_ENTRY	= 0x400000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0b91877592a8..d69556c406a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -159,6 +159,31 @@ static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
 				  iwl_mvm_get_primary_link(vif));
 }
 
+static void iwl_mvm_rx_esr_trans_fail_notif(struct iwl_mvm *mvm,
+					    struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_esr_trans_fail_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+
+	if (IS_ERR_OR_NULL(vif))
+		return;
+
+	IWL_DEBUG_INFO(mvm, "Failed to %s eSR on link %d, reason %d\n",
+		       le32_to_cpu(notif->activation) ? "enter" : "exit",
+		       le32_to_cpu(notif->link_id),
+		       le32_to_cpu(notif->err_code));
+	/* If we couldn't exit EMLSR, the AP may send us data on the link we
+	 * removed so we don't have much choice, just disconnect...
+	 * If we can't enter EMLSR, go back to single link.
+	 */
+	if (le32_to_cpu(notif->activation))
+		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_FAIL_ENTRY,
+				 iwl_mvm_get_primary_link(vif));
+	else
+		iwl_mvm_connection_loss(mvm, vif, "emlsr exit failed");
+}
+
 static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -486,6 +511,10 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
 		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_umac_scan_channel_survey_notif),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, EMLSR_TRANS_FAIL_NOTIF,
+		       iwl_mvm_rx_esr_trans_fail_notif,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		       struct iwl_esr_trans_fail_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -616,6 +645,7 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(STA_DISABLE_TX_CMD),
 	HCMD_NAME(ROC_CMD),
+	HCMD_NAME(EMLSR_TRANS_FAIL_NOTIF),
 	HCMD_NAME(ROC_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_ERROR_NOTIF),
 	HCMD_NAME(MISSED_VAP_NOTIF),
-- 
2.34.1


