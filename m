Return-Path: <linux-wireless+bounces-9540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898D916E79
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D41F22942
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF6177991;
	Tue, 25 Jun 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtltC13a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D9176248
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334302; cv=none; b=rJz/UHirhKkdnKjDqPRdrywdh1j26Bp47bAjsoKbYODDOw2PvA63ia1o8iMsVAh9W8Tz0lNNZ27sRs0468+0dzLXRJHtnogFBnqeKYJGCygsktsjTQ1E4A4ILShYlxz8eqh+Yq+GJ2ZlZmx7a35Cald11wc0WUuUoR92jyPJt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334302; c=relaxed/simple;
	bh=2mD5nuL17sBSIXp/z5zQUEs5jciy1nMatYSt4pny2XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7JELv47TsUszBEeUxbEL0mfnNSK3GZ38CqW1ODB/j/7RyD9QZ0l2pgK4ucGG7ZyFcmHcxhO58VBTWGYH1xn7te1/s1QPPZB0JJ4Ayj6o9Pk9yInzd/9RFlDpQQbOLZpD6am17c2K+F5EGKtHt5fqQ/IsFLsgpSOWXgW58EBfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtltC13a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334301; x=1750870301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mD5nuL17sBSIXp/z5zQUEs5jciy1nMatYSt4pny2XU=;
  b=QtltC13aT3Ro9DA/QwG10HdukeD39cW30JKl3/CsJM0pHeQnuhfXjimA
   wJKrfIqFGYw9RqrjHGxpVD8GLV8CLF0JbMMkiH7DHzRVsoW27i63b5lpB
   XTXrcydenogm+qFQVJMnCK2R7lIeO6PPLmkW44gk0rRtpXxXOmSRO7HzX
   M6i2Xa48X3EyrOCsEILbnRGIxRADkTOIp8eEnfPojPxp4tYQX3SoAk8o3
   zeKKBU2TaFtzibORCRB93CSPkUFbHjTReO9+bWpB8aFqn027XquSrViSP
   pZxZvOIe1hl8jeGngeKchdJLoQXPTqhuEMVzLZ9VkiOZDvW4/BhAXpRjo
   g==;
X-CSE-ConnectionGUID: luOpQ3VbR2qE9A2n9N2dQg==
X-CSE-MsgGUID: B0WtncUrQCqT3CXMW9hAxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594726"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:41 -0700
X-CSE-ConnectionGUID: 9NNsdXqzSTuwP7aUm+2eJQ==
X-CSE-MsgGUID: BDmwBo85TzCaigXa09RiXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632570"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: mvm: remove init_dbg module parameter
Date: Tue, 25 Jun 2024 19:51:12 +0300
Message-Id: <20240625194805.17a1484f2485.I095c7482ac517111081f8ff40312b48ffdd7ff94@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is no longer used

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 8 ++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 5 -----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 9 +--------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 52102a24f972..1f27ed9c3886 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -828,7 +828,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 	iwl_remove_notification(&mvm->notif_wait, &calib_wait);
 out:
 	mvm->rfkill_safe_init_done = false;
-	if (iwlmvm_mod_params.init_dbg && !mvm->nvm_data) {
+	if (!mvm->nvm_data) {
 		/* we want to debug INIT and we have no NVM - fake */
 		mvm->nvm_data = kzalloc(sizeof(struct iwl_nvm_data) +
 					sizeof(struct ieee80211_channel) +
@@ -1357,9 +1357,6 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 
 	if (ret) {
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
-
-		if (iwlmvm_mod_params.init_dbg)
-			return 0;
 		return ret;
 	}
 
@@ -1598,8 +1595,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	IWL_DEBUG_INFO(mvm, "RT uCode started.\n");
 	return 0;
  error:
-	if (!iwlmvm_mod_params.init_dbg || !ret)
-		iwl_mvm_stop_device(mvm);
+	iwl_mvm_stop_device(mvm);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8eeb405e4326..f2d0c6fbcee5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -83,14 +83,9 @@ extern const struct ieee80211_ops iwl_mvm_mld_hw_ops;
 
 /**
  * struct iwl_mvm_mod_params - module parameters for iwlmvm
- * @init_dbg: if true, then the NIC won't be stopped if the INIT fw asserted.
- *	We will register to mac80211 to have testmode working. The NIC must not
- *	be up'ed after the INIT fw asserted. This is useful to be able to use
- *	proprietary tools over testmode to debug the INIT fw.
  * @power_scheme: one of enum iwl_power_scheme
  */
 struct iwl_mvm_mod_params {
-	bool init_dbg;
 	int power_scheme;
 };
 extern struct iwl_mvm_mod_params iwlmvm_mod_params;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 008fe5fece87..df0de859fed4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -41,12 +41,8 @@ static const struct iwl_op_mode_ops iwl_mvm_ops_mq;
 
 struct iwl_mvm_mod_params iwlmvm_mod_params = {
 	.power_scheme = IWL_POWER_SCHEME_BPS,
-	/* rest of fields are 0 by default */
 };
 
-module_param_named(init_dbg, iwlmvm_mod_params.init_dbg, bool, 0444);
-MODULE_PARM_DESC(init_dbg,
-		 "set to true to debug an ASSERT in INIT fw (default: false");
 module_param_named(power_scheme, iwlmvm_mod_params.power_scheme, int, 0444);
 MODULE_PARM_DESC(power_scheme,
 		 "power management scheme: 1-active, 2-balanced, 3-low power, default: 2");
@@ -864,8 +860,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 		ret = iwl_mvm_init_mcc(mvm);
 	}
 
-	if (!iwlmvm_mod_params.init_dbg || !ret)
-		iwl_mvm_stop_device(mvm);
+	iwl_mvm_stop_device(mvm);
 
 	mutex_unlock(&mvm->mutex);
 	wiphy_unlock(mvm->hw->wiphy);
@@ -1500,8 +1495,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_fw_flush_dumps(&mvm->fwrt);
 	iwl_fw_runtime_free(&mvm->fwrt);
 
-	if (iwlmvm_mod_params.init_dbg)
-		return op_mode;
 	iwl_phy_db_free(mvm->phy_db);
 	kfree(mvm->scan_cmd);
 	iwl_trans_op_mode_leave(trans);
-- 
2.34.1


