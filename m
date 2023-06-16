Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69A7327F4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjFPGyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFPGyb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E671FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898468; x=1718434468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLCVZm+vnJJoBrgqfLAtfEKwLISv4pa9hYjfChJh0mI=;
  b=Au4QYUB2me/jFtMY9t3ar92cxF7mBtnsccvumfvJd8mQdTL2vw1cS1tU
   HZnL4BF8vCyQYlLFOG+XbHxRccjAFrnW3EZpvJ8uyZvVpyj3iaIv7Ib/5
   X/v70ETgKCMmObDk+ekqzZJrtS9yGtY5W3lOnuwFfXY9MBDpTesCylWHZ
   T26/Mdt2RoyX8LsOzqNbMY2pD6E/qRRxkoiW+rZrezKbqtktyJVU2FCwp
   y+jx8ntJqgNBoanivTJwFR5Ef3ywWeqj1FwX0R/xkQNgolGnTHMDbNoG6
   41EmlOqwLPfBmaB9ESqOWBa/K/cUQs3zaglNIp19j2Epq48suVsdBICR9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078784"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078784"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802719958"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802719958"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/20] wifi: cfg80211: make TDLS management link-aware
Date:   Fri, 16 Jun 2023 09:53:50 +0300
Message-Id: <20230616094948.cb3d87c22812.Ia3d15ac4a9a182145bf2d418bcb3ddf4539cd0a7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

For multi-link operation(MLO) TDLS management
frames need to be transmitted on a specific link.
The TDLS setup request will add BSSID along with
peer address and userspace will pass the link-id
based on BSSID value to the driver(or mac80211).

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  8 ++++----
 include/net/cfg80211.h                          |  7 ++++---
 net/mac80211/ieee80211_i.h                      |  8 ++++----
 net/mac80211/tdls.c                             | 10 +++++-----
 net/wireless/nl80211.c                          |  7 +++++--
 net/wireless/rdev-ops.h                         | 15 ++++++++-------
 net/wireless/trace.h                            | 13 ++++++++-----
 7 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554..1ef89cdcaa59 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3753,10 +3753,10 @@ static int mwifiex_cfg80211_set_coalesce(struct wiphy *wiphy,
  */
 static int
 mwifiex_cfg80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
-			   const u8 *peer, u8 action_code, u8 dialog_token,
-			   u16 status_code, u32 peer_capability,
-			   bool initiator, const u8 *extra_ies,
-			   size_t extra_ies_len)
+			   const u8 *peer, int link_id, u8 action_code,
+			   u8 dialog_token, u16 status_code,
+			   u32 peer_capability, bool initiator,
+			   const u8 *extra_ies, size_t extra_ies_len)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	int ret;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6d5b104212b3..5b1d76583dbb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4595,9 +4595,10 @@ struct cfg80211_ops {
 				  struct cfg80211_gtk_rekey_data *data);
 
 	int	(*tdls_mgmt)(struct wiphy *wiphy, struct net_device *dev,
-			     const u8 *peer, u8 action_code,  u8 dialog_token,
-			     u16 status_code, u32 peer_capability,
-			     bool initiator, const u8 *buf, size_t len);
+			     const u8 *peer, int link_id,
+			     u8 action_code, u8 dialog_token, u16 status_code,
+			     u32 peer_capability, bool initiator,
+			     const u8 *buf, size_t len);
 	int	(*tdls_oper)(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *peer, enum nl80211_tdls_operation oper);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4afd5095366c..ca8a1e1c8bbd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2565,10 +2565,10 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 /* TDLS */
 int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
-			const u8 *peer, u8 action_code, u8 dialog_token,
-			u16 status_code, u32 peer_capability,
-			bool initiator, const u8 *extra_ies,
-			size_t extra_ies_len);
+			const u8 *peer, int link_id,
+			u8 action_code, u8 dialog_token, u16 status_code,
+			u32 peer_capability, bool initiator,
+			const u8 *extra_ies, size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
 void ieee80211_tdls_peer_del_work(struct work_struct *wk);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 52c47674a554..6575b2801676 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2019, 2021-2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -1185,10 +1185,10 @@ ieee80211_tdls_mgmt_teardown(struct wiphy *wiphy, struct net_device *dev,
 }
 
 int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
-			const u8 *peer, u8 action_code, u8 dialog_token,
-			u16 status_code, u32 peer_capability,
-			bool initiator, const u8 *extra_ies,
-			size_t extra_ies_len)
+			const u8 *peer, int link_id,
+			u8 action_code, u8 dialog_token, u16 status_code,
+			u32 peer_capability, bool initiator,
+			const u8 *extra_ies, size_t extra_ies_len)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	int ret;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2941187a7a3d..515e76e870b3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12239,6 +12239,7 @@ static int nl80211_tdls_mgmt(struct sk_buff *skb, struct genl_info *info)
 	u32 peer_capability = 0;
 	u16 status_code;
 	u8 *peer;
+	int link_id;
 	bool initiator;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_TDLS) ||
@@ -12260,8 +12261,9 @@ static int nl80211_tdls_mgmt(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_TDLS_PEER_CAPABILITY])
 		peer_capability =
 			nla_get_u32(info->attrs[NL80211_ATTR_TDLS_PEER_CAPABILITY]);
+	link_id = nl80211_link_id_or_invalid(info->attrs);
 
-	return rdev_tdls_mgmt(rdev, dev, peer, action_code,
+	return rdev_tdls_mgmt(rdev, dev, peer, link_id, action_code,
 			      dialog_token, status_code, peer_capability,
 			      initiator,
 			      nla_data(info->attrs[NL80211_ATTR_IE]),
@@ -17128,7 +17130,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_OPER,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 69b508743e57..f8c310849438 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -899,17 +899,18 @@ static inline int rdev_set_rekey_data(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_tdls_mgmt(struct cfg80211_registered_device *rdev,
 				 struct net_device *dev, u8 *peer,
-				 u8 action_code, u8 dialog_token,
-				 u16 status_code, u32 peer_capability,
-				 bool initiator, const u8 *buf, size_t len)
+				 int link_id, u8 action_code,
+				 u8 dialog_token, u16 status_code,
+				 u32 peer_capability, bool initiator,
+				 const u8 *buf, size_t len)
 {
 	int ret;
-	trace_rdev_tdls_mgmt(&rdev->wiphy, dev, peer, action_code,
+	trace_rdev_tdls_mgmt(&rdev->wiphy, dev, peer, link_id, action_code,
 			     dialog_token, status_code, peer_capability,
 			     initiator, buf, len);
-	ret = rdev->ops->tdls_mgmt(&rdev->wiphy, dev, peer, action_code,
-				   dialog_token, status_code, peer_capability,
-				   initiator, buf, len);
+	ret = rdev->ops->tdls_mgmt(&rdev->wiphy, dev, peer, link_id,
+				   action_code, dialog_token, status_code,
+				   peer_capability, initiator, buf, len);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..63aed8d59d25 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1779,15 +1779,16 @@ DEFINE_EVENT(wiphy_netdev_id_evt, rdev_sched_scan_stop,
 
 TRACE_EVENT(rdev_tdls_mgmt,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 u8 *peer, u8 action_code, u8 dialog_token,
+		 u8 *peer, int link_id, u8 action_code, u8 dialog_token,
 		 u16 status_code, u32 peer_capability,
 		 bool initiator, const u8 *buf, size_t len),
-	TP_ARGS(wiphy, netdev, peer, action_code, dialog_token, status_code,
-		peer_capability, initiator, buf, len),
+	TP_ARGS(wiphy, netdev, peer, link_id, action_code, dialog_token,
+		status_code, peer_capability, initiator, buf, len),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(peer)
+		__field(int, link_id)
 		__field(u8, action_code)
 		__field(u8, dialog_token)
 		__field(u16, status_code)
@@ -1799,6 +1800,7 @@ TRACE_EVENT(rdev_tdls_mgmt,
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(peer, peer);
+		__entry->link_id = link_id;
 		__entry->action_code = action_code;
 		__entry->dialog_token = dialog_token;
 		__entry->status_code = status_code;
@@ -1806,11 +1808,12 @@ TRACE_EVENT(rdev_tdls_mgmt,
 		__entry->initiator = initiator;
 		memcpy(__get_dynamic_array(buf), buf, len);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM, action_code: %u, "
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM"
+		  ", link_id: %d, action_code: %u "
 		  "dialog_token: %u, status_code: %u, peer_capability: %u "
 		  "initiator: %s buf: %#.2x ",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
-		  __entry->action_code, __entry->dialog_token,
+		  __entry->link_id, __entry->action_code, __entry->dialog_token,
 		  __entry->status_code, __entry->peer_capability,
 		  BOOL_TO_STR(__entry->initiator),
 		  ((u8 *)__get_dynamic_array(buf))[0])
-- 
2.38.1

