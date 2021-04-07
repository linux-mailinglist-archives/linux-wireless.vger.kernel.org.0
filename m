Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6173566AD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhDGIWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349609AbhDGIWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 04:22:21 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C1C06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3iZqnmhhVB6NOEdyV6L9KvxTHP26otPAIw/yUaKytLU=; b=ftLxOJGjmTmFITdqeuxlK2luSY
        KqcQ82oCtrJDZIyXnfq3PfIeuAki0Qcl4iMFpCqB83sczBojm9BBycIfTnSfwdGlR9R8dphtDTReA
        E42KnngTVvOP+JEI5DdG7GxfyNF3zIEJInKK0G+HCAIC5Sn4vZJRHrk9EgTTTKvpJbzE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lU3Rx-0002sw-VZ; Wed, 07 Apr 2021 10:22:10 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: add wifi subsystem reset
Date:   Wed,  7 Apr 2021 10:22:06 +0200
Message-Id: <20210407082206.59939-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Reset wifi subsystem when MCU is already running.
Fixes firmware download failure after soft reboot on systems where the PCIe
reset could not be performed properly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 58 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 15 +----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 13 +++++
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 2ffadd22c259..261f5ab23721 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include "mt7915.h"
 #include "mac.h"
+#include "mcu.h"
 #include "eeprom.h"
 
 #define CCK_RATE(_idx, _rate) {						\
@@ -295,9 +296,50 @@ static void mt7915_init_work(struct work_struct *work)
 	mt7915_txbf_init(dev);
 }
 
+static void mt7915_wfsys_reset(struct mt7915_dev *dev)
+{
+	u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON | MT_TOP_PWR_PWR_ON;
+	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
+
+#define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
+#define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
+
+	mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_RANDOM);
+
+	/* change to software control */
+	val |= MT_TOP_PWR_SW_RST;
+	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+	/* reset wfsys */
+	val &= ~MT_TOP_PWR_SW_RST;
+	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+	/* release wfsys then mcu re-excutes romcode */
+	val |= MT_TOP_PWR_SW_RST;
+	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+	/* switch to hw control */
+	val &= ~MT_TOP_PWR_SW_RST;
+	val |= MT_TOP_PWR_HW_CTRL;
+	mt76_wr(dev, MT_TOP_PWR_CTRL, val);
+
+	/* check whether mcu resets to default */
+	if (!mt76_poll_msec(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_DEFAULT,
+			    MT_MCU_DUMMY_DEFAULT, 1000)) {
+		dev_err(dev->mt76.dev, "wifi subsystem reset failure\n");
+		return;
+	}
+
+	/* wfsys reset won't clear host registers */
+	mt76_clear(dev, reg, MT_TOP_MISC_FW_STATE);
+
+	msleep(100);
+}
+
 static int mt7915_init_hardware(struct mt7915_dev *dev)
 {
 	int ret, idx;
+	u32 val;
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
@@ -307,6 +349,12 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	dev->dbdc_support = !!(mt7915_l1_rr(dev, MT_HW_BOUND) & BIT(5));
 
+	val = mt76_rr(dev, mt7915_reg_map_l1(dev, MT_TOP_MISC));
+
+	/* If MCU was already running, it is likely in a bad state */
+	if (FIELD_GET(MT_TOP_MISC_FW_STATE, val) > FW_STATE_FW_DOWNLOAD)
+		mt7915_wfsys_reset(dev);
+
 	ret = mt7915_dma_init(dev);
 	if (ret)
 		return ret;
@@ -320,8 +368,14 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
 
 	ret = mt7915_mcu_init(dev);
-	if (ret)
-		return ret;
+	if (ret) {
+		/* Reset and try again */
+		mt7915_wfsys_reset(dev);
+
+		ret = mt7915_mcu_init(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = mt7915_eeprom_init(dev);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3507fd135dfe..639f65d63add 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2784,21 +2784,8 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 
 static int mt7915_load_firmware(struct mt7915_dev *dev)
 {
+	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
 	int ret;
-	u32 val, reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
-
-	val = FIELD_PREP(MT_TOP_MISC_FW_STATE, FW_STATE_FW_DOWNLOAD);
-
-	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE, val, 1000)) {
-		/* restart firmware once */
-		__mt76_mcu_restart(&dev->mt76);
-		if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
-				    val, 1000)) {
-			dev_err(dev->mt76.dev,
-				"Firmware is not ready for download\n");
-			return -EIO;
-		}
-	}
 
 	ret = mt7915_load_patch(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index ed0c9a24bb53..dfb8880657bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -4,6 +4,11 @@
 #ifndef __MT7915_REGS_H
 #define __MT7915_REGS_H
 
+/* MCU WFDMA0 */
+#define MT_MCU_WFDMA0_BASE		0x2000
+#define MT_MCU_WFDMA0(ofs)		(MT_MCU_WFDMA0_BASE + (ofs))
+#define MT_MCU_WFDMA0_DUMMY_CR		MT_MCU_WFDMA0(0x120)
+
 /* MCU WFDMA1 */
 #define MT_MCU_WFDMA1_BASE		0x3000
 #define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
@@ -396,6 +401,14 @@
 #define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
 
+#define MT_TOP_RGU_BASE				0xf0000
+#define MT_TOP_PWR_CTRL				(MT_TOP_RGU_BASE + (0x0))
+#define MT_TOP_PWR_KEY				(0x5746 << 16)
+#define MT_TOP_PWR_SW_RST			BIT(0)
+#define MT_TOP_PWR_SW_PWR_ON			GENMASK(3, 2)
+#define MT_TOP_PWR_HW_CTRL			BIT(4)
+#define MT_TOP_PWR_PWR_ON			BIT(7)
+
 #define MT_INFRA_CFG_BASE		0xf1000
 #define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
 
-- 
2.30.1

