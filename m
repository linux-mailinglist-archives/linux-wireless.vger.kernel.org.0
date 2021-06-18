Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859163AC951
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFRLF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:05:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48268 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRLF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:05:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBxB-001YXx-IS; Fri, 18 Jun 2021 13:42:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:55 +0300
Message-Id: <iwlwifi.20210618133832.5d94e78f6230.I6dc979606b6f28701b740d7aab725f7853a5a155@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 30/31] mac80211: notify driver on mgd TX completion
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have mgd_prepare_tx(), but sometimes drivers may want/need
to take action when the exchange finishes, whether successfully
or not.

Add a notification to the driver on completion, i.e. call the
new method mgd_complete_tx().

To unify the two scenarios, and to add more information, make
both of them take a struct that has the duration (prepare only),
subtype (both) and success (complete only).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/ath/ath9k/main.c         |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 include/net/mac80211.h                        | 28 +++++++-
 net/mac80211/driver-ops.h                     | 26 +++++--
 net/mac80211/mlme.c                           | 71 ++++++++++++++-----
 net/mac80211/trace.h                          | 33 +++++++--
 7 files changed, 133 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 45f6402478b5..85d6d47bdece 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2649,7 +2649,7 @@ static void ath9k_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void ath9k_mgd_prepare_tx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 u16 duration)
+				 struct ieee80211_prep_tx_info *info)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 607d5d564928..cc78f306ac1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3306,14 +3306,14 @@ static int iwl_mvm_mac_conf_tx(struct ieee80211_hw *hw,
 
 static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
-				       u16 req_duration)
+				       struct ieee80211_prep_tx_info *info)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
 	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
 
-	if (req_duration > duration)
-		duration = req_duration;
+	if (info->duration > duration)
+		duration = info->duration;
 
 	mutex_lock(&mvm->mutex);
 	/* Try really hard to protect the session and hear a beacon
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 333df6b38113..d8718b253f0b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -629,7 +629,7 @@ static void rtw_ops_sw_scan_complete(struct ieee80211_hw *hw,
 
 static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
-				   u16 duration)
+				   struct ieee80211_prep_tx_info *info)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c575240b02c8..78dde1846dab 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3346,6 +3346,21 @@ enum ieee80211_reconfig_type {
 	IEEE80211_RECONFIG_TYPE_SUSPEND,
 };
 
+/**
+ * struct ieee80211_prep_tx_info - prepare TX information
+ * @duration: if non-zero, hint about the required duration,
+ *	only used with the mgd_prepare_tx() method.
+ * @subtype: frame subtype (auth, (re)assoc, deauth, disassoc)
+ * @success: whether the frame exchange was successful, only
+ *	used with the mgd_complete_tx() method, and then only
+ *	valid for auth and (re)assoc.
+ */
+struct ieee80211_prep_tx_info {
+	u16 duration;
+	u16 subtype;
+	u8 success:1;
+};
+
 /**
  * struct ieee80211_ops - callbacks from mac80211 to the driver
  *
@@ -3758,9 +3773,13 @@ enum ieee80211_reconfig_type {
  *	frame in case that no beacon was heard from the AP/P2P GO.
  *	The callback will be called before each transmission and upon return
  *	mac80211 will transmit the frame right away.
- *      If duration is greater than zero, mac80211 hints to the driver the
- *      duration for which the operation is requested.
+ *	Additional information is passed in the &struct ieee80211_prep_tx_info
+ *	data. If duration there is greater than zero, mac80211 hints to the
+ *	driver the duration for which the operation is requested.
  *	The callback is optional and can (should!) sleep.
+ * @mgd_complete_tx: Notify the driver that the response frame for a previously
+ *	transmitted frame announced with @mgd_prepare_tx was received, the data
+ *	is filled similarly to @mgd_prepare_tx though the duration is not used.
  *
  * @mgd_protect_tdls_discover: Protect a TDLS discovery session. After sending
  *	a TDLS discovery-request, we expect a reply to arrive on the AP's
@@ -4111,7 +4130,10 @@ struct ieee80211_ops {
 
 	void	(*mgd_prepare_tx)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
-				  u16 duration);
+				  struct ieee80211_prep_tx_info *info);
+	void	(*mgd_complete_tx)(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_prep_tx_info *info);
 
 	void	(*mgd_protect_tdls_discover)(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 604ca59937f0..bcb7cc06db3d 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2019 Intel Corporation
+* Copyright (C) 2018 - 2019, 2021 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -821,7 +821,7 @@ drv_allow_buffered_frames(struct ieee80211_local *local,
 
 static inline void drv_mgd_prepare_tx(struct ieee80211_local *local,
 				      struct ieee80211_sub_if_data *sdata,
-				      u16 duration)
+				      struct ieee80211_prep_tx_info *info)
 {
 	might_sleep();
 
@@ -829,9 +829,27 @@ static inline void drv_mgd_prepare_tx(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
-	trace_drv_mgd_prepare_tx(local, sdata, duration);
+	trace_drv_mgd_prepare_tx(local, sdata, info->duration,
+				 info->subtype, info->success);
 	if (local->ops->mgd_prepare_tx)
-		local->ops->mgd_prepare_tx(&local->hw, &sdata->vif, duration);
+		local->ops->mgd_prepare_tx(&local->hw, &sdata->vif, info);
+	trace_drv_return_void(local);
+}
+
+static inline void drv_mgd_complete_tx(struct ieee80211_local *local,
+				       struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_prep_tx_info *info)
+{
+	might_sleep();
+
+	if (!check_sdata_in_driver(sdata))
+		return;
+	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
+
+	trace_drv_mgd_complete_tx(local, sdata, info->duration,
+				  info->subtype, info->success);
+	if (local->ops->mgd_complete_tx)
+		local->ops->mgd_complete_tx(&local->hw, &sdata->vif, info);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9af6fac56429..6b1020ca728d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -683,6 +683,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct element *ext_capa = NULL;
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
 	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_prep_tx_info info = {};
 
 	/* we know it's writable, cast away the const */
 	if (assoc_data->ie_len)
@@ -784,12 +785,14 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		mgmt->u.reassoc_req.listen_interval = listen_int;
 		memcpy(mgmt->u.reassoc_req.current_ap, assoc_data->prev_bssid,
 		       ETH_ALEN);
+		info.subtype = IEEE80211_STYPE_REASSOC_REQ;
 	} else {
 		skb_put(skb, 4);
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ASSOC_REQ);
 		mgmt->u.assoc_req.capab_info = cpu_to_le16(capab);
 		mgmt->u.assoc_req.listen_interval = listen_int;
+		info.subtype = IEEE80211_STYPE_ASSOC_REQ;
 	}
 
 	/* SSID */
@@ -1037,7 +1040,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	ifmgd->assoc_req_ies = kmemdup(ie_start, pos - ie_start, GFP_ATOMIC);
 	ifmgd->assoc_req_ies_len = pos - ie_start;
 
-	drv_mgd_prepare_tx(local, sdata, 0);
+	drv_mgd_prepare_tx(local, sdata, &info);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
@@ -2265,6 +2268,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 	u32 changed = 0;
+	struct ieee80211_prep_tx_info info = {
+		.subtype = stype,
+	};
 
 	sdata_assert_lock(sdata);
 
@@ -2314,8 +2320,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		 * driver requested so.
 		 */
 		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
-		    !ifmgd->have_beacon)
-			drv_mgd_prepare_tx(sdata->local, sdata, 0);
+		    !ifmgd->have_beacon) {
+			drv_mgd_prepare_tx(sdata->local, sdata, &info);
+		}
 
 		ieee80211_send_deauth_disassoc(sdata, ifmgd->bssid,
 					       ifmgd->bssid, stype, reason,
@@ -2326,6 +2333,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
+	drv_mgd_complete_tx(sdata->local, sdata, &info);
+
 	/* clear bssid only after building the needed mgmt frames */
 	eth_zero_addr(ifmgd->bssid);
 
@@ -2876,6 +2885,9 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 	u8 *pos;
 	struct ieee802_11_elems elems;
 	u32 tx_flags = 0;
+	struct ieee80211_prep_tx_info info = {
+		.subtype = IEEE80211_STYPE_AUTH,
+	};
 
 	pos = mgmt->u.auth.variable;
 	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, &elems,
@@ -2883,7 +2895,7 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 	if (!elems.challenge)
 		return;
 	auth_data->expected_transaction = 4;
-	drv_mgd_prepare_tx(sdata->local, sdata, 0);
+	drv_mgd_prepare_tx(sdata->local, sdata, &info);
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 		tx_flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
 			   IEEE80211_TX_INTFL_MLME_CONN_TX;
@@ -2936,6 +2948,9 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		.type = MLME_EVENT,
 		.u.mlme.data = AUTH_EVENT,
 	};
+	struct ieee80211_prep_tx_info info = {
+		.subtype = IEEE80211_STYPE_AUTH,
+	};
 
 	sdata_assert_lock(sdata);
 
@@ -2964,7 +2979,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 			   mgmt->sa, auth_alg, ifmgd->auth_data->algorithm,
 			   auth_transaction,
 			   ifmgd->auth_data->expected_transaction);
-		return;
+		goto notify_driver;
 	}
 
 	if (status_code != WLAN_STATUS_SUCCESS) {
@@ -2975,7 +2990,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		     (auth_transaction == 1 &&
 		      (status_code == WLAN_STATUS_SAE_HASH_TO_ELEMENT ||
 		       status_code == WLAN_STATUS_SAE_PK))))
-			return;
+			goto notify_driver;
 
 		sdata_info(sdata, "%pM denied authentication (status %d)\n",
 			   mgmt->sa, status_code);
@@ -2983,7 +2998,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.status = MLME_DENIED;
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
-		return;
+		goto notify_driver;
 	}
 
 	switch (ifmgd->auth_data->algorithm) {
@@ -3005,10 +3020,11 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	default:
 		WARN_ONCE(1, "invalid auth alg %d",
 			  ifmgd->auth_data->algorithm);
-		return;
+		goto notify_driver;
 	}
 
 	event.u.mlme.status = MLME_SUCCESS;
+	info.success = 1;
 	drv_event_callback(sdata->local, sdata, &event);
 	if (ifmgd->auth_data->algorithm != WLAN_AUTH_SAE ||
 	    (auth_transaction == 2 &&
@@ -3022,6 +3038,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
+notify_driver:
+	drv_mgd_complete_tx(sdata->local, sdata, &info);
 }
 
 #define case_WLAN(type) \
@@ -3643,6 +3661,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.type = MLME_EVENT,
 		.u.mlme.data = ASSOC_EVENT,
 	};
+	struct ieee80211_prep_tx_info info = {};
 
 	sdata_assert_lock(sdata);
 
@@ -3672,6 +3691,15 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		aid = 0; /* TODO */
 	}
 
+	/*
+	 * Note: this may not be perfect, AP might misbehave - if
+	 * anyone needs to rely on perfect complete notification
+	 * with the exact right subtype, then we need to track what
+	 * we actually transmitted.
+	 */
+	info.subtype = reassoc ? IEEE80211_STYPE_REASSOC_REQ :
+				 IEEE80211_STYPE_ASSOC_REQ;
+
 	sdata_info(sdata,
 		   "RX %sssocResp from %pM (capab=0x%x status=%d aid=%d)\n",
 		   reassoc ? "Rea" : "A", mgmt->sa,
@@ -3697,7 +3725,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		assoc_data->timeout_started = true;
 		if (ms > IEEE80211_ASSOC_TIMEOUT)
 			run_again(sdata, assoc_data->timeout);
-		return;
+		goto notify_driver;
 	}
 
 	if (status_code != WLAN_STATUS_SUCCESS) {
@@ -3712,7 +3740,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 			/* oops -- internal error -- send timeout for now */
 			ieee80211_destroy_assoc_data(sdata, false, false);
 			cfg80211_assoc_timeout(sdata->dev, cbss);
-			return;
+			goto notify_driver;
 		}
 		event.u.mlme.status = MLME_SUCCESS;
 		drv_event_callback(sdata->local, sdata, &event);
@@ -3730,10 +3758,14 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 			if (sdata->tx_conf[ac].uapsd)
 				uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
+
+		info.success = 1;
 	}
 
 	cfg80211_rx_assoc_resp(sdata->dev, cbss, (u8 *)mgmt, len, uapsd_queues,
 			       ifmgd->assoc_req_ies, ifmgd->assoc_req_ies_len);
+notify_driver:
+	drv_mgd_complete_tx(sdata->local, sdata, &info);
 }
 
 static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
@@ -4352,7 +4384,9 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	u32 tx_flags = 0;
 	u16 trans = 1;
 	u16 status = 0;
-	u16 prepare_tx_duration = 0;
+	struct ieee80211_prep_tx_info info = {
+		.subtype = IEEE80211_STYPE_AUTH,
+	};
 
 	sdata_assert_lock(sdata);
 
@@ -4375,10 +4409,9 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	}
 
 	if (auth_data->algorithm == WLAN_AUTH_SAE)
-		prepare_tx_duration =
-			jiffies_to_msecs(IEEE80211_AUTH_TIMEOUT_SAE);
+		info.duration = jiffies_to_msecs(IEEE80211_AUTH_TIMEOUT_SAE);
 
-	drv_mgd_prepare_tx(local, sdata, prepare_tx_duration);
+	drv_mgd_prepare_tx(local, sdata, &info);
 
 	sdata_info(sdata, "send auth to %pM (try %d/%d)\n",
 		   auth_data->bss->bssid, auth_data->tries,
@@ -5801,6 +5834,9 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 	bool tx = !req->local_state_change;
+	struct ieee80211_prep_tx_info info = {
+		.subtype = IEEE80211_STYPE_DEAUTH,
+	};
 
 	if (ifmgd->auth_data &&
 	    ether_addr_equal(ifmgd->auth_data->bss->bssid, req->bssid)) {
@@ -5809,7 +5845,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
-		drv_mgd_prepare_tx(sdata->local, sdata, 0);
+		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
 					       req->reason_code, tx,
@@ -5818,7 +5854,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
@@ -5829,7 +5865,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
-		drv_mgd_prepare_tx(sdata->local, sdata, 0);
+		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
 					       req->reason_code, tx,
@@ -5838,6 +5874,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 8fcc39056402..f6ef15366938 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016-2017 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2020 Intel Corporation
+* Copyright (C) 2018 - 2021 Intel Corporation
 */
 
 #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -1461,31 +1461,52 @@ DEFINE_EVENT(release_evt, drv_allow_buffered_frames,
 	TP_ARGS(local, sta, tids, num_frames, reason, more_data)
 );
 
-TRACE_EVENT(drv_mgd_prepare_tx,
+DECLARE_EVENT_CLASS(mgd_prepare_complete_tx_evt,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 u16 duration),
+		 u16 duration, u16 subtype, bool success),
 
-	TP_ARGS(local, sdata, duration),
+	TP_ARGS(local, sdata, duration, subtype, success),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
 		__field(u32, duration)
+		__field(u16, subtype)
+		__field(u8, success)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->duration = duration;
+		__entry->subtype = subtype;
+		__entry->success = success;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " duration: %u",
-		LOCAL_PR_ARG, VIF_PR_ARG, __entry->duration
+		LOCAL_PR_FMT VIF_PR_FMT " duration: %u, subtype:0x%x, success:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->duration,
+		__entry->subtype, __entry->success
 	)
 );
 
+DEFINE_EVENT(mgd_prepare_complete_tx_evt, drv_mgd_prepare_tx,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 u16 duration, u16 subtype, bool success),
+
+	TP_ARGS(local, sdata, duration, subtype, success)
+);
+
+DEFINE_EVENT(mgd_prepare_complete_tx_evt, drv_mgd_complete_tx,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 u16 duration, u16 subtype, bool success),
+
+	TP_ARGS(local, sdata, duration, subtype, success)
+);
+
 DEFINE_EVENT(local_sdata_evt, drv_mgd_protect_tdls_discover,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata),
-- 
2.32.0

