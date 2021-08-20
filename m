Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7330F3F3556
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhHTUgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 16:36:16 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:50294 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhHTUgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 16:36:16 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.174])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9AA8CA0075;
        Fri, 20 Aug 2021 20:35:36 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 601187C007F;
        Fri, 20 Aug 2021 20:35:36 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D56A313C2B1;
        Fri, 20 Aug 2021 13:35:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D56A313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629491735;
        bh=geKuTFdZbTx/HQkKrd0DDik1P6O4+Z+539mPLZ73l88=;
        h=From:To:Cc:Subject:Date:From;
        b=e/R99bR9tKPTGO67jQ10khs/yTin2sUvIEMEosPw+MZw1Vbd660bW+ldNJVXhzyPV
         GJlXbQXyY/3f4P5Rt19I1IhyU2ONGj2hktT57XhUrfDAF4yARuSqZsaz+sVoJQ6CDH
         8HZ5QJj5D5rcVNSDUGml9tXddvhLhP4sTu3WAQmU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>
Subject: [PATCH v3 1/2] mt76: mt7915: fix STA mode connection on DFS channels
Date:   Fri, 20 Aug 2021 13:35:30 -0700
Message-Id: <20210820203531.20706-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629491737-UqPWbmxv7b6F
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Only AP, adhoc and mesh mode needs to check CAC.
Stations, in particular, do not need this check.

Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
---
v3:  Fix typo in SOB in 1/2, fix rebase typo in 2/2,
  split long line in 2/2
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8747e452e114..a6e142d27b60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2455,6 +2455,32 @@ static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
 	return 0;
 }
 
+struct mt7915_vif_counts {
+	u32 mesh;
+	u32 adhoc;
+	u32 ap;
+};
+
+static void
+mt7915_vif_counts(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7915_vif_counts *counts = priv;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_ADHOC:
+		counts->adhoc++;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		counts->mesh++;
+		break;
+	case NL80211_IFTYPE_AP:
+		counts->ap++;
+		break;
+	default:
+		break;
+	}
+}
+
 static int
 mt7915_dfs_init_radar_specs(struct mt7915_phy *phy)
 {
@@ -2495,6 +2521,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int err;
+	struct mt7915_vif_counts counts = {0};
 
 	if (dev->mt76.region == NL80211_DFS_UNSET) {
 		phy->dfs_state = -1;
@@ -2519,9 +2546,14 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	phy->dfs_state = chandef->chan->dfs_state;
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
-			return mt7915_dfs_start_radar_detector(phy);
-
+		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE) {
+			ieee80211_iterate_active_interfaces(phy->mt76->hw,
+				IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7915_vif_counts, &counts);
+			if (counts.ap + counts.adhoc + counts.mesh)
+				mt7915_dfs_start_radar_detector(phy);
+			return 0;
+		}
 		return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
 					  MT_RX_SEL0, 0);
 	}
-- 
2.20.1

