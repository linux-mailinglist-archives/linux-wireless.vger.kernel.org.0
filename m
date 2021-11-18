Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21436455F48
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhKRPYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 10:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhKRPYv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 10:24:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F47F6126A;
        Thu, 18 Nov 2021 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637248911;
        bh=c2KW2ZsaiT2g1dXISSkTH5QLxnq5gzpfc+CH+hx6Pn4=;
        h=From:To:Cc:Subject:Date:From;
        b=Rrx1sbn+YbIUnpAdT5yztHIeAoeenKzdC52pBfLOLhgim0O1nrdX//azRwbJbc0de
         uFUL/njM7CAO4l79LubKJZJ8w0LFigh90ams9DmnqmnhotCm1ONuplWPlZzP32XvVS
         kDvIlnhAHWp8vBCVxX4FtxnAfC257a22oEwM9vvuDgjLMpmBdoy+011SqQ3vPPApdC
         gOuXQis/AM4xgH1lAQAX5lCJQsfMXpkhZZ3VYxbJPzPruPUfs3vCEz1YmIIuavg4AN
         otVqhtQjPaqZQHtMCWKBMq4Zv/2jsl23J21orRhFjSorGlhsWJQkasoSof/K26T/Ng
         UXoej/JKNx/eQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: connac: remove PHY_MODE_AX_6G configuration in mt76_connac_get_phy_mode
Date:   Thu, 18 Nov 2021 16:21:43 +0100
Message-Id: <701b3fc0b1f398061cfc6ff9a131aeacc0e3681a.1637248657.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of PHY_MODE_AX_6G configuration in mt76_connac_get_phy_mode
routine since mode is an u8 and PHY_MODE_AX_6G is set in phymode_ext
field in mt76_connac_bss_basic_tlv.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch must be applied on top of the following patch:
"mt76: connac: fix a theoretical NULL pointer dereference in mt76_connac_get_phy_mode"
https://lore.kernel.org/linux-wireless/d163b59d6628215f8f5889ef2c21a91c4d50d398.1637239699.git.lorenzo@kernel.org/T/#u
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 +++-------
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  3 ++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index bcb596664b3e..eba827f99790 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1190,12 +1190,8 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (vht_cap->vht_supported)
 			mode |= PHY_MODE_AC;
 
-		if (he_cap && he_cap->has_he) {
-			if (band == NL80211_BAND_6GHZ)
-				mode |= PHY_MODE_AX_6G;
-			else
-				mode |= PHY_MODE_AX_5G;
-		}
+		if (he_cap && he_cap->has_he && band == NL80211_BAND_5GHZ)
+			mode |= PHY_MODE_AX_5G;
 	}
 
 	return mode;
@@ -1318,7 +1314,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 	if (band == NL80211_BAND_6GHZ)
-		basic_req.basic.phymode_ext = BIT(0);
+		basic_req.basic.phymode_ext = PHY_MODE_AX_6G;
 
 	basic_phy = mt76_connac_get_phy_mode_v2(phy, vif, band, NULL);
 	basic_req.basic.nonht_basic_phy = cpu_to_le16(basic_phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4e2c9dafd776..388bfcef3b14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -423,7 +423,8 @@ enum {
 #define PHY_MODE_AC				BIT(5)
 #define PHY_MODE_AX_24G				BIT(6)
 #define PHY_MODE_AX_5G				BIT(7)
-#define PHY_MODE_AX_6G				BIT(8)
+
+#define PHY_MODE_AX_6G				BIT(0) /* phymode_ext */
 
 #define MODE_CCK				BIT(0)
 #define MODE_OFDM				BIT(1)
-- 
2.31.1

