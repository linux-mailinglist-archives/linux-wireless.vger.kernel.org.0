Return-Path: <linux-wireless+bounces-16897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1B9FE287
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2541611D2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8ED13D52E;
	Mon, 30 Dec 2024 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZVGl6Zn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AD183CA9
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534591; cv=none; b=KNGnysx16vu0NlYGRfxAnEmo73HmcnISqBtLhPoh3e3Bhe4zLfiJCKkVuq+X2j+LsuvXBn14kslN3NvLgUyoXbaqVGYUQI35Qs8F0vdLk9t4lc7Z/Aj9P1MmAlqxLN/AaFEOWwLuU+YhwCEXrFoGG0/KtoRX3V/IG+a42NHXsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534591; c=relaxed/simple;
	bh=d9tknz9yvTJGrWyGgZ47yVZtGOZCDZkPwAn4fFnYETI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyCsy1q6RiJRT/fwlqaSGPq9ydL7xLt+N+g+HqPhsT7gR+Znl+7kV2GwgBgRIxhJbimQQ8EspLOOnUB4dwPljmjdoHrF8F0I5lGGhSQWKCzNIEABQPpF8x52StvD16mfltl+u7iBLNqpZkRkYqtVPH0BaP/C0HJKVjgF7uJIDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZVGl6Zn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534590; x=1767070590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9tknz9yvTJGrWyGgZ47yVZtGOZCDZkPwAn4fFnYETI=;
  b=BZVGl6Zn217Mhfp1xyUBeQo3+BZmwxiadzmr2gODi18WnKr6YqujajxD
   EkRtDpCvd7Yf/Pn9FL3PpU4fEywdiGmZXwbNxqt5x95Ig3/wt9hwte3Tb
   +4L8DaQGzvXN4dWlFY1jlMre8gj8YaQnbjnOvplWAgwRQamlHAwlRlarQ
   g5m7LRMSRI7Efqic0DAA19xo14L1Rs1W+39IZwNwyDOMvrK5RyKJVtmxn
   6YUgJhTNEOKeowTV3zQeFwoFqmtG75T1y2PPRv4s3PiMNvgptgRuFdFug
   JAd3pOLpbhEkHwSZZwcuxgwF8y2LhG01oC+brVQe5ig0tRXee+7RE3Yax
   A==;
X-CSE-ConnectionGUID: Y3osPcoKRv6n7nqoKmmoog==
X-CSE-MsgGUID: rrowkVl8QGiHNqC6k5ix6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405035"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405035"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:29 -0800
X-CSE-ConnectionGUID: voNmoSVPScS1yuC/22fD/A==
X-CSE-MsgGUID: AHnQwqzQSCG6uw+XVaEw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758930"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: nl80211: Split the links handling of an association request
Date: Mon, 30 Dec 2024 06:55:53 +0200
Message-Id: <20241230065327.d13b00994d12.I27a51c8c1d455f0a6d5b59f93f2c9ac49282febb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
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
index 8789d8b73f0f..dd9340990ffe 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11088,12 +11088,83 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
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
@@ -11225,10 +11296,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	req.link_id = nl80211_link_id_or_invalid(info->attrs);
 
 	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
-		unsigned int attrsize = NUM_NL80211_ATTR * sizeof(*attrs);
-		struct nlattr *link;
-		int rem = 0;
-
 		if (req.link_id < 0)
 			return -EINVAL;
 
@@ -11243,72 +11310,10 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
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
@@ -11328,9 +11333,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			err = -EINVAL;
 			goto free;
 		}
-
-		kfree(attrs);
-		attrs = NULL;
 	} else {
 		if (req.link_id >= 0)
 			return -EINVAL;
@@ -11390,7 +11392,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	for (link_id = 0; link_id < ARRAY_SIZE(req.links); link_id++)
 		cfg80211_put_bss(&rdev->wiphy, req.links[link_id].bss);
 	cfg80211_put_bss(&rdev->wiphy, req.bss);
-	kfree(attrs);
 
 	return err;
 }
-- 
2.34.1


