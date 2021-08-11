Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A810A3E9A81
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhHKVpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:47 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:58416 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232201AbhHKVpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:17 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.179])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D1CAA2A0067
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A661EAC0081
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0927A13C2B5;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0927A13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718290;
        bh=zeyhZ7B9mfXwbjo2UzCDgiCnhZgbZWzmLgZvyfjtUz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1SJmyeFCLKA10jRyAkntUYaTBB6Cv46brwHcblgGs6XNYssH4NXeP/jRaXk/XLGN
         6djUNab5+Zc+5tVsViZWsME4AGbpCLSuYIKwvYYlRUW7zEotoRs7g+pIBGSH8jUgUD
         RASpb+RQ7j7je9vzwjiL/EN2CbqTrs4oIlpPeIqc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 03/15] mt76: mt7915:  tx_stats debugfs to read from mib
Date:   Wed, 11 Aug 2021 14:44:27 -0700
Message-Id: <20210811214439.17458-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718291-kLyjWr3fNvOg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Read from accumulated mib values instead of directly from
registers since registers are clear-on-read.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index f2ff0d3f52cd..b48fda497ab6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -444,7 +444,9 @@ static int
 mt7915_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
-	int stat[8], i, n;
+	int i;
+	long n;
+	struct mib_stats *mib = &dev->phy.mib;
 
 	mt7915_ampdu_stat_read_phy(&dev->phy, file);
 	mt7915_txbf_stat_read_phy(&dev->phy, file);
@@ -454,16 +456,16 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 	/* Tx amsdu info */
 	seq_puts(file, "Tx MSDU statistics:\n");
-	for (i = 0, n = 0; i < ARRAY_SIZE(stat); i++) {
-		stat[i] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
-		n += stat[i];
-	}
+	for (i = 0, n = 0; i < ARRAY_SIZE(mib->amsdu_pack_stats); i++)
+		n += mib->amsdu_pack_stats[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->amsdu_pack_stats); i++) {
+		long si = mib->amsdu_pack_stats[i];
 
-	for (i = 0; i < ARRAY_SIZE(stat); i++) {
-		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: 0x%x ",
-			   i + 1, stat[i]);
+		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %ld ",
+			   i + 1, si);
 		if (n != 0)
-			seq_printf(file, "(%d%%)\n", stat[i] * 100 / n);
+			seq_printf(file, "(%ld%%)\n", si * 100 / n);
 		else
 			seq_puts(file, "\n");
 	}
-- 
2.20.1

