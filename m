Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44403F5BF6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhHXKXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236216AbhHXKXq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BC46613A7;
        Tue, 24 Aug 2021 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800582;
        bh=AoXwxpJpLtJgVJkubitFPGVw4+RaDrQ5JCmv/IgjIS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oI7Mt2wPSP/+FurcZRM6q1c9EhhiYYphKt2nR4OgAuHOH5r9pqehCJ9bVVYpdsI3S
         4/rEOxk98oNxSJ3c3Q7tl2bN50Yr7CjdvQqKH5/zzvAsdtbCftF3xv/oW+EVQ2FEVr
         EF8kz0naaiNrupcChUSWIDF9XnwiW12NaMCMsFolFYBJPaK9sq//TVaQuPJxP6VCCT
         8POuc7NYcqjPpnclhqS2C4YzTOzZ0R+9D+rO34nlcT2LruSTROMPqPk/H1MVPB9c18
         NZWUKwW71eirjZ8sKNaqf/B7Q9lNkdV0HPdbD53YGJL17DrhLZVo4NG+RBGVXCEMXM
         O5Y1q3XmSsKyA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 3/9] mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
Date:   Tue, 24 Aug 2021 12:22:21 +0200
Message-Id: <16980e703a3ba35a914e93c0a9e0222bb0ea69f8.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure 6GHz channels defining mcu channel domain. This is a
preliminary patch to enable 6GHz band on mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 29 +++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8e7fedfd1758..a394ea8a1856 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -624,6 +624,7 @@ struct mt76_phy {
 	struct mt76_hw_cap cap;
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
+	struct mt76_sband sband_6g;
 
 	u8 macaddr[ETH_ALEN];
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8858a06ebd95..f5c1a7d9306e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_init_download);
 
 int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 {
-	struct mt76_dev *dev = phy->dev;
+	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0, n_6ch = 0;
 	struct mt76_connac_mcu_channel_domain {
 		u8 alpha2[4]; /* regulatory_request.alpha2 */
 		u8 bw_2g; /* BW_20_40M		0
@@ -84,25 +84,29 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 			   * BW_20_40_80_8080M	4
 			   */
 		u8 bw_5g;
-		__le16 pad;
+		u8 bw_6g;
+		u8 pad;
 		u8 n_2ch;
 		u8 n_5ch;
-		__le16 pad2;
+		u8 n_6ch;
+		u8 pad2;
 	} __packed hdr = {
 		.bw_2g = 0,
-		.bw_5g = 3,
+		.bw_5g = 3, /* BW_20_40_80_160M */
+		.bw_6g = 3,
 	};
 	struct mt76_connac_mcu_chan {
 		__le16 hw_value;
 		__le16 pad;
 		__le32 flags;
 	} __packed channel;
-	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0;
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_channel *chan;
 	struct sk_buff *skb;
 
 	n_max_channels = phy->sband_2g.sband.n_channels +
-			 phy->sband_5g.sband.n_channels;
+			 phy->sband_5g.sband.n_channels +
+			 phy->sband_6g.sband.n_channels;
 	len = sizeof(hdr) + n_max_channels * sizeof(channel);
 
 	skb = mt76_mcu_msg_alloc(dev, NULL, len);
@@ -135,11 +139,24 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 		skb_put_data(skb, &channel, sizeof(channel));
 		n_5ch++;
 	}
+	for (i = 0; i < phy->sband_6g.sband.n_channels; i++) {
+		chan = &phy->sband_6g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_6ch++;
+	}
 
 	BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(hdr.alpha2));
 	memcpy(hdr.alpha2, dev->alpha2, sizeof(dev->alpha2));
 	hdr.n_2ch = n_2ch;
 	hdr.n_5ch = n_5ch;
+	hdr.n_6ch = n_6ch;
 
 	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 
-- 
2.31.1

