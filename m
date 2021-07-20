Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4893CF9FD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhGTMUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 08:20:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53686 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231272AbhGTMUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 08:20:46 -0400
X-UUID: 7f4a4e7192674ba9b2b1e1b7f2031bd8-20210720
X-UUID: 7f4a4e7192674ba9b2b1e1b7f2031bd8-20210720
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1830024767; Tue, 20 Jul 2021 21:01:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 21:01:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 21:01:20 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: switch proper tx arbiter mode in testmode
Date:   Tue, 20 Jul 2021 21:00:13 +0800
Message-ID: <20210720130014.23572-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch proper tx arbiter mode during testmode tx to prevent from
entering the flow of normal tx in FW.
Also, testmode SU and MU tx need to use different arbiter mode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 29 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/testmode.h  | 10 +++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index baa27da..02b98e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
+	MCU_EXT_CMD_MURU_CTRL = 0x9f,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
 	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
 	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index b220b33..00dcc46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -165,6 +165,28 @@ mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
 				 sizeof(req), false);
 }
 
+static int
+mt7915_tm_set_tam_arb(struct mt7915_phy *phy, bool enable, bool mu)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		__le32 cmd;
+		u8 op_mode;
+	} __packed req = {
+		.cmd = cpu_to_le32(MURU_SET_ARB_OP_MODE),
+	};
+
+	if (!enable)
+		req.op_mode = TAM_ARB_OP_MODE_NORMAL;
+	else if (mu)
+		req.op_mode = TAM_ARB_OP_MODE_TEST;
+	else
+		req.op_mode = TAM_ARB_OP_MODE_FORCE_SU;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &req,
+				 sizeof(req), false);
+}
+
 static int
 mt7915_tm_set_wmm_qid(struct mt7915_dev *dev, u8 qid, u8 aifs, u8 cw_min,
 		      u16 cw_max, u16 txop)
@@ -397,6 +419,10 @@ mt7915_tm_init(struct mt7915_phy *phy, bool en)
 	mt7915_tm_set_trx(phy, TM_MAC_TXRX, !en);
 
 	mt7915_mcu_add_bss_info(phy, phy->monitor_vif, en);
+	mt7915_mcu_add_sta(dev, phy->monitor_vif, NULL, en);
+
+	if (!en)
+		mt7915_tm_set_tam_arb(phy, en, 0);
 }
 
 static void
@@ -438,6 +464,9 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 		}
 	}
 
+	mt7915_tm_set_tam_arb(phy, en,
+			      td->tx_rate_mode == MT76_TM_TX_MODE_HE_MU);
+
 	/* if all three params are set, duty_cycle will be ignored */
 	if (duty_cycle && tx_time && !ipg) {
 		ipg = tx_time * 100 / duty_cycle - tx_time;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
index 397a6b5..107f0cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
@@ -96,4 +96,14 @@ enum {
 	RF_OPER_WIFI_SPECTRUM,
 };
 
+enum {
+	TAM_ARB_OP_MODE_NORMAL = 1,
+	TAM_ARB_OP_MODE_TEST,
+	TAM_ARB_OP_MODE_FORCE_SU = 5,
+};
+
+enum {
+	MURU_SET_ARB_OP_MODE = 14,
+};
+
 #endif
-- 
2.25.1

