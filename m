Return-Path: <linux-wireless+bounces-22470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267BAA9C16
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83A917D69A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07726FA50;
	Mon,  5 May 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyIEN4Ky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615C25D539
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471441; cv=none; b=HdFQ/MohOf7mx7b6S58cOaflMVocEZiexJPzIE8tWlZax8qgzEYK8j1RTKrFEUS31JJdpBwVHPAy2W3+tWLJZN2r7HCf4eU/qI5CxpZFUuyXU/0Rw0d8BLM8vOzx4maZvfuPkW1jRKSYBqyoPMlwxiYkge35Z/J2WzOh3VgyWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471441; c=relaxed/simple;
	bh=BkHDf74Zzz3a9x3vE5jugRAlw5gDUgGQSRc9407dVmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXf68txa5Z7BhXY4uPALp9lCANOAD0cArpNZFViiUmXoPxga5H6Zuj8/mpMa15pcvxYzNFzbPal5dnhqGVqJdffgeXAlTOH+zXmjhIELnjzaKAGg0UNvJnfTVaNEd1sVBqa3/pHbZEt6/8/KY5AmtjlLmA3KJXObsTdGrNzyKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyIEN4Ky; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471439; x=1778007439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BkHDf74Zzz3a9x3vE5jugRAlw5gDUgGQSRc9407dVmY=;
  b=IyIEN4Kyn4SNTRo02l++EVndJt7vhFmj8LbkH7/yBCFZn5k37quTveuk
   UhkeGCwE7W3Pme9Bt2CybABjgCzp1F4k0w17F4Vv2TgnOVwfMmmpIqb3I
   I9AvlThbzFMJtNooEoz0NBh5bStYp7At0RvwN5+t/YMtRhmSGEY/auijb
   hMS665KDXdRI0a00NWnWXmExmfCfAHBBDvnh4TOiOVV7sukFL2OnBE3dO
   BNgxC1OmY9Z2dpIPMyfab1TktbsgiT+2HLUxp9dLhRVjofN2SZqTGN1kO
   cfIeGqcgt70cGJiLRP7+pk2l13MxareMLNnz8TeBj1R0GbCgkPpaE2+gM
   w==;
X-CSE-ConnectionGUID: 8mym6I2bSb6SfmTiPRS/9A==
X-CSE-MsgGUID: bNeHawk5R+eHUeRfIiXBgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359448"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:19 -0700
X-CSE-ConnectionGUID: I+1ZCdjiSqaDEOUqgFQDEA==
X-CSE-MsgGUID: sK2ewmKDQb6tdOfT6WwmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697988"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: remove NVM C step override
Date: Mon,  5 May 2025 21:56:46 +0300
Message-Id: <20250505215513.6210ac6cda09.I83cc3e68f0ed99a922d435c203fef840a28eb0de@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This was used for debug/bringup of 8000 devices, to be able to
unify between all 8000 devices with NVM override. However, this
is really no longer used, those are ancient devices by now, so
we can remove the logic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c  |  3 ---
 .../net/wireless/intel/iwlwifi/iwl-config.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c   | 18 ++----------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 9a1623091af7..6f0e62a4c8fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -35,8 +35,6 @@
 #define IWL8265_MODULE_FIRMWARE(api) \
 	IWL8265_FW_PRE "-" __stringify(api) ".ucode"
 
-#define DEFAULT_NVM_FILE_FAMILY_8000C		"nvmData-8000C"
-
 static const struct iwl_base_params iwl8000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 31,
@@ -92,7 +90,6 @@ const struct iwl_cfg_trans_params iwl8000_trans_cfg = {
 	.dccm2_len = IWL8260_DCCM2_LEN,					\
 	.smem_offset = IWL8260_SMEM_OFFSET,				\
 	.smem_len = IWL8260_SMEM_LEN,					\
-	.default_nvm_file_C_step = DEFAULT_NVM_FILE_FAMILY_8000C,	\
 	.thermal_params = &iwl8000_tt_params,				\
 	.apmg_not_supported = true,					\
 	.nvm_type = IWL_NVM_EXT,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index fe701410a44f..e2ce1c7d8c90 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -362,7 +362,6 @@ struct iwl_cfg {
 	const struct iwl_ht_params *ht_params;
 	const struct iwl_eeprom_params *eeprom_params;
 	const struct iwl_pwr_tx_backoff *pwr_tx_backoffs;
-	const char *default_nvm_file_C_step;
 	const struct iwl_tt_params *thermal_params;
 	enum iwl_led_mode led_mode;
 	enum iwl_nvm_type nvm_type;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index db49f0caff12..734f9e814a54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -308,7 +308,6 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	int ret, section;
 	u32 size_read = 0;
 	u8 *nvm_buffer, *temp;
-	const char *nvm_file_C = mvm->cfg->default_nvm_file_C_step;
 
 	if (WARN_ON_ONCE(mvm->cfg->nvm_hw_section_num >= NVM_MAX_NUM_SECTIONS))
 		return -EINVAL;
@@ -384,21 +383,8 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 		/* read External NVM file from the mod param */
 		ret = iwl_read_external_nvm(mvm->trans, mvm->nvm_file_name,
 					    mvm->nvm_sections);
-		if (ret) {
-			mvm->nvm_file_name = nvm_file_C;
-
-			if ((ret == -EFAULT || ret == -ENOENT) &&
-			    mvm->nvm_file_name) {
-				/* in case nvm file was failed try again */
-				ret = iwl_read_external_nvm(mvm->trans,
-							    mvm->nvm_file_name,
-							    mvm->nvm_sections);
-				if (ret)
-					return ret;
-			} else {
-				return ret;
-			}
-		}
+		if (ret)
+			return ret;
 	}
 
 	/* parse the relevant nvm sections */
-- 
2.34.1


