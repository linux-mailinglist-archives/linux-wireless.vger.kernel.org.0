Return-Path: <linux-wireless+bounces-16834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1959FD1BD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D3C188359C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F2154C17;
	Fri, 27 Dec 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiDkOdp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE214F132
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286507; cv=none; b=l/cNDx7NTjIrKUmQKCHYG12j81IZTc0SGVVdB32i3plP0cEcFpvSGcilPX1Wt5PHJyE+29uN0+lQ2LkbgGp0whtxW2hr+9O8tDfHWL8MCHYfWJEK/GMtLf50i/EyfUfRVWsuB0qN/2jGkewqJ7oueJyD17B5/KGb+GZ1PkHdMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286507; c=relaxed/simple;
	bh=GY/n8NDGc23Xcik/UnVapgxz1Bn97hOjtLqU82PBYKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5YJAUH5Y8mcqxdFOGWjfTd3DweLooXIvlpNNrZnbQYuIbV9+1XSgroq6iqlLFxxDoqHVQf8tNiUv6pBICZadhBWYrsIenl9KB2epWwFtRNWvJDszSzdEy/muZydMjP1IkmvO9L/z//UASCRbkbu76EbgWUFxNHQyEDHTa7z6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiDkOdp0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286505; x=1766822505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GY/n8NDGc23Xcik/UnVapgxz1Bn97hOjtLqU82PBYKU=;
  b=CiDkOdp0vonttu+dXSS4I9CZwPGCMeZOfiHY9YrK4yZ0+7sMOJ54MSgt
   PsBHhmb1CgLe4YXR7rneL4IxG5s9BhnTIUVXfYM6KVMjNtU9oLToj5JoS
   Tz+uVaFXSSl4fDdZkf2G6hem227WMfldUa1aN492z1aMAiqNGuaWZ4AAf
   cSXOviQx9NyRrl+YlmKdDpXNtGHsjRIL4gi0gCRFo9/D+OmBsyemLlzdL
   yRqaFZ944LjBV+6kTSJ+FS54NcFNglO+iD76hL6KVMfdq3wwr0qHSAvVS
   R5KZQnMABPFxn88YipHKnmx7H1cfuADmiMoegjoUlTgR6zej1WrKM1dO4
   Q==;
X-CSE-ConnectionGUID: iW8eq5NeS3yUwKY/YuGCSA==
X-CSE-MsgGUID: IyIq5b9ORNq6o0U9Nb8Ptw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690974"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690974"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:43 -0800
X-CSE-ConnectionGUID: VRlWtuhBSQuaejXMlHvFOQ==
X-CSE-MsgGUID: 9t5Z23jPTZquBsAig0guhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858414"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/17] wifi: iwlwifi: mvm: remove STARTING state
Date: Fri, 27 Dec 2024 10:01:07 +0200
Message-Id: <20241227095718.c55d73436521.I08e9f6a71d56f86872bca4d4e3048faa113a7120@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that the retry loop only happens when timeouts occur
and firmware errors are different, we no longer need the
STARTING state with all the infrastructure for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 +--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 3 ---
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b3c75484dafd..6b58231add55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1300,14 +1300,8 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 
 	/* we are starting the mac not in error flow, and restart is enabled */
 	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
-	    iwlwifi_mod_params.fw_restart) {
+	    iwlwifi_mod_params.fw_restart)
 		max_retry = IWL_MAX_INIT_RETRY;
-		/*
-		 * This will prevent mac80211 recovery flows to trigger during
-		 * init failures
-		 */
-		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
-	}
 
 	for (retry = 0; retry <= max_retry; retry++) {
 		ret = __iwl_mvm_mac_start(mvm);
@@ -1316,7 +1310,6 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 
 		IWL_ERR(mvm, "mac start retry %d\n", retry);
 	}
-	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 
 	mutex_unlock(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ad615293c75..d0ba9e0f15b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1401,8 +1401,6 @@ DEFINE_GUARD(mvm, struct iwl_mvm *, mutex_lock(&_T->mutex), mutex_unlock(&_T->mu
  * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
  * @IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE: suppress one error log
  *	if this is set, when intentionally triggered
- * @IWL_MVM_STATUS_STARTING: starting mac,
- *	used to disable restart flow while in STARTING state
  */
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
@@ -1414,7 +1412,6 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_IN_D3,
 	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
-	IWL_MVM_STATUS_STARTING,
 };
 
 struct iwl_mvm_csme_conn_info {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 623122cadd32..de815504183c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2051,9 +2051,6 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 */
 	if (!mvm->fw_restart && fw_error) {
 		iwl_fw_error_collect(&mvm->fwrt, false);
-	} else if (test_bit(IWL_MVM_STATUS_STARTING,
-			    &mvm->status)) {
-		IWL_ERR(mvm, "Starting mac, retry will be triggered anyway\n");
 	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
 
-- 
2.34.1


