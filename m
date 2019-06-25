Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2254CAF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfFYKuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 06:50:23 -0400
Received: from nbd.name ([46.4.11.11]:33080 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFYKuX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 06:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8RNOO/giFYx3mlfoogf3GPvT5yekgIVUaP2L3LuYI7o=; b=L12HfXdAenXe/vc00EoMn1L3JA
        4V2eYTYrSWyJyFdq95a7d0ocukaSva5L+XAU2VcVXqhYRleBgjfWbuo6z0amtITE3EJCM0mIxLWKt
        QP38CjI83ZPzJ+meSGqR5oGVWiwK0peH8tZ0E1HOKv7Jh591AKXTVilqRGYTN2HLVWaA=;
Received: from p5b2063ee.dip0.t-ipconnect.de ([91.32.99.238] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hfj1p-00040n-KI
        for linux-wireless@vger.kernel.org; Tue, 25 Jun 2019 12:50:21 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 06D535F99443; Tue, 25 Jun 2019 12:50:20 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x0: fix RF frontend initialization for external PA
Date:   Tue, 25 Jun 2019 12:50:20 +0200
Message-Id: <20190625105020.8947-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When loading EEPROM data from flash, the RF frontend settings need to be
initialized from flash data. Without this, the chip loads the wrong values
from its internal eFuse ROM.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c     | 13 +++++++------
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h   |  3 +++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 1fd22eb841c3..610819b49bfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -430,15 +430,15 @@ mt76x0_phy_set_chan_bbp_params(struct mt76x02_dev *dev, u16 rf_bw_band)
 static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 {
 	u16 ee_ant = mt76x02_eeprom_get(dev, MT_EE_ANTENNA);
+	u16 ee_cfg1 = mt76x02_eeprom_get(dev, MT_EE_CFG1_INIT);
 	u16 nic_conf2 = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_2);
-	u32 wlan, coex3, cmb;
+	u32 wlan, coex3;
 	bool ant_div;
 
 	wlan = mt76_rr(dev, MT_WLAN_FUN_CTRL);
-	cmb = mt76_rr(dev, MT_CMB_CTRL);
 	coex3 = mt76_rr(dev, MT_COEXCFG3);
 
-	cmb   &= ~(BIT(14) | BIT(12));
+	ee_ant &= ~(BIT(14) | BIT(12));
 	wlan  &= ~(BIT(6) | BIT(5));
 	coex3 &= ~GENMASK(5, 2);
 
@@ -447,7 +447,7 @@ static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 		ant_div = !(nic_conf2 & MT_EE_NIC_CONF_2_ANT_OPT) &&
 			  (nic_conf2 & MT_EE_NIC_CONF_2_ANT_DIV);
 		if (ant_div)
-			cmb |= BIT(12);
+			ee_ant |= BIT(12);
 		else
 			coex3 |= BIT(4);
 		coex3 |= BIT(3);
@@ -464,10 +464,11 @@ static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 	}
 
 	if (is_mt7630(dev))
-		cmb |= BIT(14) | BIT(11);
+		ee_ant |= BIT(14) | BIT(11);
 
 	mt76_wr(dev, MT_WLAN_FUN_CTRL, wlan);
-	mt76_wr(dev, MT_CMB_CTRL, cmb);
+	mt76_rmw(dev, MT_CMB_CTRL, GENMASK(15, 0), ee_ant);
+	mt76_rmw(dev, MT_CSR_EE_CFG1, GENMASK(15, 0), ee_cfg1);
 	mt76_clear(dev, MT_COEXCFG0, BIT(2));
 	mt76_wr(dev, MT_COEXCFG3, coex3);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
index e3442bc4e0a4..0ba536de3d6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
@@ -26,6 +26,7 @@ enum mt76x02_eeprom_field {
 	MT_EE_MAC_ADDR =			0x004,
 	MT_EE_PCI_ID =				0x00A,
 	MT_EE_ANTENNA =				0x022,
+	MT_EE_CFG1_INIT =			0x024,
 	MT_EE_NIC_CONF_0 =			0x034,
 	MT_EE_NIC_CONF_1 =			0x036,
 	MT_EE_COUNTRY_REGION_5GHZ =		0x038,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index 2ce05b543dff..ea7833964ec0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -66,6 +66,9 @@
 #define MT_WLAN_FUN_CTRL_GPIO_OUT	GENMASK(23, 16) /* MT76x0 */
 #define MT_WLAN_FUN_CTRL_GPIO_OUT_EN	GENMASK(31, 24) /* MT76x0 */
 
+/* MT76x0 */
+#define MT_CSR_EE_CFG1			0x0104
+
 #define MT_XO_CTRL0			0x0100
 #define MT_XO_CTRL1			0x0104
 #define MT_XO_CTRL2			0x0108
-- 
2.17.0

