Return-Path: <linux-wireless+bounces-6392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9C8A692D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BCA1F21F68
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256EA1292FC;
	Tue, 16 Apr 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCbw/QRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BC12A17E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264891; cv=none; b=GYEbWPBpCDa8yey0OYbzea+3+zTNN6HFq3Qt2RVlucUjbe6omyH8pblB0Ixl82Xn7oov25kcJ0bFtYbRP/cVtQPefUNOpZ637fVzISdijIrRbQau1uBggGo8tAgWpnQjqi55Rr4nGhq8m55TuHBqM/hfKTP34WWSoliop0/BTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264891; c=relaxed/simple;
	bh=oKpfgOhqoc/XEfQs7e1rxDPU63hb8BypJUHwaryM1U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVpJMNI6rFP9+0tTU6EJ3nAuWvqDXMZiyKZB8K8pV32YP+Z+AE4tWEAP3VmWkiRFm1LPMKzfhZCPGyjZyNG93v73SB8kz9Pu2gRW0xf6TfIzuBKTyeRc6eb5HMUDJtpL3+OPH4/du7rYg5ht2S6eTsga9wO83Fn9qC96wdWn134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCbw/QRk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264890; x=1744800890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKpfgOhqoc/XEfQs7e1rxDPU63hb8BypJUHwaryM1U0=;
  b=jCbw/QRkpKmU9h7gkN9HbiH3viZ9RNkS9cc4NVBtCLNXSnZC+GqZtW4p
   fCQdLqS1/3jAfh5IhChnv0ZG0GS8JVsoUogDOIQU9yTyOfBym/nBsn4+9
   yx28+q/PUctfCFlqIiH/llQg2cwfKOtn/tkl4wfS4P4RC6DPA4GaGyuTD
   wdv/0JkYHWJUEFtQ3XnMfiwhCr+u8npz3T9ixkGt5+stm9qzt9h6xQU+x
   F2rH7t0S56gLPudoFr/abtqN61GhXi4yZqDpzlenP4SLqZL1hasak5w9n
   5/1OLBZQ0zjACMFGaWdh5Gn8FqE3pYWPLSRArcuemfT6VoT0dLyLhvTJr
   w==;
X-CSE-ConnectionGUID: OAjf7EMgSma4Z8x41fd8RA==
X-CSE-MsgGUID: hBsYAvfkRwi4TBrq9vwZCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556077"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556077"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:49 -0700
X-CSE-ConnectionGUID: TQ2oosTcTQOJODoDslrAWw==
X-CSE-MsgGUID: IcN/8iqwTmqFQIl2lrlnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872595"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 15/16] wifi: iwlwifi: mvm: disable EMLSR when we suspend with wowlan
Date: Tue, 16 Apr 2024 13:54:10 +0300
Message-Id: <20240416134215.6ea884b3f095.I84233cb1c79ba538defafb8ddb983c47f04a400a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

We can't be an EMLSR while suspended with wowlan. De-activate the
secondary link upon wowlan entring.

Set the blocking reason upon suspension and clear it upon resume.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 19 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6763863f4354..778ea64f3f28 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1261,22 +1261,19 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (IS_ERR_OR_NULL(vif))
 		return 1;
 
-	mutex_lock(&mvm->mutex);
-
 	primary_link = iwl_mvm_get_primary_link(vif);
-	if (ieee80211_vif_is_mld(vif) && vif->cfg.assoc &&
-	    mvmvif->esr_active) {
-		/*
-		 * Select the 'best' link. May need to revisit, it seems
-		 * better to not optimize for throughput but rather
-		 * range, reliability and power here - and select
-		 * 2.4 GHz ...
-		 */
+
+	/* leave ESR immediately, not only async with iwl_mvm_block_esr() */
+	if (ieee80211_vif_is_mld(vif)) {
 		ret = ieee80211_set_active_links(vif, BIT(primary_link));
 		if (ret)
 			return ret;
 	}
 
+	mutex_lock(&mvm->mutex);
+	/* only additionally block for consistency and to avoid concurrency */
+	iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN, primary_link);
+
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	synchronize_net();
@@ -3463,6 +3460,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			goto err;
 	}
 
+	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN);
+
 	/* after the successful handshake, we're out of D3 */
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 9f343d015d81..1171fc831ca8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -678,7 +678,9 @@ u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	lockdep_assert_held(&mvmvif->mvm->mutex);
+	/* relevant data is written with both locks held, so read with either */
+	lockdep_assert(lockdep_is_held(&mvmvif->mvm->mutex) ||
+		       lockdep_is_held(&mvmvif->mvm->hw->wiphy->mtx));
 
 	if (!ieee80211_vif_is_mld(vif))
 		return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 050a04c185e5..2ef346c54d24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -356,11 +356,13 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_BLOCKED_COEX: COEX is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
  *	in a loop.
+ * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x2,
+	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x4,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 };
 
-- 
2.34.1


