Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3071B79E754
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjIML5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjIML52 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC561996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606245; x=1726142245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3IbK+NHECKuiCqmsqBlma+RcigcZLxmypRF41ZalybI=;
  b=MOasZ0Awb3pdyQgbVGktKANarp1h0LlbTxdcJRI7XjrzFf2QMa9JghOn
   cs5msO82Y3zVvUr6xgjzKzcdTGi0TQ+Cz2BANjL/SuG2wmeWVS+n80KIK
   vRZnQpRKTHG5WAJeMjoGlRCKz/9ZwzZCJDq71/Myav+wNzvq/uyd2hk4e
   6FXnBXVh3vXOj/y/cTf8jBVTf/bUFaLdlmZ7lHOHWsJselUtW8brpIAxk
   qty55BMAH9Dd763CKbZxP1pNxGp9xK0AIKxbYgnZ7L3a1/fhTqXr5cZ4h
   pPFyoqZZc4qeRynuMZCnRk9LMsw0+aWwzmrT783Ggohp2EqsdMWKAXqyg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903048"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903048"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470952"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470952"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: make "pldr_sync" mode effective
Date:   Wed, 13 Sep 2023 14:56:43 +0300
Message-Id: <20230913145231.45a94d480e56.Id9277f1df6a63ab0dfca0d0c0f448c759e1b8e73@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the device initialized with ME active, this would indeed
work, since the NVM information would be obtained from ME.
However, in the much more likely case that ME isn't active
and the firmware takes actions requiring the sync, this was
not working correctly when the firmware is only run at init
to obtain NVM data, since mac80211 isn't even initialized.

Fix this by moving the 'pldr_sync' handling to a different
place.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 +++++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 +----------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f682c9067abb..567b02754a43 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -583,6 +583,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	static const u16 init_complete[] = {
 		INIT_COMPLETE_NOTIF,
 	};
+	u32 sb_cfg;
 	int ret;
 
 	if (mvm->trans->cfg->tx_with_siso_diversity)
@@ -592,6 +593,12 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 
 	mvm->rfkill_safe_init_done = false;
 
+	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
+	/* if needed, we'll reset this on our way out later */
+	mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
+	if (mvm->pldr_sync && iwl_mei_pldr_req())
+		return -EBUSY;
+
 	iwl_init_notification_wait(&mvm->notif_wait,
 				   &init_wait,
 				   init_complete,
@@ -605,6 +612,13 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+
+		/* if we needed reset then fail here, but notify and remove */
+		if (mvm->pldr_sync) {
+			iwl_mei_alive_notif(false);
+			iwl_trans_pcie_remove(mvm->trans, true);
+		}
+
 		goto error;
 	}
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
@@ -1502,7 +1516,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	struct ieee80211_channel *chan;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_supported_band *sband = NULL;
-	u32 sb_cfg;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1510,11 +1523,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
-	mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
-	if (mvm->pldr_sync && iwl_mei_pldr_req())
-		return -EBUSY;
-
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a4ac178d76b3..93223f8c07b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1169,18 +1169,8 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 
 	for (retry = 0; retry <= max_retry; retry++) {
 		ret = __iwl_mvm_mac_start(mvm);
-		if (!ret)
-			break;
-
-		/*
-		 * In PLDR sync PCI re-enumeration is needed. no point to retry
-		 * mac start before that.
-		 */
-		if (mvm->pldr_sync) {
-			iwl_mei_alive_notif(false);
-			iwl_trans_pcie_remove(mvm->trans, true);
+		if (!ret || mvm->pldr_sync)
 			break;
-		}
 
 		IWL_ERR(mvm, "mac start retry %d\n", retry);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d4983abd9f97..1c21a313f8f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -790,6 +790,9 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 	if (ret)
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
 
+	/* no longer need this regardless of failure or not */
+	mvm->pldr_sync = false;
+
 	return ret;
 }
 
-- 
2.38.1

