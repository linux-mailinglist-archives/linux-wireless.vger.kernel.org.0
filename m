Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC0FCF99
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNUVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 15:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfKNUVl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 15:21:41 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1002070E;
        Thu, 14 Nov 2019 20:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573762900;
        bh=13ilgNRmJLAXxv8Pa9fwIvNxsiimlTPKmnsDFHEFMd0=;
        h=From:To:Cc:Subject:Date:From;
        b=QXIDj2S+6lrlPJ1JqN4EK/m8ljZYBq9JFd4KqvCIZvBo8vUrgM8cjEi2Ett9vsMfA
         00I1SYM8F8bRrJKJq0BaBzeJ6g4dAp4p1phKkm5OEehiQ9oIkvGdIERgnTh3c7eAAD
         Fqg2zG2l2Np2tI4atHcXBT7ZvQYCtT5LWHSNqjMY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: read {tx,rx} mask from eeprom
Date:   Thu, 14 Nov 2019 22:21:11 +0200
Message-Id: <2ad8ff3a8e7a8f2cd752cdb0f2e6699675d33f7d.1573762589.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Parse configured {tx,rx} mask from eeprom data instead of just setting it
to four tx-rx streams

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c | 18 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/eeprom.h |  3 +++
 .../net/wireless/mediatek/mt76/mt7615/init.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7615/regs.h   |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 515bb58e19fd..eccad4987ac8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -93,6 +93,7 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
 	u8 val, *eeprom = dev->mt76.eeprom.data;
+	u8 tx_mask, rx_mask, max_nss;
 
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
 			eeprom[MT_EE_WIFI_CONF]);
@@ -108,6 +109,23 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 		dev->mt76.cap.has_5ghz = true;
 		break;
 	}
+
+	/* read tx-rx mask from eeprom */
+	val = mt76_rr(dev, MT_TOP_STRAP_STA);
+	max_nss = val & MT_TOP_3NSS ? 3 : 4;
+
+	rx_mask =  FIELD_GET(MT_EE_NIC_CONF_RX_MASK,
+			     eeprom[MT_EE_NIC_CONF_0]);
+	if (!rx_mask || rx_mask > max_nss)
+		rx_mask = max_nss;
+
+	tx_mask =  FIELD_GET(MT_EE_NIC_CONF_TX_MASK,
+			     eeprom[MT_EE_NIC_CONF_0]);
+	if (!tx_mask || tx_mask > max_nss)
+		tx_mask = max_nss;
+
+	dev->mt76.chainmask = tx_mask << 8 | rx_mask;
+	dev->mt76.antenna_mask = BIT(tx_mask) - 1;
 }
 
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index f4a4280768d2..c3bc69ac210e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -24,6 +24,9 @@ enum mt7615_eeprom_field {
 	__MT_EE_MAX =				0x3bf
 };
 
+#define MT_EE_NIC_CONF_TX_MASK			GENMASK(7, 4)
+#define MT_EE_NIC_CONF_RX_MASK			GENMASK(3, 0)
+
 #define MT_EE_NIC_CONF_TSSI_2G			BIT(5)
 #define MT_EE_NIC_CONF_TSSI_5G			BIT(6)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 128a6ee1fa6d..553bd4d988f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -303,8 +303,6 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
-	dev->mt76.chainmask = 0x404;
-	dev->mt76.antenna_mask = 0xf;
 	dev->dfs_state = -1;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 99bd5939d33f..61a4aa9ac6e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -6,6 +6,8 @@
 
 #define MT_HW_REV			0x1000
 #define MT_HW_CHIPID			0x1008
+#define MT_TOP_STRAP_STA		0x1010
+#define MT_TOP_3NSS			BIT(24)
 #define MT_TOP_MISC2			0x1134
 #define MT_TOP_MISC2_FW_STATE		GENMASK(2, 0)
 
-- 
2.21.0

