Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8185E3AB9BE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFQQde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhFQQda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:33:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2504C061760
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V2/GB8ZYCCn4H8u+HJRfon5Lbp+eOWnJg5ILQgDiARo=; b=pzj7p+dYGtbMInUJaG0cWhK5C7
        hjYtFCw2g59blGyUsfCQ9hfvipawM0S0Via4aerVtTeceuaz7gQhF8lUhrzrxZD/5KOldG5LtnuZZ
        GXaIZuMQu2TgkUHITDpIJHsBGz447tkQbKNgb4hX9K/VJLbk8huD1pnFAu702JbYLcLI=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltuvD-0001vC-Uv; Thu, 17 Jun 2021 18:31:16 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>, johannes@sipsolutions.net
Subject: [PATCH v3 2/3] mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue
Date:   Thu, 17 Jun 2021 18:31:12 +0200
Message-Id: <20210617163113.75815-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210617163113.75815-1-nbd@nbd.name>
References: <20210617163113.75815-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Make ieee80211_tx_h_rate_ctrl() get called on dequeue to improve
performance since it reduces the turnaround time for rate control.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/mac80211/tx.c | 52 ++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e6f7953db483..5cb4a5c9597e 100644
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
 
+	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL) &&
+	    ieee80211_tx_h_rate_ctrl(tx) != TX_CONTINUE)
+		return TX_DROP;
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
2.30.1

