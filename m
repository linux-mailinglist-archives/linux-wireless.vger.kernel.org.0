Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E574A7DEF6F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbjKBKD4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346100AbjKBKDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1B139
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 03:03:44 -0700 (PDT)
X-UUID: 12e7fbb6796711ee8051498923ad61e6-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZW7oytBfEYIFtb17a2KbJQzgKcLYXCVLnxcs+UWC8N4=;
        b=b7mgaGJZIt+Hz1hvfSM7BZC9RxY99rVCV9Avcmtnb9joaVoL/n+eWQyGz6n6i3BVcU1B3zRmWJ5ADNUtGJtZenid3yfa8I54PuCDDxjlBG2sq3saeq6JuImInIUrsuS729dNh/6U/gZFbO79R2pJgGEGojrdREIsp75ig2ojpts=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c3f6a4b9-ef85-4cd4-8283-8d0fbf76d20d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:bdc03172-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 12e7fbb6796711ee8051498923ad61e6-20231102
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 42095070; Thu, 02 Nov 2023 18:03:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 18:03:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 18:03:27 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Allen Ye <allen.ye@mediatek.com>
Subject: [PATCH 1/8] wifi: mt76: change txpower init to per-phy
Date:   Thu, 2 Nov 2023 18:02:55 +0800
Message-ID: <20231102100302.22160-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.745100-8.000000
X-TMASE-MatchedRID: fEgilWoYZ6y4TtpEqCKkMna57ruHAnHxTJDl9FKHbrkAhmnHHeGnvSKI
        UiL7FC/vZUOuMOrkDQqDtDBADBIVrkKtkjlYA82dh2VzUlo4HVPljSRvSGpq3Ezgq++3Q0pHZiu
        ZFcXDg1xYHxG6vTRI6qu1MB/hHvTafMalxiFMN0q+dJWHbg4ITrn7V+KB+3cumyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1GpeevGsoI5cryI+9SRfDcN+Eh/0rLvStkJWU+NqlpaYDjO5RP6xeRKAjM
        iFdEUCtEbic1EEgxMuIyHEsyEgDMsZKR2bOXB8HRp4gvWprmK0XRoPmWO3jekxwdkPqCq7vDEyN
        +J8hd+jCS9WgDXVPCn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.745100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 491AC7AE080333C55E5AEE923BF1FD9DC821E69CA3CFD2FD98E699EC5A477C512000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use per-phy structure for maximum txpower value initializing, since each
phy may have a different chainmask, which can impact the calculation of
power gain.

Co-developed-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 30 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  4 +--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 30 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  6 ++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 6 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 81478289f17e..cea2f6d9050a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -275,10 +275,11 @@ static void mt7915_led_set_brightness(struct led_classdev *led_cdev,
 		mt7915_led_set_config(led_cdev, 0xff, 0);
 }
 
-void mt7915_init_txpower(struct mt7915_dev *dev,
-			 struct ieee80211_supported_band *sband)
+static void __mt7915_init_txpower(struct mt7915_phy *phy,
+				  struct ieee80211_supported_band *sband)
 {
-	int i, n_chains = hweight8(dev->mphy.antenna_mask);
+	struct mt7915_dev *dev = phy->dev;
+	int i, n_chains = hweight16(phy->mt76->chainmask);
 	int nss_delta = mt76_tx_power_nss_delta(n_chains);
 	int pwr_delta = mt7915_eeprom_get_power_delta(dev, sband->band);
 	struct mt76_power_limits limits;
@@ -296,7 +297,7 @@ void mt7915_init_txpower(struct mt7915_dev *dev,
 		}
 
 		target_power += pwr_delta;
-		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
 							  &limits,
 							  target_power);
 		target_power += nss_delta;
@@ -307,6 +308,19 @@ void mt7915_init_txpower(struct mt7915_dev *dev,
 	}
 }
 
+void mt7915_init_txpower(struct mt7915_phy *phy)
+{
+	if (!phy)
+		return;
+
+	if (phy->mt76->cap.has_2ghz)
+		__mt7915_init_txpower(phy, &phy->mt76->sband_2g.sband);
+	if (phy->mt76->cap.has_5ghz)
+		__mt7915_init_txpower(phy, &phy->mt76->sband_5g.sband);
+	if (phy->mt76->cap.has_6ghz)
+		__mt7915_init_txpower(phy, &phy->mt76->sband_6g.sband);
+}
+
 static void
 mt7915_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
@@ -322,9 +336,7 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	if (dev->mt76.region == NL80211_DFS_UNSET)
 		mt7915_mcu_rdd_background_enable(phy, NULL);
 
-	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
-	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
-	mt7915_init_txpower(dev, &mphy->sband_6g.sband);
+	mt7915_init_txpower(phy);
 
 	mphy->dfs_state = MT_DFS_STATE_UNKNOWN;
 	mt7915_dfs_init_radar_detector(phy);
@@ -442,6 +454,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
 	mt7915_set_stream_he_caps(phy);
+	mt7915_init_txpower(phy);
 
 	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
 	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
@@ -703,9 +716,6 @@ static void mt7915_init_work(struct work_struct *work)
 
 	mt7915_mcu_set_eeprom(dev);
 	mt7915_mac_init(dev);
-	mt7915_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7915_init_txpower(dev, &dev->mphy.sband_5g.sband);
-	mt7915_init_txpower(dev, &dev->mphy.sband_6g.sband);
 	mt7915_txbf_init(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2222fb9aa103..ac6c086b1a9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1401,8 +1401,8 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 		goto out;
 
 	mt7915_mac_init(dev);
-	mt7915_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7915_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	mt7915_init_txpower(&dev->phy);
+	mt7915_init_txpower(phy2);
 	ret = mt7915_txbf_init(dev);
 
 	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index d317c523b23f..4727d9c7b11d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -425,8 +425,7 @@ void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force);
 int mt7915_dma_start(struct mt7915_dev *dev, bool reset, bool wed_reset);
 int mt7915_txbf_init(struct mt7915_dev *dev);
-void mt7915_init_txpower(struct mt7915_dev *dev,
-			 struct ieee80211_supported_band *sband);
+void mt7915_init_txpower(struct mt7915_phy *phy);
 void mt7915_reset(struct mt7915_dev *dev);
 int mt7915_run(struct ieee80211_hw *hw);
 int mt7915_mcu_init(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 6a03cddaed04..1896571ad140 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -288,10 +288,11 @@ static void mt7996_led_set_brightness(struct led_classdev *led_cdev,
 		mt7996_led_set_config(led_cdev, 0xff, 0);
 }
 
-void mt7996_init_txpower(struct mt7996_dev *dev,
-			 struct ieee80211_supported_band *sband)
+static void __mt7996_init_txpower(struct mt7996_phy *phy,
+				  struct ieee80211_supported_band *sband)
 {
-	int i, nss = hweight8(dev->mphy.antenna_mask);
+	struct mt7996_dev *dev = phy->dev;
+	int i, nss = hweight16(phy->mt76->chainmask);
 	int nss_delta = mt76_tx_power_nss_delta(nss);
 	int pwr_delta = mt7996_eeprom_get_power_delta(dev, sband->band);
 	struct mt76_power_limits limits;
@@ -301,7 +302,7 @@ void mt7996_init_txpower(struct mt7996_dev *dev,
 		int target_power = mt7996_eeprom_get_target_power(dev, chan);
 
 		target_power += pwr_delta;
-		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
 							  &limits,
 							  target_power);
 		target_power += nss_delta;
@@ -312,6 +313,19 @@ void mt7996_init_txpower(struct mt7996_dev *dev,
 	}
 }
 
+void mt7996_init_txpower(struct mt7996_phy *phy)
+{
+	if (!phy)
+		return;
+
+	if (phy->mt76->cap.has_2ghz)
+		__mt7996_init_txpower(phy, &phy->mt76->sband_2g.sband);
+	if (phy->mt76->cap.has_5ghz)
+		__mt7996_init_txpower(phy, &phy->mt76->sband_5g.sband);
+	if (phy->mt76->cap.has_6ghz)
+		__mt7996_init_txpower(phy, &phy->mt76->sband_6g.sband);
+}
+
 static void
 mt7996_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
@@ -326,9 +340,7 @@ mt7996_regd_notifier(struct wiphy *wiphy,
 	if (dev->mt76.region == NL80211_DFS_UNSET)
 		mt7996_mcu_rdd_background_enable(phy, NULL);
 
-	mt7996_init_txpower(dev, &phy->mt76->sband_2g.sband);
-	mt7996_init_txpower(dev, &phy->mt76->sband_5g.sband);
-	mt7996_init_txpower(dev, &phy->mt76->sband_6g.sband);
+	mt7996_init_txpower(phy);
 
 	phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
 	mt7996_dfs_init_radar_detector(phy);
@@ -424,6 +436,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
+	mt7996_init_txpower(phy);
 
 	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
 	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
@@ -656,9 +669,6 @@ static void mt7996_init_work(struct work_struct *work)
 
 	mt7996_mcu_set_eeprom(dev);
 	mt7996_mac_init(dev);
-	mt7996_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7996_init_txpower(dev, &dev->mphy.sband_5g.sband);
-	mt7996_init_txpower(dev, &dev->mphy.sband_6g.sband);
 	mt7996_txbf_init(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 71ae8e263221..56dfbeb51504 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1755,9 +1755,9 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 		goto out;
 
 	mt7996_mac_init(dev);
-	mt7996_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7996_init_txpower(dev, &dev->mphy.sband_5g.sband);
-	mt7996_init_txpower(dev, &dev->mphy.sband_6g.sband);
+	mt7996_init_txpower(&dev->phy);
+	mt7996_init_txpower(phy2);
+	mt7996_init_txpower(phy3);
 	ret = mt7996_txbf_init(dev);
 
 	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0a150bcb2c19..d3eb564623ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -414,8 +414,7 @@ void mt7996_dma_cleanup(struct mt7996_dev *dev);
 void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset);
 int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx,
 			  int n_desc, int ring_base, struct mtk_wed_device *wed);
-void mt7996_init_txpower(struct mt7996_dev *dev,
-			 struct ieee80211_supported_band *sband);
+void mt7996_init_txpower(struct mt7996_phy *phy);
 int mt7996_txbf_init(struct mt7996_dev *dev);
 void mt7996_reset(struct mt7996_dev *dev);
 int mt7996_run(struct ieee80211_hw *hw);
-- 
2.39.2

