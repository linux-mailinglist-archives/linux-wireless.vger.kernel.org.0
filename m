Return-Path: <linux-wireless+bounces-25194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E856EB00956
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3111C43B7C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A52F0E3B;
	Thu, 10 Jul 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UC0Dw+4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723472F004D
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166522; cv=none; b=KtJLBHR6/yy+zkDf8yoL6H9umCZy/X2tBW9btDw6GojH1XfvOfHVNE2LXeyl1GXTQpzPnmNWsIrBa7YjPZdeeeceg8mg4dA++A8pwjAoXWkOIr07vn7uxOuD1PTib3kB70fwfYS58HaKIFmxiFe2dSKBbCyaPmCmDd+DB9fFXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166522; c=relaxed/simple;
	bh=/CfY1CzIdiK6DyWA5pL6S95m9sCRq8otp3dEPfiPrwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CeHaELd+q9iPeoYz/JETSyTpdE4aAUSj7G4Idt/AInU3XeQjsNnGXcUTksSPLgd5vPm21ojxzgYmbxAxXtgwFODxRj3KhW11HqLDqMiX70LtoVXAkLATMqJyx6uEiNK5N+hlY+H5xDdeONvxoHBeOb9OwYRu04F4i94f/Vh8qDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UC0Dw+4u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166520; x=1783702520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CfY1CzIdiK6DyWA5pL6S95m9sCRq8otp3dEPfiPrwg=;
  b=UC0Dw+4ux3uCM4q0gnSqoyFfa/Uq1pQkl8GaWpPmim/wIFOVaci63UzP
   1SjWz9OFH3inqHSeAm6vZQ1VgpSVD/MHJ5aC8RM/Bi/LJdgq22odAr1Cd
   3q6lvkhyqDOrShGJT2+K+gsS+kkvvpwzrExE/CtaRaCZZTQ5HaEFemEC6
   yGXVc/heh1nu6LQK1a5CZItwagU1jFOjkBf1q8OtkekwZCyxUq0HUkaig
   Svhnpc8112LsTVFlU0rlyZ89SKq2DSIktHeoWO0sXxfE+GsQ6wK/AddRu
   Muzy1XU+UmqUZJXfFeo78DlU/q7jh25oKIXSg6gvr8oW/L1AgCeMmU+N5
   Q==;
X-CSE-ConnectionGUID: 4hv5EAcIR16RZhUEKx+WwA==
X-CSE-MsgGUID: Nx4wUp0TSCiTQ+1/QIVMqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610004"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:18 -0700
X-CSE-ConnectionGUID: Ctl4tCQnRIS+Wx3NLUGF/g==
X-CSE-MsgGUID: 4Y2DPfeqRymRwjmPJh8dug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277045"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: iwlwifi: add iwl_trans_device_enabled() API
Date: Thu, 10 Jul 2025 19:54:40 +0300
Message-Id: <20250710195219.bb957ba9e130.I6ab825caf41308fb0f7aa1c266f50457fd0c496e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

add iwl_trans_device_enabled() function to be called by the op modes
instead of directly checking the trans status bits. This
hides the trans internal implementation details.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dump.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c  | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fd60a6816150..ed72199c0b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2978,7 +2978,7 @@ IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect_desc);
 int iwl_fw_dbg_error_collect(struct iwl_fw_runtime *fwrt,
 			     enum iwl_fw_dbg_trigger trig_type)
 {
-	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status))
+	if (!iwl_trans_device_enabled(fwrt->trans))
 		return -EIO;
 
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
@@ -3180,7 +3180,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
-	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
+	if (!iwl_trans_device_enabled(fwrt->trans)) {
 		IWL_ERR(fwrt, "Device is not enabled - cannot dump error\n");
 		goto out;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 4e1ef165f058..f633124979ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -490,7 +490,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	struct iwl_pc_data *pc_data;
 	u8 count;
 
-	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
+	if (!iwl_trans_device_enabled(fwrt->trans)) {
 		IWL_ERR(fwrt,
 			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index aa0c8ca82805..200a8d5d5bb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1235,6 +1235,11 @@ static inline void iwl_trans_suppress_cmd_error_once(struct iwl_trans *trans)
 	set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &trans->status);
 }
 
+static inline bool iwl_trans_device_enabled(struct iwl_trans *trans)
+{
+	return test_bit(STATUS_DEVICE_ENABLED, &trans->status);
+}
+
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 79660138ae97..9ce1ce0dab34 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3547,7 +3547,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
+	if (!iwl_trans_device_enabled(mvm->trans)) {
 		ret = 0;
 		goto out;
 	}
-- 
2.34.1


