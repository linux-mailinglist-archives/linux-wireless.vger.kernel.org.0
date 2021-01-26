Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63132305C7A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 14:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313788AbhAZWqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 17:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392362AbhAZS7A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 13:59:00 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29EEC06178B
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=edX+M8/W3hxSQgANZOSz1K7PwQ3V5B7Mpzz7uUVgGJY=; b=qQ7puUex5EQFavo0JdlMgzpqqP
        L6I/k2D2WHyCIOCvZRTxC0RlRuieo5HdO7Zzik8lrm+F2KM3V3N6U0Lixl240/51ZRiG7QKSmKQTT
        9HVtZZ/he2WvV52FU35F/7/aHOuqn0tPUC1DWgIpYLK3NPJjROgPeZqqnVAWg/KfPOZQ=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4TXU-0003cb-8y; Tue, 26 Jan 2021 19:58:08 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 2/6] mac80211: minstrel_ht: update total packets counter in tx status path
Date:   Tue, 26 Jan 2021 19:58:02 +0100
Message-Id: <20210126185806.61770-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210126185806.61770-1-nbd@nbd.name>
References: <20210126185806.61770-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Keep the update in one place and prepare for further rework

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 8974c3510489..7846782840a9 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1092,6 +1092,16 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 		info->status.ampdu_len = 1;
 	}
 
+	/* wraparound */
+	if (mi->total_packets >= ~0 - info->status.ampdu_len) {
+		mi->total_packets = 0;
+		mi->sample_packets = 0;
+	}
+
+	mi->total_packets += info->status.ampdu_len;
+	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)
+		mi->sample_packets += info->status.ampdu_len;
+
 	mi->ampdu_packets++;
 	mi->ampdu_len += info->status.ampdu_len;
 
@@ -1103,9 +1113,6 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 		mi->sample_count--;
 	}
 
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)
-		mi->sample_packets += info->status.ampdu_len;
-
 	if (mi->sample_mode != MINSTREL_SAMPLE_IDLE)
 		rate_sample = minstrel_get_ratestats(mi, mi->sample_rate);
 
@@ -1503,14 +1510,6 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	else
 		sample_idx = minstrel_get_sample_rate(mp, mi);
 
-	mi->total_packets++;
-
-	/* wraparound */
-	if (mi->total_packets == ~0) {
-		mi->total_packets = 0;
-		mi->sample_packets = 0;
-	}
-
 	if (sample_idx < 0)
 		return;
 
-- 
2.28.0

