Return-Path: <linux-wireless+bounces-30935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01002D3932F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98373011EC4
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE2D1EBA14;
	Sun, 18 Jan 2026 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7YkriD9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F827E1D7
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722701; cv=none; b=LdxZiqcGXxf93z/+fglJBgIti/7Jx9obGd3iGpza1/TQgSTpDOZ0YzaMO+/TsaQ+iLChDVGLzJH7aqTrz1jWE+6mf8SYfHhXdkNrlPOu9EZjuv4iA3Uv9LUxlD7YAv5rrOCHplAcitW2Wh9xGSanRIWFxjYYBW+t192/6WjLir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722701; c=relaxed/simple;
	bh=L/tQbDKX0FyrdVYkjwJ+ykMPvbtn50872BnFh5i69u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTj2i3BD0Mvje5drIKMwmMz+gKWIqD7yHVN7OAoLZ+EywrvfBwxSiGxByAU7JgQkkNW3tpDEKwP/sS1rzQeJtm0cvW2VeskaekUIXYlhip/kYyOcyTM57RN8FcanPyDzb6VV+y7fj9G6XoFBORZTogldTKA+UNH2OAcisfpWlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7YkriD9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768722691; x=1800258691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/tQbDKX0FyrdVYkjwJ+ykMPvbtn50872BnFh5i69u0=;
  b=Z7YkriD9AdDLevdc2Mjjw/8IFk/Om7FeCb2BZdkQfp4Kh0WRKfHDDyos
   +7h4+m7W/cCCHceA3YdXKG/uUmAxfgW478HFjv8UxG3t4vFxVSLO0fgdi
   RYEDLj8jr7W5PpBBEUMg+o8kCSknZg4cM0ouTdp++90PGCL72OI376KR4
   n1bqsQnxejduWIyXlbB1EYsw2nPLINAl+KESLF0g5qak4NhZjgKWFGVKy
   UmxjDVrdKiumSgyGhicfY5GFR+AU8I2Osnz7jw9Ka8P19sq3rzHG98s2/
   dXT+5ksaQGYJuQrHOFgocRQ1FFo82KvDuXtP30st6fDhN1Ho5GgD0BNp1
   Q==;
X-CSE-ConnectionGUID: pvG+VUmZQJKODIodq7L8Pg==
X-CSE-MsgGUID: dqdZxu2YRbi68fI17rZgEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="87546811"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="87546811"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:30 -0800
X-CSE-ConnectionGUID: x+HCiNWkRliodB9K80ke4w==
X-CSE-MsgGUID: UajXz65aQFyopKkB876I7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236278509"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi 3/3] wifi: cfg80211: ignore link disabled flag from userspace
Date: Sun, 18 Jan 2026 09:51:15 +0200
Message-Id: <20260118093904.754e057896a5.Ifd06f5ef839a93bfd54d0593dc932870f95f3242@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
References: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When the AP has an advertised TID to Link Mapping (TTLM) it shall
include the element in the association response. As such, when this
element is present it needs to be used for the currently dormant links.
See Draft P802.11REVmf_D1.0 section 35.3.7.2.3 ("Negotiation of TTLM")
for the details. The flag is also not usable in case userspace wants to
specify a negotiated TTLM during association.

Note that for the link reconfiguration case, mac80211 did not use the
information. Draft P802.11REVmf_D1.0 states in section 35.3.6.4 ("Link
reconfiguration to the setup links) that we "shall operate with all the
TIDs mapped to the newly added links ..."

All this means that the flag is not needed. The implementation should
parse the information from the association response.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  3 ---
 include/uapi/linux/nl80211.h |  5 +++--
 net/wireless/nl80211.c       | 10 ----------
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..2900202588a5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3221,8 +3221,6 @@ struct cfg80211_auth_request {
  *	if this is %NULL for a link, that link is not requested
  * @elems: extra elements for the per-STA profile for this link
  * @elems_len: length of the elements
- * @disabled: If set this link should be included during association etc. but it
- *	should not be used until enabled by the AP MLD.
  * @error: per-link error code, must be <= 0. If there is an error, then the
  *	operation as a whole must fail.
  */
@@ -3230,7 +3228,6 @@ struct cfg80211_assoc_link {
 	struct cfg80211_bss *bss;
 	const u8 *elems;
 	size_t elems_len;
-	bool disabled;
 	int error;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..8433bac48112 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2880,8 +2880,9 @@ enum nl80211_commands {
  *	index. If the userspace includes more RNR elements than number of
  *	MBSSID elements then these will be added in every EMA beacon.
  *
- * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
- *	disabled.
+ * @NL80211_ATTR_MLO_LINK_DISABLED: Unused. It was used to indicate that a link
+ *	is disabled during association. However, the AP will send the
+ *	information by including a TTLM in the association response.
  *
  * @NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA: Include BSS usage data, i.e.
  *	include BSSes that can only be used in restricted scenarios and/or
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..03efd45c007f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12241,9 +12241,6 @@ static int nl80211_process_links(struct cfg80211_registered_device *rdev,
 				return -EINVAL;
 			}
 		}
-
-		links[link_id].disabled =
-			nla_get_flag(attrs[NL80211_ATTR_MLO_LINK_DISABLED]);
 	}
 
 	return 0;
@@ -12423,13 +12420,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 		}
 
-		if (req.links[req.link_id].disabled) {
-			GENL_SET_ERR_MSG(info,
-					 "cannot have assoc link disabled");
-			err = -EINVAL;
-			goto free;
-		}
-
 		if (info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS])
 			req.ext_mld_capa_ops =
 				nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
-- 
2.34.1


