Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3880C25088E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHXSzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 14:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgHXSzT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 14:55:19 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5CD206BE;
        Mon, 24 Aug 2020 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598295319;
        bh=SyNgphRxE/HwLHW+1vtk437GBaZDWSY5SDMzB+B5eCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VZ7uDKUGmTMZ13gRgUpxgZjaDiCbUDfJ7zTCLptIFqjLHPWNuNspdoCPuvMvXpr9a
         0bYgcWQCZtcvCGmyp4KyopbCu1yS2lm+aQ1TlcVRnlHtiL3eTK+aRy8ZbBq1Wi720U
         6M1nyDuUYNW+6DOgX+mRHWlRpH1A9wC7xq/7iyp8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7663u: fix dma header initialization
Date:   Mon, 24 Aug 2020 20:55:12 +0200
Message-Id: <51992d5fe23804390fa64d771cb1b3ccbdfa97ee.1598295054.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix length field corruption in usb dma header introduced adding sdio
support

Fixes: 75b10f0cbd0b ("mt76: mt76u: add mt76_skb_adjust_pad utility routine")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c  | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 0b33df3e3bfe..adbed373798e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -19,6 +19,7 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	int ret, seq, ep;
+	u32 len;
 
 	mutex_lock(&mdev->mcu.mutex);
 
@@ -28,7 +29,8 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		ep = MT_EP_OUT_AC_BE;
 
-	put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
+	len = skb->len;
+	put_unaligned_le32(len, skb_push(skb, sizeof(len)));
 	ret = mt76_skb_adjust_pad(skb);
 	if (ret < 0)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 6dffdaaa9ad5..294276e2280d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -259,8 +259,11 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 
 	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, skb);
-	if (mt76_is_usb(mdev))
-		put_unaligned_le32(skb->len, skb_push(skb, sizeof(skb->len)));
+	if (mt76_is_usb(mdev)) {
+		u32 len = skb->len;
+
+		put_unaligned_le32(len, skb_push(skb, sizeof(len)));
+	}
 
 	return mt76_skb_adjust_pad(skb);
 }
-- 
2.26.2

