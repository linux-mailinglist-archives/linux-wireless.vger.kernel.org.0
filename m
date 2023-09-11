Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86479B9BB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbjIKVs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbjIKSiq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 14:38:46 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C751AB
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eAcOTaZvHF4QuJj6wJNpdOVVeuYWcUAcVJa8WDVm+8s=; b=f4nBOL5A+gTrD3tZ4uzlK4VkNM
        /bbL1i67/knuLjPHRQhzAOt5JD5n3cqVtQbs+7qWb03KXoibZcpjB1fKD+trn1uqh0SiNco8nu/l/
        E0yPb3ITJkiIF3Ld80rLqJbGCK5BVHNERQGFvj2UXt7Ctx17TZjsWVgnR280QSH2S+O4=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qflny-000t0P-GF
        for linux-wireless@vger.kernel.org; Mon, 11 Sep 2023 20:38:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb
Date:   Mon, 11 Sep 2023 20:38:37 +0200
Message-ID: <20230911183837.51601-2-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911183837.51601-1-nbd@nbd.name>
References: <20230911183837.51601-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The error handling code was added in order to allow tx enqueue to fail after
calling .tx_prepare_skb. Since this can no longer happen, the error handling
code is unused.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c        |  3 ---
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c    | 17 -----------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  2 +-
 6 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 05d9ab3ce819..6a6af1d3d687 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -330,9 +330,6 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (e->txwi == DMA_DUMMY_DATA)
 		e->txwi = NULL;
 
-	if (e->skb == DMA_DUMMY_DATA)
-		e->skb = NULL;
-
 	*prev_e = *e;
 	memset(e, 0, sizeof(*e));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 0019890fdb78..fbb1181c58ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -106,7 +106,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	else
 		mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ee5177fd6dde..73db9e14db06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -151,23 +151,6 @@ void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
 		return;
 	}
 
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_txp_common *txp;
-		struct mt76_txwi_cache *t;
-		u16 token;
-
-		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
-		if (is_mt76_fw_txp(mdev))
-			token = le16_to_cpu(txp->fw.token);
-		else
-			token = le16_to_cpu(txp->hw.msdu_id[0]) &
-				~MT_MSDU_ID_VALID;
-
-		t = mt76_token_put(mdev, token);
-		e->skb = t ? t->skb : NULL;
-	}
-
 	if (e->skb)
 		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b8b0c0fda752..2222fb9aa103 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -809,7 +809,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
 	else
 		txp->rept_wds_wcid = cpu_to_le16(0x3ff);
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index e7a995e7e70a..c866144ff061 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -48,7 +48,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
 	mt76_connac_write_hw_txp(mdev, tx_info, txp, id);
 
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ac8759febe48..0eebf915df26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -995,7 +995,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->fw.rept_wds_wcid = cpu_to_le16(wcid->idx);
 	else
 		txp->fw.rept_wds_wcid = cpu_to_le16(0xfff);
-	tx_info->skb = DMA_DUMMY_DATA;
+	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
 	tx_info->buf[1].len = MT_CT_PARSE_LEN;
-- 
2.41.0

