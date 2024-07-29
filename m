Return-Path: <linux-wireless+bounces-10624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4F93FC4C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0752C281A5A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DA15F3EA;
	Mon, 29 Jul 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjxpJwae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5C16C6A4
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273638; cv=none; b=Ee92hBC0c7effiNIfvbhSvDq+ma7T6A8ZmJSZajcidGK6Zh9jY30hEPnbZLvqBpJG+mDAYZHirrHK971dOe0qKViSrFwfJo4TtwJ1wVsSGnc5nGI4aRJXvlFO1RbSDpFYVEz1m4LwgFiSUOsd5vFr653zPBrOgKtjUqkWFX1Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273638; c=relaxed/simple;
	bh=+oyCn3PhQKGx00aB+hX+NIUe1QTtQt3AZJvCfyUgLEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hq0GHdPyUmdiukGOtZL0H4eoniArpW4vGPpWnYBMd6h6cN9MGWarrD9Fe2kU5ui0wjIn8q1rIsPaYdtC5UojbuM+pyhwc7r2j/22hAMlUlHR4TH3rGNFSpelfyxMThDVVCGimcTXbhzHRkGISiQiaUMy8vFULGoOvec+vrBDbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjxpJwae; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273637; x=1753809637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+oyCn3PhQKGx00aB+hX+NIUe1QTtQt3AZJvCfyUgLEI=;
  b=SjxpJwae7A+VwQKMDME0k8TOXoxVVdfMe/gEJUjKRiLTcf40TsL/DaLa
   t9+5XIyj3+IPjNijV66+Hz6bgWrtw6Ysk4oeHr6P4zh2vX9afAifF130s
   2UiOB5UqcMim6tzS3DJFpB8NcZ6TrsK9rize8JtB3yfZg5TQGiUiN+poh
   s772zYyv7XiVzNP7pw1n4G0l/FzcUWP60m5yfAqvdBgNfnYxD+vY2Mf33
   B/d+v2znANzx73xAWTgpjF0YVbTKxkgFeeY4NGNr8Liu3N5iy1LxMuxxd
   6gFgeFsY8pPIdAOm3nfVHjWio/hPeCToq1ffU23NhIsyIKDUW63z/YNf4
   A==;
X-CSE-ConnectionGUID: tVwlQB+dQmqdUSn08dj++A==
X-CSE-MsgGUID: vXw+V1jzR3SXl8OWTs1kDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445571"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445571"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:37 -0700
X-CSE-ConnectionGUID: 3lb6tDuYQDebbWiWzpiHGQ==
X-CSE-MsgGUID: Mw3DDAfuSLy9uKsDIoa2Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288271"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: mvm: use correct key iteration
Date: Mon, 29 Jul 2024 20:20:05 +0300
Message-Id: <20240729201718.69a2d18580c1.I2148e04d4b467d0b100beac8f7e449bfaaf775a5@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

In the cases changed here, key iteration isn't done from
an RCU critical section, but rather using the wiphy lock
as protection. Therefore, just use ieee80211_iter_keys().
The link switch case can therefore also use sync commands.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 8a38fc4b0b0f..455f5f417506 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -144,7 +144,7 @@ static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
 	if (sta != data->sta || key->link_id >= 0)
 		return;
 
-	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cmd), &cmd);
+	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
 
 	if (err)
 		data->err = err;
@@ -162,8 +162,8 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 		.new_sta_mask = new_sta_mask,
 	};
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
-				&data);
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
+			    &data);
 	return data.err;
 }
 
@@ -402,7 +402,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	if (!sec_key_ver)
 		return;
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif,
-				iwl_mvm_sec_key_remove_ap_iter,
-				(void *)(uintptr_t)link_id);
+	ieee80211_iter_keys(mvm->hw, vif,
+			    iwl_mvm_sec_key_remove_ap_iter,
+			    (void *)(uintptr_t)link_id);
 }
-- 
2.34.1


