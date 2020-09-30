Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9580527E9FE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgI3Nbd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nbc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCf-002MJ5-QK; Wed, 30 Sep 2020 16:31:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:15 +0300
Message-Id: <iwlwifi.20200930161256.28c5f5266000.I2d58b72ff92c47ac33a6aacc27fbf3790b6dfc51@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 04/12] iwlwifi: mvm: initiator: add option for adding a PASN responder
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add an option for adding a PASN responder, specifying the HLTK and
TK (if not associated). When a receiving a range request for a
PASN responder, the driver will ask for a secured measurement with
the specified HLTK and TK.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 177 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 3 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 65dc443f37df..a0ce761d0c59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -83,6 +83,96 @@ struct iwl_mvm_smooth_entry {
 	u64 host_time;
 };
 
+struct iwl_mvm_ftm_pasn_entry {
+	struct list_head list;
+	u8 addr[ETH_ALEN];
+	u8 hltk[HLTK_11AZ_LEN];
+	u8 tk[TK_11AZ_LEN];
+	u8 cipher;
+	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+};
+
+int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
+			     u8 *hltk, u32 hltk_len)
+{
+	struct iwl_mvm_ftm_pasn_entry *pasn = kzalloc(sizeof(*pasn),
+						      GFP_KERNEL);
+	u32 expected_tk_len;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!pasn)
+		return -ENOBUFS;
+
+	pasn->cipher = iwl_mvm_cipher_to_location_cipher(cipher);
+
+	switch (pasn->cipher) {
+	case IWL_LOCATION_CIPHER_CCMP_128:
+	case IWL_LOCATION_CIPHER_GCMP_128:
+		expected_tk_len = WLAN_KEY_LEN_CCMP;
+		break;
+	case IWL_LOCATION_CIPHER_GCMP_256:
+		expected_tk_len = WLAN_KEY_LEN_GCMP_256;
+		break;
+	default:
+		goto out;
+	}
+
+	/*
+	 * If associated to this AP and already have security context,
+	 * the TK is already configured for this station, so it
+	 * shouldn't be set again here.
+	 */
+	if (vif->bss_conf.assoc &&
+	    !memcmp(addr, vif->bss_conf.bssid, ETH_ALEN)) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		struct ieee80211_sta *sta;
+
+		rcu_read_lock();
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->ap_sta_id]);
+		if (!IS_ERR_OR_NULL(sta) && sta->mfp)
+			expected_tk_len = 0;
+		rcu_read_unlock();
+	}
+
+	if (tk_len != expected_tk_len || hltk_len != sizeof(pasn->hltk)) {
+		IWL_ERR(mvm, "Invalid key length: tk_len=%u hltk_len=%u\n",
+			tk_len, hltk_len);
+		goto out;
+	}
+
+	memcpy(pasn->addr, addr, sizeof(pasn->addr));
+	memcpy(pasn->hltk, hltk, sizeof(pasn->hltk));
+
+	if (tk && tk_len)
+		memcpy(pasn->tk, tk, sizeof(pasn->tk));
+
+	list_add_tail(&pasn->list, &mvm->ftm_initiator.pasn_list);
+	return 0;
+out:
+	kfree(pasn);
+	return -EINVAL;
+}
+
+void iwl_mvm_ftm_remove_pasn_sta(struct iwl_mvm *mvm, u8 *addr)
+{
+	struct iwl_mvm_ftm_pasn_entry *entry, *prev;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	list_for_each_entry_safe(entry, prev, &mvm->ftm_initiator.pasn_list,
+				 list) {
+		if (memcmp(entry->addr, addr, sizeof(entry->addr)))
+			continue;
+
+		list_del(&entry->list);
+		kfree(entry);
+		return;
+	}
+}
+
 static void iwl_mvm_ftm_reset(struct iwl_mvm *mvm)
 {
 	struct iwl_mvm_loc_entry *e, *t;
@@ -595,6 +685,63 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
 }
 
+static void iter(struct ieee80211_hw *hw,
+		 struct ieee80211_vif *vif,
+		 struct ieee80211_sta *sta,
+		 struct ieee80211_key_conf *key,
+		 void *data)
+{
+	struct iwl_tof_range_req_ap_entry_v6 *target = data;
+
+	if (!sta || memcmp(sta->addr, target->bssid, ETH_ALEN))
+		return;
+
+	WARN_ON(!sta->mfp);
+
+	if (WARN_ON(key->keylen > sizeof(target->tk)))
+		return;
+
+	memcpy(target->tk, key->key, key->keylen);
+	target->cipher = iwl_mvm_cipher_to_location_cipher(key->cipher);
+	WARN_ON(target->cipher == IWL_LOCATION_CIPHER_INVALID);
+}
+
+static void
+iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct iwl_tof_range_req_ap_entry_v7 *target)
+{
+	struct iwl_mvm_ftm_pasn_entry *entry;
+	u32 flags = le32_to_cpu(target->initiator_ap_flags);
+
+	if (!(flags & (IWL_INITIATOR_AP_FLAGS_NON_TB |
+		       IWL_INITIATOR_AP_FLAGS_TB)))
+		return;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	list_for_each_entry(entry, &mvm->ftm_initiator.pasn_list, list) {
+		if (memcmp(entry->addr, target->bssid, sizeof(entry->addr)))
+			continue;
+
+		target->cipher = entry->cipher;
+		memcpy(target->hltk, entry->hltk, sizeof(target->hltk));
+
+		if (vif->bss_conf.assoc &&
+		    !memcmp(vif->bss_conf.bssid, target->bssid,
+			    sizeof(target->bssid)))
+			ieee80211_iter_keys(mvm->hw, vif, iter, target);
+		else
+			memcpy(target->tk, entry->tk, sizeof(target->tk));
+
+		memcpy(target->rx_pn, entry->rx_pn, sizeof(target->rx_pn));
+		memcpy(target->tx_pn, entry->tx_pn, sizeof(target->tx_pn));
+
+		target->initiator_ap_flags |=
+			cpu_to_le32(IWL_INITIATOR_AP_FLAGS_SECURED);
+		return;
+	}
+}
+
 static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct cfg80211_pmsr_request *req)
@@ -618,6 +765,8 @@ static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
 		err = iwl_mvm_ftm_put_target(mvm, vif, peer, (void *)target);
 		if (err)
 			return err;
+
+		iwl_mvm_ftm_set_secured_ranging(mvm, vif, target);
 	}
 
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
@@ -868,6 +1017,24 @@ static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
 	IWL_DEBUG_INFO(mvm, "\tdistance: %lld\n", rtt_avg);
 }
 
+static void
+iwl_mvm_ftm_pasn_update_pn(struct iwl_mvm *mvm,
+			   struct iwl_tof_range_rsp_ap_entry_ntfy_v6 *fw_ap)
+{
+	struct iwl_mvm_ftm_pasn_entry *entry;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	list_for_each_entry(entry, &mvm->ftm_initiator.pasn_list, list) {
+		if (memcmp(fw_ap->bssid, entry->addr, sizeof(entry->addr)))
+			continue;
+
+		memcpy(entry->rx_pn, fw_ap->rx_pn, sizeof(entry->rx_pn));
+		memcpy(entry->tx_pn, fw_ap->tx_pn, sizeof(entry->tx_pn));
+		return;
+	}
+}
+
 void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
@@ -912,13 +1079,15 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		int peer_idx;
 
 		if (new_api) {
-			if (mvm->cmd_ver.range_resp == 8)
+			if (mvm->cmd_ver.range_resp == 8) {
 				fw_ap = &fw_resp_v8->ap[i];
-			else if (fw_has_api(&mvm->fw->ucode_capa,
-					    IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
+				iwl_mvm_ftm_pasn_update_pn(mvm, fw_ap);
+			} else if (fw_has_api(&mvm->fw->ucode_capa,
+					      IWL_UCODE_TLV_API_FTM_RTT_ACCURACY)) {
 				fw_ap = (void *)&fw_resp_v7->ap[i];
-			else
+			} else {
 				fw_ap = (void *)&fw_resp_v6->ap[i];
+			}
 
 			result.final = fw_ap->last_burst;
 			result.ap_tsf = le32_to_cpu(fw_ap->start_tsf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 40e102f2017f..1836589218fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1110,6 +1110,7 @@ struct iwl_mvm {
 		struct {
 			struct list_head resp;
 		} smooth;
+		struct list_head pasn_list;
 	} ftm_initiator;
 
 	struct list_head resp_pasn_list;
@@ -2016,6 +2017,10 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_ftm_abort(struct iwl_mvm *mvm, struct cfg80211_pmsr_request *req);
 void iwl_mvm_ftm_initiator_smooth_config(struct iwl_mvm *mvm);
 void iwl_mvm_ftm_initiator_smooth_stop(struct iwl_mvm *mvm);
+int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
+			     u8 *hltk, u32 hltk_len);
+void iwl_mvm_ftm_remove_pasn_sta(struct iwl_mvm *mvm, u8 *addr);
 
 /* TDLS */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c59ce3966807..737ef0fd6ff1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -695,6 +695,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_LIST_HEAD(&mvm->async_handlers_list);
 	spin_lock_init(&mvm->time_event_lock);
 	INIT_LIST_HEAD(&mvm->ftm_initiator.loc_list);
+	INIT_LIST_HEAD(&mvm->ftm_initiator.pasn_list);
 	INIT_LIST_HEAD(&mvm->resp_pasn_list);
 
 	INIT_WORK(&mvm->async_handlers_wk, iwl_mvm_async_handlers_wk);
-- 
2.28.0

