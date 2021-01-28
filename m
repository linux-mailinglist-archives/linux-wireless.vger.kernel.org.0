Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABF307CB1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhA1RhM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 12:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhA1RgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 12:36:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EC3C06178B
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jan 2021 09:35:37 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l5BCh-00CwTh-9p; Thu, 28 Jan 2021 18:35:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+ed107c5fa3e21cdcd86e@syzkaller.appspotmail.com
Subject: [PATCH 1/4] nl80211: call cfg80211_dev_rename() under RTNL
Date:   Thu, 28 Jan 2021 18:35:25 +0100
Message-Id: <20210128183454.16a4ea036740.I2beeb391dc322d6f1df3ee2612e714e0a7817397@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210128173528.76393-1-johannes@sipsolutions.net>
References: <20210128173528.76393-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is required, and we have an assertion, move the RTNL
unlock down to cover cfg80211_dev_rename().

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Reported-by: syzbot+ed107c5fa3e21cdcd86e@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e5e9d889f00f..3b45a9593e71 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3220,7 +3220,6 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		wdev = netdev->ieee80211_ptr;
 
 	wiphy_lock(&rdev->wiphy);
-	rtnl_unlock();
 
 	/*
 	 * end workaround code, by now the rdev is available
@@ -3230,6 +3229,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_WIPHY_NAME])
 		result = cfg80211_dev_rename(
 			rdev, nla_data(info->attrs[NL80211_ATTR_WIPHY_NAME]));
+	rtnl_unlock();
 
 	if (result)
 		goto out;
-- 
2.26.2

