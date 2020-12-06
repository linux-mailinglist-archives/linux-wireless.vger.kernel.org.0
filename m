Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E1F2D04F9
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgLFMzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34910 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727957AbgLFMzn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ0-003AHZ-MA; Sun, 06 Dec 2020 14:54:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:43 +0200
Message-Id: <iwlwifi.20201206145305.5c8dab7a22a0.I58459fdf6968b16c90cab9c574f0f04ca22b0c79@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/11] mac80211: support driver-based disconnect with reconnect hint
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support the driver indicating that a disconnection needs
to be performed, and pass through the reconnect hint in
this case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h     | 11 ++++++
 net/mac80211/ieee80211_i.h |  4 ++-
 net/mac80211/mlme.c        | 69 ++++++++++++++++++++++++++++----------
 net/mac80211/trace.h       | 23 ++++++++++++-
 4 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 05c7524bab26..4b9bbcc54674 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5881,6 +5881,17 @@ void ieee80211_beacon_loss(struct ieee80211_vif *vif);
  */
 void ieee80211_connection_loss(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_disconnect - request disconnection
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @reconnect: immediate reconnect is desired
+ *
+ * Request disconnection from the current network and, if enabled, send a
+ * hint to the higher layers that immediate reconnect is desired.
+ */
+void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect);
+
 /**
  * ieee80211_resume_disconnect - disconnect from AP after resume
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cde2e3f4fbcd..cd8275e4b2cd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -452,7 +452,9 @@ struct ieee80211_if_managed {
 	unsigned long probe_timeout;
 	int probe_send_count;
 	bool nullfunc_failed;
-	bool connection_loss;
+	u8 connection_loss:1,
+	   driver_disconnect:1,
+	   reconnect:1;
 
 	struct cfg80211_bss *associated;
 	struct ieee80211_mgd_auth_data *auth_data;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 673a1838691c..1c9cc65bccba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2720,7 +2720,7 @@ EXPORT_SYMBOL(ieee80211_ap_probereq_get);
 
 static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 					const u8 *buf, size_t len, bool tx,
-					u16 reason)
+					u16 reason, bool reconnect)
 {
 	struct ieee80211_event event = {
 		.type = MLME_EVENT,
@@ -2729,7 +2729,7 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 	};
 
 	if (tx)
-		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len, false);
+		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len, reconnect);
 	else
 		cfg80211_rx_mlme_mgmt(sdata->dev, buf, len);
 
@@ -2751,13 +2751,18 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 
 	tx = !sdata->csa_block_tx;
 
-	/* AP is probably out of range (or not reachable for another reason) so
-	 * remove the bss struct for that AP.
-	 */
-	cfg80211_unlink_bss(local->hw.wiphy, ifmgd->associated);
+	if (!ifmgd->driver_disconnect) {
+		/*
+		 * AP is probably out of range (or not reachable for another
+		 * reason) so remove the bss struct for that AP.
+		 */
+		cfg80211_unlink_bss(local->hw.wiphy, ifmgd->associated);
+	}
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
+			       ifmgd->driver_disconnect ?
+					WLAN_REASON_DEAUTH_LEAVING :
+					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.csa_active = false;
@@ -2770,7 +2775,9 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->mtx);
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
-				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY);
+				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
+				    ifmgd->reconnect);
+	ifmgd->reconnect = false;
 
 	sdata_unlock(sdata);
 }
@@ -2789,6 +2796,13 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 		sdata_info(sdata, "Connection to AP %pM lost\n",
 			   ifmgd->bssid);
 		__ieee80211_disconnect(sdata);
+		ifmgd->connection_loss = false;
+	} else if (ifmgd->driver_disconnect) {
+		sdata_info(sdata,
+			   "Driver requested disconnection from AP %pM\n",
+			   ifmgd->bssid);
+		__ieee80211_disconnect(sdata);
+		ifmgd->driver_disconnect = false;
 	} else {
 		ieee80211_mgd_probe_ap(sdata, true);
 	}
@@ -2827,6 +2841,21 @@ void ieee80211_connection_loss(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_connection_loss);
 
+void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_hw *hw = &sdata->local->hw;
+
+	trace_api_disconnect(sdata, reconnect);
+
+	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
+		return;
+
+	sdata->u.mgd.driver_disconnect = true;
+	sdata->u.mgd.reconnect = reconnect;
+	ieee80211_queue_work(hw, &sdata->u.mgd.beacon_connection_loss_work);
+}
+EXPORT_SYMBOL(ieee80211_disconnect);
 
 static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 					bool assoc)
@@ -3130,7 +3159,7 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_set_disassoc(sdata, 0, 0, false, NULL);
 
 		ieee80211_report_disconnect(sdata, (u8 *)mgmt, len, false,
-					    reason_code);
+					    reason_code, false);
 		return;
 	}
 
@@ -3179,7 +3208,8 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_set_disassoc(sdata, 0, 0, false, NULL);
 
-	ieee80211_report_disconnect(sdata, (u8 *)mgmt, len, false, reason_code);
+	ieee80211_report_disconnect(sdata, (u8 *)mgmt, len, false, reason_code,
+				    false);
 }
 
 static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
@@ -4199,7 +4229,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 				       true, deauth_buf);
 		ieee80211_report_disconnect(sdata, deauth_buf,
 					    sizeof(deauth_buf), true,
-					    WLAN_REASON_DEAUTH_LEAVING);
+					    WLAN_REASON_DEAUTH_LEAVING,
+					    false);
 		return;
 	}
 
@@ -4344,7 +4375,7 @@ static void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 			       tx, frame_buf);
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
-				    reason);
+				    reason, false);
 }
 
 static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
@@ -5431,7 +5462,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-					    WLAN_REASON_UNSPECIFIED);
+					    WLAN_REASON_UNSPECIFIED,
+					    false);
 	}
 
 	sdata_info(sdata, "authenticate with %pM\n", req->bss->bssid);
@@ -5503,7 +5535,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-					    WLAN_REASON_UNSPECIFIED);
+					    WLAN_REASON_UNSPECIFIED,
+					    false);
 	}
 
 	if (ifmgd->auth_data && !ifmgd->auth_data->done) {
@@ -5802,7 +5835,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_destroy_auth_data(sdata, false);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-					    req->reason_code);
+					    req->reason_code, false);
 
 		return 0;
 	}
@@ -5822,7 +5855,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_destroy_assoc_data(sdata, false, true);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-					    req->reason_code);
+					    req->reason_code, false);
 		return 0;
 	}
 
@@ -5837,7 +5870,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 				       req->reason_code, tx, frame_buf);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-					    req->reason_code);
+					    req->reason_code, false);
 		return 0;
 	}
 
@@ -5870,7 +5903,7 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 			       frame_buf);
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
-				    req->reason_code);
+				    req->reason_code, false);
 
 	return 0;
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 89723907a094..601322e16957 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016-2017 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2019 Intel Corporation
+* Copyright (C) 2018 - 2020 Intel Corporation
 */
 
 #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -2086,6 +2086,27 @@ TRACE_EVENT(api_connection_loss,
 	)
 );
 
+TRACE_EVENT(api_disconnect,
+	TP_PROTO(struct ieee80211_sub_if_data *sdata, bool reconnect),
+
+	TP_ARGS(sdata, reconnect),
+
+	TP_STRUCT__entry(
+		VIF_ENTRY
+		__field(int, reconnect)
+	),
+
+	TP_fast_assign(
+		VIF_ASSIGN;
+		__entry->reconnect = reconnect;
+	),
+
+	TP_printk(
+		VIF_PR_FMT " reconnect:%d",
+		VIF_PR_ARG, __entry->reconnect
+	)
+);
+
 TRACE_EVENT(api_cqm_rssi_notify,
 	TP_PROTO(struct ieee80211_sub_if_data *sdata,
 		 enum nl80211_cqm_rssi_threshold_event rssi_event,
-- 
2.29.2

