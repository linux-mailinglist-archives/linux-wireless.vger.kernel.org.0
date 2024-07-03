Return-Path: <linux-wireless+bounces-9886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63B924FE9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76205B29F75
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8143138E;
	Wed,  3 Jul 2024 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUeOq6dd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350F1B95B
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978215; cv=none; b=bWJRJN8z4hdN9I6hvriApSk+O22wyLZfR2c2D/I3feFSZqlOZW0Y9qkHocb15leKNS+NJHjpoKUhUpoc5Wpt5ZBh0cARGa9LjaoMiNZISzfbXL2WWSed+2x8lhQWp5tbdiyJWROWy6yUHprQ+sGqRR0e3cGI+jETm7iP/23AuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978215; c=relaxed/simple;
	bh=J7QCqso5HMHxuzQThUG5ZutPMCGJ4SPmZFJlyzEmaJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQmT3XR0Ns77nndV0MCHXyQS9bCYcNbOJU0WQutvHikgZ61m9V/H6nCIjQNupNbMjS+Crk6D//jUubTzCWLNWo5NJVR6c/8rbGF3qFrZR6oMXe5XoxfQIWLxIBGiAGQ78B+0O3EgitSATrLIyjuKX5N9Nl9bkmttD64kPfskT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUeOq6dd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978214; x=1751514214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7QCqso5HMHxuzQThUG5ZutPMCGJ4SPmZFJlyzEmaJg=;
  b=YUeOq6ddk/q5EBrFMPI5ukk4tYpyyzR2+U2xkp04PrDZNksUSQgN6ciD
   KvntuzHjSQam0VDEIi6mcoBE8DV6FoJLaBHbey9CE+d2UrIASytM77c07
   etcTLUYkUn5Qo60nO4y/SPZJcZt3PicFLdrjdcXHoBp73oy7QpKtnY11B
   ixrYNqjl4E5bfSnDpHEA8Fs6c6rEWKTNnqeSpbqLAycZogRDIWzx/ugIo
   PxRpJOJ8nuOQ2fCa80sX5Phxc4LKj/Hg1Su9++0A0QJOOy7XKwpvh7QOu
   Hr16aFaysubVcKNN1zBNRmZ/4LwHoxDc6kcVUPzExvIs7A5z/+GWAaIyq
   g==;
X-CSE-ConnectionGUID: ayAA91cdRXCsjDIyT9uRRQ==
X-CSE-MsgGUID: qG02kSKqTqG0rV+nboHNcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304046"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304046"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:33 -0700
X-CSE-ConnectionGUID: TbasTAv4TO2XRAamLWiSvg==
X-CSE-MsgGUID: R4Bo8AnwQz2/3x6dfU2N1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291071"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] wifi: iwlwifi: mvm: don't wake up rx_sync_waitq upon RFKILL
Date: Wed,  3 Jul 2024 06:43:16 +0300
Message-Id: <20240703064027.be7a9dbeacde.I5586cb3ca8d6e44f79d819a48a0c22351ff720c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
References: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Since we now want to sync the queues even when we're in RFKILL, we
shouldn't wake up the wait queue since we still expect to get all the
notifications from the firmware.

Fixes: 4d08c0b3357c ("wifi: iwlwifi: mvm: handle BA session teardown in RF-kill")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 678744a6fc6e..dac6155ae1bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6412,11 +6412,9 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	if (sync) {
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
-					 READ_ONCE(mvm->queue_sync_state) == 0 ||
-					 iwl_mvm_is_radio_hw_killed(mvm),
+					 READ_ONCE(mvm->queue_sync_state) == 0,
 					 SYNC_RX_QUEUE_TIMEOUT);
-		WARN_ONCE(!ret && !iwl_mvm_is_radio_hw_killed(mvm),
-			  "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
+		WARN_ONCE(!ret, "queue sync: failed to sync, state is 0x%lx, cookie %d\n",
 			  mvm->queue_sync_state,
 			  mvm->queue_sync_cookie);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 48671540f37a..d343432474db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1912,12 +1912,10 @@ static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 	bool rfkill_safe_init_done = READ_ONCE(mvm->rfkill_safe_init_done);
 	bool unified = iwl_mvm_has_unified_ucode(mvm);
 
-	if (state) {
+	if (state)
 		set_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
-		wake_up(&mvm->rx_sync_waitq);
-	} else {
+	else
 		clear_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
-	}
 
 	iwl_mvm_set_rfkill_state(mvm);
 
-- 
2.34.1


