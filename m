Return-Path: <linux-wireless+bounces-9203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B356890D9B3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87DC1C210DF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347AD13D50B;
	Tue, 18 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvVCJjt5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93813C807
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729068; cv=none; b=Ip0cB+7dAwA0ILDem0ulKOUtZB9R7FGtPHWxp/uc14Bvbm4v8sArHHwN8sJlCfRJEvZbicfLzuQatup/jliPSMT9vVlobegCMsCXEG4frHt9nZRJX5B6dCB34GMR7SlrjAWJdjcLH78+djneTKFvrN/Vu0+zCsgpz8WYy7QBIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729068; c=relaxed/simple;
	bh=JlCzq2C5AxN42wAMTePATTHirh2nRx1fGe+4k+aJu+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrAvcC3xoJPFE8eqaCtfVFO/aUq+f575bu9oZbE1sPAirr+//YW4YI3ZQr21hFp0tqrqCcW2E2ydCasPhWZW57UQp8SD8hb6dOuGK6FLLsg9WN/1Y7YW7Pch4RmN0uDA57Z/GJwz3iv6xDpvZImRVTdk9FEC88lom2fGuoYwcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvVCJjt5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729066; x=1750265066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JlCzq2C5AxN42wAMTePATTHirh2nRx1fGe+4k+aJu+Y=;
  b=nvVCJjt5QT3cAgo4MNsFNevKMcCrs0ETU5Wkzxd50+aMOIdWCpqMTeGO
   U4K1Kkjdz8EUkXl50V71XG/nnxvwNZyyrR5YACzHk1cazASu6egisqDls
   r9SOIYlg2pMi6NwaIYc+ZyQ6pnEDwC4rd5maYD60wVQwmq6GmXKvQq/C1
   /kozVuZqCquqhvGnglMbB5NyjXP6a+eOjgEfoOqQ7O8miQAgx5rP24FVs
   btMqbdDDAUqvE2dh9a3pX1H5GPR+gqWwY6nXeWjH996t89ZY4rzuuluXK
   Z8yTMT9TpR9xFEP2IIfwgDUxFsZxV2V5tWOkcsOu5wQidApNGZXwOkVdo
   w==;
X-CSE-ConnectionGUID: ekf2xCp7Rqy4P5RK/5JfsQ==
X-CSE-MsgGUID: o6sj3ZimR06zvd5vrjbw2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257169"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:26 -0700
X-CSE-ConnectionGUID: G0RHw4zCT6ivfGZgqvtk9w==
X-CSE-MsgGUID: AJng66LkRkKxU22HsE7F6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306507"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: mvm: remove IWL_MVM_PARSE_NVM
Date: Tue, 18 Jun 2024 19:44:04 +0300
Message-Id: <20240618194245.bded22049fae.I980c4a941d769f93cf74bfc90a7d7d9fb384dea1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This debug is not in use anymore. Remove it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 1abe9e9fd46b..c4c1e67b9ac7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -56,7 +56,6 @@
 #define IWL_MVM_RS_80_20_FAR_RANGE_TWEAK	1
 #define IWL_MVM_TOF_IS_RESPONDER		0
 #define IWL_MVM_HW_CSUM_DISABLE			0
-#define IWL_MVM_PARSE_NVM			0
 #define IWL_MVM_ADWELL_ENABLE			1
 #define IWL_MVM_ADWELL_MAX_BUDGET		0
 #define IWL_MVM_TCM_LOAD_MEDIUM_THRESH		10 /* percentage */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b8a785032513..36ed08f20f80 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -686,14 +686,6 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 			goto error;
 	}
 
-	if (IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
-		ret = iwl_nvm_init(mvm);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
-			goto error;
-		}
-	}
-
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						NVM_ACCESS_COMPLETE),
 				   CMD_SEND_IN_RFKILL,
@@ -718,7 +710,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 		return ret;
 
 	/* Read the NVM only at driver load time, no need to do this twice */
-	if (!IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
+	if (!mvm->nvm_data) {
 		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw,
 					    mvm->set_tx_ant, mvm->set_rx_ant);
 		if (IS_ERR(mvm->nvm_data)) {
-- 
2.34.1


