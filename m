Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F879433543
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhJSMCI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhJSMCA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80CD361360;
        Tue, 19 Oct 2021 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644787;
        bh=9IUDbZbWE2C5ogAJcx9v1OWBL3Z6Vq+A1v1RaxpzVYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bT38lu09lv42heNnvi6njETafrFsW+T7rn0TdUZIA1G+uEp+hfEHB4DGyWAqUUan2
         ue49+JII2FjVhn7bsEoC+iLgkxRmZ9lT+xN5MJjM9pczSZpfVShV77XrelJEaQPF3B
         dU7OVc8t3PoeXc6mMs+znIX4e3wROPRUptxVSqq5dlQ8pAsnZNn676iua3IRSs3GBD
         sEELvN12RG9TC3ksVSuO5AEGTsQm08335XpCcPuMNJLN8KnRPoZ7eNNBU66YsB18fs
         WdaAb9OYzTZNHZ6wIAVanv59axzm9mCX3v/v4OLhjTPo0gJ+vK0O6do+GjBs/QL7wp
         KpcavJ7PkqLXg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: [PATCH mac80211-next 3/4] cfg80211: introduce cfg80211_cac_offchan_event routine
Date:   Tue, 19 Oct 2021 13:59:06 +0200
Message-Id: <b263b45944edea9564835db19b4502fafcec677d.1634644309.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634644309.git.lorenzo@kernel.org>
References: <cover.1634644309.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce cfg80211_cac_offchan_event routine in order to notify
userland when a Channel Availability Check (CAC) is finished or aborted
by offchannel dedicated chain.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 13 +++++++++++++
 net/wireless/mlme.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index af62af6bf369..2419b4e192ae 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7630,6 +7630,19 @@ void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
 			enum nl80211_radar_event event, gfp_t gfp);
 
+/**
+ * cfg80211_cac_offchan_event - Channel Availability Check (CAC) offchan event
+ * @wiphy: the wiphy
+ * @chandef: chandef for the current channel
+ * @event: type of event
+ * @gfp: context flags
+ *
+ * This function is called when a Channel Availability Check (CAC) is finished
+ * or aborted by offchannel dedicated chain.
+ */
+void cfg80211_cac_offchan_event(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef,
+				enum nl80211_radar_event event, gfp_t gfp);
 
 /**
  * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3aa69b375a10..4362f4f49bb4 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -968,3 +968,29 @@ void cfg80211_cac_event(struct net_device *netdev,
 	nl80211_radar_notify(rdev, chandef, event, netdev, gfp);
 }
 EXPORT_SYMBOL(cfg80211_cac_event);
+
+void cfg80211_cac_offchan_event(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef,
+				enum nl80211_radar_event event, gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	switch (event) {
+	case NL80211_RADAR_CAC_FINISHED:
+		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
+		memcpy(&rdev->cac_done_chandef, chandef,
+		       sizeof(struct cfg80211_chan_def));
+		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
+		cfg80211_sched_dfs_chan_update(rdev);
+		break;
+	case NL80211_RADAR_CAC_ABORTED:
+	case NL80211_RADAR_CAC_STARTED:
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	nl80211_radar_notify(rdev, chandef, event, NULL, gfp);
+}
+EXPORT_SYMBOL(cfg80211_cac_offchan_event);
-- 
2.31.1

