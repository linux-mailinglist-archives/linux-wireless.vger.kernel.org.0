Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B855ACC8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiFYVYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D8DE8E
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cyoHR7PAi8vygIMljdAzb3kcc9AUFzi5wFs4WY85E4A=; b=SXI0+Rv0R4briuITSuWGGafY5A
        QV/gdkHAAGnJ4eylBDIDlUKipu7yGuOmE3N5V+V/qkujzSNwioWZqaoA6ukoof7heQ2jMIBZxLmUs
        3zLFF3QI0G2LiiSP0pjHLKIDabHVjR4VLfLSGJeXYLYVQoyikLEmaQNk+f6LV+G6RFIo=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGH-0003Vi-6o; Sat, 25 Jun 2022 23:24:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 2/7] mac80211: make sta airtime deficit field s32 instead of s64
Date:   Sat, 25 Jun 2022 23:24:06 +0200
Message-Id: <20220625212411.36675-2-nbd@nbd.name>
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

32 bit is more than enough range for the airtime deficit

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/debugfs_sta.c | 4 ++--
 net/mac80211/sta_info.h    | 2 +-
 net/mac80211/tx.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1dc238fc24f0..d3397c1248d3 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -202,7 +202,7 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
-	s64 deficit[IEEE80211_NUM_ACS];
+	s32 deficit[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -219,7 +219,7 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 
 	p += scnprintf(p, bufsz + buf - p,
 		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+		"Deficit: VO: %d us VI: %d us BE: %d us BK: %d us\n",
 		rx_airtime, tx_airtime, sta->airtime_weight,
 		deficit[0], deficit[1], deficit[2], deficit[3]);
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 4ba0c252da95..785fefe8c41a 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -138,7 +138,7 @@ enum ieee80211_agg_stop_reason {
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
-	s64 deficit;
+	s32 deficit;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
 	u32 aql_limit_low;
 	u32 aql_limit_high;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index fcee60ce2456..a615cadf7728 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3830,7 +3830,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						    struct sta_info, sta);
 		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
-		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
+		s32 deficit = sta->airtime[txqi->txq.ac].deficit;
 
 		if (aql_check)
 			found_eligible_txq = true;
-- 
2.36.1

