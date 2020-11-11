Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC92AF7FC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKKSeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKKSeD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:34:03 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2AFC0613D6
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dz2DRR9i0fRfaxiLwsQafWog5cdT7CbKtSG0ryPQeyQ=; b=bxyi94ytTaYp/IvUZFKMLj2ba3
        9Pjd1UFe/MC2e+OQL5PJrjSeOu+b2TyIuXb2c2ueQjoo3gsr1sPBWB5KkU/2X3GjczS1t2e7SpYR/
        pLtW8QSVWsAA30pCCFIUKgfhO4r3iJ+aePCCTTvIj/a4oF6IaQS/G0cYoCRbG1n9u4n4=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kcuwT-00034H-0G; Wed, 11 Nov 2020 19:34:01 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.10 2/3] mac80211: minstrel: remove deferred sampling code
Date:   Wed, 11 Nov 2020 19:33:58 +0100
Message-Id: <20201111183359.43528-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111183359.43528-1-nbd@nbd.name>
References: <20201111183359.43528-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Deferring sampling attempts to the second stage has some bad interactions
with drivers that process the rate table in hardware and use the probe flag
to indicate probing packets (e.g. most mt76 drivers). On affected drivers
it can lead to probing not working at all.

If the link conditions turn worse, it might not be such a good idea to
do a lot of sampling for lower rates in this case.

Fix this by simply skipping the sample attempt instead of deferring it,
but keep the checks that would allow it to be sampled if it was skipped
too often, but only if it has less than 95% success probability.

Also ensure that IEEE80211_TX_CTL_RATE_CTRL_PROBE is set for all probing
packets.

Cc: stable@vger.kernel.org
Fixes: cccf129f820e ("mac80211: add the 'minstrel' rate control algorithm")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.c | 25 ++++---------------------
 net/mac80211/rc80211_minstrel.h |  1 -
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index 86bc469a28bc..a8a940e97a9a 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -287,12 +287,6 @@ minstrel_tx_status(void *priv, struct ieee80211_supported_band *sband,
 			mi->r[ndx].stats.success += success;
 	}
 
-	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && (i >= 0))
-		mi->sample_packets++;
-
-	if (mi->sample_deferred > 0)
-		mi->sample_deferred--;
-
 	if (time_after(jiffies, mi->last_stats_update +
 				mp->update_interval / (mp->new_avg ? 2 : 1)))
 		minstrel_update_stats(mp, mi);
@@ -367,7 +361,7 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 		return;
 
 	delta = (mi->total_packets * sampling_ratio / 100) -
-			(mi->sample_packets + mi->sample_deferred / 2);
+			mi->sample_packets;
 
 	/* delta < 0: no sampling required */
 	prev_sample = mi->prev_sample;
@@ -376,7 +370,6 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 		return;
 
 	if (mi->total_packets >= 10000) {
-		mi->sample_deferred = 0;
 		mi->sample_packets = 0;
 		mi->total_packets = 0;
 	} else if (delta > mi->n_rates * 2) {
@@ -401,19 +394,8 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 	 * rate sampling method should be used.
 	 * Respect such rates that are not sampled for 20 interations.
 	 */
-	if (mrr_capable &&
-	    msr->perfect_tx_time > mr->perfect_tx_time &&
-	    msr->stats.sample_skipped < 20) {
-		/* Only use IEEE80211_TX_CTL_RATE_CTRL_PROBE to mark
-		 * packets that have the sampling rate deferred to the
-		 * second MRR stage. Increase the sample counter only
-		 * if the deferred sample rate was actually used.
-		 * Use the sample_deferred counter to make sure that
-		 * the sampling is not done in large bursts */
-		info->flags |= IEEE80211_TX_CTL_RATE_CTRL_PROBE;
-		rate++;
-		mi->sample_deferred++;
-	} else {
+	if (msr->perfect_tx_time < mr->perfect_tx_time ||
+	    msr->stats.sample_skipped >= 20) {
 		if (!msr->sample_limit)
 			return;
 
@@ -433,6 +415,7 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 
 	rate->idx = mi->r[ndx].rix;
 	rate->count = minstrel_get_retry_count(&mi->r[ndx], info);
+	info->flags |= IEEE80211_TX_CTL_RATE_CTRL_PROBE;
 }
 
 
diff --git a/net/mac80211/rc80211_minstrel.h b/net/mac80211/rc80211_minstrel.h
index dbb43bcd3c45..86cd80b3ffde 100644
--- a/net/mac80211/rc80211_minstrel.h
+++ b/net/mac80211/rc80211_minstrel.h
@@ -126,7 +126,6 @@ struct minstrel_sta_info {
 	u8 max_prob_rate;
 	unsigned int total_packets;
 	unsigned int sample_packets;
-	int sample_deferred;
 
 	unsigned int sample_row;
 	unsigned int sample_column;
-- 
2.28.0

