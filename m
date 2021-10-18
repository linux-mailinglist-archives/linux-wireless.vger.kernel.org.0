Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DA4311E7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJRIMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 04:12:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55432 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231163AbhJRIML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 04:12:11 -0400
X-UUID: 91991381fc6b49be93bb226b93319cca-20211018
X-UUID: 91991381fc6b49be93bb226b93319cca-20211018
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 360724008; Mon, 18 Oct 2021 16:09:56 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:09:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Oct
 2021 16:09:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 16:09:54 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 1/4] mt76: mt7915: enable HE UL MU-MIMO
Date:   Mon, 18 Oct 2021 16:09:38 +0800
Message-ID: <20211018080941.11443-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable HE UL MU-MIMO in sta_rec_muru, which works on both ap and station
mode.

For sending trigger frames, one of the conditions fw uses is to check if
mib rx airtime meets the threshold.
There's a main control of mib rx airtime report register in fw, so we
need to enable the register by mcu cmd instead of directly writing it,
otherwise it will still be disabled by fw.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: refine mt7915_mcu_sta_muru_tlv()
v3: split patches and rebase to staging tree
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 46 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  1 -
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ffe744e69482..cedecf2c693d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -386,8 +386,6 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
 	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
 
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
-
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	/* disable rx rate report by default due to hw issues */
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d4c8759bedd8..8ba60b66e4a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1534,6 +1534,7 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			       mvif->cap.he_mu_ebfer ||
 			       mvif->cap.vht_mu_ebfer ||
 			       mvif->cap.vht_mu_ebfee;
+	muru->cfg.mimo_ul_en = true;
 
 	muru->ofdma_dl.punc_pream_rx =
 		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
@@ -2921,6 +2922,47 @@ int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val)
 				 sizeof(req), false);
 }
 
+static int
+mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
+{
+#define RX_AIRTIME_FEATURE_CTRL		1
+#define RX_AIRTIME_BITWISE_CTRL		2
+#define RX_AIRTIME_CLEAR_EN	1
+	struct {
+		__le16 field;
+		__le16 sub_field;
+		__le32 set_status;
+		__le32 get_status;
+		u8 _rsv[12];
+
+		bool airtime_en;
+		bool mibtime_en;
+		bool earlyend_en;
+		u8 _rsv1[9];
+
+		bool airtime_clear;
+		bool mibtime_clear;
+		u8 _rsv2[98];
+	} __packed req = {
+		.field = cpu_to_le16(RX_AIRTIME_BITWISE_CTRL),
+		.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN),
+		.airtime_clear = true,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				sizeof(req), true);
+	if (ret)
+		return ret;
+
+	req.field = cpu_to_le16(RX_AIRTIME_FEATURE_CTRL);
+	req.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN);
+	req.airtime_en = true;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				 sizeof(req), true);
+}
+
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2955,6 +2997,10 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7915_mcu_init_rx_airtime(dev);
+	if (ret)
+		return ret;
+
 	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
 				 MCU_WA_PARAM_RED, 0, 0);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 4043cf547c9e..d66918d914da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -271,6 +271,7 @@ enum {
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
 	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
+	MCU_EXT_CMD_RX_AIRTIME_CTRL = 0x4a,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 6771870a867c..a2e98788f421 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -364,7 +364,6 @@
 
 #define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
-#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
 
 /* WFDMA0 */
 #define MT_WFDMA0_BASE			0xd4000
-- 
2.29.2

