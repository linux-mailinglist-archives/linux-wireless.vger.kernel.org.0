Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35EF3CAD8A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbhGOUGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbhGOUGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 16:06:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD6C08EE75
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z5DuC3oFK9xmZQUc3sxNRj/fYiu02lEgrCqAWI+86Ak=; b=PjYOxAj/aZGhA8O6TKKt3Bsg/7
        f9GGscPMfR3dbRdd1EyF9dCj22JnhgxRzwPWEz5P52p/0ViZtwJCUfa63c9yeoXkio4SwMVsW3LWV
        yPi25SKmV/oz54aqor1LwCb1I2/bI58fOtjIXE8ExtMZYcuaKIVI3WPuAw6PMHJohgfE=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1m47Rh-00046W-Bo; Thu, 15 Jul 2021 21:54:57 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 2/3] mt76: mt7921: fix mgmt frame using unexpected bitrate
Date:   Thu, 15 Jul 2021 21:54:53 +0200
Message-Id: <20210715195454.12370-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210715195454.12370-1-nbd@nbd.name>
References: <20210715195454.12370-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the current driver mgmt frame is not respecting the basic rates field
provided by the AP and then unconditionally is using the lowest (1 or 6
Mbps) rate.

For example, if the AP only supported basic rate {24, 36, 48, 54} Mbps,
mt7921 cannot send mgmt frame with the rate not in the group. So,
instead, we pick up the lowest basic rate the AP can support to send.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v4: do not rely on rate->hw_value having the proper shift for phy mode
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f4714b0f6e5c..296e0f7a1d14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -811,15 +811,15 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
-		u16 rate;
+		u16 rate, mode;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			rate = MT7921_5G_RATE_DEFAULT;
-		else
-			rate = MT7921_2G_RATE_DEFAULT;
+		rate = mt76_default_basic_rate(mphy, vif);
+		mode = rate >> 8;
+		rate &= GENMASK(7, 0);
+		rate |= FIELD_PREP(MT_TX_RATE_MODE, mode);
 
 		val = MT_TXD6_FIXED_BW |
 		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ac0b414ccd92..6e9e4dfb3928 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -38,8 +38,6 @@
 
 #define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
-#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
 #define MT7921_SKU_RATE_NUM		161
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
-- 
2.30.1

