Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3636A05CD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjBWKMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjBWKMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB93515FD
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147139; x=1708683139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epJhrOBGZ3lfV85SVlaSx1fwcvxg8D+ptEU8L9PMZ5I=;
  b=Pj22FPOrxRbC3lAR8wzs38ILGrVyBUvLTBxSv4DARSsFKIJ9Y3a3u33I
   CXyQTXcvq4ds4NzSMyYere6shzm31I6NvKeiznr73QVHWVJEA9wNp1lXg
   rwbiwQNP/Zt5Yfo1KJ2wtYFE2OxXaQ+TuL+yftcEA6C3OokSZ6slsEW1A
   k3ucuwK5aUrrfxrxksrBIDwxmYDCl6GYhFvID9jDFanE6nwS19hJckv+N
   xg4Xc/PoH0ZPECcz884II1CBxBPqqgZ1nIkawzjvJ+yVY+JwU4gRvJxh2
   EcV3JWEleHFnx2nKO0BKoZibAdw6DL5sFkMVwAjwgQXn9RPkE4Y4b3uss
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396504"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245759"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245759"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:15 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 21/21] wifi: cfg80211: fix MLO connection ownership
Date:   Thu, 23 Feb 2023 12:09:42 +0200
Message-Id: <20230223114629.034c8d8f7578.I008f070c7f3b8e8bde9278101ef9e40706a82902@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

