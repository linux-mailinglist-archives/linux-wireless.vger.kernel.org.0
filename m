Return-Path: <linux-wireless+bounces-10628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301493FC50
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E1A1C21281
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF516A947;
	Mon, 29 Jul 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPULSpQW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937ED5028C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273645; cv=none; b=S2XFOGzWAaeApb2aKX4uHFYeJopcrKTJUWhjWz5kEoStP/YmOjO3+ktrJHbbjozEkM4q1XGfujNCT2DCDJraqbBBEGdoo5lyQ1iAdcpWJ5/cs9ETrwsWFO/w2nkFJJzXl3Ua55i3euS7pPXv0VD/kmXZYsr5/S0v9lH7TRcH8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273645; c=relaxed/simple;
	bh=s6Z+XDc7I1RRyFjxDQ98NFo1KnHt90urVbArYb+y0wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SaWWRpYoGupy0/HWb+3T/3H0rMbvPnthG9nhHQDMI10qOEYOb1Y2mE6nbmTiBo7YeRgZN+nK5yhZVhWvliOn4ceD5h7HKmQYtqWt2Ti/+j512I6cdIQ0NR0VuBz2F0M7nRI6Ok6NPjMoDSVxY0PTCPyO2yxKVf/Qrqse6jRmFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPULSpQW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273644; x=1753809644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6Z+XDc7I1RRyFjxDQ98NFo1KnHt90urVbArYb+y0wQ=;
  b=gPULSpQWgpK4KzVHIr7wrogCEKwgkHYzRimjmrCPGASJwHStRcotI0fS
   TNMzOmIn7yRjQY6fLs/E3QQ6QSYcgDSnEH8VrGiLMZBwvGlLspdf8MmVz
   o3NXNXhSTfaDqpDp14LTy13cZIseaqm3wJCAD/8AJtLcd+h8rE1gpw15I
   OlJo5RyBZGhHZLHmEVOW1lokCVCbX7rxgl2t6Hn0ucOO5cnYCvAry9uRN
   s2Ft6hKQfLcX4H1ZeZsMP3Oad27JdBtl3jgrVduMXrEWmKngYTMPhGxmD
   zvS+hk5HHphv2UHMXD9GaaBqWjsVLi/3iDgyX38U0ZAywArEOu932pEc/
   A==;
X-CSE-ConnectionGUID: AxGT+ttFRnObyJkIO0/gZA==
X-CSE-MsgGUID: eTMihikUS0uP8GZ2yZoegA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445582"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:43 -0700
X-CSE-ConnectionGUID: l2Vw8/J7Ss+kvzo7TS/bgQ==
X-CSE-MsgGUID: O//v/QPkTVCt8IPOuXbjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288300"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/17] wifi: iwlwifi: mvm: set ul_mu_data_disable when needed
Date: Mon, 29 Jul 2024 20:20:09 +0300
Message-Id: <20240729201718.fef270d2995b.I328237837df30e1cb98764987eaaf8e8993e058c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware needs to know what we had in the HE CAP, propagate that
setting to the firmware through the LINK command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  8 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c       | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b9ed42faa63e..56b880e68870 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -472,7 +472,9 @@ enum iwl_link_ctx_flags {
  * @bssid_index: index of the associated VAP
  * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
  * @spec_link_id: link_id as the AP knows it
- * @reserved2: alignment
+ * @ul_mu_data_disable: OM Control UL MU Data Disable RX Support (bit 44) in
+ *	HE MAC Capabilities information field as defined in figure 9-897 in
+ *	IEEE802.11REVme-D5.0
  * @ibss_bssid_addr: bssid for ibss
  * @reserved_for_ibss_bssid_addr: reserved
  * @reserved3: reserved for future use
@@ -515,11 +517,11 @@ struct iwl_link_config_cmd {
 	u8 bssid_index;
 	u8 bss_color;
 	u8 spec_link_id;
-	u8 reserved2;
+	u8 ul_mu_data_disable;
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
 	__le32 reserved3[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3 */
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index a9929aa49913..3a6e0a90a3ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -293,6 +293,17 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			(link_conf->uora_ocw_range >> 3) & 0x7;
 	}
 
+	/* ap_sta may be NULL if we're disconnecting */
+	if (changes & LINK_CONTEXT_MODIFY_HE_PARAMS && mvmvif->ap_sta) {
+		struct ieee80211_link_sta *link_sta =
+			link_sta_dereference_check(mvmvif->ap_sta, link_id);
+
+		if (!WARN_ON(!link_sta) && link_sta->he_cap.has_he &&
+		    link_sta->he_cap.he_cap_elem.mac_cap_info[5] &
+		    IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX)
+			cmd.ul_mu_data_disable = 1;
+	}
+
 	/* TODO  how to set ndp_fdbk_buff_th_exp? */
 
 	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif->link[link_id],
-- 
2.34.1


