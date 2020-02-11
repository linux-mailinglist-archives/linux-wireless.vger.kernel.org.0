Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB84159B14
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 22:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBKV0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 16:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBKV0I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 16:26:08 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0BA20842;
        Tue, 11 Feb 2020 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581456067;
        bh=TgdbI0uZGIxxQY8njoFx4hGGwLIdN082SbQg3ORrcZY=;
        h=From:To:Cc:Subject:Date:From;
        b=zXw59Basdlt+sBwrZsH+9YLQFcu6aMIEIRusOnFCdS+DK1cYhCg/wWN/wt/Iq0j6c
         zki9Pk/l23USC2lBpRVACUQFxkssy8cDzZTqXtkrdwchnHoC7V53HyH/zQAYI9zmk6
         a4ZbT41Slyht2YMQwIp1kzcI1ayaJRzG3sJQaffM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: remove rx_mask in mt7615_eeprom_parse_hw_cap
Date:   Tue, 11 Feb 2020 22:20:54 +0100
Message-Id: <496a58e997ab842d912c5b5352fa6593dc7cc00f.1581455625.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of rx_mask in mt7615_eeprom_parse_hw_cap routine since it is not
actually used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on 'mt76: mt7615: fix max_nss in
mt7615_eeprom_parse_hw_cap'
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index ecf0f4458575..5220c18e711f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -94,7 +94,7 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
-	u8 tx_mask, rx_mask, max_nss;
+	u8 tx_mask, max_nss;
 	u32 val;
 
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
@@ -119,11 +119,6 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	val = mt76_rr(dev, MT_TOP_STRAP_STA);
 	max_nss = val & MT_TOP_3NSS ? 3 : 4;
 
-	rx_mask =  FIELD_GET(MT_EE_NIC_CONF_RX_MASK,
-			     eeprom[MT_EE_NIC_CONF_0]);
-	if (!rx_mask || rx_mask > max_nss)
-		rx_mask = max_nss;
-
 	tx_mask =  FIELD_GET(MT_EE_NIC_CONF_TX_MASK,
 			     eeprom[MT_EE_NIC_CONF_0]);
 	if (!tx_mask || tx_mask > max_nss)
-- 
2.24.1

