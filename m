Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005437EF311
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjKQMz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 07:55:25 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B9D57
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 04:55:15 -0800 (PST)
X-UUID: 87bf2738854811ee8051498923ad61e6-20231117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xRuM7+uREsWw97r0WpzmzWvcBOL+63wfOGfZeXsZipM=;
        b=IhgeS2rpRA3YE6HhPDKig7xeuNh63W0TVcmu/WGKuHTwAP62zHxsZ4Nufpa2HRXbXanwKledcpWKgOP2Y3pekWfBS/m6n6+NIkeQIvYvSx+3ZbWMJHtacHa28gJis5s6S/Sf+RS1hDtQwad4CCOEtJ9SZ7WI/qIdS3R1HKli4Lo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:457acf1e-a191-4054-a043-6a5382141712,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:b52cc672-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87bf2738854811ee8051498923ad61e6-20231117
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 891341839; Fri, 17 Nov 2023 20:55:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 17 Nov 2023 20:55:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 17 Nov 2023 20:55:04 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Wang Zhao <wang.zhao@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921s: fix workqueue problem causes STA association fail
Date:   Fri, 17 Nov 2023 20:54:49 +0800
Message-ID: <d5c157113bb248ee9494c97d4ac236c299fec3ff.1700223271.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wang Zhao <wang.zhao@mediatek.com>

The ieee80211_queue_work function queues work into the mac80211
local->workqueue, which is widely used for mac80211 internal
work processes. In the mt76 driver, both the mt76-sido-status and
mt76-sdio-net threads enqueue workers to the workqueue with this
function. However, in some cases, when two workers are enqueued
to the workqueue almost simultaneously, the second worker may not
be scheduled immediately and may get stuck for a while.
This can cause timing issues. To avoid these timing
conflicts caused by worker scheduling, replace the worker
with an independent thread.

Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
Signed-off-by: Wang Zhao <wang.zhao@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h      |  3 +--
 .../net/wireless/mediatek/mt76/mt7615/sdio.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c   |  4 +++-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c   |  3 ++-
 drivers/net/wireless/mediatek/mt76/sdio.c      | 18 +++++++++++-------
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ea828ba0b83a..a17b2fbd693b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -575,8 +575,7 @@ struct mt76_sdio {
 	struct mt76_worker txrx_worker;
 	struct mt76_worker status_worker;
 	struct mt76_worker net_worker;
-
-	struct work_struct stat_work;
+	struct mt76_worker stat_worker;
 
 	u8 *xmit_buf;
 	u32 xmit_buf_sz;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index fc547a0031ea..67cedd2555f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -204,8 +204,8 @@ static int mt7663s_suspend(struct device *dev)
 	mt76_worker_disable(&mdev->mt76.sdio.txrx_worker);
 	mt76_worker_disable(&mdev->mt76.sdio.status_worker);
 	mt76_worker_disable(&mdev->mt76.sdio.net_worker);
+	mt76_worker_disable(&mdev->mt76.sdio.stat_worker);
 
-	cancel_work_sync(&mdev->mt76.sdio.stat_work);
 	clear_bit(MT76_READING_STATS, &mdev->mphy.state);
 
 	mt76_tx_status_check(&mdev->mt76, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index dc1beb76df3e..7591e54d2897 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -228,7 +228,7 @@ static int mt7921s_suspend(struct device *__dev)
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&mdev->tx_worker);
 	mt76_worker_disable(&mdev->sdio.status_worker);
-	cancel_work_sync(&mdev->sdio.stat_work);
+	mt76_worker_disable(&mdev->sdio.stat_worker);
 	clear_bit(MT76_READING_STATS, &dev->mphy.state);
 	mt76_tx_status_check(mdev, true);
 
@@ -260,6 +260,7 @@ static int mt7921s_suspend(struct device *__dev)
 restore_worker:
 	mt76_worker_enable(&mdev->tx_worker);
 	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.stat_worker);
 
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
@@ -292,6 +293,7 @@ static int mt7921s_resume(struct device *__dev)
 	mt76_worker_enable(&mdev->sdio.txrx_worker);
 	mt76_worker_enable(&mdev->sdio.status_worker);
 	mt76_worker_enable(&mdev->sdio.net_worker);
+	mt76_worker_enable(&mdev->sdio.stat_worker);
 
 	/* restore previous ds setting */
 	if (!pm->ds_enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 8edd0291c128..389eb0903807 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -107,7 +107,7 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
 	mt76_worker_disable(&dev->mt76.sdio.status_worker);
 	mt76_worker_disable(&dev->mt76.sdio.net_worker);
-	cancel_work_sync(&dev->mt76.sdio.stat_work);
+	mt76_worker_disable(&dev->mt76.sdio.stat_worker);
 
 	mt7921s_disable_irq(&dev->mt76);
 	mt7921s_wfsys_reset(dev);
@@ -115,6 +115,7 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
 	mt76_worker_enable(&dev->mt76.sdio.status_worker);
 	mt76_worker_enable(&dev->mt76.sdio.net_worker);
+	mt76_worker_enable(&dev->mt76.sdio.stat_worker);
 
 	dev->fw_assert = false;
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 419723118ded..c52d550f0c32 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -481,21 +481,21 @@ static void mt76s_status_worker(struct mt76_worker *w)
 		if (dev->drv->tx_status_data && ndata_frames > 0 &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state) &&
 		    !test_bit(MT76_STATE_SUSPEND, &dev->phy.state))
-			ieee80211_queue_work(dev->hw, &dev->sdio.stat_work);
+			mt76_worker_schedule(&sdio->stat_worker);
 	} while (nframes > 0);
 
 	if (resched)
 		mt76_worker_schedule(&dev->tx_worker);
 }
 
-static void mt76s_tx_status_data(struct work_struct *work)
+static void mt76s_tx_status_data(struct mt76_worker *worker)
 {
 	struct mt76_sdio *sdio;
 	struct mt76_dev *dev;
 	u8 update = 1;
 	u16 count = 0;
 
-	sdio = container_of(work, struct mt76_sdio, stat_work);
+	sdio = container_of(worker, struct mt76_sdio, stat_worker);
 	dev = container_of(sdio, struct mt76_dev, sdio);
 
 	while (true) {
@@ -508,7 +508,7 @@ static void mt76s_tx_status_data(struct work_struct *work)
 	}
 
 	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
-		ieee80211_queue_work(dev->hw, &sdio->stat_work);
+		mt76_worker_schedule(&sdio->status_worker);
 	else
 		clear_bit(MT76_READING_STATS, &dev->phy.state);
 }
@@ -600,8 +600,8 @@ void mt76s_deinit(struct mt76_dev *dev)
 	mt76_worker_teardown(&sdio->txrx_worker);
 	mt76_worker_teardown(&sdio->status_worker);
 	mt76_worker_teardown(&sdio->net_worker);
+	mt76_worker_teardown(&sdio->stat_worker);
 
-	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
 	mt76_tx_status_check(dev, true);
@@ -644,10 +644,14 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	if (err)
 		return err;
 
+	err = mt76_worker_setup(dev->hw, &sdio->stat_worker, mt76s_tx_status_data,
+				"sdio-sta");
+	if (err)
+		return err;
+
 	sched_set_fifo_low(sdio->status_worker.task);
 	sched_set_fifo_low(sdio->net_worker.task);
-
-	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
+	sched_set_fifo_low(sdio->stat_worker.task);
 
 	dev->queue_ops = &sdio_queue_ops;
 	dev->bus = bus_ops;
-- 
2.18.0

