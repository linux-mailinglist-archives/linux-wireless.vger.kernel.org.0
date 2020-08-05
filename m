Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4723C93B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHEJdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgHEJck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 05:32:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B96C061756
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d2nQW1/Vrl7bAp6cyjYEOCoVqP5mQdG8nvhubxdmiLM=; b=bcXxxbyvJJGG1MzPR/xUp9ZMjF
        9utHHX/HL5FFpByrLaCvyvB88sBAPr5vQEwZIc1QQGXQZC7Efp0p+WJJmeO5XvjX7TV7IxjoEfIjJ
        wyE9Q3FcLq50v7f7lbjawQgJ5pkCW8I2XTDmklk62ISBieF0TF3MAvtajJAK+B6KaQaQ=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k3Fmn-0008Si-FX
        for linux-wireless@vger.kernel.org; Wed, 05 Aug 2020 11:32:37 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: fix double DMA unmap of the first buffer on 7615/7915
Date:   Wed,  5 Aug 2020 11:32:35 +0200
Message-Id: <20200805093235.52506-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200805093235.52506-1-nbd@nbd.name>
References: <20200805093235.52506-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A small part of the first skb buffer is passed to the firmware for parsing
via DMA, while the full buffer is passed as part of the TXP.

Avoid calling DMA unmap on the first part (with a different length than map)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c            | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h           | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6c25859dd386..ade2d58b8da9 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -61,10 +61,16 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	for (i = 0; i < nbufs; i += 2, buf += 2) {
 		u32 buf0 = buf[0].addr, buf1 = 0;
 
+		if (buf[0].skip_unmap)
+			q->entry[q->head].skip_buf0 = true;
+		q->entry[q->head].skip_buf1 = i == nbufs - 1;
+
 		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
 		if (i < nbufs - 1) {
 			buf1 = buf[1].addr;
 			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+			if (buf[1].skip_unmap)
+				q->entry[q->head].skip_buf1 = true;
 		}
 
 		if (i == nbufs - 1)
@@ -107,7 +113,7 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 				 DMA_TO_DEVICE);
 	}
 
-	if (!(ctrl & MT_DMA_CTL_LAST_SEC0)) {
+	if (!e->skip_buf1) {
 		__le32 addr = READ_ONCE(q->desc[idx].buf1);
 		u32 len = FIELD_GET(MT_DMA_CTL_SD_LEN1, ctrl);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a06f8f5abeb2..c7afc1c7cb2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -79,7 +79,8 @@ enum mt76_rxq_id {
 
 struct mt76_queue_buf {
 	dma_addr_t addr;
-	int len;
+	u16 len;
+	bool skip_unmap;
 };
 
 struct mt76_tx_info {
@@ -101,6 +102,7 @@ struct mt76_queue_entry {
 	};
 	enum mt76_txq_id qid;
 	bool skip_buf0:1;
+	bool skip_buf1:1;
 	bool schedule:1;
 	bool done:1;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 2d67f9a148cd..51b2e0467592 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -107,6 +107,7 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	/* pass partial skb header to fw */
 	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
 	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6825afca1efb..99ab5fca0f6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -715,6 +715,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	/* pass partial skb header to fw */
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
 	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD);
-- 
2.24.0

