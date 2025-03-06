Return-Path: <linux-wireless+bounces-19877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5013AA5482C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2731719F3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF22204F70;
	Thu,  6 Mar 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdMHz4Nd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F771FCCFA
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257822; cv=none; b=c3gEu1Y4IUGkgzIy7CG4u0VHJ2sMxoBGVqtk/KuWLpaeM9zjOtjOWT7bFhe9+EKNF825iiq66xedV0eNhGnbSnYQdvvElm/VKQ6oZrJtoEFcZq3asArtR6RLlPng9F/sV0iAciqnVW4x/oOCVb/+7ngigkPoiECjggCiTse9JUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257822; c=relaxed/simple;
	bh=f3/dVoJrP7n351BUZdWxgBeW1BIdQN/cWOTkROPjs+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxmvX211np90NIy+TuyYSrSoPu5YBxEx6p+UqvvssEsKtVzEOsImFI4d4hnpdhPkuu2imptN9NGnYqxVgjQgMZSaP/wpsuHkPJqD8AQMLKOadrd+tuKO91IXG5J4BjjQGqmPAWQ6PG0q0NoLitZynSuxLkF3Q04rfHAaNtEG2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdMHz4Nd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257822; x=1772793822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3/dVoJrP7n351BUZdWxgBeW1BIdQN/cWOTkROPjs+U=;
  b=IdMHz4Nd9OyAD4sxh6q6/BaRobGBx1gE5hZu6fkgZNE3uicBajTZs5q5
   ASL6ctj3nRx67Lg495zUqQ40SJZQXcuuBspB1DxZgMpou+sNuIweOXxRv
   r5nMUa5mP53HdPuyJq1qsBITcnI7oo23ObwN0kCuH52yP7PKeX+DmB51u
   ksUd6TPxGN52jY8ZYWuzcHgcAjJzOoY6EnhOZa4flaMJ/XvyoSrhV6Kkz
   Nxpnwm0UlE+OXxBBNJ3WzhN9SRDTl1Oyjs+b9nPjpUp99ajb/WhPVL/qD
   nXvMn1VQRdPg5ep0W6bYoD6BxyVjQGXcTpYLJsgInb+1e5hpu/TlLEpw3
   A==;
X-CSE-ConnectionGUID: palgtoxQSYCzP4MCEKtI0g==
X-CSE-MsgGUID: oEsvNZZFQ4+IGrMDxIX3bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844472"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:42 -0800
X-CSE-ConnectionGUID: /AYx0WEGQSWRYVLesKcmSQ==
X-CSE-MsgGUID: 7asHtTDwRfKG64f//tXyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797710"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: cfg80211: allow setting extended MLD capa/ops
Date: Thu,  6 Mar 2025 12:43:13 +0200
Message-Id: <20250306124057.b42976eb82b4.I4dd8f53b0030db7ea87a2e0920989e7e2c7b5345@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some extended MLD capabilities and operations bits (currently
the "BTM MLD Recommendataion For Multiple APs Support" bit)
may depend on userspace capabilities. Allow userspace to pass
the values for this field that it supports to the association
and link reconfiguration operations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 10 +++++++++-
 net/wireless/nl80211.c       | 12 ++++++++++++
 net/wireless/trace.h         |  4 ++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c7cfef104896..29b9cf0fe6c8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3086,10 +3086,13 @@ struct cfg80211_assoc_link {
  * struct cfg80211_ml_reconf_req - MLO link reconfiguration request
  * @add_links: data for links to add, see &struct cfg80211_assoc_link
  * @rem_links: bitmap of links to remove
+ * @ext_mld_capa_ops: extended MLD capabilities and operations set by
+ *	userspace for the ML reconfiguration action frame
  */
 struct cfg80211_ml_reconf_req {
 	struct cfg80211_assoc_link add_links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 rem_links;
+	u16 ext_mld_capa_ops;
 };
 
 /**
@@ -3164,6 +3167,8 @@ enum cfg80211_assoc_req_flags {
  *	the link on which the association request should be sent
  * @ap_mld_addr: AP MLD address in case of MLO association request,
  *	valid iff @link_id >= 0
+ * @ext_mld_capa_ops: extended MLD capabilities and operations set by
+ *	userspace for the association
  */
 struct cfg80211_assoc_request {
 	struct cfg80211_bss *bss;
@@ -3184,6 +3189,7 @@ struct cfg80211_assoc_request {
 	struct cfg80211_assoc_link links[IEEE80211_MLD_MAX_NUM_LINKS];
 	const u8 *ap_mld_addr;
 	s8 link_id;
+	u16 ext_mld_capa_ops;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9d8ecf20ef0d..c59075acdb10 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -2893,6 +2893,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_EPCS: Flag attribute indicating that EPCS is enabled for a
  *	station interface.
  *
+ * @NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS: Extended MLD capabilities and
+ *	operations that userspace implements to use during association/ML
+ *	link reconfig, currently only "BTM MLD Recommendation For Multiple
+ *	APs Support". Drivers may set additional flags that they support
+ *	in the kernel or device.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3448,6 +3454,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MLO_RECONF_REM_LINKS,
 	NL80211_ATTR_EPCS,
 
+	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fe706f70ac7e..e2e8c368fbbf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -850,6 +850,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				       NL80211_MAX_SUPP_SELECTORS),
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
+	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -11373,6 +11374,10 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			err = -EINVAL;
 			goto free;
 		}
+
+		if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+			req.ext_mld_capa_ops =
+				nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
 	} else {
 		if (req.link_id >= 0)
 			return -EINVAL;
@@ -11382,6 +11387,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		if (IS_ERR(req.bss))
 			return PTR_ERR(req.bss);
 		ap_addr = req.bss->bssid;
+
+		if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+			return -EINVAL;
 	}
 
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
@@ -16532,6 +16540,10 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
+		req.ext_mld_capa_ops =
+			nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
+
 	err = cfg80211_assoc_ml_reconf(rdev, dev, &req);
 
 out:
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index b82dc7282c20..4ed9fada4ec0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1378,6 +1378,7 @@ TRACE_EVENT(rdev_assoc,
 		__dynamic_array(u8, fils_kek, req->fils_kek_len)
 		__dynamic_array(u8, fils_nonces,
 				req->fils_nonces ? 2 * FILS_NONCE_LEN : 0)
+		__field(u16, ext_mld_capa_ops)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -1404,6 +1405,7 @@ TRACE_EVENT(rdev_assoc,
 		if (req->fils_nonces)
 			memcpy(__get_dynamic_array(fils_nonces),
 			       req->fils_nonces, 2 * FILS_NONCE_LEN);
+		__entry->ext_mld_capa_ops = req->ext_mld_capa_ops;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", previous bssid: %pM, use mfp: %s, flags: 0x%x",
@@ -4149,6 +4151,7 @@ TRACE_EVENT(rdev_assoc_ml_reconf,
 		NETDEV_ENTRY
 		__field(u16, add_links)
 		__field(u16, rem_links)
+		__field(u16, ext_mld_capa_ops)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -4160,6 +4163,7 @@ TRACE_EVENT(rdev_assoc_ml_reconf,
 		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
 			if (req->add_links[i].bss)
 				__entry->add_links |= BIT(i);
+		__entry->ext_mld_capa_ops = req->ext_mld_capa_ops;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", add_links=0x%x, rem_links=0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-- 
2.34.1


