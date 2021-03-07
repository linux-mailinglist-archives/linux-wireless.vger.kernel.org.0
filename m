Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EAA3303E4
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCGSVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 13:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhCGSVM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 13:21:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4B05650F2;
        Sun,  7 Mar 2021 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615141271;
        bh=pKM1b4Kn1QBRglY/lVM7gew6xpHLBlM8MjYwdHkhZcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrjkS4bML142bEXLxYlV+K72z4kaLiTQkcDqJO5nIFsTDC9t3LQy2VYW6i+DeHz7B
         RzSdP/PW99bLyjOtJL/d4uAvMHTeA1lQrtHkw8Ftc35TDUB/z5BjDYPWrcW+S90Gd3
         iz/EMPkbwTMDKyU1fII7d2/jAapu/QfMjZC6Z7d/9IvfYmp0j1m4S/F6XiJpC2gUl4
         srNhRytCa85V/j7ncPY0FM1KVp8HtC2Wvhtrf4cpE0A8PZj/DL7vPha5OAw99E9O2n
         LSb+uheuz0IYMLgsgFla0VaDtyPVqalzRA+EWn3fVWgdry1mx9uVKu6vwsh/V6B2tW
         AGESsHQtMvouQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 4/7] mt76: mt7921: introduce __mt7921_start utility routine
Date:   Sun,  7 Mar 2021 19:20:48 +0100
Message-Id: <3615862d1c21555c9b4e2f6225729775ae687ed5.1615140875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615140875.git.lorenzo@kernel.org>
References: <cover.1615140875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce mt7921 chip reset support.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 35 +++++++++++--------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 409bae30b8d9..66abadc6537a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -169,33 +169,40 @@ void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
 	}
 }
 
-static int mt7921_start(struct ieee80211_hw *hw)
+int __mt7921_start(struct mt7921_phy *phy)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_phy *mphy = phy->mt76;
 	int err;
 
-	mt7921_mutex_acquire(dev);
-
-	err = mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
+	err = mt76_connac_mcu_set_mac_enable(mphy->dev, 0, true, false);
 	if (err)
-		goto out;
+		return err;
 
-	err = mt76_connac_mcu_set_channel_domain(phy->mt76);
+	err = mt76_connac_mcu_set_channel_domain(mphy);
 	if (err)
-		goto out;
+		return err;
 
 	err = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 	if (err)
-		goto out;
+		return err;
 
 	mt7921_mac_reset_counters(phy);
-	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	set_bit(MT76_STATE_RUNNING, &mphy->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7921_WATCHDOG_TIME);
-out:
-	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static int mt7921_start(struct ieee80211_hw *hw)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = __mt7921_start(phy);
+	mt7921_mutex_release(phy->dev);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 72dc2ba8fd40..c1404a7f9ffb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -209,6 +209,7 @@ extern struct pci_driver mt7921_pci_driver;
 
 u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
 
+int __mt7921_start(struct mt7921_phy *phy);
 int mt7921_register_device(struct mt7921_dev *dev);
 void mt7921_unregister_device(struct mt7921_dev *dev);
 int mt7921_eeprom_init(struct mt7921_dev *dev);
-- 
2.29.2

