Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B392A1DAA6A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 08:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETGNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 02:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 02:13:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3CAC061A0E
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 23:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EpZDfbYXvkDsNVUhORYVfDdXZXKZSK/tI9xpHoLdSaI=; b=l7qtMW4FC8JU/WWtPHRqCvnmFS
        /1365WUAEqX+M0q/bi9SXD2q6Aevw9EJKa7HxWJHVFNbMvGmipHz727qJWk29pob4QlRvDu0pSKCq
        vQKBA/l/5kX7IgynAPpAPW2MjEVPUYwEnfqJKn48sG3Sf2wCPcTFXTMJwVmZtauVwMno=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jbHz5-0004wY-Cb; Wed, 20 May 2020 08:13:43 +0200
Received: by maeck.local (Postfix, from userid 501)
        id DC6DE872A409; Wed, 20 May 2020 08:13:42 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
Subject: [PATCH] mt76: fix per-driver wcid range checks after wcid array size bump
Date:   Wed, 20 May 2020 08:13:42 +0200
Message-Id: <20200520061342.62906-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All drivers before MT7915 have a limit of 128 WCID entries. Stop relying
on ARRAY_SIZE(dev->mt76.wcid), since it no longer reflects that limit.

Fixes: 49e649c3e0a6 ("mt76: adjust wcid size to support new 802.11ax generation")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02.h      | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index f8c0c957ca01..0f205ffe4905 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -473,7 +473,7 @@ mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 	struct mt7603_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+	if (idx >= MT7603_WTBL_SIZE)
 		return NULL;
 
 	wcid = rcu_dereference(dev->mt76.wcid[idx]);
@@ -1238,7 +1238,7 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
 
-	if (wcidx >= ARRAY_SIZE(dev->mt76.wcid))
+	if (wcidx >= MT7603_WTBL_SIZE)
 		return;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6b5c38ab9f5d..f1009c92ec1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -61,7 +61,7 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	struct mt7615_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+	if (idx >= MT7615_WTBL_SIZE)
 		return NULL;
 
 	wcid = rcu_dereference(dev->mt76.wcid[idx]);
@@ -1303,7 +1303,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
 
-	if (wcidx >= ARRAY_SIZE(dev->mt76.wcid))
+	if (wcidx >= MT7615_WTBL_SIZE)
 		return;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 6ea210bd3f07..4c9bbc7ce023 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -15,6 +15,7 @@
 #include "mt76x02_dfs.h"
 #include "mt76x02_dma.h"
 
+#define MT76x02_N_WCIDS 128
 #define MT_CALIBRATE_INTERVAL	HZ
 #define MT_MAC_WORK_INTERVAL	(HZ / 10)
 
@@ -246,7 +247,7 @@ mt76x02_rx_get_sta(struct mt76_dev *dev, u8 idx)
 {
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->wcid))
+	if (idx >= MT76x02_N_WCIDS)
 		return NULL;
 
 	wcid = rcu_dereference(dev->wcid[idx]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index a5a3bcd30d6f..e4e03beabe43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -561,7 +561,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	rcu_read_lock();
 
-	if (stat->wcid < ARRAY_SIZE(dev->mt76.wcid))
+	if (stat->wcid < MT76x02_N_WCIDS)
 		wcid = rcu_dereference(dev->mt76.wcid[stat->wcid]);
 
 	if (wcid && wcid->sta) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7e389dbccfeb..18adedfbbb8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -415,7 +415,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 	ieee80211_iter_keys_rcu(dev->mt76.hw, NULL, mt76x02_key_sync, NULL);
 	rcu_read_unlock();
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.wcid); i++) {
+	for (i = 0; i < MT76x02_N_WCIDS; i++) {
 		struct ieee80211_sta *sta;
 		struct ieee80211_vif *vif;
 		struct mt76x02_sta *msta;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 9a2c9afa2fb5..44822a849eb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -249,7 +249,7 @@ int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	memset(msta, 0, sizeof(*msta));
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, ARRAY_SIZE(dev->mt76.wcid));
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT76x02_N_WCIDS);
 	if (idx < 0)
 		return -ENOSPC;
 
-- 
2.24.0

