Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3572EA6CA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAEI4x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:56:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54468 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726305AbhAEI4w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:56:52 -0500
X-UUID: 4cf811e26548444c8b57881937041c57-20210105
X-UUID: 4cf811e26548444c8b57881937041c57-20210105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 816159774; Tue, 05 Jan 2021 16:56:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/6] mt76: testmode: add attributes for ipg related parameters
Date:   Tue, 5 Jan 2021 16:55:24 +0800
Message-ID: <20210105085529.14206-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add attributes for setting tx inter-packet gap (ipg), duty cycle, and
transmission time in testmode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++++
 drivers/net/wireless/mediatek/mt76/testmode.c | 17 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.h |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 245a7197b017..cbe9689dc2ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -541,6 +541,10 @@ struct mt76_testmode_data {
 	u8 tx_antenna_mask;
 	u8 tx_spe_idx;
 
+	u8 tx_duty_cycle;
+	u32 tx_time;
+	u32 tx_ipg;
+
 	u32 freq_offset;
 
 	u8 tx_power[4];
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index ad8edf137b36..74cadf51df55 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -17,6 +17,9 @@ static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_TX_SPE_IDX] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_POWER_CONTROL] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_POWER] = { .type = NLA_NESTED },
+	[MT76_TM_ATTR_TX_DUTY_CYCLE] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_IPG] = { .type = NLA_U32 },
+	[MT76_TM_ATTR_TX_TIME] = { .type = NLA_U32 },
 	[MT76_TM_ATTR_FREQ_OFFSET] = { .type = NLA_U32 },
 };
 
@@ -361,10 +364,18 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask,
 			   1 << (ext_phy * 2), phy->antenna_mask << (ext_phy * 2)) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_SPE_IDX], &td->tx_spe_idx, 0, 27) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_DUTY_CYCLE],
+			   &td->tx_duty_cycle, 0, 99) ||
 	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_POWER_CONTROL],
 			   &td->tx_power_control, 0, 1))
 		goto out;
 
+	if (tb[MT76_TM_ATTR_TX_IPG])
+		td->tx_ipg = nla_get_u32(tb[MT76_TM_ATTR_TX_IPG]);
+
+	if (tb[MT76_TM_ATTR_TX_TIME])
+		td->tx_time = nla_get_u32(tb[MT76_TM_ATTR_TX_TIME]);
+
 	if (tb[MT76_TM_ATTR_FREQ_OFFSET])
 		td->freq_offset = nla_get_u32(tb[MT76_TM_ATTR_FREQ_OFFSET]);
 
@@ -503,6 +514,12 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_ANTENNA, td->tx_antenna_mask)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_SPE_IDX) &&
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_SPE_IDX, td->tx_spe_idx)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_DUTY_CYCLE) &&
+	     nla_put_u8(msg, MT76_TM_ATTR_TX_DUTY_CYCLE, td->tx_duty_cycle)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_IPG) &&
+	     nla_put_u32(msg, MT76_TM_ATTR_TX_IPG, td->tx_ipg)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_TIME) &&
+	     nla_put_u32(msg, MT76_TM_ATTR_TX_TIME, td->tx_time)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_POWER_CONTROL) &&
 	     nla_put_u8(msg, MT76_TM_ATTR_TX_POWER_CONTROL, td->tx_power_control)) ||
 	    (mt76_testmode_param_present(td, MT76_TM_ATTR_FREQ_OFFSET) &&
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index f215b377d7fb..cecdf358aa44 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -33,6 +33,10 @@
  * @MT76_TM_ATTR_TX_POWER_CONTROL: enable tx power control (u8)
  * @MT76_TM_ATTR_TX_POWER: per-antenna tx power array (nested, u8 attrs)
  *
+ * @MT76_TM_ATTR_TX_DUTY_CYCLE: packet tx duty cycle (u8)
+ * @MT76_TM_ATTR_TX_IPG: tx inter-packet gap, in unit of us (u32)
+ * @MT76_TM_ATTR_TX_TIME: packet transmission time, in unit of us (u32)
+ *
  * @MT76_TM_ATTR_FREQ_OFFSET: RF frequency offset (u32)
  *
  * @MT76_TM_ATTR_STATS: statistics (nested, see &enum mt76_testmode_stats_attr)
@@ -61,6 +65,10 @@ enum mt76_testmode_attr {
 	MT76_TM_ATTR_TX_POWER_CONTROL,
 	MT76_TM_ATTR_TX_POWER,
 
+	MT76_TM_ATTR_TX_DUTY_CYCLE,
+	MT76_TM_ATTR_TX_IPG,
+	MT76_TM_ATTR_TX_TIME,
+
 	MT76_TM_ATTR_FREQ_OFFSET,
 
 	MT76_TM_ATTR_STATS,
-- 
2.29.2

