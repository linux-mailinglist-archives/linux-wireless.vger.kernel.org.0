Return-Path: <linux-wireless+bounces-26542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8DB30177
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF333A08754
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07789341AD4;
	Thu, 21 Aug 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hliq3py8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800423451C9
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798491; cv=none; b=SBbbu5lyaLOm9/6LY51+c4C02aGfY+b6+/tKLl4yCBPqJ6bj/pxlB7mp1t52He9LU4Eix8vdlboBantqEqzTclsvnyfp+rfnMjL6+mIPnaKDsN9GfDD2mrUv/lA4gs9yOEspeASPWytM3wW1NktcshC5D98FozNi/w9tAoqMxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798491; c=relaxed/simple;
	bh=CH1yhMYjIYz7YrhlXGs7CZ1tiTcUSkOJSa4cyh163sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER/N7ttcSqU2iZFNjyKI6zfd7vwz1dKiwiEMpB4SgsmQL7/B5NMlC6A7jGh0gPAjml9vXr62RGaRktDjpVKd77v58AZnPPmmJyIUy35BI6UYq9oyF0Mfl53WK3L0Ga5z7fIn0YtlxnJo0Tfm82Rg7vsixA8mTd0buzYZsGromv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hliq3py8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798491; x=1787334491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CH1yhMYjIYz7YrhlXGs7CZ1tiTcUSkOJSa4cyh163sk=;
  b=hliq3py8EamvqsCvLhu0DWbKMh5M5tvCDzVJyNMzIl7fzhZLWuqgmrYA
   mVnk7AwQ8oYJrStoV+yuZ40TdXAFW9478+o5V2KpDKfSnCsHTh4ZHDWQf
   OgU/Zc8TV0i3eimwYvNFTNT6UtyEEIxnKnTavHAhcnkf2J+76LOruBL/X
   DI6/LvOg0DocgLCU3m+0UrLLcCDMUaUrPICZOXAKdS7JHn6KaBJeOl37D
   poozA8XM6OMgrp2ByePXN6hhIgjIwTuOGm95OgouIbvOcKYocoTJedDFF
   L5QfzuAE40cZvy9wxRlnLdWt9F/oiuJf68+Bu3hDoJpjl40w9agv007b5
   g==;
X-CSE-ConnectionGUID: gZkNQBRAR7WSnRllQ/NmFA==
X-CSE-MsgGUID: qKFtifIPQmuJ+na383+HYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806104"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:10 -0700
X-CSE-ConnectionGUID: xak4uI8lRiC8c10JFqcuGQ==
X-CSE-MsgGUID: b5kKYjYLQZOUfFSlDZdexw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: mld: don't validate keys state on resume
Date: Thu, 21 Aug 2025 20:47:26 +0300
Message-Id: <20250821204455.fb7e3bd4a967.I7eb24756ee27ad7b6731c0fb5dce5acb5d986694@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
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


