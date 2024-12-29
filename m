Return-Path: <linux-wireless+bounces-16874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9129FDF4B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1C61882193
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2518A956;
	Sun, 29 Dec 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhWPeoiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAD197A8E
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483528; cv=none; b=Rpsyf6QviMOYsHV6oOSI3Dcy6zIhrww7zE5frBNArZ2hCjwc5UPEEwUw0yyHq5+EWcGxMbL6UM/yg9ezxgPgfaGqeQuIOA7+IIskYEh1G+N77tKSMWpiB4dyMYt+CUk8cEUhSIp6ehhFnthOxvKgJRC1yEG2tl5u2Y538cOwCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483528; c=relaxed/simple;
	bh=BhJojQ3XYGLVpmd8UbNE9TZR54T6i37Tyf/JryGoY8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyuBi7g8ilcZyLmdpSvGNZRs/FNAIN3pWcreOKOw+zlE1zNXPST5nD8lx0VaAxnHTdtoD1U+BnHwAi8eiTXBSGAmIs+Lge+Iex7l2lYW9mIM4y7Uq8erPj/kLgx60Gitlta6v7tUi4k5P1PlQIQTAv4hFkwcXEjZIbRcIaYqeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhWPeoiT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483527; x=1767019527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhJojQ3XYGLVpmd8UbNE9TZR54T6i37Tyf/JryGoY8Q=;
  b=OhWPeoiT32Y7c1+E+Kid8yt5v74Cbtt4lWsXjD+tnDPqa8UimZYnqfSv
   ZG0XzNCDWP6io9wVgItP97vBXMY5+Vpx2Xc89lQSoHInyjLY3cmLTvbpi
   CV0hbva7jApknOpmcIs3AHU2GsCVnnL13WCPJC9tbFYogamtNzntHQCQv
   VYRQ79ZFFzmZQdTMiBinnnTyVRtnhZgU++XDGSmnNezVZB2CQ63nml9n/
   30uqIUe2p2sQWv5/dwfbrv8sdsm+32ZGbp5KvdQDICyLcR1AF2klO3xEI
   CaHDBcP/vOz5ptGcxiDOyIp1AomXdxIOa8f3rKW1rr/1B92fogDSsaJbS
   A==;
X-CSE-ConnectionGUID: EwzphfQYRvq5oWisVLoFbw==
X-CSE-MsgGUID: mTWOc6ZQQk+e69WWGxWATw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572461"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572461"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:27 -0800
X-CSE-ConnectionGUID: +jCzXOLMT3mQOvNMIx/+yQ==
X-CSE-MsgGUID: nA0kyRv2RYSGlkmzFeTH6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656977"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ruan Jinjie <ruanjinjie@huawei.com>
Subject: [PATCH 13/17] wifi: iwlwifi: mvm: Use helper function IS_ERR_OR_NULL()
Date: Sun, 29 Dec 2024 16:44:48 +0200
Message-Id: <20241229164246.d3423626d981.I3b4cc7f19d1bfecdb2e6a4eba8da1c7a41461115@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Use IS_ERR_OR_NULL() instead of open-coding it
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 65927ebbabb7..36379b738de1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -24,7 +24,7 @@ void iwl_mvm_teardown_tdls_peers(struct iwl_mvm *mvm)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
-		if (!sta || IS_ERR(sta) || !sta->tdls)
+		if (IS_ERR_OR_NULL(sta) || !sta->tdls)
 			continue;
 
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -47,7 +47,7 @@ int iwl_mvm_tdls_sta_count(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
-		if (!sta || IS_ERR(sta) || !sta->tdls)
+		if (IS_ERR_OR_NULL(sta) || !sta->tdls)
 			continue;
 
 		if (vif) {
@@ -472,7 +472,7 @@ void iwl_mvm_tdls_ch_switch_work(struct work_struct *work)
 				mvm->fw_id_to_mac_id[mvm->tdls_cs.peer.sta_id],
 				lockdep_is_held(&mvm->mutex));
 	/* the station may not be here, but if it is, it must be a TDLS peer */
-	if (!sta || IS_ERR(sta) || WARN_ON(!sta->tdls))
+	if (IS_ERR_OR_NULL(sta) || WARN_ON(!sta->tdls))
 		return;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-- 
2.34.1


