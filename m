Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98A1C17DE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEAOgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgEAOga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 10:36:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB3C061A0C
        for <linux-wireless@vger.kernel.org>; Fri,  1 May 2020 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UZWEeaheVXI2q07E2/uU/7XnkJXnbEBkWfSb4zA0xis=; b=LUzWEBf1o29rngvlKmqxmYLeQl
        ntaR+xScl53Ihh7iymO6njyVU4H0+piKZ9hbxWxWLQmsUoHq8uVqtP8fHFQUx/t96PsQYauBLje/6
        4fhcpIEVwqmXva3AvLB2W9QgzOhlcsx1jIeO+K9PydC06BE4lcS6y90sVDk3+VH0KkHI=;
Received: from p54ae9310.dip0.t-ipconnect.de ([84.174.147.16] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jUWmC-000811-Uk
        for linux-wireless@vger.kernel.org; Fri, 01 May 2020 16:36:29 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 27544851522E; Fri,  1 May 2020 16:36:27 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7615: fix getting maximum tx power from eeprom
Date:   Fri,  1 May 2020 16:36:27 +0200
Message-Id: <20200501143627.24523-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200501143627.24523-1-nbd@nbd.name>
References: <20200501143627.24523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On top of the EEPROM target power, each rate can also has a power offset.
On many devices, this power offset is used to boost the tx power of lower
rates. Take this into account when parsing rate power.
The assumption here is, that the first rate (OFDM 6M or CCK 1M) has the
highest tx power

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index bd2ac1e0e01a..3dd7009e5836 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -32,6 +32,8 @@ enum mt7615_eeprom_field {
 	MT_EE_TX0_2G_TARGET_POWER =		0x058,
 	MT_EE_TX0_5G_G0_TARGET_POWER =		0x070,
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
+	MT_EE_2G_RATE_POWER =			0x0be,
+	MT_EE_5G_RATE_POWER =			0x0d5,
 	MT_EE_EXT_PA_2G_TARGET_POWER =		0x0f2,
 	MT_EE_EXT_PA_5G_TARGET_POWER =		0x0f3,
 	MT7663_EE_TX0_2G_TARGET_POWER =		0x123,
@@ -43,6 +45,10 @@ enum mt7615_eeprom_field {
 	MT7663_EE_MAX =				0x400,
 };
 
+#define MT_EE_RATE_POWER_MASK			GENMASK(5, 0)
+#define MT_EE_RATE_POWER_SIGN			BIT(6)
+#define MT_EE_RATE_POWER_EN			BIT(7)
+
 #define MT_EE_CALDATA_FLASH_TX_DPD		BIT(0)
 #define MT_EE_CALDATA_FLASH_RX_CAL		BIT(1)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 9880643888ba..7e201525305b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -198,6 +198,17 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
 	int delta = mt76_tx_power_nss_delta(n_chains);
+	u8 rate_val;
+
+	/* assume the first rate has the highest power offset */
+	if (band == NL80211_BAND_2GHZ)
+		rate_val = eep[MT_EE_2G_RATE_POWER];
+	else
+		rate_val = eep[MT_EE_5G_RATE_POWER];
+
+	if ((rate_val & ~MT_EE_RATE_POWER_MASK) ==
+	    (MT_EE_RATE_POWER_EN | MT_EE_RATE_POWER_SIGN))
+		delta += rate_val & MT_EE_RATE_POWER_MASK;
 
 	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
 	for (i = 0; i < sband->n_channels; i++) {
-- 
2.24.0

