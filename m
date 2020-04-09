Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53DB1A3291
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIKg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 06:36:57 -0400
Received: from nbd.name ([46.4.11.11]:34554 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgDIKg4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 06:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TZLOxHmiLz73vpijPk3ibwC0OYFpWwcNMOAJ1jqgYiM=; b=VNyMiQAGwnPQnKzeHeirCRa/LA
        AW1m0mCIEnJJ79Z1nMKDbWlPjXZcd/LSKNcOTCEHiX6QQhdPFQw5nKT69j9HqrSdHli12K19TZhdp
        7qnNDSGKJr/bKEnXZvB9tSY127I15lPLz0EOpL2v2Tk/J9WqDBeQD4lWhzwtlRWtPSXc=;
Received: from p54ae91d1.dip0.t-ipconnect.de ([84.174.145.209] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jMUYK-0006wj-5f
        for linux-wireless@vger.kernel.org; Thu, 09 Apr 2020 12:36:56 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id C0C81828F03B; Thu,  9 Apr 2020 12:36:55 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] mt76: mt7615: disable hw/sched scan ops for non-offload firmware
Date:   Thu,  9 Apr 2020 12:36:54 +0200
Message-Id: <20200409103655.94536-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid having to attempt hw scan and fall back to software for every scan
on devices/firmware without hw scan support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 07d4b259fe8a..7f3683205b8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -143,6 +143,13 @@ static void mt7615_init_work(struct work_struct *work)
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
 	mt7615_mcu_del_wtbl_all(dev);
+
+	if (!mt7615_firmware_offload(dev)) {
+		dev->ops->hw_scan = NULL;
+		dev->ops->cancel_hw_scan = NULL;
+		dev->ops->sched_scan_start = NULL;
+		dev->ops->sched_scan_stop = NULL;
+	}
 }
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index d2eff5442824..3849bb6b49d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -139,11 +139,16 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
 	};
+	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
 
-	mdev = mt76_alloc_device(pdev, sizeof(*dev), &mt7615_ops, &drv_ops);
+	ops = devm_kmemdup(pdev, &mt7615_ops, sizeof(mt7615_ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
 
@@ -151,6 +156,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	mt76_mmio_init(&dev->mt76, mem_base);
 
 	dev->reg_map = map;
+	dev->ops = ops;
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 65a2b30fc588..4f0d29e5e595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -235,6 +235,7 @@ struct mt7615_dev {
 
 	u16 chainmask;
 
+	struct ieee80211_ops *ops;
 	const struct mt7615_mcu_ops *mcu_ops;
 	struct regmap *infracfg;
 	const u32 *reg_map;
-- 
2.24.0

