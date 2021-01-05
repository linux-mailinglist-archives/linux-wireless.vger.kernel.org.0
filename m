Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD632EA6CE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhAEI5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:57:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbhAEI5N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:57:13 -0500
X-UUID: 1a637ae1128b4ab0ab40a2a5a483bd02-20210105
X-UUID: 1a637ae1128b4ab0ab40a2a5a483bd02-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 624529734; Tue, 05 Jan 2021 16:56:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/6] mt76: mt7915: add support for ipg in testmode
Date:   Tue, 5 Jan 2021 16:55:27 +0800
Message-ID: <20210105085529.14206-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105085529.14206-1-shayne.chen@mediatek.com>
References: <20210105085529.14206-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to calculate and apply ipg parameters in testmode
for MT7915 NIC.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   8 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 125 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7915/testmode.h  |  11 ++
 4 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index ee6d70339d92..66d34d78c1d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -49,6 +49,7 @@ enum {
 enum {
 	MCU_ATE_SET_TRX = 0x1,
 	MCU_ATE_SET_FREQ_OFFSET = 0xa,
+	MCU_ATE_SET_SLOT_TIME = 0x13,
 };
 
 struct mt7915_mcu_rxd {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 848703e6eb7c..6fb5cbab9c32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -59,6 +59,13 @@
 #define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
 #define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
 
+#define MT_TMAC_ATCR(_band)		MT_WF_TMAC(_band, 0x098)
+#define MT_TMAC_ATCR_TXV_TOUT		GENMASK(7, 0)
+
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TRCR0_TR2T_CHK		GENMASK(8, 0)
+#define MT_TMAC_TRCR0_I2T_CHK		GENMASK(24, 16)
+
 #define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
 #define MT_IFS_EIFS			GENMASK(8, 0)
 #define MT_IFS_RIFS			GENMASK(14, 10)
@@ -70,7 +77,6 @@
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
-#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
 #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
 
 #define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 278f279cc67b..748c9b55e498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -132,6 +132,111 @@ mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 				 sizeof(req), false);
 }
 
+static int
+mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_tm_cmd req = {
+		.testmode_en = !(phy->mt76->test.state == MT76_TM_STATE_OFF),
+		.param_idx = MCU_ATE_SET_SLOT_TIME,
+		.param.slot.slot_time = slot_time,
+		.param.slot.sifs = sifs,
+		.param.slot.rifs = 2,
+		.param.slot.eifs = cpu_to_le16(60),
+		.param.slot.band = phy != &dev->phy,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+				 sizeof(req), false);
+}
+
+static int
+mt7915_tm_set_wmm_qid(struct mt7915_dev *dev, u8 qid, u8 aifs, u8 cw_min,
+		      u16 cw_max, u16 txop)
+{
+	struct mt7915_mcu_tx req = { .total = 1 };
+	struct edca *e = &req.edca[0];
+
+	e->queue = qid;
+	e->set = WMM_PARAM_SET;
+
+	e->aifs = aifs;
+	e->cw_min = cw_min;
+	e->cw_max = cpu_to_le16(cw_max);
+	e->txop = cpu_to_le16(txop);
+
+	return mt7915_mcu_update_edca(dev, &req);
+}
+
+static int
+mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
+{
+#define TM_DEFAULT_SIFS	10
+#define TM_MAX_SIFS	127
+#define TM_MAX_AIFSN	0xf
+#define TM_MIN_AIFSN	0x1
+#define BBP_PROC_TIME	1500
+	struct mt7915_dev *dev = phy->dev;
+	u8 sig_ext = (mode == MT76_TM_TX_MODE_CCK) ? 0 : 6;
+	u8 slot_time = 9, sifs = TM_DEFAULT_SIFS;
+	u8 aifsn = TM_MIN_AIFSN;
+	u32 i2t_time, tr2t_time, txv_time;
+	bool ext_phy = phy != &dev->phy;
+	u16 cw = 0;
+
+	if (ipg < sig_ext + slot_time + sifs)
+		ipg = 0;
+
+	if (!ipg)
+		goto done;
+
+	ipg -= sig_ext;
+
+	if (ipg <= (TM_MAX_SIFS + slot_time)) {
+		sifs = ipg - slot_time;
+	} else {
+		u32 val = (ipg + slot_time) / slot_time;
+
+		while (val >>= 1)
+			cw++;
+
+		if (cw > 16)
+			cw = 16;
+
+		ipg -= ((1 << cw) - 1) * slot_time;
+
+		aifsn = ipg / slot_time;
+		if (aifsn > TM_MAX_AIFSN)
+			aifsn = TM_MAX_AIFSN;
+
+		ipg -= aifsn * slot_time;
+
+		if (ipg > TM_DEFAULT_SIFS) {
+			if (ipg < TM_MAX_SIFS)
+				sifs = ipg;
+			else
+				sifs = TM_MAX_SIFS;
+		}
+	}
+done:
+	txv_time = mt76_get_field(dev, MT_TMAC_ATCR(ext_phy),
+				  MT_TMAC_ATCR_TXV_TOUT);
+	txv_time *= 50;	/* normal clock time */
+
+	i2t_time = (slot_time * 1000 - txv_time - BBP_PROC_TIME) / 50;
+	tr2t_time = (sifs * 1000 - txv_time - BBP_PROC_TIME) / 50;
+
+	mt76_set(dev, MT_TMAC_TRCR0(ext_phy),
+		 FIELD_PREP(MT_TMAC_TRCR0_TR2T_CHK, tr2t_time) |
+		 FIELD_PREP(MT_TMAC_TRCR0_I2T_CHK, i2t_time));
+
+	mt7915_tm_set_slot_time(phy, slot_time, sifs);
+
+	return mt7915_tm_set_wmm_qid(dev,
+				     mt7915_lmac_mapping(dev, IEEE80211_AC_BE),
+				     aifsn, cw, cw, 0);
+}
+
 static void
 mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 {
@@ -206,9 +311,12 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 	static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
 					 9, 8, 6, 10, 16, 12, 18, 0};
 	struct mt76_testmode_data *td = &phy->mt76->test;
-	struct sk_buff *skb = phy->mt76->test.tx_skb;
 	struct mt7915_dev *dev = phy->dev;
+	struct sk_buff *skb = td->tx_skb;
 	struct ieee80211_tx_info *info;
+	u8 duty_cycle = td->tx_duty_cycle;
+	u32 tx_time = td->tx_time;
+	u32 ipg = td->tx_ipg;
 
 	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, false);
 
@@ -230,13 +338,26 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 		}
 	}
 
-	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
+	/* if all three params are set, duty_cycle will be ignored */
+	if (duty_cycle && tx_time && !ipg) {
+		ipg = tx_time * 100 / duty_cycle - tx_time;
+	} else if (duty_cycle && !tx_time && ipg) {
+		if (duty_cycle < 100)
+			tx_time = duty_cycle * ipg / (100 - duty_cycle);
+	}
+
+	mt7915_tm_set_ipg_params(phy, ipg, td->tx_rate_mode);
+
+	if (ipg)
+		td->tx_queued_limit = MT76_TM_TIMEOUT * 1000000 / ipg / 2;
 
 	if (!en || !skb)
 		return;
 
 	info = IEEE80211_SKB_CB(skb);
 	info->control.vif = phy->monitor_vif;
+
+	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
index 964f2d7fde3a..784d4c948886 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
@@ -16,6 +16,16 @@ struct mt7915_tm_freq_offset {
 	__le32 freq_offset;
 };
 
+struct mt7915_tm_slot_time {
+	u8 slot_time;
+	u8 sifs;
+	u8 rifs;
+	u8 _rsv;
+	__le16 eifs;
+	u8 band;
+	u8 _rsv1[5];
+};
+
 struct mt7915_tm_cmd {
 	u8 testmode_en;
 	u8 param_idx;
@@ -24,6 +34,7 @@ struct mt7915_tm_cmd {
 		__le32 data;
 		struct mt7915_tm_trx trx;
 		struct mt7915_tm_freq_offset freq;
+		struct mt7915_tm_slot_time slot;
 		u8 test[72];
 	} param;
 } __packed;
-- 
2.29.2

