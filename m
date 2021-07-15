Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564013CAD89
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbhGOUGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346701AbhGOUGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 16:06:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE8C031301
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iudH1YAT7f0+lOEkPWKwG3ic/2yRE6NbKK1GPmo+Ov8=; b=uTSlMxU2hkRhrMSwI0u2H3FzZb
        ZOt4PWZScQNV3HNaWputLmRFKgyKHK/5AtcXXRnlQ/hQsO7fF0Xlrq0myo6Jp9zFRUyMe7xP2ru7A
        ycHcl7C/YMRbQJzn9KYVRzaWBmh9E7+QljnkQKOyZc6O0G8M8wg6bij12MriF8pladcQ=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1m47Rh-00046W-Jd; Thu, 15 Jul 2021 21:54:57 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 3/3] mt76: mt7915: fix mgmt frame using unexpected bitrate
Date:   Thu, 15 Jul 2021 21:54:54 +0200
Message-Id: <20210715195454.12370-3-nbd@nbd.name>
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

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v4: do not rely on rate->hw_value having the proper shift for phy mode
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f1574538315d..b5a3fd96360c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1055,15 +1055,15 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		mt7915_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
-		u16 rate;
+		u16 rate, mode;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			rate = MT7915_5G_RATE_DEFAULT;
-		else
-			rate = MT7915_2G_RATE_DEFAULT;
+		rate = mt76_default_basic_rate(mphy, vif);
+		mode = rate >> 8;
+		rate &= GENMASK(7, 0);
+		rate |= FIELD_PREP(MT_TX_RATE_MODE, mode);
 
 		val = MT_TXD6_FIXED_BW |
 		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 33be449309e0..a6b5b300d415 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -36,8 +36,6 @@
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7915_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-#define MT7915_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
-#define MT7915_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
 #define MT7915_THERMAL_THROTTLE_MAX	100
 
-- 
2.30.1

