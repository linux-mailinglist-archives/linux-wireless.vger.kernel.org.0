Return-Path: <linux-wireless+bounces-14595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F489B2F63
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A651CB22133
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39091D95BC;
	Mon, 28 Oct 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBTMnPxs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D31D9587
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116531; cv=none; b=ic3CBc0XoIl0PwZIchRR/pxefoIl5YRRAimHdkNX0WqpvoNsFR4//CVwTHX6jblRMbK6TvSIxYLPBVG6tLivPajcvKUuf3aR/zh2uea+mABs+sUF0C0yfQbrjNF4E9PgM94exlB6vMmCf2NGH3ySQINUXA76zzAiMNwDs+5Z9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116531; c=relaxed/simple;
	bh=QJ2MJx2/lvwsGXKtk5ldRpmxQpefw4lUXB/nG/T8IEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDg6ptas54GUD56Tq+O/ViumkenhBtlvbcmBrGWrPLfJcuKA0pqfu93rmE0UPG08O21/HeY85qRKvwsvmmyp6nokwuFwEbMY2jfA3V4TS8sJVpk8DRoub9iYGjxeHobBbqGkQcGK28TDCp8q1AkMB4Ln3/b5Igldrrjdwyj9TYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBTMnPxs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116530; x=1761652530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJ2MJx2/lvwsGXKtk5ldRpmxQpefw4lUXB/nG/T8IEU=;
  b=aBTMnPxsrn2EoAWdMKFcxxFLePYLc6nUfG8TkLL3yCONU19DISCJ1KIE
   MYIAJLiCz5k4lsJZfUpseDOlRVg4Y0sDg1V/8dVOmA3CFmfzj/LxGxIEI
   O7WUx99CoEd5j8mzZbtXjdQ5l/YGyel2BdU/vyrpC4cAuchZ0j0d8ztfE
   nWATyeWV6RqV4AhX6YWCOSxE/sIjAP84Fil2+daSXfd4nBFDkSF2AyR5l
   hZrj0HJAPpYeMZAz0+tXWH62eh6rGNwtClpK3bKYibSX70o12Lr/PRSMO
   4fpDDJzCwb35m5XJw0iWm//FuLUiPMO6mD8AQ05TzO+Sa9MSANZnRFL9R
   A==;
X-CSE-ConnectionGUID: /1kDXj/jQ86JktT9cZxw9g==
X-CSE-MsgGUID: 1IJEpVYzQcKHbMB8AGWdFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813900"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813900"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:28 -0700
X-CSE-ConnectionGUID: puYmZS95SliBPAZnHGOyaw==
X-CSE-MsgGUID: Pw7oTdUaSMOQSPGWXPbf+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432592"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: support new initiator and responder command version
Date: Mon, 28 Oct 2024 13:54:52 +0200
Message-Id: <20241028135215.264826832f16.Iad4fdcd177a9c4bcb0839d3f87c793b4f83eb2c7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add support for range_request_cmd version 15. This version adds a
testing option flag to use bad secure LTF Tx key. The command struct
itself is not changed.
Add support for responder config command version 11. This version only
adds a flag which is part of the MVM_FTM_RESP_FLAGS and does not
require any special handling.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 30a54c7fa001..15aab3bbb7e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -616,6 +616,9 @@ struct iwl_tof_range_req_ap_entry_v2 {
  *	continue with the session and will provide the LMR feedback.
  * @IWL_INITIATOR_AP_FLAGS_TEST_INCORRECT_SAC: send an incorrect SAC in the
  *	first NDP exchange. This is used for testing.
+ * @IWL_INITIATOR_AP_FLAGS_TEST_BAD_SLTF: use incorrect secure LTF tx key. This
+ *	is used for testing. Only supported from version 15 of the range request
+ *	command.
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -633,6 +636,7 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_PMF = BIT(14),
 	IWL_INITIATOR_AP_FLAGS_TERMINATE_ON_LMR_FEEDBACK = BIT(15),
 	IWL_INITIATOR_AP_FLAGS_TEST_INCORRECT_SAC = BIT(16),
+	IWL_INITIATOR_AP_FLAGS_TEST_BAD_SLTF = BIT(17),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 55245f913286..77cfad6707f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1063,6 +1063,8 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
+		case 15:
+			/* Version 15 has the same struct as 14 */
 		case 14:
 			err = iwl_mvm_ftm_start_v14(mvm, vif, req);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index e4caa362f597..e6e468e81ab3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -131,7 +131,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (cmd_ver == 10) {
+	if (cmd_ver >= 10) {
 		cmd.band =
 			iwl_mvm_phy_band_from_nl80211(chandef->chan->band);
 	}
-- 
2.34.1


