Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C92500CBF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiDNMGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiDNMGf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 08:06:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA6B1DA
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xfB8JQ9uhjyhb8hcGHhaVUxf33zhvtfndRw8X4HdQjA=;
        t=1649937849; x=1651147449; b=J96hwe/U0xTn5AfSyWRrNfDd8xBcyMczlvcbAv0k+IoqjPx
        FKjF0nRv62+pxflMwOZ0HN8+MhfudNe6LxAtJ+xybAftzR2Ey/HXJaWTZxIzz43WNLG0oLj59Z6o2
        vNyovSG4Sy9SKbdNsHh6cYeoQOZDsc2Bu8JznZAGEiueuMM2mWMSIaGcxPSQ6e3TLQY04fOuCILFj
        lEpHJH6o19tgu59okSsxfuEQsxDnJTT0Eh0vAeNpBGzsMCkAF/Npccffw29+DGFip5eVz3+0G9Xik
        2ghGi+LeN2QgDs6cuO6IhfIx1sBl53R85cOfq2Vl6shG3ObgScl5Up1zYEbEElHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1neyCl-009rpd-5Q;
        Thu, 14 Apr 2022 14:04:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] nl80211: rework internal_flags usage
Date:   Thu, 14 Apr 2022 14:04:03 +0200
Message-Id: <20220414140402.70ddf8af3eb0.I2cc38cb6a10bb4c3863ec9ee97edbcc70a07aa4b@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414140402.32e03e8c261b.I5e7dc6bc563a129b938c43298da6bb4e812400a5@changeid>
References: <20220414140402.32e03e8c261b.I5e7dc6bc563a129b938c43298da6bb4e812400a5@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since internal_flags is only 8 bits, we can only have one
more internal flag. However, we can obviously never use all
of possible the combinations, in fact, we only use 14 of
them (including no flags).

Since we want more flags for MLO (multi-link operation) in
the future, refactor the code to use a flags selector, so
wrap all of the .internal_flags assignments in a IFLAGS()
macro which selects the combination according to the pre-
defined list of combinations.

When we need a new combination, we'll have to add it, but
again we will never use all possible combinations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h    |   2 +-
 net/wireless/nl80211.c | 344 ++++++++++++++++++++++++-----------------
 2 files changed, 200 insertions(+), 146 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 3a7dbd63d8c6..f3907da8aea4 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 087ad3accad8..a6c4d869caec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15286,23 +15286,79 @@ static int nl80211_set_fils_aad(struct sk_buff *skb,
 #define NL80211_FLAG_CLEAR_SKB		0x20
 #define NL80211_FLAG_NO_WIPHY_MTX	0x40
 
+#define INTERNAL_FLAG_SELECTORS(__sel)			\
+	SELECTOR(__sel, NONE, 0) /* must be first */	\
+	SELECTOR(__sel, WIPHY,				\
+		 NL80211_FLAG_NEED_WIPHY)		\
+	SELECTOR(__sel, WDEV,				\
+		 NL80211_FLAG_NEED_WDEV)		\
+	SELECTOR(__sel, NETDEV,				\
+		 NL80211_FLAG_NEED_NETDEV)		\
+	SELECTOR(__sel, WIPHY_RTNL,			\
+		 NL80211_FLAG_NEED_WIPHY |		\
+		 NL80211_FLAG_NEED_RTNL)		\
+	SELECTOR(__sel, WIPHY_RTNL_NOMTX,		\
+		 NL80211_FLAG_NEED_WIPHY |		\
+		 NL80211_FLAG_NEED_RTNL |		\
+		 NL80211_FLAG_NO_WIPHY_MTX)		\
+	SELECTOR(__sel, WDEV_RTNL,			\
+		 NL80211_FLAG_NEED_WDEV |		\
+		 NL80211_FLAG_NEED_RTNL)		\
+	SELECTOR(__sel, NETDEV_RTNL,			\
+		 NL80211_FLAG_NEED_NETDEV |		\
+		 NL80211_FLAG_NEED_RTNL)		\
+	SELECTOR(__sel, NETDEV_UP,			\
+		 NL80211_FLAG_NEED_NETDEV_UP)		\
+	SELECTOR(__sel, NETDEV_UP_NOTMX,		\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_NO_WIPHY_MTX)		\
+	SELECTOR(__sel, NETDEV_UP_CLEAR,		\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_CLEAR_SKB)		\
+	SELECTOR(__sel, WDEV_UP,			\
+		 NL80211_FLAG_NEED_WDEV_UP)		\
+	SELECTOR(__sel, WDEV_UP_RTNL,			\
+		 NL80211_FLAG_NEED_WDEV_UP |		\
+		 NL80211_FLAG_NEED_RTNL)		\
+	SELECTOR(__sel, WIPHY_CLEAR,			\
+		 NL80211_FLAG_NEED_WIPHY |		\
+		 NL80211_FLAG_CLEAR_SKB)
+
+enum nl80211_internal_flags_selector {
+#define SELECTOR(_, name, value)	NL80211_IFL_SEL_##name,
+	INTERNAL_FLAG_SELECTORS(_)
+#undef SELECTOR
+};
+
+static u32 nl80211_internal_flags[] = {
+#define SELECTOR(_, name, value)	[NL80211_IFL_SEL_##name] = value,
+	INTERNAL_FLAG_SELECTORS(_)
+#undef SELECTOR
+};
+
 static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = NULL;
 	struct wireless_dev *wdev;
 	struct net_device *dev;
+	u32 internal_flags;
+
+	if (WARN_ON(ops->internal_flags >= ARRAY_SIZE(nl80211_internal_flags)))
+		return -EINVAL;
+
+	internal_flags = nl80211_internal_flags[ops->internal_flags];
 
 	rtnl_lock();
-	if (ops->internal_flags & NL80211_FLAG_NEED_WIPHY) {
+	if (internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
 			rtnl_unlock();
 			return PTR_ERR(rdev);
 		}
 		info->user_ptr[0] = rdev;
-	} else if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV ||
-		   ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
+	} else if (internal_flags & NL80211_FLAG_NEED_NETDEV ||
+		   internal_flags & NL80211_FLAG_NEED_WDEV) {
 		wdev = __cfg80211_wdev_from_attrs(NULL, genl_info_net(info),
 						  info->attrs);
 		if (IS_ERR(wdev)) {
@@ -15313,7 +15369,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		dev = wdev->netdev;
 		rdev = wiphy_to_rdev(wdev->wiphy);
 
-		if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV) {
+		if (internal_flags & NL80211_FLAG_NEED_NETDEV) {
 			if (!dev) {
 				rtnl_unlock();
 				return -EINVAL;
@@ -15324,7 +15380,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			info->user_ptr[1] = wdev;
 		}
 
-		if (ops->internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
+		if (internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
 		    !wdev_running(wdev)) {
 			rtnl_unlock();
 			return -ENETDOWN;
@@ -15334,12 +15390,12 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = rdev;
 	}
 
-	if (rdev && !(ops->internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
+	if (rdev && !(internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
 		wiphy_lock(&rdev->wiphy);
 		/* we keep the mutex locked until post_doit */
 		__release(&rdev->wiphy.mtx);
 	}
-	if (!(ops->internal_flags & NL80211_FLAG_NEED_RTNL))
+	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
 		rtnl_unlock();
 
 	return 0;
@@ -15348,8 +15404,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			      struct genl_info *info)
 {
+	u32 internal_flags = nl80211_internal_flags[ops->internal_flags];
+
 	if (info->user_ptr[1]) {
-		if (ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
+		if (internal_flags & NL80211_FLAG_NEED_WDEV) {
 			struct wireless_dev *wdev = info->user_ptr[1];
 
 			dev_put(wdev->netdev);
@@ -15359,7 +15417,7 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	}
 
 	if (info->user_ptr[0] &&
-	    !(ops->internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
+	    !(internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
 		struct cfg80211_registered_device *rdev = info->user_ptr[0];
 
 		/* we kept the mutex locked since pre_doit */
@@ -15367,7 +15425,7 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		wiphy_unlock(&rdev->wiphy);
 	}
 
-	if (ops->internal_flags & NL80211_FLAG_NEED_RTNL)
+	if (internal_flags & NL80211_FLAG_NEED_RTNL)
 		rtnl_unlock();
 
 	/* If needed, clear the netlink message payload from the SKB
@@ -15375,7 +15433,7 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	 * the heap after the SKB is freed. The netlink message header
 	 * is still needed for further processing, so leave it intact.
 	 */
-	if (ops->internal_flags & NL80211_FLAG_CLEAR_SKB) {
+	if (internal_flags & NL80211_FLAG_CLEAR_SKB) {
 		struct nlmsghdr *nlh = nlmsg_hdr(skb);
 
 		memset(nlmsg_data(nlh), 0, nlmsg_len(nlh));
@@ -15485,6 +15543,11 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+#define SELECTOR(__sel, name, value) \
+	((__sel) == (value)) ? NL80211_IFL_SEL_##name :
+int __missing_selector(void);
+#define IFLAGS(__val) INTERNAL_FLAG_SELECTORS(__val) __missing_selector()
+
 static const struct genl_ops nl80211_ops[] = {
 	{
 		.cmd = NL80211_CMD_GET_WIPHY,
@@ -15493,7 +15556,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.dumpit = nl80211_dump_wiphy,
 		.done = nl80211_dump_wiphy_done,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 };
 
@@ -15510,112 +15573,113 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_get_interface,
 		.dumpit = nl80211_dump_interface,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_INTERFACE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_NEW_INTERFACE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL |
-				  /* we take the wiphy mutex later ourselves */
-				  NL80211_FLAG_NO_WIPHY_MTX,
+		.internal_flags =
+			IFLAGS(NL80211_FLAG_NEED_WIPHY |
+			       NL80211_FLAG_NEED_RTNL |
+			       /* we take the wiphy mutex later ourselves */
+			       NL80211_FLAG_NO_WIPHY_MTX),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_INTERFACE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_GET_KEY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_KEY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_NEW_KEY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_KEY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_BEACON,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_set_beacon,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_START_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_start_ap,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_STOP_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_stop_ap,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_station,
 		.dumpit = nl80211_dump_station,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_NEW_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPATH,
@@ -15623,7 +15687,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_get_mpath,
 		.dumpit = nl80211_dump_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPP,
@@ -15631,42 +15695,41 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_get_mpp,
 		.dumpit = nl80211_dump_mpp,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_NEW_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_BSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_bss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_REG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_reg_do,
 		.dumpit = nl80211_get_reg_dump,
-		.internal_flags = 0,
 		/* can be retrieved by unprivileged users */
 	},
 #ifdef CONFIG_CFG80211_CRDA_SUPPORT
@@ -15675,7 +15738,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_reg,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = 0,
 	},
 #endif
 	{
@@ -15695,28 +15757,28 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_mesh_config,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_MESH_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_update_mesh_config,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_TRIGGER_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_trigger_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_ABORT_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_abort_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_SCAN,
@@ -15728,60 +15790,58 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_STOP_SCHED_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_AUTHENTICATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_authenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_ASSOCIATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_associate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_DEAUTHENTICATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_deauthenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DISASSOCIATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_disassociate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_IBSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_IBSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 #ifdef CONFIG_NL80211_TESTMODE
 	{
@@ -15790,7 +15850,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_testmode_do,
 		.dumpit = nl80211_testmode_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 #endif
 	{
@@ -15798,34 +15858,32 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_connect,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_UPDATE_CONNECT_PARAMS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_update_connect_params,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_DISCONNECT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_disconnect,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_WIPHY_NETNS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_wiphy_netns,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL |
-				  NL80211_FLAG_NO_WIPHY_MTX,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY |
+					 NL80211_FLAG_NEED_RTNL |
+					 NL80211_FLAG_NO_WIPHY_MTX),
 	},
 	{
 		.cmd = NL80211_CMD_GET_SURVEY,
@@ -15837,121 +15895,120 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_setdel_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_PMKSA,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_setdel_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_FLUSH_PMKSA,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_flush_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_REMAIN_ON_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_cancel_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_TX_BITRATE_MASK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_tx_bitrate_mask,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_REGISTER_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV),
 	},
 	{
 		.cmd = NL80211_CMD_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_FRAME_WAIT_CANCEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_mgmt_cancel_wait,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_POWER_SAVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_power_save,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_GET_POWER_SAVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_power_save,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_CQM,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_cqm,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_MESH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_mesh,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_MESH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_mesh,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_OCB,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_ocb,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_OCB,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_ocb,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 #ifdef CONFIG_PM
 	{
@@ -15959,14 +16016,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_wowlan,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 	{
 		.cmd = NL80211_CMD_SET_WOWLAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_wowlan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 #endif
 	{
@@ -15974,126 +16031,125 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_rekey_data,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_MGMT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_OPER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_oper,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_UNEXPECTED_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_unexpected_frame,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_PROBE_CLIENT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_probe_client,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_REGISTER_BEACONS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_beacons,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 	{
 		.cmd = NL80211_CMD_SET_NOACK_MAP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_noack_map,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_START_P2P_DEVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_STOP_P2P_DEVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_START_NAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_nan,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_STOP_NAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_nan,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_ADD_NAN_FUNCTION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_add_func,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_NAN_FUNCTION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_del_func,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_CHANGE_NAN_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_change_config,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_MCAST_RATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mcast_rate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_MAC_ACL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mac_acl,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_RADAR_DETECT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NO_WIPHY_MTX,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_NO_WIPHY_MTX),
 	},
 	{
 		.cmd = NL80211_CMD_GET_PROTOCOL_FEATURES,
@@ -16105,41 +16161,41 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_update_ft_ies,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_CRIT_PROTOCOL_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_crit_protocol_start,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_CRIT_PROTOCOL_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_crit_protocol_stop,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_COALESCE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_coalesce,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 	{
 		.cmd = NL80211_CMD_SET_COALESCE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_coalesce,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
 	},
 	{
 		.cmd = NL80211_CMD_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_VENDOR,
@@ -16147,139 +16203,137 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_vendor_cmd,
 		.dumpit = nl80211_vendor_cmd_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_SET_QOS_MAP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_qos_map,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_ADD_TX_TS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_add_tx_ts,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_TX_TS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_tx_ts,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_CANCEL_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_cancel_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_MULTICAST_TO_UNICAST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_multicast_to_unicast,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_PMK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_pmk,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  0 |
-				  NL80211_FLAG_CLEAR_SKB,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_PMK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_pmk,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_EXTERNAL_AUTH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_external_auth,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_CONTROL_PORT_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_control_port,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_FTM_RESPONDER_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_ftm_responder_stats,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_PEER_MEASUREMENT_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_pmsr_start,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_NOTIFY_RADAR,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_notify_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_UPDATE_OWE_INFO,
 		.doit = nl80211_update_owe_info,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_PROBE_MESH_LINK,
 		.doit = nl80211_probe_mesh_link,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_TID_CONFIG,
 		.doit = nl80211_set_tid_config,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_SAR_SPECS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_sar_specs,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY |
+					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
 		.cmd = NL80211_CMD_COLOR_CHANGE_REQUEST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_color_change,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_FILS_AAD,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_fils_aad,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 };
 
-- 
2.35.1

