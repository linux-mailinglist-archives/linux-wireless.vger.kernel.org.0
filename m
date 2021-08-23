Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78F3F5010
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhHWSEB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231795AbhHWSD4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:03:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03846138B;
        Mon, 23 Aug 2021 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741793;
        bh=k0yebE20cJE3uwsG4VVKKAav+rOnBCWlIF3gtX2PR1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S99XFhdp3V4UZI0tJsUQsDLxNL8QFxAIwpg9x9Pio1u6JVWaIpayMz/LUlMWzJSMO
         eTHVN7H2WDDZxmMOU3FVLD/Vva0xginVJC8p5DJ971IAgj5p4WMY+fCtn4bn34I8rn
         p6Kcvp3QrEhQluEDWxV6TcgaruhupaLRKX8C/G/LPIGOZDBjDrvp3kUaN2a0sdnpQC
         iCPdRtsanJpPg4JnKRlS/yhUTq3HPppv42KrH6nZaGUzRVxlviT30TQZ3Mvbs9lHu3
         d5h0SvjqnM343QbVhmYoFMjy2ru+7TLyITom3Dunant/8i73LU2rAEWs2/DXmJ0UHk
         I7lVWG/yQQswA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 2/7] mac80211: introduce individual TWT support in AP mode.
Date:   Mon, 23 Aug 2021 20:02:39 +0200
Message-Id: <257512f2e22ba42b9f2624942a128dd8f141de4b.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce TWT action frames parsing support to mac80211.
Currently just individual TWT agreement are support in AP mode.
Whenever the AP receives a TWT action frame from an associated client,
after performing sanity checks, it will notify the underlay driver with
requested parameters in order to check if they are supported and if there
is enough room for a new agreement. The hw is expected to set agreement
result and report it to mac80211.
The two following drv callbacks have been added to mac80211:
- add_twt_setup (mandatory)
- twt_teardown_request (optional)

mac80211 will send an action frame reply according to the result
reported by the driver/fw.

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/mac80211.h     |  12 +++
 net/mac80211/driver-ops.h  |  35 +++++++
 net/mac80211/ieee80211_i.h |   6 ++
 net/mac80211/iface.c       |  41 ++++++++
 net/mac80211/rx.c          |  72 ++++++++++++++
 net/mac80211/s1g.c         | 187 +++++++++++++++++++++++++++++++++++++
 net/mac80211/status.c      |  17 +++-
 net/mac80211/trace.h       |  67 +++++++++++++
 8 files changed, 435 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d8a1d09a2141..2b55784b9c24 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3919,6 +3919,13 @@ struct ieee80211_prep_tx_info {
  * @set_sar_specs: Update the SAR (TX power) settings.
  * @sta_set_decap_offload: Called to notify the driver when a station is allowed
  *	to use rx decapsulation offload
+ * @add_twt_setup: Update hw with TWT agreement parameters received from the peer.
+ *	This callback allows the hw to check if requested parameters
+ *	are supported and if there is enough room for a new agreement.
+ *	The hw is expected to set agreement result in the req_type field of
+ *	twt structure.
+ * @twt_teardown_request: Update the hw with TWT teardown request received
+ *	from the peer.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4242,6 +4249,11 @@ struct ieee80211_ops {
 	void (*sta_set_decap_offload)(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, bool enabled);
+	void (*add_twt_setup)(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt);
+	void (*twt_teardown_request)(struct ieee80211_hw *hw,
+				     struct ieee80211_sta *sta, u8 flowid);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index bcb7cc06db3d..aaf81c8ffced 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1447,4 +1447,39 @@ static inline void drv_sta_set_decap_offload(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_add_twt_setup(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_sta *sta,
+				     struct ieee80211_twt_setup *twt)
+{
+	struct ieee80211_twt_params *twt_agrt;
+
+	might_sleep();
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+
+	trace_drv_add_twt_setup(local, sta, twt, twt_agrt);
+	local->ops->add_twt_setup(&local->hw, sta, twt);
+	trace_drv_return_void(local);
+}
+
+static inline void drv_twt_teardown_request(struct ieee80211_local *local,
+					    struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_sta *sta,
+					    u8 flowid)
+{
+	might_sleep();
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (!local->ops->twt_teardown_request)
+		return;
+
+	trace_drv_twt_teardown_request(local, sta, flowid);
+	local->ops->twt_teardown_request(&local->hw, sta, flowid);
+	trace_drv_return_void(local);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 22549b95d1aa..ca44cefcad61 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -937,6 +937,7 @@ struct ieee80211_sub_if_data {
 
 	struct work_struct work;
 	struct sk_buff_head skb_queue;
+	struct sk_buff_head status_queue;
 
 	u8 needed_rx_chains;
 	enum ieee80211_smps_mode smps_mode;
@@ -2068,6 +2069,11 @@ ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 /* S1G */
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta);
+bool ieee80211_s1g_is_twt_setup(struct sk_buff *skb);
+void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
+				 struct sk_buff *skb);
+void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
+				     struct sk_buff *skb);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1e5e9fc45523..79049cd48911 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -551,6 +551,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		 */
 		ieee80211_free_keys(sdata, true);
 		skb_queue_purge(&sdata->skb_queue);
+		skb_queue_purge(&sdata->status_queue);
 	}
 
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
@@ -983,6 +984,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	}
 
 	skb_queue_head_init(&sdata->skb_queue);
+	skb_queue_head_init(&sdata->status_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 
 	return 0;
@@ -1381,6 +1383,16 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 			WARN_ON(1);
 			break;
 		}
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_S1G) {
+		switch (mgmt->u.action.u.s1g.action_code) {
+		case WLAN_S1G_TWT_TEARDOWN:
+		case WLAN_S1G_TWT_SETUP:
+			ieee80211_s1g_rx_twt_action(sdata, skb);
+			break;
+		default:
+			break;
+		}
 	} else if (ieee80211_is_ext(mgmt->frame_control)) {
 		if (sdata->vif.type == NL80211_IFTYPE_STATION)
 			ieee80211_sta_rx_queued_ext(sdata, skb);
@@ -1436,6 +1448,24 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 	}
 }
 
+static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
+					   struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	if (ieee80211_is_action(mgmt->frame_control) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_S1G) {
+		switch (mgmt->u.action.u.s1g.action_code) {
+		case WLAN_S1G_TWT_TEARDOWN:
+		case WLAN_S1G_TWT_SETUP:
+			ieee80211_s1g_status_twt_action(sdata, skb);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void ieee80211_iface_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -1465,6 +1495,16 @@ static void ieee80211_iface_work(struct work_struct *work)
 		kcov_remote_stop();
 	}
 
+	/* process status queue */
+	while ((skb = skb_dequeue(&sdata->status_queue))) {
+		kcov_remote_start_common(skb_get_kcov_handle(skb));
+
+		ieee80211_iface_process_status(sdata, skb);
+		kfree_skb(skb);
+
+		kcov_remote_stop();
+	}
+
 	/* then other type-dependent work */
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -1528,6 +1568,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	}
 
 	skb_queue_head_init(&sdata->skb_queue);
+	skb_queue_head_init(&sdata->status_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 771921c057e8..53ca8b5d2a5b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3206,6 +3206,67 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
+static bool
+ieee80211_process_rx_twt_action(struct ieee80211_rx_data *rx)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)rx->skb->data;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_supported_band *sband;
+
+	/* TWT actions are only supported in AP for the moment */
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return false;
+
+	if (!rx->local->ops->add_twt_setup)
+		return false;
+
+	sband = rx->local->hw.wiphy->bands[status->band];
+	iftd = ieee80211_get_sband_iftype_data(sband, sdata->vif.type);
+	if (!iftd)
+		return false;
+
+	if (!(iftd->he_cap.he_cap_elem.mac_cap_info[0] &
+	      IEEE80211_HE_MAC_CAP0_TWT_RES))
+		return false;
+
+	if (!rx->sta)
+		return false;
+
+	switch (mgmt->u.action.u.s1g.action_code) {
+	case WLAN_S1G_TWT_SETUP: {
+		struct ieee80211_twt_setup *twt;
+
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE +
+				   1 + /* action code */
+				   sizeof(struct ieee80211_twt_setup) +
+				   2 /* TWT req_type agrt */)
+			break;
+
+		twt = (void *)mgmt->u.action.u.s1g.variable;
+		if (twt->element_id != WLAN_EID_S1G_TWT)
+			break;
+
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE +
+				   4 + /* action code + token + tlv */
+				   twt->length)
+			break;
+
+		return true; /* queue the frame */
+	}
+	case WLAN_S1G_TWT_TEARDOWN:
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE + 2)
+			break;
+
+		return true; /* queue the frame */
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 {
@@ -3485,6 +3546,17 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		    !mesh_path_sel_is_hwmp(sdata))
 			break;
 		goto queue;
+	case WLAN_CATEGORY_S1G:
+		switch (mgmt->u.action.u.s1g.action_code) {
+		case WLAN_S1G_TWT_SETUP:
+		case WLAN_S1G_TWT_TEARDOWN:
+			if (ieee80211_process_rx_twt_action(rx))
+				goto queue;
+			break;
+		default:
+			break;
+		}
+		break;
 	}
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index c33f332b049a..7ebe11f19404 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -6,6 +6,7 @@
 #include <linux/ieee80211.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
+#include "driver-ops.h"
 
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
 {
@@ -14,3 +15,189 @@ void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
 	sta->rx_stats.last_rate =
 			STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
 }
+
+bool ieee80211_s1g_is_twt_setup(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+
+	if (likely(!ieee80211_is_action(mgmt->frame_control)))
+		return false;
+
+	if (likely(mgmt->u.action.category != WLAN_CATEGORY_S1G))
+		return false;
+
+	return mgmt->u.action.u.s1g.action_code == WLAN_S1G_TWT_SETUP;
+}
+
+static void
+ieee80211_s1g_send_twt_setup(struct ieee80211_sub_if_data *sdata, const u8 *da,
+			     const u8 *bssid, struct ieee80211_twt_setup *twt)
+{
+	int len = IEEE80211_MIN_ACTION_SIZE + 4 + twt->length;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom + len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+	mgmt = skb_put_zero(skb, len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, da, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, bssid, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_S1G;
+	mgmt->u.action.u.s1g.action_code = WLAN_S1G_TWT_SETUP;
+	memcpy(mgmt->u.action.u.s1g.variable, twt, 3 + twt->length);
+
+	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
+					IEEE80211_TX_INTFL_MLME_CONN_TX |
+					IEEE80211_TX_CTL_REQ_TX_STATUS;
+	ieee80211_tx_skb(sdata, skb);
+}
+
+static void
+ieee80211_s1g_send_twt_teardown(struct ieee80211_sub_if_data *sdata,
+				const u8 *da, const u8 *bssid, u8 flowid)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	u8 *id;
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
+			    IEEE80211_MIN_ACTION_SIZE + 2);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE + 2);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, da, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, bssid, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_S1G;
+	mgmt->u.action.u.s1g.action_code = WLAN_S1G_TWT_TEARDOWN;
+	id = (u8 *)mgmt->u.action.u.s1g.variable;
+	*id = flowid;
+
+	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
+					IEEE80211_TX_CTL_REQ_TX_STATUS;
+	ieee80211_tx_skb(sdata, skb);
+}
+
+static void
+ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_twt_params *twt_agrt;
+	struct ieee80211_twt_setup *twt;
+
+	twt = (struct ieee80211_twt_setup *)mgmt->u.action.u.s1g.variable;
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+	twt_agrt->req_type &= cpu_to_le16(~IEEE80211_TWT_REQTYPE_REQUEST);
+
+	/* broadcast TWT not supported yet */
+	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST) {
+		twt_agrt->req_type &=
+			cpu_to_le16(~IEEE80211_TWT_REQTYPE_SETUP_CMD);
+		twt_agrt->req_type |= cpu_to_le16(
+				FIELD_PREP(IEEE80211_TWT_REQTYPE_SETUP_CMD,
+					   TWT_SETUP_CMD_REJECT));
+		goto out;
+	}
+
+	drv_add_twt_setup(sdata->local, sdata, &sta->sta, twt);
+out:
+	ieee80211_s1g_send_twt_setup(sdata, mgmt->sa, sdata->vif.addr, twt);
+}
+
+static void
+ieee80211_s1g_rx_twt_teardown(struct ieee80211_sub_if_data *sdata,
+			      struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+
+	drv_twt_teardown_request(sdata->local, sdata, &sta->sta,
+				 mgmt->u.action.u.s1g.variable[0]);
+}
+
+static void
+ieee80211_s1g_tx_twt_setup_fail(struct ieee80211_sub_if_data *sdata,
+				struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_twt_params *twt_agrt;
+	struct ieee80211_twt_setup *twt;
+	u8 flowid;
+
+	twt = (struct ieee80211_twt_setup *)mgmt->u.action.u.s1g.variable;
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+	flowid = FIELD_GET(IEEE80211_TWT_REQTYPE_FLOWID,
+			   le16_to_cpu(twt_agrt->req_type));
+
+	drv_twt_teardown_request(sdata->local, sdata, &sta->sta, flowid);
+	ieee80211_s1g_send_twt_teardown(sdata, mgmt->sa, sdata->vif.addr,
+					flowid);
+}
+
+void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
+				 struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+
+	mutex_lock(&local->sta_mtx);
+
+	sta = sta_info_get_bss(sdata, mgmt->sa);
+	if (!sta)
+		goto out;
+
+	switch (mgmt->u.action.u.s1g.action_code) {
+	case WLAN_S1G_TWT_SETUP:
+		ieee80211_s1g_rx_twt_setup(sdata, sta, skb);
+		break;
+	case WLAN_S1G_TWT_TEARDOWN:
+		ieee80211_s1g_rx_twt_teardown(sdata, sta, skb);
+		break;
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&local->sta_mtx);
+}
+
+void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
+				     struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+
+	mutex_lock(&local->sta_mtx);
+
+	sta = sta_info_get_bss(sdata, mgmt->da);
+	if (!sta)
+		goto out;
+
+	switch (mgmt->u.action.u.s1g.action_code) {
+	case WLAN_S1G_TWT_SETUP:
+		/* process failed twt setup frames */
+		ieee80211_s1g_tx_twt_setup_fail(sdata, sta, skb);
+		break;
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&local->sta_mtx);
+}
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index bae321ff77f6..5a57a08b66ee 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -705,13 +705,26 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 			/* Check to see if packet is a TDLS teardown packet */
 			if (ieee80211_is_data(hdr->frame_control) &&
 			    (ieee80211_get_tdls_action(skb, hdr_size) ==
-			     WLAN_TDLS_TEARDOWN))
+			     WLAN_TDLS_TEARDOWN)) {
 				ieee80211_tdls_td_tx_handle(local, sdata, skb,
 							    info->flags);
-			else
+			} else if (ieee80211_s1g_is_twt_setup(skb)) {
+				if (!acked) {
+					struct sk_buff *qskb;
+
+					qskb = skb_clone(skb, GFP_ATOMIC);
+					if (qskb) {
+						skb_queue_tail(&sdata->status_queue,
+							       qskb);
+						ieee80211_queue_work(&local->hw,
+								     &sdata->work);
+					}
+				}
+			} else {
 				ieee80211_mgd_conn_tx_status(sdata,
 							     hdr->frame_control,
 							     acked);
+			}
 		}
 
 		rcu_read_unlock();
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index f6ef15366938..9e8381bef7ed 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2825,6 +2825,73 @@ DEFINE_EVENT(sta_flag_evt, drv_sta_set_decap_offload,
 	TP_ARGS(local, sdata, sta, enabled)
 );
 
+TRACE_EVENT(drv_add_twt_setup,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sta *sta,
+		 struct ieee80211_twt_setup *twt,
+		 struct ieee80211_twt_params *twt_agrt),
+
+	TP_ARGS(local, sta, twt, twt_agrt),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		STA_ENTRY
+		__field(u8, dialog_token)
+		__field(u8, control)
+		__field(__le16, req_type)
+		__field(__le64, twt)
+		__field(u8, duration)
+		__field(__le16, mantissa)
+		__field(u8, channel)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		STA_ASSIGN;
+		__entry->dialog_token = twt->dialog_token;
+		__entry->control = twt->control;
+		__entry->req_type = twt_agrt->req_type;
+		__entry->twt = twt_agrt->twt;
+		__entry->duration = twt_agrt->min_twt_dur;
+		__entry->mantissa = twt_agrt->mantissa;
+		__entry->channel = twt_agrt->channel;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT STA_PR_FMT
+		" token:%d control:0x%02x req_type:0x%04x"
+		" twt:%llu duration:%d mantissa:%d channel:%d",
+		LOCAL_PR_ARG, STA_PR_ARG, __entry->dialog_token,
+		__entry->control, le16_to_cpu(__entry->req_type),
+		le64_to_cpu(__entry->twt), __entry->duration,
+		le16_to_cpu(__entry->mantissa), __entry->channel
+	)
+);
+
+TRACE_EVENT(drv_twt_teardown_request,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sta *sta, u8 flowid),
+
+	TP_ARGS(local, sta, flowid),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		STA_ENTRY
+		__field(u8, flowid)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		STA_ASSIGN;
+		__entry->flowid = flowid;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT STA_PR_FMT " flowid:%d",
+		LOCAL_PR_ARG, STA_PR_ARG, __entry->flowid
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.31.1

