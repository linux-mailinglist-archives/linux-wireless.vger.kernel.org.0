Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED693F9D3C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhH0RH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhH0RH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 13:07:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB64C061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 10:06:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso5230991pjq.4
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monroe-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2xInlpgauFs+d4JpWFzn49odZkDB3KSlUmEhIVZRpU=;
        b=A95cUdyHn5ZUFX6x/pqrt4Sg2wHekCVgIx+z2DE8MLI65FVcg4mzgdUrhcP38NLuwM
         w6Bm+oYOXe7OFOyxXzwFqBaWDCxfez+GVop6dh57KsPvDN7w4a9B55crA3Qq2VrucXzn
         aWYO8n4ignq6Wk7v4o6KXLuDNo9DVG5MoLq/v3VyUzhvxLGwkPbbsr2Bj3C6T8ZU9p9N
         h4xPhMeWDMXXTnmePA+Itd6PSQ16ivwUrEVd5/mNUO1HkvXtfNZxG6OLTB9jBINXx3pl
         qsad4ZyljzXVZ0TxdU+sjIphhgMkDnqqAIuYP57NJ8vrlxzHYtrUhuhfjYiFKdj/wqRo
         PFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2xInlpgauFs+d4JpWFzn49odZkDB3KSlUmEhIVZRpU=;
        b=QQ27j8cdWopvh6OXc73IOO8lUa7UOOQTPmc5h1VYT6xfhnyfDdueGJTSA5X1zj5fCL
         DHCyHiZ5bvEFWwIozk76zrOWt+hvGUWUVg1rrdcbD6fQxMimAKi8dLmdPwuyc8QXxYsS
         BtM2yblp/Nytt+dJRACF8TdZDBD0n4jwFCqBX+MV4rzmI6DkNqgFVzcYziSZv1o+e1yu
         g/NR12fOx5qvwKlE/Ec/GtisNepJEMKNdk0BqfdR4zaRUlsa1OlDJb6p4Hc+emmghxWx
         BPXMVoHYX2LlVVJ4KxkgYHYXzeHW7RopW6kqqof5HJWgnV+dPQEPA9wo71bHig0GWLkH
         J6rQ==
X-Gm-Message-State: AOAM532mYtMYY0rrwEFypkVvq6rXpBUaekzg56uru5ZCctn5GAjOFQOM
        se/bt/qAIkGfy3wJ6qmggGpFZg==
X-Google-Smtp-Source: ABdhPJya8N9a+GPYY1Sg9FJRCDrQ2AEw4gh5y5L6TNo/w4uO5D4kOrlEJcoc8FMgnOUtrODvW3KRgg==
X-Received: by 2002:a17:90b:1c8c:: with SMTP id oo12mr24050886pjb.170.1630083999234;
        Fri, 27 Aug 2021 10:06:39 -0700 (PDT)
Received: from bfg9000.smartrg.link (wsip-98-173-202-84.sb.sd.cox.net. [98.173.202.84])
        by smtp.googlemail.com with ESMTPSA id s32sm6546670pfw.84.2021.08.27.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:06:38 -0700 (PDT)
From:   Chad Monroe <chad@monroe.io>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chad Monroe <chad@monroe.io>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] mt76: mt7615: fix STA mode connection on DFS channels
Date:   Fri, 27 Aug 2021 10:06:31 -0700
Message-Id: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only AP, adhoc and mesh mode needs to check CAC.
Stations, in particular, do not need this check.

Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Chad Monroe <chad@monroe.io>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ed1bba42a322..78b55e872da0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2153,6 +2153,32 @@ static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
 	return 0;
 }
 
+struct mt7615_vif_counts {
+	u32 mesh;
+	u32 adhoc;
+	u32 ap;
+};
+
+static void
+mt7615_vif_counts(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7615_vif_counts *counts = priv;
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
 mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
 {
@@ -2196,6 +2222,7 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int err;
+	struct mt7615_vif_counts counts = {0};
 
 	if (is_mt7663(&dev->mt76))
 		return 0;
@@ -2223,9 +2250,14 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	phy->dfs_state = chandef->chan->dfs_state;
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
-			return mt7615_dfs_start_radar_detector(phy);
-
+		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE) {
+			ieee80211_iterate_active_interfaces(phy->mt76->hw,
+				IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7615_vif_counts, &counts);
+			if (counts.ap + counts.adhoc + counts.mesh)
+				mt7615_dfs_start_radar_detector(phy);
+			return 0;
+		}
 		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
 					  MT_RX_SEL0, 0);
 	}
-- 
2.20.1

