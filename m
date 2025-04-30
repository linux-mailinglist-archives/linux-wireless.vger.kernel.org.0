Return-Path: <linux-wireless+bounces-22249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D07AA4B07
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5021BC318A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942D22173C;
	Wed, 30 Apr 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn2uFZc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40725A623
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015893; cv=none; b=bvZoyK4ilMbTauQOC6l/xdN+xHjGgmXaBR9cj8Zw7SfbWtspALoyO9JMXGVj6tJBLWG0rdGmSXLUYXEHwTloDahlNKYUpJjgPpyFhlsYkLUcrC+2wMkFn/g7acRtRIryQFaK8KLs/dSebyxWIiscENTr3HOCAcupXAfcJQ5ax68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015893; c=relaxed/simple;
	bh=HKj0HCREN75CyPQTvfXMeoXJ4GoZOKCCHpvzkU0CmOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCIMMBG7NtZmhKHW+jEreLU8kyVclOMgvjSek5xoA/D/m7M0Z8NTTy8ktzoZBD7RDa0YmytF8qy9QvqdljcT3gYxf0FFsulBC07u0svG42KYxhhvu1kwROnclFL+G+jsvaLFOWbE4nqymrDxHwayVmnx3Zu+QE/z3URe/0uRW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn2uFZc1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015892; x=1777551892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKj0HCREN75CyPQTvfXMeoXJ4GoZOKCCHpvzkU0CmOs=;
  b=hn2uFZc11H9dxs3viFLwvRr1S/3du3PBoOjk5yg6UOiX1HXyMIycsClh
   NJNTI8LoLUza+yk3qQatuQeG81vQsHUwTE6XE7LYJ7yyLNPxcBCQZyTgq
   zAajcExxJRmBw5y3HpTYHSrOKO057W+ggs3pUwvnf8aYCC6HO73TkM5Dz
   xGghh/rtr8mTdb9cTLswG/TTYM9QgdPX/FfLf8GQOEINg2B/DYslUd2w1
   llNCGxSiEQPr2gkvZAu0d23cCGgajxdO0kdyjZX98iVFfFSi0imxKbMlh
   k9tcTAefm5r//d/zotKr2xrCB/9MxYNMCuGzMezZHigcEer2KQB+8xv1J
   A==;
X-CSE-ConnectionGUID: gQVAKx0bSZiHlaOoa6+H6w==
X-CSE-MsgGUID: L1VC53kDTamCBJes6/oqYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578269"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578269"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:52 -0700
X-CSE-ConnectionGUID: C24vK8KEQ1mqdbDPGsKxBA==
X-CSE-MsgGUID: CmFoQqcJQp+X2FJ/Sc0Mkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087863"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/14] wifi: iwlwifi: avoid scheduling restart during restart
Date: Wed, 30 Apr 2025 15:23:12 +0300
Message-Id: <20250430151952.db428503ec3c.I3f2be3d72a9d40cfb4e697cdab1cd2866a9262bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a restart is in progress, it can be async due to the next
worker being scheduled in mac80211 (restart work) or the driver
itself (reprobe). Avoid scheduling another restart during this
period.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index c1607b6d0759..75d70021ee03 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -393,6 +393,8 @@ int iwl_trans_start_hw(struct iwl_trans *trans)
 {
 	might_sleep();
 
+	clear_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status);
+
 	return iwl_trans_pcie_start_hw(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_start_hw);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b9dc1b8794ce..8fae7f59a73e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -304,6 +304,8 @@ enum iwl_d3_status {
  *	via iwl_trans_finish_sw_reset()
  * @STATUS_RESET_PENDING: reset worker was scheduled, but didn't dump
  *	the firmware state yet
+ * @STATUS_TRANS_RESET_IN_PROGRESS: reset is still in progress, don't
+ *	attempt another reset yet
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -317,6 +319,7 @@ enum iwl_trans_status {
 	STATUS_SUPPRESS_CMD_ERROR_ONCE,
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
+	STATUS_TRANS_RESET_IN_PROGRESS,
 };
 
 static inline int
@@ -1152,6 +1155,9 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 {
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return;
+	/* clear this on device init, not cleared on any unbind/reprobe */
+	if (test_and_set_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status))
+		return;
 
 	trans->restart.mode.type = type;
 	trans->restart.mode.context = IWL_ERR_CONTEXT_WORKER;
-- 
2.34.1


