Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911A3ADB48
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhFSSUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 14:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhFSSUh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 14:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51CB6610CD;
        Sat, 19 Jun 2021 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624126706;
        bh=sHJ5jxGRoxIVeEewlhvtETKOo2nJHVNCWuXeraCxlrY=;
        h=From:To:Cc:Subject:Date:From;
        b=VkxtyIIXw8TCKdZfzQbNrO5bBGVwLvuJPG+G5OJIwu5m1Ng7Z/l9JRUqk9jOG11kJ
         3VprDVy92Xb7+9MzQa84tQv5Rn4BUREj0wZUahWcrqbxgB4s4eNs50RHVjAvA37w8o
         sHTdvJ+I2SGsfwPDz3cDlO0D2EGK3GnaasyHpRy0QbQx+UI2PE4TaVYcre2xQIlNwu
         eUUADOJQl47ak4Lm/2hfrDG4oi8goqRmPPpMzLnrimO2uY2E3sBNmQCzXirlwAgeVN
         wkX5wm1AlapwGxDfPD8uTMpe6UxXuMsFqif19vKrxPwiQz4Fg2d1Iza9m3B2ksXcuE
         pRu9FQvUeV+4Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: fix endianness in mt7921_mcu_tx_done_event
Date:   Sat, 19 Jun 2021 20:18:19 +0200
Message-Id: <948d3572e324c82c80259279264651998da56232.1624126593.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix endianness in mt7921_mcu_tx_done_event event reported by the
firmware.

Fixes: 3cce2b98e0241 ("mt76: mt7921: introduce mac tx done handling")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c2c4dc196802..1819de869fdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -532,7 +532,8 @@ mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		peer.g8 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
 		peer.g16 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
 		mt7921_mcu_tx_rate_parse(mphy->mt76, &peer,
-					 &msta->stats.tx_rate, event->tx_rate);
+					 &msta->stats.tx_rate,
+					 le16_to_cpu(event->tx_rate));
 
 		spin_lock_bh(&dev->sta_poll_lock);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index d76cf8f8dfdf..d142c50c1a3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -295,11 +295,11 @@ struct mt7921_txpwr_event {
 struct mt7921_mcu_tx_done_event {
 	u8 pid;
 	u8 status;
-	u16 seq;
+	__le16 seq;
 
 	u8 wlan_idx;
 	u8 tx_cnt;
-	u16 tx_rate;
+	__le16 tx_rate;
 
 	u8 flag;
 	u8 tid;
@@ -311,9 +311,9 @@ struct mt7921_mcu_tx_done_event {
 	u8 reason;
 	u8 rsv0[1];
 
-	u32 delay;
-	u32 timestamp;
-	u32 applied_flag;
+	__le32 delay;
+	__le32 timestamp;
+	__le32 applied_flag;
 
 	u8 txs[28];
 
-- 
2.31.1

