Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BE72824F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjFHOHe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjFHOHZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CD273F
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233241; x=1717769241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0XNOx440eTca30Q0Zm0z9eumP0EX8P+4WPyJHJqbAeU=;
  b=NIXFWJrYtYx13OPlc7uf8cP3z7djXNt9TXeZhr5rwlVQY+zSdCHY6dyI
   9I0uINP5aQQeE1tX2NFuxdel3KJRAeDvz+KibQhzN5XRz1n/3yyAkgPXd
   gNtC1qb70HYYdZf79zw0WdhjwYxzyZ+YRkniybDZvhXWptJtXkVHaGb56
   9HpAV2XsqGB4BprT+sUdQ3c+ulYcz5lbFilcmUIKqzLViIRYdj2+/9Gii
   5pQH/WYGgbPclsaqTwqv05kKk6BB+TPD3k4Ra1aSQwZ+EOrGy1RFRMyPU
   DEvfGNmEL08IAqkb0hde8922Xp9YLpUB8WszmZQk7Zkr79SmBk93ETAVs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176293"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706388"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706388"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: cfg80211: Support association to AP MLD with disabled links
Date:   Thu,  8 Jun 2023 16:36:10 +0300
Message-Id: <20230608163202.c4c61ee4c4a5.I784ef4a0d619fc9120514b5615458fbef3b3684a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

An AP part of an AP MLD might be temporarily disabled, and might be
enabled later. Such a link should be included in the association
exchange, but should not be used until enabled.

Extend the NL80211_CMD_ASSOCIATE to also indicate disabled links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h       |  5 ++++-
 include/uapi/linux/nl80211.h |  7 ++++++-
 net/wireless/nl80211.c       | 13 ++++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1b8619685bf6..6d5b104212b3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2021, 2023 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -2870,11 +2870,14 @@ struct cfg80211_auth_request {
  *	if this is %NULL for a link, that link is not requested
  * @elems: extra elements for the per-STA profile for this link
  * @elems_len: length of the elements
+ * @disabled: If set this link should be included during association etc. but it
+ *	should not be used until enabled by the AP MLD.
  */
 struct cfg80211_assoc_link {
 	struct cfg80211_bss *bss;
 	const u8 *elems;
 	size_t elems_len;
+	bool disabled;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c59fec406da5..c3b674cee312 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -2805,6 +2805,9 @@ enum nl80211_commands {
  *	index. If the userspace includes more RNR elements than number of
  *	MBSSID elements then these will be added in every EMA beacon.
  *
+ * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
+ *	disabled.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3341,6 +3344,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
+	NL80211_ATTR_MLO_LINK_DISABLED,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 772671b9bc42..2941187a7a3d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <linux/if.h>
@@ -816,6 +816,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -11115,6 +11116,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 					goto free;
 				}
 			}
+
+			req.links[link_id].disabled =
+				nla_get_flag(attrs[NL80211_ATTR_MLO_LINK_DISABLED]);
 		}
 
 		if (!req.links[req.link_id].bss) {
@@ -11129,6 +11133,13 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 		}
 
+		if (req.links[req.link_id].disabled) {
+			GENL_SET_ERR_MSG(info,
+					 "cannot have assoc link disabled");
+			err = -EINVAL;
+			goto free;
+		}
+
 		kfree(attrs);
 		attrs = NULL;
 	} else {
-- 
2.38.1

