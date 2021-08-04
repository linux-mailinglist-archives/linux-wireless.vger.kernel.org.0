Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA533DFC29
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhHDHhO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 03:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235619AbhHDHhM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 03:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3590360F14;
        Wed,  4 Aug 2021 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062620;
        bh=6gHj+JnzjjbDEux0NvHD2o2v1B/FioVHA2VC6ZGYKEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dg9uiCZRxg4d1fdNYQxfBipZb/DbIO7y9ydDkLy1TffLPLu3FKI6V+0zHNP1CscRt
         1jsZ505oh+t9r9faNpA3Uzcw747MJj5ogwNzflAqVqGagcYZs8A7O3gO4AzmDfo4hn
         UgymomDctB9XTeRwAMfbjs3DY59v8v129SKunHc4e8mgIfNveJSjfmNr1EoTwrw55y
         wZsouX/gYoArXRjq0TgH2A1XW6yOzaIa55rXSu1RbqAaaUwGrSBnCscjt7pvsGvRPj
         sqA8mfa9Wb9oUQLSgQfyNKf3mwEYKKKJfK0eWEtaSBl8aL8jcLeyjrhJ99YoHQLwM7
         zJHOBFGlI3xXQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH mac80211-next 2/7] mac80211: introduce individual TWT support in AP mode.
Date:   Wed,  4 Aug 2021 09:36:33 +0200
Message-Id: <73695eba8e432a2c44f7524dd76617088c506a12.1628062233.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628062233.git.lorenzo@kernel.org>
References: <cover.1628062233.git.lorenzo@kernel.org>
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
 include/net/mac80211.h     |  13 +++
 net/mac80211/driver-ops.h  |  24 +++++
 net/mac80211/ieee80211_i.h |   5 +
 net/mac80211/iface.c       |  13 +++
 net/mac80211/rx.c          |  54 ++++++++++
 net/mac80211/s1g.c         | 198 +++++++++++++++++++++++++++++++++++++
 net/mac80211/status.c      |  34 ++++++-
 7 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d8a1d09a2141..70390a57735c 100644
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
+ *	agrt_resp structure.
+ * @twt_teardown_request: Update the hw with TWT teardown request received
+ * 	from the peer.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4242,6 +4249,12 @@ struct ieee80211_ops {
 	void (*sta_set_decap_offload)(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, bool enabled);
+	void (*add_twt_setup)(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_params *agrt_req,
+			      struct ieee80211_twt_params *agrt_resp);
+	void (*twt_teardown_request)(struct ieee80211_hw *hw,
+				     struct ieee80211_sta *sta, u8 flowid);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index bcb7cc06db3d..7adf7809d003 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1447,4 +1447,28 @@ static inline void drv_sta_set_decap_offload(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_add_twt_setup(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_sta *sta,
+				     struct ieee80211_twt_params *agrt_req,
+				     struct ieee80211_twt_params *agrt_resp)
+{
+	might_sleep();
+	check_sdata_in_driver(sdata);
+
+	local->ops->add_twt_setup(&local->hw, sta, agrt_req, agrt_resp);
+}
+
+static inline void drv_twt_teardown_request(struct ieee80211_local *local,
+					    struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_sta *sta,
+					    u8 flowid)
+{
+	might_sleep();
+	check_sdata_in_driver(sdata);
+
+	if (local->ops->twt_teardown_request)
+		local->ops->twt_teardown_request(&local->hw, sta, flowid);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 22549b95d1aa..895581a8b621 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2068,6 +2068,11 @@ ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 /* S1G */
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta);
+bool ieee80211_s1g_is_twt_setup(struct sk_buff *skb);
+void ieee80211_s1g_rx_h_twt(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb);
+void ieee80211_s1g_status_h_twt(struct ieee80211_sub_if_data *sdata,
+				struct sk_buff *skb);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1e5e9fc45523..1bf24251ba3d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1381,6 +1381,19 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 			WARN_ON(1);
 			break;
 		}
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_S1G) {
+		switch (mgmt->u.action.u.s1g.action_code) {
+		case WLAN_S1G_TWT_TEARDOWN:
+		case WLAN_S1G_TWT_SETUP:
+			if (skb->pkt_type == IEEE80211_TX_STATUS_MSG)
+				ieee80211_s1g_status_h_twt(sdata, skb);
+			else
+				ieee80211_s1g_rx_h_twt(sdata, skb);
+			break;
+		default:
+			break;
+		}
 	} else if (ieee80211_is_ext(mgmt->frame_control)) {
 		if (sdata->vif.type == NL80211_IFTYPE_STATION)
 			ieee80211_sta_rx_queued_ext(sdata, skb);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 771921c057e8..345de0e5e4fa 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3206,6 +3206,50 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
+static ieee80211_rx_result debug_noinline
+ieee80211_rx_h_twt(struct ieee80211_rx_data *rx)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)rx->skb->data;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_supported_band *sband;
+
+	/* TWT actions are only supported in AP for the moment */
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return RX_CONTINUE;
+
+	sband = rx->local->hw.wiphy->bands[status->band];
+	iftd = ieee80211_get_sband_iftype_data(sband, sdata->vif.type);
+	if (!iftd)
+		return RX_CONTINUE;
+
+	if (!rx->local->ops->add_twt_setup)
+		return RX_CONTINUE;
+
+	if (!(iftd->he_cap.he_cap_elem.mac_cap_info[0] &
+	      IEEE80211_HE_MAC_CAP0_TWT_RES))
+		return RX_CONTINUE;
+
+	if (!rx->sta)
+		return RX_CONTINUE;
+
+	switch (mgmt->u.action.u.s1g.action_code) {
+	case WLAN_S1G_TWT_SETUP:
+		if (rx->skb->len < IEEE80211_TWT_IND_SETUP_SIZE)
+			break;
+		return RX_QUEUED;
+	case WLAN_S1G_TWT_TEARDOWN:
+		if (rx->skb->len < IEEE80211_MIN_ACTION_SIZE + 2)
+			break;
+		return RX_QUEUED;
+	default:
+		break;
+	}
+
+	return RX_CONTINUE;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 {
@@ -3485,6 +3529,16 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		    !mesh_path_sel_is_hwmp(sdata))
 			break;
 		goto queue;
+	case WLAN_CATEGORY_S1G:
+		switch (mgmt->u.action.u.s1g.action_code) {
+		case WLAN_S1G_TWT_SETUP:
+		case WLAN_S1G_TWT_TEARDOWN:
+			if (ieee80211_rx_h_twt(rx) != RX_CONTINUE)
+				goto queue;
+		default:
+			break;
+		}
+		break;
 	}
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index c33f332b049a..053dc3fafc41 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -6,6 +6,7 @@
 #include <linux/ieee80211.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
+#include "driver-ops.h"
 
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
 {
@@ -14,3 +15,200 @@ void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
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
+static int
+ieee80211_s1g_send_twt_setup(struct ieee80211_sub_if_data *sdata,
+			     const u8 *da, const u8 *bssid, u8 dialog_token,
+			     struct ieee80211_twt_params *params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_twt_setup *twt;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
+			    IEEE80211_TWT_IND_SETUP_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+	mgmt = skb_put_zero(skb, IEEE80211_TWT_IND_SETUP_SIZE);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, da, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, bssid, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_S1G;
+	mgmt->u.action.u.s1g.action_code = WLAN_S1G_TWT_SETUP;
+
+	twt = (struct ieee80211_twt_setup *)mgmt->u.action.u.s1g.variable;
+	twt->dialog_token = dialog_token;
+	twt->element_id = WLAN_EID_S1G_TWT;
+	twt->length = sizeof(struct ieee80211_twt_params);
+
+	memcpy(twt->params, params, twt->length);
+
+	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
+					IEEE80211_TX_CTL_REQ_TX_STATUS;
+	ieee80211_tx_skb(sdata, skb);
+
+	return 0;
+}
+
+static int
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
+		return -ENOMEM;
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
+
+	return 0;
+}
+
+static int
+ieee80211_s1g_rx_h_twt_setup(struct ieee80211_sub_if_data *sdata,
+			     struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_twt_params *agrt_req, agrt_resp;
+	struct ieee80211_twt_setup *twt;
+
+	twt = (struct ieee80211_twt_setup *)mgmt->u.action.u.s1g.variable;
+	if (twt->element_id != WLAN_EID_S1G_TWT)
+		return -EINVAL;
+
+	agrt_req = (struct ieee80211_twt_params *)twt->params;
+
+	/* broadcast TWT not supported yet */
+	if (agrt_req->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST)
+		return -EINVAL;
+
+	drv_add_twt_setup(sdata->local, sdata, &sta->sta, agrt_req,
+			  &agrt_resp);
+
+	return ieee80211_s1g_send_twt_setup(sdata, mgmt->sa, sdata->vif.addr,
+					    twt->dialog_token, &agrt_resp);
+}
+
+static int
+ieee80211_s1g_status_twt_setup(struct ieee80211_sub_if_data *sdata,
+			       struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_twt_params *agrt_resp;
+	struct ieee80211_twt_setup *twt;
+	u8 flowid;
+
+	twt = (struct ieee80211_twt_setup *)mgmt->u.action.u.s1g.variable;
+	agrt_resp = (struct ieee80211_twt_params *)twt->params;
+	flowid = FIELD_GET(IEEE80211_TWT_REQTYPE_FLOWID,
+			   le16_to_cpu(agrt_resp->req_type));
+
+	drv_twt_teardown_request(sdata->local, sdata, &sta->sta, flowid);
+
+	return ieee80211_s1g_send_twt_teardown(sdata, mgmt->sa,
+					       sdata->vif.addr, flowid);
+}
+
+static int
+ieee80211_s1g_rx_h_twt_teardown(struct ieee80211_sub_if_data *sdata,
+				struct sta_info *sta, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+
+	drv_twt_teardown_request(sdata->local, sdata, &sta->sta,
+				 mgmt->u.action.u.s1g.variable[0]);
+
+	return 0;
+}
+
+void ieee80211_s1g_rx_h_twt(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb)
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
+		ieee80211_s1g_rx_h_twt_setup(sdata, sta, skb);
+		break;
+	case WLAN_S1G_TWT_TEARDOWN:
+		ieee80211_s1g_rx_h_twt_teardown(sdata, sta, skb);
+		break;
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&local->sta_mtx);
+}
+
+void ieee80211_s1g_status_h_twt(struct ieee80211_sub_if_data *sdata,
+				struct sk_buff *skb)
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
+		ieee80211_s1g_status_twt_setup(sdata, sta, skb);
+		break;
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&local->sta_mtx);
+}
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index bae321ff77f6..2c4e7ef21869 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -17,6 +17,33 @@
 #include "led.h"
 #include "wme.h"
 
+static struct sk_buff *
+ieee80211_tx_queue_skb(struct ieee80211_hw *hw,
+		       struct ieee80211_tx_status *status,
+		       bool monitor)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(status->skb);
+	struct sk_buff *skb = status->skb;
+	struct sta_info *sta;
+
+	if (!status->sta)
+		goto out;
+
+	if (likely(!ieee80211_s1g_is_twt_setup(skb)))
+		goto out;
+
+	if (info->flags & IEEE80211_TX_STAT_ACK)
+		goto out; /* nothing to do */
+
+	sta = container_of(status->sta, struct sta_info, sta);
+	skb->pkt_type = IEEE80211_TX_STATUS_MSG;
+	skb_queue_tail(&sta->sdata->skb_queue, skb);
+	skb = monitor ? skb_clone(skb, GFP_ATOMIC) : NULL;
+	ieee80211_queue_work(hw, &sta->sdata->work);
+
+out:
+	return skb;
+}
 
 void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 				 struct sk_buff *skb)
@@ -1046,13 +1073,18 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	 * with this test...
 	 */
 	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
-		if (status->free_list)
+		skb = ieee80211_tx_queue_skb(hw, status, false);
+		if (skb && status->free_list)
 			list_add_tail(&skb->list, status->free_list);
 		else
 			dev_kfree_skb(skb);
 		return;
 	}
 
+	skb = ieee80211_tx_queue_skb(hw, status, true);
+	if (!skb)
+		return;
+
 	/* send to monitor interfaces */
 	ieee80211_tx_monitor(local, skb, sband, retry_count, shift,
 			     send_to_cooked, status);
-- 
2.31.1

