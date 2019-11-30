Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5110DE23
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK3PbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:12 -0500
Received: from nbd.name ([46.4.11.11]:56028 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=beG1XrnMhv8btwzQ/WUIcum83LDbFzOgSnciUaRWkU4=; b=freWtY+DOHl3Cba94jZGdaXllr
        vv2tFwydOt1xPFBox0AxQOTb63PZJc2bP1IyM9B61ywOWvVKZIcXmJzEWbUu8ruZHcdzuKT5CRmqg
        AwGSn5Cmb8bQsN5dKDPxwXX8yvwRtJAkeqXV6C2X8CH2aY7d6oftlTzJIyrrXsEPHZ1k=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hq-0006hB-In
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:46 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 06593721EBD6; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/29] mt76: move txpower_conf back to driver specific structs
Date:   Sat, 30 Nov 2019 16:30:27 +0100
Message-Id: <20191130153045.28105-11-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nothing in the core uses it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 4 ++--
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 98d9653865e3..f870acbd6b87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -534,7 +534,6 @@ struct mt76_dev {
 	struct mt76_hw_cap cap;
 
 	struct mt76_rate_power rate_power;
-	int txpower_conf;
 	int txpower_cur;
 
 	enum nl80211_dfs_regions region;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 50b3bba19ddb..700ae9c12f1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -44,7 +44,7 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->mt76.txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = hw->conf.power_level * 2;
 
 		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 			mt76x0_phy_set_txpower(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 9b1ae77b8fd2..0a10d1ee7553 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -848,7 +848,7 @@ void mt76x0_phy_set_txpower(struct mt76x02_dev *dev)
 	mt76x0_get_power_info(dev, dev->mphy.chandef.chan, &info);
 
 	mt76x02_add_rate_power_offset(t, info);
-	mt76x02_limit_rate_power(t, dev->mt76.txpower_conf);
+	mt76x02_limit_rate_power(t, dev->txpower_conf);
 	dev->mt76.txpower_cur = mt76x02_get_max_rate_power(t);
 	mt76x02_add_rate_power_offset(t, -info);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 28572797a7a6..f00a9a6ee670 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -108,6 +108,7 @@ struct mt76x02_dev {
 
 	struct mt76x02_calibration cal;
 
+	int txpower_conf;
 	s8 target_power;
 	s8 target_power_delta[2];
 	bool enable_tpc;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 8fe21e7e0996..098792b86b73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -386,7 +386,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 		max_txpwr_adj = mt76x02_tx_get_max_txpwr_adj(dev, rate);
 	}
 
-	txpwr_adj = mt76x02_tx_get_txpwr_adj(dev, dev->mt76.txpower_conf,
+	txpwr_adj = mt76x02_tx_get_txpwr_adj(dev, dev->txpower_conf,
 					     max_txpwr_adj);
 	txwi->ctl2 = FIELD_PREP(MT_TX_PWR_ADJ, txpwr_adj);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 10466545405a..039f96877787 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -96,7 +96,7 @@ s8 mt76x02_tx_get_max_txpwr_adj(struct mt76x02_dev *dev,
 
 s8 mt76x02_tx_get_txpwr_adj(struct mt76x02_dev *dev, s8 txpwr, s8 max_txpwr_adj)
 {
-	txpwr = min_t(s8, txpwr, dev->mt76.txpower_conf);
+	txpwr = min_t(s8, txpwr, dev->txpower_conf);
 	txpwr -= (dev->target_power + dev->target_power_delta[0]);
 	txpwr = min_t(s8, txpwr, max_txpwr_adj);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index bc0ffae7adda..3f82b9cec89e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -86,14 +86,14 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->mt76.txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = hw->conf.power_level * 2;
 
 		/* convert to per-chain power for 2x2 devices */
-		dev->mt76.txpower_conf -= 6;
+		dev->txpower_conf -= 6;
 
 		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
 			mt76x2_phy_set_txpower(dev);
-			mt76x02_tx_set_txpwr_auto(dev, dev->mt76.txpower_conf);
+			mt76x02_tx_set_txpwr_auto(dev, dev->txpower_conf);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index 6d457c0dd699..58f28e4e3952 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -152,7 +152,7 @@ void mt76x2_phy_set_txpower(struct mt76x02_dev *dev)
 
 	mt76x2_get_rate_power(dev, &t, chan);
 	mt76x02_add_rate_power_offset(&t, txp.target_power + delta);
-	mt76x02_limit_rate_power(&t, dev->mt76.txpower_conf);
+	mt76x02_limit_rate_power(&t, dev->txpower_conf);
 	dev->mt76.txpower_cur = mt76x02_get_max_rate_power(&t);
 
 	base_power = mt76x2_get_min_rate_power(&t);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index e51b9d38221b..746f1a8304a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -78,10 +78,10 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		dev->mt76.txpower_conf = hw->conf.power_level * 2;
+		dev->txpower_conf = hw->conf.power_level * 2;
 
 		/* convert to per-chain power for 2x2 devices */
-		dev->mt76.txpower_conf -= 6;
+		dev->txpower_conf -= 6;
 
 		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 			mt76x2_phy_set_txpower(dev);
-- 
2.24.0

