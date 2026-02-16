Return-Path: <linux-wireless+bounces-31908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPtGOFSSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2AE147D31
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 039F0300AB20
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DD29C325;
	Mon, 16 Feb 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Osb4Y5SV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111692D0602
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278916; cv=none; b=VECGc2mncA1Zk5hhowHDoX8LdL9vs623RAaoIZZQIiqdUyO7uCA4WgU6TuUDQej1yDpaxRRqE9qPP2vFoso3KpWUu5NjsXZWLTXcp38X5KCMl4rOJKW/nP4xJ4VtNGtYbpSSqD3Bdjho6Hcvs2UWvwTVhwTwR1hCvOMbc4dHacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278916; c=relaxed/simple;
	bh=vnU5I2550VT3Fp1uraIBO49ULp35TZkVTVP9KyLk+nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXytRfqw5oT09awnUQjH7QVN1noDSAr2Etf4YGoDyIkzfdjdZ6MyWfygNHw10qWcYAv+e1CJOhES2AfR4nSv542XdsljCHiwTu6HcqsDRkI/JqU0UVKwIf+e2Rez6MpbeiSbO43FH0/YPNDZS+H3L3BqYN0tNOOnv/BYMWcBAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Osb4Y5SV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278916; x=1802814916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnU5I2550VT3Fp1uraIBO49ULp35TZkVTVP9KyLk+nQ=;
  b=Osb4Y5SVovsvhUeptsicrD7ti+6sk7gV7y7pAwB3u8wdqbOKEUn3JwB8
   Vz3T2EIfnNrNp6q/Vfn6H62z9bjis1nVWHwTWby9Pf28azkgbR2KA+Th2
   /aeA9pEzMeG0hxdt+FKhOJXgZyJo7mwFR/E/1QDDWb/5sorcPhS1lreLJ
   /s6ip8T/GKMAgwBoz59qcT6FgbPh6/WcYuN+VcI/ZWJ29x8bCStDDK/c8
   is8nXEA4l2dsuWPscrXEBsMliuH5oTGdV72quNRLivmbInLHeqRLA+/8d
   J4AIeL7ZiBf+iTw3SJIRcvfXW7GF8rPB7S7UhqIhWDs3gojB5GENTLNfL
   A==;
X-CSE-ConnectionGUID: scR0l/q8TbGYBLJ46gndUg==
X-CSE-MsgGUID: Iqg8B3urQ2SLZJj2kGUXwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980293"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:15 -0800
X-CSE-ConnectionGUID: HiCPvbYyT0y774zQo4a39Q==
X-CSE-MsgGUID: zCQpm5B3QHWH2OKLyQTqRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547340"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
Date: Mon, 16 Feb 2026 23:54:46 +0200
Message-Id: <20260216234830.41ec7b4fdc54.I45422adc0df3ad4101d857a92e83f0de5cf241e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31908-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2AE147D31
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
index 6750efbdf34c..9b6e5305b326 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -833,6 +833,10 @@ int wiphy_register(struct wiphy *wiphy)
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


