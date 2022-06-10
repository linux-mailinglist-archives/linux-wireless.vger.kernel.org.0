Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D508546465
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiFJKqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbiFJKo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 06:44:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F448E76
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654857669; x=1686393669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WHrFTl/lB8ywZTaFnly/UfjVgyDXZoXUIkBWA06JfbY=;
  b=FLvEUcBlvA5v0qF7lBVFYS5bfZL6Nj9fATFO17LHlsLX2rhc7V/Nmg0D
   mdfloRCs1uvnxeeD8Jg/I6v0dniXhGQRegOikoZU19030lstvEWZkNS6y
   bWEmHdBlDjCgDajLbuUuLHm0Qgq5w3eVb7d2IKQ5Ac3dA6HGP7O1pHfIe
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Jun 2022 03:41:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 03:41:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:08 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:06 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 1/3] cfg80211: increase mesh config attribute bitmask size
Date:   Fri, 10 Jun 2022 16:10:37 +0530
Message-ID: <1654857639-12346-2-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase the mask size for indicating mesh config attributes from 32bit
to 64bit.

This is required for the subsequent patch to add new mesh config.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 include/net/cfg80211.h  | 2 +-
 net/mac80211/cfg.c      | 4 ++--
 net/wireless/nl80211.c  | 6 +++---
 net/wireless/rdev-ops.h | 2 +-
 net/wireless/trace.h    | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cc8a988..34bdf1d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4237,7 +4237,7 @@ struct cfg80211_ops {
 				struct net_device *dev,
 				struct mesh_config *conf);
 	int	(*update_mesh_config)(struct wiphy *wiphy,
-				      struct net_device *dev, u32 mask,
+				      struct net_device *dev, u64 mask,
 				      const struct mesh_config *nconf);
 	int	(*join_mesh)(struct wiphy *wiphy, struct net_device *dev,
 			     const struct mesh_config *conf,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f2..a3d7950 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2206,7 +2206,7 @@ static int ieee80211_get_mesh_config(struct wiphy *wiphy,
 	return 0;
 }
 
-static inline bool _chg_mesh_attr(enum nl80211_meshconf_params parm, u32 mask)
+static inline bool _chg_mesh_attr(enum nl80211_meshconf_params parm, u64 mask)
 {
 	return (mask >> (parm-1)) & 0x1;
 }
@@ -2269,7 +2269,7 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 }
 
 static int ieee80211_update_mesh_config(struct wiphy *wiphy,
-					struct net_device *dev, u32 mask,
+					struct net_device *dev, u64 mask,
 					const struct mesh_config *nconf)
 {
 	struct mesh_config *conf;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 740b294..dee0fa9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7750,10 +7750,10 @@ static const struct nla_policy
 
 static int nl80211_parse_mesh_config(struct genl_info *info,
 				     struct mesh_config *cfg,
-				     u32 *mask_out)
+				     u64 *mask_out)
 {
 	struct nlattr *tb[NL80211_MESHCONF_ATTR_MAX + 1];
-	u32 mask = 0;
+	u64 mask = 0;
 	u16 ht_opmode;
 
 #define FILL_IN_MESH_PARAM_IF_SET(tb, cfg, param, mask, attr, fn)	\
@@ -7957,7 +7957,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct mesh_config cfg;
-	u32 mask;
+	u64 mask;
 	int err;
 
 	if (wdev->iftype != NL80211_IFTYPE_MESH_POINT)
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 439bcf5..e0fcaf12 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -330,7 +330,7 @@ rdev_get_mesh_config(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_update_mesh_config(struct cfg80211_registered_device *rdev,
-			struct net_device *dev, u32 mask,
+			struct net_device *dev, u64 mask,
 			const struct mesh_config *nconf)
 {
 	int ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d..bb4ce97d 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1053,14 +1053,14 @@ TRACE_EVENT(rdev_return_int_mesh_config,
 );
 
 TRACE_EVENT(rdev_update_mesh_config,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u32 mask,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u64 mask,
 		 const struct mesh_config *conf),
 	TP_ARGS(wiphy, netdev, mask, conf),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MESH_CFG_ENTRY
-		__field(u32, mask)
+		__field(u64, mask)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -1068,7 +1068,7 @@ TRACE_EVENT(rdev_update_mesh_config,
 		MESH_CFG_ASSIGN;
 		__entry->mask = mask;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mask: %u",
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mask: %llu",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->mask)
 );
 
-- 
2.7.4

