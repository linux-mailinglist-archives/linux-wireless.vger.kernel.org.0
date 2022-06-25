Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFD55ACC1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiFYVYS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8E101D7
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xRMuWUPVilcvtt3XcB8ba3fAVOmcyci/Yub6+bFW9gM=; b=rYTRFWqBJq1lPfCNjti5kDlrm/
        4+XVqaHT8q5YXtQAyV0Pff6WOFuXiXHcN7av2AN9v2B30/ZEqgpo7pnm8X24FZlisXxGkiJv3U3Mr
        wmr+k4W2ySGtQOmlvuv0Ee0KH1XKWDC9JB1jquZsSGTF9E35B/G5WKIqy63z7U42ghUY=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGH-0003Vi-EN; Sat, 25 Jun 2022 23:24:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 3/7] mac80211: consider aql_tx_pending when checking airtime deficit
Date:   Sat, 25 Jun 2022 23:24:07 +0200
Message-Id: <20220625212411.36675-3-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625212411.36675-1-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
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

When queueing packets for a station, deficit only gets added once the packets
have been transmitted, which could be much later. During that time, a lot of
temporary unfairness could happen, which could lead to bursty behavior.
Fix this by subtracting the aql_tx_pending when checking the deficit in tx
scheduling.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a615cadf7728..0509486ac40a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3800,6 +3800,13 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_dequeue);
 
+static inline s32 ieee80211_sta_deficit(struct sta_info *sta, u8 ac)
+{
+	struct airtime_info *air_info = &sta->airtime[ac];
+
+	return air_info->deficit - atomic_read(&air_info->aql_tx_pending);
+}
+
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -3830,7 +3837,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						    struct sta_info, sta);
 		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
-		s32 deficit = sta->airtime[txqi->txq.ac].deficit;
+		s32 deficit = ieee80211_sta_deficit(sta, txqi->txq.ac);
 
 		if (aql_check)
 			found_eligible_txq = true;
@@ -3955,7 +3962,7 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 			continue;
 		}
 		sta = container_of(iter->txq.sta, struct sta_info, sta);
-		if (sta->airtime[ac].deficit < 0)
+		if (ieee80211_sta_deficit(sta, ac) < 0)
 			sta->airtime[ac].deficit += sta->airtime_weight;
 		list_move_tail(&iter->schedule_order, &local->active_txqs[ac]);
 	}
-- 
2.36.1

