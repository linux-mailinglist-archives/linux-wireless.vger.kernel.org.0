Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298891B866B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYMLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 08:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgDYMLX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 08:11:23 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8481D20714;
        Sat, 25 Apr 2020 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587816683;
        bh=f/cPUhyoDLmiSfWVShSU2XA76c7Y0HGJoHJ4SltIYKc=;
        h=From:To:Cc:Subject:Date:From;
        b=rMz++46MN7wgh7oEn2cAvbalCTCPIQsjHj0RFsAdhrbD737dhGtYGUE+znFsAqaa1
         Lspmn80gqSEVAX8mpmEXF5kwIqwWoMc9JbxctiHC54gl+eqTWCADfukM/G1QUx0I2Q
         2J9iUJ2eIj2qLnhDz0erNFN+leyycqNnnX6p8HNU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76x0: enable MCS 8 and MCS9
Date:   Sat, 25 Apr 2020 14:11:09 +0200
Message-Id: <67151a3a910f52b689d316589377333abc2be902.1587816372.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable MCS8 and MCS9 for mt76x0{u,e} devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x0/init.c  | 26 ++++---------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index 57f8d56737eb..dc8bf4c6969a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -12,24 +12,6 @@
 #include "initvals.h"
 #include "../mt76x02_phy.h"
 
-static void mt76x0_vht_cap_mask(struct ieee80211_supported_band *sband)
-{
-	struct ieee80211_sta_vht_cap *vht_cap = &sband->vht_cap;
-	u16 mcs_map = 0;
-	int i;
-
-	vht_cap->cap &= ~IEEE80211_VHT_CAP_RXLDPC;
-	for (i = 0; i < 8; i++) {
-		if (!i)
-			mcs_map |= (IEEE80211_VHT_MCS_SUPPORT_0_7 << (i * 2));
-		else
-			mcs_map |=
-				(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
-	}
-	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
-	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
-}
-
 static void
 mt76x0_set_wlan_state(struct mt76x02_dev *dev, u32 val, bool enable)
 {
@@ -263,9 +245,11 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 		return ret;
 
 	if (dev->mt76.cap.has_5ghz) {
-		/* overwrite unsupported features */
-		mt76x0_vht_cap_mask(&dev->mphy.sband_5g.sband);
-		mt76x0_init_txpower(dev, &dev->mphy.sband_5g.sband);
+		struct ieee80211_supported_band *sband;
+
+		sband = &dev->mphy.sband_5g.sband;
+		sband->vht_cap.cap &= ~IEEE80211_VHT_CAP_RXLDPC;
+		mt76x0_init_txpower(dev, sband);
 	}
 
 	if (dev->mt76.cap.has_2ghz)
-- 
2.25.3

