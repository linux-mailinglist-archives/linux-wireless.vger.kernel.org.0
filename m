Return-Path: <linux-wireless+bounces-9902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8492578B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFEB1C2554E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08003142651;
	Wed,  3 Jul 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5JU7fxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD861422C3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000757; cv=none; b=r1C3dwN+s2vSHVaA8JMSIV4vj2/daFi8KdMUr/ZLKvr4tn0qVDC4dUx69ky4Z2DCGB4dl3JX/JUtfBsjXHlh/widd52dw+hEmvbcIt/AqcHDM3livxiCK5GiicJSp9uNtk+UgzJlvJfxYb68O4/3V8OZ0z+fEGwDxZiIVR0vFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000757; c=relaxed/simple;
	bh=lDg8lCBpdIxZIsFndn32/nBYa3d2IsrufFfVVr9S2ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bl9Iaj6rKi6fF7oUoTCul4o96Bh5ljdG8UrjmwruOeazuougRfJFE8Mx6G9DKQvEnfBI6ibYiWukQYwHMxyavAqdkYhlYf9Hl7EE4CZntZK7dvgME8XycQ8EVTJOr6fgS9nM5N8xODWI48OtRvhzA1na5d4tRlk3z0CwcMckJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5JU7fxm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000756; x=1751536756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDg8lCBpdIxZIsFndn32/nBYa3d2IsrufFfVVr9S2ZY=;
  b=R5JU7fxm4GDK2uL7PVaI8YWfIOIwUkemNJcytiZgfAvb0PsW3JVqQCgV
   pwUUtVRXeUcZ8BZ53ZbTV8r2kt4IRLx3MyVR4XFY1tNMbrrVDwr4vWnKt
   qj+lkIEMJcp1JHg/TIdc6uNMmHvOPrmKbp3/WH670SzC6qxRtBVFZLOd4
   VgfiY6N2NH/exVWct2eHhvHcDQm7cCV6ME6Rsi2+uCmrzuSknGaFOdL/o
   eD1pxwF0KCAmFD7v1725MjX+ZdR1NJYh4d7dzk5WrHMezSZ9nAWobyCi0
   2C5lENuzocNycZY5Ohqfuc2ZTCN4eeABwrzZsXwlbFaROvq7k313SK2XL
   w==;
X-CSE-ConnectionGUID: 0uqN8MVpRFCBDkIa2hClgw==
X-CSE-MsgGUID: uSSvrmM/RgSV1ct+Qz5DrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837504"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:15 -0700
X-CSE-ConnectionGUID: p0EwTY8nSbKwQ5w2KF7tCg==
X-CSE-MsgGUID: J9DY6g8ORMu58TRF9ZsFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987715"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/18] wifi: iwlwifi: mvm: clean up reorder buffer data
Date: Wed,  3 Jul 2024 12:58:49 +0300
Message-Id: <20240703125541.64ea1ba75379.I2a25af040061efaf82379e96a84a76c5fb65c677@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We really don't need to maintain the buffer size per
queue buffer, it's the same for the whole BA session.
Also, we no longer use the mvm pointer inside each
queue's data structure. Clean that up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 11 +++++------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 393ce424c196..227463522b7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -739,24 +739,20 @@ struct iwl_mvm_tcm {
  * struct iwl_mvm_reorder_buffer - per ra/tid/queue reorder buffer
  * @head_sn: reorder window head sn
  * @num_stored: number of mpdus stored in the buffer
- * @buf_size: the reorder buffer size as set by the last addba request
  * @queue: queue of this reorder buffer
  * @last_amsdu: track last ASMDU SN for duplication detection
  * @last_sub_index: track ASMDU sub frame index for duplication detection
  * @valid: reordering is valid for this queue
  * @lock: protect reorder buffer internal state
- * @mvm: mvm pointer, needed for frame timer context
  */
 struct iwl_mvm_reorder_buffer {
 	u16 head_sn;
 	u16 num_stored;
-	u16 buf_size;
 	int queue;
 	u16 last_amsdu;
 	u8 last_sub_index;
 	bool valid;
 	spinlock_t lock;
-	struct iwl_mvm *mvm;
 } ____cacheline_aligned_in_smp;
 
 /**
@@ -778,6 +774,7 @@ __aligned(roundup_pow_of_two(sizeof(struct sk_buff_head)))
  * @tid: tid of the session
  * @baid: baid of the session
  * @timeout: the timeout set in the addba request
+ * @buf_size: the reorder buffer size as set by the last addba request
  * @entries_per_queue: # of buffers per queue, this actually gets
  *	aligned up to avoid cache line sharing between queues
  * @last_rx: last rx jiffies, updated only if timeout passed from last update
@@ -794,6 +791,7 @@ struct iwl_mvm_baid_data {
 	u8 tid;
 	u8 baid;
 	u16 timeout;
+	u16 buf_size;
 	u16 entries_per_queue;
 	unsigned long last_rx;
 	struct timer_list session_timer;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5370580f6210..1a210d0c22b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -566,7 +566,7 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 	lockdep_assert_held(&reorder_buf->lock);
 
 	while (ieee80211_sn_less(ssn, nssn)) {
-		int index = ssn % reorder_buf->buf_size;
+		int index = ssn % baid_data->buf_size;
 		struct sk_buff_head *skb_list = &entries[index].frames;
 		struct sk_buff *skb;
 
@@ -617,7 +617,7 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	spin_lock_bh(&reorder_buf->lock);
 	iwl_mvm_release_frames(mvm, sta, NULL, ba_data, reorder_buf,
 			       ieee80211_sn_add(reorder_buf->head_sn,
-						reorder_buf->buf_size));
+						ba_data->buf_size));
 	spin_unlock_bh(&reorder_buf->lock);
 
 out:
@@ -839,7 +839,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	}
 
 	/* put in reorder buffer */
-	index = sn % buffer->buf_size;
+	index = sn % baid_data->buf_size;
 	__skb_queue_tail(&entries[index].frames, skb);
 	buffer->num_stored++;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c57755e5ff5e..15e64d94d6ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2743,7 +2743,7 @@ static void iwl_mvm_free_reorder(struct iwl_mvm *mvm,
 		 */
 		WARN_ON(1);
 
-		for (j = 0; j < reorder_buf->buf_size; j++)
+		for (j = 0; j < data->buf_size; j++)
 			__skb_queue_purge(&entries[j].frames);
 
 		spin_unlock_bh(&reorder_buf->lock);
@@ -2752,7 +2752,7 @@ static void iwl_mvm_free_reorder(struct iwl_mvm *mvm,
 
 static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 					struct iwl_mvm_baid_data *data,
-					u16 ssn, u16 buf_size)
+					u16 ssn)
 {
 	int i;
 
@@ -2765,12 +2765,10 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 
 		reorder_buf->num_stored = 0;
 		reorder_buf->head_sn = ssn;
-		reorder_buf->buf_size = buf_size;
 		spin_lock_init(&reorder_buf->lock);
-		reorder_buf->mvm = mvm;
 		reorder_buf->queue = i;
 		reorder_buf->valid = false;
-		for (j = 0; j < reorder_buf->buf_size; j++)
+		for (j = 0; j < data->buf_size; j++)
 			__skb_queue_head_init(&entries[j].frames);
 	}
 }
@@ -2979,13 +2977,14 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		baid_data->mvm = mvm;
 		baid_data->tid = tid;
 		baid_data->sta_mask = iwl_mvm_sta_fw_id_mask(mvm, sta, -1);
+		baid_data->buf_size = buf_size;
 
 		mvm_sta->tid_to_baid[tid] = baid;
 		if (timeout)
 			mod_timer(&baid_data->session_timer,
 				  TU_TO_EXP_TIME(timeout * 2));
 
-		iwl_mvm_init_reorder_buffer(mvm, baid_data, ssn, buf_size);
+		iwl_mvm_init_reorder_buffer(mvm, baid_data, ssn);
 		/*
 		 * protect the BA data with RCU to cover a case where our
 		 * internal RX sync mechanism will timeout (not that it's
-- 
2.34.1


