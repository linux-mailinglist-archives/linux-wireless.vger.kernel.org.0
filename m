Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90D95BB2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHTJyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 05:54:51 -0400
Received: from nbd.name ([46.4.11.11]:35126 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTJyv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sbJGifAP2hJqOW3Xo1SlJAcr8ALTVQTYf9HL5FatkPg=; b=aigo6H0lvuwf8n6qHtEd5NBwle
        qQszuQuXw5eUKAyh73tTrIMNSF5j1CG4qOTBcPTHB0ZjEwTvvoyhL1t0S5fWIO2waXcO2BjvAXdXC
        7NABYcNZINUF36HnZD76yeNo53yYDAxqPufFVh0SAtwU12osU3oeTWzu9wZsk8y5p5M0=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i00qn-0003nw-VR; Tue, 20 Aug 2019 11:54:50 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 57C3763E610D; Tue, 20 Aug 2019 11:54:49 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 3/4] mac80211: minstrel_ht: fix default max throughput rate indexes
Date:   Tue, 20 Aug 2019 11:54:48 +0200
Message-Id: <20190820095449.45255-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190820095449.45255-1-nbd@nbd.name>
References: <20190820095449.45255-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the first supported rate instead of 0 (which can be invalid)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index ad5da9a71da0..c5868a1de306 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -486,7 +486,7 @@ minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_ewma;
 	tmp_mcs_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
-	if (tmp_cck_tp > tmp_mcs_tp) {
+	if (tmp_cck_tp_rate && tmp_cck_tp > tmp_mcs_tp) {
 		for(i = 0; i < MAX_THR_RATES; i++) {
 			minstrel_ht_sort_best_tp_rates(mi, tmp_cck_tp_rate[i],
 						       tmp_mcs_tp_rate);
@@ -558,11 +558,19 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	mi->sample_slow = 0;
 	mi->sample_count = 0;
 
-	/* Initialize global rate indexes */
-	for(j = 0; j < MAX_THR_RATES; j++){
-		tmp_mcs_tp_rate[j] = 0;
-		tmp_cck_tp_rate[j] = 0;
-	}
+	memset(tmp_mcs_tp_rate, 0, sizeof(tmp_mcs_tp_rate));
+	memset(tmp_cck_tp_rate, 0, sizeof(tmp_cck_tp_rate));
+	if (mi->supported[MINSTREL_CCK_GROUP])
+		for (j = 0; j < ARRAY_SIZE(tmp_cck_tp_rate); j++)
+			tmp_cck_tp_rate[j] = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+
+	if (mi->supported[MINSTREL_VHT_GROUP_0])
+		index = MINSTREL_VHT_GROUP_0 * MCS_GROUP_RATES;
+	else
+		index = MINSTREL_HT_GROUP_0 * MCS_GROUP_RATES;
+
+	for (j = 0; j < ARRAY_SIZE(tmp_mcs_tp_rate); j++)
+		tmp_mcs_tp_rate[j] = index;
 
 	/* Find best rate sets within all MCS groups*/
 	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
-- 
2.17.0

