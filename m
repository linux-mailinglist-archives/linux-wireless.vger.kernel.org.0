Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA62EA4FF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 06:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbhAEFnJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 00:43:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49322 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726059AbhAEFnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 00:43:08 -0500
X-UUID: 7a4c8d4bfdfa4dc09d09a5fcddb489dd-20210105
X-UUID: 7a4c8d4bfdfa4dc09d09a5fcddb489dd-20210105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 489818393; Tue, 05 Jan 2021 13:42:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 13:42:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 13:42:25 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: testmode: add support to set user-defined spe index
Date:   Tue, 5 Jan 2021 13:41:24 +0800
Message-ID: <20210105054124.5946-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add spatial extension (spe) index as a configurable parameter in testmode.
This is used for specifically configuring TX path, such as different
WF TX priority, number of antennas and spatial streams.

If spe_idx is not set, TX path depends on tx_antenna_mask; otherwise,
both spe_idx and tx_antenna_mask are referenced to decide TX path.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h         |  1 +
 .../net/wireless/mediatek/mt76/mt7915/testmode.c  | 15 ++++++++++-----
 drivers/net/wireless/mediatek/mt76/testmode.c     |  4 ++++
 drivers/net/wireless/mediatek/mt76/testmode.h     |  2 ++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 10034c21f812..245a7197b017 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -539,6 +539,7 @@ struct mt76_testmode_data {
 	u8 tx_ltf;
 
 	u8 tx_antenna_mask;
+	u8 tx_spe_idx;
 
 	u32 freq_offset;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index b58c91ea3fa5..278f279cc67b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -205,6 +205,7 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 {
 	static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
 					 9, 8, 6, 10, 16, 12, 18, 0};
+	struct mt76_testmode_data *td = &phy->mt76->test;
 	struct sk_buff *skb = phy->mt76->test.tx_skb;
 	struct mt7915_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info;
@@ -212,17 +213,21 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, false);
 
 	if (en) {
-		u8 tx_ant = phy->mt76->test.tx_antenna_mask;
-
 		mutex_unlock(&dev->mt76.mutex);
 		mt7915_set_channel(phy);
 		mutex_lock(&dev->mt76.mutex);
 
 		mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 
-		if (phy != &dev->phy)
-			tx_ant >>= 2;
-		phy->test.spe_idx = spe_idx_map[tx_ant];
+		if (td->tx_spe_idx) {
+			phy->test.spe_idx = td->tx_spe_idx;
+		} else {
+			u8 tx_ant = td->tx_antenna_mask;
+
+			if (phy != &dev->phy)
+				tx_ant >>= 2;
+			phy->test.spe_idx = spe_idx_map[tx_ant];
+		}
 	}
 
 	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 8b14620e16fc..ad8edf137b36 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -14,6 +14,7 @@ static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_TX_RATE_STBC] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_LTF] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_ANTENNA] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_SPE_IDX] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_POWER_CONTROL] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_POWER] = { .type = NLA_NESTED },
 	[MT76_TM_ATTR_FREQ_OFFSET] = { .type = NLA_U32 },
@@ -359,6 +360,7 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_LTF], &td->tx_ltf, 0, 2) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask,
 			   1 << (ext_phy * 2), phy->antenna_mask << (ext_phy * 2)) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_SPE_IDX], &td->tx_spe_idx, 0, 27) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_POWER_CONTROL],
 			   &td->tx_power_control, 0, 1))
 		goto out;
@@ -499,6 +501,8 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_LTF, td->tx_ltf)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_ANTENNA) &&
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_ANTENNA, td->tx_antenna_mask)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_SPE_IDX) &&
+	     nla_put_u8(msg, MT76_TM_ATTR_TX_SPE_IDX, td->tx_spe_idx)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_POWER_CONTROL) &&
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_POWER_CONTROL, td->tx_power_control)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_FREQ_OFFSET) &&
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index 7efad685a17c..f215b377d7fb 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -29,6 +29,7 @@
  * @MT76_TM_ATTR_TX_LTF: packet tx LTF, set 0 to 2 for 1x, 2x, and 4x LTF (u8)
  *
  * @MT76_TM_ATTR_TX_ANTENNA: tx antenna mask (u8)
+ * @MT76_TM_ATTR_TX_SPE_IDX: tx spatial extension index (u8)
  * @MT76_TM_ATTR_TX_POWER_CONTROL: enable tx power control (u8)
  * @MT76_TM_ATTR_TX_POWER: per-antenna tx power array (nested, u8 attrs)
  *
@@ -56,6 +57,7 @@ enum mt76_testmode_attr {
 	MT76_TM_ATTR_TX_LTF,
 
 	MT76_TM_ATTR_TX_ANTENNA,
+	MT76_TM_ATTR_TX_SPE_IDX,
 	MT76_TM_ATTR_TX_POWER_CONTROL,
 	MT76_TM_ATTR_TX_POWER,
 
-- 
2.29.2

