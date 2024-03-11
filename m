Return-Path: <linux-wireless+bounces-4544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D48877AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E1281DDE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D6171A5;
	Mon, 11 Mar 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoq6kY4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4F16439
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138534; cv=none; b=CpalJcBWxTy8PhEgxeQCyPeR3/Ipb1/oeBZt161YRlNJZZQlaM59RXa9D/kPMQWiuIAGCRWgfNjQsfc9jezNGHBvW0nHInPmpXE5flzxZD8Ztm/6AztBrqZGYa2CM8a1XFojIufGMqUk3AmaS7umteoAHj9Lxhlssd0lzBlWfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138534; c=relaxed/simple;
	bh=MFloIgI5v9dnNoEBYqUfcXrOYWgCa/uxfDf4WzTNonU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Io7vG4/S6gqkc/YYoAGHU3sotzK4rwgQTmq8x7BDX0Lyvxa8HILLzoKYFssHRGUvvnnYCvzeNVFnTMubBSZaVzVaCLE9XjlzNkK85pZdIoMRhRds+1KhblCUlbNoU98LOPJ97YoQVWABjHfdndFKFzu4EMYo/PDR3qwb6brgSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoq6kY4z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138533; x=1741674533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFloIgI5v9dnNoEBYqUfcXrOYWgCa/uxfDf4WzTNonU=;
  b=eoq6kY4zVQAoRL7uiZLJvF6wuBqa9jC4rYtl285/hz2Gpv1p1PH2iwDX
   n+DMoz60AKaHdNJ4KuT7PgqncPa6dB7n2eEeXgsMqm3ofaJMEogK6oQkY
   qSGqnT4rZfl9mrox/bUmtBMo6x0XnXNFTP6tUYsT4Du1j7uiokUPQIDjU
   2vODcJVkPGVOLAwO2pFBqsd6ebxII0l9CNPSaYRo+IUpBoePtzsms8UGS
   3K3grht+a8Yo6yow4apgaMACERnTMcfXCcMADuB53cJil2XFeq+62HVgK
   qnhy75k+Sjc3nBuixAJvs2gMmqInm8wcRV5UIOy8JGWJ2eE/tuDCbptzY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226797"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226797"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657724"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: Refactor scan start
Date: Mon, 11 Mar 2024 08:28:12 +0200
Message-Id: <20240311081938.e7833d4cfc53.I43c1c533c2a5243229002fde6360d423946c54fa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

To support staring internal scan, refactor the scan code such
that the body iwl_mvm_reg_scan_start() is now moved to a local
function that can be used by other flows as well.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index f3e3986b4c72..a6f42d55bd98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2914,9 +2914,11 @@ static void iwl_mvm_fill_respect_p2p_go(struct iwl_mvm *mvm,
 	}
 }
 
-int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   struct cfg80211_scan_request *req,
-			   struct ieee80211_scan_ies *ies)
+static int _iwl_mvm_single_scan_start(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct cfg80211_scan_request *req,
+				      struct ieee80211_scan_ies *ies,
+				      int type)
 {
 	struct iwl_host_cmd hcmd = {
 		.len = { iwl_mvm_scan_size(mvm), },
@@ -2934,7 +2936,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EBUSY;
 	}
 
-	ret = iwl_mvm_check_running_scans(mvm, IWL_MVM_SCAN_REGULAR);
+	ret = iwl_mvm_check_running_scans(mvm, type);
 	if (ret)
 		return ret;
 
@@ -2983,8 +2985,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_scan_6ghz_passive_scan(mvm, &params, vif);
 
-	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params,
-				     IWL_MVM_SCAN_REGULAR);
+	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
 
 	if (uid < 0)
 		return uid;
@@ -3004,7 +3005,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	}
 
 	IWL_DEBUG_SCAN(mvm, "Scan request was sent successfully\n");
-	mvm->scan_status |= IWL_MVM_SCAN_REGULAR;
+	mvm->scan_status |= type;
 	mvm->scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
 	if (params.enable_6ghz_passive)
@@ -3016,6 +3017,14 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
+int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   struct cfg80211_scan_request *req,
+			   struct ieee80211_scan_ies *ies)
+{
+	return _iwl_mvm_single_scan_start(mvm, vif, req, ies,
+					  IWL_MVM_SCAN_REGULAR);
+}
+
 int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_sched_scan_request *req,
-- 
2.34.1


