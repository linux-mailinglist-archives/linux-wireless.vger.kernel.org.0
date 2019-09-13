Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF6B18A1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfIMHGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 03:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHGH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 03:06:07 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBE220830;
        Fri, 13 Sep 2019 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568358366;
        bh=/KJXOJOn/9y6jfTC+vnGIuaDwPVZ75bGj3fRqQRnCDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PauNCBfxuPTOrffSnjMb9CzptzCMsVZlai6OqI1bxcT+whLDhBqeloDmm7KUdLmsX
         2IdXTwgEi0kNbh0eM+3qJBntWspe3yztLB3tu5kRz0wJVO2vdp16ZwC/3cCDtr23sj
         U7I15pRXFo+f1nMcwsZK6Q3dnD1xnn76bU6u0yKI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 3/5] mt76: move aggr_stats array in mt76_dev
Date:   Fri, 13 Sep 2019 09:05:52 +0200
Message-Id: <517445b2f1485e8c2846d0f501e40cf8e4a2be49.1568358061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568358061.git.lorenzo@kernel.org>
References: <cover.1568358061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move aggr_stats array from mt76x02_dev to mt76_dev in order to be reused
adding aggregation stats for mt7603/mt7615 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02.h         | 2 --
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     | 6 +++---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 69ca21af5b0b..0054542f6f9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -462,6 +462,8 @@ struct mt76_dev {
 	u32 rev;
 	unsigned long state;
 
+	u32 aggr_stats[32];
+
 	u8 antenna_mask;
 	u16 chainmask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index e858bba8c8ff..50b0131f85bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -92,8 +92,6 @@ struct mt76x02_dev {
 
 	const struct mt76x02_beacon_ops *beacon_ops;
 
-	u32 aggr_stats[32];
-
 	struct sk_buff *beacons[8];
 	u8 beacon_data_mask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 186838128c55..68b40d63a46d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -19,7 +19,8 @@ mt76x02_ampdu_stat_read(struct seq_file *file, void *data)
 		seq_puts(file, "\n");
 		seq_puts(file, "Count:  ");
 		for (j = 0; j < 8; j++)
-			seq_printf(file, "%8d | ", dev->aggr_stats[i * 8 + j]);
+			seq_printf(file, "%8d | ",
+				   dev->mt76.aggr_stats[i * 8 + j]);
 		seq_puts(file, "\n");
 		seq_puts(file, "--------");
 		for (j = 0; j < 8; j++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index c681601f9114..0d000906b2e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -24,7 +24,7 @@ void mt76x02_mac_reset_counters(struct mt76x02_dev *dev)
 	for (i = 0; i < 16; i++)
 		mt76_rr(dev, MT_TX_STAT_FIFO);
 
-	memset(dev->aggr_stats, 0, sizeof(dev->aggr_stats));
+	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_reset_counters);
 
@@ -1119,8 +1119,8 @@ void mt76x02_mac_work(struct work_struct *work)
 	for (i = 0, idx = 0; i < 16; i++) {
 		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
 
-		dev->aggr_stats[idx++] += val & 0xffff;
-		dev->aggr_stats[idx++] += val >> 16;
+		dev->mt76.aggr_stats[idx++] += val & 0xffff;
+		dev->mt76.aggr_stats[idx++] += val >> 16;
 	}
 
 	if (!dev->mt76.beacon_mask)
-- 
2.21.0

