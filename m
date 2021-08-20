Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754CE3F3412
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhHTSr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 14:47:28 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:53428 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhHTSr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 14:47:28 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.31])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0570E2007F;
        Fri, 20 Aug 2021 18:46:49 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC80560008B;
        Fri, 20 Aug 2021 18:46:48 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A8E5513C2B1;
        Fri, 20 Aug 2021 11:46:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A8E5513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629485200;
        bh=kG1x9A3NsjkRp7iXqpOfoEp3HLX78Crwz5i3xOUYHSE=;
        h=From:To:Cc:Subject:Date:From;
        b=V5sygyRNLwD074jee5D3+KXp0Fp4FD4tSdVGxdm9H8MsnSryuMgM7c8JdikJIL8iX
         93MnD6kfoJyO+kPpDmSiyWNnhIg3z5zyLoNKMgpH6xQN8Ldi2cxZxVns4KoPY87rRL
         lW7MET9AM7mwXtQ7FSxNkn1zXKBPgXyNT2LKxHu0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: fix STA mode connection on DFS channels
Date:   Fri, 20 Aug 2021 11:46:36 -0700
Message-Id: <20210820184637.4922-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629485209-8ZcrqyEhAa5u
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Only AP, adhoc and mesh mode needs to check CAC.
Stations, in particular, do not need this check.

Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
Singed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Take adhoc and mesh mode into account as well.

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

