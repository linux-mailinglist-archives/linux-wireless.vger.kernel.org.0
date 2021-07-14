Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C003C9343
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhGNVrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 17:47:36 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:34706 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhGNVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 16D442005E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DFAEB3C007A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 722F313C2B7;
        Wed, 14 Jul 2021 14:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 722F313C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626299081;
        bh=n9Ta5k710dtpKyw40Sqg/69bU+xPs/NDnC2du86EHlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8e1XT5R0BYoPSxlC6ArgpQXiuiOQCi2H5Td2WMnaD4ztqTcQf4PqUHiYgFyynT9l
         hbZJUUONeIPYKCILv/+CMaQ1kn2rsrFWt8YmNPuTzNBH//DTKTz3090gb4OSNUWKiH
         sxIqMKCYVXahqht8/Ehcsko2Am8G5C/MZbmosK9k=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 6/8] mt76 - mt7915: Fix he_mcs capabilities for 160mhz.
Date:   Wed, 14 Jul 2021 14:44:30 -0700
Message-Id: <20210714214432.15162-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210714214432.15162-1-greearb@candelatech.com>
References: <20210714214432.15162-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626299082-AzeUHJM2jqrf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

At 160, this chip can only do 2x2 NSS.  Fix the features
accordingly, verified it shows up properly in iw phy foo info
now.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 08fa918c310b..0e8296a2d75a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -614,12 +614,19 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 {
 	int i, idx = 0, nss = hweight8(phy->mt76->chainmask);
 	u16 mcs_map = 0;
+	u16 mcs_map_160 = 0;
 
 	for (i = 0; i < 8; i++) {
 		if (i < nss)
 			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
 		else
 			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+
+		/* Can do 1/2 of NSS streams in 160Mhz mode. */
+		if (i < nss/2)
+			mcs_map_160 |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map_160 |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
 	}
 
 	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
@@ -721,10 +728,10 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 
 		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
 		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
-		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
-		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
-		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
-		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map_160);
+		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map_160);
+		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map_160);
+		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map_160);
 
 		mt7915_set_stream_he_txbf_caps(he_cap, i, nss);
 
-- 
2.20.1

