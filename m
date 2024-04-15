Return-Path: <linux-wireless+bounces-6310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A398A4AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E61C211ED
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571984086A;
	Mon, 15 Apr 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7ks42lE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E04085C
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171299; cv=none; b=Rln+bK+uQpb191DJSTT3Z2tyvioLxeH62boAoycXCp1Nx7z9lGNeBl3ysT4CQFt/9mEQWqnKtXRzQYTo6+QAT3kg8aZ1e0T8lxfyyT+MW+Y5QlCOJ8MA5sTZOrYrzIQOtEqI3i4XILhbqHs1YLM0s2eVRKIYOg/jqM4GviCFoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171299; c=relaxed/simple;
	bh=bXgaqCgw7xKuP/KR9ppNdwiWOxwHv4d15kW9CD5dfGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CghVHULO6AFlEdIgSXRa6S2TJNJE/kdD2l4POo5lls3oyPZ0Bf6Xyy6j5uQEgBlvruJC5JHSGFKfvA+tBIyHvcKLpEJbFAfI8TMTjgh7ULU1T/7y6jYqfhuKPyzyRuUGdlEPf3yCig7+yoDrBZ2Md6SCJ3VhGinQTlYz2lf3Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7ks42lE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171298; x=1744707298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXgaqCgw7xKuP/KR9ppNdwiWOxwHv4d15kW9CD5dfGk=;
  b=T7ks42lEWZ6YN7sDg+bxrfSwCH5EuqhH15FXcVfv3OpYIOLaXv1ENrEm
   z3Pf9A2BiPCL7LcV+hkQCFmzigghMNFqq4GRBjl1L0CkLa/Lf20uOVIcP
   /2/XI/Zox9Tpz4K6u3Oahlcbdb3zdfP4Djj3WfDALfVZC8HijuAx6l62K
   SZrHUBF2M0oMf+Wr6C2TezNhrTP9L0sipbzPE9688IqMzug7xoPHwmcLe
   nGcqxB5SfX0wIg+8KLs+K6RdfrHOYb8JON/MA7k7x7ZkcNHSFNJO7zcPR
   J9vr4rXMuE0XZtq7IexO4+h2de3aM//fehKA2C/2nM1cCGn/rJLcnoNex
   w==;
X-CSE-ConnectionGUID: 9JO9LOWfRJu8MlwskBU9TA==
X-CSE-MsgGUID: a0sDGa/wQYCVrRd04dpMKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100584"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100584"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:57 -0700
X-CSE-ConnectionGUID: T2H7pifPSliT5ND1CS5vAg==
X-CSE-MsgGUID: cJmkh7cbR3qUErMnFrTxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21767946"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: mvm: Refactor tracking of scan UIDs
Date: Mon, 15 Apr 2024 11:54:35 +0300
Message-Id: <20240415114847.7011e93363a2.Idb9b401414864dfc5540d8798a6cb2b192a2acc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Instead of setting the UID to type mapping while building the
scan command, set the UID to type mapping only after the scan
request command was sent successfully.

This resolves a bug where in case a scan request command fails
and a recovery flow is initiated, the recovery flow would indicate
to mac80211 that scan is completed though it was not really started.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index fc6b4f699cb6..f2fe9ee83d68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2281,8 +2281,6 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_scan_umac_dwell(mvm, cmd, params);
 
-	mvm->scan_uid_status[uid] = type;
-
 	cmd->uid = cpu_to_le32(uid);
 	gen_flags = iwl_mvm_scan_umac_flags(mvm, params, vif);
 	cmd->general_flags = cpu_to_le16(gen_flags);
@@ -2323,10 +2321,8 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	ret = iwl_mvm_fill_scan_sched_params(params, tail_v2->schedule,
 					     &tail_v2->delay);
-	if (ret) {
-		mvm->scan_uid_status[uid] = 0;
+	if (ret)
 		return ret;
-	}
 
 	if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
 		tail_v2->preq = params->preq;
@@ -2476,8 +2472,6 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int ret;
 	u16 gen_flags;
 
-	mvm->scan_uid_status[uid] = type;
-
 	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(type));
 	cmd->uid = cpu_to_le32(uid);
 
@@ -2558,10 +2552,8 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 							 params->n_channels,
 							 pb, cp, vif->type,
 							 version);
-	if (!cp->count) {
-		mvm->scan_uid_status[uid] = 0;
+	if (!cp->count)
 		return -EINVAL;
-	}
 
 	if (!params->n_ssids ||
 	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
@@ -3026,11 +3018,13 @@ static int _iwl_mvm_single_scan_start(struct iwl_mvm *mvm,
 		 */
 		IWL_ERR(mvm, "Scan failed! ret %d\n", ret);
 		iwl_mvm_resume_tcm(mvm);
-		mvm->scan_uid_status[uid] = 0;
 		return ret;
 	}
 
-	IWL_DEBUG_SCAN(mvm, "Scan request was sent successfully\n");
+	IWL_DEBUG_SCAN(mvm, "Scan request send success: type=%u, uid=%u\n",
+		       type, uid);
+
+	mvm->scan_uid_status[uid] = type;
 	mvm->scan_status |= type;
 
 	if (type == IWL_MVM_SCAN_REGULAR) {
@@ -3169,7 +3163,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
 		IWL_DEBUG_SCAN(mvm,
-			       "Sched scan request was sent successfully\n");
+			       "Sched scan request send success: type=%u, uid=%u\n",
+			       type, uid);
+		mvm->scan_uid_status[uid] = type;
 		mvm->scan_status |= type;
 	} else {
 		/* If the scan failed, it usually means that the FW was unable
@@ -3177,7 +3173,6 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		 * should try to send the command again with different params.
 		 */
 		IWL_ERR(mvm, "Sched scan failed! ret %d\n", ret);
-		mvm->scan_uid_status[uid] = 0;
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
-- 
2.34.1


