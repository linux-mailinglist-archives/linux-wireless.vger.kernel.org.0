Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4624D0CA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHUIto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgHUItf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 04:49:35 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E01C061346
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RWpKptDRUy7QEz+yk93XSXVLRWqkIzmC5G3Lk3G8rGs=; b=Rq+rr0jg6ZCIJRyfrJ+99Fu5lY
        k3hm6cIHozgprxXR4nS+aiU/9JztCh/duauafgc6QwB0AcR92cdLl8UagM3YHjV8dEXiNf5Hxabp3
        eP8r7bW0NaaCIIdwYMdi8d5Ukd3ULHxPbqDlTB76L6MvNzBjPRcF3+sUUP0eP1CZuDbs=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k92jq-0005lO-On; Fri, 21 Aug 2020 10:49:30 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 09/13] mac80211: support using ieee80211_tx_status_ext to free skbs without status info
Date:   Fri, 21 Aug 2020 10:49:22 +0200
Message-Id: <20200821084926.10650-10-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821084926.10650-1-nbd@nbd.name>
References: <20200821084926.10650-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For encap-offloaded packets, ieee80211_free_txskb cannot be used, since it
does not have the vif pointer.
Using ieee80211_tx_status_ext for this purpose has the advantage of being able
avoid an extra station lookup for AQL

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/status.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ac4d988556b0..a3543c3dbd3d 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1087,6 +1087,24 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	bool acked, noack_success;
 	u16 tx_time_est;
 
+	if (pubsta)
+		sta = container_of(pubsta, struct sta_info, sta);
+
+	if (skb && (tx_time_est =
+		    ieee80211_info_get_tx_time_est(IEEE80211_SKB_CB(skb))) > 0) {
+		/* Do this here to avoid the expensive lookup of the sta
+		 * in ieee80211_report_used_skb().
+		 */
+		ieee80211_sta_update_pending_airtime(local, sta,
+						     skb_get_queue_mapping(skb),
+						     tx_time_est,
+						     true);
+		ieee80211_info_set_tx_time_est(IEEE80211_SKB_CB(skb), 0);
+	}
+
+	if (!status->info)
+		goto free;
+
 	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
 
 	sband = hw->wiphy->bands[info->band];
@@ -1095,8 +1113,6 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 	if (pubsta) {
-		sta = container_of(pubsta, struct sta_info, sta);
-
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
@@ -1132,17 +1148,6 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			ieee80211s_update_metric(local, sta, status);
 	}
 
-	if (skb && (tx_time_est = ieee80211_info_get_tx_time_est(info)) > 0) {
-		/* Do this here to avoid the expensive lookup of the sta
-		 * in ieee80211_report_used_skb().
-		 */
-		ieee80211_sta_update_pending_airtime(local, sta,
-						     skb_get_queue_mapping(skb),
-						     tx_time_est,
-						     true);
-		ieee80211_info_set_tx_time_est(info, 0);
-	}
-
 	if (skb && !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
 		return __ieee80211_tx_status(hw, status, rates_idx,
 					     retry_count);
@@ -1159,6 +1164,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		I802_DEBUG_INC(local->dot11FailedCount);
 	}
 
+free:
 	if (!skb)
 		return;
 
-- 
2.28.0

