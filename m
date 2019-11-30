Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC010DE19
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK3PbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:01 -0500
Received: from nbd.name ([46.4.11.11]:56064 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QkL0hHKwEU9pWAfErjoUrKx40tQxxLoqdoVZYG7V4og=; b=uXxBwzpDN6Ba7uZwiWJVmKYINd
        MuXwPXx9V5ubhLH0rSRVZ2PiCrQ8Fb2x8IuFd9cFhbADx6m2B6ePpjXgaLQSNiXisvLDNSHmvtb0D
        hBOf46A4XRXe8aBvjmjIrVcmX3w3UgZTt5OirBJds+0yTgPjh2Lss6rcU0lP/UuXjL8Y=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iM-Qn
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0C981721EBE9; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 21/29] mt76: mt7615: remove useless MT_HW_RDD0/1 enum
Date:   Sat, 30 Nov 2019 16:30:37 +0100
Message-Id: <20191130153045.28105-21-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Writing 0/1 is shorter and just as clear

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 29 ++++++++-----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 ----
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 9dcc3b26ff33..8d80aaf9723a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -257,8 +257,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 
 	mt7615_dfs_stop_radar_detector(dev);
 	if (request->dfs_region == NL80211_DFS_UNSET)
-		mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, MT_HW_RDD0,
-				   MT_RX_SEL0, 0);
+		mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, 0, MT_RX_SEL0, 0);
 	else
 		mt7615_dfs_start_radar_detector(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 71b3de5c810c..8223c7fa1c65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1502,15 +1502,13 @@ int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev)
 	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int err;
 
-	err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, MT_HW_RDD0,
-				 MT_RX_SEL0, 0);
+	err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
 	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
 	    chandef->width == NL80211_CHAN_WIDTH_80P80)
-		err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, MT_HW_RDD1,
-					 MT_RX_SEL0, 0);
+		err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
 	return err;
 }
 
@@ -1532,20 +1530,19 @@ int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev)
 	int err;
 
 	/* start CAC */
-	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, MT_HW_RDD0,
-				 MT_RX_SEL0, 0);
+	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, 0, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
 	/* TODO: DBDC support */
 
-	err = mt7615_dfs_start_rdd(dev, MT_HW_RDD0);
+	err = mt7615_dfs_start_rdd(dev, 0);
 	if (err < 0)
 		return err;
 
 	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
 	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
-		err = mt7615_dfs_start_rdd(dev, MT_HW_RDD1);
+		err = mt7615_dfs_start_rdd(dev, 1);
 		if (err < 0)
 			return err;
 	}
@@ -1572,15 +1569,13 @@ int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev)
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
 		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
 			return mt7615_dfs_start_radar_detector(dev);
-		else
-			return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, MT_HW_RDD0,
-						  MT_RX_SEL0, 0);
-	} else {
-		err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START,
-					 MT_HW_RDD0, MT_RX_SEL0, 0);
-		if (err < 0)
-			return err;
 
-		return mt7615_dfs_stop_radar_detector(dev);
+		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, 0, MT_RX_SEL0, 0);
 	}
+
+	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, 0, MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	return mt7615_dfs_stop_radar_detector(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 88e903324f07..bd9014421b00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -149,11 +149,6 @@ enum {
 	EXT_BSSID_END
 };
 
-enum {
-	MT_HW_RDD0,
-	MT_HW_RDD1,
-};
-
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
-- 
2.24.0

