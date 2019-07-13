Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C267B44
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfGMQgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 12:36:53 -0400
Received: from nbd.name ([46.4.11.11]:41202 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfGMQgx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 12:36:53 -0400
Received: from pd95fd64b.dip0.t-ipconnect.de ([217.95.214.75] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmL10-000457-2p; Sat, 13 Jul 2019 18:36:50 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V3 2/2] mac80211: add support for the ADDBA extension element
Date:   Sat, 13 Jul 2019 18:36:42 +0200
Message-Id: <20190713163642.18491-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190713163642.18491-1-john@phrozen.org>
References: <20190713163642.18491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE allows peers to negotiate the aggregation fragmentation level to be used
during transmission. The level can be 1-3. The Ext element is added behind
the ADDBA request inside the action frame. The responder will then reply
with the same level or a lower one if the requested one is not supported.
This patch only handles the negotiation part as the ADDBA frames get passed
to the ATH11k firmware, which does the rest of the magic for us aswell as
generating the requests.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/linux/ieee80211.h  |  3 ++
 net/mac80211/agg-rx.c      | 71 +++++++++++++++++++++++++++++++++-----
 net/mac80211/ht.c          |  2 +-
 net/mac80211/ieee80211_i.h |  3 +-
 4 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c7bdaaebca5b..2d4f50c990f9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -984,6 +984,8 @@ struct ieee80211_mgmt {
 					__le16 capab;
 					__le16 timeout;
 					__le16 start_seq_num;
+					/* followed by BA Extension */
+					u8 variable[0];
 				} __packed addba_req;
 				struct{
 					u8 action_code;
@@ -1742,6 +1744,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_LEVEL_2		0x10
 #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_LEVEL_3		0x18
 #define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_MASK			0x18
+#define IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_SHIFT		3
 #define IEEE80211_HE_MAC_CAP0_MAX_NUM_FRAG_MSDU_1		0x00
 #define IEEE80211_HE_MAC_CAP0_MAX_NUM_FRAG_MSDU_2		0x20
 #define IEEE80211_HE_MAC_CAP0_MAX_NUM_FRAG_MSDU_4		0x40
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 6a4f154c99f6..65ed3a77f203 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -181,17 +181,53 @@ static void sta_rx_agg_reorder_timer_expired(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-static void ieee80211_send_addba_resp(struct ieee80211_sub_if_data *sdata, u8 *da, u16 tid,
+static void ieee80211_add_addbaext(struct ieee80211_sub_if_data *sdata,
+				   struct sk_buff *skb,
+				   const struct ieee80211_addba_ext_ie *req)
+{
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_addba_ext_ie *resp;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 frag_level, cap_frag_level;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
+	if (!he_cap)
+		return;
+
+	pos = skb_put_zero(skb, 2 + sizeof(struct ieee80211_addba_ext_ie));
+	*pos++ = WLAN_EID_ADDBA_EXT;
+	*pos++ = sizeof(struct ieee80211_addba_ext_ie);
+	resp = (struct ieee80211_addba_ext_ie *)pos;
+	resp->data = req->data & IEEE80211_ADDBA_EXT_NO_FRAG;
+
+	frag_level = (req->data & IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK) >>
+		     IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT;
+	cap_frag_level = (he_cap->he_cap_elem.mac_cap_info[0] &
+			  IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_MASK) >>
+			 IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_SHIFT;
+	if (frag_level > cap_frag_level)
+		frag_level = cap_frag_level;
+	resp->data |= (frag_level << IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT) &
+		      IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK;
+}
+
+static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 				      u8 dialog_token, u16 status, u16 policy,
-				      u16 buf_size, u16 timeout)
+				      u16 buf_size, u16 timeout,
+				      const struct ieee80211_addba_ext_ie *addbaext)
 {
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	bool amsdu = ieee80211_hw_check(&local->hw, SUPPORTS_AMSDU_IN_AMPDU);
 	u16 capab;
 
-	skb = dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom);
+	skb = dev_alloc_skb(sizeof(*mgmt) +
+		    (addbaext ? 2 + sizeof(struct ieee80211_addba_ext_ie) : 0) +
+		    local->hw.extra_tx_headroom);
 	if (!skb)
 		return;
 
@@ -225,13 +261,17 @@ static void ieee80211_send_addba_resp(struct ieee80211_sub_if_data *sdata, u8 *d
 	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
 	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
 
+	if (sta->sta.he_cap.has_he && addbaext)
+		ieee80211_add_addbaext(sdata, skb, addbaext);
+
 	ieee80211_tx_skb(sdata, skb);
 }
 
 void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 				      u8 dialog_token, u16 timeout,
 				      u16 start_seq_num, u16 ba_policy, u16 tid,
-				      u16 buf_size, bool tx, bool auto_seq)
+				      u16 buf_size, bool tx, bool auto_seq,
+				      const struct ieee80211_addba_ext_ie *addbaext)
 {
 	struct ieee80211_local *local = sta->sdata->local;
 	struct tid_ampdu_rx *tid_agg_rx;
@@ -413,21 +453,22 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	}
 
 	if (tx)
-		ieee80211_send_addba_resp(sta->sdata, sta->sta.addr, tid,
+		ieee80211_send_addba_resp(sta, sta->sta.addr, tid,
 					  dialog_token, status, 1, buf_size,
-					  timeout);
+					  timeout, addbaext);
 }
 
 static void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 					    u8 dialog_token, u16 timeout,
 					    u16 start_seq_num, u16 ba_policy,
 					    u16 tid, u16 buf_size, bool tx,
-					    bool auto_seq)
+					    bool auto_seq,
+					    const struct ieee80211_addba_ext_ie *addbaext)
 {
 	mutex_lock(&sta->ampdu_mlme.mtx);
 	___ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					 start_seq_num, ba_policy, tid,
-					 buf_size, tx, auto_seq);
+					 buf_size, tx, auto_seq, addbaext);
 	mutex_unlock(&sta->ampdu_mlme.mtx);
 }
 
@@ -437,7 +478,9 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     size_t len)
 {
 	u16 capab, tid, timeout, ba_policy, buf_size, start_seq_num;
+	struct ieee802_11_elems elems = { 0 };
 	u8 dialog_token;
+	int ies_len;
 
 	/* extract session parameters from addba request frame */
 	dialog_token = mgmt->u.action.u.addba_req.dialog_token;
@@ -450,9 +493,19 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 	tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
 	buf_size = (capab & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6;
 
+	ies_len = len - offsetof(struct ieee80211_mgmt,
+				 u.action.u.addba_req.variable);
+	if (ies_len) {
+		ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
+                                ies_len, true, &elems, mgmt->bssid, NULL);
+		if (elems.parse_error)
+			return;
+	}
+
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
-					buf_size, true, false);
+					buf_size, true, false,
+					elems.addba_ext_ie);
 }
 
 void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index c62101857b9b..3ea08e7ba0d1 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -362,7 +362,7 @@ void ieee80211_ba_session_work(struct work_struct *work)
 				       sta->ampdu_mlme.tid_rx_manage_offl))
 			___ieee80211_start_rx_ba_session(sta, 0, 0, 0, 1, tid,
 							 IEEE80211_MAX_AMPDU_BUF_HT,
-							 false, true);
+							 false, true, NULL);
 
 		if (test_and_clear_bit(tid + IEEE80211_NUM_TIDS,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c4c3193290ad..be06f51d7fa3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1812,7 +1812,8 @@ void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 				      u8 dialog_token, u16 timeout,
 				      u16 start_seq_num, u16 ba_policy, u16 tid,
-				      u16 buf_size, bool tx, bool auto_seq);
+				      u16 buf_size, bool tx, bool auto_seq,
+				      const struct ieee80211_addba_ext_ie *addbaext);
 void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 					 enum ieee80211_agg_stop_reason reason);
 void ieee80211_process_delba(struct ieee80211_sub_if_data *sdata,
-- 
2.20.1

