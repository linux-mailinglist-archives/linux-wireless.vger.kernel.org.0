Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DC36C24F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhD0KIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 06:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhD0KIM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 06:08:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3101261185;
        Tue, 27 Apr 2021 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619518049;
        bh=0d1JpXnWyX0R8um8HKYIUleR61gtqO3NpAoCzGis7VY=;
        h=From:To:Cc:Subject:Date:From;
        b=sH4TZdEr5n+tUYL0/naTbWObz/AdhLvyEPkgmakYzdJV3kX3JKfxYcb8cYTW3zz0W
         /USi92npG0TvCF0JJy3kMfFnj9d3QoQAGvfVf20TEopTd0+w3OFuQ8IWshkQIP+gzl
         m+7OmPk86fDLZd43q92e/EcKmVNSUDcPwsaJO/8Ac0ZCF8KlPzHNaFXMb114ADMoVc
         gKt9ibGJuWcMVteP4+WZSpJppd19NDzuqVAC5tVSQqQuhLWzt+pOWUHQGVhcIoPUMv
         X3q7GJ8zPecXBGckEq/BBwLu/C6xKtTkHb7VVxc3GQfw6h1APGxD1qsN1CEgox9mrL
         dluHF7gF3P3Bw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: fix NULL pointer dereference in tx_prepare_skb()
Date:   Tue, 27 Apr 2021 12:07:14 +0200
Message-Id: <72567c35a07247d427f7e82afa93ace83c2f93ef.1619517975.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix theoretical NULL pointer dereference in mt7615_tx_prepare_skb and
mt7663_usb_sdio_tx_prepare_skb routines. This issue has been identified
by code analysis.

Fixes: 6aa4ed7927f11 ("mt76: mt7615: implement DMA support for MT7622")
Fixes: 4bb586bc33b98 ("mt76: mt7663u: sync probe sampling with rate configuration")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index d7cbef752f9f..cc278d8cb888 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -131,20 +131,21 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct mt76_tx_info *tx_info)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	int pid, id;
 	u8 *txwi = (u8 *)txwi_ptr;
 	struct mt76_txwi_cache *t;
+	struct mt7615_sta *msta;
 	void *txp;
 
+	msta = wcid ? container_of(wcid, struct mt7615_sta, wcid) : NULL;
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
+	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && msta) {
 		struct mt7615_phy *phy = &dev->phy;
 
 		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index f8d3673c2cae..7010101f6b14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -191,14 +191,15 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   struct ieee80211_sta *sta,
 				   struct mt76_tx_info *tx_info)
 {
-	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct sk_buff *skb = tx_info->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mt7615_sta *msta;
 	int pad;
 
+	msta = wcid ? container_of(wcid, struct mt7615_sta, wcid) : NULL;
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
-	    !msta->rate_probe) {
+	    msta && !msta->rate_probe) {
 		/* request to configure sampling rate */
 		spin_lock_bh(&dev->mt76.lock);
 		mt7615_mac_set_rates(&dev->phy, msta, &info->control.rates[0],
-- 
2.30.2

