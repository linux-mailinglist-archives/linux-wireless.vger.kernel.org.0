Return-Path: <linux-wireless+bounces-16965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424009FF2E0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7D3A21A4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF1175AB;
	Wed,  1 Jan 2025 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+Wl+I0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF33199B8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707977; cv=none; b=C0KFS9dDrLxZRuKbJMwUCMAb7cYyY0K8i4zHxN06braRh+2pFeJ3N9azTRcNolkA0n45jHda/4u56zZnG7R7T0EbEiBltD8TrGgbxieN7OHtUm8uQHAgwjjIF2c6a7nZkC0HyyyKTlbv/Jyuhfy8Nk1KXxbSfYtr1d7HI20/1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707977; c=relaxed/simple;
	bh=8fvl1CmtpE0JFqLaLflLPMT/O/aAZ6DT5N4HUtUPRNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsnKIibmd2ulQrOmpibxpEhJcdOAkC3g/JgmwFGMY6NzP383rCpWjHiq9tfC8WmFO3CPZc8SU0PW/KZdMsEl1gLjA2lKTbtZbShnmxwzv3J+ETX7zwmbq30XLN02QPWrFts8uHPohlD11EHhOUEKZxxaStet7xLZbaYK3jRH99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+Wl+I0U; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707976; x=1767243976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fvl1CmtpE0JFqLaLflLPMT/O/aAZ6DT5N4HUtUPRNw=;
  b=O+Wl+I0Uta6ohEz4icFBH/tRSFgYYnPH0f7VESay5SumzfZ5gnozhV/z
   uHpST8DIbnbw5eFQb0abIz0F6fn8DV8ccsS1NV59Nnu0zrzg2Vd4p6G/e
   f8BOebmv8CbgN98xIZfTO0AZ5x8oTCbQCizhZOfj82rVT7b8rw1xHk0p9
   duNA56RcyvdEzV73EtaDAPASQ4tIwuVAjuajOPQj6GnCDMeVQgFGIZqTJ
   eNTz20AFTV942pzaeXp0TN2/tpm7tjMQ8Zd+ugDnebINBSpZyvlAEW2Oe
   V8M9mt/2KXvyLDisOBoRf3mjyTFN8oxTs9afSgcItJ1mnawGMHY1yvTvO
   A==;
X-CSE-ConnectionGUID: ctCYR/NNQv6J4mv2LpAT7w==
X-CSE-MsgGUID: MH4G4kewSFWgYWs1aYKQHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194442"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:15 -0800
X-CSE-ConnectionGUID: pb5XFoiTTnmzAd8mRdkcag==
X-CSE-MsgGUID: Pnf192ysTN6DLiQWSGhzeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618939"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/19] wifi: nl80211: permit userspace to pass supported selectors
Date: Wed,  1 Jan 2025 07:05:35 +0200
Message-Id: <20250101070249.fe67b871cc39.Ieb98390328927e998e612345a58b6dbc00b0e3a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Currently the SAE_H2E selector already exists, which needs to be
implemented by the SME. As new such selectors might be added in the
future, add a feature to permit userspace to report a selector as
supported.

If not given, the kernel should assume that userspace does support
SAE_H2E.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7790af534b7f..8a38d66be2c9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3023,6 +3023,10 @@ static inline const u8 *ieee80211_bss_get_ie(struct cfg80211_bss *bss, u8 id)
  *
  * @bss: The BSS to authenticate with, the callee must obtain a reference
  *	to it if it needs to keep it.
+ * @supported_selectors: List of selectors that should be assumed to be
+ *	supported by the station.
+ *	SAE_H2E must be assumed supported if set to %NULL.
+ * @supported_selectors_len: Length of supported_selectors in octets.
  * @auth_type: Authentication type (algorithm)
  * @ie: Extra IEs to add to Authentication frame or %NULL
  * @ie_len: Length of ie buffer in octets
@@ -3045,6 +3049,8 @@ struct cfg80211_auth_request {
 	struct cfg80211_bss *bss;
 	const u8 *ie;
 	size_t ie_len;
+	const u8 *supported_selectors;
+	u8 supported_selectors_len;
 	enum nl80211_auth_type auth_type;
 	const u8 *key;
 	u8 key_len;
@@ -3124,6 +3130,10 @@ enum cfg80211_assoc_req_flags {
  *	included in the Current AP address field of the Reassociation Request
  *	frame.
  * @flags:  See &enum cfg80211_assoc_req_flags
+ * @supported_selectors: supported selectors in IEEE 802.11 format
+ *	(or %NULL for no change).
+ *	If %NULL, then support for SAE_H2E should be assumed.
+ * @supported_selectors_len: Length of supported_selectors in octets.
  * @ht_capa:  HT Capabilities over-rides.  Values set in ht_capa_mask
  *	will be used in ht_capa.  Un-supported values will be ignored.
  * @ht_capa_mask:  The bits of ht_capa which are to be used.
@@ -3150,6 +3160,8 @@ struct cfg80211_assoc_request {
 	struct cfg80211_crypto_settings crypto;
 	bool use_mfp;
 	u32 flags;
+	const u8 *supported_selectors;
+	u8 supported_selectors_len;
 	struct ieee80211_ht_cap ht_capa;
 	struct ieee80211_ht_cap ht_capa_mask;
 	struct ieee80211_vht_cap vht_capa, vht_capa_mask;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6d11437596b9..ee1cf19803ea 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2871,6 +2871,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
  *	A value of 0 means all radios.
  *
+ * @NL80211_ATTR_SUPPORTED_SELECTORS: supported selectors, array of
+ *	supported selectors as defined by IEEE 802.11 7.3.2.2 but without the
+ *	length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
+ *	This can be used to provide a list of selectors that are implemented
+ *	by the supplicant. If not given, support for SAE_H2E is assumed.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3421,6 +3427,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VIF_RADIO_MASK,
 
+	NL80211_ATTR_SUPPORTED_SELECTORS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3465,6 +3473,7 @@ enum nl80211_attrs {
 #define NL80211_WIPHY_NAME_MAXLEN		64
 
 #define NL80211_MAX_SUPP_RATES			32
+#define NL80211_MAX_SUPP_SELECTORS		128
 #define NL80211_MAX_SUPP_HT_RATES		77
 #define NL80211_MAX_SUPP_REG_RULES		128
 #define NL80211_TKIP_DATA_OFFSET_ENCR_KEY	0
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8789d8b73f0f..39c114265db8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -294,6 +294,21 @@ static int validate_he_capa(const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_supported_selectors(const struct nlattr *attr,
+					struct netlink_ext_ack *extack)
+{
+	const u8 *supported_selectors = nla_data(attr);
+	u8 supported_selectors_len = nla_len(attr);
+
+	/* The top bit must not be set as it is not part of the selector */
+	for (int i = 0; i < supported_selectors_len; i++) {
+		if (supported_selectors[i] & 0x80)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -830,6 +845,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
 	[NL80211_ATTR_VIF_RADIO_MASK] = { .type = NLA_U32 },
+	[NL80211_ATTR_SUPPORTED_SELECTORS] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_supported_selectors,
+				       NL80211_MAX_SUPP_SELECTORS),
 };
 
 /* policy for the key attributes */
@@ -10858,6 +10876,13 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		req.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
 	}
 
+	if (info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]) {
+		req.supported_selectors =
+			nla_data(info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]);
+		req.supported_selectors_len =
+			nla_len(info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]);
+	}
+
 	auth_type = nla_get_u32(info->attrs[NL80211_ATTR_AUTH_TYPE]);
 	if (!nl80211_valid_auth_type(rdev, auth_type, NL80211_CMD_AUTHENTICATE))
 		return -EINVAL;
@@ -11140,6 +11165,13 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_PREV_BSSID])
 		req.prev_bssid = nla_data(info->attrs[NL80211_ATTR_PREV_BSSID]);
 
+	if (info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]) {
+		req.supported_selectors =
+			nla_data(info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]);
+		req.supported_selectors_len =
+			nla_len(info->attrs[NL80211_ATTR_SUPPORTED_SELECTORS]);
+	}
+
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HT]))
 		req.flags |= ASSOC_REQ_DISABLE_HT;
 
-- 
2.34.1


