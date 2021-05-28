Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632503943B6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhE1OCL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 10:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhE1OCG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 10:02:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB27F613E5;
        Fri, 28 May 2021 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622210431;
        bh=aHpj0S40WZjNmUCQ1UjIWj1fO3zMpnDa4X2A/IsOfPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qIPB9jaSP5DQ3OV1s2YffJ1JT88dYr3oOkU1yM2ssUvr/mvsgCFGZgGz38lK2FJFa
         tAAq5RsAMy6i6J+tw+7BE1kE5r3wi14PhFtWaUARlAoHvBl+kJzyq6Fa2H097Sab77
         VZRaLAbxu1IAv/wK4OOLmUKb1JtNp4pZ/jL5o/njaUdzS+S7sAvfE0XrZrFiQ/I1PL
         B6w0+UUoIaZplr1HNcF1NIYxcQOOrXtT+P+MD76Ocoz2bume7m6Ua4mX79btJ9ICfL
         0JQg23mm2ArAZq1LcT77RHz/IIrrXhEF3hAu/+DZS7Is0c/a1066Zq99IBfyu5MK2N
         JhJea4Sxz9wqQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2] mt76: mt7921: set MT76_RESET during mac reset
Date:   Fri, 28 May 2021 16:00:24 +0200
Message-Id: <f201e2d43858d022eb149a7cc29c82ea0361d328.1622210344.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set MT76_RESET during mt7921_mac_reset in order to avoid packet
transmissions. Move tx scheduling at the end of reset routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move tx scheduling at the end of reset routine
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 4d1050ae9f39..baaca4eb715e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1255,6 +1255,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
+	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -1274,17 +1275,13 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	if (err)
 		return err;
 
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 
-	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-	mt76_worker_enable(&dev->mt76.tx_worker);
-
-	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
 		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 		MT_INT_MCU_CMD);
@@ -1302,7 +1299,16 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	if (err)
 		return err;
 
-	return __mt7921_start(&dev->phy);
+	err = __mt7921_start(&dev->phy);
+	if (err)
+		return err;
+
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return 0;
 }
 
 /* system error recovery */
-- 
2.31.1

