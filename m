Return-Path: <linux-wireless+bounces-4543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2DA877AF2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3ED1C20D5A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69814A96;
	Mon, 11 Mar 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgXSnjqd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124C1428F
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138532; cv=none; b=FgGQD0I/8pcoCJ4/oplG5+vNmSjPyz4Tx76JdNk0EA2fqn6NzxfGOya7P0QxF3dY0F2ujpaDFngFEvV17ALIG0LswnViFLFH4HunOmf+mWQlPPJdWEN+rTUzXO3Y0s9z10JLC9OShYYSBKRTnBmROq6jTF1tgLA0Yv1xmnwD9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138532; c=relaxed/simple;
	bh=Rf5BpwF1xL4GFJeiz3F8A+hforaprU1Ck5U3u69cdco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9v2PaH7ZDDFLVsHRiUCUAbXGbpJCuZQZaF8LGagNI9iqGfz63ORZXzeKx6hX+mQsMVwzAy2dfts+AD6f6zA/x8CDuDub2yyhSeHEpKB5uLBMl1pkJwHdNHMvbP4Grw9S1HTqtWBoqdNb/JW5HoKFbY8mAACCTLitWDI+JLlf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgXSnjqd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138531; x=1741674531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rf5BpwF1xL4GFJeiz3F8A+hforaprU1Ck5U3u69cdco=;
  b=YgXSnjqdwWT30Zp4XxGuCbxpENPi3CAdEBA6x4kgan1z7UwMuvL+3ZdD
   Dj+CMhsj6s1OCyHhBECHG/pywOQcYZzbX+3pEkZKLtjjNod5ra9L8aY8B
   1RbMYOZLzEmmtDhYGVnP4mdoYfls4mZYbcFTT/dklWpJ/w4O3CKzzHK45
   eAyKHdW54EDT6QWJlBPLcfuS+uUpVqqOTednY9bqXUoqAj3twZL8s9NaC
   nJthvR8X/90//6A2wmqSjsYh7JTZmGpKKPwfx+/ADYhEGVv28m5OjbfPp
   w0ZPkSL/J1SzHkVsNbf0pbryW5nZqZJmZuPu+NBeJqrHhCHgGF/WeaSVM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226793"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226793"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657719"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET_CSA
Date: Mon, 11 Mar 2024 08:28:11 +0200
Message-Id: <20240311081938.fa75403b5eaa.Ie3ff02215f810fcfefd6a22c481567f94f61c0c6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware has handled quiet in CSA for a long time now, but
it didn't really matter much. However, now with quiet CSA on a
perhaps secondary link, we don't want mac80211 to stop queues,
we can continue using a link that's not requiring quiet. Set
the feature flag for MLO-capable devices indicating that we'll
handle the quiet entirely in the driver/device.

However, the firmware doesn't handle quiet in AP mode since we
don't really expect to really be needing that (without radar
detection), but - even for testing - make that work properly
by simply not pulling from TXQs in this scenario.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 58 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 ++-
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5f8a53a77290..bea40de36b7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -359,8 +359,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	/* Set this early since we need to have it for the check below */
 	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
-	    !iwlwifi_mod_params.disable_11be)
+	    !iwlwifi_mod_params.disable_11be) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+		/* we handle this already earlier, but need it for MLO */
+		ieee80211_hw_set(hw, HANDLES_QUIET_CSA);
+	}
 
 	/* With MLD FW API, it tracks timing by itself,
 	 * no need for any timing from the host
@@ -903,6 +906,8 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 					&mvmtxq->state) &&
 			      !test_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT,
 					&mvmtxq->state) &&
+			      !test_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA,
+					&mvmtxq->state) &&
 			      !test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))) {
 			skb = ieee80211_tx_dequeue(hw, txq);
 
@@ -1421,6 +1426,20 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
+static void iwl_mvm_post_csa_tx(void *data, struct ieee80211_sta *sta)
+{
+	struct ieee80211_hw *hw = data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct iwl_mvm_txq *mvmtxq =
+			iwl_mvm_txq_from_mac80211(sta->txq[i]);
+
+		clear_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
+		iwl_mvm_mac_itxq_xmit(hw, sta->txq[i]);
+	}
+}
+
 int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *link_conf)
@@ -1459,6 +1478,18 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 
 			iwl_mvm_stop_session_protection(mvm, vif);
 		}
+	} else if (vif->type == NL80211_IFTYPE_AP && mvmvif->csa_blocks_tx) {
+		struct iwl_mvm_txq *mvmtxq =
+			iwl_mvm_txq_from_mac80211(vif->txq);
+
+		clear_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
+
+		local_bh_disable();
+		iwl_mvm_mac_itxq_xmit(hw, vif->txq);
+		ieee80211_iterate_stations_atomic(hw, iwl_mvm_post_csa_tx, hw);
+		local_bh_enable();
+
+		mvmvif->csa_blocks_tx = false;
 	}
 
 	mvmvif->ps_disabled = false;
@@ -5421,6 +5452,18 @@ static int iwl_mvm_old_pre_chan_sw_sta(struct iwl_mvm *mvm,
 	return 0;
 }
 
+static void iwl_mvm_csa_block_txqs(void *data, struct ieee80211_sta *sta)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct iwl_mvm_txq *mvmtxq =
+			iwl_mvm_txq_from_mac80211(sta->txq[i]);
+
+		set_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
+	}
+}
+
 #define IWL_MAX_CSA_BLOCK_TX 1500
 int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
@@ -5429,6 +5472,7 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_vif *csa_vif;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_txq *mvmtxq;
 	int ret;
 
 	mutex_lock(&mvm->mutex);
@@ -5471,6 +5515,18 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		mvmvif->csa_target_freq = chsw->chandef.chan->center_freq;
 
+		if (!chsw->block_tx)
+			break;
+		/* don't need blocking in driver otherwise - mac80211 will do */
+		if (!ieee80211_hw_check(mvm->hw, HANDLES_QUIET_CSA))
+			break;
+
+		mvmvif->csa_blocks_tx = true;
+		mvmtxq = iwl_mvm_txq_from_mac80211(vif->txq);
+		set_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
+		ieee80211_iterate_stations_atomic(mvm->hw,
+						  iwl_mvm_csa_block_txqs,
+						  NULL);
 		break;
 	case NL80211_IFTYPE_STATION:
 		mvmvif->csa_blocks_tx = chsw->block_tx;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ffc8f20700d6..d58cd7d41fe1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -759,9 +759,10 @@ struct iwl_mvm_txq {
 	struct list_head list;
 	u16 txq_id;
 	atomic_t tx_request;
-#define IWL_MVM_TXQ_STATE_STOP_FULL	0
-#define IWL_MVM_TXQ_STATE_STOP_REDIRECT	1
-#define IWL_MVM_TXQ_STATE_READY		2
+#define IWL_MVM_TXQ_STATE_READY		0
+#define IWL_MVM_TXQ_STATE_STOP_FULL	1
+#define IWL_MVM_TXQ_STATE_STOP_REDIRECT	2
+#define IWL_MVM_TXQ_STATE_STOP_AP_CSA	3
 	unsigned long state;
 };
 
-- 
2.34.1


