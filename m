Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB6547768
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiFKUBW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFKUBQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 16:01:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8C5047D
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ybmJYgyT6wVmtTzw362Og5U3wOSpEWgrLtZv05kJ1Lk=; b=pTli8K1fpkbuaRtu9P0PYJZPox
        J0zkoKwg5jx7P0YYCX/XQVIWqqfilci9mbDK6tG07mA+9sA4jM1drEyukDPLysYl1CGZXw+NkezbR
        WN8V0qslrdDBve/Jj8LAHYvQYAOmU6EOhwz0wPWbuG7PnkZ1swTSa15UPmt8uJPqRjrc=;
Received: from p57a6f441.dip0.t-ipconnect.de ([87.166.244.65] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o07ID-0006oU-26; Sat, 11 Jun 2022 22:01:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@kernel.org
Subject: [PATCH v2 2/4] mac80211: improve AQL tx time estimation
Date:   Sat, 11 Jun 2022 22:01:04 +0200
Message-Id: <20220611200106.34319-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220611200106.34319-1-nbd@nbd.name>
References: <20220611200106.34319-1-nbd@nbd.name>
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

If airtime cannot be calculated because of missing or unsupported rate info,
use the smallest possible non-zero value for estimated tx time.
This improves handling of these cases by preventing queueing of as many packets
as the driver/hardware queue can hold for these stations.
Also slightly improve limiting queueing by explicitly rounding up small values.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 18 +++++++++++-------
 net/mac80211/status.c  |  2 ++
 net/mac80211/tx.c      | 13 ++++++-------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ebadb2103968..d8c4d49bcc49 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1127,20 +1127,24 @@ struct ieee80211_tx_info {
 	};
 };
 
+#define IEEE80211_TX_TIME_EST_UNIT 4
+
+static inline u16
+ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
+{
+	return info->tx_time_est * IEEE80211_TX_TIME_EST_UNIT;
+}
+
 static inline u16
 ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_time_est)
 {
 	/* We only have 10 bits in tx_time_est, so store airtime
 	 * in increments of 4us and clamp the maximum to 2**12-1
 	 */
-	info->tx_time_est = min_t(u16, tx_time_est, 4095) >> 2;
-	return info->tx_time_est << 2;
-}
+	tx_time_est = DIV_ROUND_UP(tx_time_est, IEEE80211_TX_TIME_EST_UNIT);
+	info->tx_time_est = min_t(u16, tx_time_est, BIT(10) - 1);
 
-static inline u16
-ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
-{
-	return info->tx_time_est << 2;
+	return ieee80211_info_get_tx_time_est(info);
 }
 
 /***
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index e69272139437..cea053d89dbb 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1014,6 +1014,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 								   NULL,
 								   skb->len,
 								   false);
+			if (!airtime)
+				airtime = IEEE80211_TX_TIME_EST_UNIT;
 
 			ieee80211_register_airtime(txq, airtime, 0);
 		}
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..ecb3975680bc 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3797,13 +3797,12 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
 							     skb->len, ampdu);
-		if (airtime) {
-			airtime = ieee80211_info_set_tx_time_est(info, airtime);
-			ieee80211_sta_update_pending_airtime(local, tx.sta,
-							     txq->ac,
-							     airtime,
-							     false);
-		}
+		if (!airtime)
+			airtime = IEEE80211_TX_TIME_EST_UNIT;
+
+		airtime = ieee80211_info_set_tx_time_est(info, airtime);
+		ieee80211_sta_update_pending_airtime(local, tx.sta, txq->ac,
+						     airtime, false);
 	}
 
 	return skb;
-- 
2.36.1

