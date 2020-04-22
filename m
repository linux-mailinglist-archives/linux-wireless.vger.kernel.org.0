Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634781B42CE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDVLH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 07:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgDVLH7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 07:07:59 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8962B2076E;
        Wed, 22 Apr 2020 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587553678;
        bh=ZEPR/VQvyg7OiZedkRLfWOrSsyS7UfjXMLTZZoPa4zA=;
        h=From:To:Cc:Subject:Date:From;
        b=WwD1fE0QKC9LcCn6dMDR/WMmsm9EZzObNRi5HV//paumvNGR8vSPrVdSnlc+lJGtA
         2tbMHUuJpqM84UQi9B79Xm/jHfqvYZIuAD5bj0na5iX2eec7uCXDvUNRuVYH0t5WcW
         6Q8fdsTpcy910/bYmWPAJkszmL2E01zNa/yICcec=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: move mcu bss upload before creating the sta
Date:   Wed, 22 Apr 2020 13:07:44 +0200
Message-Id: <5b69c9f19314643eeb6e0ac061af4ca21aab9802.1587551460.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt7615_mcu_add_bss_info routine before mt7615_mcu_sta_add since
the firmware requires the bss is created before the relative sta

Tested-by: Sean Wang <sean.wang@mediatek.com>
Suggested-by: YF Luo <yf.luo@mediatek.com>
Suggested-by: Lucy Hsu <lucy.hsu@mediatek.com>
Co-developed-by: Soul Huang <soul.huang@mediatek.com>
Signed-off-by: Soul Huang <soul.huang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8f8ad632d6ba..3c35b8d0489c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -491,9 +491,6 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (changed & BSS_CHANGED_ASSOC)
-		mt7615_mcu_add_bss_info(phy, vif, info->assoc);
-
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
 
@@ -545,9 +542,14 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.ext_phy = mvif->band_idx;
 
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt7615_phy *phy;
+
+		phy = mvif->band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+		mt7615_mcu_add_bss_info(phy, vif, true);
+	}
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-
 	mt7615_mcu_sta_add(dev, vif, sta, true);
 
 	return 0;
@@ -563,6 +565,13 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7615_mcu_sta_add(dev, vif, sta, false);
 	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+		struct mt7615_phy *phy;
+
+		phy = mvif->band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+		mt7615_mcu_add_bss_info(phy, vif, false);
+	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
-- 
2.25.3

