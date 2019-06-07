Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA33F39265
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfFGQn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 12:43:59 -0400
Received: from nbd.name ([46.4.11.11]:58270 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbfFGQn7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 12:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OzrqzEe3wG3fpAEux/CZfAY8+Ghl5eFpZoaN/HRs9zk=; b=W3/E28f2qlNptIrs8niuHT7JFt
        UzVii9vgH8/sKL9loktrTLrARjtTvcJ4BaPhx4LsL/vzKl+a0dRlkqoDdquNbA23jay30kGysGW2b
        nSFQKLKsWSI0Q2kTv2vfZLXpyLQ4cFU+avUNSuJVzQ7KWcoguFev/wgkIZ7mANO4b0mg=;
Received: from p4ff13bc7.dip0.t-ipconnect.de ([79.241.59.199] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hZHyA-0008DD-IX
        for linux-wireless@vger.kernel.org; Fri, 07 Jun 2019 18:43:58 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id B49015C32BC2; Fri,  7 Jun 2019 18:43:56 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt7603: fix reading target tx power from eeprom
Date:   Fri,  7 Jun 2019 18:43:52 +0200
Message-Id: <20190607164355.51876-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the external PA (TSSI OFF) case, the target power needs to be read
from a different location in EEPROM

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
index f27b99b7e359..b893facfba48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
@@ -69,6 +69,8 @@ enum mt7603_eeprom_field {
 
 	MT_EE_CP_FT_VERSION =			0x0f0,
 
+	MT_EE_TX_POWER_TSSI_OFF =		0x0f2,
+
 	MT_EE_XTAL_FREQ_OFFSET =		0x0f4,
 	MT_EE_XTAL_TRIM_2_COMP =		0x0f5,
 	MT_EE_XTAL_TRIM_3_COMP =		0x0f6,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 4e269044f8a4..2238e3daedc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -465,9 +465,13 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	u8 *eeprom = (u8 *)dev->mt76.eeprom.data;
 	int target_power = eeprom[MT_EE_TX_POWER_0_START_2G + 2] & ~BIT(7);
 	u8 *rate_power = &eeprom[MT_EE_TX_POWER_CCK];
+	bool ext_pa = eeprom[MT_EE_NIC_CONF_0 + 1] & BIT(1);
 	int max_offset, cur_offset;
 	int i;
 
+	if (ext_pa)
+		target_power = eeprom[MT_EE_TX_POWER_TSSI_OFF] & ~BIT(7);
+
 	if (target_power & BIT(6))
 		target_power = -(target_power & GENMASK(5, 0));
 
-- 
2.17.0

