Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB887CBEBB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjJQJRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjJQJRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF4B0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534226; x=1729070226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9wN4cvpXoiYZlfHNDWUevkbXccgdtS4kMjPD1n8CJCU=;
  b=S/oKepBTYemWyH2YDTgzJUyAeewUpwk0CQ315rKT7WAhJMSTke9w5bt+
   eIcHDeJ9g/PJrghhAls2yqRRdBprUCDrMFxxroEjRoqxXom2NuJro3xtq
   XwGjKPadQMC3tos2TwfasncVD5QTXi3QuVIPxp/aYmgwMj+NuWtKCHOfp
   CODeo6/YOyH4kPzPL1qekZ/ML95Y8VS3LFf/USLdE+8HLl0+g7S881QFb
   qTPVrjAqJDD/2uYISbAWQbzknJMHn7e79tF1nWMTLTE87hHAxeeJYFTsW
   nJ7WxPmQJxMs/iJO1XJ2ommmuRWVfUbo1lYJw+TAtfqD2n0SKXH/khMlG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808515"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808515"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731796"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731796"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: make time_events MLO aware
Date:   Tue, 17 Oct 2023 12:16:36 +0300
Message-Id: <20231017115047.21496bcacb18.I79d037325b4fae4c12a22d9477e53fc9c537ad46@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As session protection API is moving to be per link instead of per mac,
move the time events to be per link too.

Since there is only one concurrent time event per mac, it feels
unnecessary to have the time_event as a member of iwl_mvm_link_info.
(That way we will have to iterate over all links each time we want to
clear a time event, and also we will need mac80211 to tell us the link
id when mgd_tx_complete() is called.)
So leave this as a member of iwl_mvm_vif, but add the link id to the
time_event structure.

The link id in time_event will only be maintained and used for:
1. When SESSION_PROTECTION_CMD is supported (before it, we don't have MLO)
2. For time_events of types SESSION_PROTECT_CONF_ASSOC,
   SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV, and
   SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION
   (not for aux roc/ Hot Spot time_events).

For P2P, non-MLO connections, and pre-MLD API, deflink id, meaning 0,
will be used

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     |  9 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c |  8 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c   | 10 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.h   |  4 +++-
 6 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ba087c5ba6e1..38ee1629ec4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2462,7 +2462,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   u32 duration_override)
+			   u32 duration_override, unsigned int link_id)
 {
 	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
 	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
@@ -2482,7 +2482,8 @@ void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, 900,
-						    min_duration, false);
+						    min_duration, false,
+						    link_id);
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					min_duration, 500, false);
@@ -2670,7 +2671,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				 * time could be small without us having heard
 				 * a beacon yet.
 				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0);
+				iwl_mvm_protect_assoc(mvm, vif, 0, 0);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
@@ -4009,7 +4010,7 @@ void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_protect_assoc(mvm, vif, info->duration);
+	iwl_mvm_protect_assoc(mvm, vif, info->duration, info->link_id);
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index e5f386ae862d..8402482a74a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -851,6 +851,12 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 			    protect) {
+				/* We are in assoc so only one link is active-
+				 * The association link
+				 */
+				unsigned int link_id =
+					ffs(vif->active_links) - 1;
+
 				/* If we're not restarting and still haven't
 				 * heard a beacon (dtim period unknown) then
 				 * make sure we still have enough minimum time
@@ -860,7 +866,7 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 				 * time could be small without us having heard
 				 * a beacon yet.
 				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0);
+				iwl_mvm_protect_assoc(mvm, vif, 0, link_id);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f81f1ec3bb79..0bd2a8bcaee5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -121,6 +121,7 @@ struct iwl_mvm_time_event_data {
 	 * if the te is in the time event list or not (when id == TE_MAX)
 	 */
 	u32 id;
+	u8 link_id;
 };
 
  /* Power management */
@@ -1956,7 +1957,7 @@ int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif);
 /*Session Protection */
 void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   u32 duration_override);
+			   u32 duration_override, unsigned int link_id);
 
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index fac992af3ddb..e7d5f4ebeb25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -155,7 +155,7 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, duration,
-						    duration, true);
+						    duration, true, link_id);
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					duration, 100, true);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 7ab6cabda9a4..54e57c7ecfc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -42,6 +42,7 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 	te_data->uid = 0;
 	te_data->id = TE_MAX;
 	te_data->vif = NULL;
+	te_data->link_id = -1;
 }
 
 void iwl_mvm_roc_done_wk(struct work_struct *wk)
@@ -951,6 +952,9 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 	/* The time_event_data.id field is reused to save session
 	 * protection's configuration.
 	 */
+
+	mvmvif->time_event_data.link_id = 0;
+
 	switch (type) {
 	case IEEE80211_ROC_TYPE_NORMAL:
 		mvmvif->time_event_data.id =
@@ -1231,7 +1235,8 @@ static bool iwl_mvm_session_prot_notif(struct iwl_notif_wait_data *notif_wait,
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 duration, u32 min_duration,
-					 bool wait_for_notif)
+					 bool wait_for_notif,
+					 unsigned int link_id)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
@@ -1249,7 +1254,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 
 	spin_lock_bh(&mvm->time_event_lock);
-	if (te_data->running &&
+	if (te_data->running && te_data->link_id == link_id &&
 	    time_after(te_data->end_jiffies, TU_TO_EXP_TIME(min_duration))) {
 		IWL_DEBUG_TE(mvm, "We have enough time in the current TE: %u\n",
 			     jiffies_to_msecs(te_data->end_jiffies - jiffies));
@@ -1266,6 +1271,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	te_data->id = le32_to_cpu(cmd.conf_id);
 	te_data->duration = le32_to_cpu(cmd.duration_tu);
 	te_data->vif = vif;
+	te_data->link_id = link_id;
 	spin_unlock_bh(&mvm->time_event_lock);
 
 	IWL_DEBUG_TE(mvm, "Add new session protection, duration %d TU\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index f77df939b6b1..49256ba4cf58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -206,11 +206,13 @@ iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
  * @duration: the requested duration of the protection
  * @min_duration: the minimum duration of the protection
  * @wait_for_notif: if true, will block until the start of the protection
+ * @link_id: The link to schedule a session protection for
  */
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 duration, u32 min_duration,
-					 bool wait_for_notif);
+					 bool wait_for_notif,
+					 unsigned int link_id);
 
 /**
  * iwl_mvm_rx_session_protect_notif - handles %SESSION_PROTECTION_NOTIF
-- 
2.38.1

