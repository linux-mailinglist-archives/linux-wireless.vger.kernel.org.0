Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB561A3306
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 13:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDILPL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 07:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgDILPK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 07:15:10 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405AD20757;
        Thu,  9 Apr 2020 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586430910;
        bh=Gj07/G5apjP04lfMYXxChEFVCf8+k8eaHer5HKmfSUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgVnizM3RGQ0+g2UAG4vwYuUNBhO16bXClI3IO+23evJmlBdMWOIDmZuQRdua4EYK
         ytPbaugZnaMCFcA98j9zXqT3IXzPH0+RDHoEpb4o0IP0VghI4U6tpgvxz5uItaOuBd
         xti3h+NzIXaCKW1hVoIqsyOE0R1xn8KPMLDtCFyM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        soul.huang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] mt76: mt7622: fix DMA unmap length
Date:   Thu,  9 Apr 2020 13:14:56 +0200
Message-Id: <fea589edafe30906c60d58760f26f4821b8b3e82.1586430566.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586430566.git.lorenzo@kernel.org>
References: <cover.1586430566.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1ef988883660..b7a96d514656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -695,7 +695,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 
 		len = le16_to_cpu(ptr->len0);
 		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		len &= MT_TXD_LEN_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
 				 DMA_TO_DEVICE);
 		if (last)
@@ -703,7 +703,7 @@ mt7615_txp_skb_unmap_hw(struct mt76_dev *dev, struct mt7615_hw_txp *txp)
 
 		len = le16_to_cpu(ptr->len1);
 		last = len & MT_TXD_LEN_MSDU_LAST;
-		len &= ~MT_TXD_LEN_MSDU_LAST;
+		len &= MT_TXD_LEN_MASK;
 		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
 				 DMA_TO_DEVICE);
 		if (last)
@@ -1114,8 +1114,8 @@ mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
 
 	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
 		u32 addr = tx_info->buf[i + 1].addr;
-		u16 len = tx_info->buf[i + 1].len;
 
 		if (i == nbuf - 1)
 			len |= MT_TXD_LEN_MSDU_LAST |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index f3e0070896a1..aab6be5f5465 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -253,6 +253,7 @@ enum tx_phy_bandwidth {
 
 #define MT_MSDU_ID_VALID		BIT(15)
 
+#define MT_TXD_LEN_MASK                 GENMASK(11, 0)
 #define MT_TXD_LEN_MSDU_LAST		BIT(14)
 #define MT_TXD_LEN_AMSDU_LAST		BIT(15)
 
-- 
2.25.2

