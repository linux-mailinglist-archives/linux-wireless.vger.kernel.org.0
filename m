Return-Path: <linux-wireless+bounces-16810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611669FCBA4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E914C18832A5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288E43AA8;
	Thu, 26 Dec 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfrQhqVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D41EEE9
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227922; cv=none; b=UUW2rySD3EpFIuXb9F4Q7ijNvCYBVUWBwtpuem2tzwiqPGfCIjM/ATM9+/h1l9Ez6BF+KxPI6SBbNZTFwCFXLso9yiDg0gQ5BbN/QoGwMCdkzNOPYqkFK3jdmk6aM7GnfqbP/MyKW8lybN1snkQhIV1Q3rP0KYcuqdm/txUID7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227922; c=relaxed/simple;
	bh=uxmQf6yg8Lr588gUXCDkJeuHyIeQXxy/mdXY+og8alQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/zzKUCf/Ijj5h9ielCIy0U+A1CbUO8j/mbMiY2Emiijp2zHeD2s6ZSGIpVXJjiHj69kJmGIPVRCNeFaeglArdNdl5gKWbRps7k01hiGwiiY6pGfczqMSe6aDuHPmHoVTkep6Wu9h5gZBPOR7iMjBfESCEnACTUef7cNItFFXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfrQhqVl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227920; x=1766763920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uxmQf6yg8Lr588gUXCDkJeuHyIeQXxy/mdXY+og8alQ=;
  b=FfrQhqVlGTj8ctXqO74PBh0yohBMjBlXdmGXfq/b+rlXuP6y8Y4vf4Fn
   zp35/gwOVSBX4BHeu4FSoTKr3bZ5sVcbfBNvL5E6FqyhAk9UoNFmTvjKB
   J3SUheB+kdxEgnC9eE7+h7ULdv/CgW8VjURrbpbQ2346EiLcZzSd/Sg64
   /cznnd+10wbfATLj73kYRALeTNYLxsSYSr5JL+47Xihw6cDIDE8q4pbqd
   Qbq3udpDjzQldbNoQ4rA53cYdN048xSYey8iQaeN3uYRCrxoxJfGwXdyo
   SUdL4+WGPvAOBM7P+7rWWmrf0Vct9qFDExnj84eupz/L0FL0RZVovdsui
   w==;
X-CSE-ConnectionGUID: dukamTfcRmW+eMtrRMQvuA==
X-CSE-MsgGUID: zM3lxTT7SqWa9BLoadL1Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878137"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878137"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:19 -0800
X-CSE-ConnectionGUID: k8FphWV4SPixPmJMB0naqQ==
X-CSE-MsgGUID: C3MBEafaQV+3tbjBh6G8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777988"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: log error for failures after D3
Date: Thu, 26 Dec 2024 17:44:46 +0200
Message-Id: <20241226174257.df1e451d4928.Ibe286bc010ad7fecebba5650097e16ed22a654e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

We only logged an error in the fast resume path. However, as the
hardware is being restarted it makes sense to log an error to make it
easier to understand what is happening.

Add a new error message into the normal resume path and update the
error in the fast resume path to match.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f85c01e04ebf..cab11229bd7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3533,6 +3533,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
 	if (iwl_mvm_check_rt_status(mvm, vif)) {
+		IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
 		iwl_mvm_dump_nic_error_log(mvm);
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
@@ -3705,8 +3706,7 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
 	if (iwl_mvm_check_rt_status(mvm, NULL)) {
-		IWL_ERR(mvm,
-			"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
+		IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
 		iwl_mvm_dump_nic_error_log(mvm);
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
-- 
2.34.1


