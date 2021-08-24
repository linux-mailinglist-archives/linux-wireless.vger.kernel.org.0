Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2943F5BF7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHXKXs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236232AbhHXKXr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AE316127B;
        Tue, 24 Aug 2021 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800584;
        bh=NWEDq2hoY5PcY5jaCuKwtpYsxVSsHWuwH7OubOY4F7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx1j7F3KLUBb8xkJFbtQIdKqgG/wzNEOh6lIiQldvwtPNNH9jTeroo+wc6p02UeZJ
         yFkTDh5w0vuKWebsNhfLz/DfnUOgGNnjtZlIfI1v2rOr/O63KoWd9W579EFtdIJZua
         6TPiBRuYWyvA9UJ/2YvVfxlkQjWRVYBJhicQBz+a6Egae8JeHRDZB96WvAcXUrFXiG
         rBssCZ5rTx3mfTxOCtS40vlQWWV55vygaCSUz/LsjCtOUYr9RTclug9hH4XINXYT6M
         IvHrF01X7jMds2dfMwGibyRMpJn7lHreD/G/nmDknocsHxHbhUhZC8db5C+axt9aVP
         8QmWeNHZ0XmBg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 4/9] mt76: connac: set 6G phymode in single-sku support
Date:   Tue, 24 Aug 2021 12:22:22 +0200
Message-Id: <a0c4e863065eca90f15e9d69c829b66baad2d66a.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure tx rate power for 6GHz channels. This is a preliminary patch
to enable 6GHz band for mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c   |  3 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 48 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 3b47e85e95e7..376c3bd883e5 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -285,6 +285,9 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 	case NL80211_BAND_5GHZ:
 		band = '5';
 		break;
+	case NL80211_BAND_6GHZ:
+		band = '6';
+		break;
 	default:
 		return target_power;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f5c1a7d9306e..8e1475aa35ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1839,6 +1839,9 @@ static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
 	case NL80211_BAND_5GHZ:
 		sband = &phy->sband_5g.sband;
 		break;
+	case NL80211_BAND_6GHZ:
+		sband = &phy->sband_6g.sband;
+		break;
 	default:
 		return target_power;
 	}
@@ -1880,6 +1883,24 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		142, 144, 149, 151, 153, 155, 157,
 		159, 161, 165
 	};
+	static const u8 chan_list_6ghz[] = {
+		  1,   3,   5,   7,   9,  11,  13,
+		 15,  17,  19,  21,  23,  25,  27,
+		 29,  33,  35,  37,  39,  41,  43,
+		 45,  47,  49,  51,  53,  55,  57,
+		 59,  61,  65,  67,  69,  71,  73,
+		 75,  77,  79,  81,  83,  85,  87,
+		 89,  91,  93,  97,  99, 101, 103,
+		105, 107, 109, 111, 113, 115, 117,
+		119, 121, 123, 125, 129, 131, 133,
+		135, 137, 139, 141, 143, 145, 147,
+		149, 151, 153, 155, 157, 161, 163,
+		165, 167, 169, 171, 173, 175, 177,
+		179, 181, 183, 185, 187, 189, 193,
+		195, 197, 199, 201, 203, 205, 207,
+		209, 211, 213, 215, 217, 219, 221,
+		225, 227, 229, 233
+	};
 	int i, n_chan, batch_size, idx = 0, tx_power, last_ch;
 	struct mt76_connac_sku_tlv sku_tlbv;
 	struct mt76_power_limits limits;
@@ -1893,6 +1914,9 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 	if (band == NL80211_BAND_2GHZ) {
 		n_chan = ARRAY_SIZE(chan_list_2ghz);
 		ch_list = chan_list_2ghz;
+	} else if (band == NL80211_BAND_6GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_6ghz);
+		ch_list = chan_list_6ghz;
 	} else {
 		n_chan = ARRAY_SIZE(chan_list_5ghz);
 		ch_list = chan_list_5ghz;
@@ -1901,13 +1925,13 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 
 	if (!phy->cap.has_5ghz)
 		last_ch = chan_list_2ghz[n_chan - 1];
+	else if (phy->cap.has_6ghz)
+		last_ch = chan_list_6ghz[n_chan - 1];
 	else
 		last_ch = chan_list_5ghz[n_chan - 1];
 
 	for (i = 0; i < batch_size; i++) {
-		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {
-			.band = band == NL80211_BAND_2GHZ ? 1 : 2,
-		};
+		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {};
 		int j, err, msg_len, num_ch;
 		struct sk_buff *skb;
 
@@ -1923,6 +1947,18 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		memcpy(tx_power_tlv.alpha2, dev->alpha2, sizeof(dev->alpha2));
 		tx_power_tlv.n_chan = num_ch;
 
+		switch (band) {
+		case NL80211_BAND_2GHZ:
+			tx_power_tlv.band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			tx_power_tlv.band = 3;
+			break;
+		default:
+			tx_power_tlv.band = 2;
+			break;
+		}
+
 		for (j = 0; j < num_ch; j++, idx++) {
 			struct ieee80211_channel chan = {
 				.hw_value = ch_list[idx],
@@ -1973,6 +2009,12 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
 		if (err < 0)
 			return err;
 	}
+	if (phy->cap.has_6ghz) {
+		err = mt76_connac_mcu_rate_txpower_band(phy,
+							NL80211_BAND_6GHZ);
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index cb36dd39221c..0f11574af535 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -964,7 +964,7 @@ struct mt76_connac_tx_power_limit_tlv {
 	__le16 len;
 	/* DW1 - cmd hint */
 	u8 n_chan; /* # channel */
-	u8 band; /* 2.4GHz - 5GHz */
+	u8 band; /* 2.4GHz - 5GHz - 6GHz */
 	u8 last_msg;
 	u8 pad1;
 	/* DW3 */
-- 
2.31.1

