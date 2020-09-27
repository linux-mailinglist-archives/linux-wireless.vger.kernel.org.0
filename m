Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2C27A08B
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0K4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgI0K4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 06:56:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6315C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8iDKmD/kp2M4ohOM6k3/iDqtrdLyy3ZbxZcGIscT4E8=; b=nPHJCNNcOap30N5fp+36pJMVIv
        HgYn8t7JBiEphY8h0ubzAn2b+SXwBFvk+7G+E38HBzFIumgoSrZbiFlv47ln46+5Xyc5HDGY33eBt
        95Q4oGjWTSMJp4qe0KukstPxX3D6WUVdanT5JRw46LgQIJDxQx74CtlJfuBdWwN5FwEM=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMULe-0007DK-Rw; Sun, 27 Sep 2020 12:56:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Georgi Valkov <gvalkov@abv.bg>
Subject: [PATCH v3] mac80211: fix regression in sta connection monitor
Date:   Sun, 27 Sep 2020 12:56:05 +0200
Message-Id: <20200927105605.97954-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a frame was acked and probe frames were sent, the connection monitoring
needs to be reset, otherwise it will keep probing until the connection is
considered dead, even though frames have been acked in the mean time.

Fixes: 9abf4e49830d ("mac80211: optimize station connection monitor")
Reported-by: Georgi Valkov <gvalkov@abv.bg>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v3: only queue work on nullfunc frames status
v2: reset connection monitor when a frame was acked (not just for nulldata)

 net/mac80211/mlme.c   |  4 +++-
 net/mac80211/status.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 50a9b9025725..7c04d8e30482 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2508,7 +2508,9 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 	    !sdata->u.mgd.probe_send_count)
 		return;
 
-	if (!ack)
+	if (ack)
+		sdata->u.mgd.probe_send_count = 0;
+	else
 		sdata->u.mgd.nullfunc_failed = true;
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 }
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 7fe5bececfd9..88a736f3c413 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -982,10 +982,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
 
-		if ((sta->sdata->vif.type == NL80211_IFTYPE_STATION) &&
-		    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
-			ieee80211_sta_tx_notify(sta->sdata, (void *) skb->data,
-						acked, info->status.tx_time);
 	}
 
 	/* SNMP counters
@@ -1120,11 +1116,18 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 	if (pubsta) {
+		struct ieee80211_sub_if_data *sdata = sta->sdata;
+
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
+			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+			    skb && !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
+				ieee80211_sta_tx_notify(sdata, (void *) skb->data,
+							acked, info->status.tx_time);
+
 			if (acked) {
 				sta->status_stats.last_ack = jiffies;
 
@@ -1134,6 +1137,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				/* Track when last packet was ACKed */
 				sta->status_stats.last_pkt_time = jiffies;
 
+				/* Reset connection monitor */
+				if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+				    unlikely(sdata->u.mgd.probe_send_count > 0))
+					sdata->u.mgd.probe_send_count = 0;
+
 				if (info->status.is_valid_ack_signal) {
 					sta->status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
-- 
2.28.0

