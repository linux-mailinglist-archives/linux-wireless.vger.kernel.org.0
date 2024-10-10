Return-Path: <linux-wireless+bounces-13846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B399846C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE6B25739
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B91C3305;
	Thu, 10 Oct 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqCmubHE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D81C2DD4
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558329; cv=none; b=cJJgbiDfU6gmtIGo6D75P9G7uQH+KpIBLJwdHXMqTxcLflaUp48IF/Q8aSyVqJ86rYuZ1DXuD3CAWvR9aIiHtVGgvZGnpSArwRqDcGhrvcsfnKH/CYVt587+EVKe9b+ecDaTMbjqbhsWzCA+0+e7QdSa/CP7G2MMZ2dQLhpKa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558329; c=relaxed/simple;
	bh=QB8rQy4zPTXqDM3JrFzuN/6lCJiG8m07y5ea3Ak/Xo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qH3N8sXHA/Ig46tFjpesubxvlXX64koydqDunVJjs/hgIhVgNlbShUe0FYScCIP5aISnZvc/DIH9b4LOJSE78JWOTlbZmDbQ+50EgJK0u8stDlS8iqi2TPXptnuJ1508SfeaE6wy6aHTVALB+VpE0tGkztxbQKuk2SVFyYnKkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqCmubHE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558328; x=1760094328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QB8rQy4zPTXqDM3JrFzuN/6lCJiG8m07y5ea3Ak/Xo8=;
  b=RqCmubHEXucDB/LAeJWoXh5AsBj/g6cIZVN3acolwijgW4HbFK7eqRKf
   V9K5sRLiXRWVsYbqObxlwqY/hAsE+xFFHuLFdQrUIZT23fsNHuH+QOS0s
   jI5+aLdygfGxK4JjTweJWg+Iw0md6yUm1L4kjunfxhLSJZP7IUuRJnma1
   Z1xAHt6hq8Qpm6n36lUZ7tCw7N35ihRejv82yR7cFQpNAKK2RHv3puYur
   0nxqUuT+gYoju9P+VRjHxGwO2kjxKf/itfl2yjalbBBLkNo1yVLwEvAkJ
   Ipv+IgCN/7Wn5vl21VsGhW4kpe+dzCxmHM4YuUgKOcE82pKnF5/GkcUPf
   Q==;
X-CSE-ConnectionGUID: a1HG5DTwRR22chkDZ90nYQ==
X-CSE-MsgGUID: n5ecdee3ScW9AXP238hQ5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697736"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:27 -0700
X-CSE-ConnectionGUID: uOnSajq+SHqiweNaKJZfCQ==
X-CSE-MsgGUID: sOuJZ9vxSZe27Cn5lMcU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362321"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/9] wifi: iwlwifi: mvm: remove STARTING state
Date: Thu, 10 Oct 2024 14:05:02 +0300
Message-Id: <20241010140328.bb42b81b6c14.I622d5c1e88460e657958261d88cd18abb42cfb9c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

While removing the retry loops, I neglected to also remove the
bits of code that were added with the retry loops that prevented
firmware restart, now that the retry loops no longer exist they
need to also be removed so that restart/reprobe can happen. Fix
that by removing the STARTING state and associated code.

Fixes: dfdfe4be183b ("wifi: iwlwifi: remove retry loops in start")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 -------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  3 ---
 3 files changed, 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 62d55864b5df..819e1c0c46ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1295,20 +1295,7 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-
-	/* we are starting the mac not in error flow, and restart is enabled */
-	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
-	    iwlwifi_mod_params.fw_restart) {
-		/*
-		 * This will prevent mac80211 recovery flows to trigger during
-		 * init failures
-		 */
-		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
-	}
-
 	ret = __iwl_mvm_mac_start(mvm);
-	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
-
 	mutex_unlock(&mvm->mutex);
 
 	iwl_mvm_mei_set_sw_rfkill_state(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ef07cff203b0..ec201a738d82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1395,8 +1395,6 @@ DEFINE_GUARD(mvm, struct iwl_mvm *, mutex_lock(&_T->mutex), mutex_unlock(&_T->mu
  * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
  * @IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE: suppress one error log
  *	if this is set, when intentionally triggered
- * @IWL_MVM_STATUS_STARTING: starting mac,
- *	used to disable restart flow while in STARTING state
  */
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
@@ -1408,7 +1406,6 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_IN_D3,
 	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
-	IWL_MVM_STATUS_STARTING,
 };
 
 struct iwl_mvm_csme_conn_info {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 4dd4a9d5c71f..8254701f5eba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2040,9 +2040,6 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 */
 	if (!mvm->fw_restart && fw_error) {
 		iwl_fw_error_collect(&mvm->fwrt, false);
-	} else if (test_bit(IWL_MVM_STATUS_STARTING,
-			    &mvm->status)) {
-		IWL_ERR(mvm, "Starting mac, retry will be triggered anyway\n");
 	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
 
-- 
2.34.1


