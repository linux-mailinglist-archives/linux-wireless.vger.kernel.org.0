Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16D47A38A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhLTCSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 21:18:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46150 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237140AbhLTCSS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 21:18:18 -0500
X-UUID: e02d32b30e3e4967bf52cd26f55b835c-20211220
X-UUID: e02d32b30e3e4967bf52cd26f55b835c-20211220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 930522154; Mon, 20 Dec 2021 10:18:15 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Dec 2021 10:18:14 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Dec
 2021 10:18:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Dec 2021 10:18:12 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v4 05/12] mt76: mt7915: add firmware support for mt7916
Date:   Mon, 20 Dec 2021 10:17:57 +0800
Message-ID: <6b2d86cbbe6426a5ed0d91b8248b95ac3390885f.1639965732.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1639965732.git.Bo.Jiao@mediatek.com>
References: <cover.1639965732.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Update firmware initialization for mt7916.
This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
v3:
- modify the function mt7915_wfsys_reset to support mt7916
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 75 ++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  6 +-
 5 files changed, 115 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 2da342d..edf0d7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -511,41 +511,53 @@ static void mt7915_init_work(struct work_struct *work)
 
 static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 {
-	u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON | MT_TOP_PWR_PWR_ON;
+	u32 val;
 
 #define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
 #define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
+	if (is_mt7915(&dev->mt76)) {
+		mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_RANDOM);
+
+		/* change to software control */
+		val |= MT_TOP_PWR_SW_RST;
+		mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+		/* reset wfsys */
+		val &= ~MT_TOP_PWR_SW_RST;
+		mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+		/* release wfsys then mcu re-excutes romcode */
+		val |= MT_TOP_PWR_SW_RST;
+		mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+		/* switch to hw control */
+		val &= ~MT_TOP_PWR_SW_RST;
+		val |= MT_TOP_PWR_HW_CTRL;
+		mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+		/* check whether mcu resets to default */
+		if (!mt76_poll_msec(dev, MT_MCU_WFDMA0_DUMMY_CR,
+				    MT_MCU_DUMMY_DEFAULT, MT_MCU_DUMMY_DEFAULT,
+				    1000)) {
+			dev_err(dev->mt76.dev, "wifi subsystem reset failure\n");
+			return;
+		}
 
-	mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_RANDOM);
-
-	/* change to software control */
-	val |= MT_TOP_PWR_SW_RST;
-	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
-
-	/* reset wfsys */
-	val &= ~MT_TOP_PWR_SW_RST;
-	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+		/* wfsys reset won't clear host registers */
+		mt76_clear(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE);
 
-	/* release wfsys then mcu re-excutes romcode */
-	val |= MT_TOP_PWR_SW_RST;
-	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+		msleep(100);
+	} else {
+		val = mt76_rr(dev, MT_WF_SUBSYS_RST);
 
-	/* switch to hw control */
-	val &= ~MT_TOP_PWR_SW_RST;
-	val |= MT_TOP_PWR_HW_CTRL;
-	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+		val |= 0x1;
+		mt76_wr(dev, MT_WF_SUBSYS_RST, val);
+		msleep(20);
 
-	/* check whether mcu resets to default */
-	if (!mt76_poll_msec(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_DEFAULT,
-			    MT_MCU_DUMMY_DEFAULT, 1000)) {
-		dev_err(dev->mt76.dev, "wifi subsystem reset failure\n");
-		return;
+		val &= ~0x1;
+		mt76_wr(dev, MT_WF_SUBSYS_RST, val);
+		msleep(20);
 	}
-
-	/* wfsys reset won't clear host registers */
-	mt76_clear(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE);
-
-	msleep(100);
 }
 
 static int mt7915_init_hardware(struct mt7915_dev *dev)
@@ -568,15 +580,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
-	/*
-	 * force firmware operation mode into normal state,
-	 * which should be set before firmware download stage.
-	 */
-	if (is_mt7915(&dev->mt76))
-		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-	else
-		mt76_wr(dev, MT_SWDEF_MODE_MT7916, MT_SWDEF_NORMAL_MODE);
-
 	ret = mt7915_mcu_init(dev);
 	if (ret) {
 		/* Reset and try again */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d068266..6ea213b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2693,16 +2693,20 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
 				 sizeof(req), true);
 }
 
-static int mt7915_driver_own(struct mt7915_dev *dev)
+static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
 {
-	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_DRV_OWN);
-	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND0,
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(band), MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND(band),
 			    MT_TOP_LPCR_HOST_FW_OWN_STAT,
 			    0, 500)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
 
+	/* clear irq when the driver own success */
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND_IRQ_STAT(band),
+		MT_TOP_LPCR_HOST_BAND_STAT);
+
 	return 0;
 }
 
@@ -2732,6 +2736,7 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 {
 	const struct mt7915_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
+	const char *patch;
 	int i, ret, sem;
 
 	sem = mt7915_mcu_patch_sem_ctrl(dev, 1);
@@ -2745,7 +2750,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, MT7915_ROM_PATCH, dev->mt76.dev);
+	patch = is_mt7915(&dev->mt76) ? MT7915_ROM_PATCH : MT7916_ROM_PATCH;
+	ret = request_firmware(&fw, patch, dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -2876,9 +2882,11 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 {
 	const struct mt7915_fw_trailer *hdr;
 	const struct firmware *fw;
+	const char *mcu;
 	int ret;
 
-	ret = request_firmware(&fw, MT7915_FIRMWARE_WM, dev->mt76.dev);
+	mcu = is_mt7915(&dev->mt76) ? MT7915_FIRMWARE_WM : MT7916_FIRMWARE_WM;
+	ret = request_firmware(&fw, mcu, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -2902,7 +2910,8 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 
 	release_firmware(fw);
 
-	ret = request_firmware(&fw, MT7915_FIRMWARE_WA, dev->mt76.dev);
+	mcu = is_mt7915(&dev->mt76) ? MT7915_FIRMWARE_WA : MT7916_FIRMWARE_WA;
+	ret = request_firmware(&fw, mcu, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -2934,10 +2943,36 @@ out:
 	return ret;
 }
 
+static int
+mt7915_firmware_state(struct mt7915_dev *dev, bool wa)
+{
+	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE,
+			       wa ? FW_STATE_RDY : FW_STATE_FW_DOWNLOAD);
+
+	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
+			    state, 1000)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+		return -EIO;
+	}
+	return 0;
+}
+
 static int mt7915_load_firmware(struct mt7915_dev *dev)
 {
 	int ret;
 
+	/* make sure fw is download state */
+	if (mt7915_firmware_state(dev, false)) {
+		/* restart firmware once */
+		__mt76_mcu_restart(&dev->mt76);
+		ret = mt7915_firmware_state(dev, false);
+		if (ret) {
+			dev_err(dev->mt76.dev,
+				"Firmware is not ready for download\n");
+			return ret;
+		}
+	}
+
 	ret = mt7915_load_patch(dev);
 	if (ret)
 		return ret;
@@ -2946,12 +2981,9 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
-			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
-				       FW_STATE_RDY), 1000)) {
-		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
-		return -EIO;
-	}
+	ret = mt7915_firmware_state(dev, true);
+	if (ret)
+		return ret;
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 
@@ -3117,9 +3149,23 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7915_mcu_ops;
 
-	ret = mt7915_driver_own(dev);
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	if (is_mt7915(&dev->mt76))
+		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	else
+		mt76_wr(dev, MT_SWDEF_MODE_MT7916, MT_SWDEF_NORMAL_MODE);
+
+	ret = mt7915_driver_own(dev, 0);
 	if (ret)
 		return ret;
+	/* set driver own for band1 when two hif exist */
+	if (dev->hif2) {
+		ret = mt7915_driver_own(dev, 1);
+		if (ret)
+			return ret;
+	}
 
 	ret = mt7915_load_firmware(dev);
 	if (ret)
@@ -3154,14 +3200,15 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 void mt7915_mcu_exit(struct mt7915_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
-	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
-			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
-				       FW_STATE_FW_DOWNLOAD), 1000)) {
+	if (mt7915_firmware_state(dev, false)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		return;
 	}
 
-	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_FW_OWN);
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(0), MT_TOP_LPCR_HOST_FW_OWN);
+	if (dev->hif2)
+		mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(1),
+			MT_TOP_LPCR_HOST_FW_OWN);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 673c2d7..d4449e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -30,6 +30,10 @@
 #define MT7915_FIRMWARE_WM		"mediatek/mt7915_wm.bin"
 #define MT7915_ROM_PATCH		"mediatek/mt7915_rom_patch.bin"
 
+#define MT7916_FIRMWARE_WA		"mediatek/mt7916_wa.bin"
+#define MT7916_FIRMWARE_WM		"mediatek/mt7916_wm.bin"
+#define MT7916_ROM_PATCH		"mediatek/mt7916_rom_patch.bin"
+
 #define MT7915_EEPROM_DEFAULT		"mediatek/mt7915_eeprom.bin"
 #define MT7915_EEPROM_DEFAULT_DBDC	"mediatek/mt7915_eeprom_dbdc.bin"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index e4854a4..5d6adcd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -167,3 +167,6 @@ MODULE_DEVICE_TABLE(pci, mt7915_hif_device_table);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7915_ROM_PATCH);
+MODULE_FIRMWARE(MT7916_FIRMWARE_WA);
+MODULE_FIRMWARE(MT7916_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7916_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index a8e864a..1168a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -729,17 +729,21 @@ enum offs_rev {
 #define MT_TOP_BASE			0x18060000
 #define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
 
-#define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
+#define MT_TOP_LPCR_HOST_BAND(_band)	MT_TOP(0x10 + ((_band) * 0x10))
 #define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
 #define MT_TOP_LPCR_HOST_FW_OWN_STAT	BIT(2)
 
+#define MT_TOP_LPCR_HOST_BAND_IRQ_STAT(_band)	MT_TOP(0x14 + ((_band) * 0x10))
+#define MT_TOP_LPCR_HOST_BAND_STAT	BIT(0)
+
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
+#define MT_WF_SUBSYS_RST		0x70002600
 
 /* PCIE MAC */
 #define MT_PCIE_MAC_BASE		0x74030000
-- 
2.18.0

