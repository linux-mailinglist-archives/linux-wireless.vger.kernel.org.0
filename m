Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D4448203
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbhKHOqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 09:46:10 -0500
Received: from mailgw01.mediatek.com ([216.200.240.184]:62653 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbhKHOqJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 09:46:09 -0500
X-UUID: 1b16e850da0c4dc5a725b3597fd62a3f-20211108
X-UUID: 1b16e850da0c4dc5a725b3597fd62a3f-20211108
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773574449; Mon, 08 Nov 2021 07:43:15 -0700
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Nov 2021 06:43:14 -0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 8 Nov 2021 22:43:12 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2] mt76: mt7921: introduce 160 MHz channel bandwidth support
Date:   Mon, 8 Nov 2021 22:41:53 +0800
Message-ID: <66edc3125e9a12dedeba1a61697d46322b0c004d.1636374449.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Introduce the basic configuration for chips with BW160 capability

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            |  1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 12 ++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e2da720a91b6..babca8086027 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -346,6 +346,7 @@ struct mt76_hw_cap {
 	bool has_2ghz;
 	bool has_5ghz;
 	bool has_6ghz;
+	bool has_bw160;
 };
 
 #define MT_DRV_TXWI_NO_FREE		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 26b4b875dcc0..3b42e1e8e970 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1775,6 +1775,7 @@ static void mt76_connac_mcu_parse_phy_cap(struct mt76_dev *dev,
 	dev->phy.chainmask = dev->phy.antenna_mask;
 	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
 	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+	dev->phy.cap.has_bw160 = cap->max_bw == IEEE80211_STA_RX_BW_160;
 }
 
 int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 210998f086ab..30c0246fba3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -264,6 +264,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
 			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+	if (dev->mt76.phy.cap.has_bw160)
+		dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+			IEEE80211_VHT_CAP_SHORT_GI_160;
 
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 633c6d2a57ac..af8c675f909f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -128,11 +128,23 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
 				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
 				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+
+			if (phy->mt76->cap.has_bw160) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+				he_cap_elem->phy_cap_info[8] |=
+					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
+			}
 			break;
 		}
 
 		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
 		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		if (phy->mt76->cap.has_bw160) {
+			he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+			he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		}
 
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
-- 
2.18.0

