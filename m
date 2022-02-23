Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DBE4C1E88
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiBWWfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 17:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiBWWe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 17:34:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FD1B7B8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 14:34:26 -0800 (PST)
X-UUID: 9dbd636b79f146ebaefdb5e064f17f2a-20220224
X-UUID: 9dbd636b79f146ebaefdb5e064f17f2a-20220224
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 745270586; Thu, 24 Feb 2022 06:34:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Feb 2022 06:34:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Feb 2022 06:34:19 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] mt76: mt7921: fix up the monitor mode
Date:   Thu, 24 Feb 2022 06:34:17 +0800
Message-ID: <7dcfc62d67f1f51e6627cc24000393844aa2b649.1645655280.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Properly set up the monitor mode the firmware can support to fix up
RTS/CTS and beacon frames cannot be captured and forwarded to the host.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 31 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 ++++++++------
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0a646ae51c8d..dded8a7d3efc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2784,5 +2784,36 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
 
+int mt76_connac_mcu_set_sniffer(struct mt76_dev *dev, struct ieee80211_vif *vif,
+				bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct sniffer_enable_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 enable;
+			u8 pad[3];
+		} __packed enable;
+		} req = {
+		.hdr = {
+			.band_idx = mvif->band_idx,
+		},
+		.enable = {
+			.tag = cpu_to_le16(0),
+			.len = cpu_to_le16(sizeof(struct sniffer_enable_tlv)),
+			.enable = enable,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
+				 true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_sniffer);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 384c3eab1c8a..96ab1a55af17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -993,6 +993,7 @@ enum {
 	MCU_UNI_CMD_SUSPEND = 0x05,
 	MCU_UNI_CMD_OFFLOAD = 0x06,
 	MCU_UNI_CMD_HIF_CTRL = 0x07,
+	MCU_UNI_CMD_SNIFFER = 0x24,
 };
 
 enum {
@@ -1653,4 +1654,6 @@ int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 int mt76_connac_mcu_restart(struct mt76_dev *dev);
 int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val);
+int mt76_connac_mcu_set_sniffer(struct mt76_dev *dev, struct ieee80211_vif *vif,
+				bool enable);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b6e836a4fad7..051a573141f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -479,6 +479,16 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
 }
 
+static void
+mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	mt76_connac_mcu_set_sniffer(&dev->mt76, vif, enabled);
+}
+
 void mt7921_set_runtime_pm(struct mt7921_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->mphy.hw;
@@ -516,16 +526,9 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
-
-		if (!enabled)
-			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
-		else
-			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
-
-		mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
-			       enabled);
-		mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
+		ieee80211_iterate_active_interfaces(hw,
+						    IEEE80211_IFACE_ITER_RESUME_ALL,
+						    mt7921_sniffer_interface_iter, dev);
 		mt7921_set_runtime_pm(dev);
 	}
 
-- 
2.25.1

