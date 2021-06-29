Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE523B7152
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhF2Lb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Jun 2021 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhF2Lb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Jun 2021 07:31:26 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A9C061760
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jun 2021 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=COxEAXPCUPIInmlp3mCbquU+blypUSMoxsW40vsGPTo=; b=BOO+Q5QrXB9dBDFEh7IN3UT5wr
        u8qFcGJ/eviBeKpxz6BE5K261+xKCDDlru7QQIKfBTa7QTcIDKEx17bLbH3lxJyx/WnSh0O3MJ3ZR
        27Oo06n7GqOguzEjCVmRnB1zVIgJ+R0kTEjXDAtNvzoQnCTF9xcBSAah13zrAA5k1aYE=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lyBvD-0006Bt-PZ; Tue, 29 Jun 2021 13:28:55 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: fix starting aggregation sessions on mesh interfaces
Date:   Tue, 29 Jun 2021 13:28:53 +0200
Message-Id: <20210629112853.29785-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The logic for starting aggregation sessions was recently moved from minstrel_ht
to mac80211, into the subif tx handler just after the sta lookup.
Unfortunately this didn't work for mesh interfaces, since the sta lookup is
deferred until a much later point in time on those.
Fix this by also calling the aggregation check right after the deferred sta
lookup.

Fixes: 08a46c642001 ("mac80211: move A-MPDU session check from minstrel_ht to mac80211")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 57 ++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e96981144358..8509778ff31f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1147,6 +1147,29 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 	return queued;
 }
 
+static void
+ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
+		     struct sta_info *sta,
+		     struct sk_buff *skb)
+{
+	struct rate_control_ref *ref = sdata->local->rate_ctrl;
+	u16 tid;
+
+	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
+		return;
+
+	if (!sta || !sta->sta.ht_cap.ht_supported ||
+	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
+	    skb->protocol == sdata->control_port_protocol)
+		return;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	if (likely(sta->ampdu_mlme.tid_tx[tid]))
+		return;
+
+	ieee80211_start_tx_ba_session(&sta->sta, tid, 0);
+}
+
 /*
  * initialises @tx
  * pass %NULL for the station if unknown, a valid pointer if known
@@ -1160,6 +1183,7 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool aggr_check = false;
 	int tid;
 
 	memset(tx, 0, sizeof(*tx));
@@ -1188,8 +1212,10 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 		} else if (tx->sdata->control_port_protocol == tx->skb->protocol) {
 			tx->sta = sta_info_get_bss(sdata, hdr->addr1);
 		}
-		if (!tx->sta && !is_multicast_ether_addr(hdr->addr1))
+		if (!tx->sta && !is_multicast_ether_addr(hdr->addr1)) {
 			tx->sta = sta_info_get(sdata, hdr->addr1);
+			aggr_check = true;
+		}
 	}
 
 	if (tx->sta && ieee80211_is_data_qos(hdr->frame_control) &&
@@ -1199,8 +1225,12 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 		struct tid_ampdu_tx *tid_tx;
 
 		tid = ieee80211_get_tid(hdr);
-
 		tid_tx = rcu_dereference(tx->sta->ampdu_mlme.tid_tx[tid]);
+		if (!tid_tx && aggr_check) {
+			ieee80211_aggr_check(sdata, tx->sta, skb);
+			tid_tx = rcu_dereference(tx->sta->ampdu_mlme.tid_tx[tid]);
+		}
+
 		if (tid_tx) {
 			bool queued;
 
@@ -4120,29 +4150,6 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-static void
-ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
-		     struct sta_info *sta,
-		     struct sk_buff *skb)
-{
-	struct rate_control_ref *ref = sdata->local->rate_ctrl;
-	u16 tid;
-
-	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
-		return;
-
-	if (!sta || !sta->sta.ht_cap.ht_supported ||
-	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
-	    skb->protocol == sdata->control_port_protocol)
-		return;
-
-	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	if (likely(sta->ampdu_mlme.tid_tx[tid]))
-		return;
-
-	ieee80211_start_tx_ba_session(&sta->sta, tid, 0);
-}
-
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
-- 
2.30.1

