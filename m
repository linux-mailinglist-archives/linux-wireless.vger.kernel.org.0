Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49496A6AA0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCAKLc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCAKLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:11:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB33B86A
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665457; x=1709201457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epJhrOBGZ3lfV85SVlaSx1fwcvxg8D+ptEU8L9PMZ5I=;
  b=HRjyqtjudo8Zw9w0rKV1WpCk/S1EW2kjhkuNJ/QvY4MPE9u8yuZONyAQ
   ERkneT0iwOUWTJIRlJdpRVy0DoFVfpDHDWqnTBJM0AWhFSSW3fTKTuSoa
   tIxlgZASXKwXrZ8EHMmg5rhTeyr3bySMAKzGoEgZUyQZ5UP+Yc5+Lpkno
   DQwLy4cEwRkJwPXYU4xqKURJH/vhmTHB9P8p/Un2BO12PzBGTjIdZrLjB
   jkl9eBh4kL5tpKvXfXg9wM4cxOWGzOPOor7STzEk16w+YUtHjoUwyC8Qd
   9FoWCt5mhiVGZz1q9iy5H1656PCBFSaWj00WRXrITyYdLY91pzhuxArmu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662968"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589245"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589245"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:51 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 21/23] wifi: cfg80211: fix MLO connection ownership
Date:   Wed,  1 Mar 2023 12:09:33 +0200
Message-Id: <20230301115906.4c1b3b18980e.I008f070c7f3b8e8bde9278101ef9e40706a82902@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When disconnecting from an MLO connection we need the AP
MLD address, not an arbitrary BSSID. Fix the code to do
that.

Fixes: 9ecff10e82a5 ("wifi: nl80211: refactor BSS lookup in nl80211_associate()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/nl80211.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a42b37de68b0..3742296dca8d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10801,8 +10801,7 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 
 static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device *rdev,
 					      const u8 *ssid, int ssid_len,
-					      struct nlattr **attrs,
-					      const u8 **bssid_out)
+					      struct nlattr **attrs)
 {
 	struct ieee80211_channel *chan;
 	struct cfg80211_bss *bss;
@@ -10829,7 +10828,6 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 	if (!bss)
 		return ERR_PTR(-ENOENT);
 
-	*bssid_out = bssid;
 	return bss;
 }
 
@@ -10839,7 +10837,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct cfg80211_assoc_request req = {};
 	struct nlattr **attrs = NULL;
-	const u8 *bssid, *ssid;
+	const u8 *ap_addr, *ssid;
 	unsigned int link_id;
 	int err, ssid_len;
 
@@ -10976,6 +10974,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+		ap_addr = req.ap_mld_addr;
 
 		attrs = kzalloc(attrsize, GFP_KERNEL);
 		if (!attrs)
@@ -11001,8 +11000,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 				goto free;
 			}
 			req.links[link_id].bss =
-				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
-						  &bssid);
+				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs);
 			if (IS_ERR(req.links[link_id].bss)) {
 				err = PTR_ERR(req.links[link_id].bss);
 				req.links[link_id].bss = NULL;
@@ -11053,10 +11051,10 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		if (req.link_id >= 0)
 			return -EINVAL;
 
-		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs,
-					    &bssid);
+		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs);
 		if (IS_ERR(req.bss))
 			return PTR_ERR(req.bss);
+		ap_addr = req.bss->bssid;
 	}
 
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
@@ -11069,7 +11067,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			dev->ieee80211_ptr->conn_owner_nlportid =
 				info->snd_portid;
 			memcpy(dev->ieee80211_ptr->disconnect_bssid,
-			       bssid, ETH_ALEN);
+			       ap_addr, ETH_ALEN);
 		}
 
 		wdev_unlock(dev->ieee80211_ptr);
-- 
2.38.1

