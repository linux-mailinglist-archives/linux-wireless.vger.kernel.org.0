Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D8213622
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGCIQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgGCIQu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:50 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3670920826;
        Fri,  3 Jul 2020 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764209;
        bh=fxijEvzRHz5bQaHcvkUcNOes0roKuYRxsT5sogrW3yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bj/7+jOPWnPo4sXnk6DkbumDHT2HCfYIr0ssG+8XKIVr+0hOU7CF3ymjWJs3nKyzj
         zkLmPS6/RiR++9rGh5LFGusUdJZjix+QScBY/ttSTbyGod7VI/D3r/5VYTbxMFgInI
         iIHJb5jTaK0Hy4Iu3f0pxqBEsN2+fcjuguBITym4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 16/22] mt76: mt7615: run mt7615_pm_wake in mt7615_mac_sta_{add,remove}
Date:   Fri,  3 Jul 2020 10:15:55 +0200
Message-Id: <e95afc8730648c80d4f633165e71a8b6c242e537.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt7615_pm_wake()/mt7615_pm_power_save_sched() directly in order to
wake the device from low power state in mt7615_mac_sta_{add,remove}
since they run holding mt76 mutex in common mt76 code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 57d5e3aa9439..de4230b2d7bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -583,7 +583,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	int idx;
+	int idx, err;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
 	if (idx < 0)
@@ -595,6 +595,10 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.ext_phy = mvif->band_idx;
 
+	err = mt7615_pm_wake(dev);
+	if (err)
+		return err;
+
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		struct mt7615_phy *phy;
 
@@ -605,6 +609,8 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	mt7615_mcu_sta_add(dev, vif, sta, true);
 
+	mt7615_pm_power_save_sched(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_sta_add);
@@ -616,6 +622,7 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 
 	mt7615_free_pending_tx_skbs(dev, msta);
+	mt7615_pm_wake(dev);
 
 	mt7615_mcu_sta_add(dev, vif, sta, false);
 	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
@@ -632,6 +639,8 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt7615_pm_power_save_sched(dev);
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_sta_remove);
 
-- 
2.26.2

