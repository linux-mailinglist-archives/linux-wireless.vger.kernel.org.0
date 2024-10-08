Return-Path: <linux-wireless+bounces-13670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C01993DF6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664BB1C24661
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930C135A69;
	Tue,  8 Oct 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drhZdNO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8E12C484
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361553; cv=none; b=tdvpQ9Ahlq1eZlid8rfUBOMCJ7t6VSWLsc09MDkmrs6vW9c5DlKKOCZ2dodxAivm2N619VqU/jTnkcD8ebR+lVAvYvK+fMVXF6mBuNIRuti1Ssujabo6uXtBpgFixOgMVpnPqwEyCsoN5Dmrm00bxlWrqschPajJm4sHgw7Y3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361553; c=relaxed/simple;
	bh=GQI78rGAQr07e0zchy2qc/JkbRJB6sk3lh5diHAmBz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jq/ZYxmlMJyeHG++85I2wqe49A/VfdVDy1cqDdfF/ul/BrB7mwfsBHCjucmrVE1ve3otSqlR4PzVfFs3/nPOpraC7hBKfiCvFs7+Azqs2blFt/aVe6Ew9tQ1A/I4Z0jz+bTtPrRbGYldDKTwMC9bAC8hJEXV8IsZaWIYpreSj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drhZdNO4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361552; x=1759897552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQI78rGAQr07e0zchy2qc/JkbRJB6sk3lh5diHAmBz4=;
  b=drhZdNO4rFmejchjEAjy2D+NXUFWKrwz6ZrddBL/GMFho13/mRWSc0cA
   Bp5XU8Y76jHEr/kJrPxrCVZfIl6T7tXB3SiTd09+jMfwE4U4/sIg27lxS
   xYaL7oRRVz5uNjMrf+U3/BTz2DZjxQLZg7B7VB2gwrEKRoAuUKS52sWzR
   v2hvdxWlSrjAL1CsD7mmHR6nA4DbD/eRA3rB5yazwHKiVk51KSCiwWwUH
   VAbNoDq2AGq2zvkswSaUpcThiiPqBiyVOOz5ve7TrPtG2RbBWzA/Gad/B
   Zrdj3UgD6haRVp3aJquNiMrwE3OGpID06xInyR3iL8kI8woA5SY3KU1nH
   g==;
X-CSE-ConnectionGUID: 1VyyKcwxR+mIUfxlJOi01g==
X-CSE-MsgGUID: rcs3WfGZSdWuFVdm373Hng==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024282"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024282"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:51 -0700
X-CSE-ConnectionGUID: pzo2ez7RRReaCJev20vF0g==
X-CSE-MsgGUID: AP0ZRCdqThiNoS2XNWtTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486349"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: mvm: Remove unused last_amsdu from reorder buffer
Date: Tue,  8 Oct 2024 07:25:21 +0300
Message-Id: <20241008072037.13ba0eeae0fd.I94985512596e5996f5ab199451ce851c59a5a72a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

The last_amsdu field is not used and appears to be a leftover
from a previous implementation, remove it.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ff5d720b7314..475e781e166a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -780,7 +780,6 @@ struct iwl_mvm_tcm {
  * @head_sn: reorder window head sn
  * @num_stored: number of mpdus stored in the buffer
  * @queue: queue of this reorder buffer
- * @last_amsdu: track last ASMDU SN for duplication detection
  * @valid: reordering is valid for this queue
  * @lock: protect reorder buffer internal state
  */
@@ -788,7 +787,6 @@ struct iwl_mvm_reorder_buffer {
 	u16 head_sn;
 	u16 num_stored;
 	int queue;
-	u16 last_amsdu;
 	bool valid;
 	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 65f8933c34b4..fdbd63ff91ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -814,7 +814,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	if (!buffer->num_stored && ieee80211_sn_less(sn, nssn)) {
 		if (!amsdu || last_subframe)
 			buffer->head_sn = nssn;
-		/* No need to update AMSDU last SN - we are moving the head */
+
 		spin_unlock_bh(&buffer->lock);
 		return false;
 	}
@@ -831,7 +831,6 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		if (!amsdu || last_subframe)
 			buffer->head_sn = ieee80211_sn_inc(buffer->head_sn);
 
-		/* No need to update AMSDU last SN - we are moving the head */
 		spin_unlock_bh(&buffer->lock);
 		return false;
 	}
@@ -841,9 +840,6 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	__skb_queue_tail(&entries[index].frames, skb);
 	buffer->num_stored++;
 
-	if (amsdu)
-		buffer->last_amsdu = sn;
-
 	/*
 	 * We cannot trust NSSN for AMSDU sub-frames that are not the last.
 	 * The reason is that NSSN advances on the first sub-frame, and may
-- 
2.34.1


