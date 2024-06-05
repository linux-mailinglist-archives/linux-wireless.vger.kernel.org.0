Return-Path: <linux-wireless+bounces-8539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D548FC9AC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1EA1C22004
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297C192B81;
	Wed,  5 Jun 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbJ4SOuH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2831146017
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585522; cv=none; b=bU810Of7rGwhc+WXFJ7TBBDRI1gUEKd+/p7pmua43SultRa8VwEBtQnpHB/hLORP0FQO7Tab9Hvw04udyhPf5eghV+w3IDh1PT8hfk9pG+PmWN5EOugwdgJKrFlzxxmUnpsiVpLGmicoccYRYHC+2p/dAS9u/LvPa1uHJrcUTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585522; c=relaxed/simple;
	bh=Vcr2EgBYhf9DK3AkDvPaEAU0S6EyS6XndQ5jVQ1Wsjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPdhiF2ILifEPLJ9FHa+WmpFp0h6+qlw1BFKsg7894CBg3234Eio1j6T9eerVaFjiOS/U/oRDo8qOOdXTIlMUOu0OvDYYGi84cAclqgVb1nrNSSL6D5wBahMAmhM11hpmwNz+eGyBm7HW/OFd7LWgqrFOHIJ4ncf0w2zsdEmhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbJ4SOuH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585521; x=1749121521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vcr2EgBYhf9DK3AkDvPaEAU0S6EyS6XndQ5jVQ1Wsjs=;
  b=bbJ4SOuHWi2iMGOag/x/KxBLYmxSL1KDI1pOOCk+/zdeeTiW3M8yekmA
   RWKg3qHra05eydXwL5z2UbVYAPbfPH6nKqSPozNdCH9bwV9tNc434/MaC
   JVAPrmyCW8j8ANCOMGzq1cLm6e5apb9YpP1IL3G3ii7BdeWHQKyS2a7tB
   xcolNtVQNGpuGpEmmtOj9u6K1ZlFW/kF3P2ISWqN4/Tm2fxvfULkT14BX
   RAxkb3XBNryFLSFJlzjhmsOlgy/1auRPp2miI9nWKHnvv0EeIZotaCtsR
   JtECfdYup54MocvzWFbKyHVXyv9ayC9CS34xVHI/gadX2M3xCGM71PbOA
   Q==;
X-CSE-ConnectionGUID: 4p9IXRzNQA+UQeVJLMBrsg==
X-CSE-MsgGUID: mMPTTv4cTd+7pBiGGUAvlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402181"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:20 -0700
X-CSE-ConnectionGUID: YVYmUr+ST6SLnP1PEl1xYA==
X-CSE-MsgGUID: +vDtNmPGTPuJTOCdH4Kqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997360"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: move TXQ bytecount limit to queue code
Date: Wed,  5 Jun 2024 14:05:00 +0300
Message-Id: <20240605140327.000a0a1e807d.Ib822590d5aca76ff3168418ae2c139b3d43d81ed@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This really isn't correct to be in the opmode, do the clamping
(and power-of-2 fixup that may be necessary due to this, or even
otherwise) in the queue code. Also move down the retrying of the
allocation, it should be after all the size fixups, but also it
just makes sense, and avoids retrying same-size allocations in
the case of the BZ-family A-step workaround.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 27 +++++--------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 22 +++++++++++++--
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 276bcccb7a38..bf3a1f132382 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -857,12 +857,6 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 		size = iwl_mvm_get_queue_size(sta);
 	}
 
-	/* take the min with bc tbl entries allowed */
-	size = min_t(u32, size, mvm->trans->txqs.bc_tbl_size / sizeof(u16));
-
-	/* size needs to be power of 2 values for calculating read/write pointers */
-	size = rounddown_pow_of_two(size);
-
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 		struct ieee80211_link_sta *link_sta;
@@ -887,22 +881,13 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	if (!sta_mask)
 		return -EINVAL;
 
-	do {
-		queue = iwl_trans_txq_alloc(mvm->trans, 0, sta_mask,
-					    tid, size, timeout);
-
-		if (queue < 0)
-			IWL_DEBUG_TX_QUEUES(mvm,
-					    "Failed allocating TXQ of size %d for sta mask %x tid %d, ret: %d\n",
-					    size, sta_mask, tid, queue);
-		size /= 2;
-	} while (queue < 0 && size >= 16);
-
-	if (queue < 0)
-		return queue;
+	queue = iwl_trans_txq_alloc(mvm->trans, 0, sta_mask,
+				    tid, size, timeout);
 
-	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
-			    queue, sta_mask, tid);
+	if (queue >= 0)
+		IWL_DEBUG_TX_QUEUES(mvm,
+				    "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
+				    queue, sta_mask, tid);
 
 	return queue;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 6229c785c845..726035dfa5cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1237,11 +1237,29 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 	};
 	int ret;
 
+	/* take the min with bytecount table entries allowed */
+	size = min_t(u32, size, trans->txqs.bc_tbl_size / sizeof(u16));
+	/* but must be power of 2 values for calculating read/write pointers */
+	size = rounddown_pow_of_two(size);
+
 	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    trans->hw_rev_step == SILICON_A_STEP)
+	    trans->hw_rev_step == SILICON_A_STEP) {
 		size = 4096;
+		txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
+	} else {
+		do {
+			txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
+			if (!IS_ERR(txq))
+				break;
+
+			IWL_DEBUG_TX_QUEUES(trans,
+					    "Failed allocating TXQ of size %d for sta mask %x tid %d, ret: %ld\n",
+					    size, sta_mask, tid,
+					    PTR_ERR(txq));
+			size /= 2;
+		} while (size >= 16);
+	}
 
-	txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
 	if (IS_ERR(txq))
 		return PTR_ERR(txq);
 
-- 
2.34.1


