Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F9188ABB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgCQQmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:21 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482572073E;
        Tue, 17 Mar 2020 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463340;
        bh=y+Nfv/XK3kcsURjyKdjeMR5hp3vaUh1MU49xoSY3usI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRfpsl5qlsHwv/u7QekqZGUulFmmK5wfhmC/R6RRGLpnZaW/7A0SOkrB2CIIl0Xd3
         4IuYK+FGgIZreMB5dgtyncI4ZAqac4i/2rOcsrJ6C5JyanJiaprVM6OwPih6JCb4HI
         /NZ2+xLDVsOBR1HgWQfKGC/R3RejjGVUJwMHHPSw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 15/25] mt76: mt7615: add mt7663e support to mt7615_reg_map
Date:   Tue, 17 Mar 2020 17:41:22 +0100
Message-Id: <e398194b0e22dec05de83b5d8733bc55a2bb4d4d.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7663e support to mt7615_reg_map routine in order to reuse it
adding support for mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   | 12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  5 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |  3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index fb4a76270ad4..43c8b29020f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -30,9 +30,15 @@ const u32 mt7615e_reg_map[] = {
 
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
 {
-	u32 base = addr & MT_MCU_PCIE_REMAP_2_BASE;
-	u32 offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
-
+	u32 base, offset;
+
+	if (is_mt7663(&dev->mt76)) {
+		base = addr & MT7663_MCU_PCIE_REMAP_2_BASE;
+		offset = addr & MT7663_MCU_PCIE_REMAP_2_OFFSET;
+	} else {
+		base = addr & MT_MCU_PCIE_REMAP_2_BASE;
+		offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
+	}
 	mt76_wr(dev, MT_MCU_PCIE_REMAP_2, base);
 
 	return MT_PCIE_REMAP_BASE_2 + offset;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index c03ad0409f43..143fa63517ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -343,6 +343,11 @@ static inline bool is_mt7615(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7615;
 }
 
+static inline bool is_mt7663(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7663;
+}
+
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index b422a9c71089..928e5a841885 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -55,6 +55,9 @@ enum mt7615_reg_base {
 
 #define MT_HIF(ofs)			((dev)->reg_map[MT_HIF_BASE] + (ofs))
 
+#define MT7663_MCU_PCIE_REMAP_2_OFFSET	GENMASK(15, 0)
+#define MT7663_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 16)
+
 #define MT_CFG_LPCR_HOST		MT_HIF(0x1f0)
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_CFG_LPCR_HOST_DRV_OWN	BIT(1)
-- 
2.25.1

