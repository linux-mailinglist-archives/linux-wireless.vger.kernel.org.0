Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE514DD11
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgA3Or0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:26 -0500
Received: from nbd.name ([46.4.11.11]:57448 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgA3OrW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MzMtSuJdT+mp6u132QBZeSGfkmn+kvDDEAbc7SCMzIg=; b=CT8ykGhWSu96TqY5AjGPcBhBhs
        KCZYWiAZ5FHigDLNUJ956xC0+jffeS1bfSgtR7M6ytOB+wgwjpO9t+OjjesSF8cKvezNg/dmxiT6Y
        uWFFXMgFRDoVYDhKtFU8IyYZqodSjHjWvkNIApz+tFXWf8HIb7jDXj+arOIcpnZ2wuxI=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6G-0001Vl-JN
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:20 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EEA7C7AE4694; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/15] mt76: mt7615: add eeprom support for MT7622
Date:   Thu, 30 Jan 2020 15:47:11 +0100
Message-Id: <20200130144718.14298-8-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When sending EEPROM data to the MCU, MT7622 uses a longer buffer

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/eeprom.h  |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 17 +++++++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index e4dcfa531a24..3c3570332366 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -84,6 +84,7 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
 
 	switch (val) {
 	case 0x7615:
+	case 0x7622:
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index c3bc69ac210e..18c7301521b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -21,7 +21,8 @@ enum mt7615_eeprom_field {
 	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
 	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
 
-	__MT_EE_MAX =				0x3bf
+	MT7615_EE_MAX =				0x3bf,
+	MT7622_EE_MAX =				0x3db,
 };
 
 #define MT_EE_NIC_CONF_TX_MASK			GENMASK(7, 4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2352e7687790..e51e584bf81f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -621,18 +621,23 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 		__le16 len;
 	} __packed req_hdr = {
 		.buffer_mode = 1,
-		.len = cpu_to_le16(__MT_EE_MAX - MT_EE_NIC_CONF_0),
 	};
-	int ret, len = sizeof(req_hdr) + __MT_EE_MAX - MT_EE_NIC_CONF_0;
+	int ret, len, eep_len;
 	u8 *req, *eep = (u8 *)dev->mt76.eeprom.data;
 
+	if (is_mt7622(&dev->mt76))
+		eep_len = MT7622_EE_MAX - MT_EE_NIC_CONF_0;
+	else
+		eep_len = MT7615_EE_MAX - MT_EE_NIC_CONF_0;
+
+	len = sizeof(req_hdr) + eep_len;
 	req = kzalloc(len, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
 
+	req_hdr.len = cpu_to_le16(eep_len);
 	memcpy(req, &req_hdr, sizeof(req_hdr));
-	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0,
-	       __MT_EE_MAX - MT_EE_NIC_CONF_0);
+	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0, eep_len);
 
 	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
 				  req, len, true);
@@ -1285,7 +1290,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_phy *phy)
 	};
 	s8 tx_power;
 
-	len = sizeof(req_hdr) + __MT_EE_MAX - MT_EE_NIC_CONF_0;
+	len = sizeof(req_hdr) + MT7615_EE_MAX - MT_EE_NIC_CONF_0;
 	req = kzalloc(len, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -1293,7 +1298,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_phy *phy)
 	memcpy(req, &req_hdr, sizeof(req_hdr));
 	data = req + sizeof(req_hdr);
 	memcpy(data, eep + MT_EE_NIC_CONF_0,
-	       __MT_EE_MAX - MT_EE_NIC_CONF_0);
+	       MT7615_EE_MAX - MT_EE_NIC_CONF_0);
 
 	tx_power = hw->conf.power_level * 2;
 	switch (n_chains) {
-- 
2.24.0

