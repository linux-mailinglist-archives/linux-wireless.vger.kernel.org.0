Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E997188AD0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCQQmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCQQmm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:42 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4C820735;
        Tue, 17 Mar 2020 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463359;
        bh=5lcu8hIH4lILHcGmnAiQL9o1jcyYIj61wCz7B8DPJaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+ScWhjQnyfY51yjB8szkGBL7GOPgxyqzmS7mBGJj9Pu3PtNDj3RhmBGxuOeSct+3
         +6eXQbFeKPk2uoCF3EX4mXTFlVyVUX3XBGJ46AjM5dXen0q0lcqeOYraJJqDREYvUE
         CEeJg2Lzu8UbFElmUBR2FBv1cLhfHT31iNcgrwy4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 25/25] mt76: mt7615: introduce mt7663e support
Date:   Tue, 17 Mar 2020 17:41:32 +0100
Message-Id: <74b288cdc485595ca1fa6da65efe42b75a1e392c.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663e 802.11ac 2x2:2 chipset to mt7615 driver.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  50 +++++-
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |  40 +++--
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  18 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   6 +
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  11 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 156 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  28 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   5 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  12 +-
 10 files changed, 308 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 1bc71f5081ce..b19f208e3d54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -101,8 +101,12 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
+	u16 flag;
 
 	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
 
 	switch (type) {
 	case PKT_TYPE_TXS:
@@ -116,6 +120,7 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	case PKT_TYPE_RX_EVENT:
 		mt7615_mcu_rx_event(dev, skb);
 		break;
+	case PKT_TYPE_NORMAL_MCU:
 	case PKT_TYPE_NORMAL:
 		if (!mt7615_mac_fill_rx(dev, skb)) {
 			mt76_rx(&dev->mt76, q, skb);
@@ -186,6 +191,41 @@ static void mt7622_dma_sched_init(struct mt7615_dev *dev)
 	mt76_wr(dev, reg + MT_DMASHDL_SCHED_SET1, 0xedcba987);
 }
 
+static void mt7663_dma_sched_init(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt76_rmw(dev, MT_DMA_SHDL(MT_DMASHDL_PKT_MAX_SIZE),
+		 MT_DMASHDL_PKT_MAX_SIZE_PLE | MT_DMASHDL_PKT_MAX_SIZE_PSE,
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PLE, 1) |
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PSE, 8));
+
+	/* enable refill control group 0, 1, 2, 4, 5 */
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_REFILL), 0xffc80000);
+	/* enable group 0, 1, 2, 4, 5, 15 */
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_OPTIONAL), 0x70068037);
+
+	/* each group min quota must larger then PLE_PKT_MAX_SIZE_NUM */
+	for (i = 0; i < 5; i++)
+		mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_GROUP_QUOTA(i)),
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x40) |
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x800));
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_GROUP_QUOTA(5)),
+		FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x40) |
+		FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x40));
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_GROUP_QUOTA(15)),
+		FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x20) |
+		FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x20));
+
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(0)), 0x42104210);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(1)), 0x42104210);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(2)), 0x00050005);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_Q_MAP(3)), 0);
+	/* ALTX0 and ALTX1 QID mapping to group 5 */
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET0), 0x6012345f);
+	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET1), 0xedcba987);
+}
+
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int rx_ring_size = MT7615_RX_RING_SIZE;
@@ -198,10 +238,6 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		MT_WPDMA_GLO_CFG_FIFO_LITTLE_ENDIAN |
 		MT_WPDMA_GLO_CFG_OMIT_TX_INFO);
 
-	if (!is_mt7622(&dev->mt76))
-		mt76_set(dev, MT_WPDMA_GLO_CFG,
-			 MT_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY);
-
 	mt76_rmw_field(dev, MT_WPDMA_GLO_CFG,
 		       MT_WPDMA_GLO_CFG_TX_BT_SIZE_BIT0, 0x1);
 
@@ -215,6 +251,9 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		       MT_WPDMA_GLO_CFG_MULTI_DMA_EN, 0x3);
 
 	if (is_mt7615(&dev->mt76)) {
+		mt76_set(dev, MT_WPDMA_GLO_CFG,
+			 MT_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY);
+
 		mt76_wr(dev, MT_WPDMA_GLO_CFG1, 0x1);
 		mt76_wr(dev, MT_WPDMA_TX_PRE_CFG, 0xf0000);
 		mt76_wr(dev, MT_WPDMA_RX_PRE_CFG, 0xf7f0000);
@@ -271,6 +310,9 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (is_mt7622(&dev->mt76))
 		mt7622_dma_sched_init(dev);
 
+	if (is_mt7663(&dev->mt76))
+		mt7663_dma_sched_init(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index b1091694569e..dfa9a08b896d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -128,19 +128,25 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
-	u8 tx_mask, max_nss;
-	u32 val;
+	u8 tx_mask;
 
 	mt7615_eeprom_parse_hw_band_cap(dev);
 
-	/* read tx-rx mask from eeprom */
-	val = mt76_rr(dev, MT_TOP_STRAP_STA);
-	max_nss = val & MT_TOP_3NSS ? 3 : 4;
+	if (is_mt7663(&dev->mt76)) {
+		tx_mask = 2;
+	} else {
+		u8 max_nss;
+		u32 val;
 
-	tx_mask =  FIELD_GET(MT_EE_NIC_CONF_TX_MASK,
-			     eeprom[MT_EE_NIC_CONF_0]);
-	if (!tx_mask || tx_mask > max_nss)
-		tx_mask = max_nss;
+		/* read tx-rx mask from eeprom */
+		val = mt76_rr(dev, MT_TOP_STRAP_STA);
+		max_nss = val & MT_TOP_3NSS ? 3 : 4;
+
+		tx_mask =  FIELD_GET(MT_EE_NIC_CONF_TX_MASK,
+				     eeprom[MT_EE_NIC_CONF_0]);
+		if (!tx_mask || tx_mask > max_nss)
+			tx_mask = max_nss;
+	}
 
 	dev->chainmask = BIT(tx_mask) - 1;
 	dev->mphy.antenna_mask = dev->chainmask;
@@ -247,6 +253,18 @@ static void mt7622_apply_cal_free_data(struct mt7615_dev *dev)
 	}
 }
 
+static void mt7615_cal_free_data(struct mt7615_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7622:
+		mt7622_apply_cal_free_data(dev);
+		break;
+	case 0x7615:
+		mt7615_apply_cal_free_data(dev);
+		break;
+	}
+}
+
 int mt7615_eeprom_init(struct mt7615_dev *dev)
 {
 	int ret;
@@ -259,10 +277,8 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
 	if (ret && dev->mt76.otp.data)
 		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
 		       MT7615_EEPROM_SIZE);
-	else if (is_mt7622(&dev->mt76))
-		mt7622_apply_cal_free_data(dev);
 	else
-		mt7615_apply_cal_free_data(dev);
+		mt7615_cal_free_data(dev);
 
 	mt7615_eeprom_parse_hw_cap(dev);
 	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6a4b3eaa12f9..03b1e56534d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -4,6 +4,7 @@
  * Author: Roy Luo <royluo@google.com>
  *         Ryder Lee <ryder.lee@mediatek.com>
  *         Felix Fietkau <nbd@nbd.name>
+ *         Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
 #include <linux/etherdevice.h>
@@ -77,7 +78,6 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	int i;
 
 	mt7615_init_mac_chain(dev, 0);
-	mt7615_init_mac_chain(dev, 1);
 
 	mt76_rmw_field(dev, MT_TMAC_CTCR0,
 		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
@@ -101,15 +101,25 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
 		FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4));
 
-	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
-		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072));
-
 	for (i = 0; i < MT7615_WTBL_SIZE; i++)
 		mt7615_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_EN);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_EN);
+
+	/* disable hdr translation and hw AMSDU */
+	mt76_wr(dev, MT_DMA_DCR0,
+		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
+		MT_DMA_DCR0_RX_VEC_DROP);
+	if (is_mt7663(&dev->mt76)) {
+		mt76_wr(dev, MT_CSR(0x010), 0x8208);
+		mt76_wr(dev, 0x44064, 0x2000000);
+		mt76_wr(dev, MT_WF_AGG(0x160), 0x5c341c02);
+		mt76_wr(dev, MT_WF_AGG(0x164), 0x70708040);
+	} else {
+		mt7615_init_mac_chain(dev, 1);
+	}
 }
 
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4d5171044b1e..1f1961806db0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1524,6 +1524,9 @@ void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
 	if (dev->scs_en == enable)
 		goto out;
 
+	if (is_mt7663(&dev->mt76))
+		goto out;
+
 	if (enable) {
 		mt76_set(dev, MT_WF_PHY_MIN_PRI_PWR(0),
 			 MT_WF_PHY_PD_BLK(0));
@@ -1555,6 +1558,9 @@ void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy)
 {
 	u32 rxtd;
 
+	if (is_mt7663(&dev->mt76))
+		return;
+
 	if (ext_phy)
 		rxtd = MT_WF_PHY_RXTD2(10);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 6fa7e3dd6a3a..e0b89257db90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -8,6 +8,7 @@
 #define MT_CT_DMA_BUF_NUM		2
 
 #define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
 #define MT_RXD0_PKT_TYPE		GENMASK(31, 29)
 
 #define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
@@ -26,7 +27,8 @@ enum rx_pkt_type {
 	PKT_TYPE_RX_TMR,
 	PKT_TYPE_RETRIEVE,
 	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_NORMAL_MCU,
 };
 
 #define MT_RXD1_NORMAL_BSSID		GENMASK(31, 26)
@@ -229,8 +231,15 @@ enum tx_phy_bandwidth {
 #define MT_TXD6_FIXED_BW		BIT(2)
 #define MT_TXD6_BW			GENMASK(1, 0)
 
+/* MT7663 DW7 HW-AMSDU */
+#define MT_TXD7_HW_AMSDU_CAP		BIT(30)
 #define MT_TXD7_TYPE			GENMASK(21, 20)
 #define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
+#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
+#define MT_TXD7_SPE_IDX_SLE		BIT(10)
+
+#define MT_TXD8_L_TYPE			GENMASK(5, 4)
+#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
 
 #define MT_TX_RATE_STBC			BIT(11)
 #define MT_TX_RATE_NSS			GENMASK(10, 9)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8e0225e6cc72..50c98913d81d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -29,8 +29,37 @@ struct mt7615_fw_trailer {
 	__le32 len;
 } __packed;
 
+#define FW_V3_COMMON_TAILER_SIZE	36
+#define FW_V3_REGION_TAILER_SIZE	40
+#define FW_START_OVERRIDE		BIT(0)
+#define FW_START_DLYCAL                 BIT(1)
+#define FW_START_WORKING_PDA_CR4	BIT(2)
+
+struct mt7663_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 reserv[2];
+	char fw_ver[10];
+	char build_date[15];
+	u32 crc;
+} __packed;
+
+struct mt7663_fw_buf {
+	u32 crc;
+	u32 d_img_size;
+	u32 block_size;
+	u8 rsv[4];
+	u32 img_dest_addr;
+	u32 img_size;
+	u8 feature_set;
+};
+
 #define MT7615_PATCH_ADDRESS		0x80000
 #define MT7622_PATCH_ADDRESS		0x9c000
+#define MT7663_PATCH_ADDRESS		0xdc000
 
 #define N9_REGION_NUM			2
 #define CR4_REGION_NUM			1
@@ -44,6 +73,7 @@ struct mt7615_fw_trailer {
 #define DL_MODE_KEY_IDX			GENMASK(2, 1)
 #define DL_MODE_RESET_SEC_IV		BIT(3)
 #define DL_MODE_WORKING_PDA_CR4		BIT(4)
+#define DL_MODE_VALID_RAM_ENTRY         BIT(5)
 #define DL_MODE_NEED_RSP		BIT(31)
 
 #define FW_START_OVERRIDE		BIT(0)
@@ -1816,6 +1846,121 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 				   &data, sizeof(data), true);
 }
 
+static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
+{
+	u32 offset = 0, override_addr = 0, flag = 0;
+	const struct mt7663_fw_trailer *hdr;
+	const struct mt7663_fw_buf *buf;
+	const struct firmware *fw;
+	const u8 *base_addr;
+	int i, ret;
+
+	ret = request_firmware(&fw, name, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < FW_V3_COMMON_TAILER_SIZE) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7663_fw_trailer *)(fw->data + fw->size -
+						 FW_V3_COMMON_TAILER_SIZE);
+
+	dev_info(dev->mt76.dev, "N9 Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+	dev_info(dev->mt76.dev, "Region number: 0x%x\n", hdr->n_region);
+
+	base_addr = fw->data + fw->size - FW_V3_COMMON_TAILER_SIZE;
+	for (i = 0; i < hdr->n_region; i++) {
+		u32 shift = (hdr->n_region - i) * FW_V3_REGION_TAILER_SIZE;
+		u32 len, addr, mode;
+
+		dev_info(dev->mt76.dev, "Parsing tailer Region: %d\n", i);
+
+		buf = (const struct mt7663_fw_buf *)(base_addr - shift);
+		mode = mt7615_mcu_gen_dl_mode(buf->feature_set, false);
+		addr = le32_to_cpu(buf->img_dest_addr);
+		len = le32_to_cpu(buf->img_size);
+
+		ret = mt7615_mcu_init_download(dev, addr, len, mode);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = mt7615_mcu_send_firmware(dev, fw->data + offset, len);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Failed to send firmware\n");
+			goto out;
+		}
+
+		offset += buf->img_size;
+		if (buf->feature_set & DL_MODE_VALID_RAM_ENTRY) {
+			override_addr = le32_to_cpu(buf->img_dest_addr);
+			dev_info(dev->mt76.dev, "Region %d, override_addr = 0x%08x\n",
+				 i, override_addr);
+		}
+	}
+
+	if (is_mt7663(&dev->mt76)) {
+		flag |= FW_START_DLYCAL;
+		if (override_addr)
+			flag |= FW_START_OVERRIDE;
+
+		dev_info(dev->mt76.dev, "override_addr = 0x%08x, option = %d\n",
+			 override_addr, flag);
+	}
+
+	ret = mt7615_mcu_start_firmware(dev, override_addr, flag);
+	if (ret)
+		dev_err(dev->mt76.dev, "Failed to start N9 firmware\n");
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7663_load_firmware(struct mt7615_dev *dev)
+{
+	int ret;
+
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret) {
+		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
+		return -EIO;
+	}
+
+	ret = mt7615_load_patch(dev, MT7663_PATCH_ADDRESS, MT7663_ROM_PATCH);
+	if (ret)
+		return ret;
+
+	dev->fw_ver = MT7615_FIRMWARE_V3;
+	dev->mcu_ops = &uni_update_ops;
+
+	ret = mt7663_load_n9(dev, MT7663_FIRMWARE_N9);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		ret = mt76_get_field(dev, MT_CONN_ON_MISC,
+				     MT7663_TOP_MISC2_FW_STATE);
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+		return -EIO;
+	}
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
+
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
@@ -1831,10 +1976,17 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	if (is_mt7622(&dev->mt76))
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7622:
 		ret = mt7622_load_firmware(dev);
-	else
+		break;
+	case 0x7663:
+		ret = mt7663_load_firmware(dev);
+		break;
+	default:
 		ret = mt7615_load_firmware(dev);
+		break;
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 43c8b29020f5..d2eff5442824 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -10,6 +10,7 @@ const u32 mt7615e_reg_map[] = {
 	[MT_TOP_CFG_BASE]	= 0x01000,
 	[MT_HW_BASE]		= 0x01000,
 	[MT_PCIE_REMAP_2]	= 0x02504,
+	[MT_ARB_BASE]		= 0x20c00,
 	[MT_HIF_BASE]		= 0x04000,
 	[MT_CSR_BASE]		= 0x07000,
 	[MT_PHY_BASE]		= 0x10000,
@@ -28,6 +29,30 @@ const u32 mt7615e_reg_map[] = {
 	[MT_EFUSE_ADDR_BASE]	= 0x81070000,
 };
 
+const u32 mt7663e_reg_map[] = {
+	[MT_TOP_CFG_BASE]	= 0x01000,
+	[MT_HW_BASE]		= 0x02000,
+	[MT_DMA_SHDL_BASE]	= 0x06000,
+	[MT_PCIE_REMAP_2]	= 0x0700c,
+	[MT_ARB_BASE]		= 0x20c00,
+	[MT_HIF_BASE]		= 0x04000,
+	[MT_CSR_BASE]		= 0x07000,
+	[MT_PHY_BASE]		= 0x10000,
+	[MT_CFG_BASE]		= 0x20000,
+	[MT_AGG_BASE]		= 0x22000,
+	[MT_TMAC_BASE]		= 0x24000,
+	[MT_RMAC_BASE]		= 0x25000,
+	[MT_DMA_BASE]		= 0x27000,
+	[MT_WTBL_BASE_ON]	= 0x29000,
+	[MT_WTBL_BASE_OFF]	= 0x29800,
+	[MT_LPON_BASE]		= 0x2b000,
+	[MT_MIB_BASE]		= 0x2d000,
+	[MT_WTBL_BASE_ADDR]	= 0x30000,
+	[MT_PCIE_REMAP_BASE2]	= 0x90000,
+	[MT_TOP_MISC_BASE]	= 0xc0000,
+	[MT_EFUSE_ADDR_BASE]	= 0x78011000,
+};
+
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
 {
 	u32 base, offset;
@@ -135,6 +160,9 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	if (ret)
 		goto error;
 
+	if (is_mt7663(mdev))
+		mt76_wr(dev, MT_PCIE_IRQ_ENABLE, 1);
+
 	ret = mt7615_register_device(dev);
 	if (ret)
 		goto error;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 143fa63517ff..8b3d95a2d7b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -38,6 +38,10 @@
 
 #define MT7615_FIRMWARE_V1		1
 #define MT7615_FIRMWARE_V2		2
+#define MT7615_FIRMWARE_V3		3
+
+#define MT7663_ROM_PATCH		"mediatek/mt7663pr2h_v3.bin"
+#define MT7663_FIRMWARE_N9              "mediatek/mt7663_n9_v3.bin"
 
 #define MT7615_EEPROM_SIZE		1024
 #define MT7615_TOKEN_SIZE		4096
@@ -287,6 +291,7 @@ mt7615_ext_phy(struct mt7615_dev *dev)
 
 extern const struct ieee80211_ops mt7615_ops;
 extern const u32 mt7615e_reg_map[__MT_BASE_MAX];
+extern const u32 mt7663e_reg_map[__MT_BASE_MAX];
 extern struct pci_driver mt7615_pci_driver;
 extern struct platform_driver mt7622_wmac_driver;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index d20db968c7ec..c8d0f893a47f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -13,12 +13,14 @@
 
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
+	{ PCI_DEVICE(0x14c3, 0x7663) },
 	{ },
 };
 
 static int mt7615_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
+	const u32 *map;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -35,8 +37,9 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	map = id->device == 0x7663 ? mt7663e_reg_map : mt7615e_reg_map;
 	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-				 pdev->irq, mt7615e_reg_map);
+				 pdev->irq, map);
 }
 
 static void mt7615_pci_remove(struct pci_dev *pdev)
@@ -58,3 +61,5 @@ MODULE_DEVICE_TABLE(pci, mt7615_pci_device_table);
 MODULE_FIRMWARE(MT7615_FIRMWARE_CR4);
 MODULE_FIRMWARE(MT7615_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7615_ROM_PATCH);
+MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7663_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 928e5a841885..1e0d95b917e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -7,7 +7,9 @@
 enum mt7615_reg_base {
 	MT_TOP_CFG_BASE,
 	MT_HW_BASE,
+	MT_DMA_SHDL_BASE,
 	MT_PCIE_REMAP_2,
+	MT_ARB_BASE,
 	MT_HIF_BASE,
 	MT_CSR_BASE,
 	MT_PHY_BASE,
@@ -40,6 +42,8 @@ enum mt7615_reg_base {
 #define MT_TOP_MISC2			((dev)->reg_map[MT_TOP_CFG_BASE] + 0x134)
 #define MT_TOP_MISC2_FW_STATE		GENMASK(2, 0)
 
+#define MT7663_TOP_MISC2_FW_STATE	GENMASK(3, 1)
+
 #define MT_MCU_BASE			0x2000
 #define MT_MCU(ofs)			(MT_MCU_BASE + (ofs))
 
@@ -58,6 +62,10 @@ enum mt7615_reg_base {
 #define MT7663_MCU_PCIE_REMAP_2_OFFSET	GENMASK(15, 0)
 #define MT7663_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 16)
 
+#define MT_HIF2_BASE			0xf0000
+#define MT_HIF2(ofs)			(MT_HIF2_BASE + (ofs))
+#define MT_PCIE_IRQ_ENABLE		MT_HIF2(0x188)
+
 #define MT_CFG_LPCR_HOST		MT_HIF(0x1f0)
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_CFG_LPCR_HOST_DRV_OWN	BIT(1)
@@ -209,7 +217,7 @@ enum mt7615_reg_base {
 #define MT_AGG_SCR			MT_WF_AGG(0x0fc)
 #define MT_AGG_SCR_NLNAV_MID_PTEC_DIS	BIT(3)
 
-#define MT_WF_ARB_BASE			0x20c00
+#define MT_WF_ARB_BASE			((dev)->reg_map[MT_ARB_BASE])
 #define MT_WF_ARB(ofs)			(MT_WF_ARB_BASE + (ofs))
 
 #define MT_ARB_SCR			MT_WF_ARB(0x080)
@@ -400,6 +408,8 @@ enum mt7615_reg_base {
 
 #define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
 
+#define MT_DMA_SHDL(ofs)		(dev->reg_map[MT_DMA_SHDL_BASE] + (ofs))
+
 #define MT_DMASHDL_BASE			0x5000a000
 #define MT_DMASHDL_OPTIONAL		0x008
 #define MT_DMASHDL_PAGE			0x00c
-- 
2.25.1

