Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C756FEC0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfGVLdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 07:33:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40452 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfGVLdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 07:33:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so26385265lff.7
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKSgdE7NkWvMe5bN8DVq6fNelBXU7jD8Qf+VtFitSRs=;
        b=U7scbrI5gMNGd1+m0MVKUGDzhS0ydjrfFBDwdbGtRlOkFRqg9Ddsx9tKNZ4FGzyHwa
         qpt6DM/4AcyIiLWnK1NF2hAd7UZnlX7i3lIzRs9z1CQ8Z/752PGtziGXbXS/K3vyA209
         c3FCRfwIOmfmV0yTZ2gM+2RwfSIEY0MlkWPxzIDlwQsQeae2P6PQ7bglteLJygM3FNOX
         b7BLkx7fqExePqODbF+EgjqPzVl5ehXq8BDXFYG3wu4rBk7i+SGaTG1GcJz7L/la1M7L
         cbNHwD484kvO6DH1FW//CnRgDwKK9SFURbldGFS8qTfmwqIDjKzVZASW4YpSMlgWLvSs
         bp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKSgdE7NkWvMe5bN8DVq6fNelBXU7jD8Qf+VtFitSRs=;
        b=caxqXiiqPBRHb962awqSfYKn4iUu/UsJKxR4ADj2WCcZh3Rh/21BxJ/XDi3Mz7FLKv
         zgGZbJZNo2ZLzGq2QzqtfOcswoFEa69KrfPxXOIh2DGCxxSUb2X/NOZVNFQ1bsU8sjhy
         EOvGSFWWAIPFyz0r5y1hFw3CoU265vywYuqO45OY/Ed36KJW0MbEYUokn4s2x5Wx4fT9
         f95jQWU6P77IsWxcmZ/wwUkDcSgDFTmK1Kq0+DcFcNS701HNaOKHUJpLRZbLTi+D9HX7
         6amHz7Df0ZNxM76XKi5bootzvQzkcC761saEeRo/NvnmMK4nBQNjLmJrNX6C8I10LsVJ
         2/7w==
X-Gm-Message-State: APjAAAXJifDt9rcMlSMNSw3Fzv2g+0U33W6sM0VBDEvJvLvfaeM7jYQJ
        WUogaipw1xqD6z1n72fk4tIhBhtA
X-Google-Smtp-Source: APXvYqwqHQPAYrrUAVyjrWAQkgagDy0kbaA3I9Oy4SqDGzBKuRdtwC43QGyYV4B7ZumENZIWQaZYkw==
X-Received: by 2002:ac2:596c:: with SMTP id h12mr32298130lfp.101.1563795199668;
        Mon, 22 Jul 2019 04:33:19 -0700 (PDT)
Received: from localhost.localdomain (109-252-54-73.nat.spd-mgts.ru. [109.252.54.73])
        by smtp.gmail.com with ESMTPSA id u18sm5940336lfe.65.2019.07.22.04.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 04:33:19 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v4 2/3] nl80211: Limit certain commands to interface owner
Date:   Mon, 22 Jul 2019 06:33:11 -0500
Message-Id: <20190722113312.14031-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722113312.14031-1-denkenz@gmail.com>
References: <20190722113312.14031-1-denkenz@gmail.com>
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
 net/wireless/nl80211.c | 78 ++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 18 deletions(-)

Changes in v4:
  -  Minor restructuring suggested by Arend

Changes in v3:
  -  Fix minor locking mistake reported by kernel test robot

Changes in v2:
  -  None
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fc83dd179c1a..a075d86a52f6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13602,6 +13602,7 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
 					 NL80211_FLAG_CHECK_NETDEV_UP)
 #define NL80211_FLAG_CLEAR_SKB		0x20
+#define NL80211_FLAG_OWNER_ONLY		0x40
 
 static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
@@ -13610,6 +13611,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	struct wireless_dev *wdev;
 	struct net_device *dev;
 	bool rtnl = ops->internal_flags & NL80211_FLAG_NEED_RTNL;
+	int ret;
 
 	if (rtnl)
 		rtnl_lock();
@@ -13617,10 +13619,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	if (ops->internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
-			if (rtnl)
-				rtnl_unlock();
-			return PTR_ERR(rdev);
+			ret = PTR_ERR(rdev);
+			goto fail;
 		}
+
 		info->user_ptr[0] = rdev;
 	} else if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV ||
 		   ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
@@ -13629,32 +13631,33 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		wdev = __cfg80211_wdev_from_attrs(genl_info_net(info),
 						  info->attrs);
 		if (IS_ERR(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
-			return PTR_ERR(wdev);
+			ret = PTR_ERR(wdev);
+			goto fail;
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
+				goto fail;
 
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
+			goto fail;
+
+		ret = -EPERM;
+		if (ops->internal_flags & NL80211_FLAG_OWNER_ONLY &&
+		    wdev->owner_nlportid &&
+		    wdev->owner_nlportid != info->snd_portid)
+			goto fail;
 
 		if (dev)
 			dev_hold(dev);
@@ -13663,6 +13666,12 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	}
 
 	return 0;
+
+fail:
+	if (rtnl)
+		rtnl_unlock();
+
+	return ret;
 }
 
 static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
@@ -13727,7 +13736,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY,
 	},
 	{
 		.cmd = NL80211_CMD_NEW_INTERFACE,
@@ -13743,7 +13753,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_interface,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY,
 	},
 	{
 		.cmd = NL80211_CMD_GET_KEY,
@@ -13760,6 +13771,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13769,6 +13781,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13777,6 +13790,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13793,6 +13807,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_start_ap,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13801,6 +13816,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_stop_ap,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13817,6 +13833,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13825,6 +13842,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_new_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13833,6 +13851,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13936,6 +13955,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_trigger_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13944,6 +13964,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_abort_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13957,6 +13978,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_start_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13965,6 +13987,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_stop_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13973,6 +13996,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_authenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -13982,6 +14006,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_associate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -13991,6 +14016,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_deauthenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -13999,6 +14025,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_disassociate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14007,6 +14034,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_join_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14015,6 +14043,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_leave_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 #ifdef CONFIG_NL80211_TESTMODE
@@ -14034,6 +14063,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_connect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14043,6 +14073,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_update_connect_params,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14052,6 +14083,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_disconnect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14098,6 +14130,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14106,6 +14139,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_cancel_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14130,6 +14164,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_tx_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14138,6 +14173,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_tx_mgmt_cancel_wait,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14162,6 +14198,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_cqm,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14236,6 +14273,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_rekey_data,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
@@ -14293,6 +14331,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_start_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14301,6 +14340,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_stop_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14386,6 +14426,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_crit_protocol_start,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
@@ -14394,6 +14435,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_crit_protocol_stop,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
+				  NL80211_FLAG_OWNER_ONLY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
 	{
-- 
2.21.0

