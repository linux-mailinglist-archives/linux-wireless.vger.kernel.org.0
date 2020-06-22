Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C9203A49
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgFVPHS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 11:07:18 -0400
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140]:63977 "EHLO
        maeck.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgFVPHR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 11:07:17 -0400
Received: by maeck.local (Postfix, from userid 501)
        id 510068EDC3DE; Mon, 22 Jun 2020 17:07:16 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.8] mt76: mt7615: fix EEPROM buffer size
Date:   Mon, 22 Jun 2020 17:07:16 +0200
Message-Id: <20200622150716.49622-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid adding MT7615_EEPROM_SIZE twice.
Rename MT7615_EEPROM_EXTRA_DATA to MT7615_EEPROM_FULL_SIZE, since it already
includes MT7615_EEPROM_SIZE

Fixes: ad380ad1ebbe ("mt76: mt7615: add support for applying DC offset calibration from EEPROM")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index edac37e7847b..22e4eabe6578 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -72,8 +72,7 @@ static int mt7615_eeprom_load(struct mt7615_dev *dev, u32 addr)
 {
 	int ret;
 
-	ret = mt76_eeprom_init(&dev->mt76, MT7615_EEPROM_SIZE +
-					   MT7615_EEPROM_EXTRA_DATA);
+	ret = mt76_eeprom_init(&dev->mt76, MT7615_EEPROM_FULL_SIZE);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 40fed7adc58a..a024dee10362 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -17,7 +17,7 @@
 #define MT7615_EEPROM_TXDPD_SIZE		216
 #define MT7615_EEPROM_TXDPD_COUNT		(44 + 3)
 
-#define MT7615_EEPROM_EXTRA_DATA		(MT7615_EEPROM_TXDPD_OFFSET + \
+#define MT7615_EEPROM_FULL_SIZE			(MT7615_EEPROM_TXDPD_OFFSET + \
 						 MT7615_EEPROM_TXDPD_COUNT * \
 						 MT7615_EEPROM_TXDPD_SIZE)
 
-- 
2.24.0

