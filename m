Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA143F7D2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhJ2H2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhJ2H2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 03:28:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C2C061570
        for <linux-wireless@vger.kernel.org>; Fri, 29 Oct 2021 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=lAOYpeXKC/OmkPJIVCQ6m0WZtG6sMrrykOsbEaR0Ckg=; t=1635492345; x=1636701945; 
        b=JdHofL/4WsTGI8e4NJrIGU0kjSseKm7FtT3ZE62CNS2EKUBnyyetZzKKtnkYjKFcYs83gSPOyhA
        txnuJCJv8GbOw8j8i3qK9+6g2ZhlztfAhc4jMsJE70KVra5CFi6GwyxTYnkTH4LwaVSSvsZS5YaaH
        PrdCMjceUYM81Y3lPMcC38uQe4sWnZ53XGm7gkdNr6T2e9BmpJ5AmjzxAm6lNJ/gDKa2JgFCb/JZ5
        SJ715bTezvCcQGmnnk+FHDddhNDvP2aFEFKh26TbkJiCIKb+vTVIevbKx8l3LGG0MjMRC+wlx8q1v
        rbEZdGR96FOwckZ5jJXkvWVANjrwi4/K9DeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mgMGk-008Eq1-Jv;
        Fri, 29 Oct 2021 09:25:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jan Fuchs <jf@simonwunderlich.de>
Subject: [PATCH] nl80211: fix radio statistics in survey dump
Date:   Fri, 29 Oct 2021 09:25:39 +0200
Message-Id: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Even if userspace specifies the NL80211_ATTR_SURVEY_RADIO_STATS
attribute, we cannot get the statistics because we're not really
parsing the incoming attributes properly any more.

Fix this by passing the attrbuf to nl80211_prepare_wdev_dump()
and filling it there, if given, and using a local version only
if no output is desired.

Since I'm touching it anyway, make nl80211_prepare_wdev_dump()
static.

Fixes: 50508d941c18 ("cfg80211: use parallel_ops for genl")
Reported-by: Jan Fuchs <jf@simonwunderlich.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 34 +++++++++++++++++++---------------
 net/wireless/nl80211.h |  6 +-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 25ee16558dfa..83a1ba96e172 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -937,33 +937,37 @@ nl80211_packet_pattern_policy[MAX_NL80211_PKTPAT + 1] = {
 	[NL80211_PKTPAT_OFFSET] = { .type = NLA_U32 },
 };
 
-int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
-			      struct cfg80211_registered_device **rdev,
-			      struct wireless_dev **wdev)
+static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
+				     struct cfg80211_registered_device **rdev,
+				     struct wireless_dev **wdev,
+				     struct nlattr **attrbuf)
 {
 	int err;
 
 	if (!cb->args[0]) {
-		struct nlattr **attrbuf;
+		struct nlattr **attrbuf_free = NULL;
 
-		attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf),
-				  GFP_KERNEL);
-		if (!attrbuf)
-			return -ENOMEM;
+		if (!attrbuf) {
+			attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf),
+					  GFP_KERNEL);
+			if (!attrbuf)
+				return -ENOMEM;
+			attrbuf_free = attrbuf;
+		}
 
 		err = nlmsg_parse_deprecated(cb->nlh,
 					     GENL_HDRLEN + nl80211_fam.hdrsize,
 					     attrbuf, nl80211_fam.maxattr,
 					     nl80211_policy, NULL);
 		if (err) {
-			kfree(attrbuf);
+			kfree(attrbuf_free);
 			return err;
 		}
 
 		rtnl_lock();
 		*wdev = __cfg80211_wdev_from_attrs(NULL, sock_net(cb->skb->sk),
 						   attrbuf);
-		kfree(attrbuf);
+		kfree(attrbuf_free);
 		if (IS_ERR(*wdev)) {
 			rtnl_unlock();
 			return PTR_ERR(*wdev);
@@ -6198,7 +6202,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	int sta_idx = cb->args[2];
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
 		return err;
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
@@ -7093,7 +7097,7 @@ static int nl80211_dump_mpath(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
 		return err;
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
@@ -7293,7 +7297,7 @@ static int nl80211_dump_mpp(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
 		return err;
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
@@ -9723,7 +9727,7 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	int start = cb->args[2], idx = 0;
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
 	if (err)
 		return err;
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
@@ -9856,7 +9860,7 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!attrbuf)
 		return -ENOMEM;
 
-	res = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
+	res = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
 	if (res) {
 		kfree(attrbuf);
 		return res;
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index a3f387770f1b..d642e3be4ee7 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018, 2020 Intel Corporation
+ * Copyright (C) 2018, 2020-2021 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -22,10 +22,6 @@ static inline u64 wdev_id(struct wireless_dev *wdev)
 	       ((u64)wiphy_to_rdev(wdev->wiphy)->wiphy_idx << 32);
 }
 
-int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
-			      struct cfg80211_registered_device **rdev,
-			      struct wireless_dev **wdev);
-
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
 			  struct cfg80211_chan_def *chandef);
-- 
2.31.1

