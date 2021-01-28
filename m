Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB415307CC6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 18:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhA1RhT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhA1RgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 12:36:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4473DC06178C
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jan 2021 09:35:38 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l5BCi-00CwTh-EB; Thu, 28 Jan 2021 18:35:36 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] wext: call cfg80211_set_encryption() with wiphy lock held
Date:   Thu, 28 Jan 2021 18:35:27 +0100
Message-Id: <20210128183454.ea2f086465ed.I891d3bb44f068e6d97c160005010f052f28ab6e5@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210128173528.76393-1-johannes@sipsolutions.net>
References: <20210128173528.76393-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Similar to the previous commit, we need to hold the wiphy lock
here. There's a second instance that is correct already, fix
this one as well.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-compat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 0c6ea6212496..a8320dc59af7 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -655,6 +655,7 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 	bool remove = false;
 	struct key_params params;
 	u32 cipher;
+	int ret;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION &&
 	    wdev->iftype != NL80211_IFTYPE_ADHOC)
@@ -726,12 +727,16 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 		params.seq_len = 6;
 	}
 
-	return cfg80211_set_encryption(
+	wiphy_lock(wdev->wiphy);
+	ret = cfg80211_set_encryption(
 			rdev, dev,
 			!(ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY),
 			addr, remove,
 			ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY,
 			idx, &params);
+	wiphy_unlock(wdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwencode(struct net_device *dev,
-- 
2.26.2

