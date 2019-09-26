Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF9BF7D8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfIZRrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:37 -0400
Received: from nbd.name ([46.4.11.11]:55240 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rA60bGR8u4HU6kcFr9xXmRBRPNRoWZEzKJE5aXlYE4w=; b=IGYFsQvICOy3hq0P4ZobR09ca4
        MUwxWQlUuhzzBNTiTJ/YJ9ym5Jdq9TgoUItxm2+tgbZfG7fUN1mjU4brael1nCgh83RqAxecIITdE
        3X96LbfOCwF0VjtcUKy7OvHGHuD36hSmznz8Kf2fSIjzoUgcp8nrK0pBqmJz4bkisV0o=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrZ-0000yb-A3
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:33 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B483269B6A83; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 13/15] mt76: mt7615: introduce mt7615_mac_wtbl_update routine
Date:   Thu, 26 Sep 2019 19:47:30 +0200
Message-Id: <20190926174732.42375-13-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce mt7615_mac_wtbl_update utility routine in order to update
WTBL update register

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 16 +++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f688390bfd3a..2e36b3289fa6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -492,6 +492,15 @@ static u32 mt7615_mac_wtbl_addr(int wcid)
 	return MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
 }
 
+bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
 void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
@@ -724,11 +733,8 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 	mt76_wr(dev, MT_WTBL_RICR0, w0);
 	mt76_wr(dev, MT_WTBL_RICR1, w1);
 
-	mt76_wr(dev, MT_WTBL_UPDATE,
-		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid->idx) |
-		MT_WTBL_UPDATE_RXINFO_UPDATE);
-
-	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
+	if (!mt7615_mac_wtbl_update(dev, wcid->idx,
+				    MT_WTBL_UPDATE_RXINFO_UPDATE))
 		return -ETIMEDOUT;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index fe084555754b..070afba63e43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -231,6 +231,7 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 }
 
 void mt7615_update_channel(struct mt76_dev *mdev);
+bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
-- 
2.17.0

