Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C731301BD8
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jan 2021 13:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAXM3E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jan 2021 07:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbhAXM26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jan 2021 07:28:58 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E09C061574
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jan 2021 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VEQzgM3AI4cc/JK4D7EIuR2iFs3zfdqNXJtHjnCv2g8=; b=DzWCSv2UVwh8brB40wKncrZn+G
        65+fR62P5n7j/azRCxeBK5OJxlfeTscAtipnp2dOH7haX6tcV7zCu6DbYCmEu5xFpcJ3fjo4kKy17
        oAuRw8IzKgEPpZKN3ZcT398hNhO18Ukh1ZajlLBF+QQpDt7v6imQuy+wXhQEfyZ4ypXY=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l3eV4-00074g-0d; Sun, 24 Jan 2021 13:28:14 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/6] mac80211: minstrel_ht: update total packets counter in tx status path
Date:   Sun, 24 Jan 2021 13:28:08 +0100
Message-Id: <20210124122812.49929-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210124122812.49929-1-nbd@nbd.name>
References: <20210124122812.49929-1-nbd@nbd.name>
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
index a3b86fd300f0..2ef748ca5355 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1093,6 +1093,16 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
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
 
@@ -1104,9 +1114,6 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 		mi->sample_count--;
 	}
 
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)
-		mi->sample_packets += info->status.ampdu_len;
-
 	if (mi->sample_mode != MINSTREL_SAMPLE_IDLE)
 		rate_sample = minstrel_get_ratestats(mi, mi->sample_rate);
 
@@ -1504,14 +1511,6 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
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

