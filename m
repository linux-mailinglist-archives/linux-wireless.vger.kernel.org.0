Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73F42E720E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgL2QC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 11:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgL2QC0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 11:02:26 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578FC061796
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JuVHklXh3+qr+96gL8tswkfFmb2W3TeisauOl2TtJeM=; b=jRp7vrwYdWS0/q5hkY2mvz4d4e
        gfh0SdMXpgnPb0q3eRu8liubnhmo8cfez9/HwfsSbF4wHipvRUoO6jbc8z2YTJHh7ivSs47n6j+M6
        O/ifNG2mTfycj2R0BIqOcL4ygXnI+jP0x3DByUD3p+n7SI6n4Dv1BAs41kgsO9HsPbLs=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kuHRA-0005ka-Bf; Tue, 29 Dec 2020 17:01:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5/8] mac80211: minstrel_ht: improve ampdu length estimation
Date:   Tue, 29 Dec 2020 17:01:22 +0100
Message-Id: <20201229160125.92794-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201229160125.92794-1-nbd@nbd.name>
References: <20201229160125.92794-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the driver does not report A-MPDU length, estimate it based on the rate.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 38 +++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 62bb3c1b0bb5..950e6d2b4525 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -382,13 +382,37 @@ minstrel_get_ratestats(struct minstrel_ht_sta *mi, int index)
 	return &mi->groups[index / MCS_GROUP_RATES].rates[index % MCS_GROUP_RATES];
 }
 
+static inline int
+minstrel_get_duration(int index)
+{
+	const struct mcs_group *group = &minstrel_mcs_groups[index / MCS_GROUP_RATES];
+	unsigned int duration = group->duration[index % MCS_GROUP_RATES];
+	return duration << group->shift;
+}
+
 static unsigned int
 minstrel_ht_avg_ampdu_len(struct minstrel_ht_sta *mi)
 {
-	if (!mi->avg_ampdu_len)
-		return AVG_AMPDU_SIZE;
+	int duration;
+
+	if (mi->avg_ampdu_len)
+		return MINSTREL_TRUNC(mi->avg_ampdu_len);
+
+	if (minstrel_ht_is_legacy_group(mi->max_tp_rate[0] / MCS_GROUP_RATES))
+		return 1;
+
+	duration = minstrel_get_duration(mi->max_tp_rate[0]);
 
-	return MINSTREL_TRUNC(mi->avg_ampdu_len);
+	if (duration > 400 * 1000)
+		return 2;
+
+	if (duration > 250 * 1000)
+		return 4;
+
+	if (duration > 150 * 1000)
+		return 8;
+
+	return 16;
 }
 
 /*
@@ -588,14 +612,6 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 	}
 }
 
-static inline int
-minstrel_get_duration(int index)
-{
-	const struct mcs_group *group = &minstrel_mcs_groups[index / MCS_GROUP_RATES];
-	unsigned int duration = group->duration[index % MCS_GROUP_RATES];
-	return duration << group->shift;
-}
-
 static bool
 minstrel_ht_probe_group(struct minstrel_ht_sta *mi, const struct mcs_group *tp_group,
 						int tp_idx, const struct mcs_group *group)
-- 
2.28.0

