Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7374E386BF6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhEQVJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhEQVJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 17:09:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57114C061573
        for <linux-wireless@vger.kernel.org>; Mon, 17 May 2021 14:08:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1likT1-00AVFx-PB; Mon, 17 May 2021 23:08:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] mac80211: refactor SKB queue processing a bit
Date:   Mon, 17 May 2021 23:07:55 +0200
Message-Id: <20210517230754.6bc6cdd68570.I28a86ebdb19601ca1965c4dc654cc49fc1064efa@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
References: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is a very long loop body, move it into its own function
instead, keeping only the kcov and free outside in the loop
body.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 228 ++++++++++++++++++++++---------------------
 1 file changed, 119 insertions(+), 109 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7032a2b59249..3a998ae50429 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1320,13 +1320,130 @@ static void ieee80211_if_setup_no_queue(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 
+static void ieee80211_iface_process_skb(struct ieee80211_local *local,
+					struct ieee80211_sub_if_data *sdata,
+					struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	if (ieee80211_is_action(mgmt->frame_control) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK) {
+		struct sta_info *sta;
+		int len = skb->len;
+
+		mutex_lock(&local->sta_mtx);
+		sta = sta_info_get_bss(sdata, mgmt->sa);
+		if (sta) {
+			switch (mgmt->u.action.u.addba_req.action_code) {
+			case WLAN_ACTION_ADDBA_REQ:
+				ieee80211_process_addba_request(local, sta,
+								mgmt, len);
+				break;
+			case WLAN_ACTION_ADDBA_RESP:
+				ieee80211_process_addba_resp(local, sta,
+							     mgmt, len);
+				break;
+			case WLAN_ACTION_DELBA:
+				ieee80211_process_delba(sdata, sta,
+							mgmt, len);
+				break;
+			default:
+				WARN_ON(1);
+				break;
+			}
+		}
+		mutex_unlock(&local->sta_mtx);
+	} else if (ieee80211_is_action(mgmt->frame_control) &&
+		   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
+		switch (mgmt->u.action.u.vht_group_notif.action_code) {
+		case WLAN_VHT_ACTION_OPMODE_NOTIF: {
+			struct ieee80211_rx_status *status;
+			enum nl80211_band band;
+			struct sta_info *sta;
+			u8 opmode;
+
+			status = IEEE80211_SKB_RXCB(skb);
+			band = status->band;
+			opmode = mgmt->u.action.u.vht_opmode_notif.operating_mode;
+
+			mutex_lock(&local->sta_mtx);
+			sta = sta_info_get_bss(sdata, mgmt->sa);
+
+			if (sta)
+				ieee80211_vht_handle_opmode(sdata, sta, opmode,
+							    band);
+
+			mutex_unlock(&local->sta_mtx);
+			break;
+		}
+		case WLAN_VHT_ACTION_GROUPID_MGMT:
+			ieee80211_process_mu_groups(sdata, mgmt);
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+	} else if (ieee80211_is_ext(mgmt->frame_control)) {
+		if (sdata->vif.type == NL80211_IFTYPE_STATION)
+			ieee80211_sta_rx_queued_ext(sdata, skb);
+		else
+			WARN_ON(1);
+	} else if (ieee80211_is_data_qos(mgmt->frame_control)) {
+		struct ieee80211_hdr *hdr = (void *)mgmt;
+		struct sta_info *sta;
+
+		/*
+		 * So the frame isn't mgmt, but frame_control
+		 * is at the right place anyway, of course, so
+		 * the if statement is correct.
+		 *
+		 * Warn if we have other data frame types here,
+		 * they must not get here.
+		 */
+		WARN_ON(hdr->frame_control &
+				cpu_to_le16(IEEE80211_STYPE_NULLFUNC));
+		WARN_ON(!(hdr->seq_ctrl &
+				cpu_to_le16(IEEE80211_SCTL_FRAG)));
+		/*
+		 * This was a fragment of a frame, received while
+		 * a block-ack session was active. That cannot be
+		 * right, so terminate the session.
+		 */
+		mutex_lock(&local->sta_mtx);
+		sta = sta_info_get_bss(sdata, mgmt->sa);
+		if (sta) {
+			u16 tid = ieee80211_get_tid(hdr);
+
+			__ieee80211_stop_rx_ba_session(
+				sta, tid, WLAN_BACK_RECIPIENT,
+				WLAN_REASON_QSTA_REQUIRE_SETUP,
+				true);
+		}
+		mutex_unlock(&local->sta_mtx);
+	} else switch (sdata->vif.type) {
+	case NL80211_IFTYPE_STATION:
+		ieee80211_sta_rx_queued_mgmt(sdata, skb);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		ieee80211_ibss_rx_queued_mgmt(sdata, skb);
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		if (!ieee80211_vif_is_mesh(&sdata->vif))
+			break;
+		ieee80211_mesh_rx_queued_mgmt(sdata, skb);
+		break;
+	default:
+		WARN(1, "frame for unexpected interface type");
+		break;
+	}
+}
+
 static void ieee80211_iface_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, work);
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
-	struct sta_info *sta;
 
 	if (!ieee80211_sdata_running(sdata))
 		return;
@@ -1339,116 +1456,9 @@ static void ieee80211_iface_work(struct work_struct *work)
 
 	/* first process frames */
 	while ((skb = skb_dequeue(&sdata->skb_queue))) {
-		struct ieee80211_mgmt *mgmt = (void *)skb->data;
-
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
-		if (ieee80211_is_action(mgmt->frame_control) &&
-		    mgmt->u.action.category == WLAN_CATEGORY_BACK) {
-			int len = skb->len;
-
-			mutex_lock(&local->sta_mtx);
-			sta = sta_info_get_bss(sdata, mgmt->sa);
-			if (sta) {
-				switch (mgmt->u.action.u.addba_req.action_code) {
-				case WLAN_ACTION_ADDBA_REQ:
-					ieee80211_process_addba_request(
-							local, sta, mgmt, len);
-					break;
-				case WLAN_ACTION_ADDBA_RESP:
-					ieee80211_process_addba_resp(local, sta,
-								     mgmt, len);
-					break;
-				case WLAN_ACTION_DELBA:
-					ieee80211_process_delba(sdata, sta,
-								mgmt, len);
-					break;
-				default:
-					WARN_ON(1);
-					break;
-				}
-			}
-			mutex_unlock(&local->sta_mtx);
-		} else if (ieee80211_is_action(mgmt->frame_control) &&
-			   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
-			switch (mgmt->u.action.u.vht_group_notif.action_code) {
-			case WLAN_VHT_ACTION_OPMODE_NOTIF: {
-				struct ieee80211_rx_status *status;
-				enum nl80211_band band;
-				u8 opmode;
-
-				status = IEEE80211_SKB_RXCB(skb);
-				band = status->band;
-				opmode = mgmt->u.action.u.vht_opmode_notif.operating_mode;
-
-				mutex_lock(&local->sta_mtx);
-				sta = sta_info_get_bss(sdata, mgmt->sa);
-
-				if (sta)
-					ieee80211_vht_handle_opmode(sdata, sta,
-								    opmode,
-								    band);
-
-				mutex_unlock(&local->sta_mtx);
-				break;
-			}
-			case WLAN_VHT_ACTION_GROUPID_MGMT:
-				ieee80211_process_mu_groups(sdata, mgmt);
-				break;
-			default:
-				WARN_ON(1);
-				break;
-			}
-		} else if (ieee80211_is_ext(mgmt->frame_control)) {
-			if (sdata->vif.type == NL80211_IFTYPE_STATION)
-				ieee80211_sta_rx_queued_ext(sdata, skb);
-			else
-				WARN_ON(1);
-		} else if (ieee80211_is_data_qos(mgmt->frame_control)) {
-			struct ieee80211_hdr *hdr = (void *)mgmt;
-			/*
-			 * So the frame isn't mgmt, but frame_control
-			 * is at the right place anyway, of course, so
-			 * the if statement is correct.
-			 *
-			 * Warn if we have other data frame types here,
-			 * they must not get here.
-			 */
-			WARN_ON(hdr->frame_control &
-					cpu_to_le16(IEEE80211_STYPE_NULLFUNC));
-			WARN_ON(!(hdr->seq_ctrl &
-					cpu_to_le16(IEEE80211_SCTL_FRAG)));
-			/*
-			 * This was a fragment of a frame, received while
-			 * a block-ack session was active. That cannot be
-			 * right, so terminate the session.
-			 */
-			mutex_lock(&local->sta_mtx);
-			sta = sta_info_get_bss(sdata, mgmt->sa);
-			if (sta) {
-				u16 tid = ieee80211_get_tid(hdr);
 
-				__ieee80211_stop_rx_ba_session(
-					sta, tid, WLAN_BACK_RECIPIENT,
-					WLAN_REASON_QSTA_REQUIRE_SETUP,
-					true);
-			}
-			mutex_unlock(&local->sta_mtx);
-		} else switch (sdata->vif.type) {
-		case NL80211_IFTYPE_STATION:
-			ieee80211_sta_rx_queued_mgmt(sdata, skb);
-			break;
-		case NL80211_IFTYPE_ADHOC:
-			ieee80211_ibss_rx_queued_mgmt(sdata, skb);
-			break;
-		case NL80211_IFTYPE_MESH_POINT:
-			if (!ieee80211_vif_is_mesh(&sdata->vif))
-				break;
-			ieee80211_mesh_rx_queued_mgmt(sdata, skb);
-			break;
-		default:
-			WARN(1, "frame for unexpected interface type");
-			break;
-		}
+		ieee80211_iface_process_skb(local, sdata, skb);
 
 		kfree_skb(skb);
 		kcov_remote_stop();
-- 
2.31.1

