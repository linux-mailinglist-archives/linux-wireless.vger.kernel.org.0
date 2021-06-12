Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C953A4EEC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFLMu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 08:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhFLMu5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 08:50:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 147F760FDA;
        Sat, 12 Jun 2021 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623502138;
        bh=YXq5N1qkcP0iXRvP+jEQieuw/3G28CkTFd+TYK1GYLI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ewrd+yxZJlgh7KxDNtwdSKMiaHLeg7dkLiicQDDcuB6XVDn8vq2IOkE/pDzBQpR3T
         r5BGVayb0fZs4EocQQDL18rZ+Baog3xaKGA+NfEAAev7aqUKJSuKWqEgLWYWztziqK
         Jh0+W7f7e/vpqeQUfkxmJauWpuilrF/zOsZPbeQmpZtr3zhrfF3CBWlbvJ/JaIed28
         iIh5MJyF6/WA9IpDY2w5f2FS++tKt9p3bf+jbbMWapYn2X+DWQq18aiYRax6dtK/6A
         JY0Som/5JK0A5Q+eVgiJupTyDkAi0TXsmutQ4sA9C213Qt6ciHCCfJ75sshq8OzP53
         oM9QWPuTw0EnA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH] mt76: mt7921: limit txpower according to userlevel power
Date:   Sat, 12 Jun 2021 14:48:48 +0200
Message-Id: <bdcb48d390e0b0768a614b8b7451849224c5a6ea.1623501997.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Limit tx power for single-sku according to userlevel power.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 28 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8fe09e7363ca..614a0e96e711 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1762,12 +1762,15 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		142, 144, 149, 151, 153, 155, 157,
 		159, 161, 165
 	};
+	int i, n_chan, batch_size, idx = 0, tx_power, last_ch;
 	struct mt76_connac_sku_tlv sku_tlbv;
-	int i, n_chan, batch_size, idx = 0;
 	struct mt76_power_limits limits;
 	const u8 *ch_list;
 
 	sku_len = is_mt7921(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
 
 	if (band == NL80211_BAND_2GHZ) {
 		n_chan = ARRAY_SIZE(chan_list_2ghz);
@@ -1778,39 +1781,48 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 	}
 	batch_size = DIV_ROUND_UP(n_chan, batch_len);
 
+	if (!phy->cap.has_5ghz)
+		last_ch = chan_list_2ghz[n_chan - 1];
+	else
+		last_ch = chan_list_5ghz[n_chan - 1];
+
 	for (i = 0; i < batch_size; i++) {
-		bool last_msg = i == batch_size - 1;
-		int num_ch = last_msg ? n_chan % batch_len : batch_len;
 		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {
 			.band = band == NL80211_BAND_2GHZ ? 1 : 2,
-			.n_chan = num_ch,
-			.last_msg = last_msg,
 		};
+		int j, err, msg_len, num_ch;
 		struct sk_buff *skb;
-		int j, err, msg_len;
 
+		num_ch = i == batch_size - 1 ? n_chan % batch_len : batch_len;
 		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
 		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
 		if (!skb)
 			return -ENOMEM;
 
+		skb_reserve(skb, sizeof(tx_power_tlv));
+
 		BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(tx_power_tlv.alpha2));
 		memcpy(tx_power_tlv.alpha2, dev->alpha2, sizeof(dev->alpha2));
+		tx_power_tlv.n_chan = num_ch;
 
-		skb_put_data(skb, &tx_power_tlv, sizeof(tx_power_tlv));
 		for (j = 0; j < num_ch; j++, idx++) {
 			struct ieee80211_channel chan = {
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
 
-			mt76_get_rate_power_limits(phy, &chan, &limits, 127);
+			mt76_get_rate_power_limits(phy, &chan, &limits,
+						   tx_power);
 
+			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
+
 			mt76_connac_mcu_build_sku(dev, sku_tlbv.pwr_limit,
 						  &limits, band);
 			skb_put_data(skb, &sku_tlbv, sku_len);
 		}
+		__skb_push(skb, sizeof(tx_power_tlv));
+		memcpy(skb->data, &tx_power_tlv, sizeof(tx_power_tlv));
 
 		err = mt76_mcu_skb_send_msg(dev, skb,
 					    MCU_CMD_SET_RATE_TX_POWER, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f062088780c2..873eecd48833 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -433,6 +433,9 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 
 	mt7921_mutex_acquire(dev);
 
+	if (changed & IEEE80211_CONF_CHANGE_POWER)
+		mt76_connac_mcu_set_rate_txpower(phy->mt76);
+
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
-- 
2.31.1

