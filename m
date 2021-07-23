Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBE3D3CBB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhGWPGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:06:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:41684 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235611AbhGWPGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:06:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F41231A006C
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CB4CD680073
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5F01613C2B8;
        Fri, 23 Jul 2021 08:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5F01613C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627055197;
        bh=ebvdbEp3CyND0tTAllOpxo6ClqpSZni8qJjvW6vcvPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+8hIfV3JOhCkS2H+jvKClY8lQxWPumKSxnxAikW5qQ1IHWg5u9GnFA/phv3SnAoZ
         yT532nWRmKWLwwTL9arSIvR1z3GziiMdBr8r2pt9pE/dRyxcRL5fYc9vi+kyqOMUYq
         2o3GPL5HAO6BC71qZ9W479LN6H+SAk9w0KAdiBCE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 6/8] mt76 - mt7915: Fix he_mcs capabilities for 160mhz.
Date:   Fri, 23 Jul 2021 08:46:25 -0700
Message-Id: <20210723154627.10078-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com>
References: <20210723154627.10078-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627055198-2eNTDb6R_A-m
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
index 08fa918c310b..f174cf219724 100644
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
+		if (i < nss / 2)
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

