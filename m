Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C320839463B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhE1RN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 13:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhE1RN2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 13:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A642E613B4;
        Fri, 28 May 2021 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622221913;
        bh=O+0s3Im5qRTilBsOVRaGOwZMIGy61SLzbC1smZ4A+s4=;
        h=From:To:Cc:Subject:Date:From;
        b=LQSsODEcFSxVGd7BNH+QQ9vDXebVov/Njzq9zTpzBOXWLkVBxgauqt+j+Daqi5iwA
         XSgn0ctuAL/iuJPx8D/1UiNuDTJlBA71efUAUo3v5zIxVuU+6N+I78YEv4LUNK39CC
         NA4HfYM9YE4JTkeEB/T0pLCr/JDDDlWG0MoqY5T0jVu4L32EfmlBbcShM6m47eS0cP
         u5Y70xtzpb182MUp8hvqyz5QA7Qzkb+IBxhfmR35L1/8LPKLxatTCsAbCLzcLU83eo
         HQa/BOiW0H34QyIp6M2rRbcO8d1hqHae7y0AUqFdGzOdRUgZxH+94LLl5Cjn2z/Bby
         49AvshoBPpXZA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3] mt76: mt7921: set MT76_RESET during mac reset
Date:   Fri, 28 May 2021 19:11:42 +0200
Message-Id: <349c7c836e0b2c1978d0c3706d74034e71279532.1622221131.git.lorenzo@kernel.org>
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
Changes since v2:
- clear flags in case of error

Changes since v1:
- move tx scheduling at the end of reset routine
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index aecb2615b63d..f518c84d7fa9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1294,6 +1294,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
+	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -1309,19 +1310,13 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt7921_tx_token_put(dev);
 	idr_init(&dev->mt76.token);
 
-	err = mt7921_wpdma_reset(dev, true);
-	if (err)
-		return err;
+	mt7921_wpdma_reset(dev, true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 
-	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-	mt76_worker_enable(&dev->mt76.tx_worker);
-
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
@@ -1331,17 +1326,25 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 
 	err = mt7921_run_firmware(dev);
 	if (err)
-		return err;
+		goto out;
 
 	err = mt7921_mcu_set_eeprom(dev);
 	if (err)
-		return err;
+		goto out;
 
 	err = mt7921_mac_init(dev);
 	if (err)
-		return err;
+		goto out;
+
+	err = __mt7921_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	return __mt7921_start(&dev->phy);
+	return err;
 }
 
 /* system error recovery */
-- 
2.31.1

