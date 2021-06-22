Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D93AFE4D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhFVHuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 03:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhFVHuy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 03:50:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6FFD611BF;
        Tue, 22 Jun 2021 07:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624348119;
        bh=d9NcP3YJPo68hGHGOO01M+hZMB5wA8I2ObH6kkzcIzc=;
        h=From:To:Cc:Subject:Date:From;
        b=OQbMt2e0Ue9aV+mMRnskmTj5YU9eZNBpUsS6vGo0nsc7g1AOL0dd4FoM+MyflafO7
         dNjCoy84OYsDJmafVOnk5+xx9hIV5GXjCbOq2AfC14Hdn/7+oQCSYY1QCN8UMME7cf
         mzNLBB5UUIPMeerfN5OiW1yLaO+tDMhb4V46a1hPcr1mqmzVotMskWW03pS84QLH1C
         5sWohGo5xVT7PARgDZMB2WkWGcUPOgsQXfXEG98jAw27TZfO6Gd+9zFq1fke/aIDjJ
         xKr1M1kogmmy+U8YvRLdofJUSNvU/ETy1xg7csji5So/dxwghEiydHN1/BlIjbcpR6
         VI65loYDSfRdQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x02: fix endianness warnings in mt76x02_mac.c
Date:   Tue, 22 Jun 2021 09:48:30 +0200
Message-Id: <be88d99a9a674c697a4586c10183fe7e78bad3ab.1624348082.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt76x02_mac_write_txwi and
mt76x02_mac_tx_rate_val routines:
drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:237:19:
	warning: restricted __le16 degrades to intege
	warning: cast from restricted __le16
drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:383:28:
	warning: incorrect type in assignment (different base types)
	expected restricted __le16 [usertype] rate
	got unsigned long

Fixes: db9f11d3433f7 ("mt76: store wcid tx rate info in one u32 reduce locking")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index c32e6dc68773..07b21b208582 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -176,7 +176,7 @@ void mt76x02_mac_wcid_set_drop(struct mt76x02_dev *dev, u8 idx, bool drop)
 		mt76_wr(dev, MT_WCID_DROP(idx), (val & ~bit) | (bit * drop));
 }
 
-static __le16
+static u16
 mt76x02_mac_tx_rate_val(struct mt76x02_dev *dev,
 			const struct ieee80211_tx_rate *rate, u8 *nss_val)
 {
@@ -222,14 +222,14 @@ mt76x02_mac_tx_rate_val(struct mt76x02_dev *dev,
 		rateval |= MT_RXWI_RATE_SGI;
 
 	*nss_val = nss;
-	return cpu_to_le16(rateval);
+	return rateval;
 }
 
 void mt76x02_mac_wcid_set_rate(struct mt76x02_dev *dev, struct mt76_wcid *wcid,
 			       const struct ieee80211_tx_rate *rate)
 {
 	s8 max_txpwr_adj = mt76x02_tx_get_max_txpwr_adj(dev, rate);
-	__le16 rateval;
+	u16 rateval;
 	u32 tx_info;
 	s8 nss;
 
@@ -342,7 +342,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	u32 wcid_tx_info;
 	u16 rate_ht_mask = FIELD_PREP(MT_RXWI_RATE_PHY, BIT(1) | BIT(2));
-	u16 txwi_flags = 0;
+	u16 txwi_flags = 0, rateval;
 	u8 nss;
 	s8 txpwr_adj, max_txpwr_adj;
 	u8 ccmp_pn[8], nstreams = dev->mphy.chainmask & 0xf;
@@ -380,14 +380,15 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 
 	if (wcid && (rate->idx < 0 || !rate->count)) {
 		wcid_tx_info = wcid->tx_info;
-		txwi->rate = FIELD_GET(MT_WCID_TX_INFO_RATE, wcid_tx_info);
+		rateval = FIELD_GET(MT_WCID_TX_INFO_RATE, wcid_tx_info);
 		max_txpwr_adj = FIELD_GET(MT_WCID_TX_INFO_TXPWR_ADJ,
 					  wcid_tx_info);
 		nss = FIELD_GET(MT_WCID_TX_INFO_NSS, wcid_tx_info);
 	} else {
-		txwi->rate = mt76x02_mac_tx_rate_val(dev, rate, &nss);
+		rateval = mt76x02_mac_tx_rate_val(dev, rate, &nss);
 		max_txpwr_adj = mt76x02_tx_get_max_txpwr_adj(dev, rate);
 	}
+	txwi->rate = cpu_to_le16(rateval);
 
 	txpwr_adj = mt76x02_tx_get_txpwr_adj(dev, dev->txpower_conf,
 					     max_txpwr_adj);
-- 
2.31.1

