Return-Path: <linux-wireless+bounces-3164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501584A6D1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8081F292DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9458123;
	Mon,  5 Feb 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOQEr+pZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C05788F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160896; cv=none; b=FlcT1Tg5gHevMLzE9Ag8BVvU8z+l0rukafhzPO6Lbx54jBcwjRYn5SBBBo6/JPBJT4VKcdQK4CgEpW2rPM+RhuhaISee7heKsuHJjEFjMQSU4Jw32ptDJg5BeDXtoIgEBHvQNbE9RLX9ap35thNgKdz8PLZYnc/5C0D49q8Qc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160896; c=relaxed/simple;
	bh=lLGQzoasiIZGJzdx6yhvjqJyiL9NSMssUYEh3X6lXgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuyWc9PC5zz54RcZbkHTrl78b65x6bmkQA+z7JhIQNLGkCZYR7/xzBPNSRUn6Yfd5QtUqLUCg8Cm2t0t/tdDYP19P+syNWFzr/ncQuxtuwA1713W6qHR2tm/GT8jYoHDG+Cg9J3OZO8yHy4+NELq9hRNkEtP654QnY0nE/uxb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOQEr+pZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160894; x=1738696894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lLGQzoasiIZGJzdx6yhvjqJyiL9NSMssUYEh3X6lXgA=;
  b=EOQEr+pZRQTbE7opQGWmHKE16CtwTJS4p51fZCX4n+jUIbI/8wLOQbQo
   56n7gLtBFDS3c4b/vaNX5GUIsI/VJNPRHALYSoIynodpDtNnruLRtvJE4
   5Zh6cz4otiXK5QlAHjnktqkwO1C6vbLOatmJhOjzahwLUQcpANvQVAHLa
   tIEcO3aEvAIKd+WlIYCMl5mb5B0xiMAiKZfGnQOzG1m9PuP9yGQA8sKo5
   0n/Hf5LJrGXycaWW4RqBLPEJLOaE9KXeQ8IClFpiVCGtxZAYdJAWq4fA+
   CGWcEEz/KS4IK3b+2yDMPOmWTb3YcS7MfeFbRdXmCfVl0LQJdCXFd6tOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381551"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381551"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403067"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mvm: expand queue sync warning messages
Date: Mon,  5 Feb 2024 21:21:01 +0200
Message-Id: <20240205211151.1df82a509636.I2f71811569a5c48eb166c4caa779af2d6160ad33@changeid>
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

It's a bit tricky to understand what's going on here, add
more data to the warning messages to make that clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4188957afdf4..a4ae3c09b543 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -6097,8 +6097,9 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 					 iwl_mvm_is_radio_killed(mvm),
 					 HZ);
 		WARN_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm),
-			  "queue sync: failed to sync, state is 0x%lx\n",
-			  mvm->queue_sync_state);
+			  "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
+			  mvm->queue_sync_state,
+			  mvm->queue_sync_cookie);
 	}
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 67062fe40152..7979b7952a79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -688,11 +688,11 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 		return;
 	len -= sizeof(*notif) + sizeof(*internal_notif);
 
-	if (internal_notif->sync &&
-	    mvm->queue_sync_cookie != internal_notif->cookie) {
-		WARN_ONCE(1, "Received expired RX queue sync message\n");
+	if (WARN_ONCE(internal_notif->sync &&
+		      mvm->queue_sync_cookie != internal_notif->cookie,
+		      "Received expired RX queue sync message (cookie %d but wanted %d, queue %d)\n",
+		      internal_notif->cookie, mvm->queue_sync_cookie, queue))
 		return;
-	}
 
 	switch (internal_notif->type) {
 	case IWL_MVM_RXQ_EMPTY:
-- 
2.34.1


