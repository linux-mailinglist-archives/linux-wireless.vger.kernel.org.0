Return-Path: <linux-wireless+bounces-1404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FE822228
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989BDB228FC
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0515E9D;
	Tue,  2 Jan 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd1djjX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A615EAE
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224192; x=1735760192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WutA2hszgTf0TSlhuqJWqrZioIMGLE6KyQ0RHiqhpVE=;
  b=Bd1djjX5h9WxLPfsV64NZx1Pc6b/MgysIAaDxmo0ZNVc9i+lt1CP08E2
   TpZZbalpC5QvYN82kFKseaTVlZ1DOzyM9hVAtOtkSxU/d0DfvBVXS+Ck3
   kx8a5J+8wQpeH7bayO9yYqNxrkzh5o58HCDBGdkHcnIq13rqNG8G4WWC/
   lTiap3EEVG9hZ0IcKAEdnRaeHnylJkHY+HL2u5A2GO8C0AfTA+HDKs2PO
   WlieBipKp1dkQjYIBmC1LtpLFUr2kEyweq6+3/c72qpjKfmAqF1HdBoEk
   ncyTnwrpGwmEugckbGWo8Jq7xWoduOwYZJrBUw6mXRkU+CujiIzd+70DV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314326"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624563"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624563"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: mac80211_hwsim: Declare support for negotiated TTLM
Date: Tue,  2 Jan 2024 21:35:38 +0200
Message-Id: <20240102213313.3f54382f8449.I42b2f7c52f7574448cc8da3ad3db45075e4e0baa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Advertise support for negotiated TTLM in AP mode for testing
purposes. In addition, declare support for some extended
capabilities that are globally advertised by mac80211.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e080d1131f76..2b7c9368e96c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4984,6 +4984,29 @@ static void mac80211_hwsim_sband_capab(struct ieee80211_supported_band *sband)
 	 BIT(NL80211_IFTYPE_MESH_POINT) | \
 	 BIT(NL80211_IFTYPE_OCB))
 
+static const u8 iftypes_ext_capa_ap[] = {
+	 [0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	 [2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
+	 [7] = WLAN_EXT_CAPA8_OPMODE_NOTIF |
+	       WLAN_EXT_CAPA8_MAX_MSDU_IN_AMSDU_LSB,
+	 [8] = WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB,
+	 [9] = WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT,
+};
+
+#define MAC80211_HWSIM_MLD_CAPA_OPS FIELD_PREP_CONST( \
+	IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
+	IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)
+
+static const struct wiphy_iftype_ext_capab mac80211_hwsim_iftypes_ext_capa[] = {
+	{
+		.iftype = NL80211_IFTYPE_AP,
+		.extended_capabilities = iftypes_ext_capa_ap,
+		.extended_capabilities_mask = iftypes_ext_capa_ap,
+		.extended_capabilities_len = sizeof(iftypes_ext_capa_ap),
+		.mld_capa_and_ops = MAC80211_HWSIM_MLD_CAPA_OPS,
+	},
+};
+
 static int mac80211_hwsim_new_radio(struct genl_info *info,
 				    struct hwsim_new_radio_params *param)
 {
@@ -5178,6 +5201,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 		ieee80211_hw_set(hw, AP_LINK_PS);
+
+		hw->wiphy->iftype_ext_capab = mac80211_hwsim_iftypes_ext_capa;
+		hw->wiphy->num_iftype_ext_capab =
+			ARRAY_SIZE(mac80211_hwsim_iftypes_ext_capa);
 	} else {
 		ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
 		ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
-- 
2.34.1


