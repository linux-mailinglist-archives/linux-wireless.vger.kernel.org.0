Return-Path: <linux-wireless+bounces-16958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04E9FF2D9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DAE3A2BCB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527C15E90;
	Wed,  1 Jan 2025 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7xFympC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F34F9F8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707966; cv=none; b=PNinqQNcyIflUkCM3kAy/CWTE+wSK56oxse0vl5Cd7RpItW2NvCuM00wUA8gDtotk0TtY0sciFjMZ/N5570WmFGSjq2zRb5lU7KrugAzMicGVHCR8/NdkBIZd7UNY2zk8DQ1sfK7n/wLITD5oka916qwgR1AXlsEQV/kC59QhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707966; c=relaxed/simple;
	bh=+TPfv/dRw5N4mst50b2R6H/eOI+0gvERGAZMjhaS3Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCxAEF5xhhi6BXFpd1g+slsUJmsMvq16bDc6QIUHZgoWw8n+w/Zc7gS1Nrs4tEUrQijYKQ4428ZZE9DcKUHUS9Ywl03aMTBlWDOJECzVJREE+ipmDgqZVzE91ZSs56xugK0kavEecAdL3N4C0tJJWKnNN6Lgymd34Hb+Y9oH6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7xFympC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707965; x=1767243965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TPfv/dRw5N4mst50b2R6H/eOI+0gvERGAZMjhaS3Zw=;
  b=j7xFympCsTc36T3K7tx1rSrO4caoyhnVr9IELg/Xbce4ICxTd6tqlFiF
   3WbBG0+3fhAXTNe7ix2WFrbHUAAAd+4eW9sr88u7Bay9wUnuWkqA1IKWR
   gyDca+xNEEf6jzbIQOMTbCJUugXHlJTMJAdy9/npOneSHTdtUl9OfHcpH
   kDMkIJa09j2dCSqmD7QiSl2/597aVouT1DpIUEUUl4rZKmmXrM77Ual65
   6L6iJol/T30oII8RkNdSjoQrlMUO7Y4pmS85zxvlPsVofL9lKEtzLkF2h
   zSxxNu479SLTiT72BI5ixzvz4ZGOlCrIkzO8+UXzFPi2SL7+IkIApUd6z
   A==;
X-CSE-ConnectionGUID: Nlcg+4iGQB25uzPs8YdbmQ==
X-CSE-MsgGUID: AMvNr0l/QOSIWhVpwzvUvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194418"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194418"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:05 -0800
X-CSE-ConnectionGUID: Bm4woULbQrS9Nx5LdaKcOg==
X-CSE-MsgGUID: mhQXvyGBQAKhMGe4udttmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618903"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/19] wifi: mac80211: improve stop/wake queue tracing
Date: Wed,  1 Jan 2025 07:05:28 +0200
Message-Id: <20250101070249.bd320c6e6702.I6ae0f19d922aea1f28236d72bf260acac428fc02@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


