Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50C7128D64
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLVKdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:49 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E360E208C3;
        Sun, 22 Dec 2019 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010828;
        bh=sdEN17P045t1pqEVL4WQhAnU7/TgPz3LOOj6tzd/5Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8QtFEX/q5pGEv3E9ujawcWtjHYXXD5UPDp6Vqd7OUlnBMJjNIsh86bEF0r0axnuA
         +2sqDm4+mnlqWCeEyuFxVigmzPtWZg1F4DXI/KfLosfCe0VfJvo2yTh6EFieA3T764
         08NGtsKvmzdw8Ajn5AOm43GhCxf6Vro8Sz5QUWkk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 07/18] mt76: mt76u: move mcu buffer allocation in mt76x02u drivers
Date:   Sun, 22 Dec 2019 11:33:09 +0100
Message-Id: <d7bf5b5a94fd97eac7d5e8d8dfd64e19b27fe52d.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mcu buffer allocation in mt76x2u/mt76x0u drivers since newer
chipsets (e.g. mt7763u) does not rely on synchronous mcu communication

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/usb.c             | 5 -----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index abf0a19ee70e..78ceb14fe5d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -172,8 +172,14 @@ static int mt76x0u_init_hardware(struct mt76x02_dev *dev, bool reset)
 static int mt76x0u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->mt76.hw;
+	struct mt76_usb *usb = &dev->mt76.usb;
 	int err;
 
+	usb->mcu.data = devm_kmalloc(dev->mt76.dev, MCU_RESP_URB_SIZE,
+				     GFP_KERNEL);
+	if (!usb->mcu.data)
+		return -ENOMEM;
+
 	err = mt76u_alloc_queues(&dev->mt76);
 	if (err < 0)
 		goto out_err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 62e5e89baf23..2a576618b76e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -190,6 +190,7 @@ int mt76x2u_init_hardware(struct mt76x02_dev *dev)
 int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_usb *usb = &dev->mt76.usb;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -199,6 +200,11 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		return err;
 
+	usb->mcu.data = devm_kmalloc(dev->mt76.dev, MCU_RESP_URB_SIZE,
+				     GFP_KERNEL);
+	if (!usb->mcu.data)
+		return -ENOMEM;
+
 	err = mt76u_alloc_queues(&dev->mt76);
 	if (err < 0)
 		goto fail;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 23a2abf28bde..8b9c598cbeac 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -605,14 +605,9 @@ mt76u_submit_rx_buffers(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 static int mt76u_alloc_rx(struct mt76_dev *dev)
 {
-	struct mt76_usb *usb = &dev->usb;
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	int i, err;
 
-	usb->mcu.data = devm_kmalloc(dev->dev, MCU_RESP_URB_SIZE, GFP_KERNEL);
-	if (!usb->mcu.data)
-		return -ENOMEM;
-
 	spin_lock_init(&q->lock);
 	q->entry = devm_kcalloc(dev->dev,
 				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
-- 
2.24.1

