Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10266284B41
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgJFMAJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 08:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgJFMAI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 08:00:08 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9802083B;
        Tue,  6 Oct 2020 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601985607;
        bh=NkwbxMnYvYZbXOknbFpt/KhuxR0mEcWp4lx0U0sP25g=;
        h=From:To:Cc:Subject:Date:From;
        b=GDCm2vgd537GOMGcQnGNDV2KdrJ/sDVj6cx88zxzKk9ILzYvmGeiFseOrmGeedMs2
         KKxTI2nBSWjkxTSPwr7Q8l449IY8SSHy28pv/KeYs+343Y6R58Sks0VpgU9GWMT1HU
         buo/XO79zSkq5ZmjnqScE4lGHFjA8fqJs5AcY0bI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: sdio: get rid of sched.lock
Date:   Tue,  6 Oct 2020 14:00:01 +0200
Message-Id: <9ea75bd8b2d234a2073e416e3ebd0b413e1f61a2.1601985414.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sched quota is now updated in mt7663s_txrx_worker so there is no more
need of sched.lock mutex

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 21 +++++++------------
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |  4 ----
 drivers/net/wireless/mediatek/mt76/sdio.c     |  1 -
 4 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b8765548e3a4..ca724805eb69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -458,7 +458,6 @@ struct mt76_sdio {
 	void *intr_data;
 
 	struct {
-		struct mutex lock;
 		int pse_data_quota;
 		int ple_data_quota;
 		int pse_mcu_quota;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 38670c00380c..0e8cad025657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -19,23 +19,18 @@
 static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
-	u32 pse0, ple, pse1, txdwcnt;
-
-	pse0 = mt76_get_field(dev, MT_PSE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
-	pse1 = mt76_get_field(dev, MT_PSE_PG_HIF1_GROUP, MT_HIF1_MIN_QUOTA);
-	ple = mt76_get_field(dev, MT_PLE_PG_HIF0_GROUP, MT_HIF0_MIN_QUOTA);
+	u32 txdwcnt;
+
+	sdio->sched.pse_data_quota = mt76_get_field(dev, MT_PSE_PG_HIF0_GROUP,
+						    MT_HIF0_MIN_QUOTA);
+	sdio->sched.pse_mcu_quota = mt76_get_field(dev, MT_PSE_PG_HIF1_GROUP,
+						   MT_HIF1_MIN_QUOTA);
+	sdio->sched.ple_data_quota = mt76_get_field(dev, MT_PLE_PG_HIF0_GROUP,
+						    MT_HIF0_MIN_QUOTA);
 	txdwcnt = mt76_get_field(dev, MT_PP_TXDWCNT,
 				 MT_PP_TXDWCNT_TX1_ADD_DW_CNT);
-
-	mutex_lock(&sdio->sched.lock);
-
-	sdio->sched.pse_data_quota = pse0;
-	sdio->sched.ple_data_quota = ple;
-	sdio->sched.pse_mcu_quota = pse1;
 	sdio->sched.deficit = txdwcnt << 2;
 
-	mutex_unlock(&sdio->sched.lock);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 77377c208064..e46ed4b94bc5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -46,11 +46,9 @@ static int mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 	if (!pse_data_quota && !ple_data_quota && !pse_mcu_quota)
 		return 0;
 
-	mutex_lock(&sdio->sched.lock);
 	sdio->sched.pse_mcu_quota += pse_mcu_quota;
 	sdio->sched.pse_data_quota += pse_data_quota;
 	sdio->sched.ple_data_quota += ple_data_quota;
-	mutex_unlock(&sdio->sched.lock);
 
 	return pse_data_quota + ple_data_quota + pse_mcu_quota;
 }
@@ -193,14 +191,12 @@ static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 static void mt7663s_tx_update_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 				    int pse_size, int ple_size)
 {
-	mutex_lock(&sdio->sched.lock);
 	if (qid == MT_TXQ_MCU) {
 		sdio->sched.pse_mcu_quota -= pse_size;
 	} else {
 		sdio->sched.pse_data_quota -= pse_size;
 		sdio->sched.ple_data_quota -= ple_size;
 	}
-	mutex_unlock(&sdio->sched.lock);
 }
 
 static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 41e832b11199..b4def262e1a0 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -350,7 +350,6 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 
 	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
 
-	mutex_init(&sdio->sched.lock);
 	dev->queue_ops = &sdio_queue_ops;
 	dev->bus = bus_ops;
 	dev->sdio.func = func;
-- 
2.26.2

