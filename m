Return-Path: <linux-wireless+bounces-20031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B27A57E57
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EE5188D6F7
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD961A4F2F;
	Sat,  8 Mar 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi8Dscig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A2374FF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467984; cv=none; b=eYY0AHqLvaH7D8dwDTf8Lqi/FOP7wzSK7oVh+uhRDZrfo0glXJje7ayqKHPq1zcMS3X8FVWw37IgA9xd3gB5+503RRGPVLO5O9PNlRROSpHDcwQme9Qd08jBB2wGtoxttX5/g0kyuaaYtE/ync0CrnKZeokpvlcehEpZdORWJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467984; c=relaxed/simple;
	bh=f3/dVoJrP7n351BUZdWxgBeW1BIdQN/cWOTkROPjs+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6b4pp51m6ps8RLWTnDX4f18/TbrgkYoftOLWFQSEEUicfqovZYNKpnP4RUYNHvktIYu+KxlVggQllqC1yPGU40LhJ09f6xgTLk1bnvVObOz6rTqbiLSnA5W65iKXYBujbCvXbKGTg2iomxhSs64cYWCFDIb5f5N/ALk9/NTJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi8Dscig; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467982; x=1773003982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3/dVoJrP7n351BUZdWxgBeW1BIdQN/cWOTkROPjs+U=;
  b=Pi8Dscigeq2EIMiq7rN3bvupJt35/A6YE8Y5ZNhIY8xdgo2pcihVVR3a
   WTII29tZgGIRKQ3jdHZ1ofTeKIt53sw0lo33ENjHjmp5U0AiTHYmOUpif
   zGmnMea7Cd57Qw92CRLH5wgoZfVSfRNztVDtnPq2pynLAI8aG7u6DozJ0
   L1tRU8oIGm3dLuMpX5e2M29DbNDpU4RuUIfWhH7pKX4VrpHzlyiiyLVnH
   JLBve2VozdCWRXhGIAU8u4gDsEr5yvnN01nqI2ksnaecNsvUyZE04fhTb
   aK0aloNpMAAOuuHmKeI+vCVUmfkf7zVXVOsXu+c3a8aOb/CpzxNO3dw8B
   g==;
X-CSE-ConnectionGUID: HqVe5VCnQpm2DfRpy5/U3Q==
X-CSE-MsgGUID: z9lgGxZ6QyGVYo+CTifLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413025"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413025"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:57 -0800
X-CSE-ConnectionGUID: ud0GzQibSbeKGgkFNCgTLw==
X-CSE-MsgGUID: 6lbN/PLKSJ+MtvHMWk5e9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644357"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 02/15] wifi: cfg80211: allow setting extended MLD capa/ops
Date: Sat,  8 Mar 2025 23:03:28 +0200
Message-Id: <20250308225541.bd52078b5f65.I4dd8f53b0030db7ea87a2e0920989e7e2c7b5345@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
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


