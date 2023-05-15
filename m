Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052AC702E1C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbjEON3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjEON3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 09:29:35 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DF19BC;
        Mon, 15 May 2023 06:29:32 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pyYGG-0003Dv-1Q;
        Mon, 15 May 2023 13:29:12 +0000
Date:   Mon, 15 May 2023 15:27:12 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Alexander Couzens <lynxis@fe80.eu>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Lorenz Brun <lorenz@brun.one>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] wifi: mt76: mt7915: add support for MT7981
Message-ID: <5f906578cd213b70e1049e927a2905ad1cb63afd.1684155848.git.daniel@makrotopia.org>
References: <cover.1684155848.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684155848.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alexander Couzens <lynxis@fe80.eu>

Add support for the MediaTek MT7981 SoC which is similar to the MT7986
but with a newer IP cores and only 2x ARM Cortex-A53 instead of 4x.
Unlike MT7986 the MT7981 can only connect a single wireless frontend,
usually MT7976 is used for DBDC.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  10 ++
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   6 +-
 .../wireless/mediatek/mt76/mt7915/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7915/coredump.c  |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |   6 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  17 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 +-
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 162 ++++++++++++------
 13 files changed, 179 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 15653b274f83..77ca8f057d61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -197,11 +197,21 @@ static inline bool is_mt7916(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7906;
 }
 
+static inline bool is_mt7981(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7981;
+}
+
 static inline bool is_mt7986(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7986;
 }
 
+static inline bool is_mt798x(struct mt76_dev *dev)
+{
+	return is_mt7981(dev) || is_mt7986(dev);
+}
+
 static inline bool is_mt7996(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7990;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index d710726d47bf..896ec38c23d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -14,12 +14,12 @@ config MT7915E
 
 	  To compile this driver as a module, choose M here.
 
-config MT7986_WMAC
-	bool "MT7986 (SoC) WMAC support"
+config MT798X_WMAC
+	bool "MT798x (SoC) WMAC support"
 	depends on MT7915E
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select REGMAP
 	help
-	  This adds support for the built-in WMAC on MT7986 SoC device
+	  This adds support for the built-in WMAC on MT7981 and MT7986 SoC device
 	  which has the same feature set as a MT7915, but enables 6E
 	  support.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index 797ae49805c3..e0ca638c91a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -6,5 +6,5 @@ mt7915e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
 	     debugfs.o mmio.o
 
 mt7915e-$(CONFIG_NL80211_TESTMODE) += testmode.o
-mt7915e-$(CONFIG_MT7986_WMAC) += soc.o
+mt7915e-$(CONFIG_MT798X_WMAC) += soc.o
 mt7915e-$(CONFIG_DEV_COREDUMP) += coredump.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
index d097a56dd33d..5daf2258dfe6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
@@ -52,7 +52,7 @@ static const struct mt7915_mem_region mt7916_mem_regions[] = {
 	},
 };
 
-static const struct mt7915_mem_region mt7986_mem_regions[] = {
+static const struct mt7915_mem_region mt798x_mem_regions[] = {
 	{
 		.start = 0x00800000,
 		.len = 0x0005ffff,
@@ -92,9 +92,10 @@ mt7915_coredump_get_mem_layout(struct mt7915_dev *dev, u32 *num)
 	case 0x7915:
 		*num = ARRAY_SIZE(mt7915_mem_regions);
 		return &mt7915_mem_regions[0];
+	case 0x7981:
 	case 0x7986:
-		*num = ARRAY_SIZE(mt7986_mem_regions);
-		return &mt7986_mem_regions[0];
+		*num = ARRAY_SIZE(mt798x_mem_regions);
+		return &mt798x_mem_regions[0];
 	case 0x7916:
 		*num = ARRAY_SIZE(mt7916_mem_regions);
 		return &mt7916_mem_regions[0];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 43a5456d4b97..86a93dedb1bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -11,7 +11,7 @@ mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base
 	struct mt7915_dev *dev = phy->dev;
 
 	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
-		if (is_mt7986(&dev->mt76))
+		if (is_mt798x(&dev->mt76))
 			ring_base += MT_TXQ_ID(0) * MT_RING_SIZE;
 		else
 			ring_base = MT_WED_TX_RING_BASE;
@@ -370,7 +370,7 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 		int ret;
 
 		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
-		if (!is_mt7986(&dev->mt76))
+		if (!is_mt798x(&dev->mt76))
 			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
 		else
 			mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
@@ -404,7 +404,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	mt7915_dma_disable(dev, true);
 
 	if (mtk_wed_device_active(&mdev->mmio.wed)) {
-		if (!is_mt7986(mdev)) {
+		if (!is_mt798x(mdev)) {
 			u8 wed_control_rx1 = is_mt7915(mdev) ? 1 : 2;
 
 			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index a79628933948..76be7308460b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -39,6 +39,8 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
 		return CHECK_EEPROM_ERR(is_mt7915(&dev->mt76));
 	case 0x7916:
 		return CHECK_EEPROM_ERR(is_mt7916(&dev->mt76));
+	case 0x7981:
+		return CHECK_EEPROM_ERR(is_mt7981(&dev->mt76));
 	case 0x7986:
 		return CHECK_EEPROM_ERR(is_mt7986(&dev->mt76));
 	default:
@@ -52,6 +54,9 @@ static char *mt7915_eeprom_name(struct mt7915_dev *dev)
 	case 0x7915:
 		return dev->dbdc_support ?
 		       MT7915_EEPROM_DEFAULT_DBDC : MT7915_EEPROM_DEFAULT;
+	case 0x7981:
+		/* mt7981 only supports mt7976 and only in DBDC mode */
+		return MT7981_EEPROM_MT7976_DEFAULT_DBDC;
 	case 0x7986:
 		switch (mt7915_check_adie(dev, true)) {
 		case MT7976_ONE_ADIE_DBDC:
@@ -215,7 +220,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 					eeprom[MT_EE_WIFI_CONF + 2 + band]);
 		}
 
-		if (!is_mt7986(&dev->mt76))
+		if (!is_mt798x(&dev->mt76))
 			nss_max = 2;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ac2049f49bb3..34825a166671 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -732,7 +732,7 @@ void mt7915_wfsys_reset(struct mt7915_dev *dev)
 		mt76_clear(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE);
 
 		msleep(100);
-	} else if (is_mt7986(&dev->mt76)) {
+	} else if (is_mt798x(&dev->mt76)) {
 		mt7986_wmac_disable(dev);
 		msleep(20);
 
@@ -753,7 +753,7 @@ static bool mt7915_band_config(struct mt7915_dev *dev)
 
 	dev->phy.mt76->band_idx = 0;
 
-	if (is_mt7986(&dev->mt76)) {
+	if (is_mt798x(&dev->mt76)) {
 		u32 sku = mt7915_check_adie(dev, true);
 
 		/*
@@ -1162,7 +1162,7 @@ static void mt7915_stop_hardware(struct mt7915_dev *dev)
 	mt7915_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
-	if (is_mt7986(&dev->mt76))
+	if (is_mt798x(&dev->mt76))
 		mt7986_wmac_disable(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7df8d95fc3fb..fb6bab879832 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1576,7 +1576,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
-		if (!is_mt7986(&dev->mt76))
+		if (!is_mt798x(&dev->mt76))
 			mt76_wr(dev, MT_INT_WED_MASK_CSR, 0);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9fcb22fa1f97..9b5cf18bee64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -13,6 +13,9 @@
 	case 0x7915:						\
 		_fw = MT7915_##name;				\
 		break;						\
+	case 0x7981:						\
+		_fw = MT7981_##name;				\
+		break;						\
 	case 0x7986:						\
 		_fw = MT7986_##name##__VA_ARGS__;		\
 		break;						\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 45f3558bf31c..78b34699a5bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -417,7 +417,7 @@ static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
 	u32 l1_remap;
 
-	if (is_mt7986(&dev->mt76))
+	if (is_mt798x(&dev->mt76))
 		return MT_CONN_INFRA_OFFSET(addr);
 
 	l1_remap = is_mt7915(&dev->mt76) ?
@@ -447,7 +447,7 @@ static u32 mt7915_reg_map_l2(struct mt7915_dev *dev, u32 addr)
 		/* use read to push write */
 		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
 	} else {
-		u32 ofs = is_mt7986(&dev->mt76) ? 0x400000 : 0;
+		u32 ofs = is_mt798x(&dev->mt76) ? 0x400000 : 0;
 
 		offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET_MT7916, addr);
 		base = FIELD_GET(MT_HIF_REMAP_L2_BASE_MT7916, addr);
@@ -785,7 +785,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.nbuf = MT7915_HW_TOKEN_SIZE;
 	wed->wlan.tx_tbit[0] = is_mt7915(&dev->mt76) ? 4 : 30;
 	wed->wlan.tx_tbit[1] = is_mt7915(&dev->mt76) ? 5 : 31;
-	wed->wlan.txfree_tbit = is_mt7986(&dev->mt76) ? 2 : 1;
+	wed->wlan.txfree_tbit = is_mt798x(&dev->mt76) ? 2 : 1;
 	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
 	wed->wlan.wcid_512 = !is_mt7915(&dev->mt76);
 
@@ -795,7 +795,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	if (is_mt7915(&dev->mt76)) {
 		wed->wlan.rx_tbit[0] = 16;
 		wed->wlan.rx_tbit[1] = 17;
-	} else if (is_mt7986(&dev->mt76)) {
+	} else if (is_mt798x(&dev->mt76)) {
 		wed->wlan.rx_tbit[0] = 22;
 		wed->wlan.rx_tbit[1] = 23;
 	} else {
@@ -853,6 +853,7 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 		dev->reg.map = mt7916_reg_map;
 		dev->reg.map_size = ARRAY_SIZE(mt7916_reg_map);
 		break;
+	case 0x7981:
 	case 0x7986:
 		dev->reg.reg_rev = mt7986_reg;
 		dev->reg.offs_rev = mt7916_offs;
@@ -1062,8 +1063,8 @@ static int __init mt7915_init(void)
 	if (ret)
 		goto error_pci;
 
-	if (IS_ENABLED(CONFIG_MT7986_WMAC)) {
-		ret = platform_driver_register(&mt7986_wmac_driver);
+	if (IS_ENABLED(CONFIG_MT798X_WMAC)) {
+		ret = platform_driver_register(&mt798x_wmac_driver);
 		if (ret)
 			goto error_wmac;
 	}
@@ -1080,8 +1081,8 @@ static int __init mt7915_init(void)
 
 static void __exit mt7915_exit(void)
 {
-	if (IS_ENABLED(CONFIG_MT7986_WMAC))
-		platform_driver_unregister(&mt7986_wmac_driver);
+	if (IS_ENABLED(CONFIG_MT798X_WMAC))
+		platform_driver_unregister(&mt798x_wmac_driver);
 
 	pci_unregister_driver(&mt7915_pci_driver);
 	pci_unregister_driver(&mt7915_hif_driver);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b3ead3530740..eaf82d630cef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -34,6 +34,10 @@
 #define MT7916_FIRMWARE_WM		"mediatek/mt7916_wm.bin"
 #define MT7916_ROM_PATCH		"mediatek/mt7916_rom_patch.bin"
 
+#define MT7981_FIRMWARE_WA		"mediatek/mt7981_wa.bin"
+#define MT7981_FIRMWARE_WM		"mediatek/mt7981_wm.bin"
+#define MT7981_ROM_PATCH		"mediatek/mt7981_rom_patch.bin"
+
 #define MT7986_FIRMWARE_WA		"mediatek/mt7986_wa.bin"
 #define MT7986_FIRMWARE_WM		"mediatek/mt7986_wm.bin"
 #define MT7986_FIRMWARE_WM_MT7975	"mediatek/mt7986_wm_mt7975.bin"
@@ -43,6 +47,9 @@
 #define MT7915_EEPROM_DEFAULT		"mediatek/mt7915_eeprom.bin"
 #define MT7915_EEPROM_DEFAULT_DBDC	"mediatek/mt7915_eeprom_dbdc.bin"
 #define MT7916_EEPROM_DEFAULT		"mediatek/mt7916_eeprom.bin"
+
+#define MT7981_EEPROM_MT7976_DEFAULT_DBDC	"mediatek/mt7981_eeprom_mt7976_dbdc.bin"
+
 #define MT7986_EEPROM_MT7975_DEFAULT		"mediatek/mt7986_eeprom_mt7975.bin"
 #define MT7986_EEPROM_MT7975_DUAL_DEFAULT	"mediatek/mt7986_eeprom_mt7975_dual.bin"
 #define MT7986_EEPROM_MT7976_DEFAULT		"mediatek/mt7986_eeprom_mt7976.bin"
@@ -420,8 +427,7 @@ mt7915_ext_phy(struct mt7915_dev *dev)
 static inline u32 mt7915_check_adie(struct mt7915_dev *dev, bool sku)
 {
 	u32 mask = sku ? MT_CONNINFRA_SKU_MASK : MT_ADIE_TYPE_MASK;
-
-	if (!is_mt7986(&dev->mt76))
+	if (!is_mt798x(&dev->mt76))
 		return 0;
 
 	return mt76_rr(dev, MT_CONNINFRA_SKU_DEC_ADDR) & mask;
@@ -431,9 +437,9 @@ extern const struct ieee80211_ops mt7915_ops;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
 extern struct pci_driver mt7915_pci_driver;
 extern struct pci_driver mt7915_hif_driver;
-extern struct platform_driver mt7986_wmac_driver;
+extern struct platform_driver mt798x_wmac_driver;
 
-#ifdef CONFIG_MT7986_WMAC
+#ifdef CONFIG_MT798X_WMAC
 int mt7986_wmac_enable(struct mt7915_dev *dev);
 void mt7986_wmac_disable(struct mt7915_dev *dev);
 #else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index c8e478a55081..374677f73e51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -871,7 +871,12 @@ enum offs_rev {
 #define MT_AFE_RG_WBG_EN_WPLL_UP_MASK	BIT(20)
 #define MT_AFE_RG_WBG_EN_PLL_UP_MASK	(MT_AFE_RG_WBG_EN_BPLL_UP_MASK | \
 					 MT_AFE_RG_WBG_EN_WPLL_UP_MASK)
-#define MT_AFE_RG_WBG_EN_TXCAL_MASK	GENMASK(21, 17)
+#define MT_AFE_RG_WBG_EN_TXCAL_WF4	BIT(29)
+#define MT_AFE_RG_WBG_EN_TXCAL_BT	BIT(21)
+#define MT_AFE_RG_WBG_EN_TXCAL_WF3	BIT(20)
+#define MT_AFE_RG_WBG_EN_TXCAL_WF2	BIT(19)
+#define MT_AFE_RG_WBG_EN_TXCAL_WF1	BIT(18)
+#define MT_AFE_RG_WBG_EN_TXCAL_WF0	BIT(17)
 
 #define MT_ADIE_SLP_CTRL_BASE(_band)	(0x18005000 + ((_band) << 19))
 #define MT_ADIE_SLP_CTRL(_band, ofs)	(MT_ADIE_SLP_CTRL_BASE(_band) + (ofs))
@@ -1096,6 +1101,12 @@ enum offs_rev {
 #define MT_TOP_MCU_EMI_BASE		MT_TOP(0x1c4)
 #define MT_TOP_MCU_EMI_BASE_MASK	GENMASK(19, 0)
 
+#define MT_TOP_WF_AP_PERI_BASE		MT_TOP(0x1c8)
+#define MT_TOP_WF_AP_PERI_BASE_MASK	GENMASK(19, 0)
+
+#define MT_TOP_EFUSE_BASE		MT_TOP(0x1cc)
+#define MT_TOP_EFUSE_BASE_MASK		GENMASK(19, 0)
+
 #define MT_TOP_CONN_INFRA_WAKEUP	MT_TOP(0x1a0)
 #define MT_TOP_CONN_INFRA_WAKEUP_MASK	BIT(0)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 32c137066e7f..1f23e60f9714 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -16,6 +16,9 @@
 
 #include "mt7915.h"
 
+#define MT7981_CON_INFRA_VERSION 0x02090000
+#define MT7986_CON_INFRA_VERSION 0x02070000
+
 /* INFRACFG */
 #define MT_INFRACFG_CONN2AP_SLPPROT	0x0d0
 #define MT_INFRACFG_AP2CONN_SLPPROT	0x0d4
@@ -167,10 +170,14 @@ static u32 mt76_wmac_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 	return val;
 }
 
-static u8 mt7986_wmac_check_adie_type(struct mt7915_dev *dev)
+static u8 mt798x_wmac_check_adie_type(struct mt7915_dev *dev)
 {
 	u32 val;
 
+	/* Only DBDC A-die is used with MT7981 */
+	if (is_mt7981(&dev->mt76))
+		return ADIE_DBDC;
+
 	val = readl(dev->sku + MT_TOP_POS_SKU);
 
 	return FIELD_GET(MT_TOP_POS_SKU_ADIE_DBDC_MASK, val);
@@ -195,7 +202,7 @@ static int mt7986_wmac_gpio_setup(struct mt7915_dev *dev)
 	int ret;
 	u8 type;
 
-	type = mt7986_wmac_check_adie_type(dev);
+	type = mt798x_wmac_check_adie_type(dev);
 	pinctrl = devm_pinctrl_get(dev->mt76.dev);
 	if (IS_ERR(pinctrl))
 		return PTR_ERR(pinctrl);
@@ -257,16 +264,26 @@ static int mt7986_wmac_consys_lockup(struct mt7915_dev *dev, bool enable)
 	return 0;
 }
 
-static int mt7986_wmac_coninfra_check(struct mt7915_dev *dev)
+static int mt798x_wmac_coninfra_check(struct mt7915_dev *dev)
 {
 	u32 cur;
+	u32 con_infra_version;
+
+	if (is_mt7981(&dev->mt76)) {
+		con_infra_version = MT7981_CON_INFRA_VERSION;
+	} else if (is_mt7986(&dev->mt76)) {
+		con_infra_version = MT7986_CON_INFRA_VERSION;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
 
-	return read_poll_timeout(mt76_rr, cur, (cur == 0x02070000),
+	return read_poll_timeout(mt76_rr, cur, (cur == con_infra_version),
 				 USEC_PER_MSEC, 50 * USEC_PER_MSEC,
 				 false, dev, MT_CONN_INFRA_BASE);
 }
 
-static int mt7986_wmac_coninfra_setup(struct mt7915_dev *dev)
+static int mt798x_wmac_coninfra_setup(struct mt7915_dev *dev)
 {
 	struct device *pdev = dev->mt76.dev;
 	struct reserved_mem *rmem;
@@ -284,15 +301,25 @@ static int mt7986_wmac_coninfra_setup(struct mt7915_dev *dev)
 
 	val = (rmem->base >> 16) & MT_TOP_MCU_EMI_BASE_MASK;
 
-	/* Set conninfra subsys PLL check */
-	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
-		       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
-	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
-		       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
+	if (is_mt7986(&dev->mt76)) {
+		/* Set conninfra subsys PLL check */
+		mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
+			       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
+		mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
+			       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
+	}
 
 	mt76_rmw_field(dev, MT_TOP_MCU_EMI_BASE,
 		       MT_TOP_MCU_EMI_BASE_MASK, val);
 
+	if (is_mt7981(&dev->mt76)) {
+		mt76_rmw_field(dev, MT_TOP_WF_AP_PERI_BASE,
+			       MT_TOP_WF_AP_PERI_BASE_MASK, 0x300d0000 >> 16);
+
+		mt76_rmw_field(dev, MT_TOP_EFUSE_BASE,
+			       MT_TOP_EFUSE_BASE_MASK, 0x11f20000 >> 16);
+	}
+
 	mt76_wr(dev, MT_INFRA_BUS_EMI_START, rmem->base);
 	mt76_wr(dev, MT_INFRA_BUS_EMI_END, rmem->size);
 
@@ -305,15 +332,18 @@ static int mt7986_wmac_coninfra_setup(struct mt7915_dev *dev)
 	return 0;
 }
 
-static int mt7986_wmac_sku_setup(struct mt7915_dev *dev, u32 *adie_type)
+static int mt798x_wmac_sku_setup(struct mt7915_dev *dev, u32 *adie_type)
 {
 	int ret;
-	u32 adie_main, adie_ext;
+	u32 adie_main = 0, adie_ext = 0;
 
 	mt76_rmw_field(dev, MT_CONN_INFRA_ADIE_RESET,
 		       MT_CONN_INFRA_ADIE1_RESET_MASK, 0x1);
-	mt76_rmw_field(dev, MT_CONN_INFRA_ADIE_RESET,
-		       MT_CONN_INFRA_ADIE2_RESET_MASK, 0x1);
+
+	if (is_mt7986(&dev->mt76)) {
+		mt76_rmw_field(dev, MT_CONN_INFRA_ADIE_RESET,
+			       MT_CONN_INFRA_ADIE2_RESET_MASK, 0x1);
+	}
 
 	mt76_wmac_spi_lock(dev);
 
@@ -321,9 +351,11 @@ static int mt7986_wmac_sku_setup(struct mt7915_dev *dev, u32 *adie_type)
 	if (ret)
 		goto out;
 
-	ret = mt76_wmac_spi_read(dev, 1, MT_ADIE_CHIP_ID, &adie_ext);
-	if (ret)
-		goto out;
+	if (is_mt7986(&dev->mt76)) {
+		ret = mt76_wmac_spi_read(dev, 1, MT_ADIE_CHIP_ID, &adie_ext);
+		if (ret)
+			goto out;
+	}
 
 	*adie_type = FIELD_GET(MT_ADIE_CHIP_ID_MASK, adie_main) |
 		     (MT_ADIE_CHIP_ID_MASK & adie_ext);
@@ -470,7 +502,7 @@ static int mt7986_wmac_adie_xtal_trim_7976(struct mt7915_dev *dev, u8 adie)
 	return ret;
 }
 
-static int mt7986_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
+static int mt798x_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
 {
 	u32 id, version, rg_xo_01, rg_xo_03;
 	int ret;
@@ -489,7 +521,14 @@ static int mt7986_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
 		rg_xo_01 = 0x1d59080f;
 		rg_xo_03 = 0x34c00fe0;
 	} else {
-		rg_xo_01 = 0x1959f80f;
+		if (is_mt7981(&dev->mt76)) {
+			rg_xo_01 = 0x1959c80f;
+		} else if (is_mt7986(&dev->mt76)) {
+			rg_xo_01 = 0x1959f80f;
+		} else {
+			WARN_ON(1);
+			return -EINVAL;
+		}
 		rg_xo_03 = 0x34d00fe0;
 	}
 
@@ -611,7 +650,15 @@ static int mt7986_wmac_adie_patch_7975(struct mt7915_dev *dev, u8 adie)
 		return ret;
 
 	/* turn on SX0 LTBUF */
-	ret = mt76_wmac_spi_write(dev, adie, 0x074, 0x00000002);
+	if (is_mt7981(&dev->mt76)) {
+		ret = mt76_wmac_spi_write(dev, adie, 0x074, 0x00000007);
+	} else if (is_mt7986(&dev->mt76)) {
+		ret = mt76_wmac_spi_write(dev, adie, 0x074, 0x00000002);
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	if (ret)
 		return ret;
 
@@ -658,7 +705,10 @@ static int mt7986_wmac_adie_patch_7975(struct mt7915_dev *dev, u8 adie)
 		return ret;
 
 	/* set CKB driving and filter */
-	return mt76_wmac_spi_write(dev, adie, 0x2c8, 0x00000072);
+	if (is_mt7986(&dev->mt76))
+		return mt76_wmac_spi_write(dev, adie, 0x2c8, 0x00000072);
+
+	return ret;
 }
 
 static int mt7986_wmac_adie_cfg(struct mt7915_dev *dev, u8 adie, u32 adie_type)
@@ -686,7 +736,7 @@ static int mt7986_wmac_adie_cfg(struct mt7915_dev *dev, u8 adie, u32 adie_type)
 
 		ret = mt7986_wmac_adie_patch_7975(dev, adie);
 	} else if (is_7976(dev, adie, adie_type)) {
-		if (mt7986_wmac_check_adie_type(dev) == ADIE_DBDC) {
+		if (mt798x_wmac_check_adie_type(dev) == ADIE_DBDC) {
 			ret = mt76_wmac_spi_write(dev, adie,
 						  MT_ADIE_WRI_CK_SEL, 0x1c);
 			if (ret)
@@ -701,7 +751,7 @@ static int mt7986_wmac_adie_cfg(struct mt7915_dev *dev, u8 adie, u32 adie_type)
 		if (ret)
 			goto out;
 
-		ret = mt7986_wmac_adie_patch_7976(dev, adie);
+		ret = mt798x_wmac_adie_patch_7976(dev, adie);
 	}
 out:
 	mt76_wmac_spi_unlock(dev);
@@ -714,6 +764,7 @@ mt7986_wmac_afe_cal(struct mt7915_dev *dev, u8 adie, bool dbdc, u32 adie_type)
 {
 	int ret;
 	u8 idx;
+	u32 txcal;
 
 	mt76_wmac_spi_lock(dev);
 	if (is_7975(dev, adie, adie_type))
@@ -744,12 +795,18 @@ mt7986_wmac_afe_cal(struct mt7915_dev *dev, u8 adie, bool dbdc, u32 adie_type)
 		       MT_AFE_RG_WBG_EN_WPLL_UP_MASK, 0x1);
 	usleep_range(60, 100);
 
-	mt76_rmw_field(dev, MT_AFE_DIG_EN_01(idx),
-		       MT_AFE_RG_WBG_EN_TXCAL_MASK, 0x1f);
+	txcal = (MT_AFE_RG_WBG_EN_TXCAL_BT |
+		      MT_AFE_RG_WBG_EN_TXCAL_WF0 |
+		      MT_AFE_RG_WBG_EN_TXCAL_WF1 |
+		      MT_AFE_RG_WBG_EN_TXCAL_WF2 |
+		      MT_AFE_RG_WBG_EN_TXCAL_WF3);
+	if (is_mt7981(&dev->mt76))
+		txcal |= MT_AFE_RG_WBG_EN_TXCAL_WF4;
+
+	mt76_set(dev, MT_AFE_DIG_EN_01(idx), txcal);
 	usleep_range(800, 1000);
 
-	mt76_rmw(dev, MT_AFE_DIG_EN_01(idx),
-		 MT_AFE_RG_WBG_EN_TXCAL_MASK, 0x0);
+	mt76_clear(dev, MT_AFE_DIG_EN_01(idx), txcal);
 	mt76_rmw(dev, MT_AFE_DIG_EN_03(idx),
 		 MT_AFE_RG_WBG_EN_PLL_UP_MASK, 0x0);
 
@@ -806,7 +863,7 @@ static int mt7986_wmac_bus_timeout(struct mt7915_dev *dev)
 	mt76_rmw_field(dev, MT_INFRA_BUS_ON_TIMEOUT,
 		       MT_INFRA_BUS_TIMEOUT_EN_MASK, 0xf);
 
-	return mt7986_wmac_coninfra_check(dev);
+	return mt798x_wmac_coninfra_check(dev);
 }
 
 static void mt7986_wmac_clock_enable(struct mt7915_dev *dev, u32 adie_type)
@@ -876,14 +933,15 @@ static int mt7986_wmac_top_wfsys_wakeup(struct mt7915_dev *dev, bool enable)
 	if (!enable)
 		return 0;
 
-	return mt7986_wmac_coninfra_check(dev);
+	return mt798x_wmac_coninfra_check(dev);
 }
 
 static int mt7986_wmac_wm_enable(struct mt7915_dev *dev, bool enable)
 {
 	u32 cur;
 
-	mt76_wr(dev, MT_CONNINFRA_SKU_DEC_ADDR, 0);
+	if (is_mt7986(&dev->mt76))
+		mt76_wr(dev, MT_CONNINFRA_SKU_DEC_ADDR, 0);
 
 	mt76_rmw_field(dev, MT7986_TOP_WM_RESET,
 		       MT7986_TOP_WM_RESET_MASK, enable);
@@ -1006,7 +1064,7 @@ mt7986_wmac_adie_setup(struct mt7915_dev *dev, u8 adie, u32 adie_type)
 	if (ret)
 		return ret;
 
-	if (!adie && (mt7986_wmac_check_adie_type(dev) == ADIE_DBDC))
+	if (!adie && (mt798x_wmac_check_adie_type(dev) == ADIE_DBDC))
 		ret = mt7986_wmac_afe_cal(dev, adie, true, adie_type);
 
 	return ret;
@@ -1061,15 +1119,15 @@ int mt7986_wmac_enable(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7986_wmac_coninfra_check(dev);
+	ret = mt798x_wmac_coninfra_check(dev);
 	if (ret)
 		return ret;
 
-	ret = mt7986_wmac_coninfra_setup(dev);
+	ret = mt798x_wmac_coninfra_setup(dev);
 	if (ret)
 		return ret;
 
-	ret = mt7986_wmac_sku_setup(dev, &adie_type);
+	ret = mt798x_wmac_sku_setup(dev, &adie_type);
 	if (ret)
 		return ret;
 
@@ -1077,9 +1135,12 @@ int mt7986_wmac_enable(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7986_wmac_adie_setup(dev, 1, adie_type);
-	if (ret)
-		return ret;
+	/* mt7981 doesn't support a second a-die */
+	if (is_mt7986(&dev->mt76)) {
+		ret = mt7986_wmac_adie_setup(dev, 1, adie_type);
+		if (ret)
+			return ret;
+	}
 
 	ret = mt7986_wmac_subsys_powerup(dev, adie_type);
 	if (ret)
@@ -1132,7 +1193,7 @@ void mt7986_wmac_disable(struct mt7915_dev *dev)
 	mt7986_wmac_consys_reset(dev, false);
 }
 
-static int mt7986_wmac_init(struct mt7915_dev *dev)
+static int mt798x_wmac_init(struct mt7915_dev *dev)
 {
 	struct device *pdev = dev->mt76.dev;
 	struct platform_device *pfdev = to_platform_device(pdev);
@@ -1165,7 +1226,7 @@ static int mt7986_wmac_init(struct mt7915_dev *dev)
 	return 0;
 }
 
-static int mt7986_wmac_probe(struct platform_device *pdev)
+static int mt798x_wmac_probe(struct platform_device *pdev)
 {
 	void __iomem *mem_base;
 	struct mt7915_dev *dev;
@@ -1203,7 +1264,7 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_device;
 
-	ret = mt7986_wmac_init(dev);
+	ret = mt798x_wmac_init(dev);
 	if (ret)
 		goto free_irq;
 
@@ -1225,7 +1286,7 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mt7986_wmac_remove(struct platform_device *pdev)
+static int mt798x_wmac_remove(struct platform_device *pdev)
 {
 	struct mt7915_dev *dev = platform_get_drvdata(pdev);
 
@@ -1234,20 +1295,21 @@ static int mt7986_wmac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mt7986_wmac_of_match[] = {
+static const struct of_device_id mt798x_wmac_of_match[] = {
+	{ .compatible = "mediatek,mt7981-wmac", .data = (u32 *)0x7981 },
 	{ .compatible = "mediatek,mt7986-wmac", .data = (u32 *)0x7986 },
 	{},
 };
 
-MODULE_DEVICE_TABLE(of, mt7986_wmac_of_match);
+MODULE_DEVICE_TABLE(of, mt798x_wmac_of_match);
 
-struct platform_driver mt7986_wmac_driver = {
+struct platform_driver mt798x_wmac_driver = {
 	.driver = {
-		.name = "mt7986-wmac",
-		.of_match_table = mt7986_wmac_of_match,
+		.name = "mt798x-wmac",
+		.of_match_table = mt798x_wmac_of_match,
 	},
-	.probe = mt7986_wmac_probe,
-	.remove = mt7986_wmac_remove,
+	.probe = mt798x_wmac_probe,
+	.remove = mt798x_wmac_remove,
 };
 
 MODULE_FIRMWARE(MT7986_FIRMWARE_WA);
@@ -1255,3 +1317,7 @@ MODULE_FIRMWARE(MT7986_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7986_FIRMWARE_WM_MT7975);
 MODULE_FIRMWARE(MT7986_ROM_PATCH);
 MODULE_FIRMWARE(MT7986_ROM_PATCH_MT7975);
+
+MODULE_FIRMWARE(MT7981_FIRMWARE_WA);
+MODULE_FIRMWARE(MT7981_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7981_ROM_PATCH);
-- 
2.40.1

