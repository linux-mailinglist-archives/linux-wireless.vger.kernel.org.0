Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D0910DE0B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfK3Pau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:50 -0500
Received: from nbd.name ([46.4.11.11]:56066 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfK3Pau (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u2qUR7Ml/rSWqtr8DS6Po7B4sCbdxit1b+0EKLd31h8=; b=oqcb22+JluZ7Sx9QwiZjHNnaS7
        fDT3ZKbuBnksj+Isjha3EHS8QqT6m7gGMsymhz0wE/COdH9FibfMAGXXBq8NgAsesOJx20IR2TaqA
        eH+jp48ZgpeSTw9RdA7up7IvyW1vRvYlUyTvnNXrjKmd23FpVxi0J1x4ZMcZRmJzqN60=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iT-SM
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0E9D2721EBEF; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 24/29] mt76: mt7615: add multiple wiphy support to the rx path
Date:   Sat, 30 Nov 2019 16:30:40 +0100
Message-Id: <20191130153045.28105-24-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Program the RMAC CHFREQ registers to properly indicate the band that the
frames are received on.
Add some sanity checks to the programmed values, because the firmware
programs these registers differently

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 42 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  7 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 11 +++--
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  2 +
 4 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 89d6a21820ac..886c54a91252 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -70,6 +70,8 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7615_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_hdr *hdr;
 	__le32 *rxd = (__le32 *)skb->data;
@@ -78,11 +80,28 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	bool unicast, remove_pad, insert_ccmp_hdr = false;
 	int i, idx;
+	u8 chfreq;
+
+	memset(status, 0, sizeof(*status));
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+	chfreq = FIELD_GET(MT_RXD1_NORMAL_CH_FREQ, rxd1);
+	if (!(chfreq & MT_CHFREQ_VALID))
 		return -EINVAL;
 
-	memset(status, 0, sizeof(*status));
+	if (chfreq & MT_CHFREQ_DBDC_IDX) {
+		mphy = dev->mt76.phy2;
+		if (!mphy)
+			return -EINVAL;
+
+		phy = mphy->priv;
+		status->ext_phy = true;
+	}
+
+	if ((chfreq & MT_CHFREQ_SEQ) != phy->chfreq_seq)
+		return -EINVAL;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
 
 	unicast = (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) == MT_RXD1_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
@@ -98,13 +117,12 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		spin_unlock_bh(&dev->sta_poll_lock);
 	}
 
-	/* TODO: properly support DBDC */
-	status->freq = dev->mphy.chandef.chan->center_freq;
-	status->band = dev->mphy.chandef.chan->band;
+	status->freq = mphy->chandef.chan->center_freq;
+	status->band = mphy->chandef.chan->band;
 	if (status->band == NL80211_BAND_5GHZ)
-		sband = &dev->mphy.sband_5g.sband;
+		sband = &mphy->sband_5g.sband;
 	else
-		sband = &dev->mphy.sband_2g.sband;
+		sband = &mphy->sband_2g.sband;
 
 	if (rxd2 & MT_RXD2_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -124,13 +142,13 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_AMPDU_DETAILS;
 
 		/* all subframes of an A-MPDU have the same timestamp */
-		if (dev->rx_ampdu_ts != rxd[12]) {
-			if (!++dev->ampdu_ref)
-				dev->ampdu_ref++;
+		if (phy->rx_ampdu_ts != rxd[12]) {
+			if (!++phy->ampdu_ref)
+				phy->ampdu_ref++;
 		}
-		dev->rx_ampdu_ts = rxd[12];
+		phy->rx_ampdu_ts = rxd[12];
 
-		status->ampdu_ref = dev->ampdu_ref;
+		status->ampdu_ref = phy->ampdu_ref;
 	}
 
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1650b7dfe2ad..4b23998957ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -178,6 +178,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 static int mt7615_set_channel(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	int ret;
 
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
@@ -185,6 +186,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
+	phy->chfreq_seq = (phy->chfreq_seq + 1) & MT_CHFREQ_SEQ;
 	phy->dfs_state = -1;
 	mt76_set_channel(phy->mt76);
 
@@ -192,6 +194,11 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	if (ret)
 		goto out;
 
+	mt76_wr(dev, MT_CHFREQ(ext_phy),
+		MT_CHFREQ_VALID |
+		(ext_phy * MT_CHFREQ_DBDC_IDX) |
+		phy->chfreq_seq);
+
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 37d3b0971292..64c8ad64733b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -36,6 +36,10 @@
 #define MT_FRAC_SCALE		12
 #define MT_FRAC(val, div)	(((val) << MT_FRAC_SCALE) / (div))
 
+#define MT_CHFREQ_VALID		BIT(7)
+#define MT_CHFREQ_DBDC_IDX	BIT(6)
+#define MT_CHFREQ_SEQ		GENMASK(5, 0)
+
 struct mt7615_vif;
 struct mt7615_sta;
 
@@ -92,8 +96,12 @@ struct mt7615_phy {
 
 	u16 chainmask;
 
+	u8 chfreq_seq;
 	u8 rdd_state;
 	int dfs_state;
+
+	__le32 rx_ampdu_ts;
+	u32 ampdu_ref;
 };
 
 struct mt7615_dev {
@@ -106,9 +114,6 @@ struct mt7615_dev {
 	u32 vif_mask;
 	u32 omac_mask;
 
-	__le32 rx_ampdu_ts;
-	u32 ampdu_ref;
-
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index a805561d10c4..d0602a3b0ac1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -200,6 +200,8 @@
 #define MT_WF_RFCR1_DROP_CFEND		BIT(7)
 #define MT_WF_RFCR1_DROP_CFACK		BIT(8)
 
+#define MT_CHFREQ(_band)		MT_WF_RMAC((_band) ? 0x130 : 0x030)
+
 #define MT_WF_RMAC_MIB_TIME0		MT_WF_RMAC(0x03c4)
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
 #define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
-- 
2.24.0

