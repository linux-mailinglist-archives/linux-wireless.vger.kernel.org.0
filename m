Return-Path: <linux-wireless+bounces-12297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FD9674F4
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05997B21D6F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E340BE3;
	Sun,  1 Sep 2024 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBcZItuo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3445013
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164299; cv=none; b=G7ViDChFShZm847k2htntgx7nC2zetTnKfyy+FPzN0rpCKaMFcww/B45pltAepkOJH+KmgBliMl5cZxektsdxHwYqA8oE3IrzfMdvd5USSsFvQOdVg/rWTHiS86nGf3/FlBP3aSA5V/y1rthh0S6SdaT/p9IJoP2X7HcKPb9SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164299; c=relaxed/simple;
	bh=O3o7yupxRLlzby0jxY1Unu+f2ZUm1quBTSyKNf1Uu+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJ5W06BjShdJL4l7xUQXDFGZKWIA6+Umad1Z6ONmtogxnm1O4RKTzPvmMT1EGFRHJsNwuF/PniGRTKBe79afCXKR0unkY9xjSP7pQrlkmHAh/HLeZN5E+aRFd52w0sEuYnGUJ/Ma261jcnbWZnEQxSc85voTpeN4NDkgNPpTBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBcZItuo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164297; x=1756700297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3o7yupxRLlzby0jxY1Unu+f2ZUm1quBTSyKNf1Uu+4=;
  b=fBcZItuokCoR5hPljMS3ZqfOQLW0+5M5fVlKEAk+pA6XDm4+wSPMCtP3
   Ilg/oSI2NQoV7KIKBzNFgvXYX3evK42RiX9USoaBxKQgzvRiKkhdnQalZ
   86ClK4z9EGYAkmeKsnSXM9nWHr1wwnjmENH4AudRIyuLNldmcUpKJbs6e
   iBjtW3wc64PIWy3HCjFdANBDGW+pX5iLwH3liJ9MeQLPMKOcyVug42Z6m
   5TjQFjbLTE5UrW0iLxJ4SllNBGa/NO58cTla0RAF56moQ4lW35KH4HguF
   exzodXTQ4ekleHkOtYngZtZm2itMNGse6sM5wALJGUHuT8OijT7T8Hqi0
   A==;
X-CSE-ConnectionGUID: eK77lKMOSsCrv2Cw2trX1Q==
X-CSE-MsgGUID: v8x2cfNRTeGWYaM+v4Cw0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559528"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559528"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:17 -0700
X-CSE-ConnectionGUID: jEvD8mAfQ5iAn7oTSlKvTQ==
X-CSE-MsgGUID: WJ3dSjHsRAmb9damMt0aBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276324"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 7/8] wifi: iwlwifi: mvm: Remove unused last_sub_index from reorder buffer
Date: Sun,  1 Sep 2024 07:17:56 +0300
Message-Id: <20240901071542.da75cfef9144.I6e1fb635b2893618e6bd28501fb858042d8aa44e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

The last_sub_index field is not used and appears to be a leftover
from a previous implementation, remove it.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index be637f6e4074..650b562a22cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -774,7 +774,6 @@ struct iwl_mvm_tcm {
  * @num_stored: number of mpdus stored in the buffer
  * @queue: queue of this reorder buffer
  * @last_amsdu: track last ASMDU SN for duplication detection
- * @last_sub_index: track ASMDU sub frame index for duplication detection
  * @valid: reordering is valid for this queue
  * @lock: protect reorder buffer internal state
  */
@@ -783,7 +782,6 @@ struct iwl_mvm_reorder_buffer {
 	u16 num_stored;
 	int queue;
 	u16 last_amsdu;
-	u8 last_sub_index;
 	bool valid;
 	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ae0f2aabddc3..65f8933c34b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -729,8 +729,6 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	bool last_subframe =
 		desc->amsdu_info & IWL_RX_MPDU_AMSDU_LAST_SUBFRAME;
 	u8 tid = ieee80211_get_tid(hdr);
-	u8 sub_frame_idx = desc->amsdu_info &
-			   IWL_RX_MPDU_AMSDU_SUBFRAME_IDX_MASK;
 	struct iwl_mvm_reorder_buf_entry *entries;
 	u32 sta_mask;
 	int index;
@@ -843,10 +841,8 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	__skb_queue_tail(&entries[index].frames, skb);
 	buffer->num_stored++;
 
-	if (amsdu) {
+	if (amsdu)
 		buffer->last_amsdu = sn;
-		buffer->last_sub_index = sub_frame_idx;
-	}
 
 	/*
 	 * We cannot trust NSSN for AMSDU sub-frames that are not the last.
-- 
2.34.1


