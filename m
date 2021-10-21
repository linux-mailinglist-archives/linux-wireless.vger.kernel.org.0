Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E342043692D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJURl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 13:41:27 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:48526 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229968AbhJURl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 13:41:26 -0400
X-UUID: 6dfaf082c7e74f7f85cd01970ce83578-20211022
X-UUID: 6dfaf082c7e74f7f85cd01970ce83578-20211022
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742407728; Fri, 22 Oct 2021 01:39:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 01:39:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Oct 2021 01:39:05 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v5 1/2] mt76: mt7915: add WA firmware log support
Date:   Fri, 22 Oct 2021 01:38:39 +0800
Message-ID: <20211021173840.6203-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support to turn on/off WA firmware log from debugfs.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v3: rebase to staging tree
v4: rebase to staging tree
v5: check return value of mcu cmd
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 50 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 12 ++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  5 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +-
 4 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 4b7f38f..e720958 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -82,7 +82,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
 			 mt7915_radar_trigger, "%lld\n");
 
 static int
-mt7915_fw_debug_set(void *data, u64 val)
+mt7915_fw_debug_wm_set(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
 	enum {
@@ -92,29 +92,58 @@ mt7915_fw_debug_set(void *data, u64 val)
 		DEBUG_SPL,
 		DEBUG_RPT_RX,
 	} debug;
+	int ret;
 
-	dev->fw_debug = !!val;
+	dev->fw_debug_wm = val ? MCU_FW_LOG_TO_HOST : 0;
 
-	mt7915_mcu_fw_log_2_host(dev, dev->fw_debug ? 2 : 0);
+	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, dev->fw_debug_wm);
+	if (ret)
+		return ret;
 
-	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++)
-		mt7915_mcu_fw_dbg_ctrl(dev, debug, dev->fw_debug);
+	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++) {
+		ret = mt7915_mcu_fw_dbg_ctrl(dev, debug, !!dev->fw_debug_wm);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
 static int
-mt7915_fw_debug_get(void *data, u64 *val)
+mt7915_fw_debug_wm_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->fw_debug_wm;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wm, mt7915_fw_debug_wm_get,
+			 mt7915_fw_debug_wm_set, "%lld\n");
+
+static int
+mt7915_fw_debug_wa_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	dev->fw_debug_wa = val ? MCU_FW_LOG_TO_HOST : 0;
+
+	return mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
+}
+
+static int
+mt7915_fw_debug_wa_get(void *data, u64 *val)
 {
 	struct mt7915_dev *dev = data;
 
-	*val = dev->fw_debug;
+	*val = dev->fw_debug_wa;
 
 	return 0;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7915_fw_debug_get,
-			 mt7915_fw_debug_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
+			 mt7915_fw_debug_wa_set, "%lld\n");
 
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
@@ -460,7 +489,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
 			    &mt7915_xmit_queues_fops);
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
-	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
+	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f98bd8a..70193bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2864,7 +2864,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	return 0;
 }
 
-int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl)
+int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl)
 {
 	struct {
 		u8 ctrl_val;
@@ -2873,6 +2873,10 @@ int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
+	if (type == MCU_FW_LOG_WA)
+		return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(FW_LOG_2_HOST),
+					 &data, sizeof(data), true);
+
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(FW_LOG_2_HOST), &data,
 				 sizeof(data), true);
 }
@@ -2985,7 +2989,11 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		return ret;
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	ret = mt7915_mcu_fw_log_2_host(dev, 0);
+	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, 0);
+	if (ret)
+		return ret;
+
+	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 91bf421..99ff265 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -229,6 +229,11 @@ enum {
 	MCU_S2D_H2CN
 };
 
+enum {
+	MCU_FW_LOG_WM,
+	MCU_FW_LOG_WA,
+	MCU_FW_LOG_TO_HOST,
+};
 
 #define __MCU_CMD_FIELD_ID	GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID	GENMASK(15, 8)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index fff15f6..070950b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -270,8 +270,9 @@ struct mt7915_dev {
 
 	bool dbdc_support;
 	bool flash_mode;
-	bool fw_debug;
 	bool ibf;
+	u8 fw_debug_wm;
+	u8 fw_debug_wa;
 
 	void *cal;
 
@@ -449,7 +450,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
 		       u8 index, u8 rx_sel, u8 val);
-int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl);
+int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
 void mt7915_mcu_exit(struct mt7915_dev *dev);
-- 
2.25.1

