Return-Path: <linux-wireless+bounces-7463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB88C265B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD4CB2474E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2941708BA;
	Fri, 10 May 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfJvg3Pw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118417107F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350019; cv=none; b=N1YWUt3PkWb2RiLMRbLLEL7TqKCdoWQbECb7kyll/4fpeYg8kASBqamJ3mAJ9yQC8RfONlUkGwb3IXKc7YW/YmxgmPcBNj5SdMBZROHOQK+BMSEi36VcIjLqu5xgXcFLPLC1rx8buRc8YKTtUK4RRZZaTZi53dT/Jq86I2dO8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350019; c=relaxed/simple;
	bh=c4+WFOZE1cD7Mv/9QTcqsDFjhgI3JHDzVEWTw2xvl3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCVqM8OsoHWDUHWq6A+DliL55q2xMW+/tTcCS9BE6MfR7esTNPxXM/dozpVSN0BFBU82klqn58vsXel0SU+C8jmk713nR1X/7niRau2wjYLGMxuLsoW574U4NYD67NPTJlswxa0g0pY0j8Vv95EmvOI3Z39hIqh9057iN1RtlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfJvg3Pw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350017; x=1746886017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4+WFOZE1cD7Mv/9QTcqsDFjhgI3JHDzVEWTw2xvl3A=;
  b=BfJvg3Pwn0Jjcj+YePLV3gmBnLzxmp9C1Kuv/YOHh233P+nYIwDU8Q9l
   gTpUkUasI6wcXfCLLBwChGLnM1hw3XoZGVMey4vFMtVo8xKKXZNG7kGSo
   h8RTVedSSANZZuiLypIWEohHzPeFxqwU/+XO8QKmIKwZMeDDj1zKsgmxi
   IXjIP8RCLSzqkGyG6kiH8wVxAcP3Nfel566rRE6go9bVF1lkIRNqDMJxM
   8Hw7CskiTcv5nwDGSXOpmBgruTwwC+x1I6AE8bn+60ocG11KwaTpy42q9
   MkiaaCYo7msysjPVB6l2XimUpNuPNxh3A3iRNLuLX14VUeLqugMTzwsBW
   g==;
X-CSE-ConnectionGUID: LVo2CcXASGuruAWJxZC5VA==
X-CSE-MsgGUID: hB9GVWk0TomNUYzQpR0r8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125532"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:57 -0700
X-CSE-ConnectionGUID: tM3515cjQrajX6oSyw2e+A==
X-CSE-MsgGUID: 7Z7xV2EARjWrlsJF9xh68g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101835"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/14] iwlwifi: mvm: simplify the uAPSD coexistence limitation code
Date: Fri, 10 May 2024 17:06:30 +0300
Message-Id: <20240510170500.4ac26534adf7.Ib892020177e86603b2be3a105f8717b9a15951d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

uAPSD can't be enabled on BSS or P2P Client if there is
another active interface (e.g. associated client). Allow
the code that apply those limitations to run on BSS as well.
Also forbid uAPSD if we have an IBSS or NAN interface in
the system.
Since we are now forbidding uAPSD in any concurrency
scenario, we don't need to check the number of PHY
contexts.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/23958
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 55 +++++++++----------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 568f53c56199..72f4480ae7f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -211,19 +211,29 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 		IWL_MVM_PS_HEAVY_RX_THLD_PERCENT;
 }
 
-static void iwl_mvm_p2p_standalone_iterator(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
+struct iwl_allow_uapsd_iface_iterator_data {
+	struct ieee80211_vif *exclude_vif;
+	bool allow_uapsd;
+};
+
+static void iwl_mvm_allow_uapsd_iterator(void *_data, u8 *mac,
+					 struct ieee80211_vif *vif)
 {
-	bool *is_p2p_standalone = _data;
+	struct iwl_allow_uapsd_iface_iterator_data *data = _data;
 
-	switch (ieee80211_vif_type_p2p(vif)) {
-	case NL80211_IFTYPE_P2P_GO:
+	/* exclude the given vif */
+	if (vif == data->exclude_vif)
+		return;
+
+	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
-		*is_p2p_standalone = false;
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_NAN:
+		data->allow_uapsd = false;
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (vif->cfg.assoc)
-			*is_p2p_standalone = false;
+			data->allow_uapsd = false;
 		break;
 
 	default:
@@ -235,6 +245,10 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_allow_uapsd_iface_iterator_data data = {
+		.exclude_vif = vif,
+		.allow_uapsd = true,
+	};
 
 	if (ether_addr_equal(mvmvif->uapsd_misbehaving_ap_addr,
 			     vif->cfg.ap_addr))
@@ -249,30 +263,15 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 	    IEEE80211_P2P_OPPPS_ENABLE_BIT))
 		return false;
 
-	/*
-	 * Avoid using uAPSD if client is in DCM -
-	 * low latency issue in Miracast
-	 */
-	if (iwl_mvm_phy_ctx_count(mvm) >= 2)
+	if (vif->p2p && !iwl_mvm_is_p2p_scm_uapsd_supported(mvm))
 		return false;
 
-	if (vif->p2p) {
-		/* Allow U-APSD only if p2p is stand alone */
-		bool is_p2p_standalone = true;
-
-		if (!iwl_mvm_is_p2p_scm_uapsd_supported(mvm))
-			return false;
-
-		ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-					IEEE80211_IFACE_ITER_NORMAL,
-					iwl_mvm_p2p_standalone_iterator,
-					&is_p2p_standalone);
-
-		if (!is_p2p_standalone)
-			return false;
-	}
+	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
+				IEEE80211_IFACE_ITER_NORMAL,
+				iwl_mvm_allow_uapsd_iterator,
+				&data);
 
-	return true;
+	return data.allow_uapsd;
 }
 
 static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
-- 
2.34.1


