Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7814810DE0F
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfK3Pat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:49 -0500
Received: from nbd.name ([46.4.11.11]:56076 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gSlTD4TPbaJlr/kc0f6ANUzOBEtvNM5n8VX09Q1Km/Q=; b=m32uF6ICbomD9tg8hsH8YrXE5G
        O2IQJxaUpbde/4FdHi6qnQ0tcm99/0JfIa331u28B7c6DKHUMO2peQL0tzrqJ1swZL7FhqBoSoEd6
        Vti7ssJRAx+cEYkJgBZV9UQ04crc6ya0DZswWXu/Tr2WWiXEwh/s3UmPrVd9w98tnNU0=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iL-TB
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0B920721EBE5; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/29] mt76: move chainmask back to driver specific structs
Date:   Sat, 30 Nov 2019 16:30:26 +0100
Message-Id: <20191130153045.28105-10-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nothing in the core uses it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h         | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c | 2 +-
 10 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 441a9a81eb44..98d9653865e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -524,7 +524,6 @@ struct mt76_dev {
 	u32 aggr_stats[32];
 
 	u8 antenna_mask;
-	u16 chainmask;
 
 	struct tasklet_struct pre_tbtt_tasklet;
 	int beacon_int;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index eccad4987ac8..6bf8388410ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -124,7 +124,7 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	if (!tx_mask || tx_mask > max_nss)
 		tx_mask = max_nss;
 
-	dev->mt76.chainmask = tx_mask << 8 | rx_mask;
+	dev->chainmask = tx_mask << 8 | rx_mask;
 	dev->mt76.antenna_mask = BIT(tx_mask) - 1;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 1aba10e6b5cb..3c5922d17e44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1299,7 +1299,7 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	} req = {
 		.control_chan = chandef->chan->hw_value,
 		.center_chan = ieee80211_frequency_to_channel(freq1),
-		.tx_streams = (dev->mt76.chainmask >> 8) & 0xf,
+		.tx_streams = (dev->chainmask >> 8) & 0xf,
 		.rx_streams_mask = dev->mt76.antenna_mask,
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 828df9b4a53e..9c27b355a445 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -85,6 +85,7 @@ struct mt7615_dev {
 		struct mt76_phy mphy;
 	};
 
+	u16 chainmask;
 	u32 vif_mask;
 	u32 omac_mask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 7a44ab52fca6..28572797a7a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -80,6 +80,7 @@ struct mt76x02_dev {
 	struct mutex phy_mutex;
 
 	u16 vif_mask;
+	u16 chainmask;
 
 	u8 txdone_seq;
 	DECLARE_KFIFO_PTR(txstatus_fifo, struct mt76x02_tx_status);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 8a4396941ef2..8fe21e7e0996 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -344,7 +344,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 	u16 txwi_flags = 0;
 	u8 nss;
 	s8 txpwr_adj, max_txpwr_adj;
-	u8 ccmp_pn[8], nstreams = dev->mt76.chainmask & 0xf;
+	u8 ccmp_pn[8], nstreams = dev->chainmask & 0xf;
 
 	memset(txwi, 0, sizeof(*txwi));
 
@@ -679,7 +679,7 @@ mt76x02_mac_process_rate(struct mt76x02_dev *dev,
 		status->rate_idx = idx;
 		break;
 	case MT_PHY_TYPE_VHT: {
-		u8 n_rxstream = dev->mt76.chainmask & 0xf;
+		u8 n_rxstream = dev->chainmask & 0xf;
 
 		status->encoding = RX_ENC_VHT;
 		status->rate_idx = FIELD_GET(MT_RATE_INDEX_VHT_IDX, idx);
@@ -769,7 +769,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	u16 rate = le16_to_cpu(rxwi->rate);
 	u16 tid_sn = le16_to_cpu(rxwi->tid_sn);
 	bool unicast = rxwi->rxinfo & cpu_to_le32(MT_RXINFO_UNICAST);
-	int pad_len = 0, nstreams = dev->mt76.chainmask & 0xf;
+	int pad_len = 0, nstreams = dev->chainmask & 0xf;
 	s8 signal;
 	u8 pn_len;
 	u8 wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
index d7334267b530..aaadc15ea83c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -16,7 +16,7 @@ void mt76x02_phy_set_rxpath(struct mt76x02_dev *dev)
 	val = mt76_rr(dev, MT_BBP(AGC, 0));
 	val &= ~BIT(4);
 
-	switch (dev->mt76.chainmask & 0xf) {
+	switch (dev->chainmask & 0xf) {
 	case 2:
 		val |= BIT(3);
 		break;
@@ -35,7 +35,7 @@ void mt76x02_phy_set_txdac(struct mt76x02_dev *dev)
 {
 	int txpath;
 
-	txpath = (dev->mt76.chainmask >> 8) & 0xf;
+	txpath = (dev->chainmask >> 8) & 0xf;
 	switch (txpath) {
 	case 2:
 		mt76_set(dev, MT_BBP(TXBE, 5), 0x3);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index d226112494d3..846cd75e3e2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -192,10 +192,10 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 				IEEE80211_HT_CAP_LDPC_CODING;
 		dev->mphy.sband_5g.sband.ht_cap.cap |=
 				IEEE80211_HT_CAP_LDPC_CODING;
-		dev->mt76.chainmask = 0x202;
+		dev->chainmask = 0x202;
 		dev->mt76.antenna_mask = 3;
 	} else {
-		dev->mt76.chainmask = 0x101;
+		dev->chainmask = 0x101;
 		dev->mt76.antenna_mask = 1;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
index 76d8cd37d4de..9635c04ce032 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
@@ -29,7 +29,7 @@ int mt76x2_mcu_set_channel(struct mt76x02_dev *dev, u8 channel, u8 bw,
 		.idx = channel,
 		.scan = scan,
 		.bw = bw,
-		.chainmask = cpu_to_le16(dev->mt76.chainmask),
+		.chainmask = cpu_to_le16(dev->chainmask),
 	};
 
 	/* first set the channel without the extension channel info */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 1f2db374ed51..bc0ffae7adda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -124,7 +124,7 @@ static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	dev->mt76.chainmask = (tx_ant == 3) ? 0x202 : 0x101;
+	dev->chainmask = (tx_ant == 3) ? 0x202 : 0x101;
 	dev->mt76.antenna_mask = tx_ant;
 
 	mt76_set_stream_caps(&dev->mt76, true);
-- 
2.24.0

