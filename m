Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1430438291
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhJWJNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhJWJNo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AA086105A;
        Sat, 23 Oct 2021 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980285;
        bh=8a7rA28uPrbDiD/r4pK3TzFWlYEXPoN8dU2BKDRcPFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E29JQVF7X7cswifMQEQMI8RVYEnyKu+IQS/nb6t606sLFXuGpjJGzfDpreLtA/X7/
         IJ1KjV0QVDiGxtKowuNvIAwki6L9dItykYZ/W1SbufAJx8IzJ4GmCgsxuJXW/KGh3J
         8KMp24/0eZmZnYGmFfTJ2V5OB0HJcf5jc3x3bGY5gJXW+VjWu+uWTce4MJxEDqhIII
         PnqJ+T0dm4/mPLYVaiU99vnsBFGmAuwmDsQGTi5kGWf1Y3Uj+lLh4VHIeYor1PHoeu
         Jb53KCt/kJA+Ny6p9Q4JSqWrRuFQDfNGFeSrIQxNUxznaDoI1mgc57vXb+N34nH1ej
         KyxVtBkhQGxmw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 1/6] cfg80211: introduce set_radar_offchan callback
Date:   Sat, 23 Oct 2021 11:10:50 +0200
Message-Id: <7468e291ef5d05d692c1738d25b8f778d8ea5c3f.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_radar_offchan callback in cfg80211_ops in order to
configure a dedicated offchannel chain available for radar/CAC
detection on some hw. This chain can't be used to transmit
or receive frames and it is bounded to a running wdev.
Offchannel radar/CAC detection allows to avoid the CAC downtime
switching on a different channel during CAC detection on the selected
radar channel.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h  | 11 +++++++++++
 net/wireless/rdev-ops.h | 18 ++++++++++++++++++
 net/wireless/trace.h    | 19 +++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c9d5db4f0e6..3bb76835f4b1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4072,6 +4072,15 @@ struct mgmt_frame_regs {
  * @set_fils_aad: Set FILS AAD data to the AP driver so that the driver can use
  *	those to decrypt (Re)Association Request and encrypt (Re)Association
  *	Response frame.
+ *
+ * @set_radar_offchan: Configure dedicated offchannel chain available for
+ *	radar/CAC detection on some hw. This chain can't be used to transmit
+ *	or receive frames and it is bounded to a running wdev.
+ *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ *	switching to a different channel during CAC detection on the selected
+ *	radar channel.
+ *	The caller is expected to set chandef pointer to NULL in order to
+ *	disable offchannel CAC/radar detection.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4404,6 +4413,8 @@ struct cfg80211_ops {
 				struct cfg80211_color_change_settings *params);
 	int     (*set_fils_aad)(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_fils_aad *fils_aad);
+	int	(*set_radar_offchan)(struct wiphy *wiphy,
+				     struct cfg80211_chan_def *chandef);
 };
 
 /*
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index cc1efec4b27b..980f1403e000 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1395,4 +1395,22 @@ rdev_set_fils_aad(struct cfg80211_registered_device *rdev,
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
+	if (chandef)
+		trace_rdev_set_radar_offchan(wiphy, chandef);
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

