Return-Path: <linux-wireless+bounces-16891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66549FE281
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D671881C1E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5718991E;
	Mon, 30 Dec 2024 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAQohCOD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99B187870
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534582; cv=none; b=QJgDVY3j8DoKiHIehJVKOI0OHkRQP/D9oXaS3FkGIK90548vbHCr//Msa45+0hRqtRNTT8x9ygjUsufArbsGLo8M7guodLC3yqNBtVWeKxzmO0f5RnNWKATc5lh2U8xL4q1vQ6sN3DUFrP6fp1DeaTANj14H4jaZoaQSNlIEAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534582; c=relaxed/simple;
	bh=+TPfv/dRw5N4mst50b2R6H/eOI+0gvERGAZMjhaS3Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmGXxyRG7/mY18ErqJftatKZ/caSiFDnznc1jA9B7zNyZpjL8rGgrvPkcl+sKsRc9uVZx5taEbWALs78aP5lnOup4sGN6u19CkzBtgeRlHTBM2TBHJbl07CmjCn07p8RJs+r/7aBgDH1YNbGKSoFaRC42NQUard9iOwJxmNzKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAQohCOD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534581; x=1767070581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TPfv/dRw5N4mst50b2R6H/eOI+0gvERGAZMjhaS3Zw=;
  b=UAQohCOD/360ASJJtr6PHyYz0CqZwqDBrGv0YzCSJIDzEHQ0gDb6S6gs
   4LdhLT2Z5vzJuA3QYc7XwGvR+Tn00iXg2CdqHpRdB8Fz66wkkP2hjk/y0
   eEZNsbDy48b7oYq7aSduUtLu5Ja47aT0cqjqrZpmahxpxxbdm/CPKYygt
   fBwPIKdgUEgiV03CJADsO6avoLj5XZIbmT10uRepUdqtf3G3aEjmmA+k3
   45+L1YVGjD+m0ZRlQafmV6j037Fm2AWRsd/0ybxx0HCHnOOndjGiGD5zQ
   8OLoW/JOOcQozjPxdhRjX+0uzkG0cM4VV7G6/McL/Su0qdaKgQhdZWswh
   Q==;
X-CSE-ConnectionGUID: FKWF2DWhTBqD67VdQFYbcw==
X-CSE-MsgGUID: Q566DdN3RN2pFBNBSWFOmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405021"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405021"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:20 -0800
X-CSE-ConnectionGUID: wiYcsdVBQr+UAKoEJTxDaQ==
X-CSE-MsgGUID: QQECTPoeT2+TG9pSywHfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758904"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: mac80211: improve stop/wake queue tracing
Date: Mon, 30 Dec 2024 06:55:47 +0200
Message-Id: <20241230065327.bd320c6e6702.I6ae0f19d922aea1f28236d72bf260acac428fc02@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add the refcount. This can be useful when we want to understand why a
queue stays stopped after it is woken.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/trace.h | 22 ++++++++++++++--------
 net/mac80211/util.c  | 10 ++++++----
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index fe26fb46758d..72fad8ea8bb9 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3159,49 +3159,55 @@ TRACE_EVENT(api_finalize_rx_omi_bw,
 
 TRACE_EVENT(wake_queue,
 	TP_PROTO(struct ieee80211_local *local, u16 queue,
-		 enum queue_stop_reason reason),
+		 enum queue_stop_reason reason, int refcount),
 
-	TP_ARGS(local, queue, reason),
+	TP_ARGS(local, queue, reason, refcount),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		__field(u16, queue)
 		__field(u32, reason)
+		__field(int, refcount)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		__entry->queue = queue;
 		__entry->reason = reason;
+		__entry->refcount = refcount;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT " queue:%d, reason:%d",
-		LOCAL_PR_ARG, __entry->queue, __entry->reason
+		LOCAL_PR_FMT " queue:%d, reason:%d, refcount: %d",
+		LOCAL_PR_ARG, __entry->queue, __entry->reason,
+		__entry->refcount
 	)
 );
 
 TRACE_EVENT(stop_queue,
 	TP_PROTO(struct ieee80211_local *local, u16 queue,
-		 enum queue_stop_reason reason),
+		 enum queue_stop_reason reason, int refcount),
 
-	TP_ARGS(local, queue, reason),
+	TP_ARGS(local, queue, reason, refcount),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		__field(u16, queue)
 		__field(u32, reason)
+		__field(int, refcount)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		__entry->queue = queue;
 		__entry->reason = reason;
+		__entry->refcount = refcount;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT " queue:%d, reason:%d",
-		LOCAL_PR_ARG, __entry->queue, __entry->reason
+		LOCAL_PR_FMT " queue:%d, reason:%d, refcount: %d",
+		LOCAL_PR_ARG, __entry->queue, __entry->reason,
+		__entry->refcount
 	)
 );
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7b656326e68a..94cf19cf4e28 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -437,8 +437,6 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
-	trace_wake_queue(local, queue, reason);
-
 	if (WARN_ON(queue >= hw->queues))
 		return;
 
@@ -456,6 +454,9 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 	if (local->q_stop_reasons[queue][reason] == 0)
 		__clear_bit(reason, &local->queue_stop_reasons[queue]);
 
+	trace_wake_queue(local, queue, reason,
+			 local->q_stop_reasons[queue][reason]);
+
 	if (local->queue_stop_reasons[queue] != 0)
 		/* someone still has this queue stopped */
 		return;
@@ -502,8 +503,6 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
-	trace_stop_queue(local, queue, reason);
-
 	if (WARN_ON(queue >= hw->queues))
 		return;
 
@@ -512,6 +511,9 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
 	else
 		local->q_stop_reasons[queue][reason]++;
 
+	trace_stop_queue(local, queue, reason,
+			 local->q_stop_reasons[queue][reason]);
+
 	set_bit(reason, &local->queue_stop_reasons[queue]);
 }
 
-- 
2.34.1


