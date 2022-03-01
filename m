Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407024C8047
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Mar 2022 02:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiCABSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 20:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCABSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 20:18:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB5FE8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 17:18:01 -0800 (PST)
X-UUID: 3c6d5f61831548d595f53bb1f766f5c0-20220301
X-UUID: 3c6d5f61831548d595f53bb1f766f5c0-20220301
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1954228514; Tue, 01 Mar 2022 09:17:55 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Mar 2022 09:17:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 09:17:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 09:17:53 +0800
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
Subject: [PATCH v3 1/2] mt76: mt7921: fix up the monitor mode
Date:   Tue, 1 Mar 2022 09:17:51 +0800
Message-ID: <88f1b17ebc83b428a9c9faa15de38c77ffa6d346.1646097204.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Properly set up the monitor mode the firmware can support to fix up
RTS/CTS and beacon frames cannot be captured and forwarded to the host.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Tested-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: 1. add Tested-by tag
    2. make mt76_connac_mcu_set_sniffer mt7921 specific
    3. align the structure declartion
v3: 1. add Tested-by tag with Sven
    2. read back the rxfilter after monitor mode setup
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 24 ++++++++-------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 30 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 384c3eab1c8a..e5857d2cf78c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -993,6 +993,7 @@ enum {
 	MCU_UNI_CMD_SUSPEND = 0x05,
 	MCU_UNI_CMD_OFFLOAD = 0x06,
 	MCU_UNI_CMD_HIF_CTRL = 0x07,
+	MCU_UNI_CMD_SNIFFER = 0x24,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b6e836a4fad7..ce4c38b436ec 100644
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
+	mt7921_mcu_set_sniffer(dev, vif, enabled);
+}
+
 void mt7921_set_runtime_pm(struct mt7921_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->mphy.hw;
@@ -516,16 +526,10 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
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
+		dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
 		mt7921_set_runtime_pm(dev);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 33a836825cca..ab790e5df863 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1133,3 +1133,33 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
 
 	return 0;
 }
+
+int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			   bool enable)
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
+	} req = {
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
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
+				 true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 9edc83f06139..9575d571b425 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -452,4 +452,6 @@ void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
+int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			   bool enable);
 #endif
-- 
2.25.1

