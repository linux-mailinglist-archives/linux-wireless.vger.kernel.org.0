Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F30434EFA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJTP06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 11:26:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55344 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230445AbhJTP04 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 11:26:56 -0400
X-UUID: 3efb13856c9a40d28aca39332666e4bf-20211020
X-UUID: 3efb13856c9a40d28aca39332666e4bf-20211020
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1545427916; Wed, 20 Oct 2021 23:24:39 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Oct 2021 23:24:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Oct
 2021 23:24:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Oct 2021 23:24:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH] mt76: mt7615: apply cached RF data for DBDC
Date:   Wed, 20 Oct 2021 23:24:35 +0800
Message-ID: <5526d0a2cf959d1700c8ed0128f6eee787ec9332.1634720865.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Band0 and band1 share the same hardware, so band0 will stop Tx/Rx when
band1 performs Rx calibration. cal_cache is introduced to solve such
corner cases by moving necessary datas from channel_switch to bootup.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 22 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2cb3969e6432..25f9cbe2cd61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1698,6 +1698,19 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 				 sizeof(data), true);
 }
 
+static int mt7615_mcu_cal_cache_apply(struct mt7615_dev *dev)
+{
+	struct {
+		bool cache_enable;
+		u8 pad[3];
+	} data = {
+		.cache_enable = true
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_CAL_CACHE, &data,
+				 sizeof(data), false);
+}
+
 static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 {
 	u32 offset = 0, override_addr = 0, flag = FW_START_DLYCAL;
@@ -1906,9 +1919,14 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	mt7615_mcu_fw_log_2_host(dev, 0);
 
-	return 0;
+	if (dev->dbdc_support) {
+		ret = mt7615_mcu_cal_cache_apply(dev);
+		if (ret)
+			return ret;
+	}
+
+	return mt7615_mcu_fw_log_2_host(dev, 0);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_init);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index b89faab04996..4e2c9dafd776 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -531,6 +531,7 @@ enum {
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
 	MCU_EXT_CMD_TXDPD_CAL = 0x60,
+	MCU_EXT_CMD_CAL_CACHE = 0x67,
 	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
-- 
2.29.2

