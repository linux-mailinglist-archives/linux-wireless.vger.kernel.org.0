Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7281C30531B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 07:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhA0GUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 01:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhA0F7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 00:59:14 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C88C06178C
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BKHsgdfC9xJRT2Zc169eBLstSXJ+aQ4LY8SnDtVBMAM=; b=DXAWprsjagNiSZjwKwEHfiyzzT
        ZvgGjCwwMCiRtgXejvImCnKvhV9h3pxlCqAnO4JBQXn0YV4AA0QYKI3rP0LoEuEw+1fXy0rB5EHoE
        7AIgUXw+VVGQVqMhHhMDbaE4ro8GWv/CsKvPR8reSUt8VSzGghCTZdmWkBW2EQAN5qZo=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4dph-00083z-M7; Wed, 27 Jan 2021 06:57:37 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH RESEND v2 5/6] mac80211: minstrel_ht: show sampling rates in debugfs
Date:   Wed, 27 Jan 2021 06:57:34 +0100
Message-Id: <20210127055735.78599-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210127055735.78599-1-nbd@nbd.name>
References: <20210127055735.78599-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes it easier to see what rates are going to be tested next

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix duplicated line

 net/mac80211/rc80211_minstrel_ht_debugfs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 067d10383fa7..25b8a67a63a4 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -32,6 +32,18 @@ minstrel_stats_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static bool
+minstrel_ht_is_sample_rate(struct minstrel_ht_sta *mi, int idx)
+{
+	int type, i;
+
+	for (type = 0; type < ARRAY_SIZE(mi->sample); type++)
+		for (i = 0; i < MINSTREL_SAMPLE_RATES; i++)
+			if (mi->sample[type].cur_sample_rates[i] == idx)
+				return true;
+	return false;
+}
+
 static char *
 minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 {
@@ -84,6 +96,7 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		*(p++) = (idx == mi->max_tp_rate[2]) ? 'C' : ' ';
 		*(p++) = (idx == mi->max_tp_rate[3]) ? 'D' : ' ';
 		*(p++) = (idx == mi->max_prob_rate) ? 'P' : ' ';
+		*(p++) = minstrel_ht_is_sample_rate(mi, idx) ? 'S' : ' ';
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
 			p += sprintf(p, "  MCS%-2u", (mg->streams - 1) * 8 + j);
@@ -145,9 +158,9 @@ minstrel_ht_stats_open(struct inode *inode, struct file *file)
 
 	p += sprintf(p, "\n");
 	p += sprintf(p,
-		     "              best   ____________rate__________    ____statistics___    _____last____    ______sum-of________\n");
+		     "              best    ____________rate__________    ____statistics___    _____last____    ______sum-of________\n");
 	p += sprintf(p,
-		     "mode guard #  rate  [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]\n");
+		     "mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]\n");
 
 	p = minstrel_ht_stats_dump(mi, MINSTREL_CCK_GROUP, p);
 	for (i = 0; i < MINSTREL_CCK_GROUP; i++)
@@ -228,6 +241,7 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[2]) ? "C" : ""));
 		p += sprintf(p, "%s" ,((idx == mi->max_tp_rate[3]) ? "D" : ""));
 		p += sprintf(p, "%s" ,((idx == mi->max_prob_rate) ? "P" : ""));
+		p += sprintf(p, "%s", (minstrel_ht_is_sample_rate(mi, idx) ? "S" : ""));
 
 		if (gflags & IEEE80211_TX_RC_MCS) {
 			p += sprintf(p, ",MCS%-2u,", (mg->streams - 1) * 8 + j);
-- 
2.28.0

