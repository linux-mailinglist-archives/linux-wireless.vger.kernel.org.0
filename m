Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA366E4A11
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDQNiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDQNiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 09:38:11 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E99872BA
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gee+MJQCSYFi49kYv4mguY3pvMAUQQbP3FbJ+ehoerM=; b=fgBmUeVEsBS8Egs9jsQUi9zZN/
        Cs+0DJ8KfBy55CU8baSaHk3AQnQPJmUWLzyQzUXQntn2d1KVCnLbE3asf8eFm5gRIktn2vJXbcwpI
        rWt3ujQTxgLhfPzXalTcpRXubJSeEd/D5+6dXxn0CBQArIVhDsRp0wM2JCBs3eol2yAQ=;
Received: from [2a01:598:b1a5:5f87:b534:7c55:b6fa:8ec] (helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1poP3J-00Fgks-07; Mon, 17 Apr 2023 15:37:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: remove ieee80211_tx_status_8023
Date:   Mon, 17 Apr 2023 15:37:51 +0200
Message-Id: <20230417133751.79160-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is unused and should not be used. In order to avoid limitations in
4-address mode, the driver should always use ieee80211_tx_status_ext for
802.3 frames with a valid sta pointer.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 20 --------------------
 net/mac80211/status.c  | 24 ------------------------
 2 files changed, 44 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a8dadbd83d95..ac0370e76874 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5215,26 +5215,6 @@ static inline void ieee80211_tx_status_ni(struct ieee80211_hw *hw,
 void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 				 struct sk_buff *skb);
 
-/**
- * ieee80211_tx_status_8023 - transmit status callback for 802.3 frame format
- *
- * Call this function for all transmitted data frames after their transmit
- * completion. This callback should only be called for data frames which
- * are using driver's (or hardware's) offload capability of encap/decap
- * 802.11 frames.
- *
- * This function may not be called in IRQ context. Calls to this function
- * for a single hardware must be synchronized against each other and all
- * calls in the same tx status family.
- *
- * @hw: the hardware the frame was transmitted by
- * @vif: the interface for which the frame was transmitted
- * @skb: the frame that was transmitted, owned by mac80211 after this call
- */
-void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif,
-			       struct sk_buff *skb);
-
 /**
  * ieee80211_report_low_ack - report non-responding station
  *
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3f9ddd7f04b6..2b13a52ce96c 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1244,30 +1244,6 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
-void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif,
-			      struct sk_buff *skb)
-{
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_tx_status status = {
-		.skb = skb,
-		.info = IEEE80211_SKB_CB(skb),
-	};
-	struct sta_info *sta;
-
-	sdata = vif_to_sdata(vif);
-
-	rcu_read_lock();
-
-	if (!ieee80211_lookup_ra_sta(sdata, skb, &sta) && !IS_ERR(sta))
-		status.sta = &sta->sta;
-
-	ieee80211_tx_status_ext(hw, &status);
-
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(ieee80211_tx_status_8023);
-
 void ieee80211_report_low_ack(struct ieee80211_sta *pubsta, u32 num_packets)
 {
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-- 
2.39.0

