Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB45305319
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 07:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhA0GT4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 01:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhA0F7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 00:59:14 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40786C061793
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=edX+M8/W3hxSQgANZOSz1K7PwQ3V5B7Mpzz7uUVgGJY=; b=FNrX/o5mtfpNoeWA4MTGNc16kd
        pNyMf88w12k6dZOUzI1e0HuKbVtG3CYozvr3zBbdWxCQN/KXEWctcCTzQ1pGTgz6Tgs7N8s4Nqi4e
        qrYuM+zVVuGK/bp1xfluAERFuGXezobTTZz2DyukB/AQu10lUgG98lU5l5/aWsNcMHLc=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4dph-00083z-1O; Wed, 27 Jan 2021 06:57:37 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH RESEND v2 2/6] mac80211: minstrel_ht: update total packets counter in tx status path
Date:   Wed, 27 Jan 2021 06:57:31 +0100
Message-Id: <20210127055735.78599-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210127055735.78599-1-nbd@nbd.name>
References: <20210127055735.78599-1-nbd@nbd.name>
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

