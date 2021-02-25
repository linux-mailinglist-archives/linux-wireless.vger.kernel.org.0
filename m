Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717D3251D7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBYO7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 09:59:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39381 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231604AbhBYO73 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 09:59:29 -0500
X-UUID: 90f650db0b284ae3ba64f9e21ff82725-20210225
X-UUID: 90f650db0b284ae3ba64f9e21ff82725-20210225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 961085183; Thu, 25 Feb 2021 22:58:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Feb 2021 22:58:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 22:58:36 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: add missing capabilities for DBDC
Date:   Thu, 25 Feb 2021 22:58:35 +0800
Message-ID: <dd852df70c61ad730f39566ed6fa22c736ce5942.1614239710.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B25BA3C93DB8F615E26B47FBE407EC944DEC344A3EDE7C449983167C4ED8749A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adjust capabilities setup for DBDC to improve performance.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - adjust setup sequence.
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 50 +++++++++++--------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c599b44a728c..98de148e1043 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -113,6 +113,24 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	hw->max_tx_fragments = 4;
+
+	if (phy->mt76->cap.has_2ghz)
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+	if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+	}
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7915_set_stream_vht_txbf_caps(phy);
+	mt7915_set_stream_he_caps(phy);
 }
 
 static void
@@ -240,22 +258,17 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	phy->mt76 = mphy;
 	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
 	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
-	mt7915_init_wiphy(mphy->hw);
 
 	INIT_LIST_HEAD(&phy->stats_list);
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	mt7915_eeprom_parse_band_config(phy);
-	mt7915_set_stream_vht_txbf_caps(phy);
-	mt7915_set_stream_he_caps(phy);
+	mt7915_init_wiphy(mphy->hw);
 
 	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR2,
 	       ETH_ALEN);
 	mt76_eeprom_override(mphy);
 
-	/* The second interface does not get any packets unless it has a vif */
-	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
-
 	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
 				    MT7915_TX_RING_SIZE);
 	if (ret)
@@ -332,8 +345,14 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 {
-	int nss = hweight8(phy->mt76->chainmask);
-	u32 *cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
+	int nss;
+	u32 *cap;
+
+	if (!phy->mt76->cap.has_5ghz)
+		return;
+
+	nss = hweight8(phy->mt76->chainmask);
+	*cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
@@ -637,25 +656,14 @@ int mt7915_register_device(struct mt7915_dev *dev)
 		return ret;
 
 	mt7915_init_wiphy(hw);
-	dev->mphy.sband_2g.sband.ht_cap.cap |=
-			IEEE80211_HT_CAP_LDPC_CODING |
-			IEEE80211_HT_CAP_MAX_AMSDU;
-	dev->mphy.sband_5g.sband.ht_cap.cap |=
-			IEEE80211_HT_CAP_LDPC_CODING |
-			IEEE80211_HT_CAP_MAX_AMSDU;
-	dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+
 	if (!dev->dbdc_support)
 		dev->mphy.sband_5g.sband.vht_cap.cap |=
 			IEEE80211_VHT_CAP_SHORT_GI_160 |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
-
-	mt76_set_stream_caps(&dev->mphy, true);
-	mt7915_set_stream_vht_txbf_caps(&dev->phy);
-	mt7915_set_stream_he_caps(&dev->phy);
 	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
-- 
2.18.0

