Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70EA41B2B9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhI1PQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhI1PQd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4D8161215;
        Tue, 28 Sep 2021 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842094;
        bh=9X8BQthMgu7UpxWbkkjqo62yXQU1qeFiRDnzff+nFXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vc6FtWKflj1tze0uP63UYJNtbCr793UZOzD/tFBMwiEffPuPIIGGXb3KSnye40oDu
         7CIbZ1P8/nNxGU6EQEzhgsD+XaXib3PtR8JAXKrNVZuAyb+PZQ9AeNfgRNqLh1WIg8
         yC+mA0s0Zd1PTUl02yqJ5gC1MMM9Lyvsk10pjz4Jb+qCC5KIoTxGW/QuBanB645OgG
         mOzUA2LjpUONi9QcwfW+piTwVhseaCH2IiYeF7a1FGSExmXHhFO82ciQ0BFoMbiQbB
         JxYNVReY7MdelhFax76tAVAfK4kugu4+JgmVKT6du5F1Xt3GJOCQ3RRzHGUvfo+++H
         8H5P8jh2ICaNg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 3/7] cfg80211: introduce cfg80211_cac_offchan_event routine
Date:   Tue, 28 Sep 2021 17:14:34 +0200
Message-Id: <dac35d82115f4440ef2dbfd90da291675b4052ea.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce cfg80211_cac_offchan_event routine in order to notify
userland when a Channel Availability Check (CAC) is finished or aborted
by offchannel dedicated chain.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 13 +++++++++++++
 net/wireless/mlme.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa31b0919be9..7c1bcd406a34 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7564,6 +7564,19 @@ void cfg80211_cac_event(struct net_device *netdev,
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

