Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD172667EA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgIKRzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:55:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50288 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbgIKRzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:55:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6Q-0028eU-6Y; Fri, 11 Sep 2020 20:44:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:39 +0300
Message-Id: <iwlwifi.20200911204056.c915b44ad7dd.I72ef7f9753964555561c27ec503241105eddb14e@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/11] iwlwifi: mvm: add an option to add PASN station
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

A FTM responder may do PASN authentication with unassociated stations
to allow secure ranging. In this case, the driver will add an internal
station and install the TK so the FW will accept protected FTM
request frames from this station and will send a protected FTM
response frame.

In addition, the driver needs to configure the HLTK to the FW so
the FW can derive the secure LTF bits. This is left for a later
patch since it is not yet supported by the FW.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 78 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 49 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +
 6 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 0b6c32098b5a..179bd2bb0a82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -62,6 +62,12 @@
 #include "mvm.h"
 #include "constants.h"
 
+struct iwl_mvm_pasn_sta {
+	struct list_head list;
+	struct iwl_mvm_int_sta int_sta;
+	u8 addr[ETH_ALEN];
+};
+
 static int iwl_mvm_ftm_responder_set_bw_v1(struct cfg80211_chan_def *chandef,
 					   u8 *bw, u8 *ctrl_ch_position)
 {
@@ -207,6 +213,62 @@ iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
 	return iwl_mvm_send_cmd(mvm, &hcmd);
 }
 
+int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
+				      u8 *hltk, u32 hltk_len)
+{
+	int ret;
+	struct iwl_mvm_pasn_sta *sta;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	sta = kmalloc(sizeof(*sta), GFP_KERNEL);
+	if (!sta)
+		return -ENOBUFS;
+
+	ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr, cipher, tk,
+				   tk_len);
+	if (ret) {
+		kfree(sta);
+		return ret;
+	}
+
+	// TODO: set the HLTK to fw
+
+	memcpy(sta->addr, addr, ETH_ALEN);
+	list_add_tail(&sta->list, &mvm->resp_pasn_list);
+	return 0;
+}
+
+static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct iwl_mvm_pasn_sta *sta)
+{
+	list_del(&sta->list);
+	iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+	iwl_mvm_dealloc_int_sta(mvm, &sta->int_sta);
+	kfree(sta);
+}
+
+int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif, u8 *addr)
+{
+	struct iwl_mvm_pasn_sta *sta, *prev;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	list_for_each_entry_safe(sta, prev, &mvm->resp_pasn_list, list) {
+		if (!memcmp(sta->addr, addr, ETH_ALEN)) {
+			iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
+			return 0;
+		}
+	}
+
+	IWL_ERR(mvm, "FTM: PASN station %pM not found\n", addr);
+	return -EINVAL;
+}
+
 int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -255,12 +317,24 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return ret;
 }
 
+void iwl_mvm_ftm_responder_clear(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_pasn_sta *sta, *prev;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	list_for_each_entry_safe(sta, prev, &mvm->resp_pasn_list, list)
+		iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
+}
+
 void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
 {
 	if (!vif->bss_conf.ftm_responder)
 		return;
 
+	iwl_mvm_ftm_responder_clear(mvm, vif);
 	iwl_mvm_ftm_start_responder(mvm, vif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f9b261e36f2d..12f217f2d7b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2633,6 +2633,8 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 
 	iwl_mvm_update_quotas(mvm, false, NULL);
 
+	iwl_mvm_ftm_responder_clear(mvm, vif);
+
 	/*
 	 * This is not very nice, but the simplest:
 	 * For older FWs removing the mcast sta before the bcast station may
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e2f7f6ec711e..f39be84aa279 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1115,6 +1115,8 @@ struct iwl_mvm {
 		int responses[IWL_MVM_TOF_MAX_APS];
 	} ftm_initiator;
 
+	struct list_head resp_pasn_list;
+
 	struct {
 		u8 d0i3_resp;
 	} cmd_ver;
@@ -1996,6 +1998,14 @@ void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif);
 void iwl_mvm_ftm_responder_stats(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
+int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif, u8 *addr);
+int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
+				      u8 *hltk, u32 hltk_len);
+void iwl_mvm_ftm_responder_clear(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif);
 
 /* FTM initiator */
 void iwl_mvm_ftm_restart(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d095ff847be9..e184a163946a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -695,6 +695,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_LIST_HEAD(&mvm->async_handlers_list);
 	spin_lock_init(&mvm->time_event_lock);
 	INIT_LIST_HEAD(&mvm->ftm_initiator.loc_list);
+	INIT_LIST_HEAD(&mvm->resp_pasn_list);
 
 	INIT_WORK(&mvm->async_handlers_wk, iwl_mvm_async_handlers_wk);
 	INIT_WORK(&mvm->roc_done_wk, iwl_mvm_roc_done_wk);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index fc45ef4f6951..827e80ff5aa6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1997,7 +1997,7 @@ static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
 }
 
 static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
-					  int maccolor,
+					  int maccolor, u8 *addr,
 					  struct iwl_mvm_int_sta *sta,
 					  u16 *queue, int fifo)
 {
@@ -2007,7 +2007,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 	if (!iwl_mvm_has_new_tx_api(mvm))
 		iwl_mvm_enable_aux_snif_queue(mvm, *queue, sta->sta_id, fifo);
 
-	ret = iwl_mvm_add_int_sta_common(mvm, sta, NULL, macidx, maccolor);
+	ret = iwl_mvm_add_int_sta_common(mvm, sta, addr, macidx, maccolor);
 	if (ret) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			iwl_mvm_disable_txq(mvm, NULL, *queue,
@@ -2047,7 +2047,7 @@ int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_add_int_sta_with_queue(mvm, MAC_INDEX_AUX, 0,
+	ret = iwl_mvm_add_int_sta_with_queue(mvm, MAC_INDEX_AUX, 0, NULL,
 					     &mvm->aux_sta, &mvm->aux_queue,
 					     IWL_MVM_TX_FIFO_MCAST);
 	if (ret) {
@@ -2065,7 +2065,8 @@ int iwl_mvm_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	lockdep_assert_held(&mvm->mutex);
 
 	return iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id, mvmvif->color,
-					      &mvm->snif_sta, &mvm->snif_queue,
+					      NULL, &mvm->snif_sta,
+					      &mvm->snif_queue,
 					      IWL_MVM_TX_FIFO_BE);
 }
 
@@ -3903,3 +3904,43 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 
 	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
 }
+
+int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
+			 u8 *key, u32 key_len)
+{
+	int ret;
+	u16 queue;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_key_conf *keyconf;
+
+	ret = iwl_mvm_allocate_int_sta(mvm, sta, 0,
+				       NL80211_IFTYPE_UNSPECIFIED,
+				       IWL_STA_LINK);
+	if (ret)
+		return ret;
+
+	ret = iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id, mvmvif->color,
+					     addr, sta, &queue,
+					     IWL_MVM_TX_FIFO_BE);
+	if (ret)
+		goto out;
+
+	keyconf = kzalloc(sizeof(*keyconf) + key_len, GFP_KERNEL);
+	if (!keyconf) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	keyconf->cipher = cipher;
+	memcpy(keyconf->key, key, key_len);
+	keyconf->keylen = key_len;
+
+	ret = iwl_mvm_send_sta_key(mvm, sta->sta_id, keyconf, false,
+				   0, NULL, 0, 0, true);
+	kfree(keyconf);
+	return 0;
+out:
+	iwl_mvm_dealloc_int_sta(mvm, sta);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index da2d1ac01229..55dd2fb0a779 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -579,5 +579,8 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 				       bool disable);
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
+int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
+			 u8 *key, u32 key_len);
 
 #endif /* __sta_h__ */
-- 
2.28.0

