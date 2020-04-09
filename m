Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866181A3124
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 10:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIIqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 04:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDIIqu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 04:46:50 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6940322206;
        Thu,  9 Apr 2020 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586422011;
        bh=SIpkwKZjrnQ6AtdZVrfLuhZQ/3hgVIcv+fqa+0b2KNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDwmUhEwn+/gnAuRS3qNFpf50dzarY4quuePBzOhXedW+ahj3PGFVVbxLGbpFVOzy
         TCvE+synhZHe+VhfRdKZ1Rj9FZdC5nkfj02Z7wucU1IcLEDouShPwNbrGJYfe9x3ly
         oaGgWWspg5utY4ZcZLEs19ylSZ2EHwvmvcCWPUhU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        soul.huang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mt76: mt7622: fix DMA unmap length
Date:   Thu,  9 Apr 2020 10:46:38 +0200
Message-Id: <f46e842b580fe6e04fb2a7ff51a489832558f535.1586421673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586421673.git.lorenzo@kernel.org>
References: <cover.1586421673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix DMA unmap length estimation in mt7615_txp_skb_unmap_hw for mt7622
chipset

Fixes: 6aa4ed7927f1 ("mt76: mt7615: implement DMA support for MT7622")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h     | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c4a81bde5cf9..e7db7f17c37b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -662,16 +662,16 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 		u16 len;
 
 		len = le16_to_cpu(ptr->len0);
-		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		last = len & MT_TXD_LAST_MASK;
+		len &= ~MT_TXD_LAST_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
 				 DMA_TO_DEVICE);
 		if (last)
 			break;
 
 		len = le16_to_cpu(ptr->len1);
-		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		last = len & MT_TXD_LAST_MASK;
+		len &= ~MT_TXD_LAST_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
 				 DMA_TO_DEVICE);
 		if (last)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index b540a8cca1e1..d9b2fdfb4c8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -258,6 +258,7 @@ enum tx_phy_bandwidth {
 
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+#define MT_TXD_LAST_MASK		GENMASK(15, 14)
 
 struct mt7615_txp_ptr {
 	__le32 buf0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 7fba1c39060f..6dfd03a8869b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -67,8 +67,7 @@ mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		u16 len = tx_info->buf[i + 1].len;
 
 		if (i == nbuf - 1)
-			len |= MT_TXD_LEN_MSDU_LAST |
-			       MT_TXD_LEN_AMSDU_LAST;
+			len |= MT_TXD_LAST_MASK;
 
 		if (i & 1) {
 			ptr->buf1 = cpu_to_le32(addr);
-- 
2.25.2

