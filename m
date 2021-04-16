Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C728A362AE6
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDPWQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 18:16:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54640 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232618AbhDPWQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 18:16:54 -0400
X-UUID: ade985bdd85a4db6b7b8d4138b5efac2-20210417
X-UUID: ade985bdd85a4db6b7b8d4138b5efac2-20210417
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1445916421; Sat, 17 Apr 2021 06:16:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Apr 2021 06:16:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Apr 2021 06:16:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7915: add support for DT rate power limits
Date:   Sat, 17 Apr 2021 06:16:17 +0800
Message-ID: <6c1be8713dfd1154b5ec61b2b094eb156d9fb659.1618609024.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

Enable to limit per-rate max txpower from DT.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0b739ed8ce33..3d88a05aad5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3375,15 +3375,47 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 		.format_id = 4,
 		.dbdc_idx = phy != &dev->phy,
 	};
-	int i;
-	s8 *delta;
+	struct mt76_power_limits limits_array;
+	s8 *delta, *la = (s8 *)&limits_array;
+	int i, idx, n_chains = hweight8(mphy->antenna_mask);
+	int tx_power;
 
 	delta = dev->rate_power[mphy->chandef.chan->band];
-	mphy->txpower_cur = hw->conf.power_level * 2 +
-			    delta[MT7915_SKU_MAX_DELTA_IDX];
+	tx_power = hw->conf.power_level * 2 -
+		   mt76_tx_power_nss_delta(n_chains);
+
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &limits_array, tx_power);
+	mphy->txpower_cur = tx_power;
+
+	for (i = 0, idx = 0; i < MAX_SKU_RATE_GROUP_NUM; i++) {
+		const struct sku_group *sku = &mt7915_sku_groups[i];
+		u32 offset = sku->offset[mphy->chandef.chan->band];
+		u8 mcs_num = sku->len;
+		int j;
+
+		if (i >= SKU_HT_BW20 && i <= SKU_VHT_BW160) {
+			mcs_num = 10;
+
+			if (i == SKU_HT_BW20 || i == SKU_VHT_BW20)
+				la = (s8 *)&limits_array + 12;
+		}
 
-	for (i = 0; i < MT7915_SKU_RATE_NUM; i++)
-		req.val[i] = hw->conf.power_level * 2 + delta[i];
+		if (!offset) {
+			idx += sku->len;
+			la += mcs_num;
+			continue;
+		}
+
+		for (j = 0; j < min_t(u8, mcs_num, sku->len); j++) {
+			s8 rate_power;
+
+			rate_power = hw->conf.power_level * 2 + delta[idx + j];
+			req.val[idx + j] = min_t(s8, la[j], rate_power);
+		}
+		la += mcs_num;
+		idx += sku->len;
+	}
 
 	return mt76_mcu_send_msg(&dev->mt76,
 				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
-- 
2.18.0

