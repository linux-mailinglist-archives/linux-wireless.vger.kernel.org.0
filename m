Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5418216C0C9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 13:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgBYM2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 07:28:50 -0500
Received: from nbd.name ([46.4.11.11]:53754 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgBYM2u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 07:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=APmM0hXCPyAiDiGHqejETCBeGW6vdN2aMw2cyCbrYHk=; b=X3QaB0HG1QtqIhI92Pkay0p6Jt
        zQNYG/BDOvYunc5P2dVdq+WRQSoDIBrNtrEoim/Zi23HdayKnyjwxofN3GAEPvo3CLNpR8rgtSNHw
        OTjOST9y0/ks74I/pBD+kvUdaGLPyTi9+PXB7xvgzucqX/tr5Au0TUSs39/X29ApBt7U=;
Received: from [80.255.7.116] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j6ZKS-0006CL-Vp
        for linux-wireless@vger.kernel.org; Tue, 25 Feb 2020 13:28:49 +0100
Received: by maeck.local (Postfix, from userid 501)
        id F01327E3F8B9; Tue, 25 Feb 2020 13:28:47 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: mt7615: fix antenna mask initialization in DBDC mode
Date:   Tue, 25 Feb 2020 13:28:45 +0100
Message-Id: <20200225122847.40846-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update wiphy available antenna mask, and fix chainmask setting on 3x3 hardware

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 889eb72ad6bd..4c41e4048161 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -350,6 +350,8 @@ mt7615_cap_dbdc_enable(struct mt7615_dev *dev)
 	else
 		dev->mphy.antenna_mask = dev->chainmask >> 1;
 	dev->phy.chainmask = dev->mphy.antenna_mask;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->phy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->phy.chainmask;
 	mt76_set_stream_caps(&dev->mt76, true);
 }
 
@@ -361,6 +363,8 @@ mt7615_cap_dbdc_disable(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 	dev->mphy.antenna_mask = dev->chainmask;
 	dev->phy.chainmask = dev->chainmask;
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->chainmask;
 	mt76_set_stream_caps(&dev->mt76, true);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 01194ed79869..7edd5e739b2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -686,7 +686,13 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mutex_lock(&dev->mt76.mutex);
 
 	phy->mt76->antenna_mask = tx_ant;
-	phy->chainmask = ext_phy ? tx_ant << 2 : tx_ant;
+	if (ext_phy) {
+		if (dev->chainmask == 0xf)
+			tx_ant <<= 2;
+		else
+			tx_ant <<= 1;
+	}
+	phy->chainmask = tx_ant;
 
 	mt76_set_stream_caps(&dev->mt76, true);
 
-- 
2.24.0

