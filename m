Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4307843353D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhJSMB6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 08:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbhJSMB5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 08:01:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE90C6113B;
        Tue, 19 Oct 2021 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644784;
        bh=OfSXV/7F3iDf3tnepvj9uYwVtnl/6iflvyR6nsj9LNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpsgrU9/Sq6iR5L3UcrwlSO97Gb3kHEXLJS1O60hu0/moSpg7jpM9G6bG+cntOW3v
         NYsq2MtI7nK/HyDQ0l+J+7HWI617vywLzgt0DQZUI/CqSqfmQxrmdcf91Py5kCK9DX
         fA2MoQyRGbaePdtKlL9Pu/qykfupNO0cWjxLYFniiGSy6LXbbn7O5ADWMlMVxmtaD3
         f+YKHM7bMg/+wHDm7ScNXjJzsSnhjyuAbr385yQVEriG198Agr94CldA8vUsSLG7zx
         aNIDi26Qw5aFG9G/1m+48lDiJQpvxiAwv5z+StK0OXYkjRUW4ozkT2Nm/jhF32pYWv
         UfZCVOljcfu1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: [PATCH mac80211-next 1/4] mac80211: introduce set_radar_offchan callback
Date:   Tue, 19 Oct 2021 13:59:04 +0200
Message-Id: <951f403d4a0ae015295c6152622f155d6a7afa12.1634644309.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634644309.git.lorenzo@kernel.org>
References: <cover.1634644309.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_radar_offchan callback in cfg80211/mac80211_ops in order to
configure a dedicated chain available on some hw (e.g. mt7915) to
perform offchannel CAC detection.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h  |  6 ++++++
 include/net/mac80211.h  |  5 +++++
 net/mac80211/cfg.c      | 13 +++++++++++++
 net/wireless/rdev-ops.h | 17 +++++++++++++++++
 net/wireless/trace.h    | 19 +++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e9e313aa991f..af62af6bf369 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4072,6 +4072,10 @@ struct mgmt_frame_regs {
  * @set_fils_aad: Set FILS AAD data to the AP driver so that the driver can use
  *	those to decrypt (Re)Association Request and encrypt (Re)Association
  *	Response frame.
+ *
+ * @set_radar_offchan: Configure dedicated chain available for radar detection
+ *	on some hw. The chain can't be used to transmits or receives frames.
+ *	The driver is supposed to implement CAC management in sw or fw.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4404,6 +4408,8 @@ struct cfg80211_ops {
 				struct cfg80211_color_change_settings *params);
 	int     (*set_fils_aad)(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_fils_aad *fils_aad);
+	int	(*set_radar_offchan)(struct wiphy *wiphy,
+				     struct cfg80211_chan_def *chandef);
 };
 
 /*
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 13cad5e9e6c0..faf6ede80f2b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3944,6 +3944,9 @@ struct ieee80211_prep_tx_info {
  *	twt structure.
  * @twt_teardown_request: Update the hw with TWT teardown request received
  *	from the peer.
+ * @set_radar_offchan: Configure dedicated chain available for radar detection
+ *	on some hw. The chain can't be used to transmits or receives frames.
+ *	The driver is supposed to implement CAC management in sw or fw.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4272,6 +4275,8 @@ struct ieee80211_ops {
 			      struct ieee80211_twt_setup *twt);
 	void (*twt_teardown_request)(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta, u8 flowid);
+	int (*set_radar_offchan)(struct ieee80211_hw *hw,
+				 struct cfg80211_chan_def *chandef);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2b791c37591..1ab84830a38f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4379,6 +4379,18 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+static int
+ieee80211_set_radar_offchan(struct wiphy *wiphy,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (!local->ops->set_radar_offchan)
+		return -EOPNOTSUPP;
+
+	return local->ops->set_radar_offchan(&local->hw, chandef);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4483,4 +4495,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
 	.color_change = ieee80211_color_change,
+	.set_radar_offchan = ieee80211_set_radar_offchan,
 };
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index cc1efec4b27b..8672b3ef99e4 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1395,4 +1395,21 @@ rdev_set_fils_aad(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_radar_offchan(struct cfg80211_registered_device *rdev,
+		       struct cfg80211_chan_def *chandef)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret;
+
+	if (!rdev->ops->set_radar_offchan)
+		return -EOPNOTSUPP;
+
+	trace_rdev_set_radar_offchan(wiphy, chandef);
+	ret = rdev->ops->set_radar_offchan(wiphy, chandef);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index ad6c16a06bcb..0b27eaa14a18 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3674,6 +3674,25 @@ TRACE_EVENT(cfg80211_bss_color_notify,
 		  __entry->color_bitmap)
 );
 
+TRACE_EVENT(rdev_set_radar_offchan,
+	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
+
+	TP_ARGS(wiphy, chandef),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		CHAN_DEF_ENTRY
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		CHAN_DEF_ASSIGN(chandef)
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
+		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.31.1

