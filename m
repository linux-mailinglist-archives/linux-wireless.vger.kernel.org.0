Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5E2F6019
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbhANLbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbhANLbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:31:06 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F232C06179F
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GS4lB+Dmu0gpIV8fi33WFpEebsCdkKYl6F092yYuhto=; b=mdbixb5zpg2o6vAUlYeX4Dkp1Q
        XnpQTbZkQHP2w6rwpRAX+j8DVtxxuS7yMtQJF0yUyeWnVD5gzw9knnnaclMQT0FWjURILPfDnjIJD
        TyTEi2/N6UELqNn0hiq8J/wN5KMdOln3J1AWU0kqt7lUY84B2CELg2fC8suO2jroRZzg=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00oi-0001PU-13
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] mt76: mt7915: fix eeprom DBDC band selection
Date:   Thu, 14 Jan 2021 12:29:25 +0100
Message-Id: <20210114112925.87646-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the EEPROM band fields contain default values, assign 2.4 GHz to the
first band and 5 GHz to the second.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h | 8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 8f12a1bef3fc..9704d114974f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -54,11 +54,14 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 
 	val = mt7915_eeprom_read(dev, MT_EE_WIFI_CONF + ext_phy);
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+	if (val == MT_EE_BAND_SEL_DEFAULT && dev->dbdc_support)
+		val = ext_phy ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
+
 	switch (val) {
-	case MT_EE_5GHZ:
+	case MT_EE_BAND_SEL_5GHZ:
 		phy->mt76->cap.has_5ghz = true;
 		break;
-	case MT_EE_2GHZ:
+	case MT_EE_BAND_SEL_2GHZ:
 		phy->mt76->cap.has_2ghz = true;
 		break;
 	default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 7999e95560a8..3ee8c27bb61b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -35,10 +35,10 @@ enum mt7915_eeprom_field {
 #define MT_EE_WIFI_CONF7_TSSI1_5G		BIT(4)
 
 enum mt7915_eeprom_band {
-	MT_EE_DUAL_BAND,
-	MT_EE_5GHZ,
-	MT_EE_2GHZ,
-	MT_EE_DBDC,
+	MT_EE_BAND_SEL_DEFAULT,
+	MT_EE_BAND_SEL_5GHZ,
+	MT_EE_BAND_SEL_2GHZ,
+	MT_EE_BAND_SEL_DUAL,
 };
 
 #define SKU_DELTA_VAL		GENMASK(5, 0)
-- 
2.28.0

