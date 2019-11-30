Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7A10DE20
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfK3PbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:09 -0500
Received: from nbd.name ([46.4.11.11]:56030 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cpKpPx5M3OPk2FzU0fWLRScfIUbiOPAbcxIzpFkCKm8=; b=s3iSCY+Qar7FhngvN9+8l2ZGNh
        765qdmyiIspI0C93aQASbI6uQdD5tuwmw1fDSp+4z4kOeFKMQAh5iwtYQGeTpYPbV6Uvx967je7Gb
        EfX7Z/PCqucwhSMhWBv76IR/ipsDSSenOSVRfoyGlsupn4ZbG7byU3aNPFroKULKqSvo=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hq-0006hD-Ig
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:46 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 01242721EBD3; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 13/29] mt76: add multiple wiphy support to mt76_get_min_avg_rssi
Date:   Sat, 30 Nov 2019 16:30:29 +0100
Message-Id: <20191130153045.28105-13-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow tracking clients of both wiphys separately

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c | 2 +-
 drivers/net/wireless/mediatek/mt76/util.c       | 8 ++++++--
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 97baa92242fa..91a3acf57d12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -793,7 +793,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 
-int mt76_get_min_avg_rssi(struct mt76_dev *dev);
+int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8cf6c430ef67..ab9ac6e07159 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1737,7 +1737,7 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 
 	mt7603_cca_stats_reset(dev);
 
-	min_signal = mt76_get_min_avg_rssi(&dev->mt76);
+	min_signal = mt76_get_min_avg_rssi(&dev->mt76, false);
 	if (!min_signal) {
 		dev->sensitivity = 0;
 		dev->last_cca_adj = jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 581cbf52482c..38abb3dab549 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1266,7 +1266,7 @@ mt7615_mac_adjust_sensitivity(struct mt7615_dev *dev,
 	int signal;
 
 	sensitivity = ofdm ? &dev->ofdm_sensitivity : &dev->cck_sensitivity;
-	signal = mt76_get_min_avg_rssi(&dev->mt76);
+	signal = mt76_get_min_avg_rssi(&dev->mt76, false);
 	if (!signal) {
 		mt7615_mac_set_default_sensitivity(dev);
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index cc28ad03155d..b56397c05218 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -1069,7 +1069,7 @@ mt76x0_phy_update_channel_gain(struct mt76x02_dev *dev)
 	u8 gain_delta;
 	int low_gain;
 
-	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76);
+	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, false);
 	if (!dev->cal.avg_rssi_all)
 		dev->cal.avg_rssi_all = -75;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index 91ab25c7d5ba..ed2dcb05d614 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -280,7 +280,7 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 	int low_gain;
 	u32 val;
 
-	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76);
+	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, false);
 	if (!dev->cal.avg_rssi_all)
 		dev->cal.avg_rssi_all = -75;
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 23d1e1da78b2..8c60c450125a 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -64,7 +64,7 @@ int mt76_wcid_alloc(unsigned long *mask, int size)
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
 
-int mt76_get_min_avg_rssi(struct mt76_dev *dev)
+int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
 {
 	struct mt76_wcid *wcid;
 	int i, j, min_rssi = 0;
@@ -75,14 +75,18 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(dev->wcid_mask); i++) {
 		unsigned long mask = dev->wcid_mask[i];
+		unsigned long phy_mask = dev->wcid_phy_mask[i];
 
 		if (!mask)
 			continue;
 
-		for (j = i * BITS_PER_LONG; mask; j++, mask >>= 1) {
+		for (j = i * BITS_PER_LONG; mask; j++, mask >>= 1, phy_mask >>= 1) {
 			if (!(mask & 1))
 				continue;
 
+			if (!!(phy_mask & 1) != ext_phy)
+				continue;
+
 			wcid = rcu_dereference(dev->wcid[j]);
 			if (!wcid)
 				continue;
-- 
2.24.0

