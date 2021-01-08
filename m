Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F127A2EF67F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbhAHRfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 12:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbhAHRfF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 12:35:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0B392333E;
        Fri,  8 Jan 2021 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610127264;
        bh=wBZ5mumP3Adln5IPhn+gtns1tDptQ4ZE6Am/M1LMjao=;
        h=From:To:Cc:Subject:Date:From;
        b=P32z+17DsXRJA6l+/RPhWg+o/Lc2dN2HbklB7xD7v9N4teALWve14I0Clm7ZL3O8C
         rPvsJ3/2BAjXIoZTf2iO3xernsCwGe+4ksk6Cu8XibDtw/MLS1q464odpsebySp0+4
         p1dQLdDMixrEbWvbfOVfSftu/zVA+IH5OHsbzTIeh5CGmUkXnVm4tPs79bobBYjCfB
         zxZORSBg0DlODYmaywOIlAmuRZaPMWDXa+Ydfm4H3o8xULCaW/ZYFCodPkEhZag8VZ
         1m7eW/1pAYCtiTYDzVrRbCo/u3ZcnyHWKxv7Pj/c2/yyovIgo2UrvdYi21BnlEFWfb
         GNjfiufsbENyQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: set mcu country code in mt7615_mcu_set_channel_domain()
Date:   Fri,  8 Jan 2021 18:34:13 +0100
Message-Id: <a86337de4272797c0e1ed5913fe0de0f02d9e130.1610127075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update mcu country code running mt7615_mcu_set_channel_domain routine in
mt7615_regd_notifier().
Filter out disabled channels in mt7615_mcu_set_channel_domain().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 10 +++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 43 +++++++++++++------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ++
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 10034c21f812..5c86ade0aa1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -647,6 +647,7 @@ struct mt76_dev {
 
 	struct mt76_rate_power rate_power;
 
+	char alpha2[3];
 	enum nl80211_dfs_regions region;
 
 	u32 debugfs_reg;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a73b76e57c7f..635b94de1021 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -296,13 +296,15 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	struct mt7615_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
-		return;
-
 	mt7615_mutex_acquire(dev);
-	mt7615_dfs_init_radar_detector(phy);
+
+	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
+		mt7615_dfs_init_radar_detector(phy);
+	mt7615_mcu_set_channel_domain(phy);
+
 	mt7615_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c49e9041006f..715423c325e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2981,6 +2981,7 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
 	struct mt7615_dev *dev = phy->dev;
+	u32 country_code = MT76_ALPHA2_TO_CC(dev->mt76.alpha2);
 	struct mt7615_mcu_channel_domain {
 		__le32 country_code; /* regulatory_request.alpha2 */
 		u8 bw_2g; /* BW_20_40M		0
@@ -2995,45 +2996,61 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 		u8 n_5ch;
 		__le16 pad2;
 	} __packed hdr = {
+		.country_code = cpu_to_le32(country_code),
 		.bw_2g = 0,
 		.bw_5g = 3,
-		.n_2ch = mphy->sband_2g.sband.n_channels,
-		.n_5ch = mphy->sband_5g.sband.n_channels,
 	};
 	struct mt7615_mcu_chan {
 		__le16 hw_value;
 		__le16 pad;
 		__le32 flags;
-	} __packed;
-	int i, n_channels = hdr.n_2ch + hdr.n_5ch;
-	int len = sizeof(hdr) + n_channels * sizeof(struct mt7615_mcu_chan);
+	} __packed channel;
+	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0;
+	struct ieee80211_channel *chan;
 	struct sk_buff *skb;
 
 	if (!mt7615_firmware_offload(dev))
 		return 0;
 
+	n_max_channels = mphy->sband_2g.sband.n_channels +
+			 mphy->sband_5g.sband.n_channels;
+	len = sizeof(hdr) + n_max_channels * sizeof(channel);
+
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_put_data(skb, &hdr, sizeof(hdr));
+	skb_reserve(skb, sizeof(hdr));
 
-	for (i = 0; i < n_channels; i++) {
-		struct ieee80211_channel *chan;
-		struct mt7615_mcu_chan channel;
+	for (i = 0; i < mphy->sband_2g.sband.n_channels; i++) {
+		chan = &mphy->sband_2g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
 
-		if (i < hdr.n_2ch)
-			chan = &mphy->sband_2g.sband.channels[i];
-		else
-			chan = &mphy->sband_5g.sband.channels[i - hdr.n_2ch];
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_2ch++;
+	}
+	for (i = 0; i < mphy->sband_5g.sband.n_channels; i++) {
+		chan = &mphy->sband_5g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
 
 		channel.hw_value = cpu_to_le16(chan->hw_value);
 		channel.flags = cpu_to_le32(chan->flags);
 		channel.pad = 0;
 
 		skb_put_data(skb, &channel, sizeof(channel));
+		n_5ch++;
 	}
 
+	hdr.n_2ch = n_2ch;
+	hdr.n_5ch = n_5ch;
+	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
 				     false);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 979c5c7fe93c..85e8b4cf23b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -70,6 +70,9 @@
 #define MT7615_MAX_SCHED_SCAN_SSID	10
 #define MT7615_MAX_SCAN_MATCH		16
 
+#define MT76_ALPHA2_TO_CC(alpha2)		\
+	(((u32)alpha2[2] << 16) | ((u32)alpha2[1] << 8) | (u32)alpha2[0])
+
 struct mt7615_vif;
 struct mt7615_sta;
 struct mt7615_dfs_pulse;
-- 
2.29.2

