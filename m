Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4963C1A3127
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIIq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 04:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIIqz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 04:46:55 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE8922202;
        Thu,  9 Apr 2020 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586422015;
        bh=BWcm7JB/lPeWS8begBxm6Gv9BP5cm/j+Y7kTfEgg8A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwJxbMFK4EGhNY93BWbnVQm7lz2RPllyBBjY9ERFNRdNnvIkoBHrHe1Xu/tQpUEoh
         5NvH3UIMDFe7nH5eGgfInEtsPmu6WVTWj9EMR3isIZNmiGIb82T2XOldUlrgRdkeRX
         Lvxut5KwWniOlDdlAwVsJn1M8hJIdMyPkjKLtA/g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        soul.huang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mt76: mt7663: fix DMA unmap length
Date:   Thu,  9 Apr 2020 10:46:39 +0200
Message-Id: <20f6c8304fb911d31780ad2b1d8fa768b7b1eda2.1586421673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586421673.git.lorenzo@kernel.org>
References: <cover.1586421673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix DMA unmap length for mt7663e devices in mt7615_txp_skb_unmap_hw

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Soul Huang <soul.huang@mediatek.com>
Signed-off-by: Soul Huang <soul.huang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 17 +++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c | 15 ++++++++++++---
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e7db7f17c37b..11d161d278e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -654,24 +654,33 @@ mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt7615_fw_txp *txp)
 static void
 mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 {
+	u32 last_mask, len_mask;
 	int i;
 
+	if (is_mt7663(dev)) {
+		last_mask = MT_TXD_LEN_AMSDU_LAST;
+		len_mask = MT7663_TXD_LEN_MASK;
+	} else {
+		last_mask = MT_TXD_LAST_MASK;
+		len_mask = MT_TXD_LEN_MASK;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
 		struct mt7615_txp_ptr *ptr = &txp->ptr[i];
 		bool last;
 		u16 len;
 
 		len = le16_to_cpu(ptr->len0);
-		last = len & MT_TXD_LAST_MASK;
-		len &= ~MT_TXD_LAST_MASK;
+		last = len & last_mask;
+		len &= len_mask;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
 				 DMA_TO_DEVICE);
 		if (last)
 			break;
 
 		len = le16_to_cpu(ptr->len1);
-		last = len & MT_TXD_LAST_MASK;
-		len &= ~MT_TXD_LAST_MASK;
+		last = len & last_mask;
+		len &= len_mask;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
 				 DMA_TO_DEVICE);
 		if (last)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index d9b2fdfb4c8b..2b08abb82b73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -256,8 +256,10 @@ enum tx_phy_bandwidth {
 
 #define MT_MSDU_ID_VALID		BIT(15)
 
+#define MT7663_TXD_LEN_MASK		GENMASK(11, 0)
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+#define MT_TXD_LEN_MASK			GENMASK(13, 0)
 #define MT_TXD_LAST_MASK		GENMASK(15, 14)
 
 struct mt7615_txp_ptr {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 6dfd03a8869b..f2db396bfae3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -54,20 +54,29 @@ mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 {
 	struct mt7615_hw_txp *txp = txp_ptr;
 	struct mt7615_txp_ptr *ptr = &txp->ptr[0];
-	int nbuf = tx_info->nbuf - 1;
-	int i;
+	int i, nbuf = tx_info->nbuf - 1;
+	u32 last_mask, len_mask;
 
 	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
 	tx_info->nbuf = 1;
 
+	if (is_mt7663(&dev->mt76)) {
+		last_mask = MT_TXD_LEN_AMSDU_LAST;
+		len_mask = MT7663_TXD_LEN_MASK;
+	} else {
+		last_mask = MT_TXD_LAST_MASK;
+		len_mask = MT_TXD_LEN_MASK;
+	}
+
 	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
 
 	for (i = 0; i < nbuf; i++) {
 		u32 addr = tx_info->buf[i + 1].addr;
 		u16 len = tx_info->buf[i + 1].len;
 
+		len &= len_mask;
 		if (i == nbuf - 1)
-			len |= MT_TXD_LAST_MASK;
+			len |= last_mask;
 
 		if (i & 1) {
 			ptr->buf1 = cpu_to_le32(addr);
-- 
2.25.2

