Return-Path: <linux-wireless+bounces-13700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69939940A1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C56528A6D3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99921204F8E;
	Tue,  8 Oct 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QKQhdGLx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BA204955
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372237; cv=none; b=uzO/0CmUj1baJFIEFbeiRFkzadPUKCVLZt9SnYv5sTR5jbES69V0NwFosDW8Fu54JhY81E6wZYp1dad8KSwAgkYGUxCYdV/iAm3SU+f9IbLZ08FoqXVoqLYz94TSCmOUN/KWEc6ORXCFgd9dprmX9PODneXBbT9RtV1v5LaIF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372237; c=relaxed/simple;
	bh=lBm36YHm1O95U9tDNnY4j65paDDPwQsYnsHAkTq4RE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxYw4xlY8sNtszZ4pjY8Xh5tBK/MAt6s9be58n6IVh7qYPjjUtZqIqHsE5H2qhAYBgm5paQ9LKBNIcSXOO16jOfTfl9/FBKylB2htuwvxAjjwZwLqqmGemfc3GZBWzVfZAJCwpaN7ye0rI+FpaSnAcioJSWg0K4azdllXduRddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QKQhdGLx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rzRpzigNdqgKHKztVRzhoAU8pvhxiouCFSAHkmdwCIw=; b=QKQhdGLxItGvmENog9z7/ky7K9
	S2Pf4M3DJyrjEz/H8wMzsdrrfYI/LarhaVdBW9KmvbV64QVm3tRBjmVr8iT7QPusrMLZdRIF6Ho7G
	k6gu/3vMP7OOjYvfsu7QxH+9XUi8LEcGxC0kFtnCJ0Faw1g+NATPwcC487GCfhTIEUe0=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZO-006H62-2W;
	Tue, 08 Oct 2024 09:23:46 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 06/11] wifi: cfg80211: pass net_device to .set_monitor_channel
Date: Tue,  8 Oct 2024 09:23:39 +0200
Message-ID: <c2ffa3dacfa04f459c60d68766f279a9babaea23.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for allowing multiple monitor interfaces with different channels
on a multi-radio wiphy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  1 +
 drivers/net/wireless/marvell/libertas/cfg.c        |  1 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  3 ++-
 include/net/cfg80211.h                             |  1 +
 net/mac80211/cfg.c                                 |  1 +
 net/wireless/chan.c                                |  3 ++-
 net/wireless/core.h                                |  1 +
 net/wireless/nl80211.c                             |  2 +-
 net/wireless/rdev-ops.h                            |  5 +++--
 net/wireless/trace.h                               | 10 ++++++----
 net/wireless/wext-compat.c                         |  2 +-
 11 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index e8f1d30a8d73..a1a0a9223e74 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1493,6 +1493,7 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int wil_cfg80211_set_channel(struct wiphy *wiphy,
+				    struct net_device *dev,
 				    struct cfg80211_chan_def *chandef)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index b700c213d10c..c1f462bb6a3f 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -486,6 +486,7 @@ static int lbs_add_wps_enrollee_tlv(u8 *tlv, const u8 *ie, size_t ie_len)
  */
 
 static int lbs_cfg_set_monitor_channel(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef)
 {
 	struct lbs_private *priv = wiphy_priv(wiphy);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index eb37b228d54e..9977be0020fe 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -231,6 +231,7 @@ struct wilc_vif *wilc_get_wl_to_vif(struct wilc *wl)
 }
 
 static int set_channel(struct wiphy *wiphy,
+		       struct net_device *dev,
 		       struct cfg80211_chan_def *chandef)
 {
 	struct wilc *wl = wiphy_priv(wiphy);
@@ -1424,7 +1425,7 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct wilc_vif *vif = netdev_priv(dev);
 	int ret;
 
-	ret = set_channel(wiphy, &settings->chandef);
+	ret = set_channel(wiphy, dev, &settings->chandef);
 	if (ret != 0)
 		netdev_err(dev, "Error in setting channel\n");
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8bb5fb80cd7b..4dd537da0873 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4696,6 +4696,7 @@ struct cfg80211_ops {
 					     struct ieee80211_channel *chan);
 
 	int	(*set_monitor_channel)(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef);
 
 	int	(*scan)(struct wiphy *wiphy,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 847304a3a29a..b1ea7006f8d3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -879,6 +879,7 @@ static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
+					 struct net_device *dev,
 					 struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e579d7e1425f..035f3b099d0f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1628,6 +1628,7 @@ bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
 EXPORT_SYMBOL(cfg80211_reg_check_beaconing);
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
 				 struct cfg80211_chan_def *chandef)
 {
 	if (!rdev->ops->set_monitor_channel)
@@ -1635,7 +1636,7 @@ int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_has_monitors_only(rdev))
 		return -EBUSY;
 
-	return rdev_set_monitor_channel(rdev, chandef);
+	return rdev_set_monitor_channel(rdev, dev, chandef);
 }
 
 bool cfg80211_any_usable_channels(struct wiphy *wiphy,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 3b3e3cd7027a..4c45f994a8c0 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -516,6 +516,7 @@ static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 }
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
 				 struct cfg80211_chan_def *chandef);
 
 int ieee80211_get_ratemask(struct ieee80211_supported_band *sband,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d2c1fd98dc03..7845548b15b9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3564,7 +3564,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_MESH_POINT:
 		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
 	case NL80211_IFTYPE_MONITOR:
-		return cfg80211_set_monitor_channel(rdev, &chandef);
+		return cfg80211_set_monitor_channel(rdev, dev, &chandef);
 	default:
 		break;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index f5adbf6b5c84..adb6105bbb7d 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -445,11 +445,12 @@ rdev_libertas_set_mesh_channel(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_monitor_channel(struct cfg80211_registered_device *rdev,
+			 struct net_device *dev,
 			 struct cfg80211_chan_def *chandef)
 {
 	int ret;
-	trace_rdev_set_monitor_channel(&rdev->wiphy, chandef);
-	ret = rdev->ops->set_monitor_channel(&rdev->wiphy, chandef);
+	trace_rdev_set_monitor_channel(&rdev->wiphy, dev, chandef);
+	ret = rdev->ops->set_monitor_channel(&rdev->wiphy, dev, chandef);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 97c21b627791..d5c9bb614fa6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1318,19 +1318,21 @@ TRACE_EVENT(rdev_libertas_set_mesh_channel,
 );
 
 TRACE_EVENT(rdev_set_monitor_channel,
-	TP_PROTO(struct wiphy *wiphy,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, chandef),
+	TP_ARGS(wiphy, netdev, chandef),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG)
 );
 
 TRACE_EVENT(rdev_auth,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2371069f3c43..fd3d01359807 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -830,7 +830,7 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
 			ret = -EINVAL;
 			break;
 		}
-		ret = cfg80211_set_monitor_channel(rdev, &chandef);
+		ret = cfg80211_set_monitor_channel(rdev, dev, &chandef);
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
 		freq = cfg80211_wext_freq(wextfreq);
-- 
git-series 0.9.1

