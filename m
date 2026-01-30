Return-Path: <linux-wireless+bounces-31366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNhQLR+wfGmbOQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:20:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3EDBAECB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C72D0300B772
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231029CB24;
	Fri, 30 Jan 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="awOtS7uj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140429C35A
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779229; cv=none; b=ppWtk47gfkBewN+T3KGCuREasV6GrSHGN/IRs2mivWjhnZ8Uj9H5wqBRwoo02tin/tGyTKktIa2FcNAn5uTh9aF0T53YYLSNe9FlyGNQF8rtl3fD13BTS/7aQOfNpNRX04PzqqMH9+bbe+ibkk9uuvslyRBOAwJK+mFVWmaWzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779229; c=relaxed/simple;
	bh=hBOgqeM/0MXsvMEDRtUtgVShGQAiQ2P7Wqr7Al6c9CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2dzuuyXfsvqgrjPgk5o+c5YAKAwgVJZtJfm6n0dYFWpbDn4kfbpHMuI26vAWeACP4hOQNnf1FQ96EhcbXRIhNOXBSjKVse2Eik40R9TGM8p8LRk6Lziyegohz4fjZqdml7JKfPBBYiXFl1+OqYtpkIk3tsZhnuAeA48YTXDHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=awOtS7uj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=63VHuF/6ezuqafk5HLivQ0/Y3AkXJ7FHdmrAqE/Cse0=;
	t=1769779227; x=1770988827; b=awOtS7ujauD7mbUs5b7IwdYnIZd8x00eEWYYy2NlLjoSGg1
	5wWWB5ZO2CU2iLhClveCMAYDNRGt6V+ulddv4IZdkIKR99DPv2FD1RQnjAhGpMp69X9vLC6hDGOrI
	/kM67fYOo8UEccqLPildrPTx5wKtLVxgTedeQ4yhZSGkN5lY2P8ZxIRsoRV1toL5vtEws0Kjo5ORy
	uU7q3UWq+kxjI8lhYlnVgo/QXaJr9wvqzMHof+t//uZq9NzRhn7euYrDIG3/t5Ctzm+FAspnHlhQt
	rb8T58Edq7ebsMM6LXiKdELFA5kNOMEDMoTI+kbFPy/eXMIL4hINi8Greuu3dO5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vloQB-00000007ssf-3083;
	Fri, 30 Jan 2026 14:20:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v7 2/3] wifi: cfg80211: add initial UHR support
Date: Fri, 30 Jan 2026 14:20:20 +0100
Message-ID: <20260130142019.69d59a4538d6.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130142019.bd561c0eae91.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
References: <20260130142019.bd561c0eae91.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31366-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]
X-Rspamd-Queue-Id: 1F3EDBAECB
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add initial support for making UHR connections (or suppressing
that), adding UHR capable stations on the AP side, encoding
and decoding UHR MCSes (except rate calculation for the new
MCSes 17, 19, 20 and 23) as well as regulatory support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v7:
 - adjust for changed naming
v5:
 - validate NL80211_ATTR_UHR_CAPABILITY for non-AP (only)
v4:
 - check for correct NSS/MCS for interference mitigation
v3:
 - remove UHR capa pointer from AP settings, it's not in
   the beacon anyway
 - fix kernel-doc (Jeff Johnson)
---
 include/net/cfg80211.h       |  58 ++++++++++++++++++--
 include/uapi/linux/nl80211.h |  30 +++++++++++
 net/wireless/nl80211.c       | 102 +++++++++++++++++++++++++++++++++--
 net/wireless/reg.c           |   4 +-
 net/wireless/util.c          | 101 ++++++++++++++++++++++++++--------
 5 files changed, 265 insertions(+), 30 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0ae0aa7594a3..aca349d4cc1a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -126,6 +126,7 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_4MHZ: 4 MHz bandwidth is not permitted on this channel.
  * @IEEE80211_CHAN_NO_8MHZ: 8 MHz bandwidth is not permitted on this channel.
  * @IEEE80211_CHAN_NO_16MHZ: 16 MHz bandwidth is not permitted on this channel.
+ * @IEEE80211_CHAN_NO_UHR: UHR operation is not permitted on this channel.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -143,6 +144,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_10MHZ			= BIT(12),
 	IEEE80211_CHAN_NO_HE			= BIT(13),
 	/* can use free bits here */
+	IEEE80211_CHAN_NO_UHR			= BIT(18),
 	IEEE80211_CHAN_NO_320MHZ		= BIT(19),
 	IEEE80211_CHAN_NO_EHT			= BIT(20),
 	IEEE80211_CHAN_DFS_CONCURRENT		= BIT(21),
@@ -429,6 +431,18 @@ struct ieee80211_sta_eht_cap {
 	u8 eht_ppe_thres[IEEE80211_EHT_PPE_THRES_MAX_LEN];
 };
 
+/**
+ * struct ieee80211_sta_uhr_cap - STA's UHR capabilities
+ * @has_uhr: true iff UHR is supported and data is valid
+ * @mac: fixed MAC capabilities
+ * @phy: fixed PHY capabilities
+ */
+struct ieee80211_sta_uhr_cap {
+	bool has_uhr;
+	struct ieee80211_uhr_cap_mac mac;
+	struct ieee80211_uhr_cap_phy phy;
+};
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /*
@@ -454,6 +468,7 @@ struct ieee80211_sta_eht_cap {
  * @he_6ghz_capa: HE 6 GHz capabilities, must be filled in for a
  *	6 GHz band channel (and 0 may be valid value).
  * @eht_cap: STA's EHT capabilities
+ * @uhr_cap: STA's UHR capabilities
  * @vendor_elems: vendor element(s) to advertise
  * @vendor_elems.data: vendor element(s) data
  * @vendor_elems.len: vendor element(s) length
@@ -463,6 +478,7 @@ struct ieee80211_sband_iftype_data {
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	struct ieee80211_sta_eht_cap eht_cap;
+	struct ieee80211_sta_uhr_cap uhr_cap;
 	struct {
 		const u8 *data;
 		unsigned int len;
@@ -704,6 +720,26 @@ ieee80211_get_eht_iftype_cap(const struct ieee80211_supported_band *sband,
 	return NULL;
 }
 
+/**
+ * ieee80211_get_uhr_iftype_cap - return UHR capabilities for an sband's iftype
+ * @sband: the sband to search for the iftype on
+ * @iftype: enum nl80211_iftype
+ *
+ * Return: pointer to the struct ieee80211_sta_uhr_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_uhr_cap *
+ieee80211_get_uhr_iftype_cap(const struct ieee80211_supported_band *sband,
+			     enum nl80211_iftype iftype)
+{
+	const struct ieee80211_sband_iftype_data *data =
+		ieee80211_get_sband_iftype_data(sband, iftype);
+
+	if (data && data->uhr_cap.has_uhr)
+		return &data->uhr_cap;
+
+	return NULL;
+}
+
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
@@ -1486,6 +1522,7 @@ struct cfg80211_s1g_short_beacon {
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
  * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
  * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
+ * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
@@ -1525,6 +1562,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_oper;
+	const struct ieee80211_uhr_oper *uhr_oper;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
@@ -1698,6 +1736,8 @@ struct sta_txpwr {
  * @eht_capa: EHT capabilities of station
  * @eht_capa_len: the length of the EHT capabilities
  * @s1g_capa: S1G capabilities of station
+ * @uhr_capa: UHR capabilities of the station
+ * @uhr_capa_len: the length of the UHR capabilities
  */
 struct link_station_parameters {
 	const u8 *mld_mac;
@@ -1717,6 +1757,8 @@ struct link_station_parameters {
 	const struct ieee80211_eht_cap_elem *eht_capa;
 	u8 eht_capa_len;
 	const struct ieee80211_s1g_cap *s1g_capa;
+	const struct ieee80211_uhr_cap *uhr_capa;
+	u8 uhr_capa_len;
 };
 
 /**
@@ -1898,6 +1940,11 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
  * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
  * @RATE_INFO_FLAGS_S1G_MCS: MCS field filled with S1G MCS
+ * @RATE_INFO_FLAGS_UHR_MCS: UHR MCS information
+ * @RATE_INFO_FLAGS_UHR_ELR_MCS: UHR ELR MCS was used
+ *	(set together with @RATE_INFO_FLAGS_UHR_MCS)
+ * @RATE_INFO_FLAGS_UHR_IM: UHR Interference Mitigation
+ *	was used
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1909,6 +1956,9 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
 	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
 	RATE_INFO_FLAGS_S1G_MCS			= BIT(8),
+	RATE_INFO_FLAGS_UHR_MCS			= BIT(9),
+	RATE_INFO_FLAGS_UHR_ELR_MCS		= BIT(10),
+	RATE_INFO_FLAGS_UHR_IM			= BIT(11),
 };
 
 /**
@@ -1924,7 +1974,7 @@ enum rate_info_flags {
  * @RATE_INFO_BW_160: 160 MHz bandwidth
  * @RATE_INFO_BW_HE_RU: bandwidth determined by HE RU allocation
  * @RATE_INFO_BW_320: 320 MHz bandwidth
- * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT RU allocation
+ * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT/UHR RU allocation
  * @RATE_INFO_BW_1: 1 MHz bandwidth
  * @RATE_INFO_BW_2: 2 MHz bandwidth
  * @RATE_INFO_BW_4: 4 MHz bandwidth
@@ -1955,7 +2005,7 @@ enum rate_info_bw {
  *
  * @flags: bitflag of flags from &enum rate_info_flags
  * @legacy: bitrate in 100kbit/s for 802.11abg
- * @mcs: mcs index if struct describes an HT/VHT/HE/EHT/S1G rate
+ * @mcs: mcs index if struct describes an HT/VHT/HE/EHT/S1G/UHR rate
  * @nss: number of streams (VHT & HE only)
  * @bw: bandwidth (from &enum rate_info_bw)
  * @he_gi: HE guard interval (from &enum nl80211_he_gi)
@@ -3265,6 +3315,7 @@ struct cfg80211_ml_reconf_req {
  *	Drivers shall disable MLO features for the current association if this
  *	flag is not set.
  * @ASSOC_REQ_SPP_AMSDU: SPP A-MSDUs will be used on this connection (if any)
+ * @ASSOC_REQ_DISABLE_UHR: Disable UHR
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -3275,6 +3326,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_EHT			= BIT(5),
 	CONNECT_REQ_MLO_SUPPORT			= BIT(6),
 	ASSOC_REQ_SPP_AMSDU			= BIT(7),
+	ASSOC_REQ_DISABLE_UHR			= BIT(8),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 54ddbd9a5459..2254a6dead39 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2976,6 +2976,13 @@ enum nl80211_commands {
  * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
  *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
  *
+ * @NL80211_ATTR_UHR_CAPABILITY: UHR Capability information element (from
+ *	association request when used with NL80211_CMD_NEW_STATION). Can be set
+ *	only if HE/EHT are also available.
+ * @NL80211_ATTR_DISABLE_UHR: Force UHR capable interfaces to disable
+ *	this feature during association. This is a flag attribute.
+ *	Currently only supported in mac80211 drivers.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3546,6 +3553,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EPP_PEER,
 
+	NL80211_ATTR_UHR_CAPABILITY,
+	NL80211_ATTR_DISABLE_UHR,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3898,6 +3908,12 @@ enum nl80211_eht_ru_alloc {
  * @NL80211_RATE_INFO_4_MHZ_WIDTH: 4 MHz S1G rate
  * @NL80211_RATE_INFO_8_MHZ_WIDTH: 8 MHz S1G rate
  * @NL80211_RATE_INFO_16_MHZ_WIDTH: 16 MHz S1G rate
+ * @NL80211_RATE_INFO_UHR_MCS: UHR MCS index (u8, 0-15, 17, 19, 20, 23)
+ *	Note that the other EHT attributes (such as @NL80211_RATE_INFO_EHT_NSS)
+ *	are used in conjunction with this where applicable
+ * @NL80211_RATE_INFO_UHR_ELR: UHR ELR flag, which restricts NSS to 1,
+ *	MCS to 0 or 1, and GI to %NL80211_RATE_INFO_EHT_GI_1_6.
+ * @NL80211_RATE_INFO_UHR_IM: UHR Interference Mitigation flag
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3931,6 +3947,9 @@ enum nl80211_rate_info {
 	NL80211_RATE_INFO_4_MHZ_WIDTH,
 	NL80211_RATE_INFO_8_MHZ_WIDTH,
 	NL80211_RATE_INFO_16_MHZ_WIDTH,
+	NL80211_RATE_INFO_UHR_MCS,
+	NL80211_RATE_INFO_UHR_ELR,
+	NL80211_RATE_INFO_UHR_IM,
 
 	/* keep last */
 	__NL80211_RATE_INFO_AFTER_LAST,
@@ -4253,6 +4272,10 @@ enum nl80211_mpath_info {
  *	capabilities element
  * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE: EHT PPE thresholds information as
  *	defined in EHT capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC: UHR MAC capabilities as in UHR
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY: UHR PHY capabilities as in UHR
+ *	capabilities element
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
  * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
@@ -4270,6 +4293,8 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
+	NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC,
+	NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
@@ -4452,6 +4477,8 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY: Channel is not permitted for use
  *	as a primary channel. Does not prevent the channel from existing
  *	as a non-primary subchannel. Only applicable to S1G channels.
+ * @NL80211_FREQUENCY_ATTR_NO_UHR: UHR operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4501,6 +4528,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 	NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY,
+	NL80211_FREQUENCY_ATTR_NO_UHR,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4714,6 +4742,7 @@ enum nl80211_sched_scan_match_attr {
  *	despite NO_IR configuration.
  * @NL80211_RRF_ALLOW_20MHZ_ACTIVITY: Allow activity in 20 MHz bandwidth,
  *	despite NO_IR configuration.
+ * @NL80211_RRF_NO_UHR: UHR operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM                 = 1 << 0,
@@ -4740,6 +4769,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_6GHZ_AFC_CLIENT      = 1 << 23,
 	NL80211_RRF_ALLOW_6GHZ_VLP_AP       = 1 << 24,
 	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    = 1 << 25,
+	NL80211_RRF_NO_UHR		    = 1 << 26,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85e30fda4c46..181205eae755 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -332,6 +332,15 @@ static int validate_nan_cluster_id(const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_uhr_capa(const struct nlattr *attr,
+			     struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+
+	return ieee80211_uhr_capa_size_ok(data, len, false);
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -934,6 +943,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EPP_PEER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_UHR_CAPABILITY] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
+	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -1319,6 +1331,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_S1G_NO_PRIMARY))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_UHR) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHR))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -1954,6 +1969,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap = &iftdata->eht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap = &iftdata->uhr_cap;
 
 	if (nl80211_put_iftypes(msg, NL80211_BAND_IFTYPE_ATTR_IFTYPES,
 				iftdata->types_mask))
@@ -2005,6 +2021,14 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			return -ENOBUFS;
 	}
 
+	if (uhr_cap->has_uhr) {
+		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC,
+			    sizeof(uhr_cap->mac), &uhr_cap->mac) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY,
+			    sizeof(uhr_cap->phy), &uhr_cap->phy))
+			return -ENOBUFS;
+	}
+
 	if (sband->band == NL80211_BAND_6GHZ &&
 	    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
 		    sizeof(iftdata->he_6ghz_capa),
@@ -6462,6 +6486,17 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 						cap->datalen - 1))
 			return -EINVAL;
 	}
+
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
+	if (cap) {
+		if (!cap->datalen)
+			return -EINVAL;
+		params->uhr_oper = (void *)(cap->data + 1);
+		if (!ieee80211_uhr_oper_size_ok((const u8 *)params->uhr_oper,
+						cap->datalen - 1, true))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -6593,6 +6628,9 @@ static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params
 	    (channel->flags & IEEE80211_CHAN_NO_EHT))
 		return -EOPNOTSUPP;
 
+	if (params->uhr_oper && (channel->flags & IEEE80211_CHAN_NO_UHR))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
@@ -7175,7 +7213,8 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		break;
 	case RATE_INFO_BW_EHT_RU:
 		rate_flg = 0;
-		WARN_ON(!(info->flags & RATE_INFO_FLAGS_EHT_MCS));
+		WARN_ON(!(info->flags & RATE_INFO_FLAGS_EHT_MCS) &&
+			!(info->flags & RATE_INFO_FLAGS_UHR_MCS));
 		break;
 	}
 
@@ -7228,6 +7267,23 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		    nla_put_u8(msg, NL80211_RATE_INFO_EHT_RU_ALLOC,
 			       info->eht_ru_alloc))
 			return false;
+	} else if (info->flags & RATE_INFO_FLAGS_UHR_MCS) {
+		if (nla_put_u8(msg, NL80211_RATE_INFO_UHR_MCS, info->mcs))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_NSS, info->nss))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_GI, info->eht_gi))
+			return false;
+		if (info->bw == RATE_INFO_BW_EHT_RU &&
+		    nla_put_u8(msg, NL80211_RATE_INFO_EHT_RU_ALLOC,
+			       info->eht_ru_alloc))
+			return false;
+		if (info->flags & RATE_INFO_FLAGS_UHR_ELR_MCS &&
+		    nla_put_flag(msg, NL80211_RATE_INFO_UHR_ELR))
+			return false;
+		if (info->flags & RATE_INFO_FLAGS_UHR_IM &&
+		    nla_put_flag(msg, NL80211_RATE_INFO_UHR_IM))
+			return false;
 	}
 
 	nla_nest_end(msg, rate);
@@ -8101,7 +8157,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		if (params->ext_capab || params->link_sta_params.ht_capa ||
 		    params->link_sta_params.vht_capa ||
 		    params->link_sta_params.he_capa ||
-		    params->link_sta_params.eht_capa)
+		    params->link_sta_params.eht_capa ||
+		    params->link_sta_params.uhr_capa)
 			return -EINVAL;
 		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
 			return -EINVAL;
@@ -8321,6 +8378,16 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		if (!params->link_sta_params.eht_capa)
+			return -EINVAL;
+
+		params->link_sta_params.uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		params->link_sta_params.uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
 		params->link_sta_params.s1g_capa =
 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
@@ -8641,6 +8708,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		if (!params.link_sta_params.eht_capa)
+			return -EINVAL;
+
+		params.link_sta_params.uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		params.link_sta_params.uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_EML_CAPABILITY]) {
 		params.eml_cap_present = true;
 		params.eml_cap =
@@ -8700,10 +8777,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.link_sta_params.ht_capa = NULL;
 		params.link_sta_params.vht_capa = NULL;
 
-		/* HE and EHT require WME */
+		/* HE, EHT and UHR require WME */
 		if (params.link_sta_params.he_capa_len ||
 		    params.link_sta_params.he_6ghz_capa ||
-		    params.link_sta_params.eht_capa_len)
+		    params.link_sta_params.eht_capa_len ||
+		    params.link_sta_params.uhr_capa_len)
 			return -EINVAL;
 	}
 
@@ -12379,6 +12457,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
 		req.flags |= ASSOC_REQ_DISABLE_EHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_UHR]))
+		req.flags |= ASSOC_REQ_DISABLE_UHR;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -13258,6 +13339,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_EHT]))
 		connect.flags |= ASSOC_REQ_DISABLE_EHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_UHR]))
+		connect.flags |= ASSOC_REQ_DISABLE_UHR;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -17690,6 +17774,16 @@ nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
 		}
 	}
 
+	if (info->attrs[NL80211_ATTR_UHR_CAPABILITY]) {
+		if (!params.eht_capa)
+			return -EINVAL;
+
+		params.uhr_capa =
+			nla_data(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+		params.uhr_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_UHR_CAPABILITY]);
+	}
+
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
 		params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6cbfa3b78311..139cb27e5a81 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -1605,6 +1605,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
 	if (rd_flags & NL80211_RRF_ALLOW_20MHZ_ACTIVITY)
 		channel_flags |= IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY;
+	if (rd_flags & NL80211_RRF_NO_UHR)
+		channel_flags |= IEEE80211_CHAN_NO_UHR;
 	return channel_flags;
 }
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cc55b759694e..371149220031 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2018-2023, 2025-2026 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -1572,26 +1572,30 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	return result / 10000;
 }
 
-static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
+static u32 _cfg80211_calculate_bitrate_eht_uhr(struct rate_info *rate)
 {
 #define SCALE 6144
-	static const u32 mcs_divisors[16] = {
-		102399, /* 16.666666... */
-		 51201, /*  8.333333... */
-		 34134, /*  5.555555... */
-		 25599, /*  4.166666... */
-		 17067, /*  2.777777... */
-		 12801, /*  2.083333... */
-		 11377, /*  1.851725... */
-		 10239, /*  1.666666... */
-		  8532, /*  1.388888... */
-		  7680, /*  1.250000... */
-		  6828, /*  1.111111... */
-		  6144, /*  1.000000... */
-		  5690, /*  0.926106... */
-		  5120, /*  0.833333... */
-		409600, /* 66.666666... */
-		204800, /* 33.333333... */
+	static const u32 mcs_divisors[] = {
+		[ 0] = 102399, /* 16.666666... */
+		[ 1] =  51201, /*  8.333333... */
+		[ 2] =  34134, /*  5.555555... */
+		[ 3] =  25599, /*  4.166666... */
+		[ 4] =  17067, /*  2.777777... */
+		[ 5] =  12801, /*  2.083333... */
+		[ 6] =  11377, /*  1.851725... */
+		[ 7] =  10239, /*  1.666666... */
+		[ 8] =   8532, /*  1.388888... */
+		[ 9] =   7680, /*  1.250000... */
+		[10] =   6828, /*  1.111111... */
+		[11] =   6144, /*  1.000000... */
+		[12] =   5690, /*  0.926106... */
+		[13] =   5120, /*  0.833333... */
+		[14] = 409600, /* 66.666666... */
+		[15] = 204800, /* 33.333333... */
+		[17] =  38400, /*  6.250180... */
+		[19] =  19200, /*  3.125090... */
+		[20] =  15360, /*  2.500000... */
+		[23] =   9600, /*  1.562545... */
 	};
 	static const u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
 	static const u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
@@ -1602,8 +1606,6 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 	u64 tmp;
 	u32 result;
 
-	if (WARN_ON_ONCE(rate->mcs > 15))
-		return 0;
 	if (WARN_ON_ONCE(rate->eht_gi > NL80211_RATE_INFO_EHT_GI_3_2))
 		return 0;
 	if (WARN_ON_ONCE(rate->eht_ru_alloc >
@@ -1684,7 +1686,7 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_26)
 		result = rates_26[rate->eht_gi];
 	else {
-		WARN(1, "invalid EHT MCS: bw:%d, ru:%d\n",
+		WARN(1, "invalid EHT or UHR MCS: bw:%d, ru:%d\n",
 		     rate->bw, rate->eht_ru_alloc);
 		return 0;
 	}
@@ -1698,11 +1700,64 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 	tmp *= rate->nss;
 	do_div(tmp, 8);
 
+	/* and handle interference mitigation - 0.9x */
+	if (rate->flags & RATE_INFO_FLAGS_UHR_IM) {
+		if (WARN(rate->nss != 1 || rate->mcs != 15,
+			 "invalid NSS or MCS for UHR IM\n"))
+			return 0;
+		tmp *= 9000;
+		do_div(tmp, 10000);
+	}
+
 	result = tmp;
 
 	return result / 10000;
 }
 
+static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
+{
+	if (WARN_ONCE(rate->mcs > 15, "bad EHT MCS %d\n", rate->mcs))
+		return 0;
+
+	if (WARN_ONCE(rate->flags & (RATE_INFO_FLAGS_UHR_ELR_MCS |
+				     RATE_INFO_FLAGS_UHR_IM),
+		      "bad EHT MCS flags 0x%x\n", rate->flags))
+		return 0;
+
+	return _cfg80211_calculate_bitrate_eht_uhr(rate);
+}
+
+static u32 cfg80211_calculate_bitrate_uhr(struct rate_info *rate)
+{
+	if (rate->flags & RATE_INFO_FLAGS_UHR_ELR_MCS) {
+		WARN_ONCE(rate->eht_gi != NL80211_RATE_INFO_EHT_GI_1_6,
+			  "bad UHR ELR guard interval %d\n",
+			  rate->eht_gi);
+		WARN_ONCE(rate->mcs > 1, "bad UHR ELR MCS %d\n", rate->mcs);
+		WARN_ONCE(rate->nss != 1, "bad UHR ELR NSS %d\n", rate->nss);
+		WARN_ONCE(rate->bw != RATE_INFO_BW_20,
+			  "bad UHR ELR bandwidth %d\n",
+			  rate->bw);
+		WARN_ONCE(rate->flags & RATE_INFO_FLAGS_UHR_IM,
+			  "bad UHR MCS flags 0x%x\n", rate->flags);
+		if (rate->mcs == 0)
+			return 17;
+		return 33;
+	}
+
+	switch (rate->mcs) {
+	case 0 ... 15:
+	case 17:
+	case 19:
+	case 20:
+	case 23:
+		return _cfg80211_calculate_bitrate_eht_uhr(rate);
+	}
+
+	WARN_ONCE(1, "bad UHR MCS %d\n", rate->mcs);
+	return 0;
+}
+
 static u32 cfg80211_calculate_bitrate_s1g(struct rate_info *rate)
 {
 	/* For 1, 2, 4, 8 and 16 MHz channels */
@@ -1827,6 +1882,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_he(rate);
 	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
 		return cfg80211_calculate_bitrate_eht(rate);
+	if (rate->flags & RATE_INFO_FLAGS_UHR_MCS)
+		return cfg80211_calculate_bitrate_uhr(rate);
 	if (rate->flags & RATE_INFO_FLAGS_S1G_MCS)
 		return cfg80211_calculate_bitrate_s1g(rate);
 
-- 
2.52.0


