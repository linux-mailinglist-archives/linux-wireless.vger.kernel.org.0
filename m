Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9445D67FEB
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfGNPog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:36 -0400
Received: from nbd.name ([46.4.11.11]:59390 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbfGNPog (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:36 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgfx-0007cJ-GR; Sun, 14 Jul 2019 17:44:33 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/6] mac80211: propagate struct ieee80211_tx_status into ieee80211_tx_monitor()
Date:   Sun, 14 Jul 2019 17:44:15 +0200
Message-Id: <20190714154419.11854-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190714154419.11854-1-john@phrozen.org>
References: <20190714154419.11854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This will allow use to report HE rates on the radiotap interface.

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/ieee80211_i.h | 3 ++-
 net/mac80211/status.c      | 6 ++++--
 net/mac80211/tx.c          | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index db1c834d55d5..be06f51d7fa3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1776,7 +1776,8 @@ ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags);
 void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 			  struct ieee80211_supported_band *sband,
-			  int retry_count, int shift, bool send_to_cooked);
+			  int retry_count, int shift, bool send_to_cooked,
+			  struct ieee80211_tx_status *status);
 
 void ieee80211_check_fast_xmit(struct sta_info *sta);
 void ieee80211_check_fast_xmit_all(struct ieee80211_local *local);
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 0c8858c01e36..a3502da02b4e 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -648,7 +648,8 @@ static int ieee80211_tx_get_rates(struct ieee80211_hw *hw,
 
 void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 			  struct ieee80211_supported_band *sband,
-			  int retry_count, int shift, bool send_to_cooked)
+			  int retry_count, int shift, bool send_to_cooked,
+			  struct ieee80211_tx_status *status)
 {
 	struct sk_buff *skb2;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -904,7 +905,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	}
 
 	/* send to monitor interfaces */
-	ieee80211_tx_monitor(local, skb, sband, retry_count, shift, send_to_cooked);
+	ieee80211_tx_monitor(local, skb, sband, retry_count, shift,
+			     send_to_cooked, status);
 }
 
 void ieee80211_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 173a8495820e..2395f7cf0be1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4794,7 +4794,8 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 	if (!sband)
 		return bcn;
 
-	ieee80211_tx_monitor(hw_to_local(hw), copy, sband, 1, shift, false);
+	ieee80211_tx_monitor(hw_to_local(hw), copy, sband, 1, shift, false,
+			     NULL);
 
 	return bcn;
 }
-- 
2.20.1

