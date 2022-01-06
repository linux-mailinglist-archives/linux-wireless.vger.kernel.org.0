Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE065486AAD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiAFTuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 14:50:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42796 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243486AbiAFTuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 14:50:18 -0500
X-UUID: b3967e4467ce492c89f51241ae778c76-20220107
X-UUID: b3967e4467ce492c89f51241ae778c76-20220107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1222017295; Fri, 07 Jan 2022 03:50:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 7 Jan 2022 03:50:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 03:50:11 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Leon Yen" <leon.yen@mediatek.com>
Subject: [PATCH] mt76: mt7921s: fix mt7921s_mcu_[fw|drv]_pmctrl
Date:   Fri, 7 Jan 2022 03:50:10 +0800
Message-ID: <5d5622916a35bf3efedcd553b925e14f1d5bf46f.1641498203.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Leon Yen <leon.yen@mediatek.com>

According to the firmware behavior (even the oldest one in linux-firmware)
If the firmware is downloaded, MT7921S must rely on the additional mailbox
mechanism that resides in firmware to check if the device is the right
state for mt7921s_mcu_[fw|drv]_pmctrl. Otherwise, we still apply the old
way for that.

That is a necessary patch before we enable runtime pm for mt7921s as
default.

Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 38 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/sdio.h     |  2 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index d20f2ff01be1..5d8af18c7026 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -49,6 +49,26 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
+static u32 mt7921s_read_rm3r(struct mt7921_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	return sdio_readl(sdio->func, MCR_D2HRM3R, NULL);
+}
+
+static u32 mt7921s_clear_rm3r_drv_own(struct mt7921_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 val;
+
+	val = sdio_readl(sdio->func, MCR_D2HRM3R, NULL);
+	if (val)
+		sdio_writel(sdio->func, H2D_SW_INT_CLEAR_MAILBOX_ACK,
+			    MCR_WSICR, NULL);
+
+	return val;
+}
+
 int mt7921s_mcu_init(struct mt7921_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921s_mcu_ops = {
@@ -88,6 +108,12 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
 
 	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+
+	if (!err && test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+		err = readx_poll_timeout(mt7921s_read_rm3r, dev, status,
+					 status & D2HRM3R_IS_DRIVER_OWN,
+					 2000, 1000000);
+
 	sdio_release_host(func);
 
 	if (err < 0) {
@@ -115,12 +141,24 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
 
 	sdio_claim_host(func);
 
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+		err = readx_poll_timeout(mt7921s_clear_rm3r_drv_own,
+					 dev, status,
+					 !(status & D2HRM3R_IS_DRIVER_OWN),
+					 2000, 1000000);
+		if (err < 0) {
+			dev_err(dev->mt76.dev, "mailbox ACK not cleared\n");
+			goto err;
+		}
+	}
+
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
 
 	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
 				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
 	sdio_release_host(func);
 
+err:
 	if (err < 0) {
 		dev_err(dev->mt76.dev, "firmware own failed\n");
 		clear_bit(MT76_STATE_PM, &mphy->state);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
index 99db4ad93b7c..27d5d2077eba 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.h
+++ b/drivers/net/wireless/mediatek/mt76/sdio.h
@@ -65,6 +65,7 @@
 #define MCR_H2DSM0R			0x0070
 #define H2D_SW_INT_READ			BIT(16)
 #define H2D_SW_INT_WRITE		BIT(17)
+#define H2D_SW_INT_CLEAR_MAILBOX_ACK	BIT(22)
 
 #define MCR_H2DSM1R			0x0074
 #define MCR_D2HRM0R			0x0078
@@ -109,6 +110,7 @@
 #define MCR_H2DSM2R			0x0160 /* supported in CONNAC2 */
 #define MCR_H2DSM3R			0x0164 /* supported in CONNAC2 */
 #define MCR_D2HRM3R			0x0174 /* supported in CONNAC2 */
+#define D2HRM3R_IS_DRIVER_OWN		BIT(0)
 #define MCR_WTQCR8			0x0190 /* supported in CONNAC2 */
 #define MCR_WTQCR9			0x0194 /* supported in CONNAC2 */
 #define MCR_WTQCR10			0x0198 /* supported in CONNAC2 */
-- 
2.25.1

