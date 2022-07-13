Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2057332B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiGMJpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82EEEAB6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0Hnlfk7h3sjjJxbe/5bc5EHK9aI6rOQ2u8skrMeKwsM=;
        t=1657705509; x=1658915109; b=NU0duGtKUEbjO3yORuZ6APrYLbDQUhUnoF8xVgBUOawh+0P
        3LBzPvSCRad+62mRDAl2mlHNB0TCMKXIUDJj+VUJkpBbu/DBCbF/0QLAh0v14Sw6b3KwqK8sx6iSF
        aq0vHdKJyKhfjmpzyjxmV9l3thrWdkLLp8srU9oP+JpiWWAFSq/txeIpTqQhoFXCcpPLx7lvS4KQ2
        utyGpSIwH94vO/iQQavIWz7I3v1N3jqinp5z7w05S6KVth4hf5bJxRXIDLeXGsMXNoANpJbEtyavt
        AeocIWz+qWx7enVXZcZ8rWq79zY8oBP1GF1XYQRSOfYwap1/MnJmnSd7E8DzAqGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvb-00EgvB-Kv;
        Wed, 13 Jul 2022 11:45:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/76] wifi: nl80211: hold wdev mutex in add/mod/del link station
Date:   Wed, 13 Jul 2022 11:43:57 +0200
Message-Id: <20220713114425.6ae3d87939e9.I5ae7161064d870033ef792be09efaca652af31ca@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

Since we deal with links, and that requires looking at wdev links,
we should hold the wdev mutex for driver convenience.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5f6cbc2d73b4..26d277c14fd4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15781,9 +15781,14 @@ nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
 	if (err)
 		return err;
 
+	wdev_lock(dev->ieee80211_ptr);
 	if (add)
-		return rdev_add_link_station(rdev, dev, &params);
-	return rdev_mod_link_station(rdev, dev, &params);
+		err = rdev_add_link_station(rdev, dev, &params);
+	else
+		err = rdev_mod_link_station(rdev, dev, &params);
+	wdev_unlock(dev->ieee80211_ptr);
+
+	return err;
 }
 
 static int
@@ -15804,6 +15809,7 @@ nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
 	struct link_station_del_parameters params = {};
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
+	int ret;
 
 	if (!rdev->ops->del_link_station)
 		return -EOPNOTSUPP;
@@ -15815,7 +15821,11 @@ nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
 	params.mld_mac = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
 	params.link_id = nla_get_u8(info->attrs[NL80211_ATTR_MLO_LINK_ID]);
 
-	return rdev_del_link_station(rdev, dev, &params);
+	wdev_lock(dev->ieee80211_ptr);
+	ret = rdev_del_link_station(rdev, dev, &params);
+	wdev_unlock(dev->ieee80211_ptr);
+
+	return ret;
 }
 
 #define NL80211_FLAG_NEED_WIPHY		0x01
-- 
2.36.1

