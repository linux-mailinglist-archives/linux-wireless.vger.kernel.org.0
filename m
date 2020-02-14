Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3913215D465
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgBNJMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 04:12:12 -0500
Received: from nbd.name ([46.4.11.11]:41284 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbgBNJML (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0of+fvnNm2vz7AJoX6Othy0SnQiZHg8p+Cxsmtvif3k=; b=bU17IVvT+hyO635C9JB5kaMr25
        bEkEdWcgemss+rPIZ0Ec/GEB4VlZLiBDGvGYBy4+cd7yu0NvU6XiBzZzSn6LCKU58nqRPNjg6RnW3
        IYC34N0qg1UxRPMLXj9nwgv83arYdy3xSfdQUOc/8sKG9I1PbPqc6mk1/HB+VSvBRd2I=;
Received: from [80.255.7.100] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j2X17-0006Mt-SY
        for linux-wireless@vger.kernel.org; Fri, 14 Feb 2020 10:12:10 +0100
Received: by maeck.local (Postfix, from userid 501)
        id D6FB87C8211F; Fri, 14 Feb 2020 10:12:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7615: rework rx phy index handling
Date:   Fri, 14 Feb 2020 10:12:07 +0100
Message-Id: <20200214091208.59619-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200214091208.59619-1-nbd@nbd.name>
References: <20200214091208.59619-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Overwriting the RMAC_CHFREQ register is not reliable enough, as the firmware
could potentially write it again.
Since there is no PHY index indication in the rx info, we need to use another
way:

If both PHYs are using different channels, find the PHY where chfreq matches
the register value.

The only corner case remaining is when both PHYs are using the same channel.
In that case, the per-packet noise value on the primary PHY will have
information belonging to the chains of the secondary PHY from the previous
received packet of that PHY. The secondary PHY will set noise to 0 for extra
chains.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 111 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   5 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   7 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 4 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b0d41ec68b77..22ec28bf80b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -169,36 +169,32 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7615_phy *phy = &dev->phy;
+	struct mt7615_phy *phy2 = dev->mt76.phy2 ? dev->mt76.phy2->priv : NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_hdr *hdr;
 	__le32 *rxd = (__le32 *)skb->data;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
+	__le32 rxd12 = rxd[12];
 	bool unicast, remove_pad, insert_ccmp_hdr = false;
+	int phy_idx;
 	int i, idx;
 	u8 chfreq;
 
 	memset(status, 0, sizeof(*status));
 
 	chfreq = FIELD_GET(MT_RXD1_NORMAL_CH_FREQ, rxd1);
-	if (!(chfreq & MT_CHFREQ_VALID))
-		return -EINVAL;
-
-	if (chfreq & MT_CHFREQ_DBDC_IDX) {
-		mphy = dev->mt76.phy2;
-		if (!mphy)
-			return -EINVAL;
-
-		phy = mphy->priv;
-		status->ext_phy = true;
-	}
-
-	if ((chfreq & MT_CHFREQ_SEQ) != phy->chfreq_seq)
-		return -EINVAL;
-
-	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
-		return -EINVAL;
+	if (!phy2)
+		phy_idx = 0;
+	else if (phy2->chfreq == phy->chfreq)
+		phy_idx = -1;
+	else if (phy->chfreq == chfreq)
+		phy_idx = 0;
+	else if (phy2->chfreq == chfreq)
+		phy_idx = 1;
+	else
+		phy_idx = -1;
 
 	unicast = (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) == MT_RXD1_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
@@ -214,13 +210,6 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		spin_unlock_bh(&dev->sta_poll_lock);
 	}
 
-	status->freq = mphy->chandef.chan->center_freq;
-	status->band = mphy->chandef.chan->band;
-	if (status->band == NL80211_BAND_5GHZ)
-		sband = &mphy->sband_5g.sband;
-	else
-		sband = &mphy->sband_2g.sband;
-
 	if (rxd2 & MT_RXD2_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
 
@@ -234,28 +223,11 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
-	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
-		      MT_RXD2_NORMAL_NON_AMPDU))) {
-		status->flag |= RX_FLAG_AMPDU_DETAILS;
-
-		/* all subframes of an A-MPDU have the same timestamp */
-		if (phy->rx_ampdu_ts != rxd[12]) {
-			if (!++phy->ampdu_ref)
-				phy->ampdu_ref++;
-		}
-		phy->rx_ampdu_ts = rxd[12];
-
-		status->ampdu_ref = phy->ampdu_ref;
-	}
-
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
 		return -EINVAL;
 
-	if (!sband->channels)
-		return -EINVAL;
-
 	rxd += 4;
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_4) {
 		rxd += 4;
@@ -287,6 +259,59 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 			return -EINVAL;
 	}
 
+	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
+		u32 rxdg5 = le32_to_cpu(rxd[5]);
+
+		/*
+		 * If both PHYs are on the same channel and we don't have a WCID,
+		 * we need to figure out which PHY this packet was received on.
+		 * On the primary PHY, the noise value for the chains belonging to the
+		 * second PHY will be set to the noise value of the last packet from
+		 * that PHY.
+		 */
+		if (phy_idx < 0) {
+			int first_chain = ffs(phy2->chainmask) - 1;
+
+			phy_idx = ((rxdg5 >> (first_chain * 8)) & 0xff) == 0;
+		}
+	}
+
+	if (phy_idx == 1 && phy2) {
+		mphy = dev->mt76.phy2;
+		phy = phy2;
+		status->ext_phy = true;
+	}
+
+	if (chfreq != phy->chfreq)
+		return -EINVAL;
+
+	status->freq = mphy->chandef.chan->center_freq;
+	status->band = mphy->chandef.chan->band;
+	if (status->band == NL80211_BAND_5GHZ)
+		sband = &mphy->sband_5g.sband;
+	else
+		sband = &mphy->sband_2g.sband;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
+		      MT_RXD2_NORMAL_NON_AMPDU))) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+		/* all subframes of an A-MPDU have the same timestamp */
+		if (phy->rx_ampdu_ts != rxd12) {
+			if (!++phy->ampdu_ref)
+				phy->ampdu_ref++;
+		}
+		phy->rx_ampdu_ts = rxd12;
+
+		status->ampdu_ref = phy->ampdu_ref;
+	}
+
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
 		u32 rxdg0 = le32_to_cpu(rxd[0]);
 		u32 rxdg1 = le32_to_cpu(rxd[1]);
@@ -340,14 +365,14 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
 
-		status->chains = dev->mphy.antenna_mask;
+		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
 		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
 		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
 		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
 		status->signal = status->chain_signal[0];
 
-		for (i = 1; i < hweight8(dev->mphy.antenna_mask); i++) {
+		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
 			if (!(status->chains & BIT(i)))
 				continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index bf12eba549f7..6fa7e3dd6a3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -103,6 +103,11 @@ enum rx_pkt_type {
 #define MT_RXV4_RCPI1			GENMASK(15, 8)
 #define MT_RXV4_RCPI0			GENMASK(7, 0)
 
+#define MT_RXV6_NF3			GENMASK(31, 24)
+#define MT_RXV6_NF2			GENMASK(23, 16)
+#define MT_RXV6_NF1			GENMASK(15, 8)
+#define MT_RXV6_NF0			GENMASK(7, 0)
+
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
 	MT_HDR_FORMAT_CMD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 001760709379..01194ed79869 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -229,7 +229,6 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
-	phy->chfreq_seq = (phy->chfreq_seq + 1) & MT_CHFREQ_SEQ;
 	phy->dfs_state = -1;
 	mt76_set_channel(phy->mt76);
 
@@ -237,11 +236,6 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	if (ret)
 		goto out;
 
-	mt76_wr(dev, MT_CHFREQ(ext_phy),
-		MT_CHFREQ_VALID |
-		(ext_phy * MT_CHFREQ_DBDC_IDX) |
-		phy->chfreq_seq);
-
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
@@ -249,6 +243,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 
 	mt7615_mac_reset_counters(dev);
 	phy->noise = 0;
+	phy->chfreq = mt76_rr(dev, MT_CHFREQ(ext_phy));
 
 out:
 	clear_bit(MT76_RESET, &phy->mt76->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2ecfddbd5ad4..a84a9b4cbf4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -134,7 +134,7 @@ struct mt7615_phy {
 	s16 coverage_class;
 	u8 slottime;
 
-	u8 chfreq_seq;
+	u8 chfreq;
 	u8 rdd_state;
 	int dfs_state;
 
-- 
2.24.0

