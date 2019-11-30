Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C64910DE15
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfK3Pat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:49 -0500
Received: from nbd.name ([46.4.11.11]:56034 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ka4TaNSQ7wY8alOYkcj7luTGd0Wt2LeXCXIBS5Oa02A=; b=hGx+4x8kSK5nLPvTNBg0+bPSmV
        9bzfAEy2qoqnAfOSvrfW7GODoDJMZkcRAyaeiw2YVq6I7YJuDilAVFvm9FutHMyHuqO1gJJ5ia4KT
        WLGLRqfUMiwTUlgMQ052GnzMpCYS3gLkexUsUC4cc6WH5c1goDbNnqg15gyvfmTwOsi0=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006ha-3h
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 077E1721EBDA; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 26/29] mt76: mt7615: move radio/mac initialization to .start/stop callbacks
Date:   Sat, 30 Nov 2019 16:30:42 +0100
Message-Id: <20191130153045.28105-26-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run initialization per phy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  3 ---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 23 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 ++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index c4dbc635c2c6..78bcdf90ca5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -56,8 +56,6 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
 		 MT_AGG_SCR_NLNAV_MID_PTEC_DIS);
 
-	mt7615_mcu_init_mac(dev);
-
 	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072));
 
@@ -132,7 +130,6 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt7615_mcu_set_eeprom(dev);
 	mt7615_mac_init(dev);
 	mt7615_phy_init(dev);
-	mt7615_mcu_ctrl_pm_state(dev, 0, 0);
 	mt7615_mcu_del_wtbl_all(dev);
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index f80fa045f549..a7e1ab22c81c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -33,6 +33,17 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	mutex_lock(&dev->mt76.mutex);
 
 	running = mt7615_dev_running(dev);
+
+	if (!running) {
+		mt7615_mcu_ctrl_pm_state(dev, 0, 0);
+		mt7615_mcu_set_mac_enable(dev, 0, true);
+	}
+
+	if (phy != &dev->phy) {
+		mt7615_mcu_ctrl_pm_state(dev, 1, 0);
+		mt7615_mcu_set_mac_enable(dev, 1, true);
+	}
+
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (running)
@@ -57,9 +68,19 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	mutex_lock(&dev->mt76.mutex);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	if (!mt7615_dev_running(dev))
+
+	if (phy != &dev->phy) {
+		mt7615_mcu_ctrl_pm_state(dev, 1, 1);
+		mt7615_mcu_set_mac_enable(dev, 1, false);
+	}
+
+	if (!mt7615_dev_running(dev)) {
 		cancel_delayed_work_sync(&dev->mt76.mac_work);
 
+		mt7615_mcu_ctrl_pm_state(dev, 0, 1);
+		mt7615_mcu_set_mac_enable(dev, 0, false);
+	}
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9b09f2e742df..c08a301d4a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -615,15 +615,15 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	return ret;
 }
 
-int mt7615_mcu_init_mac(struct mt7615_dev *dev)
+int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
 {
 	struct {
 		u8 enable;
 		u8 band;
 		u8 rsv[2];
 	} __packed req = {
-		.enable = 1,
-		.band = 0,
+		.enable = enable,
+		.band = band,
 	};
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3323baa7cc0c..2adf3b8a61b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -288,7 +288,7 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
-int mt7615_mcu_init_mac(struct mt7615_dev *dev);
+int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
-- 
2.24.0

