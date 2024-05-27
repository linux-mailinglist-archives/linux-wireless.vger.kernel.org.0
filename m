Return-Path: <linux-wireless+bounces-8121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A048D07F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F01C20307
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAD15D5D2;
	Mon, 27 May 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvGsKQw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC07346D
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825996; cv=none; b=O46/Db1zkuHpW85Hzj3zBY3b8SUBu1epb2jetDm8CONErwYLNek6gmdMfj2s+q9oPtRdSjdhpPmmwGc+T1pElPCL8EIhZ1pcMuQpt43wcdh9fcWcl91Da7M//YtSKat9HEPWlF97mZnQXzySaw8TBSqHDveeSY9lW9NU1Ml2LZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825996; c=relaxed/simple;
	bh=haIERDVN8aIfsXOHcTTGoVqbQocflAXSZNpuk/9L7zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WK/zyBg6m3qzJa2bcCfRqI/ZejyG0fIiwtBejVd7HuMZ4xzsShFWW7UDaAfSX4EO5uD9oQJ5gaLv5NWFEGgoEwz28l86xzpF9c9wCFFGF8soaxhaH8+rVVXTYKq52H4iw5oUsWvhK5YMf6HzpQFu2iZZg9SOfBRnMj+hch4w8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvGsKQw+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825995; x=1748361995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haIERDVN8aIfsXOHcTTGoVqbQocflAXSZNpuk/9L7zU=;
  b=ZvGsKQw+Orxc+faTJU9AXS3I94S/41eUaXK++DpRQFS1aVh6rkZsD2EF
   yNyFwXFPzJg37RF+dC+REHnxeOgbK7UD1fezCLSRxN+qsgnPtq6jFknSE
   U+zlloUyxdvKazEEXJ0NazM3bOOr1WcKQENW8F8d9AyV0639c7WAFBaFb
   sy4U5tMi1s2j5R6q3iUrvHMKxAbDTc8cbnnSTEiCv5nOng2MI8MqgBZio
   /P3Lzgd/jNAFXOjAoi4J8ezBP2Fz7XO5+7IXgB1Tmedzpa/8f9N5lPZZQ
   +G9YIwA/XeI6p3JVse0OnbSGE9ztnvPnKkM0q5YnrNszcwPaJtOj+tWFM
   g==;
X-CSE-ConnectionGUID: JcN66xEpRViYtLgHJdG3Cg==
X-CSE-MsgGUID: 0SgwwLvXTZOSi694W4t+Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002083"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002083"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:35 -0700
X-CSE-ConnectionGUID: MZgcheqPQ/StN0cHzogWbA==
X-CSE-MsgGUID: 95DOrkAlRnaYAu8W01jqZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407091"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 07/20] wifi: iwlwifi: mvm: initiator: move setting target flags into a function
Date: Mon, 27 May 2024 19:06:02 +0300
Message-Id: <20240527190228.9d22b61ce589.I7dbe596b4f677638d9a48c3f39b0826a9e35bea4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Move setting the target flags into a dedicated function to support
different versions of the target struct.
This is done as preparation for moving to the new range request
version.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 72a3d71f46f0..98b1bbfc84bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -434,44 +434,55 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 #define FTM_PUT_FLAG(flag)	(target->initiator_ap_flags |= \
 				 cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
 
+#define FTM_SET_FLAG(flag)	(*flags |= \
+				 cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
+
 static void
-iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
-			      struct cfg80211_pmsr_request_peer *peer,
-			      struct iwl_tof_range_req_ap_entry_v6 *target)
+iwl_mvm_ftm_set_target_flags(struct iwl_mvm *mvm,
+			     struct cfg80211_pmsr_request_peer *peer,
+			     __le32 *flags)
 {
-	memcpy(target->bssid, peer->addr, ETH_ALEN);
-	target->burst_period =
-		cpu_to_le16(peer->ftm.burst_period);
-	target->samples_per_burst = peer->ftm.ftms_per_burst;
-	target->num_of_bursts = peer->ftm.num_bursts_exp;
-	target->ftmr_max_retries = peer->ftm.ftmr_retries;
-	target->initiator_ap_flags = cpu_to_le32(0);
+	*flags = cpu_to_le32(0);
 
 	if (peer->ftm.asap)
-		FTM_PUT_FLAG(ASAP);
+		FTM_SET_FLAG(ASAP);
 
 	if (peer->ftm.request_lci)
-		FTM_PUT_FLAG(LCI_REQUEST);
+		FTM_SET_FLAG(LCI_REQUEST);
 
 	if (peer->ftm.request_civicloc)
-		FTM_PUT_FLAG(CIVIC_REQUEST);
+		FTM_SET_FLAG(CIVIC_REQUEST);
 
 	if (IWL_MVM_FTM_INITIATOR_DYNACK)
-		FTM_PUT_FLAG(DYN_ACK);
+		FTM_SET_FLAG(DYN_ACK);
 
 	if (IWL_MVM_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_LINEAR_REG)
-		FTM_PUT_FLAG(ALGO_LR);
+		FTM_SET_FLAG(ALGO_LR);
 	else if (IWL_MVM_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_FFT)
-		FTM_PUT_FLAG(ALGO_FFT);
+		FTM_SET_FLAG(ALGO_FFT);
 
 	if (peer->ftm.trigger_based)
-		FTM_PUT_FLAG(TB);
+		FTM_SET_FLAG(TB);
 	else if (peer->ftm.non_trigger_based)
-		FTM_PUT_FLAG(NON_TB);
+		FTM_SET_FLAG(NON_TB);
 
 	if ((peer->ftm.trigger_based || peer->ftm.non_trigger_based) &&
 	    peer->ftm.lmr_feedback)
-		FTM_PUT_FLAG(LMR_FEEDBACK);
+		FTM_SET_FLAG(LMR_FEEDBACK);
+}
+
+static void
+iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
+			      struct cfg80211_pmsr_request_peer *peer,
+			      struct iwl_tof_range_req_ap_entry_v6 *target)
+{
+	memcpy(target->bssid, peer->addr, ETH_ALEN);
+	target->burst_period =
+		cpu_to_le16(peer->ftm.burst_period);
+	target->samples_per_burst = peer->ftm.ftms_per_burst;
+	target->num_of_bursts = peer->ftm.num_bursts_exp;
+	target->ftmr_max_retries = peer->ftm.ftmr_retries;
+	iwl_mvm_ftm_set_target_flags(mvm, peer, &target->initiator_ap_flags);
 }
 
 static int
-- 
2.34.1


