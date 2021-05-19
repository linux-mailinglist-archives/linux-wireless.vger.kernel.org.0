Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1D38971B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhEST5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 15:57:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49437 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232233AbhEST5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 15:57:49 -0400
X-UUID: cf9bc010a74e4cbe81bd1664d6cabf0c-20210520
X-UUID: cf9bc010a74e4cbe81bd1664d6cabf0c-20210520
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 294613297; Thu, 20 May 2021 03:56:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 03:56:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 03:56:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [RFC PATCH 1/4] mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue
Date:   Thu, 20 May 2021 03:56:21 +0800
Message-ID: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make ieee80211_tx_h_rate_ctrl() get called on dequeue to improve
performance since it reduces the turnaround time for rate control.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 52 ++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0b719f3d2dec..b3ef6aaece31 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1768,8 +1768,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 	CALL_TXH(ieee80211_tx_h_ps_buf);
 	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
 	CALL_TXH(ieee80211_tx_h_select_key);
-	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
-		CALL_TXH(ieee80211_tx_h_rate_ctrl);
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
@@ -1802,6 +1800,9 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 		goto txh_done;
 	}
 
+	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
+		CALL_TXH(ieee80211_tx_h_rate_ctrl);
+
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
@@ -3369,15 +3370,21 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
  * Can be called while the sta lock is held. Anything that can cause packets to
  * be generated will cause deadlock!
  */
-static void ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
-				       struct sta_info *sta, u8 pn_offs,
-				       struct ieee80211_key *key,
-				       struct sk_buff *skb)
+static ieee80211_tx_result
+ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta, u8 pn_offs,
+			   struct ieee80211_key *key,
+			   struct ieee80211_tx_data *tx)
 {
+	struct sk_buff *skb = tx->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	u8 tid = IEEE80211_NUM_TIDS;
 
+	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
+		if (ieee80211_tx_h_rate_ctrl(tx) != TX_CONTINUE)
+			return TX_DROP;
+
 	if (key)
 		info->control.hw_key = &key->conf;
 
@@ -3426,6 +3433,8 @@ static void ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 			break;
 		}
 	}
+
+	return TX_CONTINUE;
 }
 
 static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
@@ -3529,24 +3538,17 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	tx.sta = sta;
 	tx.key = fast_tx->key;
 
-	if (!ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
-		tx.skb = skb;
-		r = ieee80211_tx_h_rate_ctrl(&tx);
-		skb = tx.skb;
-		tx.skb = NULL;
-
-		if (r != TX_CONTINUE) {
-			if (r != TX_QUEUED)
-				kfree_skb(skb);
-			return true;
-		}
-	}
-
 	if (ieee80211_queue_skb(local, sdata, sta, skb))
 		return true;
 
-	ieee80211_xmit_fast_finish(sdata, sta, fast_tx->pn_offs,
-				   fast_tx->key, skb);
+	tx.skb = skb;
+	r = ieee80211_xmit_fast_finish(sdata, sta, fast_tx->pn_offs,
+				       fast_tx->key, &tx);
+	tx.skb = NULL;
+	if (r == TX_DROP) {
+		kfree_skb(skb);
+		return true;
+	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
@@ -3663,8 +3665,12 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		    (tx.key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV))
 			pn_offs = ieee80211_hdrlen(hdr->frame_control);
 
-		ieee80211_xmit_fast_finish(sta->sdata, sta, pn_offs,
-					   tx.key, skb);
+		r = ieee80211_xmit_fast_finish(sta->sdata, sta, pn_offs,
+					       tx.key, &tx);
+		if (r != TX_CONTINUE) {
+			ieee80211_free_txskb(&local->hw, skb);
+			goto begin;
+		}
 	} else {
 		if (invoke_tx_handlers_late(&tx))
 			goto begin;
-- 
2.18.0

