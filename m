Return-Path: <linux-wireless+bounces-27020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC6B44303
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96E0161E4D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22E286885;
	Thu,  4 Sep 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZEDQ3Pe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646E260580
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003914; cv=none; b=TwY9t0afdCN12g9XHoEQPVt/9NAyE8k76SpyJXDsCdW3/TwhkzuCjXPcSDcmy3m67xsqUoKbE1MCiJMK+i9EBMv+eBjz/UoOeH4+sBRaGsvXAfnLlIou2hFRU85QfVn5RK3Z+Od6MzDrVhogGIOo7+Ud2eFe6ayx3eDbns6L20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003914; c=relaxed/simple;
	bh=Wvf2iKxJmjzm++ss1BTrRvwIprhwY9WOa/o9Y4MoeJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucJRZvkIkVhbcYJ6l/9drFksaazPlBmgJee5CbWanrO0RhXvnQ+2CvFNkFipNZJaedDqJTafYtSddLosiU6OqHQRLfC0WVTFuZFzWtUpNiFi5ojCIeHDJU3jdLr+mogI8TBhFZay8u4Wg7y5rvepqZ15ip/7ZMrme4Ssk65dMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZEDQ3Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763D3C4CEF0;
	Thu,  4 Sep 2025 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003913;
	bh=Wvf2iKxJmjzm++ss1BTrRvwIprhwY9WOa/o9Y4MoeJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oZEDQ3Pex22UY5g0SeWATmLaYEK10PnQCjGbA3QC84D69W80IcQU5BQakUVfzZ6+r
	 hCgNeztukNmrRBLEPfS9X3gqzV5DJAMAS2x0rL/COrZAk15W74yJ2iJuyJJfjBuYB4
	 W1kkMcwkAwdnJrvJWfzMvhBtUrQ/62CbF4OGf6yLWv+T1BsKUXR04k1Ku1cN0rO0AR
	 vYND4rBCewu4L/6sHp00y8T9gUMx0AfH4Jqh2Jahlx7QHfC5/j9sQhgKJ4fGxLHMzi
	 XYw3vwAUJQMsFWgRvDfU0du8Q+AnWpDriTaXOMgUTPWYpQCD8X/95z7AT9qcAtQqEY
	 OvmLjGD8Xliqw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:38:00 +0200
Subject: [PATCH mt76 v4 06/15] wifi: mt76: mt7996: Enable HW RRO for MT7992
 chipset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-6-2cd91e7229d6@kernel.org>
References: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
In-Reply-To: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

This is a preliminary patch to enable WED support for MT7992 Kite
chipset supported by MT7996 driver.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 168 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   9 ++
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  10 ++
 3 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 21ac618d1c836aa997b12769cdbe386265b2b276..93144b5e9564792556153a1fad7bf8e4140a3385 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -605,19 +605,21 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 	}
 
 	/* rro module init */
-	if (is_mt7996(&dev->mt76))
-		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
-	else
+	if (dev->hif2)
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE,
-				   dev->hif2 ? 7 : 0);
+				   is_mt7996(&dev->mt76) ? 2 : 7);
+	else
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 0);
 
 	if (dev->has_rro) {
 		u16 timeout;
 
 		timeout = mt76_rr(dev, MT_HW_REV) == MT_HW_REV1 ? 512 : 128;
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_FLUSH_TIMEOUT, timeout);
-		mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 1);
-		mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 0);
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE,
+				   is_mt7996(&dev->mt76) ? 1 : 2);
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH,
+				   !is_mt7996(&dev->mt76));
 	} else {
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 3);
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 1);
@@ -754,11 +756,95 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 	msleep(20);
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static void mt7996_rro_hw_init(struct mt7996_dev *dev)
+{
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
+	int i;
+
+	if (!dev->has_rro)
+		return;
+
+	if (is_mt7992(&dev->mt76)) {
+		/* Set emul 3.0 function */
+		mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
+			MT_RRO_3_0_EMU_CONF_EN_MASK);
+		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE0,
+			dev->wed_rro.addr_elem[0].phy_addr);
+	} else {
+		/* TODO: remove line after WM has set */
+		mt76_clear(dev, WF_RRO_AXI_MST_CFG,
+			   WF_RRO_AXI_MST_CFG_DIDX_OK);
+		/* setup BA bitmap cache address */
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE0,
+			dev->wed_rro.ba_bitmap[0].phy_addr);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE1, 0);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT0,
+			dev->wed_rro.ba_bitmap[1].phy_addr);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT1, 0);
+
+		/* Setup Address element address */
+		for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
+			mt76_wr(dev, reg,
+				dev->wed_rro.addr_elem[i].phy_addr >> 4);
+			reg += 4;
+		}
+
+		/* Setup Address element address - separate address
+		 * segment mode
+		 */
+		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
+			MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
+	}
+	wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
+	if (is_mt7996(&dev->mt76))
+		wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
+	else
+		wed->wlan.ind_cmd.particular_sid = 1;
+	wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
+	wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
+	wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
+
+	mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0x15010e00);
+	mt76_set(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1,
+		 MT_RRO_IND_CMD_SIGNATURE_BASE1_EN);
+
+	/* particular session configure */
+	/* use max session idx + 1 as particular session id */
+	mt76_wr(dev, MT_RRO_PARTICULAR_CFG0, dev->wed_rro.session.phy_addr);
+
+	if (is_mt7992(&dev->mt76)) {
+		reg = MT_RRO_MSDU_PG_SEG_ADDR0;
+
+		mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
+			 MT_RRO_3_1_GLOBAL_CONFIG_INTERLEAVE_EN);
+
+		/* setup Msdu page address */
+		for (i = 0; i < ARRAY_SIZE(dev->wed_rro.msdu_pg); i++) {
+			mt76_wr(dev, reg,
+				dev->wed_rro.msdu_pg[i].phy_addr >> 4);
+			reg += 4;
+		}
+		mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
+			MT_RRO_PARTICULAR_CONFG_EN |
+			FIELD_PREP(MT_RRO_PARTICULAR_SID, 1));
+	} else {
+		mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
+			MT_RRO_PARTICULAR_CONFG_EN |
+			FIELD_PREP(MT_RRO_PARTICULAR_SID,
+				   MT7996_RRO_MAX_SESSION));
+	}
+	/* interrupt enable */
+	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
+		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
+}
+#endif
+
 static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
-	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
 	struct mt7996_wed_rro_addr *addr;
 	void *ptr;
 	int i;
@@ -804,6 +890,20 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 			dev->wed_rro.addr_elem[i].phy_addr;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.msdu_pg); i++) {
+		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+					  MT7996_RRO_MSDU_PG_SIZE_PER_CR,
+					  &dev->wed_rro.msdu_pg[i].phy_addr,
+					  GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+
+		dev->wed_rro.msdu_pg[i].ptr = ptr;
+
+		memset(dev->wed_rro.msdu_pg[i].ptr, 0,
+		       MT7996_RRO_MSDU_PG_SIZE_PER_CR);
+	}
+
 	ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
 				  MT7996_RRO_WINDOW_MAX_LEN * sizeof(*addr),
 				  &dev->wed_rro.session.phy_addr,
@@ -818,50 +918,8 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		addr++;
 	}
 
-	/* rro hw init */
-	/* TODO: remove line after WM has set */
-	mt76_clear(dev, WF_RRO_AXI_MST_CFG, WF_RRO_AXI_MST_CFG_DIDX_OK);
-
-	/* setup BA bitmap cache address */
-	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE0,
-		dev->wed_rro.ba_bitmap[0].phy_addr);
-	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE1, 0);
-	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT0,
-		dev->wed_rro.ba_bitmap[1].phy_addr);
-	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT1, 0);
-
-	/* setup Address element address */
-	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
-		mt76_wr(dev, reg, dev->wed_rro.addr_elem[i].phy_addr >> 4);
-		reg += 4;
-	}
-
-	/* setup Address element address - separate address segment mode */
-	mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
-		MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
-
-	wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
-	wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
-	wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
-	wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
-	wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
-
-	mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0x15010e00);
-	mt76_set(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1,
-		 MT_RRO_IND_CMD_SIGNATURE_BASE1_EN);
-
-	/* particular session configure */
-	/* use max session idx + 1 as particular session id */
-	mt76_wr(dev, MT_RRO_PARTICULAR_CFG0, dev->wed_rro.session.phy_addr);
-	mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
-		MT_RRO_PARTICULAR_CONFG_EN |
-		FIELD_PREP(MT_RRO_PARTICULAR_SID, MT7996_RRO_MAX_SESSION));
-
-	/* interrupt enable */
-	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
-		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
+	mt7996_rro_hw_init(dev);
 
-	/* rro ind cmd queue init */
 	return mt7996_dma_rro_init(dev);
 #else
 	return 0;
@@ -900,6 +958,16 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 				   dev->wed_rro.addr_elem[i].phy_addr);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.msdu_pg); i++) {
+		if (!dev->wed_rro.msdu_pg[i].ptr)
+			continue;
+
+		dmam_free_coherent(dev->mt76.dma_dev,
+				   MT7996_RRO_MSDU_PG_SIZE_PER_CR,
+				   dev->wed_rro.msdu_pg[i].ptr,
+				   dev->wed_rro.msdu_pg[i].phy_addr);
+	}
+
 	if (!dev->wed_rro.session.ptr)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c210dfd5e37a91ded70e09f51bca52406d7b9d53..094ea070369a8ac33a3aa692d5aaf9535c89d3d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -112,6 +112,7 @@
 #define MT7996_CRIT_TEMP		110
 #define MT7996_MAX_TEMP			120
 
+#define MT7996_RRO_MSDU_PG_HASH_SIZE	127
 #define MT7996_RRO_MAX_SESSION		1024
 #define MT7996_RRO_WINDOW_MAX_LEN	1024
 #define MT7996_RRO_ADDR_ELEM_LEN	128
@@ -128,6 +129,10 @@
 #define MT7996_RX_MSDU_PAGE_SIZE	(128 + \
 					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+/* RRO 3.1 */
+#define MT7996_RRO_MSDU_PG_CR_CNT	8
+#define MT7996_RRO_MSDU_PG_SIZE_PER_CR	0x10000
+
 struct mt7996_vif;
 struct mt7996_sta;
 struct mt7996_dfs_pulse;
@@ -400,6 +405,10 @@ struct mt7996_dev {
 			void *ptr;
 			dma_addr_t phy_addr;
 		} session;
+		struct {
+			void *ptr;
+			dma_addr_t phy_addr;
+		} msdu_pg[MT7996_RRO_MSDU_PG_CR_CNT];
 
 		struct work_struct work;
 		struct list_head poll_list;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 4b8bc008ab3143dcf44cd40b17b9f09778cfd464..070cdebcd19d7713ebae1d74fdf0c6062eb7c925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -88,6 +88,8 @@ enum offs_rev {
 #define MT_RRO_BA_BITMAP_BASE1			MT_RRO_TOP(0xC)
 #define WF_RRO_AXI_MST_CFG			MT_RRO_TOP(0xB8)
 #define WF_RRO_AXI_MST_CFG_DIDX_OK		BIT(12)
+
+#define MT_RRO_ADDR_ARRAY_BASE0			MT_RRO_TOP(0x30)
 #define MT_RRO_ADDR_ARRAY_BASE1			MT_RRO_TOP(0x34)
 #define MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE	BIT(31)
 
@@ -108,6 +110,14 @@ enum offs_rev {
 
 #define MT_RRO_ADDR_ELEM_SEG_ADDR0		MT_RRO_TOP(0x400)
 
+#define MT_RRO_3_0_EMU_CONF			MT_RRO_TOP(0x600)
+#define MT_RRO_3_0_EMU_CONF_EN_MASK		BIT(11)
+
+#define MT_RRO_3_1_GLOBAL_CONFIG		MT_RRO_TOP(0x604)
+#define MT_RRO_3_1_GLOBAL_CONFIG_INTERLEAVE_EN	BIT(0)
+
+#define MT_RRO_MSDU_PG_SEG_ADDR0		MT_RRO_TOP(0x620)
+
 #define MT_RRO_ACK_SN_CTRL			MT_RRO_TOP(0x50)
 #define MT_RRO_ACK_SN_CTRL_SN_MASK		GENMASK(27, 16)
 #define MT_RRO_ACK_SN_CTRL_SESSION_MASK		GENMASK(11, 0)

-- 
2.50.1


