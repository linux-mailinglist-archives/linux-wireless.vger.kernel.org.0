Return-Path: <linux-wireless+bounces-25211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F7B00B60
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36643AA66F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7F2FCFF7;
	Thu, 10 Jul 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJfTi5vc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7F2FCE14
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172144; cv=none; b=keVw2Y+Bk/PcWomIOva87fUczWY0aroJqZ9BaTO0i8gnz+qQa6vhXVAHXO39J39+M867ADj+LVTvQJUueTeu+MLtc7+T4Ml9VHJwCEROdFoLXCYbur19fuI32sJ/j19WGKsng68BY0pkZpGieiM0S0ilenISsLzdj1tGmAK6z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172144; c=relaxed/simple;
	bh=/CfY1CzIdiK6DyWA5pL6S95m9sCRq8otp3dEPfiPrwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWweszy26DJW9ziacqhfwmBk0EsP9W1QL2ek4hoG5Tm6V+NS0JglIu6gLjnipQ3ViJMIbaH9LcfqQzuxY3cu5NsryWvJD/mFWorvTGwA9J+fOTAuT4ObqP4NQryfVqWfbzBITWh3epugwOnSKGubaGXUh7ytW+yBj5QXyFSRNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJfTi5vc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172143; x=1783708143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CfY1CzIdiK6DyWA5pL6S95m9sCRq8otp3dEPfiPrwg=;
  b=aJfTi5vcvPJi5HAp93gmWgDSqcfrIALJkbXDzg77hpUZbFdolYOmF2dK
   WrcHTzc8jX7328E5VFeCb8Y20Z+YuJvceyFmHnxNvWQTqNx4DOfIGHyl7
   ruy37a2esRxC0jsPe/wPaBSiF4Fx//R3DMONMDJbVmApVaIhuiMN/KhnZ
   KMZOqm+6NXHCz1Ky3fh0xUgp1jZxzifBbQKsSADUHL9aVM4NP3vSngAiF
   A/FYDa6AonJvwi0x5fWJcQFGG0/RLovlbJF7wlI9sdBxk8Ms+mNw+VKgO
   4rgjzKkWBcvgOssW6vNAL/WbM5Dy0WgpQj3HGCIIIyDP+ddpac6fXSZYJ
   Q==;
X-CSE-ConnectionGUID: 8ln852hoQ1iBXszkaXDRAg==
X-CSE-MsgGUID: IDjByaviTGuuoJvAFqOsBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077797"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:03 -0700
X-CSE-ConnectionGUID: YKIK1FpgSxWigPLyDGP1tA==
X-CSE-MsgGUID: K2fJjRwSRe+qBdPTOuKFUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718724"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: add iwl_trans_device_enabled() API
Date: Thu, 10 Jul 2025 21:28:24 +0300
Message-Id: <20250710212632.bb957ba9e130.I6ab825caf41308fb0f7aa1c266f50457fd0c496e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
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


