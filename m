Return-Path: <linux-wireless+bounces-3166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB884A6D4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3441C26792
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D35789B;
	Mon,  5 Feb 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtR4oCTF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D358129
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160905; cv=none; b=G7wBSxjhYr2UrwSwG/XlgIo72qKHWKg13fU3MEDt0gPyfIUDdKj7fy+2a2DOLzjmFdCLdrfVSb8GnxLACYwBMSbKGoAohHmpBd1nnBVPLErYukW8OBOc/VIVeB1zfCfI/W3qvjAwxntCkdjs7uB2qltQs/x0nTuw7Un3tziJSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160905; c=relaxed/simple;
	bh=3pu/vgmCOuWip43LQylmir5q7w2bn9cvbxOLSsyBQQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAvfo64V5f+vQwWnVOHP3FC7doxRg+28WMLk+m1+VJRfzLnfuBxbElEvwD/V1b8LJykzQXNP9V3F5LouqVn9IWGUr85yDNMoFirSSc4swAThMWlzvtk1z+80n24j7B2v/h7WwuETDGJVVg51YdIuow7clN8ZcGhUbpwmClHJLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtR4oCTF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160901; x=1738696901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pu/vgmCOuWip43LQylmir5q7w2bn9cvbxOLSsyBQQc=;
  b=jtR4oCTFZ20100qGqABG5flpzgjIYr0oPzq9GGy9CVHEg4cma9JZoo6z
   siFIIqQjNYY7qL0Me7Ax+vFJvx+qbqWPvQxkckHz8IeKTsvoSTT0dbKJE
   KiX69FBnaeLqY6JvH3sTdf0v6uCBV6Q6kSnSvxYoysgSLMc+DrdZOgYwm
   uZiCHOJuq8E5OnFY1IkEqyczgmiOSBI6NNTzSNu+RQ/yujRvJwqgzYN3Q
   wSrSBnl1k+ikZ2DGAQDVyKj0MP19peqRaDbVG4ZhAF/Vq5aZUyzgT0f69
   1CBcwFpljrHk+2hUkPub7iOq7FvkRysoPcSixI6WFj5dmHg/giMPK/bzW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381570"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403082"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: don't abort queue sync in CT-kill
Date: Mon,  5 Feb 2024 21:21:03 +0200
Message-Id: <20240205211151.4e0745e2cd97.I311dc623ce68de6a2da3c21c8d84a387844f714a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

CT kill should stop doing a lot of TX etc. to cool down the
NIC, but we don't stop all commands from going to the NIC,
and as such we shouldn't abort queue sync, since it can get
confused if we do, warning that we do it twice at the same
time etc. Only stop it when we'd also not send it in the
first place.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     | 16 +++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6477a39f643e..9c8eea883212 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6095,9 +6095,9 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
 					 READ_ONCE(mvm->queue_sync_state) == 0 ||
-					 iwl_mvm_is_radio_killed(mvm),
+					 iwl_mvm_is_radio_hw_killed(mvm),
 					 SYNC_RX_QUEUE_TIMEOUT);
-		WARN_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm),
+		WARN_ONCE(!ret && !iwl_mvm_is_radio_hw_killed(mvm),
 			  "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
 			  mvm->queue_sync_state,
 			  mvm->queue_sync_cookie);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 747fc91ef8d0..ac46be4d5971 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1828,12 +1828,8 @@ static void iwl_mvm_wake_sw_queue(struct iwl_op_mode *op_mode, int hw_queue)
 
 static void iwl_mvm_set_rfkill_state(struct iwl_mvm *mvm)
 {
-	bool state = iwl_mvm_is_radio_killed(mvm);
-
-	if (state)
-		wake_up(&mvm->rx_sync_waitq);
-
-	wiphy_rfkill_set_hw_state(mvm->hw->wiphy, state);
+	wiphy_rfkill_set_hw_state(mvm->hw->wiphy,
+				  iwl_mvm_is_radio_killed(mvm));
 }
 
 void iwl_mvm_set_hw_ctkill_state(struct iwl_mvm *mvm, bool state)
@@ -1858,10 +1854,12 @@ static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 	bool rfkill_safe_init_done = READ_ONCE(mvm->rfkill_safe_init_done);
 	bool unified = iwl_mvm_has_unified_ucode(mvm);
 
-	if (state)
+	if (state) {
 		set_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
-	else
+		wake_up(&mvm->rx_sync_waitq);
+	} else {
 		clear_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
+	}
 
 	iwl_mvm_set_rfkill_state(mvm);
 
-- 
2.34.1


