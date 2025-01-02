Return-Path: <linux-wireless+bounces-16980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17A9FFA5B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BBB1883BCE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C651B413F;
	Thu,  2 Jan 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8Z9p/KU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615701AF0BA
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827628; cv=none; b=R2J11x55mO5G6g1gDEDbdeMJ9++EToWyXNKxh8DgpMprugAEze2yUrh4dgn5ZwtAlMf0//KCJNkuArwbpUrUSS7r9J/AxeDcESO7uQB48NJinvloQZoKTYnsqdABENkgPLamLrpPyaJfaAw1Qefd4ieyylfuvzSNw82td2a+CIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827628; c=relaxed/simple;
	bh=EhV1aIA7Tc7/MY2d6btyxBm4yk6IQ06bcRH2APesIIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J01NPwmyt3a8YbiD8DMxBw5I6cnlRfxItMOFua1OmX4FViunm272oqoybgWtvxLefM9GwPy7Jmn3CEz7+bNjqvAOwnMPXKm174CYL/xwG79rAi378qT5kgEM7FkwgiyWj/L722LCm/089YY3SJEddQrO0EQ1scH4pLADETpu6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8Z9p/KU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827626; x=1767363626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhV1aIA7Tc7/MY2d6btyxBm4yk6IQ06bcRH2APesIIc=;
  b=g8Z9p/KUUAak7HbpKS+esFwRwK+kBmpk8QElL2TgFEpThLH7v+gRzkhM
   Ntm/eH8dqJBL4ITLsQpX5rsTKdrfjR8SjyfSlWiJv6Wa2Itou3Ne9yCbj
   +vEywF6hpfSMrTTfeLMMPnQ35Ad5cE2+/8YbZrbSj9CLhGLScSetKe9sv
   0B60x/I9XHdCOxBZa21vhe68QcS9ru7f+9tY1m9fkBRwsoaHDo7mB1P4C
   fZ5jA/0upms3lOmwACo/pA1NItqayfPDXC3nJDkBU2b50p9BTZQoiKC/4
   01lXtTgWtelqgxf95tq9lPOtYwXcD47ixhsUSG1XVj1M23USiz4XCQoQf
   Q==;
X-CSE-ConnectionGUID: tVgtjhnrSO+rmxfAMvEI0w==
X-CSE-MsgGUID: sLeBJEjeTGiR2z2QXjosAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735095"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735095"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:26 -0800
X-CSE-ConnectionGUID: HUesHvJ6QDit+yN6InoW/Q==
X-CSE-MsgGUID: gNWnZhv7ShC1/kCaHCR11A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357361"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/17] wifi: nl80211: Split the links handling of an association request
Date: Thu,  2 Jan 2025 16:19:54 +0200
Message-Id: <20250102161730.1e9c1873796a.I27a51c8c1d455f0a6d5b59f93f2c9ac49282febb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

And move it to a separate function so it could later be reused for
dynamic addition of links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 151 +++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 75 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 39c114265db8..9a9e61421c47 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11113,12 +11113,83 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 	return bss;
 }
 
+static int nl80211_process_links(struct cfg80211_registered_device *rdev,
+				 struct cfg80211_assoc_link *links,
+				 const u8 *ssid, int ssid_len,
+				 struct genl_info *info)
+{
+	unsigned int attrsize = NUM_NL80211_ATTR * sizeof(struct nlattr *);
+	struct nlattr **attrs __free(kfree) = kzalloc(attrsize, GFP_KERNEL);
+	struct nlattr *link;
+	unsigned int link_id;
+	int rem, err;
+
+	if (!attrs)
+		return -ENOMEM;
+
+	nla_for_each_nested(link, info->attrs[NL80211_ATTR_MLO_LINKS], rem) {
+		memset(attrs, 0, attrsize);
+
+		nla_parse_nested(attrs, NL80211_ATTR_MAX, link, NULL, NULL);
+
+		if (!attrs[NL80211_ATTR_MLO_LINK_ID]) {
+			NL_SET_BAD_ATTR(info->extack, link);
+			return -EINVAL;
+		}
+
+		link_id = nla_get_u8(attrs[NL80211_ATTR_MLO_LINK_ID]);
+		/* cannot use the same link ID again */
+		if (links[link_id].bss) {
+			NL_SET_BAD_ATTR(info->extack, link);
+			return -EINVAL;
+		}
+		links[link_id].bss =
+			nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
+					  link_id, link_id);
+		if (IS_ERR(links[link_id].bss)) {
+			err = PTR_ERR(links[link_id].bss);
+			links[link_id].bss = NULL;
+			NL_SET_ERR_MSG_ATTR(info->extack, link,
+					    "Error fetching BSS for link");
+			return err;
+		}
+
+		if (attrs[NL80211_ATTR_IE]) {
+			links[link_id].elems = nla_data(attrs[NL80211_ATTR_IE]);
+			links[link_id].elems_len =
+				nla_len(attrs[NL80211_ATTR_IE]);
+
+			if (cfg80211_find_elem(WLAN_EID_FRAGMENT,
+					       links[link_id].elems,
+					       links[link_id].elems_len)) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    attrs[NL80211_ATTR_IE],
+						    "cannot deal with fragmentation");
+				return -EINVAL;
+			}
+
+			if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						   links[link_id].elems,
+						   links[link_id].elems_len)) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    attrs[NL80211_ATTR_IE],
+						    "cannot deal with non-inheritance");
+				return -EINVAL;
+			}
+		}
+
+		links[link_id].disabled =
+			nla_get_flag(attrs[NL80211_ATTR_MLO_LINK_DISABLED]);
+	}
+
+	return 0;
+}
+
 static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct cfg80211_assoc_request req = {};
-	struct nlattr **attrs = NULL;
 	const u8 *ap_addr, *ssid;
 	unsigned int link_id;
 	int err, ssid_len;
@@ -11257,10 +11328,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	req.link_id = nl80211_link_id_or_invalid(info->attrs);
 
 	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
-		unsigned int attrsize = NUM_NL80211_ATTR * sizeof(*attrs);
-		struct nlattr *link;
-		int rem = 0;
-
 		if (req.link_id < 0)
 			return -EINVAL;
 
@@ -11275,72 +11342,10 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
 		ap_addr = req.ap_mld_addr;
 
-		attrs = kzalloc(attrsize, GFP_KERNEL);
-		if (!attrs)
-			return -ENOMEM;
-
-		nla_for_each_nested(link,
-				    info->attrs[NL80211_ATTR_MLO_LINKS],
-				    rem) {
-			memset(attrs, 0, attrsize);
-
-			nla_parse_nested(attrs, NL80211_ATTR_MAX,
-					 link, NULL, NULL);
-
-			if (!attrs[NL80211_ATTR_MLO_LINK_ID]) {
-				err = -EINVAL;
-				NL_SET_BAD_ATTR(info->extack, link);
-				goto free;
-			}
-
-			link_id = nla_get_u8(attrs[NL80211_ATTR_MLO_LINK_ID]);
-			/* cannot use the same link ID again */
-			if (req.links[link_id].bss) {
-				err = -EINVAL;
-				NL_SET_BAD_ATTR(info->extack, link);
-				goto free;
-			}
-			req.links[link_id].bss =
-				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
-						  req.link_id, link_id);
-			if (IS_ERR(req.links[link_id].bss)) {
-				err = PTR_ERR(req.links[link_id].bss);
-				req.links[link_id].bss = NULL;
-				NL_SET_ERR_MSG_ATTR(info->extack,
-						    link, "Error fetching BSS for link");
-				goto free;
-			}
-
-			if (attrs[NL80211_ATTR_IE]) {
-				req.links[link_id].elems =
-					nla_data(attrs[NL80211_ATTR_IE]);
-				req.links[link_id].elems_len =
-					nla_len(attrs[NL80211_ATTR_IE]);
-
-				if (cfg80211_find_elem(WLAN_EID_FRAGMENT,
-						       req.links[link_id].elems,
-						       req.links[link_id].elems_len)) {
-					NL_SET_ERR_MSG_ATTR(info->extack,
-							    attrs[NL80211_ATTR_IE],
-							    "cannot deal with fragmentation");
-					err = -EINVAL;
-					goto free;
-				}
-
-				if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-							   req.links[link_id].elems,
-							   req.links[link_id].elems_len)) {
-					NL_SET_ERR_MSG_ATTR(info->extack,
-							    attrs[NL80211_ATTR_IE],
-							    "cannot deal with non-inheritance");
-					err = -EINVAL;
-					goto free;
-				}
-			}
-
-			req.links[link_id].disabled =
-				nla_get_flag(attrs[NL80211_ATTR_MLO_LINK_DISABLED]);
-		}
+		err = nl80211_process_links(rdev, req.links, ssid, ssid_len,
+					    info);
+		if (err)
+			goto free;
 
 		if (!req.links[req.link_id].bss) {
 			err = -EINVAL;
@@ -11360,9 +11365,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			err = -EINVAL;
 			goto free;
 		}
-
-		kfree(attrs);
-		attrs = NULL;
 	} else {
 		if (req.link_id >= 0)
 			return -EINVAL;
@@ -11422,7 +11424,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	for (link_id = 0; link_id < ARRAY_SIZE(req.links); link_id++)
 		cfg80211_put_bss(&rdev->wiphy, req.links[link_id].bss);
 	cfg80211_put_bss(&rdev->wiphy, req.bss);
-	kfree(attrs);
 
 	return err;
 }
-- 
2.34.1


