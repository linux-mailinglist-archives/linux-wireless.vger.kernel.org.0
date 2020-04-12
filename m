Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB81C1A5F4E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgDLQFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgDLQFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 12:05:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA386C00876E
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 08:58:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n10so3485129pff.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zoHsqvmfICV2TLA2Y8FhvagDaKGBc7JQQXu8HzlkVo=;
        b=mHa/0if53kgZ2oaF4zTPS4WAjflWi8dLVIjMWpv9R5cB4rb/XmyCF3yGAdF7ENeDXM
         dcNdj7ORBu9ejLD6265VteoocPacsWYwZhAiPj4/bd0Wg8VSrSbhrXkd1DkIcmM0xvWW
         35356vWDWrIZ7WsWmWWH7D1GlEPtU+t5dGnDy8sxJOvjPYMScPP3PIv6OW+Q1m03Zfbq
         oAVq+94MOVsQEICxav2t14EQcUHOMFug4Seid9GpIGBxOrYdBejaJCFp039uSfRsUbfM
         RW6rL6fvwSgZk7XrI2e9onFo+/TSjlXIhrXml8KwsNV+Pj8ieMywGvsQVCl2hITtk7A7
         L8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zoHsqvmfICV2TLA2Y8FhvagDaKGBc7JQQXu8HzlkVo=;
        b=TAalFbM8UsKh1zKVfiJg8nmQqtYmLAlERNuuCX2IlEY8OrlAA8s3mksSwlEu9jNTXX
         9w33GaQG8BYFSFh/VG2s5Dc0We7HRhp1ULkeQVYkUfYsUFbtOZ49MM6gm9tr7pyHbzAO
         69ZDGFwiRXylVna99POcKbdvnqwhStXtREGgKa44cm/r52KMq9B8paZAfEcW6ZMbHy7T
         EJ+H9AZH6lBs9Jo1c7nth3bCDujBmbo7RD7HBOa5t/hljjWo/JGDZ3QnVpuHfFe9jlmR
         yaCuKqRLqL1Uc8OtWt4ZNCn6fHVNYMoVRj0h0DDkSMZILScdAn0O4j1J1dUCEvF/gjjV
         u5Sg==
X-Gm-Message-State: AGi0Pub+jgytkeIoeXDXIaxGve1qemQKHsuX4xT968njvqKCJCnlpP6q
        f8jeJYZ9rBpT64t09uwMI6MQSIXtzQuDcg==
X-Google-Smtp-Source: APiQypI4CktBcTIuAchsLEqulUi0iTr/+kWVKJqxm1EIgUAMZRt0x6DTJd8APdI9W2AAzazVy70LsQ==
X-Received: by 2002:a63:5d7:: with SMTP id 206mr1894909pgf.136.1586707135042;
        Sun, 12 Apr 2020 08:58:55 -0700 (PDT)
Received: from example.com ([2402:f000:1:1501::7416:1d81])
        by smtp.gmail.com with ESMTPSA id kb18sm7311019pjb.14.2020.04.12.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 08:58:54 -0700 (PDT)
From:   DENG Qingfang <dqfext@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mt76: mt7615: add support for MT7611N
Date:   Sun, 12 Apr 2020 23:58:48 +0800
Message-Id: <20200412155848.15506-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7611N is basically the same as MT7615N, except it only supports 5 GHz
It is used by some TP-Link and Mercury wireless routers

Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c     | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c  | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c     | 1 +
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index b4d0795154e3..fac705e1621f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -264,7 +264,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
-	if (is_mt7615(&dev->mt76))
+	if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "queues", dir,
 					    mt7615_queues_read);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index b19f208e3d54..274053311749 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -74,7 +74,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	if (!is_mt7615(&dev->mt76))
+	if (!is_mt7615(&dev->mt76) && !is_mt7611(&dev->mt76))
 		return mt7622_init_tx_queues_multi(dev);
 
 	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[0], 0,
@@ -139,7 +139,7 @@ mt7615_tx_cleanup(struct mt7615_dev *dev)
 	int i;
 
 	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
-	if (is_mt7615(&dev->mt76)) {
+	if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76)) {
 		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
 	} else {
 		for (i = 0; i < IEEE80211_NUM_ACS; i++)
@@ -250,7 +250,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	mt76_rmw_field(dev, MT_WPDMA_GLO_CFG,
 		       MT_WPDMA_GLO_CFG_MULTI_DMA_EN, 0x3);
 
-	if (is_mt7615(&dev->mt76)) {
+	if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76)) {
 		mt76_set(dev, MT_WPDMA_GLO_CFG,
 			 MT_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY);
 
@@ -276,7 +276,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	if (!is_mt7615(&dev->mt76))
+	if (!is_mt7615(&dev->mt76) && !is_mt7611(&dev->mt76))
 	    rx_ring_size /= 2;
 
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index dfa9a08b896d..bb6f28305733 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -109,6 +109,12 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 		return;
 	}
 
+	if (is_mt7611(&dev->mt76)) {
+		/* 5GHz only */
+		dev->mt76.cap.has_5ghz = true;
+		return;
+	}
+
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
 			eeprom[MT_EE_WIFI_CONF]);
 	switch (val) {
@@ -260,6 +266,7 @@ static void mt7615_cal_free_data(struct mt7615_dev *dev)
 		mt7622_apply_cal_free_data(dev);
 		break;
 	case 0x7615:
+	case 0x7611:
 		mt7615_apply_cal_free_data(dev);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 03b1e56534d6..33472a2493e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -349,7 +349,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
-	if (is_mt7615(&phy->dev->mt76))
+	if (is_mt7615(&phy->dev->mt76) || is_mt7611(&phy->dev->mt76))
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 	else
 		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index a27a6d164009..b5b760b081cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -427,7 +427,7 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 		dev = container_of(mdev, struct mt7615_dev, mt76);
 		txp = mt7615_txwi_to_txp(mdev, e->txwi);
 
-		if (is_mt7615(&dev->mt76))
+		if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76))
 			token = le16_to_cpu(txp->fw.token);
 		else
 			token = le16_to_cpu(txp->hw.msdu_id[0]) &
@@ -697,7 +697,7 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 	struct mt7615_txp_common *txp;
 
 	txp = mt7615_txwi_to_txp(dev, t);
-	if (is_mt7615(dev))
+	if (is_mt7615(dev) || is_mt7611(dev))
 		mt7615_txp_skb_unmap_fw(dev, &txp->fw);
 	else
 		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
@@ -1212,7 +1212,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	txp = txwi + MT_TXD_SIZE;
 	memset(txp, 0, sizeof(struct mt7615_txp_common));
-	if (is_mt7615(&dev->mt76))
+	if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76))
 		mt7615_write_fw_txp(dev, tx_info, txp, id);
 	else
 		mt7615_write_hw_txp(dev, tx_info, txp, id);
@@ -1482,7 +1482,7 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	u8 i, count;
 
 	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
-	if (is_mt7615(&dev->mt76)) {
+	if (is_mt7615(&dev->mt76) || is_mt7611(&dev->mt76)) {
 		__le16 *token = &free->token[0];
 
 		for (i = 0; i < count; i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 676ca622c35a..8daf1027de8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -353,6 +353,11 @@ static inline bool is_mt7663(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7663;
 }
 
+static inline bool is_mt7611(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7611;
+}
+
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index c8d0f893a47f..54c0ea2701bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -14,6 +14,7 @@
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
 	{ PCI_DEVICE(0x14c3, 0x7663) },
+	{ PCI_DEVICE(0x14c3, 0x7611) },
 	{ },
 };
 
-- 
2.26.0

