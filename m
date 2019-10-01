Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03BC42AA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfJAV0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 17:26:44 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45180 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfJAV0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 17:26:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFPfJ-0004d8-P8; Tue, 01 Oct 2019 23:26:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: pass internal sta to ieee80211_tx_frags()
Date:   Tue,  1 Oct 2019 23:26:35 +0200
Message-Id: <1569965193-Id656db92703dded4bb2e3ec5dc329529f58e58f0@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This simplifies the code somewhat, and if necessary would let
us access the sta itself in that code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1fa422782905..938c10f7955b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1617,7 +1617,7 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 
 static bool ieee80211_tx_frags(struct ieee80211_local *local,
 			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
+			       struct sta_info *sta,
 			       struct sk_buff_head *skbs,
 			       bool txpending)
 {
@@ -1679,7 +1679,7 @@ static bool ieee80211_tx_frags(struct ieee80211_local *local,
 		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
 		info->control.vif = vif;
-		control.sta = sta;
+		control.sta = sta ? &sta->sta : NULL;
 
 		__skb_unlink(skb, skbs);
 		drv_tx(local, &control, skb);
@@ -1698,7 +1698,6 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info;
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_vif *vif;
-	struct ieee80211_sta *pubsta;
 	struct sk_buff *skb;
 	bool result = true;
 	__le16 fc;
@@ -1713,11 +1712,6 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 	if (sta && !sta->uploaded)
 		sta = NULL;
 
-	if (sta)
-		pubsta = &sta->sta;
-	else
-		pubsta = NULL;
-
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_MONITOR:
 		if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
@@ -1744,8 +1738,7 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 		break;
 	}
 
-	result = ieee80211_tx_frags(local, vif, pubsta, skbs,
-				    txpending);
+	result = ieee80211_tx_frags(local, vif, sta, skbs, txpending);
 
 	ieee80211_tpt_led_trig_tx(local, fc, led_len);
 
@@ -3529,7 +3522,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_sub_if_data, u.ap);
 
 	__skb_queue_tail(&tx.skbs, skb);
-	ieee80211_tx_frags(local, &sdata->vif, &sta->sta, &tx.skbs, false);
+	ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
 	return true;
 }
 
-- 
2.20.1

