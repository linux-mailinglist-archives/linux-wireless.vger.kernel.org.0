Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0B226BD5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgGTPlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 11:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgGTPla (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:30 -0400
Received: from lore-desk.redhat.com (unknown [151.48.143.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D16022CE3;
        Mon, 20 Jul 2020 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259690;
        bh=B4OwmZIosriiNRY7EQq2R0kxQcb9Yp8e7YAIJ6psF4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHpTspXN8tUKDr7/88PPuXvTmuMJUb0OXAtL54ARKgEzdnA7lFRNKj0oDkQQXgsbm
         mhgtqfyVDhvf966q/65DPBHwKzSJeS0A4oRnIVfg31FtxB4rR6JvT8HGLx/S7Vc5wD
         ThyIEVfncpisGpJekmH8XfrvK7LdJr/tT4QMIdzE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7663s: move drv_own/fw_own in mt7615_mcu_ops
Date:   Mon, 20 Jul 2020 17:41:20 +0200
Message-Id: <16b5d074700110edfd4506ba8597c96ed255859e.1595259089.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1595259089.git.lorenzo@kernel.org>
References: <cover.1595259089.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize set_drv_ctrl and set_fw_ctrl function pointers in
mt7663s_mcu_init. This is a preliminary patch to enable runtime-pm for
mt7663s chipset.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  2 --
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8f008e056e39..dec4d008141a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -677,8 +677,6 @@ int mt7663u_mcu_init(struct mt7615_dev *dev);
 /* sdio */
 u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
-int mt7663s_driver_own(struct mt7615_dev *dev);
-int mt7663s_firmware_own(struct mt7615_dev *dev);
 int mt7663s_kthread_run(void *data);
 void mt7663s_sdio_irq(struct sdio_func *func);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index dabce51117b0..dc4d420c0c8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -428,7 +428,7 @@ static int mt7663s_suspend(struct device *dev)
 
 	mt76s_stop_txrx(&mdev->mt76);
 
-	return mt7663s_firmware_own(mdev);
+	return mt7615_mcu_set_fw_ctrl(mdev);
 }
 
 static int mt7663s_resume(struct device *dev)
@@ -437,7 +437,7 @@ static int mt7663s_resume(struct device *dev)
 	struct mt7615_dev *mdev = sdio_get_drvdata(func);
 	int err;
 
-	err = mt7663s_driver_own(mdev);
+	err = mt7615_mcu_set_drv_ctrl(mdev);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 28b86bec7fc2..953b5893fa67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -63,7 +63,7 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
-int mt7663s_driver_own(struct mt7615_dev *dev)
+static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -95,7 +95,7 @@ int mt7663s_driver_own(struct mt7615_dev *dev)
 	return 0;
 }
 
-int mt7663s_firmware_own(struct mt7615_dev *dev)
+static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -132,9 +132,10 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.mcu_rr = mt7615_mcu_reg_rr,
 		.mcu_wr = mt7615_mcu_reg_wr,
 	};
+	struct mt7615_mcu_ops *mcu_ops;
 	int ret;
 
-	ret = mt7663s_driver_own(dev);
+	ret = mt7663s_mcu_drv_pmctrl(dev);
 	if (ret)
 		return ret;
 
@@ -152,6 +153,15 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
+	mcu_ops = devm_kmemdup(dev->mt76.dev, dev->mcu_ops, sizeof(*mcu_ops),
+			       GFP_KERNEL);
+	if (!mcu_ops)
+		return -ENOMEM;
+
+	mcu_ops->set_drv_ctrl = mt7663s_mcu_drv_pmctrl;
+	mcu_ops->set_fw_ctrl = mt7663s_mcu_fw_pmctrl;
+	dev->mcu_ops = mcu_ops;
+
 	ret = mt7663s_mcu_init_sched(dev);
 	if (ret)
 		return ret;
-- 
2.26.2

