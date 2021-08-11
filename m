Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3CE3E89F6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 07:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhHKF6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 01:58:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51620 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234563AbhHKF6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 01:58:52 -0400
X-UUID: d9acd20eb85242039f8f64c1005a7497-20210811
X-UUID: d9acd20eb85242039f8f64c1005a7497-20210811
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1897002180; Wed, 11 Aug 2021 13:58:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 13:58:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 13:58:25 +0800
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
Subject: [PATCH] mt76: mt7921: fix firmware usage of RA info using legacy rates
Date:   Wed, 11 Aug 2021 13:58:24 +0800
Message-ID: <4be4378630c93ae32a4db8bc3e0871c7b15150a6.1628661185.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

According to the firmware usage, OFDM rates should fill out bit 6 - 13
while CCK rates should fill out bit 0 - 3 in legacy field of RA info to
make the rate adaption runs propertly. Otherwise, a unicast frame might be
picking up the unsupported rate to send out.

Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
Reported-by: Joshua Emele <jemele@chromium.org>
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index a2555dc0f003..27e45f4fc05f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -719,6 +719,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	struct sta_rec_state *state;
 	struct sta_rec_phy *phy;
 	struct tlv *tlv;
+	u16 supp_rates;
 
 	/* starec ht */
 	if (sta->ht_cap.ht_supported) {
@@ -767,7 +768,15 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
-	ra_info->legacy = cpu_to_le16((u16)sta->supp_rates[band]);
+
+	supp_rates = sta->supp_rates[band];
+	if (band == NL80211_BAND_2GHZ)
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
+			     FIELD_PREP(RA_LEGACY_CCK, supp_rates & 0xf);
+	else
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates);
+
+	ra_info->legacy = cpu_to_le16(supp_rates);
 
 	if (sta->ht_cap.ht_supported)
 		memcpy(ra_info->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ab77289c0541..9dfdf7625844 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -124,6 +124,8 @@ struct sta_rec_state {
 	u8 rsv[1];
 } __packed;
 
+#define RA_LEGACY_OFDM GENMASK(13, 6)
+#define RA_LEGACY_CCK  GENMASK(3, 0)
 #define HT_MCS_MASK_NUM 10
 struct sta_rec_ra_info {
 	__le16 tag;
-- 
2.25.1

