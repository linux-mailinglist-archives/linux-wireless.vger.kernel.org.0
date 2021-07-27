Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C803D838A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhG0W7a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 18:59:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:45976 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232827AbhG0W7W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 18:59:22 -0400
X-UUID: eaab0206780947719879ba3d7699a363-20210728
X-UUID: eaab0206780947719879ba3d7699a363-20210728
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 201437277; Wed, 28 Jul 2021 06:59:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 06:59:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 06:59:19 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] mt76: connac: add support maximum regulatory Tx power
Date:   Wed, 28 Jul 2021 06:59:17 +0800
Message-ID: <1627426757-14811-2-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
References: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <YN.Chen@mediatek.com>

Consider .max_reg_power in struct ieee80211_channel to limit the
maximum power the wireless device allowed to transmit on the
corresponding channel according to the regulatory domain.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index d71393b1c5e6..84f42ce12626 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1773,6 +1773,43 @@ static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
 	return target_power;
 }
 
+static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
+				   struct ieee80211_channel *chan,
+				   s8 target_power)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	switch (chan->band) {
+	case NL80211_BAND_2GHZ:
+		sband = &phy->sband_2g.sband;
+		break;
+	case NL80211_BAND_5GHZ:
+		sband = &phy->sband_5g.sband;
+		break;
+	default:
+		return target_power;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *ch = &sband->channels[i];
+
+		if (ch->hw_value == chan->hw_value) {
+			if (!(ch->flags & IEEE80211_CHAN_DISABLED)) {
+				int power = 2 * ch->max_reg_power;
+
+				if (power > 127 || power < -127)
+					power = 127;
+				target_power = min_t(s8, power, target_power);
+			}
+			break;
+		}
+	}
+
+	return target_power;
+}
+
 static int
 mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				  enum nl80211_band band)
@@ -1840,10 +1877,12 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
-			s8 sar_power;
+			s8 reg_power, sar_power;
 
+			reg_power = mt76_connac_get_ch_power(phy, &chan,
+							     tx_power);
 			sar_power = mt76_connac_get_sar_power(phy, &chan,
-							      tx_power);
+							      reg_power);
 
 			mt76_get_rate_power_limits(phy, &chan, &limits,
 						   sar_power);
-- 
2.25.1

