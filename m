Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7C13BDE4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgAOK7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:42 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA01624679;
        Wed, 15 Jan 2020 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085981;
        bh=jo053NYPsKdCLA3vd1N6ZrNuBblBEjLgJVWqLhtElrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krDs7QzA1iM39+aVRTtYJgq6uzkZlMaCVr9Wfk6b79ArW2eAdHBFLKtqu7hdLifz3
         4qHB9W+QHfaOoZ9+9GGJmunxuIk6Xv/1iOa0Zm86vK1f3ihfQJhdOAT4hTmiaS5BDG
         M8p32M0SkPY8Q7nhLVuXFXHqsDuAxca4oTTVMDG8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 07/18] mt76: mt76u: move mcu buffer allocation in mt76x02u drivers
Date:   Wed, 15 Jan 2020 11:58:47 +0100
Message-Id: <e4ade54ae6913dcab5aa4ec1793587226ddafadb.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mcu buffer allocation in mt76x2u/mt76x0u drivers since newer
chipsets (e.g. mt7663u) does not rely on synchronous mcu communication

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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
index 678720c53886..96269e8eb170 100644
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
2.21.1

