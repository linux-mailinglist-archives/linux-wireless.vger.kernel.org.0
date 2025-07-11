Return-Path: <linux-wireless+bounces-25289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7EDB02094
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CC67BECE8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0992EE27E;
	Fri, 11 Jul 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOserGcp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E82EE28C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248108; cv=none; b=lTl/gSnDbj3RagQc8KQ1VlqNmaNzA4Ui/O+CvdBqxwypN46fO8WCHCapt77b7DNSj4qHIxVKmT+d9wJUtYEKfBiEDW21KUHe0EPTcjoEloyY+5RvvQ6nanVLBcEpfT9x7K0Nm75ZqWJD8SKIyIRP3ievcBG9gtXZrHsVYCmF4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248108; c=relaxed/simple;
	bh=28FePwuHE151rXhmaFBkn+CGG4MFHhHZsdkSs12gCsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdwTd2e6u50EhqvrBWWGlaKpS5h+SsFk5/hqJDcclnLqYBL6qp6n052p9I/CiRMjEDpxxLO/nyvhHUBp75AJiJ2Z4g5omKPrvH5AhCpgk9GeXKqauxee7eT4p5Pt1xfX+72Z5xEIFtQt0+KqXQjFSqK0unD9AjVHyACxzfvPaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOserGcp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248108; x=1783784108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=28FePwuHE151rXhmaFBkn+CGG4MFHhHZsdkSs12gCsE=;
  b=AOserGcpXykxsB2dqnsPxxhBBupvnYs4fCvSmOKSdwsvJ5/lES6KhRSX
   k4vDxvz85zpBPhubnprX3tk+q8UFIQYoQvD+NunqMZRjHv6ORSQ9RNtdo
   rDChs44uAXbun5keuHWGsHIGSau75c3Cn/AFPrFfj4brlPjpBAbyQpUQt
   OlbeNC4u4UiXLq9UrJ0ne3mPgVOflWJbSw4hyw0vqePFbR9MaQ2XJbIFZ
   0pvt9vn2v6O/SHqF5lN/zuikuYkVYeLEuBDuR6bH9JgQThkDjpckKaDjl
   7weEofCKq9RburtLtT8dIfIrqphusz7IZ6jGaf/KE+chjLf+0AE7Js/tU
   Q==;
X-CSE-ConnectionGUID: KWgIriOeQxO0kEjya1EO/w==
X-CSE-MsgGUID: 7FoV1jr6R0mTEfvhzeHptw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264173"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:07 -0700
X-CSE-ConnectionGUID: gMbQBGUBTzy3M/GWuNweVA==
X-CSE-MsgGUID: fvekPDzsTG2LddGXvtSI/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485191"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: remove support of version 4 of iwl_wowlan_rsc_tsc_params_cmd
Date: Fri, 11 Jul 2025 18:34:28 +0300
Message-Id: <20250711183056.89156be9bc7f.I5ff5c1055eaf4fef9bd73233ea4d95504634ceed@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This are not used in any of our devices. Remove it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  5 ----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 29 +++++++------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index b16bd8aa136a..53445087e9cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -456,11 +456,6 @@ struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 {
 	union iwl_all_tsc_rsc all_tsc_rsc;
 } __packed; /* ALL_TSC_RSC_API_S_VER_2 */
 
-struct iwl_wowlan_rsc_tsc_params_cmd_v4 {
-	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 params;
-	__le32 sta_id;
-} __packed; /* ALL_TSC_RSC_API_S_VER_4 */
-
 struct iwl_wowlan_rsc_tsc_params_cmd {
 	__le64 ucast_rsc[IWL_MAX_TID_COUNT];
 	__le64 mcast_rsc[WOWLAN_GTK_KEYS_NUM][IWL_MAX_TID_COUNT];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 8930f8e3c0de..ef9bab042902 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -211,7 +211,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 }
 
 struct wowlan_key_rsc_tsc_data {
-	struct iwl_wowlan_rsc_tsc_params_cmd_v4 *rsc_tsc;
+	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 *rsc_tsc;
 	bool have_rsc_tsc;
 };
 
@@ -236,16 +236,16 @@ static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
 			u64 pn64;
 
 			tkip_sc =
-			   data->rsc_tsc->params.all_tsc_rsc.tkip.unicast_rsc;
+			   data->rsc_tsc->all_tsc_rsc.tkip.unicast_rsc;
 			tkip_tx_sc =
-				&data->rsc_tsc->params.all_tsc_rsc.tkip.tsc;
+				&data->rsc_tsc->all_tsc_rsc.tkip.tsc;
 
 			pn64 = atomic64_read(&key->tx_pn);
 			tkip_tx_sc->iv16 = cpu_to_le16(TKIP_PN_TO_IV16(pn64));
 			tkip_tx_sc->iv32 = cpu_to_le32(TKIP_PN_TO_IV32(pn64));
 		} else {
 			tkip_sc =
-			  data->rsc_tsc->params.all_tsc_rsc.tkip.multicast_rsc;
+			  data->rsc_tsc->all_tsc_rsc.tkip.multicast_rsc;
 		}
 
 		/*
@@ -269,15 +269,15 @@ static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
 			u64 pn64;
 
 			aes_sc =
-			   data->rsc_tsc->params.all_tsc_rsc.aes.unicast_rsc;
+			   data->rsc_tsc->all_tsc_rsc.aes.unicast_rsc;
 			aes_tx_sc =
-				&data->rsc_tsc->params.all_tsc_rsc.aes.tsc;
+				&data->rsc_tsc->all_tsc_rsc.aes.tsc;
 
 			pn64 = atomic64_read(&key->tx_pn);
 			aes_tx_sc->pn = cpu_to_le64(pn64);
 		} else {
 			aes_sc =
-			   data->rsc_tsc->params.all_tsc_rsc.aes.multicast_rsc;
+			   data->rsc_tsc->all_tsc_rsc.aes.multicast_rsc;
 		}
 
 		/*
@@ -480,30 +480,21 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		else
 			ret = 0;
 		kfree(data.rsc);
-	} else if (ver == 4 || ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
+	} else if (ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
 		struct wowlan_key_rsc_tsc_data data = {};
-		int size;
 
 		data.rsc_tsc = kzalloc(sizeof(*data.rsc_tsc), GFP_KERNEL);
 		if (!data.rsc_tsc)
 			return -ENOMEM;
 
-		if (ver == 4) {
-			size = sizeof(*data.rsc_tsc);
-			data.rsc_tsc->sta_id =
-				cpu_to_le32(mvm_link->ap_sta_id);
-		} else {
-			/* ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN */
-			size = sizeof(data.rsc_tsc->params);
-		}
-
 		ieee80211_iter_keys(mvm->hw, vif,
 				    iwl_mvm_wowlan_get_rsc_tsc_data,
 				    &data);
 
 		if (data.have_rsc_tsc)
 			ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
-						   CMD_ASYNC, size,
+						   CMD_ASYNC,
+						   sizeof(data.rsc_tsc),
 						   data.rsc_tsc);
 		else
 			ret = 0;
-- 
2.34.1


