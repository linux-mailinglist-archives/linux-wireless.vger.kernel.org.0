Return-Path: <linux-wireless+bounces-8550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AA8FCA2A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ABC285E42
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC5194132;
	Wed,  5 Jun 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8ushLUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1019306C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586244; cv=none; b=LpVMmK+L23Yejizgl7GfQcX6xUNhDQfU1PZUy181YrRGA0QbzWIUMTaHOnDqz9eBiGrVUwd4p5NJgYmpPGp6eitR6JijmyVjatww51V5y+3BaGsiwYKrMfxgAlBuyq8kTjT5EoAlGyq1onAhpiDBVgvhB/KByNp8r35CYjYb7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586244; c=relaxed/simple;
	bh=oqs8DQ9zpniAk7C9rCPfB2RgXLx/iPT/OXGpGu0g8DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlZE/2elR2dEIXeU6qglbLR0bxUSDTKZ74B2fFFaB7SwZ6c5sxCH3JhJUQHttWqJk/RszJKNkdY1rE/BuBrV8agXKICm3m5jah0x0osPy0rx8kEsWh877oKtP9Qwbr6e2bSja6aV6nupQs5dpnfVgrKG+e3MjDjX4c54oiHEy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8ushLUq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586242; x=1749122242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqs8DQ9zpniAk7C9rCPfB2RgXLx/iPT/OXGpGu0g8DM=;
  b=T8ushLUqjtJfEhenpj1HSknNCKzF9HX1MrYUMDIZEzBmta8Rdh42g70v
   qON8fsfsysPaFX2e3+rR0tSgOaLE4IvwbpTVO0+hHWEdOoQ7313XxYkQ2
   TDqNlz2B/XOeff00jqytYbEWoXlbarTxi4WyKrcBJnvwjmIKKpz4J4o7I
   t+kRiwsrYnyoFzKfcksyF7xMCUZ402m18pFwfzW/Fmbri/0L2deODhrvf
   It4nnundN5RjsGnMN+eAMdnCF1pAsbBMJAs44ysp8GgNiz/qoBOrhIfsh
   wfdqfEbpMlXAzXZPsSHkJqthMBUdX5N+SB6Zi3IsZLsB8exCxHKD5pUc+
   g==;
X-CSE-ConnectionGUID: mPYyy51uQmasQE7MuJcWVw==
X-CSE-MsgGUID: S0XthvZKTpK9rnfoOszCMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36718038"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36718038"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:48 -0700
X-CSE-ConnectionGUID: /1EcKUgzSimntUTwmPCeyg==
X-CSE-MsgGUID: DO6JjO29RauLHrMPsbBRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37433755"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] wifi: iwlwifi: mvm: separate non-BSS/ROC EMLSR blocking
Date: Wed,  5 Jun 2024 14:07:36 +0300
Message-Id: <20240605140556.461fcf7b95bb.Id0d21dcb739d426ff15ec068b5df8abaab58884d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
References: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If non-BSS and remain-on-channel (ROC) blocking were to occur
simultaneously, they'd step on each other's toes, unblocking
when not yet supported. Disentangle these bits, and ROC doesn't
need to use the non_bss_link() function then.

Fixes: a1efeb823084 ("wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 10 +++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c |  5 +++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a2a0409672c3..d2b97e30d9eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4787,6 +4787,7 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       const struct iwl_mvm_roc_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
 	u32 lmac_id;
 	int ret;
 
@@ -4799,9 +4800,12 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 */
 	flush_work(&mvm->roc_done_wk);
 
-	ret = iwl_mvm_esr_non_bss_link(mvm, vif, 0, true);
-	if (ret)
-		return ret;
+	if (!IS_ERR_OR_NULL(bss_vif)) {
+		ret = iwl_mvm_block_esr_sync(mvm, bss_vif,
+					     IWL_MVM_ESR_BLOCKED_ROC);
+		if (ret)
+			return ret;
+	}
 
 	guard(mvm)(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 82080d920d59..cb227dca4f87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -361,7 +361,9 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_BLOCKED_TPT: block EMLSR when there is not enough traffic
  * @IWL_MVM_ESR_BLOCKED_FW: FW didn't recommended/forced exit from EMLSR
- * @IWL_MVM_ESR_BLOCKED_NON_BSS: An active non-bssid link's preventing EMLSR
+ * @IWL_MVM_ESR_BLOCKED_NON_BSS: An active non-BSS interface's link is
+ *	preventing EMLSR
+ * @IWL_MVM_ESR_BLOCKED_ROC: remain-on-channel is preventing EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
@@ -378,6 +380,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_TPT		= 0x4,
 	IWL_MVM_ESR_BLOCKED_FW		= 0x8,
 	IWL_MVM_ESR_BLOCKED_NON_BSS	= 0x10,
+	IWL_MVM_ESR_BLOCKED_ROC		= 0x20,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 31bc80cdcb7d..c0322349bfcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -47,6 +47,7 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 
 static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 {
+	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
 	struct ieee80211_vif *vif = mvm->p2p_device_vif;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -119,9 +120,9 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
+	if (vif && !IS_ERR_OR_NULL(bss_vif))
+		iwl_mvm_unblock_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_ROC);
 	mutex_unlock(&mvm->mutex);
-	if (vif)
-		iwl_mvm_esr_non_bss_link(mvm, vif, 0, false);
 }
 
 void iwl_mvm_roc_done_wk(struct work_struct *wk)
-- 
2.34.1


