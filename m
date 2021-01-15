Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE252F7837
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbhAOMDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbhAOMDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:03:32 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AAAC061798
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BI4dOLn6XJIWPSJsw9SU6tEKGEplQ+jrmF4XJ2pqXKM=; b=OOLlN2GDr3q4llWQZkWxTnbUMF
        M35BgPEOshPmyR0tiSWEQpgmTBrg1i4TNiAQtB6t8Tr1Rah9A8Beo91o8gNbc9Y7fSfSTHIVD9qjp
        lhlD744ITf1t6g7XYC5VufsROz86e9Nc8rWXNztxO7LrzZTh9tYx6cWRgRVjnN2qGTX0=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l0NoT-0006Y0-Ha; Fri, 15 Jan 2021 13:02:45 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 1/9] mac80211: minstrel_ht: clean up CCK code
Date:   Fri, 15 Jan 2021 13:02:34 +0100
Message-Id: <20210115120242.89616-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210115120242.89616-1-nbd@nbd.name>
References: <20210115120242.89616-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- move ack overhead out of rate duration table
- remove cck_supported, cck_supported_short

Preparation for adding OFDM legacy rates support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 54 +++++++++++++++++-------------
 net/mac80211/rc80211_minstrel_ht.h |  5 ++-
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index b11a2af55b06..167d4fa5adf1 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -136,20 +136,16 @@
 	__VHT_GROUP(_streams, _sgi, _bw,				\
 		    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
 
-#define CCK_DURATION(_bitrate, _short, _len)		\
+#define CCK_DURATION(_bitrate, _short)			\
 	(1000 * (10 /* SIFS */ +			\
 	 (_short ? 72 + 24 : 144 + 48) +		\
-	 (8 * (_len + 4) * 10) / (_bitrate)))
-
-#define CCK_ACK_DURATION(_bitrate, _short)			\
-	(CCK_DURATION((_bitrate > 10 ? 20 : 10), false, 60) +	\
-	 CCK_DURATION(_bitrate, _short, AVG_PKT_SIZE))
+	 (8 * (AVG_PKT_SIZE + 4) * 10) / (_bitrate)))
 
 #define CCK_DURATION_LIST(_short, _s)			\
-	CCK_ACK_DURATION(10, _short) >> _s,		\
-	CCK_ACK_DURATION(20, _short) >> _s,		\
-	CCK_ACK_DURATION(55, _short) >> _s,		\
-	CCK_ACK_DURATION(110, _short) >> _s
+	CCK_DURATION(10, _short) >> _s,			\
+	CCK_DURATION(20, _short) >> _s,			\
+	CCK_DURATION(55, _short) >> _s,			\
+	CCK_DURATION(110, _short) >> _s
 
 #define __CCK_GROUP(_s)					\
 	[MINSTREL_CCK_GROUP] = {			\
@@ -163,7 +159,7 @@
 	}
 
 #define CCK_GROUP_SHIFT					\
-	GROUP_SHIFT(CCK_ACK_DURATION(10, false))
+	GROUP_SHIFT(CCK_DURATION(10, false))
 
 #define CCK_GROUP __CCK_GROUP(CCK_GROUP_SHIFT)
 
@@ -349,15 +345,19 @@ int
 minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
 		       int prob_avg)
 {
-	unsigned int nsecs = 0;
+	unsigned int nsecs = 0, overhead = mi->overhead;
+	unsigned int ampdu_len = 1;
 
 	/* do not account throughput if sucess prob is below 10% */
 	if (prob_avg < MINSTREL_FRAC(10, 100))
 		return 0;
 
-	if (group != MINSTREL_CCK_GROUP)
-		nsecs = 1000 * mi->overhead / minstrel_ht_avg_ampdu_len(mi);
+	if (group == MINSTREL_CCK_GROUP)
+		overhead = mi->overhead_legacy;
+	else
+		ampdu_len = minstrel_ht_avg_ampdu_len(mi);
 
+	nsecs = 1000 * overhead / ampdu_len;
 	nsecs += minstrel_mcs_groups[group].duration[rate] <<
 		 minstrel_mcs_groups[group].shift;
 
@@ -1031,7 +1031,10 @@ minstrel_calc_retransmit(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	ctime += (t_slot * cw) >> 1;
 	cw = min((cw << 1) | 1, mp->cw_max);
 
-	if (index / MCS_GROUP_RATES != MINSTREL_CCK_GROUP) {
+	if (index / MCS_GROUP_RATES == MINSTREL_CCK_GROUP) {
+		overhead = mi->overhead_legacy;
+		overhead_rtscts = mi->overhead_legacy_rtscts;
+	} else {
 		overhead = mi->overhead;
 		overhead_rtscts = mi->overhead_rtscts;
 	}
@@ -1369,18 +1372,14 @@ minstrel_ht_update_cck(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (!ieee80211_hw_check(mp->hw, SUPPORTS_HT_CCK_RATES))
 		return;
 
-	mi->cck_supported = 0;
-	mi->cck_supported_short = 0;
 	for (i = 0; i < 4; i++) {
 		if (!rate_supported(sta, sband->band, mp->cck_rates[i]))
 			continue;
 
-		mi->cck_supported |= BIT(i);
+		mi->supported[MINSTREL_CCK_GROUP] |= BIT(i);
 		if (sband->bitrates[i].flags & IEEE80211_RATE_SHORT_PREAMBLE)
-			mi->cck_supported_short |= BIT(i);
+			mi->supported[MINSTREL_CCK_GROUP] |= BIT(i + 4);
 	}
-
-	mi->supported[MINSTREL_CCK_GROUP] = mi->cck_supported;
 }
 
 static void
@@ -1394,12 +1393,13 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
 	u16 ht_cap = sta->ht_cap.cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	const struct ieee80211_rate *ctl_rate;
+	bool ldpc, erp;
 	int use_vht;
 	int n_supported = 0;
 	int ack_dur;
 	int stbc;
 	int i;
-	bool ldpc;
 
 	/* fall back to the old minstrel for legacy stations */
 	if (!sta->ht_cap.ht_supported)
@@ -1423,6 +1423,14 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	mi->overhead += ack_dur;
 	mi->overhead_rtscts = mi->overhead + 2 * ack_dur;
 
+	ctl_rate = &sband->bitrates[rate_lowest_index(sband, sta)];
+	erp = ctl_rate->flags & IEEE80211_RATE_ERP_G;
+	ack_dur = ieee80211_frame_duration(sband->band, 10,
+					   ctl_rate->bitrate, erp, 1,
+					   ieee80211_chandef_get_shift(chandef));
+	mi->overhead_legacy = ack_dur;
+	mi->overhead_legacy_rtscts = mi->overhead_legacy + 2 * ack_dur;
+
 	mi->avg_ampdu_len = MINSTREL_FRAC(1, 1);
 
 	/* When using MRR, sample more on the first attempt, without delay */
@@ -1523,8 +1531,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	if (!n_supported)
 		goto use_legacy;
 
-	mi->supported[MINSTREL_CCK_GROUP] |= mi->cck_supported_short << 4;
-
 	/* create an initial rate table with the lowest supported rates */
 	minstrel_ht_update_stats(mp, mi, true);
 	minstrel_ht_update_rates(mp, mi);
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 53ea3c29debf..11300fa48a2f 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -77,6 +77,8 @@ struct minstrel_ht_sta {
 	/* overhead time in usec for each frame */
 	unsigned int overhead;
 	unsigned int overhead_rtscts;
+	unsigned int overhead_legacy;
+	unsigned int overhead_legacy_rtscts;
 
 	unsigned int total_packets_last;
 	unsigned int total_packets_cur;
@@ -97,9 +99,6 @@ struct minstrel_ht_sta {
 	/* current MCS group to be sampled */
 	u8 sample_group;
 
-	u8 cck_supported;
-	u8 cck_supported_short;
-
 	/* Bitfield of supported MCS rates of all groups */
 	u16 supported[MINSTREL_GROUPS_NB];
 
-- 
2.28.0

