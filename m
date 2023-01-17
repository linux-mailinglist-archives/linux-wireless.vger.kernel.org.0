Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E772066DA01
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 10:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjAQJdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 04:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjAQJco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 04:32:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680FA5EC
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 01:31:40 -0800 (PST)
X-UUID: bb385a9c964911eda06fc9ecc4dadd91-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8oVfLaW56c/kNrNce8+es3cYvqc2J6QaPeCdRq6UxJs=;
        b=IxMI8gT0e8z7+P6lur2X4AXS4XgtyW6DDsEepLgyj6Gs6SNsPfNA261gIfvLbhLTdzj8mxE2YV/pNAxd1DklsvnILTXq9kfqztmD81bzPLmN4xhJ3Nfz5GQlrsh7GIB23g+xocIrOmtytaE0iuCp0+W1lFxVHJ8YC7f0K21Erck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:9fa54733-21c1-4e7e-8e64-a19266be1d4c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:06d80df6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: bb385a9c964911eda06fc9ecc4dadd91-20230117
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2107484675; Tue, 17 Jan 2023 17:31:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 17 Jan 2023 17:31:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 17 Jan 2023 17:31:32 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Neil Chen <yn.chen@mediatek.com>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent
Date:   Tue, 17 Jan 2023 17:30:59 +0800
Message-ID: <b9ebeda5d445f66fceb17c48c8251093dfe94c57.1673947063.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Neil Chen <yn.chen@mediatek.com>

The rx filter, in mt7921 series, may be changed in fw operation. There is
a racing problem if rx filter controlled by both driver and firmware at
the same time. To avoid this issue, let mt7921 driver set rx filter by new
command MCU_CE_CMD_SET_RX_FILTER and allow the firmware controlling it
only.

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Neil Chen <yn.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 48 ++-----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 36 +++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
 .../wireless/mediatek/mt76/mt7921/testmode.c  |  1 -
 6 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1e942b9a887..1baea5d5bdb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1238,6 +1238,7 @@ enum {
 	MCU_CE_CMD_TEST_CTRL = 0x01,
 	MCU_CE_CMD_START_HW_SCAN = 0x03,
 	MCU_CE_CMD_SET_PS_PROFILE = 0x05,
+	MCU_CE_CMD_SET_RX_FILTER = 0x0a,
 	MCU_CE_CMD_SET_CHAN_DOMAIN = 0x0f,
 	MCU_CE_CMD_SET_BSS_CONNECTED = 0x16,
 	MCU_CE_CMD_SET_BSS_ABORT = 0x17,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d4b681d7e1d2..4b935867c2b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -229,8 +229,6 @@ int mt7921_mac_init(struct mt7921_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt7921_mac_init_band(dev, i);
 
-	dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
-
 	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 76ac5069638f..df7bd84b28d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -681,7 +681,6 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_iterate_active_interfaces(hw,
 						    IEEE80211_IFACE_ITER_RESUME_ALL,
 						    mt7921_sniffer_interface_iter, dev);
-		dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
 	}
 
 out:
@@ -710,53 +709,12 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 				    u64 multicast)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
-			MT_WF_RFCR1_DROP_BF_POLL |
-			MT_WF_RFCR1_DROP_BA |
-			MT_WF_RFCR1_DROP_CFEND |
-			MT_WF_RFCR1_DROP_CFACK;
-	u32 flags = 0;
-
-#define MT76_FILTER(_flag, _hw) do {					\
-		flags |= *total_flags & FIF_##_flag;			\
-		dev->mt76.rxfilter &= ~(_hw);				\
-		dev->mt76.rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
-	} while (0)
 
 	mt7921_mutex_acquire(dev);
-
-	dev->mt76.rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-				MT_WF_RFCR_DROP_OTHER_BEACON |
-				MT_WF_RFCR_DROP_FRAME_REPORT |
-				MT_WF_RFCR_DROP_PROBEREQ |
-				MT_WF_RFCR_DROP_MCAST_FILTERED |
-				MT_WF_RFCR_DROP_MCAST |
-				MT_WF_RFCR_DROP_BCAST |
-				MT_WF_RFCR_DROP_DUPLICATE |
-				MT_WF_RFCR_DROP_A2_BSSID |
-				MT_WF_RFCR_DROP_UNWANTED_CTL |
-				MT_WF_RFCR_DROP_STBC_MULTI);
-
-	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
-			       MT_WF_RFCR_DROP_A3_MAC |
-			       MT_WF_RFCR_DROP_A3_BSSID);
-
-	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
-
-	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
-			     MT_WF_RFCR_DROP_RTS |
-			     MT_WF_RFCR_DROP_CTL_RSV |
-			     MT_WF_RFCR_DROP_NDPA);
-
-	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
-
-	if (*total_flags & FIF_CONTROL)
-		mt76_clear(dev, MT_WF_RFCR1(0), ctl_flags);
-	else
-		mt76_set(dev, MT_WF_RFCR1(0), ctl_flags);
-
+	mt7921_mcu_set_rxfilter(dev, *total_flags, 0, 0);
 	mt7921_mutex_release(dev);
+
+	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
 }
 
 static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8930b5a4467c..8aeb030fb763 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1019,6 +1019,8 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable)
 {
+#define MT7921_FIF_BIT_CLR		BIT(1)
+#define MT7921_FIF_BIT_SET		BIT(0)
 	int err;
 
 	if (enable) {
@@ -1026,7 +1028,11 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 		if (err)
 			return err;
 
-		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+		err = mt7921_mcu_set_rxfilter(dev, 0,
+					      MT7921_FIF_BIT_SET,
+					      MT_WF_RFCR_DROP_OTHER_BEACON);
+		if (err)
+			return err;
 
 		return 0;
 	}
@@ -1035,7 +1041,11 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 	if (err)
 		return err;
 
-	mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+	err = mt7921_mcu_set_rxfilter(dev, 0,
+				      MT7921_FIF_BIT_CLR,
+				      MT_WF_RFCR_DROP_OTHER_BEACON);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -1255,3 +1265,25 @@ int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 	}
 	return 0;
 }
+
+int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map)
+{
+	struct {
+		u8 rsv[4];
+		u8 mode;
+		u8 rsv2[3];
+		__le32 fif;
+		__le32 bit_map; /* bit_* for bitmap update */
+		u8 bit_op;
+		u8 pad[51];
+	} __packed data = {
+		.mode = fif ? 1 : 2,
+		.fif = cpu_to_le32(fif),
+		.bit_map = cpu_to_le32(bit_map),
+		.bit_op = bit_op,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_RX_FILTER),
+				 &data, sizeof(data), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index efff4d43d796..248a4bc30955 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -383,6 +383,8 @@ int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
+int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map);
 
 static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index bdec8684ce94..7f408212e716 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -59,7 +59,6 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
 		cancel_work_sync(&pm->wake_work);
 		__mt7921_mcu_drv_pmctrl(dev);
 
-		mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
 		phy->test.state = MT76_TM_STATE_ON;
 	}
 
-- 
2.18.0

