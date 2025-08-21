Return-Path: <linux-wireless+bounces-26510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D3B2F8CA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFED6071B4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0603101BF;
	Thu, 21 Aug 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StgSN0xI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C513326D7F
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780320; cv=none; b=Hpq0HRPawfyps/t5RCR+vfNirSk60gwQtdBX8J8jiAjGuHxsbEGR/uz9nPyWojpOMLvN7VsZ9zbdPuaAkKiwUqisY8PnBcuHlH1sJPeDbKkqmEayTpSAUn2vWPK9JVASgIUdb4x5uhfz1Dts0xXGOiOFJaYUKsFwTnpARLUO3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780320; c=relaxed/simple;
	bh=CH1yhMYjIYz7YrhlXGs7CZ1tiTcUSkOJSa4cyh163sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHCkV3D2G3st6c8LfT2uUC0Fsor5V2cIFpWQRSiaKUspq8d7LrotbyxWdcVCKVRHXO2o9FS8YrV5SgL34cnqHPSzduwJSuyOXldXxBAW0BlbQ4eznhA7itPoHGhSX9TGMWcYYryeW2hqRoJp8MORBXPPEJlc4cl9xc1U67TGYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StgSN0xI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780319; x=1787316319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CH1yhMYjIYz7YrhlXGs7CZ1tiTcUSkOJSa4cyh163sk=;
  b=StgSN0xI4h2IOLPsnczDlHKaj/jySUb6PAHJDw8YNs5JlCy9SM30GTeq
   HbHt3V6WJkNcYSumfKBiH590Nva9/PUoFKQtq8GuL2Y6t+UKXqAICJyHH
   Hi7WMOXrkdHh850u37s/Xrs2WMIQnywJLJ9jKY2gft52CoIs+KnXiZ6tx
   u9XZIisNMmQ22s8THZB7I7ZszZ8tzypdeAGcUUhDaiMizQFcTz/vqEHgZ
   xPLlsqTucpXdNxar7GIyWQG7UQmiNDIvlQjgbQBGUi2sh/BoUAhA18DPn
   Ia6/OrciOJIwi4r34TqfF6X5pzOGuZ9rRPqnZJetjvLygNw0ebneg57Aw
   g==;
X-CSE-ConnectionGUID: ZV+PKl70QkG+oY0ofqXOPA==
X-CSE-MsgGUID: C6C0XdX+ShSKx0k43kNWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895770"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895770"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:19 -0700
X-CSE-ConnectionGUID: PWvB42DqQDy5p15Br5WGYQ==
X-CSE-MsgGUID: ONG9V2HYQRu/rm9qdnG43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622238"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: don't validate keys state on resume
Date: Thu, 21 Aug 2025 15:44:33 +0300
Message-Id: <20250821154216.fb7e3bd4a967.I7eb24756ee27ad7b6731c0fb5dce5acb5d986694@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When resuming, we iterate over all the (installed) keys to update the
PNs. If we find a key with an unexpected cipher we disconnect.
But there is no reason for us to validate the internal key state
specifically on resume, it should be the same as it was before the
suspend.
Remove the 'unhandled_cipher' from the iteration data.

Also remove the num_keys indication as it is not really needed.
If no keys were installed before the suspend, we will have
num_of_gtk_rekeys = 0 and we will return early anyway.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 22 ++-------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index b27b874b3e84..6a32aa22ffb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -41,8 +41,6 @@ enum iwl_mld_d3_notif {
 struct iwl_mld_resume_key_iter_data {
 	struct iwl_mld *mld;
 	struct iwl_mld_wowlan_status *wowlan_status;
-	u32 num_keys;
-	bool unhandled_cipher;
 };
 
 struct iwl_mld_suspend_key_iter_data {
@@ -747,14 +745,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	struct iwl_mld_wowlan_status *wowlan_status = data->wowlan_status;
 	u8 status_idx;
 
-	if (data->unhandled_cipher)
-		return;
-
 	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		/* ignore WEP completely, nothing to do */
-		return;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
@@ -785,11 +776,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 						    &wowlan_status->bigtk[status_idx]);
 		}
 		break;
-	default:
-		data->unhandled_cipher = true;
-		return;
 	}
-	data->num_keys++;
 }
 
 static void
@@ -922,15 +909,10 @@ iwl_mld_update_sec_keys(struct iwl_mld *mld,
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_resume_keys_iter,
 			    &key_iter_data);
 
-	if (key_iter_data.unhandled_cipher)
-		return false;
-
-	IWL_DEBUG_WOWLAN(mld,
-			 "Number of installed keys: %d, Number of rekeys: %d\n",
-			 key_iter_data.num_keys,
+	IWL_DEBUG_WOWLAN(mld, "Number of rekeys: %d\n",
 			 wowlan_status->num_of_gtk_rekeys);
 
-	if (!key_iter_data.num_keys || !wowlan_status->num_of_gtk_rekeys)
+	if (!wowlan_status->num_of_gtk_rekeys)
 		return true;
 
 	iwl_mld_add_all_rekeys(mld, vif, wowlan_status,
-- 
2.34.1


