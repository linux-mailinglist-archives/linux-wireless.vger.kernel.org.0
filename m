Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF434A8552
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350795AbiBCNgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 08:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiBCNgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 08:36:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31BC06173E
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z0IjQaj2tb4Q+vbfwKiEKkFu1Gf1CmuxhWWKFMF1ziw=; b=AVJQ2fWFGQSsAjvpS5dmvcQIvx
        lV1TpypaS8+uaGBoFWNBgE2J/Ip6avLMob8GoOSiPpdCEY2UTPSfUEXBj6lBGoTlOTjiDJK41dUvi
        HdChHFqlSU1meyyPTBBW0OjNKuMuwd3aTa4IQGeJL42RkffjevBn+3a858hAk8Zinl1c=;
Received: from p200300daa71e0b007cedb37d167c1481.dip0.t-ipconnect.de ([2003:da:a71e:b00:7ced:b37d:167c:1481] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFcHK-0001Et-J7
        for linux-wireless@vger.kernel.org; Thu, 03 Feb 2022 14:36:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/5] mt76: mt7615: fix/rewrite the dfs state handling logic
Date:   Thu,  3 Feb 2022 14:35:59 +0100
Message-Id: <20220203133600.92211-4-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220203133600.92211-1-nbd@nbd.name>
References: <20220203133600.92211-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Copy the updated logic from mt7915 to to fix issues in handling DFS radar
detector states

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 51 +++++++++++--------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a753c7476d31..a06dcbb8c673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -552,7 +552,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
 	mt7615_cap_dbdc_disable(dev);
-	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->mt76.test_ops = &mt7615_testmode_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2705141402c1..1b350cc1d631 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2287,44 +2287,51 @@ mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
 
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
+	enum mt76_dfs_state dfs_state, prev_state;
 	int err;
 
 	if (is_mt7663(&dev->mt76))
 		return 0;
 
-	if (dev->mt76.region == NL80211_DFS_UNSET) {
-		phy->dfs_state = -1;
-		if (phy->rdd_state)
-			goto stop;
+	prev_state = phy->mt76->dfs_state;
+	dfs_state = mt76_phy_dfs_state(phy->mt76);
 
+	if (prev_state == dfs_state)
 		return 0;
-	}
 
-	if (test_bit(MT76_SCANNING, &phy->mt76->state))
-		return 0;
-
-	if (phy->dfs_state == chandef->chan->dfs_state)
-		return 0;
+	if (prev_state == MT_DFS_STATE_UNKNOWN)
+		mt7615_dfs_stop_radar_detector(phy);
 
-	err = mt7615_dfs_init_radar_specs(phy);
-	if (err < 0) {
-		phy->dfs_state = -1;
+	if (dfs_state == MT_DFS_STATE_DISABLED)
 		goto stop;
-	}
 
-	phy->dfs_state = chandef->chan->dfs_state;
+	if (prev_state <= MT_DFS_STATE_DISABLED) {
+		err = mt7615_dfs_init_radar_specs(phy);
+		if (err < 0)
+			return err;
+
+		err = mt7615_dfs_start_radar_detector(phy);
+		if (err < 0)
+			return err;
 
-	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
-			return mt7615_dfs_start_radar_detector(phy);
+		phy->mt76->dfs_state = MT_DFS_STATE_CAC;
+	}
+
+	if (dfs_state == MT_DFS_STATE_CAC)
+		return 0;
 
-		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END, ext_phy,
-					       MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
+				      ext_phy, MT_RX_SEL0, 0);
+	if (err < 0) {
+		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+		return err;
 	}
 
+	phy->mt76->dfs_state = MT_DFS_STATE_ACTIVE;
+	return 0;
+
 stop:
 	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
 				      MT_RX_SEL0, 0);
@@ -2332,6 +2339,8 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 		return err;
 
 	mt7615_dfs_stop_radar_detector(phy);
+	phy->mt76->dfs_state = MT_DFS_STATE_DISABLED;
+
 	return 0;
 }
 
-- 
2.32.0 (Apple Git-132)

