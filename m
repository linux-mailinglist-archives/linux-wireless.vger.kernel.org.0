Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D52FD9C4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 20:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392612AbhATTfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 14:35:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48775 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392580AbhATTf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 14:35:27 -0500
X-UUID: d02bb83abffe4109bef81d894f49748c-20210121
X-UUID: d02bb83abffe4109bef81d894f49748c-20210121
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1937928816; Thu, 21 Jan 2021 03:33:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 03:33:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 03:33:53 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v6 02/15] mt76: move chainmask in mt76_phy
Date:   Thu, 21 Jan 2021 03:33:38 +0800
Message-ID: <9650420f84d31392167e4333261b65bfd879463e.1611060302.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611060302.git.objelf@gmail.com>
References: <cover.1611060302.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B44392636DA6C12B06BF9FE95A64489D258E8084107DF698D786BB8C3FAE361D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move chainmask from driver phy to mt76_phy since it is used by all
drivers. This is a preliminary patch to create a common mcu library used
by mt7615 and mt7921 drivers

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h           |  1 +
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |  2 --
 .../net/wireless/mediatek/mt76/mt7615/testmode.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02.h        |  2 --
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c     |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c    | 13 ++++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  |  1 -
 .../net/wireless/mediatek/mt76/mt7915/testmode.c    |  2 +-
 21 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 52228936f792..1925e7fbc1b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -579,6 +579,7 @@ struct mt76_phy {
 
 	int txpower_cur;
 	u8 antenna_mask;
+	u16 chainmask;
 
 #ifdef CONFIG_NL80211_TESTMODE
 	struct mt76_testmode_data test;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 3232ebd5eda6..2eab23898c77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -161,7 +161,7 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 
 	dev->chainmask = BIT(tx_mask) - 1;
 	dev->mphy.antenna_mask = dev->chainmask;
-	dev->phy.chainmask = dev->chainmask;
+	dev->mphy.chainmask = dev->chainmask;
 }
 
 static int mt7663_eeprom_get_target_power_index(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index d89b607cce68..8151c1d60728 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -362,9 +362,9 @@ mt7615_cap_dbdc_enable(struct mt7615_dev *dev)
 		dev->mphy.antenna_mask = dev->chainmask >> 2;
 	else
 		dev->mphy.antenna_mask = dev->chainmask >> 1;
-	dev->phy.chainmask = dev->mphy.antenna_mask;
-	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
-	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
+	dev->mphy.chainmask = dev->mphy.antenna_mask;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 	mt76_set_stream_caps(&dev->mphy, true);
 }
 
@@ -375,7 +375,7 @@ mt7615_cap_dbdc_disable(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_SHORT_GI_160 |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 	dev->mphy.antenna_mask = dev->chainmask;
-	dev->phy.chainmask = dev->chainmask;
+	dev->mphy.chainmask = dev->chainmask;
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->chainmask;
 	mt76_set_stream_caps(&dev->mphy, true);
@@ -404,8 +404,8 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	phy = mphy->priv;
 	phy->dev = dev;
 	phy->mt76 = mphy;
-	phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
-	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
+	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
+	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
 	mt7615_init_wiphy(mphy->hw);
 
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7615_mac_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2cc329019edc..26909fdbb0a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -326,7 +326,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		 * that PHY.
 		 */
 		if (phy_idx < 0) {
-			int first_chain = ffs(phy2->chainmask) - 1;
+			int first_chain = ffs(phy2->mt76->chainmask) - 1;
 
 			phy_idx = ((rxdg5 >> (first_chain * 8)) & 0xff) == 0;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index a7155509f95a..5134d051dc2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -911,7 +911,7 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		else
 			tx_ant <<= 1;
 	}
-	phy->chainmask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
 
 	mt76_set_stream_caps(phy->mt76, true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c49e9041006f..c377860e220f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1662,7 +1662,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			.center_chan = ieee80211_frequency_to_channel(freq1),
 			.center_chan2 = ieee80211_frequency_to_channel(freq2),
 			.tx_streams = hweight8(phy->mt76->antenna_mask),
-			.rx_streams = phy->chainmask,
+			.rx_streams = phy->mt76->chainmask,
 			.short_st = true,
 		},
 	};
@@ -2880,7 +2880,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 		.control_chan = chandef->chan->hw_value,
 		.center_chan = ieee80211_frequency_to_channel(freq1),
 		.tx_streams = hweight8(phy->mt76->antenna_mask),
-		.rx_streams_mask = phy->chainmask,
+		.rx_streams_mask = phy->mt76->chainmask,
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 99365807142e..a773ea4d5b12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -171,8 +171,6 @@ struct mt7615_phy {
 	s8 ofdm_sensitivity;
 	s8 cck_sensitivity;
 
-	u16 chainmask;
-
 	s16 coverage_class;
 	u8 slottime;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index b82915445d0d..a0542a309e27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -178,7 +178,7 @@ mt7615_tm_set_tx_antenna(struct mt7615_phy *phy, bool en)
 		return;
 
 	if (!en)
-		mask = phy->chainmask;
+		mask = phy->mt76->chainmask;
 
 	for (i = 0; i < 4; i++) {
 		mt76_rmw_field(dev, MT_WF_PHY_RFINTF3_0(i),
@@ -306,7 +306,7 @@ mt7615_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 	    td->state == MT76_TM_STATE_OFF)
 		return 0;
 
-	if (td->tx_antenna_mask & ~phy->chainmask)
+	if (td->tx_antenna_mask & ~mphy->chainmask)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index d626817a2103..4d58c2c1c0ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -82,8 +82,6 @@ struct mt76x02_dev {
 
 	struct mutex phy_mutex;
 
-	u16 chainmask;
-
 	u8 txdone_seq;
 	DECLARE_KFIFO_PTR(txstatus_fifo, struct mt76x02_tx_status);
 	spinlock_t txstatus_fifo_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index e0c4e1981e5b..771bad60e1bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -345,7 +345,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 	u16 txwi_flags = 0;
 	u8 nss;
 	s8 txpwr_adj, max_txpwr_adj;
-	u8 ccmp_pn[8], nstreams = dev->chainmask & 0xf;
+	u8 ccmp_pn[8], nstreams = dev->mphy.chainmask & 0xf;
 
 	memset(txwi, 0, sizeof(*txwi));
 
@@ -685,7 +685,7 @@ mt76x02_mac_process_rate(struct mt76x02_dev *dev,
 		status->rate_idx = idx;
 		break;
 	case MT_PHY_TYPE_VHT: {
-		u8 n_rxstream = dev->chainmask & 0xf;
+		u8 n_rxstream = dev->mphy.chainmask & 0xf;
 
 		status->encoding = RX_ENC_VHT;
 		status->rate_idx = FIELD_GET(MT_RATE_INDEX_VHT_IDX, idx);
@@ -777,7 +777,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	u16 rate = le16_to_cpu(rxwi->rate);
 	u16 tid_sn = le16_to_cpu(rxwi->tid_sn);
 	bool unicast = rxwi->rxinfo & cpu_to_le32(MT_RXINFO_UNICAST);
-	int pad_len = 0, nstreams = dev->chainmask & 0xf;
+	int pad_len = 0, nstreams = dev->mphy.chainmask & 0xf;
 	s8 signal;
 	u8 pn_len;
 	u8 wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
index aaadc15ea83c..2e53b0c1afdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -16,7 +16,7 @@ void mt76x02_phy_set_rxpath(struct mt76x02_dev *dev)
 	val = mt76_rr(dev, MT_BBP(AGC, 0));
 	val &= ~BIT(4);
 
-	switch (dev->chainmask & 0xf) {
+	switch (dev->mphy.chainmask & 0xf) {
 	case 2:
 		val |= BIT(3);
 		break;
@@ -35,7 +35,7 @@ void mt76x02_phy_set_txdac(struct mt76x02_dev *dev)
 {
 	int txpath;
 
-	txpath = (dev->chainmask >> 8) & 0xf;
+	txpath = (dev->mphy.chainmask >> 8) & 0xf;
 	switch (txpath) {
 	case 2:
 		mt76_set(dev, MT_BBP(TXBE, 5), 0x3);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index db7bd35d425c..1852b6c9add6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -197,10 +197,10 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 				IEEE80211_HT_CAP_LDPC_CODING;
 		dev->mphy.sband_5g.sband.ht_cap.cap |=
 				IEEE80211_HT_CAP_LDPC_CODING;
-		dev->chainmask = 0x202;
+		dev->mphy.chainmask = 0x202;
 		dev->mphy.antenna_mask = 3;
 	} else {
-		dev->chainmask = 0x101;
+		dev->mphy.chainmask = 0x101;
 		dev->mphy.antenna_mask = 1;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
index 3c2738903d7d..ac83ce5f3e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
@@ -29,7 +29,7 @@ int mt76x2_mcu_set_channel(struct mt76x02_dev *dev, u8 channel, u8 bw,
 		.idx = channel,
 		.scan = scan,
 		.bw = bw,
-		.chainmask = cpu_to_le16(dev->chainmask),
+		.chainmask = cpu_to_le16(dev->mphy.chainmask),
 	};
 
 	/* first set the channel without the extension channel info */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 93fa3f644bb8..933125b07ea3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -116,7 +116,7 @@ static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	dev->chainmask = (tx_ant == 3) ? 0x202 : 0x101;
+	dev->mphy.chainmask = (tx_ant == 3) ? 0x202 : 0x101;
 	dev->mphy.antenna_mask = tx_ant;
 
 	mt76_set_stream_caps(&dev->mphy, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 0a3ac07bab4a..7807b9165e01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -89,7 +89,7 @@ static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 
 	dev->chainmask = BIT(nss) - 1;
 	dev->mphy.antenna_mask = BIT(tx_mask[0]) - 1;
-	dev->phy.chainmask = dev->mphy.antenna_mask;
+	dev->mphy.chainmask = dev->mphy.antenna_mask;
 }
 
 int mt7915_eeprom_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6d1ea2998b52..e7fa68ae8640 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -235,8 +235,8 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	phy = mphy->priv;
 	phy->dev = dev;
 	phy->mt76 = mphy;
-	phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
-	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
+	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
+	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
 	mt7915_init_wiphy(mphy->hw);
 
 	INIT_LIST_HEAD(&phy->stats_list);
@@ -329,7 +329,7 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 {
-	int nss = hweight8(phy->chainmask);
+	int nss = hweight8(phy->mt76->chainmask);
 	u32 *cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
@@ -440,8 +440,7 @@ static int
 mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data)
 {
-	int i, idx = 0;
-	int nss = hweight8(phy->chainmask);
+	int i, idx = 0, nss = hweight8(phy->mt76->chainmask);
 	u16 mcs_map = 0;
 
 	for (i = 0; i < 8; i++) {
@@ -648,8 +647,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 		dev->mphy.sband_5g.sband.vht_cap.cap |=
 			IEEE80211_VHT_CAP_SHORT_GI_160 |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
-	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
-	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7915_set_stream_vht_txbf_caps(&dev->phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cdc4b3ed5259..261bb1890a4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1362,7 +1362,7 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 	u32 val, sum = 0, n = 0;
 	int nss, i;
 
-	for (nss = 0; nss < hweight8(phy->chainmask); nss++) {
+	for (nss = 0; nss < hweight8(phy->mt76->chainmask); nss++) {
 		u32 reg = MT_WF_IRPI(nss + (idx << dev->dbdc_support));
 
 		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 60a0fc9ec3c7..24d912cb112d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -812,7 +812,7 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		else
 			tx_ant <<= 1;
 	}
-	phy->chainmask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ae9efdba8494..6c3d5ee2b888 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -834,9 +834,9 @@ static void
 mt7915_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		      struct mt7915_phy *phy)
 {
+	int max_nss = hweight8(phy->mt76->chainmask);
 	struct bss_info_ra *ra;
 	struct tlv *tlv;
-	int max_nss = hweight8(phy->chainmask);
 
 	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_RA, sizeof(*ra));
 
@@ -1771,7 +1771,7 @@ mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 {
 	struct ieee80211_sta_vht_cap *pc = &sta->vht_cap;
 	struct ieee80211_sta_vht_cap *vc = &phy->mt76->sband_5g.sband.vht_cap;
-	u8 bfee_nr, bfer_nr, n, tx_ant = hweight8(phy->chainmask) - 1;
+	u8 bfee_nr, bfer_nr, n, tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	u16 mcs_map;
 
 	bf->tx_mode = MT_PHY_TYPE_VHT;
@@ -1868,9 +1868,9 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			struct ieee80211_vif *vif, struct mt7915_phy *phy,
 			bool enable)
 {
+	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
-	int tx_ant = hweight8(phy->chainmask) - 1;
 	const u8 matrix[4][4] = {
 		{0, 0, 0, 0},
 		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
@@ -1923,9 +1923,9 @@ static void
 mt7915_mcu_sta_bfee_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			struct mt7915_phy *phy)
 {
+	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
-	int tx_ant = hweight8(phy->chainmask) - 1;
 	u8 nr = 0;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a3cdaecef4ce..970c397734bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -126,7 +126,6 @@ struct mt7915_phy {
 	u64 omac_mask;
 
 	u16 noise;
-	u16 chainmask;
 
 	s16 coverage_class;
 	u8 slottime;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index b58c91ea3fa5..06353de2e762 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -316,7 +316,7 @@ mt7915_tm_set_params(struct mt76_phy *mphy, struct nlattr **tb,
 	    td->state == MT76_TM_STATE_OFF)
 		return 0;
 
-	if (td->tx_antenna_mask & ~phy->chainmask)
+	if (td->tx_antenna_mask & ~mphy->chainmask)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(tm_change_map); i++) {
-- 
2.25.1

