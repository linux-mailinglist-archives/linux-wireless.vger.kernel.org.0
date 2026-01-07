Return-Path: <linux-wireless+bounces-30501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B807ECFE544
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44169301D616
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6454234405C;
	Wed,  7 Jan 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oL1nDzoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA83446B1
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795853; cv=none; b=gk6fv1lODsJAB3wLQkqI2onmtESK0+CiB+3z4VfJkCZvLulaVX1faed8N8dTix4mZximlcZ4r+QCWrNq63izQMXVaP5CFoetGAb8+0ONhuXgxDo1dDEpkgtvPieDRe1FzrMhTtylVxAX+uamjsWgA/1evfsA+9v0tFFsHxuxPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795853; c=relaxed/simple;
	bh=0yVb0WRH2peodriSbj02TARVqiX5LooM7j9bzDjcQ0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQyAs9qvGrceLAUAdYiTHF/EypvQDVqkUQHKchO41a/kQCSuWmOD14GJhGl4E0GGK84l1Fh8iDc9WFzSuxWTU24u0c1gZ+SFZsfyp4BEiQQgPJjwSqnCqa6bXAv2Cz3J07nB1XhCcct3UD9UGkMvWjg9gB4/F89UYGBpVlF6LHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oL1nDzoF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I7rgZEVZuSSty5LcyLRvsZgrWJh6/fti4OHWECZ2ovo=;
	t=1767795851; x=1769005451; b=oL1nDzoF1qaf+Ll5R+iDqvXl9hoxfxlzUNiQ313EkB4V/0U
	/eeHRSEYy+ie9MYFvVOAiMGXf0oGyBwBAfD4+XIZGFGAcZPza8gbF/NgzUmttkQO2le+Zq4k7Q5Re
	whPOuCkU/O83BNG3eK2K9fXAt/b8P66nZVjnQtdWMuANmsLDGfVU2HATctPIYIWbk5YyeHCtQ082j
	z0sHjTVSMOYlOj8sdH7WhN3wtaWZL9tuRyIt9t8UCUF9tUO75plcPSocRht/WDZq+JEoPId2UzX8F
	yYlxtK8ozcMP7925CUd6YUGfRx3to82bxZqw59pbQ84g5XxLzZ1rVvK42BXjVqQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSG-00000005agF-2NuF;
	Wed, 07 Jan 2026 15:24:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 39/46] wifi: mac80211_hwsim: add NAN PHY capabilities
Date: Wed,  7 Jan 2026 15:22:38 +0100
Message-ID: <20260107152325.e883e2b18c01.I539fab4adf2eb43bfec27006f7529b926e5208ea@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Add static HT, VHT and HE PHY capabilities to the NAN capabilities
structure. These are based on the existing band capability structures
and initialization in mac80211_hwsim.

The NAN PHY capabilities are used by mac80211 and nl80211 to
advertise device capabilities for NAN data interfaces.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 102 ++++++++++++++++--
 1 file changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 75bdb46785dc..639a62bf0df8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5072,6 +5072,95 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
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
@@ -5295,6 +5384,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		data->if_limits[n_limits].max = 2;
 		data->if_limits[n_limits].types = BIT(NL80211_IFTYPE_NAN_DATA);
 		n_limits++;
+
+		hw->wiphy->nan_capa.phy.ht = hwsim_nan_ht_cap;
+		hw->wiphy->nan_capa.phy.vht = hwsim_nan_vht_cap;
+		hw->wiphy->nan_capa.phy.he = hwsim_nan_he_cap;
 	}
 
 	data->if_combination.radar_detect_widths =
@@ -5467,14 +5560,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
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
2.52.0


