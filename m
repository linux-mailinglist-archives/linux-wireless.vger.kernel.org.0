Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13F1A21AF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgDHMUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 08:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgDHMUv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:51 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BDD206F7;
        Wed,  8 Apr 2020 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586348450;
        bh=4ESBG9SkgQkFponzawGQ7aor+asTMiiGcIRnIU6gIiI=;
        h=From:To:Cc:Subject:Date:From;
        b=vVz0CgiDeZO+mnulwuYl9rOZo9aiNKHzhwIDt+lD1E70cXwqdAhva5HEdM9kxZJVQ
         6e1tjqgkW9Rog5MS/JbwhqP76BNaAYL9EZONuHL9/6NfxVzCJ72yu6VUjqj5g3oMmq
         AnMO+PVJDYrxDWISpzXxLiBI095aeYXmJYbSOH2E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7663: fix aggr range entry in debugfs
Date:   Wed,  8 Apr 2020 14:20:39 +0200
Message-Id: <3b86a23c5ad6348cab3500935c619fba74db08ec.1586348345.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix register definitions for aggr range counter registers for mt7663
chipset

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h    | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 777c7f9bd760..2163a22967c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -129,16 +129,18 @@ mt7615_ampdu_stat_read_phy(struct mt7615_phy *phy,
 			   struct seq_file *file)
 {
 	struct mt7615_dev *dev = file->private;
+	u32 reg = is_mt7663(&dev->mt76) ? MT_MIB_ARNG(0) : MT_AGG_ASRCR0;
 	bool ext_phy = phy != &dev->phy;
 	int bound[7], i, range;
 
 	if (!phy)
 		return;
 
-	range = mt76_rr(dev, MT_AGG_ASRCR0);
+	range = mt76_rr(dev, reg);
 	for (i = 0; i < 4; i++)
 		bound[i] = MT_AGG_ASRCR_RANGE(range, i) + 1;
-	range = mt76_rr(dev, MT_AGG_ASRCR1);
+
+	range = mt76_rr(dev, reg + 4);
 	for (i = 0; i < 3; i++)
 		bound[i + 4] = MT_AGG_ASRCR_RANGE(range, i) + 1;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6acaaf2732df..07d4b259fe8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -116,6 +116,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_DMA_DCR0,
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
 		MT_DMA_DCR0_RX_VEC_DROP);
+	mt76_set(dev, MT_WF_MIB_SCR0, MT_MIB_SCR0_AGG_CNT_RANGE_EN);
 	if (is_mt7663(&dev->mt76)) {
 		mt76_wr(dev, MT_WF_AGG(0x160), 0x5c341c02);
 		mt76_wr(dev, MT_WF_AGG(0x164), 0x70708040);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 481e4d941e72..a3333f382350 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -384,6 +384,9 @@ enum mt7615_reg_base {
 #define MT_WF_MIB_BASE			(dev->reg_map[MT_MIB_BASE])
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE + (ofs) + (_band) * 0x200)
 
+#define MT_WF_MIB_SCR0			MT_WF_MIB(0, 0)
+#define MT_MIB_SCR0_AGG_CNT_RANGE_EN	BIT(21)
+
 #define MT_MIB_M0_MISC_CR(_band)	MT_WF_MIB(_band, 0x00c)
 
 #define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
@@ -414,6 +417,8 @@ enum mt7615_reg_base {
 #define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
 #define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
 
+#define MT_MIB_ARNG(n)			MT_WF_MIB(0, 0x4b8 + ((n) << 2))
+
 #define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0xa8 + ((n) << 2))
 
 #define MT_DMA_SHDL(ofs)		(dev->reg_map[MT_DMA_SHDL_BASE] + (ofs))
-- 
2.25.2

