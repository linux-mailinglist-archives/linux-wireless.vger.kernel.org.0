Return-Path: <linux-wireless+bounces-33949-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fp/A4QMxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33949-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F43338B1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B599319B248
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6733BFE3B;
	Thu, 26 Mar 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8HdxfYr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA61399030
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520111; cv=none; b=TtwnZLuVtL6FwUX2PFybfxKj8Bnx+FHvlIfixP+zrj9WJNjJunk1R4LRpZjxJjEE7Oucyiv7aiKo+W8AQ4uh6zp1yUjoJwzmYcjksCmZHNlAeiI3UZaIa+A1cMactdMe7VBVRQmCQhX34+7fQcR3IvkeWOlVlE2Vg0dD6XJweW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520111; c=relaxed/simple;
	bh=jW3v3+ayvZxgXzGsXSfVeY7oJ4tjVa88JV2ZWIe3GaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irk7y1bBTyLwB3Mrt40ARNuucAQNQQhY+fYhkPMJLBNavDyBFy+8VuFV0cZX0cPp0dJjPNeNS7qMhc29mMz8TeoRQdbS3x2iIoh6UMlJCuktNzhMFuXC4/RHjCgYiOVy5+VtP8t4jDmTZ9xklpP3W7cxY6TQisIHwl7h0G/1jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8HdxfYr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520110; x=1806056110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jW3v3+ayvZxgXzGsXSfVeY7oJ4tjVa88JV2ZWIe3GaQ=;
  b=Z8HdxfYrhgT4AMsuoZvgW5/YieLYsx6lm6M5XBJxmaJfkGAW4rA8fqav
   lu6jNZddFwppueEEEOpYgNsssAtu+M4UrK4IgcwCIXJ/hUrYFHwVnK4Jq
   MDsiSDow326nNaK+oqcWLdqHexK7t80Wjj1PaiFHH4GH1u6RsXMi601HP
   S6kxAp3yOuCFHyd69AYKZyS1AsksE5JGCUhNxrUTlz2mLkWKDJ1Bv5KKW
   Xoz2hZ8OJwRLQVnYCfJZz9SZDsevkmzpGAt8WOvQI0d0rlw6lrpfos5Ek
   PDwpCyT69FKKIeV0PO2RQyD8jQNK0xiUkXlKGumNoXfHhb9dA7+Iv9xQJ
   w==;
X-CSE-ConnectionGUID: TMwmJlM5SZKfCxqVXi190Q==
X-CSE-MsgGUID: X5I2YR2dSzynQKGe49q75A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048558"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048558"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:09 -0700
X-CSE-ConnectionGUID: GUJcxsmOSQqA+D5eF2b1nQ==
X-CSE-MsgGUID: rJvN/JzJRJKslPWHB5tvMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653174"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 02/15] wifi: ieee80211: add more NAN definitions
Date: Thu, 26 Mar 2026 12:14:32 +0200
Message-Id: <20260326121156.ebb52db4c1eb.Ie8142cf92fc8c97c744a7c8b0a94ce3da6ff75ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33949-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 665F43338B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

These will be needed to implement NAN synchronization in mac80211_hwsim.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211-nan.h | 37 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/include/linux/ieee80211-nan.h b/include/linux/ieee80211-nan.h
index ebf28ea651f9..455033955e54 100644
--- a/include/linux/ieee80211-nan.h
+++ b/include/linux/ieee80211-nan.h
@@ -37,4 +37,41 @@
 #define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
 #define NAN_DEV_CAPA_S3_SUPPORTED		0x10
 
+/* NAN attributes, as defined in Wi-Fi Aware (TM) specification 4.0 Table 42 */
+#define NAN_ATTR_MASTER_INDICATION		0x00
+#define NAN_ATTR_CLUSTER_INFO			0x01
+
+struct ieee80211_nan_attr {
+	u8 attr;
+	__le16 length;
+	u8 data[];
+} __packed;
+
+struct ieee80211_nan_master_indication {
+	u8 master_pref;
+	u8 random_factor;
+} __packed;
+
+struct ieee80211_nan_anchor_master_info {
+	union {
+		__le64 master_rank;
+		struct {
+			u8 master_addr[ETH_ALEN];
+			u8 random_factor;
+			u8 master_pref;
+		} __packed;
+	} __packed;
+	u8 hop_count;
+	__le32 ambtt;
+} __packed;
+
+#define for_each_nan_attr(_attr, _data, _datalen)			\
+	for (_attr = (const struct ieee80211_nan_attr *)(_data);	\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) &&					\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_attr >=	\
+		(int)sizeof(*_attr) + le16_to_cpu(_attr->length);	\
+	     _attr = (const struct ieee80211_nan_attr *)		\
+		(_attr->data + le16_to_cpu(_attr->length)))
+
 #endif /* LINUX_IEEE80211_NAN_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b5d649db123f..ffa8f9f77efe 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2240,6 +2240,7 @@ struct ieee80211_multiple_bssid_configuration {
 
 #define WLAN_OUI_WFA			0x506f9a
 #define WLAN_OUI_TYPE_WFA_P2P		9
+#define WLAN_OUI_TYPE_WFA_NAN		0x13
 #define WLAN_OUI_TYPE_WFA_DPP		0x1A
 #define WLAN_OUI_MICROSOFT		0x0050f2
 #define WLAN_OUI_TYPE_MICROSOFT_WPA	1
-- 
2.34.1


