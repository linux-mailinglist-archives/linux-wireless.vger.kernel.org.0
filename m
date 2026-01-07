Return-Path: <linux-wireless+bounces-30452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F108CFDF30
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A2B315D6BF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3232A3E1;
	Wed,  7 Jan 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA0J8tPL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA791329E58
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792025; cv=none; b=rkLzVKtVrIiQ/g/+3IXx0xvWH/OUDZ0+vFPRi5VNluS1Njnroz84xRFTWjtSZgv63pDt/p6nyQLkE9WBtUcHjopKMtmFkuunbWY6BYACML5k2sXkIN/dZVT5kRHR87wwP/BwghXoCqR7mGEfEiQqIFEGJbMzVjpjqcEX3TJxWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792025; c=relaxed/simple;
	bh=f9/dzM7wZ4ikiOgfrk1h4v1Br9afjMhAjxb9oFcj2d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/kW91VKmwVAD4xmrkjB9fmdyBpLEUGADZU8V7PPlqcrfyvkqtgRZF/a2+NSAtHUMWpa3KpEm2gpvyJHRj4RjZQJN45fc5tzzUK9G70Z+uPDODHACXbpWwjjzVSfIUI0mjQwytkNi59TwOGf8O0Mve93CO6arV2XqiW5JOssyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA0J8tPL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792024; x=1799328024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f9/dzM7wZ4ikiOgfrk1h4v1Br9afjMhAjxb9oFcj2d4=;
  b=LA0J8tPLuoE72RU9hW6l6up5ED0L5s/iHrNE89MSL6dRhZphQhgKjo+z
   fVu6mzHdfmoCwCrLz21HFeTHq/G6Ry6x6S42U2NJX5VQUeDhrvT1SGxsD
   3xDZjDnl4QRD2ZfGKzdm4gGLL1KXCOaBdsHfN2Q9wYtYnp2uaYgYgaTEb
   kE1QO2Vw2CifHz/U1kB+jKIJYM8wU6PaPyc7ORP9D5myEaheTqAH2Vudc
   E3WI1wa4ZxKImhPZqXp7V/2TAWtvg0+eRzibnPVOZqGz65fJW+Z9h7hxJ
   Pui1ojlCUbYVUWNmUkThuEHj9uCzv9EJRP3h9AC/X2DE6o325py0VNqTY
   w==;
X-CSE-ConnectionGUID: iOeiWcp+Rg2sATfEh3FACA==
X-CSE-MsgGUID: dv52BSPTQyWA5MblwJwXjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576865"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576865"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:24 -0800
X-CSE-ConnectionGUID: aSV7ahDFTISOuArMgJwtPw==
X-CSE-MsgGUID: cfuT6rcKQJWs0LO2SFP8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
Date: Wed,  7 Jan 2026 15:19:57 +0200
Message-Id: <20260107150057.98723ca2b3a7.I45422adc0df3ad4101d857a92e83f0de5cf241e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

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
 net/wireless/core.c          |  2 +-
 net/wireless/nl80211.c       | 65 ++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index bae0d3f27315..2f58dfe7b392 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5820,6 +5820,12 @@ enum wiphy_nan_flags {
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
@@ -5827,6 +5833,11 @@ struct wiphy_nan_capa {
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
index 27fabbdab8c6..751d613bc9bf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4370,6 +4370,46 @@ enum nl80211_band_attr {
 
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
@@ -8457,6 +8497,8 @@ enum nl80211_s1g_short_beacon_attrs {
  * @NL80211_NAN_CAPA_CAPABILITIES: u8 attribute containing the
  *	capabilities of the device as defined in Wi-Fi Aware (TM)
  *	specification Table 79 (Capabilities field).
+ * @NL80211_NAN_CAPA_PHY: nested attribute containing band-agnostic
+ *	capabilities for NAN data path. See &enum nl80211_nan_phy_cap_attr.
  * @__NL80211_NAN_CAPABILITIES_LAST: Internal
  * @NL80211_NAN_CAPABILITIES_MAX: Highest NAN capability attribute.
  */
@@ -8469,6 +8511,7 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPA_NUM_ANTENNAS,
 	NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
 	NL80211_NAN_CAPA_CAPABILITIES,
+	NL80211_NAN_CAPA_PHY,
 	/* keep last */
 	__NL80211_NAN_CAPABILITIES_LAST,
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 815402860b39..60bc4f67b958 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -826,7 +826,7 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 
 	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN_DATA)) &&
-		    wiphy->n_radio > 1))
+		    (wiphy->n_radio > 1 || !wiphy->nan_capa.phy.ht.ht_supported)))
 		return -EINVAL;
 
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cf63f114bd1c..0cf3db9315e9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2606,6 +2606,68 @@ static int nl80211_put_radios(struct wiphy *wiphy, struct sk_buff *msg)
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
@@ -2632,6 +2694,9 @@ static int nl80211_put_nan_capa(struct wiphy *wiphy, struct sk_buff *msg)
 		       wiphy->nan_capa.dev_capabilities))
 		goto fail;
 
+	if (nl80211_put_nan_phy_cap(wiphy, msg))
+		goto fail;
+
 	nla_nest_end(msg, nan_caps);
 
 	return 0;
-- 
2.34.1


