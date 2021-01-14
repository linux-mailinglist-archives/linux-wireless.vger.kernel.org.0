Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980DA2F64E9
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbhANPjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 10:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbhANPjm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 10:39:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98BFD23B3E;
        Thu, 14 Jan 2021 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610638741;
        bh=PjNW5jHBxFgj7E+6DUtX+IcHYAuH7mJGmOt3zUfI3kI=;
        h=From:To:Cc:Subject:Date:From;
        b=QL+RJs/C7mSyf2jKhktNgUIyxQeutjXDhbYpr9JkUotI3zDiXM9GkzS2n5nZJz5+a
         7p5k2UgQ4HppgyvXAauKWv1RyEw9tP8ckZ1+Wi6SYESOoH666JUJkB/y+WW+CpbO7Z
         09z/T9RiwuDLHcpo3CWvSMr+0Em9tmhpKzf3a8f8xOO1wWHZu8ypGe+W3ngdKH91mM
         7Oiksbtkqwhiq0SHi6/9exaGW5VKRtp/0dsGxq9bgrSaFKcAfivvLGZQeObxBOfDE+
         3i2A0ZlMVSzONKdPPP4ub2bHYzqlKPm6iLtCwa5+pW/80Yw9bUpH2RjfcfBHuk75YL
         7obVrFrQPRqGg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2] mt76: mt7615: set mcu country code in mt7615_mcu_set_channel_domain()
Date:   Thu, 14 Jan 2021 16:38:55 +0100
Message-Id: <0ab62947a94ff5571dc3491340a3c6f178fa5f14.1610627297.git.lorenzo@kernel.org>
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
Changes since v1:
- directly memcpy alpha2 domain in the mcu message
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 10 ++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 46 +++++++++++++------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 598c09b9b8f6..7a7776f38f44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -656,6 +656,7 @@ struct mt76_dev {
 
 	struct mt76_rate_power rate_power;
 
+	char alpha2[3];
 	enum nl80211_dfs_regions region;
 
 	u32 debugfs_reg;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 8151c1d60728..7e81ec53bd84 100644
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
index c377860e220f..ebc0eeda9658 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2982,7 +2982,7 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 	struct mt76_phy *mphy = phy->mt76;
 	struct mt7615_dev *dev = phy->dev;
 	struct mt7615_mcu_channel_domain {
-		__le32 country_code; /* regulatory_request.alpha2 */
+		u8 alpha2[4]; /* regulatory_request.alpha2 */
 		u8 bw_2g; /* BW_20_40M		0
 			   * BW_20M		1
 			   * BW_20_40_80M	2
@@ -2997,43 +2997,61 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 	} __packed hdr = {
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
 
+	BUILD_BUG_ON(sizeof(dev->mt76.alpha2) > sizeof(hdr.alpha2));
+	memcpy(hdr.alpha2, dev->mt76.alpha2, sizeof(dev->mt76.alpha2));
+	hdr.n_2ch = n_2ch;
+	hdr.n_5ch = n_5ch;
+
+	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
 				     false);
 }
-- 
2.29.2

