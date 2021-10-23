Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3A438293
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJWJNv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhJWJNu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96B706105A;
        Sat, 23 Oct 2021 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980291;
        bh=IwRLzlC+2Z7Hw/6Lu8EDgL9a4i2b5p6rei/TAoO475I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1lVjj+P63VQ57OpLFNoFI0PCAq3lE/zocSqUXraPBC+dCGKk3GxxE4QVWQPRPGyh
         jSUkj2i+LxHb6HmWiCm33gf3GOa4IGlDiIj1+54cKvt6MyNDhF1HAadau5mX2Em7OU
         kVeHTBwOF1etGshIncex3g08ANCpb+lSHpGoEgGlrY9q/7yImQ91ZPmmHI+kh7Qln7
         VD8n+cS5cfGCdZdKeyd32lacSccadLLSQ4kZ9ak2tl0HXA6esA8U7rE00L0g4dm9g1
         pG0LJlgoePdqn4bCD7GU663bA4dqn5MEvKf3qaxWA7Qg3Alffr1jO8X751GJKCjgBJ
         RbhS5WS9vewhQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 5/6] cfg80211: introduce offchannel cac delayed work
Date:   Sat, 23 Oct 2021 11:10:54 +0200
Message-Id: <4b6c08671ad59aae0ac46fc94c02f31b1610eb72.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce cac delayed work in order to report NL80211_RADAR_CAC_FINISHED
to userspace.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/wireless/core.c |  1 +
 net/wireless/core.h |  4 ++++
 net/wireless/mlme.c | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 385c3654b385..57e825bc37ea 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -545,6 +545,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
+	INIT_DELAYED_WORK(&rdev->offchan_cac_work, cfg80211_offchan_cac_work);
 
 	init_waitqueue_head(&rdev->dev_wait);
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 6e4d18fb93b1..c129311834a0 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -86,6 +86,8 @@ struct cfg80211_registered_device {
 
 	struct mutex offchan_mutex; /* protect offchan_radar_wdev */
 	struct wireless_dev *offchan_radar_wdev;
+	struct cfg80211_chan_def offchan_radar_chandef;
+	struct delayed_work offchan_cac_work;
 
 	/* netlink port which started critical protocol (0 means not started) */
 	u32 crit_proto_nlportid;
@@ -500,6 +502,8 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 int
 cfg80211_stop_offchan_radar_detection(struct cfg80211_registered_device *rdev);
 
+void cfg80211_offchan_cac_work(struct work_struct *work);
+
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan);
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 9f379a91d7fd..532df85d1c26 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -969,6 +969,17 @@ void cfg80211_cac_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_cac_event);
 
+void cfg80211_offchan_cac_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct cfg80211_registered_device *rdev;
+
+	rdev = container_of(delayed_work, struct cfg80211_registered_device,
+			    offchan_cac_work);
+	cfg80211_offchan_cac_event(&rdev->wiphy, &rdev->offchan_radar_chandef,
+				   NL80211_RADAR_CAC_FINISHED, GFP_KERNEL);
+}
+
 static void
 __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 			     struct wireless_dev *wdev,
@@ -993,6 +1004,7 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 		rdev->offchan_radar_wdev = NULL;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
+		cancel_delayed_work(&rdev->offchan_cac_work);
 		wdev = rdev->offchan_radar_wdev;
 		rdev->offchan_radar_wdev = NULL;
 		break;
@@ -1025,6 +1037,7 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 				       struct wireless_dev *wdev,
 				       struct cfg80211_chan_def *chandef)
 {
+	unsigned int cac_time_ms;
 	int err = -EBUSY;
 
 	mutex_lock(&rdev->offchan_mutex);
@@ -1035,8 +1048,15 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	if (err)
 		goto out;
 
+	cac_time_ms = cfg80211_chandef_dfs_cac_time(&rdev->wiphy, chandef);
+	if (!cac_time_ms)
+		cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
+
+	rdev->offchan_radar_chandef = *chandef;
 	__cfg80211_offchan_cac_event(rdev, wdev, chandef,
 				     NL80211_RADAR_CAC_STARTED, GFP_KERNEL);
+	queue_delayed_work(cfg80211_wq, &rdev->offchan_cac_work,
+			   msecs_to_jiffies(cac_time_ms));
 out:
 	mutex_unlock(&rdev->offchan_mutex);
 	return err;
-- 
2.31.1

