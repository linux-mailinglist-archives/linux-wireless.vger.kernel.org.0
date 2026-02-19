Return-Path: <linux-wireless+bounces-32019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZIHqPclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2B15D853
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46FC43064EA5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6EA30F921;
	Thu, 19 Feb 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvNOtoRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398C2ECE91
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494469; cv=none; b=GWGBJ5h1MHZyIKSaIq9k/+yhypUMx5v+w0QDLc82UVU00Pa2jKLQWNGXnXPF5CcBUw8gCg6a0MAPMm2+kAQi/gthY2MOX/c7dE4MMXWgN73yQv7L8GlrhluR8RSjvUQwg/VrMy8LQvu6ZxxrKy8K5W1N5QnOlag7nKzNO83d2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494469; c=relaxed/simple;
	bh=J0gW3CdpYyQmVdO+r+DkPgB9g9yZBeu0S4A+S0Jnnzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfIlFJivsnOB7bnWmAU7Kk7eWUa6dFREi7fVcfMB1zjXUWkGYuBWR8cWlWoBN4wzy2CPJ6v60Ae29em3TspG5OAZ+4G8oh7U9zceghmrwZAVffbK1p4MmWBLig74T4QkuQlVosvoD6VIyR7s8o/ku4Um3x4qsk805LZEeNshjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvNOtoRG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494468; x=1803030468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0gW3CdpYyQmVdO+r+DkPgB9g9yZBeu0S4A+S0Jnnzg=;
  b=BvNOtoRG+BcCsIKf0JK3oFH5RGTIwMUERwNtSfXs/KLtdj7iDLQ5AX4E
   kwacH5Aikf8tS66QK8QHD82aPMduIfo9phIJd7Sl0GENRAGH4Xsovqt9T
   KZphXos9/Gg73fB8cbptNHyG5xcDaO2EXUz/Ie7mMhPRRXXPVbqFjOsLo
   MTGyz3jFzuZAdi2wEStd6PS8n2ztaKPpMSEEjegeyBTY4GuHs0+KLU6m+
   M9d61Jj9LmBCfGvl5DYB4HP425rLnQS87I6sSCvabQzqD3zcEzoYEUhLq
   YDrURs5JTqA1P0RU5HDiQYa6/rkhMmM0Z/zb9xAgJFvMn/l8DqXquiJ1Z
   g==;
X-CSE-ConnectionGUID: 61XfGlxAR2KqPcBrK06N3g==
X-CSE-MsgGUID: eJqPrLnmTruxtNmfs/UMhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680102"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680102"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:48 -0800
X-CSE-ConnectionGUID: 71HmsdloQDamPlwxMxsOWg==
X-CSE-MsgGUID: 5VJY6PXgR3GG1KCrB0fabQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989027"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 09/15] wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
Date: Thu, 19 Feb 2026 11:47:19 +0200
Message-Id: <20260219114327.4b6f3e4a81b4.I45422adc0df3ad4101d857a92e83f0de5cf241e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32019-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0E2B15D853
X-Rspamd-Action: no action

In NAN, unlike in other modes, there is only one set of (HT, VHT, HE)
capabilities that is used for all channels (and bands) used in the NAN
data path.

This set of capabilities will have to be a special one, for example - have
the minimum of (HT-for-5 GHz, HT-for-2.4 GHz), careful handling of the
bits that have a different meaning for each band, etc.

While we could use the exiting sband/iftype capabilities, and require
identical capabilities for all bands (makes no sense since this means
that we will have VHT capabilities in the 2.4 GHz slot),
or require that only one of the sbands will be set,
or have logic to extract the minimum and handle the conflicting bits -
it seems simpler to add a dedicated set of capabilities which is special
for NAN, and is band agnostic, to be populated by the driver.

That way we also let the driver decide how it wants to handle the
conflicting bits.

Add this special set of these capabilities to wiphy:nan_capabilities, to be
populated by the driver.
Send it to user space.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 11 ++++++
 include/uapi/linux/nl80211.h | 43 ++++++++++++++++++++++++
 net/wireless/core.c          |  4 +++
 net/wireless/nl80211.c       | 65 ++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ccd80868800..1eceb03892d1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5911,6 +5911,12 @@ enum wiphy_nan_flags {
  * @max_channel_switch_time: maximum channel switch time in milliseconds.
  * @dev_capabilities: NAN device capabilities as defined in Wi-Fi Aware (TM)
  *     specification Table 79 (Capabilities field).
+ * @phy: Band-agnostic capabilities for NAN data interfaces. Since NAN
+ *     operates on multiple channels simultaneously, these capabilities apply
+ *     across all bands. Valid only if NL80211_IFTYPE_NAN_DATA is supported.
+ * @phy.ht: HT capabilities (mandatory for NAN data)
+ * @phy.vht: VHT capabilities (optional)
+ * @phy.he: HE capabilities (optional)
  */
 struct wiphy_nan_capa {
 	u32 flags;
@@ -5918,6 +5924,11 @@ struct wiphy_nan_capa {
 	u8 n_antennas;
 	u16 max_channel_switch_time;
 	u8 dev_capabilities;
+	struct {
+		struct ieee80211_sta_ht_cap ht;
+		struct ieee80211_sta_vht_cap vht;
+		struct ieee80211_sta_he_cap he;
+	} phy;
 };
 
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b1584f145eac..44dff379b66b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4436,6 +4436,46 @@ enum nl80211_band_attr {
 
 #define NL80211_BAND_ATTR_HT_CAPA NL80211_BAND_ATTR_HT_CAPA
 
+/**
+ * enum nl80211_nan_phy_cap_attr - NAN PHY capabilities attributes
+ * @__NL80211_NAN_PHY_CAP_ATTR_INVALID: attribute number 0 is reserved
+ * @NL80211_NAN_PHY_CAP_ATTR_HT_MCS_SET: 16-byte attribute containing HT MCS set
+ * @NL80211_NAN_PHY_CAP_ATTR_HT_CAPA: HT capabilities (u16)
+ * @NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_FACTOR: HT A-MPDU factor (u8)
+ * @NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_DENSITY: HT A-MPDU density (u8)
+ * @NL80211_NAN_PHY_CAP_ATTR_VHT_MCS_SET: 8-byte attribute containing VHT MCS set
+ * @NL80211_NAN_PHY_CAP_ATTR_VHT_CAPA: VHT capabilities (u32)
+ * @NL80211_NAN_PHY_CAP_ATTR_HE_MAC: HE MAC capabilities
+ * @NL80211_NAN_PHY_CAP_ATTR_HE_PHY: HE PHY capabilities
+ * @NL80211_NAN_PHY_CAP_ATTR_HE_MCS_SET: HE supported NSS/MCS combinations
+ * @NL80211_NAN_PHY_CAP_ATTR_HE_PPE: HE PPE thresholds
+ * @NL80211_NAN_PHY_CAP_ATTR_MAX: highest NAN PHY cap attribute number
+ * @__NL80211_NAN_PHY_CAP_ATTR_AFTER_LAST: internal use
+ */
+enum nl80211_nan_phy_cap_attr {
+	__NL80211_NAN_PHY_CAP_ATTR_INVALID,
+
+	/* HT capabilities */
+	NL80211_NAN_PHY_CAP_ATTR_HT_MCS_SET,
+	NL80211_NAN_PHY_CAP_ATTR_HT_CAPA,
+	NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_FACTOR,
+	NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_DENSITY,
+
+	/* VHT capabilities */
+	NL80211_NAN_PHY_CAP_ATTR_VHT_MCS_SET,
+	NL80211_NAN_PHY_CAP_ATTR_VHT_CAPA,
+
+	/* HE capabilities */
+	NL80211_NAN_PHY_CAP_ATTR_HE_MAC,
+	NL80211_NAN_PHY_CAP_ATTR_HE_PHY,
+	NL80211_NAN_PHY_CAP_ATTR_HE_MCS_SET,
+	NL80211_NAN_PHY_CAP_ATTR_HE_PPE,
+
+	/* keep last */
+	__NL80211_NAN_PHY_CAP_ATTR_AFTER_LAST,
+	NL80211_NAN_PHY_CAP_ATTR_MAX = __NL80211_NAN_PHY_CAP_ATTR_AFTER_LAST - 1
+};
+
 /**
  * enum nl80211_wmm_rule - regulatory wmm rule
  *
@@ -8594,6 +8634,8 @@ enum nl80211_s1g_short_beacon_attrs {
  * @NL80211_NAN_CAPA_CAPABILITIES: u8 attribute containing the
  *	capabilities of the device as defined in Wi-Fi Aware (TM)
  *	specification Table 79 (Capabilities field).
+ * @NL80211_NAN_CAPA_PHY: nested attribute containing band-agnostic
+ *	capabilities for NAN data path. See &enum nl80211_nan_phy_cap_attr.
  * @__NL80211_NAN_CAPABILITIES_LAST: Internal
  * @NL80211_NAN_CAPABILITIES_MAX: Highest NAN capability attribute.
  */
@@ -8606,6 +8648,7 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPA_NUM_ANTENNAS,
 	NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
 	NL80211_NAN_CAPA_CAPABILITIES,
+	NL80211_NAN_CAPA_PHY,
 	/* keep last */
 	__NL80211_NAN_CAPABILITIES_LAST,
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 923368ce56da..d40dc50a34d8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -835,6 +835,10 @@ int wiphy_register(struct wiphy *wiphy)
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
 
+	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN_DATA)) &&
+		    !wiphy->nan_capa.phy.ht.ht_supported))
+		return -EINVAL;
+
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
 		return -EINVAL;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0b2bdd1d989e..84cfd70eb8fd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2700,6 +2700,68 @@ static int nl80211_put_radios(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_nan_phy_cap(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *nl_phy_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+
+	if (!cfg80211_iftype_allowed(wiphy, NL80211_IFTYPE_NAN_DATA, false, 0))
+		return 0;
+
+	ht_cap = &wiphy->nan_capa.phy.ht;
+	vht_cap = &wiphy->nan_capa.phy.vht;
+	he_cap = &wiphy->nan_capa.phy.he;
+
+	/* HT is mandatory */
+	if (WARN_ON(!ht_cap->ht_supported))
+		return 0;
+
+	nl_phy_cap = nla_nest_start_noflag(msg, NL80211_NAN_CAPA_PHY);
+	if (!nl_phy_cap)
+		return -ENOBUFS;
+
+	if (nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_HT_MCS_SET,
+		    sizeof(ht_cap->mcs), &ht_cap->mcs) ||
+	    nla_put_u16(msg, NL80211_NAN_PHY_CAP_ATTR_HT_CAPA, ht_cap->cap) ||
+	    nla_put_u8(msg, NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_FACTOR,
+		       ht_cap->ampdu_factor) ||
+	    nla_put_u8(msg, NL80211_NAN_PHY_CAP_ATTR_HT_AMPDU_DENSITY,
+		       ht_cap->ampdu_density))
+		goto fail;
+
+	if (vht_cap->vht_supported) {
+		if (nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_VHT_MCS_SET,
+			    sizeof(vht_cap->vht_mcs), &vht_cap->vht_mcs) ||
+		    nla_put_u32(msg, NL80211_NAN_PHY_CAP_ATTR_VHT_CAPA,
+				vht_cap->cap))
+			goto fail;
+	}
+
+	if (he_cap->has_he) {
+		if (nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_HE_MAC,
+			    sizeof(he_cap->he_cap_elem.mac_cap_info),
+			    he_cap->he_cap_elem.mac_cap_info) ||
+		    nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_HE_PHY,
+			    sizeof(he_cap->he_cap_elem.phy_cap_info),
+			    he_cap->he_cap_elem.phy_cap_info) ||
+		    nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_HE_MCS_SET,
+			    sizeof(he_cap->he_mcs_nss_supp),
+			    &he_cap->he_mcs_nss_supp) ||
+		    nla_put(msg, NL80211_NAN_PHY_CAP_ATTR_HE_PPE,
+			    sizeof(he_cap->ppe_thres), he_cap->ppe_thres))
+			goto fail;
+	}
+
+	nla_nest_end(msg, nl_phy_cap);
+	return 0;
+
+fail:
+	nla_nest_cancel(msg, nl_phy_cap);
+	return -ENOBUFS;
+}
+
 static int nl80211_put_nan_capa(struct wiphy *wiphy, struct sk_buff *msg)
 {
 	struct nlattr *nan_caps;
@@ -2726,6 +2788,9 @@ static int nl80211_put_nan_capa(struct wiphy *wiphy, struct sk_buff *msg)
 		       wiphy->nan_capa.dev_capabilities))
 		goto fail;
 
+	if (nl80211_put_nan_phy_cap(wiphy, msg))
+		goto fail;
+
 	nla_nest_end(msg, nan_caps);
 
 	return 0;
-- 
2.34.1


