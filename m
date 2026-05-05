Return-Path: <linux-wireless+bounces-35931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKnnIBoe+mmaJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A26944D1838
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89772301C52B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA5492507;
	Tue,  5 May 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joJmdW3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F248B36F
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999363; cv=none; b=XwyNEuuq1ydH/WjtRoeZVEvP1PbaUNpPv/jgqPD8gcWPn7bx2Owjts6snSV9D0TuWsKYqNoRvbgJI8AerZ0MSwYHb2Bz4YXi0j7FbqqsnFHiZHRO8kEljJibSBmNO/xEhDG45XHEAS8I3Xk/0aMTLzHw9vLxk+bfGaxu4g+zT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999363; c=relaxed/simple;
	bh=aZMhHx+ajEh04ZW02xqcHsQY5nEqpfFjQb4TgmLUTG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftjukc4vWNJiFg/c/Uosyuqx9fX0gFXBvT2h3qFRtB2HhE/cv1PDyCZJ73G9vYiBB7y62TTBum+gEqN7rCAk7LsQ1M0j6w9ZukPmKjKecgK7XEHe19naKOSUzu+HkC1AkDs1Hwms6cSn88PEzOWTVufZYawwuTRUBmTuBA0aVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joJmdW3c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999362; x=1809535362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZMhHx+ajEh04ZW02xqcHsQY5nEqpfFjQb4TgmLUTG4=;
  b=joJmdW3ctxkZfKdAMCvSvGBIyPkBkOECkaLryNu9MMMybiYmmUXrgmKC
   tZIA2U1JuZHf68NtrNnGRzZMY30/suyv94qHEnNx46YRZN0ZKgsZbQemf
   lS+ucCx/P85Qke5QDzSgldU24op4Jq10SadUlO4YX86HzzB3/r9o8lwtu
   eXm+PuSLFICnBpRfmIulo8OE2Mh+pbIT7KIS7vHKAbFHpFAYDWP+h3tPA
   RD4XpAkbtDZFfKasS2vW+MclVI9hldKymAbhqy11JzD4dSb2KF7xxGH5y
   Ae1BELaenxLd4gnH2v7bXQKyzu66tyg4qvSY4ulcW+dNwHBO/svXM6Tt4
   g==;
X-CSE-ConnectionGUID: KXy9tOJ/SSi4UAwXYaCYQg==
X-CSE-MsgGUID: zTwUuXmAQRGzT3rxoZ3v3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898980"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898980"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:41 -0700
X-CSE-ConnectionGUID: ZHi7Xi4hRUyocO4EWLBLBA==
X-CSE-MsgGUID: puyF4PHyRba+YYh8KgPJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206399"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 07/14] wifi: mac80211_hwsim: add NAN PHY capabilities
Date: Tue,  5 May 2026 19:42:12 +0300
Message-Id: <20260505194007.2c94c156f05d.I539fab4adf2eb43bfec27006f7529b926e5208ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A26944D1838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35931-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Daniel Gabay <daniel.gabay@intel.com>

Add static HT, VHT and HE PHY capabilities to the NAN capabilities
structure. These are based on the existing band capability structures
and initialization in mac80211_hwsim.

The NAN PHY capabilities are used by mac80211 and nl80211 to
advertise device capabilities for NAN data interfaces.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 102 ++++++++++++++++--
 1 file changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 3397acfe61c8..fc940b38c52c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5412,6 +5412,95 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 #endif
 };
 
+#define HWSIM_VHT_MCS_MAP				\
+	(IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 2 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 4 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 6 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 8 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 10 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 12 |		\
+	 IEEE80211_VHT_MCS_SUPPORT_0_9 << 14)
+
+static const struct ieee80211_sta_ht_cap hwsim_nan_ht_cap = {
+	.ht_supported = true,
+	.cap = IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+	       IEEE80211_HT_CAP_GRN_FLD |
+	       IEEE80211_HT_CAP_SGI_20 |
+	       IEEE80211_HT_CAP_SGI_40 |
+	       IEEE80211_HT_CAP_DSSSCCK40,
+	.ampdu_factor = 0x3,
+	.ampdu_density = 0x6,
+	.mcs = {
+		.rx_mask = { 0xff, 0xff },
+		.tx_params = IEEE80211_HT_MCS_TX_DEFINED,
+	},
+};
+
+static const struct ieee80211_sta_vht_cap hwsim_nan_vht_cap = {
+	.vht_supported = true,
+	.cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+	       IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ |
+	       IEEE80211_VHT_CAP_RXLDPC |
+	       IEEE80211_VHT_CAP_SHORT_GI_80 |
+	       IEEE80211_VHT_CAP_SHORT_GI_160 |
+	       IEEE80211_VHT_CAP_TXSTBC |
+	       IEEE80211_VHT_CAP_RXSTBC_4 |
+	       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+	.vht_mcs = {
+		.rx_mcs_map = cpu_to_le16(HWSIM_VHT_MCS_MAP),
+		.tx_mcs_map = cpu_to_le16(HWSIM_VHT_MCS_MAP),
+	},
+};
+
+static const struct ieee80211_sta_he_cap hwsim_nan_he_cap = {
+	.has_he = true,
+	.he_cap_elem = {
+		.mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE,
+		.mac_cap_info[1] =
+			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
+			IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
+		.mac_cap_info[2] =
+			IEEE80211_HE_MAC_CAP2_BSR |
+			IEEE80211_HE_MAC_CAP2_MU_CASCADING |
+			IEEE80211_HE_MAC_CAP2_ACK_EN,
+		.mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
+		.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+		.phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G,
+		.phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
+			IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
+			IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS,
+		.phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+			IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO,
+
+		/*
+		 * Leave all the other PHY capability bytes
+		 * unset, as DCM, beam forming, RU and PPE
+		 * threshold information are not supported
+		 */
+	},
+	.he_mcs_nss_supp = {
+		.rx_mcs_80 = cpu_to_le16(0xfffa),
+		.tx_mcs_80 = cpu_to_le16(0xfffa),
+		.rx_mcs_160 = cpu_to_le16(0xfffa),
+		.tx_mcs_160 = cpu_to_le16(0xfffa),
+		.rx_mcs_80p80 = cpu_to_le16(0xfffa),
+		.tx_mcs_80p80 = cpu_to_le16(0xfffa),
+	},
+};
+
 static void mac80211_hwsim_sband_capab(struct ieee80211_supported_band *sband)
 {
 	switch (sband->band) {
@@ -5635,6 +5724,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		data->if_limits[n_limits].max = 2;
 		data->if_limits[n_limits].types = BIT(NL80211_IFTYPE_NAN_DATA);
 		n_limits++;
+
+		hw->wiphy->nan_capa.phy.ht = hwsim_nan_ht_cap;
+		hw->wiphy->nan_capa.phy.vht = hwsim_nan_vht_cap;
+		hw->wiphy->nan_capa.phy.he = hwsim_nan_he_cap;
 	}
 
 	data->if_combination.radar_detect_widths =
@@ -5816,14 +5909,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 				IEEE80211_VHT_CAP_RXSTBC_4 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 			sband->vht_cap.vht_mcs.rx_mcs_map =
-				cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 2 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 4 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 6 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 8 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 10 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 12 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 14);
+				cpu_to_le16(HWSIM_VHT_MCS_MAP);
 			sband->vht_cap.vht_mcs.tx_mcs_map =
 				sband->vht_cap.vht_mcs.rx_mcs_map;
 			break;
-- 
2.34.1


