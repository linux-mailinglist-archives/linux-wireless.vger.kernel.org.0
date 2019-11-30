Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC910DE18
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfK3PbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:00 -0500
Received: from nbd.name ([46.4.11.11]:56070 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3PGXM1q8qq0iGl/1vDedRR6vVBVWepaKW0ffoaI3ktc=; b=sfmoeLcgMOUy1JovtWLa+WU8Hc
        IwDCoiyrhB+NTpGYVHNDbSWeMqEqjwRIq46D+fE24ZdJs8Hc9z70Btvbj8gqg/iMW0JMXIbsUcysU
        1ZE7RLSAkjnclDFYPF19To/IYPQ8fpmioIclxTSOhkHjJcB4YAJPQmQhl1yEwUrkofqw=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iN-R2
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0C584721EBE8; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/29] mt76: introduce struct mt76_phy
Date:   Sat, 30 Nov 2019 16:30:18 +0100
Message-Id: <20191130153045.28105-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

On the first wiphy, hw->priv will point to struct mt76_dev, which contains a
struct mt76_phy at the start. For the secondary wiphy, hw->priv will point
to a mt76_phy encapsulated in a driver specific struct

To simplify access to struct mt76_phy members from drivers, the driver specific
device struct is changed to add a union of struct mt76_dev and struct mt76_phy
as the first element

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c      | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76.h          | 9 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       | 5 ++++-
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 17e67267f71c..39b409556083 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -274,6 +274,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 		  const struct mt76_driver_ops *drv_ops)
 {
 	struct ieee80211_hw *hw;
+	struct mt76_phy *phy;
 	struct mt76_dev *dev;
 	int i;
 
@@ -286,6 +287,10 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	dev->dev = pdev;
 	dev->drv = drv_ops;
 
+	phy = &dev->phy;
+	phy->dev = dev;
+	phy->hw = hw;
+
 	spin_lock_init(&dev->rx_lock);
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->cc_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fb077760347a..2a01d2c0445b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -449,7 +449,14 @@ struct mt76_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 };
 
+struct mt76_phy {
+	struct ieee80211_hw *hw;
+	struct mt76_dev *dev;
+};
+
 struct mt76_dev {
+	struct mt76_phy phy; /* must be first */
+
 	struct ieee80211_hw *hw;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
@@ -581,7 +588,7 @@ enum mt76_phy_type {
 #define __mt76_rmw_field(_dev, _reg, _field, _val)	\
 	__mt76_rmw(_dev, _reg, _field, FIELD_PREP(_field, _val))
 
-#define mt76_hw(dev) (dev)->mt76.hw
+#define mt76_hw(dev) (dev)->mphy.hw
 
 bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 		 int timeout);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index ab54b0612e98..63ec1fa71aba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -98,7 +98,10 @@ enum mt7603_reset_cause {
 };
 
 struct mt7603_dev {
-	struct mt76_dev mt76; /* must be first */
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
 
 	const struct mt76_bus_ops *bus_ops;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 21486831172c..85d865e832ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -80,7 +80,11 @@ struct mt7615_vif {
 };
 
 struct mt7615_dev {
-	struct mt76_dev mt76; /* must be first */
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
 	u32 vif_mask;
 	u32 omac_mask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 0ca0bbfe8769..7a44ab52fca6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -70,7 +70,10 @@ struct mt76x02_beacon_ops {
 	(dev)->beacon_ops->pre_tbtt_enable(dev, enable)
 
 struct mt76x02_dev {
-	struct mt76_dev mt76; /* must be first */
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
 
 	struct mac_address macaddr_list[8];
 
-- 
2.24.0

