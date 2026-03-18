Return-Path: <linux-wireless+bounces-33387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJSED0+eumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0102BBBD1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF1331BE899
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298120E030;
	Wed, 18 Mar 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyUp4aU5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD863CFF6E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837584; cv=none; b=LFYuf3odwO3FFcURoTEdvyTTt3JXKnhz8HhevmIVa5xU5Vqa4KKettiem89hYfem24XrI5obLf1hSyCZx9Y/sQWqHV2SRw5Pz4y18MgsTDVOGjgQ9SE/VSRLYR20mwNp526Sz66GVaounJz9YslaJlp1MjNw/NUNSvnGbP1tUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837584; c=relaxed/simple;
	bh=/49KyJz64A6UG39Cy+tyyi7gQbQI7UXutrVU/64v5fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCVk9J0x0VZ+x1SsIeeFZoKiFULmmBUAkIlA5gHd2hHH6y+/cXYiHsCPqyFXhvTdy+pO+Urqp8NL/nmrOxGAdBgo5gBZtcgktnMXZ7IqNPhJ8jbLe97jq9YM2D/DbBYGyw/tgKAUaHmbHotjUVUXsBCLVURYUe5+Swt3xbiZC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyUp4aU5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837583; x=1805373583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/49KyJz64A6UG39Cy+tyyi7gQbQI7UXutrVU/64v5fA=;
  b=HyUp4aU51OkYJ+QhrfTsdFsX4RiSsovJXJLu93LViGdcCXjiQablYDLg
   1d0tKgQXsu+El+2EOQdNhecXKNqsoyYFDJrT7dUOsLXrkXwEBSw4io1Jr
   0Aksa/FgppPp3T95EtErY3Zv0iDcP9wCpwawOcGUkkrPq+CjGvbpJPZse
   p0Urf9W+pSlhmFbUXv6m+1rI2eJ2AzXNepITH8vjE9CIyrcKFi4+q+pfv
   VXMK0srP9gsU1B3rmPQvIrLPX8xeWnCbsYgeMQ6HLtNGTj67knb3vk+Kj
   eZp07W9JutG2h4dn4LolarTW1pR3/OQpUIY+0z+H8AAKQS6RxtZaRODvs
   A==;
X-CSE-ConnectionGUID: bf7WXrE8TMe9gL2wwXhYXw==
X-CSE-MsgGUID: zxNMgBtJR3KctpuZhfigGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519268"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519268"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:43 -0700
X-CSE-ConnectionGUID: hwsa3vbMTQ2SYZ+YW5opzw==
X-CSE-MsgGUID: 9YUjeqGkRWuK0TOwq1G61w==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 04/12] wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
Date: Wed, 18 Mar 2026 14:39:18 +0200
Message-Id: <20260318123926.206536-5-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33387-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CB0102BBBD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Link: https://patch.msgid.link/20260219114327.4b6f3e4a81b4.I45422adc0df3ad4101d857a92e83f0de5cf241e1@changeid
---
 include/net/cfg80211.h       | 11 ++++++
 include/uapi/linux/nl80211.h | 43 ++++++++++++++++++++++++
 net/wireless/core.c          |  4 +++
 net/wireless/nl80211.c       | 65 ++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1797ece50295..60cd0fbe9a46 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5913,6 +5913,12 @@ enum wiphy_nan_flags {
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
@@ -5920,6 +5926,11 @@ struct wiphy_nan_capa {
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
index 3984c176f9e7..c94e957a3467 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4462,6 +4462,46 @@ enum nl80211_band_attr {
 
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
@@ -8635,6 +8675,8 @@ enum nl80211_s1g_short_beacon_attrs {
  * @NL80211_NAN_CAPA_CAPABILITIES: u8 attribute containing the
  *	capabilities of the device as defined in Wi-Fi Aware (TM)
  *	specification Table 79 (Capabilities field).
+ * @NL80211_NAN_CAPA_PHY: nested attribute containing band-agnostic
+ *	capabilities for NAN data path. See &enum nl80211_nan_phy_cap_attr.
  * @__NL80211_NAN_CAPABILITIES_LAST: Internal
  * @NL80211_NAN_CAPABILITIES_MAX: Highest NAN capability attribute.
  */
@@ -8647,6 +8689,7 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPA_NUM_ANTENNAS,
 	NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
 	NL80211_NAN_CAPA_CAPABILITIES,
+	NL80211_NAN_CAPA_PHY,
 	/* keep last */
 	__NL80211_NAN_CAPABILITIES_LAST,
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 200b97f912eb..6783e0672dcb 100644
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
index b3c68d281c3f..07ec0621d4de 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2721,6 +2721,68 @@ static int nl80211_put_radios(struct wiphy *wiphy, struct sk_buff *msg)
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
@@ -2747,6 +2809,9 @@ static int nl80211_put_nan_capa(struct wiphy *wiphy, struct sk_buff *msg)
 		       wiphy->nan_capa.dev_capabilities))
 		goto fail;
 
+	if (nl80211_put_nan_phy_cap(wiphy, msg))
+		goto fail;
+
 	nla_nest_end(msg, nan_caps);
 
 	return 0;
-- 
2.34.1


