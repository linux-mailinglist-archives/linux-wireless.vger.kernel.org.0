Return-Path: <linux-wireless+bounces-18665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24AA2DDCD
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43E03A45F1
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2371CD1E4;
	Sun,  9 Feb 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmLA7i0K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DE1DDC22
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104518; cv=none; b=vCp5cA4u3vmeJ6Kkbb0A3FJhjibbifYNOJP7hz210210UnGH2Y2rORp7X5c5X4RrP9v31p6MJ+T7yNKGhaUaQwdESGOcVNaivfsWqJMpE+ELb0i1NZuiaClXt6HCKLzGYf36SFmUdq+qjap2VgLhf06KYuReg3swXrTXkxwQ27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104518; c=relaxed/simple;
	bh=n0tWg4GTE4cf8DbWgrNpF0LwkF+vjQb3zR3ZS1aBqgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsJXDD1us82OSY6eqJt3uZcnlIZSR6g+PJraqGSC0H95r0XH6bG3KQpckvC2Qyl8kazFuj12ZKwe7/LIlN2uRnbjsPkOTL71AuuhtI8DtZ2gQViqbafQ9ssJRx78PswOiLE0Dh9LnuncVyoAaCw78qZZmXETFziZ+SZP1FmuQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmLA7i0K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104516; x=1770640516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0tWg4GTE4cf8DbWgrNpF0LwkF+vjQb3zR3ZS1aBqgQ=;
  b=cmLA7i0KFAY7MDfntppOD0AuvcJASFUCn2iOlb4iOG/T40rcO/hGuJPK
   fcCbXrvmbVB215/TvsnE6zKXXI51t815gRDpHHmEC5I6h9qq5ZNsEdaD7
   FuSphhp2dTaBdAcukoBeuXuNIyy2Wsyzp9ILOtC/b1LBTKul7wz+x1CYp
   JQV2t6sRtYVEqKavEpLp2TZSX4GEz07raC8zQApf+xNnBiGoNK2gdM1/G
   dhRTz/g9aOmLDpQsbclp/1nROV0MA6n+vWmUVeTAUbPaI2zY6vA/exjv5
   f+S9MmG9yeLPJfz4o8PJhWmOIGl8vb6pRAkLGxGM7Y2VpJBbrKIele1ax
   w==;
X-CSE-ConnectionGUID: Yui+4flZTfmpAPyZlQbQAA==
X-CSE-MsgGUID: Y+2+A8o5S4GKsBTrmYq6Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125978"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125978"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:16 -0800
X-CSE-ConnectionGUID: 2zs6FeN9Qn+y3C81F6wJMw==
X-CSE-MsgGUID: LlPqzDJ/Q3e8Lp7fBPdmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782440"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 4/9] wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while suspend
Date: Sun,  9 Feb 2025 14:34:48 +0200
Message-Id: <20250209143303.a10463a40318.I14131781c3124b58e60e1f5e9d793a2bc88b464c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is not really a firmware error. We need to reload the firmware, but
this doesn't mean that we should consider this as a firmware error.
When the firmware was restarted upon resume, this wasn't felt by the
driver. Now that we keep the firmware running during suspend even if we
don't have wowlan, this started to pop-up.

Fixes: e8bb19c1d590 ("wifi: iwlwifi: support fast resume")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 77 ++++++++++++++-------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 129b6bdf9ef9..82ca7f8b1bb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3092,8 +3092,14 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 		ieee80211_resume_disconnect(vif);
 }
 
-static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif)
+enum rt_status {
+	FW_ALIVE,
+	FW_NEEDS_RESET,
+	FW_ERROR,
+};
+
+static enum rt_status iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
+					      struct ieee80211_vif *vif)
 {
 	u32 err_id;
 
@@ -3101,29 +3107,35 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.lmac_error_event_table[0],
 				    &err_id)) {
-		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
-			struct cfg80211_wowlan_wakeup wakeup = {
-				.rfkill_release = true,
-			};
-			ieee80211_report_wowlan_wakeup(vif, &wakeup,
-						       GFP_KERNEL);
+		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN) {
+			IWL_WARN(mvm, "Rfkill was toggled during suspend\n");
+			if (vif) {
+				struct cfg80211_wowlan_wakeup wakeup = {
+					.rfkill_release = true,
+				};
+
+				ieee80211_report_wowlan_wakeup(vif, &wakeup,
+							       GFP_KERNEL);
+			}
+
+			return FW_NEEDS_RESET;
 		}
-		return true;
+		return FW_ERROR;
 	}
 
 	/* check if we have lmac2 set and check for error */
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.lmac_error_event_table[1],
 				    NULL))
-		return true;
+		return FW_ERROR;
 
 	/* check for umac error */
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.umac_error_event_table,
 				    NULL))
-		return true;
+		return FW_ERROR;
 
-	return false;
+	return FW_ALIVE;
 }
 
 /*
@@ -3492,6 +3504,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	bool d0i3_first = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_D0I3_END_FIRST);
 	bool resume_notif_based = iwl_mvm_d3_resume_notif_based(mvm);
+	enum rt_status rt_status;
 	bool keep = false;
 
 	mutex_lock(&mvm->mutex);
@@ -3515,14 +3528,19 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
-	if (iwl_mvm_check_rt_status(mvm, vif)) {
-		IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
+	rt_status = iwl_mvm_check_rt_status(mvm, vif);
+	if (rt_status != FW_ALIVE) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
-		iwl_mvm_dump_nic_error_log(mvm);
-		iwl_dbg_tlv_time_point(&mvm->fwrt,
-				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
-		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
-					false, 0);
+		if (rt_status == FW_ERROR) {
+			IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
+			iwl_mvm_dump_nic_error_log(mvm);
+			iwl_dbg_tlv_time_point(&mvm->fwrt,
+					       IWL_FW_INI_TIME_POINT_FW_ASSERT,
+					       NULL);
+			iwl_fw_dbg_collect_desc(&mvm->fwrt,
+						&iwl_dump_desc_assert,
+						false, 0);
+		}
 		ret = 1;
 		goto err;
 	}
@@ -3679,6 +3697,7 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 		.notif_expected =
 			IWL_D3_NOTIF_D3_END_NOTIF,
 	};
+	enum rt_status rt_status;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -3688,14 +3707,20 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 	mvm->last_reset_or_resume_time_jiffies = jiffies;
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
-	if (iwl_mvm_check_rt_status(mvm, NULL)) {
-		IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
+	rt_status = iwl_mvm_check_rt_status(mvm, NULL);
+	if (rt_status != FW_ALIVE) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
-		iwl_mvm_dump_nic_error_log(mvm);
-		iwl_dbg_tlv_time_point(&mvm->fwrt,
-				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
-		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
-					false, 0);
+		if (rt_status == FW_ERROR) {
+			IWL_ERR(mvm,
+				"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
+			iwl_mvm_dump_nic_error_log(mvm);
+			iwl_dbg_tlv_time_point(&mvm->fwrt,
+					       IWL_FW_INI_TIME_POINT_FW_ASSERT,
+					       NULL);
+			iwl_fw_dbg_collect_desc(&mvm->fwrt,
+						&iwl_dump_desc_assert,
+						false, 0);
+		}
 		mvm->trans->state = IWL_TRANS_NO_FW;
 		ret = -ENODEV;
 
-- 
2.34.1


