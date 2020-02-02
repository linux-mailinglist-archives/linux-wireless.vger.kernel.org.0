Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4114FECF
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2020 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBSwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Feb 2020 13:52:11 -0500
Received: from nbd.name ([46.4.11.11]:35598 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgBBSwL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Feb 2020 13:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CcngjrDQ9ytK0uU7zvhoLsLpGBN8JYCvqR5FHGlJYIQ=; b=s1DfTPGtCpLgWr4J3k3TbjERGU
        vTDkQgtt0sdQH6rurH5LF6OrDYCAHCLz/D1tbFdoKkYH1xWtJoM0gCWOprR9x/G/OpF+waPWpmKxI
        Zem8JOWHy/lL0P+2fC5T3+Gvr+XQ8aeHXVfy8xoj1w0i4/S5BPvLdB/0j7uz9g67p4do=;
Received: from [81.95.5.35] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iyKLp-0003Ha-It
        for linux-wireless@vger.kernel.org; Sun, 02 Feb 2020 19:52:09 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 1230B7B1886F; Sun,  2 Feb 2020 19:52:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7615: fix monitor mode on second PHY
Date:   Sun,  2 Feb 2020 19:52:08 +0100
Message-Id: <20200202185208.28026-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202185208.28026-1-nbd@nbd.name>
References: <20200202185208.28026-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The second PHY receives no packets unless there is an active vif present.
Set the WANT_MONITOR_VIF flag to deal with that

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e7f251957fca..4c9f52e04bb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -415,6 +415,9 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->sband_2g.sband.n_channels = 0;
 	mphy->hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 
+	/* The second interface does not get any packets unless it has a vif */
+	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
+
 	ret = mt76_register_phy(mphy);
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 20184f6ffc62..7f9aa84388fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -177,9 +177,11 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
-	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-	mtxq->wcid = &mvif->sta.wcid;
-	mt76_txq_init(&dev->mt76, vif->txq);
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = &mvif->sta.wcid;
+		mt76_txq_init(&dev->mt76, vif->txq);
+	}
 
 out:
 	mutex_unlock(&dev->mt76.mutex);
@@ -201,7 +203,8 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt7615_mcu_set_dev_info(dev, vif, 0);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
-	mt76_txq_remove(&dev->mt76, vif->txq);
+	if (vif->txq)
+		mt76_txq_remove(&dev->mt76, vif->txq);
 
 	mutex_lock(&dev->mt76.mutex);
 	dev->vif_mask &= ~BIT(mvif->idx);
-- 
2.24.0

