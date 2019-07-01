Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD15BFE6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGAPd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 11:33:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40356 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfGAPd1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 11:33:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so13885688otl.7
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2019 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56ExRDbThe8Lr9zK7ycBl8La4KzifmCcJUnDuOYNVi8=;
        b=ujmCvVgETOuIc3ZZc0xoFFF3yqmIsCG+LR51HPoy+Pxbnk6kauTuzK0WKRv5zhsXf7
         1XQiHrCmCsGQf6pqj2T9XKK18GWiom/gPqRPREe5GTzXQIp6Yz6kS/mtAxzcsFCRJa84
         kQTfDxKWiIM0H1xrK9C7Z5gruNSht+f3YsPhRehaVNNHL6xMOFV3+dEONxPkxuKXNPrE
         o4S06QflpCBsgSoMaiCfhDwR1czc2EV4TJPHljsxpklX8wW+twcfHFrduZSOL4O50cWZ
         pGofTyPCYj0J29Z5n2d8czAn0lX5+gI3QBVWecu/s5u9IVJjBho4yZjbmr/rB7LrjChp
         hx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56ExRDbThe8Lr9zK7ycBl8La4KzifmCcJUnDuOYNVi8=;
        b=a8gCPmSXRYe5tq0PDAdYWYxefsvDnAb2MNZRde0skRlPbZ99wXRuj+9+PVQWaKG7f6
         vQjrFRea+z42kJrp8FVHrVtB63Z/T+gOudX++7MQY8JxirS3Ni8cqBYi0Fh+5C4kPfw3
         iqkM0H/Y+zVjxqj0aNkOQDa1E65310zBLgUyGifKrIEidVw8BSTorlRljoAbFskULC5y
         pVuOGRRZLin/NMmo4Bfo5tJdmjJ+TRExSNTNIKQwvKCijW2WApq271kdmCrCVYY3UJS2
         L+rvVRPZ5kh1CzY4teBHnJCR5AaSpFtCuCYKnHWVPwXb5eDwkzNhCe2vF/ZVJFkNgGR4
         iu8Q==
X-Gm-Message-State: APjAAAXJNP4iYpj+gxj+YK3epazrvf7ZEkZHOi4dPf/TYfxuSaASpbNf
        +/D4BEfOho/q7W1hrUK6fs0O7B4Y
X-Google-Smtp-Source: APXvYqzXOS8/6yDmZzw9tgJBS0yMJ/blYBS/OB3lR+iAgZY96q7BqEossEr6NDenC9XSlPR0NMfrXA==
X-Received: by 2002:a9d:5510:: with SMTP id l16mr20507462oth.63.1561995205738;
        Mon, 01 Jul 2019 08:33:25 -0700 (PDT)
Received: from new-host-2.home (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id y4sm4136786otj.56.2019.07.01.08.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:33:25 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 2/3] nl80211: Limit certain commands to interface owner
Date:   Mon,  1 Jul 2019 10:33:16 -0500
Message-Id: <20190701153317.27170-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701153317.27170-1-denkenz@gmail.com>
References: <20190701153317.27170-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the wdev object has been created (via NEW_INTERFACE) with
SOCKET_OWNER attribute set, then limit certain commands only to the
process that created that wdev.

This can be used to make sure no other process on the system interferes
by sending unwanted scans, action frames or any other funny business.

This patch introduces a new internal flag, and checks that flag in the
pre_doit hook.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/wireless/nl80211.c | 80 ++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 19 deletions(-)

Changes in v3:
  - Fix minor locking mistake reported by kernel test robot

Changes in v2:
  - None

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ff760ba83449..ebf5eab1f9b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13587,6 +13587,7 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
 					 NL80211_FLAG_CHECK_NETDEV_UP)
 #define NL80211_FLAG_CLEAR_SKB		0x20
+#define NL80211_FLAG_OWNER_ONLY		0x40
 
 static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
@@ -13595,6 +13596,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	struct net_device *dev;
 	bool rtnl = ops->internal_flags & NL80211_FLAG_NEED_RTNL;
+	int ret;
 
 	if (rtnl)
 		rtnl_lock();
@@ -13602,10 +13604,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	if (ops->internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
-			if (rtnl)
-				rtnl_unlock();
-			return PTR_ERR(rdev);
+			ret = PTR_ERR(rdev);
+			goto done;
 		}
+
 		info->user_ptr[0] = rdev;
 	} else if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV ||
 		   ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
@@ -13614,32 +13616,33 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		wdev = __cfg80211_wdev_from_attrs(genl_info_net(info),
 						  info->attrs);
 		if (IS_ERR(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
-			return PTR_ERR(wdev);
+			ret = PTR_ERR(wdev);
+			goto done;
 		}
 
 		dev = wdev->netdev;
 		rdev = wiphy_to_rdev(wdev->wiphy);
 
+		ret = -EINVAL;
 		if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV) {
-			if (!dev) {
-				if (rtnl)
-					rtnl_unlock();
-				return -EINVAL;
-			}
+			if (!dev)
+				goto done;
 
 			info->user_ptr[1] = dev;
 		} else {
 			info->user_ptr[1] = wdev;
 		}
 
+		ret = -ENETDOWN;
 		if (ops->internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
-		    !wdev_running(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
-			return -ENETDOWN;
-		}
+		    !wdev_running(wdev))
+			goto done;
+
+		ret = -EPERM;
+		if (ops->internal_flags & NL80211_FLAG_OWNER_ONLY &&
+		    wdev->owner_nlportid &&
+		    wdev->owner_nlportid != info->snd_portid)
+			goto done;
 
 		if (dev)
 			dev_hold(dev);
@@ -13647,7 +13650,13 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = rdev;
 	}
 
-	return 0;
+	ret = 0;
+
+done:
+	if (rtnl && ret < 0)
+		rtnl_unlock();
+
+	return ret;
 }
 
 static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
@@ -13712,7 +13721,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY,
 	},
 	{
 		.cmd = NL80211_CMD_NEW_INTERFACE,
@@ -13728,7 +13738,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY,
 	},
 	{
 		.cmd = NL80211_CMD_GET_KEY,
@@ -13745,6 +13756,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13754,6 +13766,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13762,6 +13775,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13778,6 +13792,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_start_ap,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13786,6 +13801,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_stop_ap,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13802,6 +13818,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13810,6 +13827,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_new_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13818,6 +13836,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13921,6 +13940,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_trigger_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13929,6 +13949,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_abort_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13942,6 +13963,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_start_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13950,6 +13972,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_stop_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13958,6 +13981,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_authenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -13967,6 +13991,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_associate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -13976,6 +14001,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_deauthenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13984,6 +14010,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_disassociate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13992,6 +14019,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_join_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14000,6 +14028,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_leave_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 #ifdef CONFIG_NL80211_TESTMODE
@@ -14019,6 +14048,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_connect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14028,6 +14058,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_update_connect_params,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14037,6 +14068,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_disconnect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14083,6 +14115,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14091,6 +14124,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_cancel_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14115,6 +14149,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_tx_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14123,6 +14158,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_tx_mgmt_cancel_wait,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14147,6 +14183,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_cqm,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14221,6 +14258,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_rekey_data,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14278,6 +14316,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_start_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14286,6 +14325,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_stop_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14371,6 +14411,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_crit_protocol_start,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14379,6 +14420,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_crit_protocol_stop,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
-- 
2.21.0

