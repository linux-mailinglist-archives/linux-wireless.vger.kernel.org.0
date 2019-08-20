Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC395BB3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 11:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfHTJyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 05:54:51 -0400
Received: from nbd.name ([46.4.11.11]:35130 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfHTJyv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Poq5vLsP62rGfrtLYlDN3EnnaA5m+p4IQrkExi4z978=; b=DOrp2rcfG0jLbjM96Wvy8F8i1g
        INuo1kFA2s3HOhtJCckAI2CAy0aVeVxyovcnebKwCGGUyd47CKKLIPDhRDlrlLjgrwuNtlW1xztPW
        T0w1Teora2bt2IjhIpmkESKB7MPIwBupUtMq1Puf7qRZr6Jr3RnETB1/V3YruKNoi2js=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i00qn-0003nv-VR; Tue, 20 Aug 2019 11:54:50 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 5745D63E610B; Tue, 20 Aug 2019 11:54:49 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/4] mac80211: minstrel_ht: reduce unnecessary rate probing attempts
Date:   Tue, 20 Aug 2019 11:54:47 +0200
Message-Id: <20190820095449.45255-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190820095449.45255-1-nbd@nbd.name>
References: <20190820095449.45255-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On hardware with static fallback tables (e.g. mt76x2), rate probing attempts
can be very expensive.
On such devices, avoid sampling rates slower than the per-group max throughput
rate, based on the assumption that the fallback table will take care of probing
lower rates within that group if the higher rates fail.
To make this work, this also fixes a wrong initialization in the previously
unused per-group sorted rate array.
To further reduce unnecessary probing attempts, skip duplicate attempts on
rates slower than the max throughput rate.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index ba230b037257..ad5da9a71da0 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1059,6 +1059,21 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	    minstrel_get_duration(mi->max_prob_rate) * 3 < sample_dur)
 		return -1;
 
+
+	/*
+	 * For devices with no configurable multi-rate retry, skip sampling
+	 * below the per-group max throughput rate, and only use one sampling
+	 * attempt per rate
+	 */
+	if (mp->hw->max_rates == 1 &&
+	    (minstrel_get_duration(mg->max_group_tp_rate[0]) < sample_dur ||
+	     mrs->attempts))
+		return -1;
+
+	/* Skip already sampled slow rates */
+	if (sample_dur >= minstrel_get_duration(tp_rate1) && mrs->attempts)
+		return -1;
+
 	/*
 	 * Make sure that lower rates get sampled only occasionally,
 	 * if the link is working perfectly.
-- 
2.17.0

