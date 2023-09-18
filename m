Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848F47A4825
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbjIRLNV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbjIRLMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C910D
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035535; x=1726571535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nk9yaiE40tY3rG0eHhncncPn4QSdtadwzRmF+nkFgJg=;
  b=gy3k/UBNYSmSpHTISkJz5kYfrg5hAMbQnDIR4dcr/faLH2AzvIHsvxTP
   MJITdAxDEfMOPIh23qjjxmKk5bwDsKiDZ4saN/TTmWHIzH2qVW+Exgg+s
   ME8hSrXY+86nZxqnWm8DHNwj/auNJ0UUGxzlrDVwDiA9Mj0+qxJa1ExfK
   vVZYcF8c22r6VCT80iawLpATqLswgpW7N+oZd8RkWbGGLOiLGsyx5Q65q
   NS0gXgLLbUuVeEdW1nun9/dI4WRjMohZhid0iG13jpuirzZzHQ4vWrIGw
   t4WNs3mcCUYcvaMAbr17xdYT+LEzbpilf6uNKUnYnLh9vcNlpsI4uVgGD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535969"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025559"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025559"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/18] wifi: cfg80211: report per-link errors during association
Date:   Mon, 18 Sep 2023 14:11:01 +0300
Message-Id: <20230918140607.164cd0ae846c.I40799998f02bf987acee1501a2522dc98bb6eb5a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

When one of the links (other than the assoc_link) is misconfigured
and cannot work the association will fail. However, userspace was not
able to tell that the operation only failed because of a problem with
one of the links. Fix this, by allowing the driver to set a per-link
error code and reporting the (first) offending link by setting the
bad_attr accordingly.

This only allows us to report the first error, but that is sufficient
for userspace to e.g. remove the offending link and retry.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h |  3 +++
 net/wireless/nl80211.c | 50 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9af714431b22..0115fd9bf33a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2964,12 +2964,15 @@ struct cfg80211_auth_request {
  * @elems_len: length of the elements
  * @disabled: If set this link should be included during association etc. but it
  *	should not be used until enabled by the AP MLD.
+ * @error: per-link error code, must be <= 0. If there is an error, then the
+ *	operation as a whole must fail.
  */
 struct cfg80211_assoc_link {
 	struct cfg80211_bss *bss;
 	const u8 *elems;
 	size_t elems_len;
 	bool disabled;
+	int error;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e64bf2a58b36..74eaf74f153a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10942,8 +10942,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 
 		if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 					   req.ie, req.ie_len)) {
-			GENL_SET_ERR_MSG(info,
-					 "non-inheritance makes no sense");
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    info->attrs[NL80211_ATTR_IE],
+					    "non-inheritance makes no sense");
 			return -EINVAL;
 		}
 	}
@@ -11068,6 +11069,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 
 			if (!attrs[NL80211_ATTR_MLO_LINK_ID]) {
 				err = -EINVAL;
+				NL_SET_BAD_ATTR(info->extack, link);
 				goto free;
 			}
 
@@ -11075,6 +11077,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			/* cannot use the same link ID again */
 			if (req.links[link_id].bss) {
 				err = -EINVAL;
+				NL_SET_BAD_ATTR(info->extack, link);
 				goto free;
 			}
 			req.links[link_id].bss =
@@ -11082,6 +11085,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			if (IS_ERR(req.links[link_id].bss)) {
 				err = PTR_ERR(req.links[link_id].bss);
 				req.links[link_id].bss = NULL;
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    link, "Error fetching BSS for link");
 				goto free;
 			}
 
@@ -11094,8 +11099,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 				if (cfg80211_find_elem(WLAN_EID_FRAGMENT,
 						       req.links[link_id].elems,
 						       req.links[link_id].elems_len)) {
-					GENL_SET_ERR_MSG(info,
-							 "cannot deal with fragmentation");
+					NL_SET_ERR_MSG_ATTR(info->extack,
+							    attrs[NL80211_ATTR_IE],
+							    "cannot deal with fragmentation");
 					err = -EINVAL;
 					goto free;
 				}
@@ -11103,8 +11109,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 				if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 							   req.links[link_id].elems,
 							   req.links[link_id].elems_len)) {
-					GENL_SET_ERR_MSG(info,
-							 "cannot deal with non-inheritance");
+					NL_SET_ERR_MSG_ATTR(info->extack,
+							    attrs[NL80211_ATTR_IE],
+							    "cannot deal with non-inheritance");
 					err = -EINVAL;
 					goto free;
 				}
@@ -11147,6 +11154,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
 	if (!err) {
+		struct nlattr *link;
+		int rem = 0;
+
 		err = cfg80211_mlme_assoc(rdev, dev, &req);
 
 		if (!err && info->attrs[NL80211_ATTR_SOCKET_OWNER]) {
@@ -11155,6 +11165,34 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			memcpy(dev->ieee80211_ptr->disconnect_bssid,
 			       ap_addr, ETH_ALEN);
 		}
+
+		/* Report error from first problematic link */
+		if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
+			nla_for_each_nested(link,
+					    info->attrs[NL80211_ATTR_MLO_LINKS],
+					    rem) {
+				struct nlattr *link_id_attr =
+					nla_find_nested(link, NL80211_ATTR_MLO_LINK_ID);
+
+				if (!link_id_attr)
+					continue;
+
+				link_id = nla_get_u8(link_id_attr);
+
+				if (link_id == req.link_id)
+					continue;
+
+				if (!req.links[link_id].error ||
+				    WARN_ON(req.links[link_id].error > 0))
+					continue;
+
+				WARN_ON(err >= 0);
+
+				NL_SET_BAD_ATTR(info->extack, link);
+				err = req.links[link_id].error;
+				break;
+			}
+		}
 	}
 
 free:
-- 
2.38.1

