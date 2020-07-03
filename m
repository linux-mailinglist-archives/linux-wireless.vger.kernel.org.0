Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236D7213623
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGCIQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGCIQv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:51 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A0B207DA;
        Fri,  3 Jul 2020 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764211;
        bh=vKTW3aj0dzI+HHz6az1EZ5O+wlYOTV+EJcjLep85Cr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDw/Xa2S2UKTnczXdFwwOirU/cekZe0KoxPMUlg8NUtoRcxqa59MJBE42+R0xu0P4
         /vZl/RUsTNjNanSatf4qmEEwzvF3sXC69AUdCxe0wyVOF2JURkis+ZjFXlsiZ9kPS0
         OrmmYonjgb61H6Gem2thnt7u1UDkCT0jm5mZflGM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 17/22] mt76: mt7615: check MT76_STATE_PM flag before accessing the device
Date:   Fri,  3 Jul 2020 10:15:56 +0200
Message-Id: <1379c3ecf027e745eeb5dde9c51782ec1f83e2d1.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Double-check if the device is in low-power state before accessing
registermap in mt7615_sta_rate_tbl_update() and in
mt7615_led_set_config()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index de4230b2d7bb..0ce76472df2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -664,8 +664,10 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 			break;
 	}
 	msta->n_rates = i;
-	mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
-	msta->rate_probe = false;
+	if (!test_bit(MT76_STATE_PM, &phy->mt76->state)) {
+		mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
+		msta->rate_probe = false;
+	}
 	spin_unlock_bh(&dev->mt76.lock);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 69cba8609edf..7224a0078211 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -70,6 +70,10 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 
 	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
 	dev = container_of(mt76, struct mt7615_dev, mt76);
+
+	if (test_bit(MT76_STATE_PM, &mt76->phy.state))
+		return;
+
 	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
-- 
2.26.2

