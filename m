Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE643C62B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbhJ0JMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59048 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241182AbhJ0JMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:13 -0400
X-UUID: 4d5a2025003840d9880c100b07f41616-20211027
X-UUID: 4d5a2025003840d9880c100b07f41616-20211027
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1142020366; Wed, 27 Oct 2021 17:09:43 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:34 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:34 +0800
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
Subject: [PATCH 04/11] mt76: mt7915: add firmware support for mt7916
Date:   Wed, 27 Oct 2021 16:40:12 +0800
Message-ID: <ecb8996b0a3f1b42a2fc7a008fb23f13095645fe.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
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
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 --
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 78 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  5 +-
 5 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f455c12..a4e2d85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -567,12 +567,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
-	/*
-	 * force firmware operation mode into normal state,
-	 * which should be set before firmware download stage.
-	 */
-	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-
 	ret = mt7915_mcu_init(dev);
 	if (ret) {
 		/* Reset and try again */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ee9952d..b60b4b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2713,16 +2713,20 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
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
 
+	/* clear irq when the driver own seccess */
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND_IRQ_STAT(band),
+		MT_TOP_LPCR_HOST_BAND_STAT);
+
 	return 0;
 }
 
@@ -2752,6 +2756,7 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 {
 	const struct mt7915_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
+	const char *patch;
 	int i, ret, sem;
 
 	sem = mt7915_mcu_patch_sem_ctrl(dev, 1);
@@ -2765,7 +2770,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, MT7915_ROM_PATCH, dev->mt76.dev);
+	patch = is_mt7915(&dev->mt76) ? MT7915_ROM_PATCH : MT7916_ROM_PATCH;
+	ret = request_firmware(&fw, patch, dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -2896,9 +2902,11 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
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
 
@@ -2922,7 +2930,8 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 
 	release_firmware(fw);
 
-	ret = request_firmware(&fw, MT7915_FIRMWARE_WA, dev->mt76.dev);
+	mcu = is_mt7915(&dev->mt76) ? MT7915_FIRMWARE_WA : MT7916_FIRMWARE_WA;
+	ret = request_firmware(&fw, mcu, dev->mt76.dev);
 	if (ret)
 		return ret;
 
@@ -2954,10 +2963,36 @@ out:
 	return ret;
 }
 
+static int
+mt7915_firmware_state(struct mt7915_dev *dev, bool wa)
+{
+	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE,
+			       wa ? FW_STATE_WACPU_RDY : FW_STATE_FW_DOWNLOAD);
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
@@ -2966,12 +3001,9 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
-			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
-				       FW_STATE_WACPU_RDY), 1000)) {
-		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
-		return -EIO;
-	}
+	ret = mt7915_firmware_state(dev, true);
+	if (ret)
+		return ret;
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 
@@ -3096,9 +3128,20 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7915_mcu_ops;
 
-	ret = mt7915_driver_own(dev);
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
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
@@ -3133,14 +3176,15 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
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
index 8adb069..cee719f 100644
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
index 2aba79a..3134b46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -168,3 +168,6 @@ MODULE_DEVICE_TABLE(pci, mt7915_hif_device_table);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7915_ROM_PATCH);
+MODULE_FIRMWARE(MT7916_FIRMWARE_WA);
+MODULE_FIRMWARE(MT7916_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7916_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 4745e3f..caad6bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -787,11 +787,14 @@ enum bit_rev {
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
 
-- 
2.18.0

