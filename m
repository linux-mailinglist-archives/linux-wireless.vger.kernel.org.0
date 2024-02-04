Return-Path: <linux-wireless+bounces-3109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A368490FD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305151C21E25
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8DB3CF5F;
	Sun,  4 Feb 2024 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1Axfp00"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012313B19D
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084409; cv=none; b=cxZP4MT08ykRVe66Dq0Wehy/cltF1J52jNaNyEoa4r0cYmPvJI4LR+QH1Z4j3WeLrdmyC86OOLXlU6C1dTNXxf+8tKhslK+wvuYNpft5nys0FG3uecTin96oQkCeiYN8wduatj1HnKUHQxQeieJaJ9n6B4VI6WyslOYZSwo9sO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084409; c=relaxed/simple;
	bh=IcKvOPD31iMP/CggLO98BA1RY5PSB9LT8dePlFgy5Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Em8v6VcUlukK2SGnmZRc84M75cJxS+b8jO/YAtPH2ql7oMPbyjTUbotPRxcyCb+NTOFrBvKdiuK59pkSSOGC4RhySDixtfjejQwYmsebxFI2RpaRAnYpuYPSuCXoMfKG7zQxMrSReK7aZNkUyMRA2GdQ+0pyVsVvw8PwyiwkNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1Axfp00; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084408; x=1738620408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcKvOPD31iMP/CggLO98BA1RY5PSB9LT8dePlFgy5Pw=;
  b=M1Axfp00jLAtCVMPuuXhzKA8avu+atzUemWdMqQMxl74BkBQcr2a857g
   4y9BKVYi1xb3Fx+LshkhLkVeY1yvaKfqd7GVFrifNElmPq3KTHh/WjW/J
   BSaFzJRfh0eBKA6sL46spdsAKonCSyWOCAiaPmP6/9rh22QBvYlIE7Qkn
   sY6txmJXgIQgjTGWmAFQXx+OPBOEeCNspTKgAK5SNOioRDoBSq4kvZZdm
   cLLJrTYa0RAQwLi/cfyKY7qSOmT4D1U+cgeMXfrCfFJfpVgFkRvjn9qOb
   v4h2IJOxkZpM5exq69MB1loAOchLifAqRkuSsQdJwh1It3S46/1/kRjNX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869382"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815883"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: remove EHT code from mac80211.c
Date: Mon,  5 Feb 2024 00:06:10 +0200
Message-Id: <20240204235836.bde5a9d87759.I4c69dd94416f92b0f1f53dd57dafecbec643600d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The code here is the pre-MLD API, but of course older FW
that doesn't support MLD APIs cannot support EHT. Remove
some code that shouldn't be there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 93baec9bb3fc..bc8d1760f36c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2611,9 +2611,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	 */
 	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc) {
 		if ((vif->bss_conf.he_support &&
-		     !iwlwifi_mod_params.disable_11ax) ||
-		    (vif->bss_conf.eht_support &&
-		     !iwlwifi_mod_params.disable_11be))
+		     !iwlwifi_mod_params.disable_11ax))
 			iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->deflink.ap_sta_id);
 
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
@@ -2622,10 +2620,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	/* Update MU EDCA params */
 	if (changes & BSS_CHANGED_QOS && mvmvif->associated &&
 	    vif->cfg.assoc &&
-	    ((vif->bss_conf.he_support &&
-	      !iwlwifi_mod_params.disable_11ax) ||
-	     (vif->bss_conf.eht_support &&
-	      !iwlwifi_mod_params.disable_11be)))
+	    (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax))
 		iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->deflink.ap_sta_id);
 
 	/*
@@ -3737,10 +3732,8 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 		 * the default bss_conf
 		 */
 		if (!mvm->mld_api_is_used &&
-		    ((vif->bss_conf.he_support &&
-		      !iwlwifi_mod_params.disable_11ax) ||
-		    (vif->bss_conf.eht_support &&
-		     !iwlwifi_mod_params.disable_11be)))
+		    (vif->bss_conf.he_support &&
+		     !iwlwifi_mod_params.disable_11ax))
 			iwl_mvm_cfg_he_sta(mvm, vif, mvm_sta->deflink.sta_id);
 	} else if (vif->type == NL80211_IFTYPE_STATION) {
 		iwl_mvm_vif_set_he_support(hw, vif, sta, true);
-- 
2.34.1


