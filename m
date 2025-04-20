Return-Path: <linux-wireless+bounces-21755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13423A946DC
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AF7189708E
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0711C6FF9;
	Sun, 20 Apr 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlNhTCNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70E1C5F1B
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132422; cv=none; b=Q4YGbkBxu9y45bwgQBzuOgoaGcK9XSBgFm3PaECeZtKs93naiRq1kAe2J56bWfAXiu36h5BwOkHd8vkC2YjVe95EELPL2jYkbA9PnBJBpMGcd0qHD+2yYpyWiga5yN5E02h2a5YXPo7ZWO/XAkEJZru1N/sclWB0zBitP3kO4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132422; c=relaxed/simple;
	bh=BEVceNqg+HpcHA4SrsLXB32tZbghK0QZ93LTYvHXx5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAfcPExmDabzvupOJ08jWJxAE5u6KUsEvF4fkO8SDs48Au946lnREj49Jokzz9tbJay0Q+q2RVkCHGA5J/UYqEYCi9Pq9X1biJYtuVKfNOtnDP/3MWV597f3nTHYLEvbS7TQiO9vHJf/wrfGF0SzYWC4rxyPD0ZomBfhjxJhnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlNhTCNo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132420; x=1776668420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEVceNqg+HpcHA4SrsLXB32tZbghK0QZ93LTYvHXx5Y=;
  b=TlNhTCNoTi0iyjlwHJ64rxG9vkjkwaP1LNWTI6mfXPu3RcLa+b0Y7OCs
   tO1G54vP5wsjUa/zqQgCaPmD0HQeqkz1jdYsCDJQveyd93aU2GFoxV+My
   muRKKBtNyOue0VOjFWagEU7yijoxkanT9nTSGFMSzmKrLTwXHdE1U0AqQ
   Rz1v9RCoB2DmX1yjv2cmzWpZZUucDbW4XkWxHJZashs5GQqOxtS0fBV/v
   LUI2E0v+vN7kZEOX7+okNv0P68gOOSbm82izg1Y5jmQuMr1WOyCZfDAgs
   CbC1a5KWB229nkWau1L1WoweAZPIhBvwhUaBCyZyJp2f6lGtgHScqoeqm
   g==;
X-CSE-ConnectionGUID: kupbX6gPQQOY7u9IhXkr6A==
X-CSE-MsgGUID: +OrCg/6uT56hR41kerlglg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827903"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827903"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:20 -0700
X-CSE-ConnectionGUID: RtSe0CxDT0qjqNjQspKU1w==
X-CSE-MsgGUID: 8GQ7bVV1Qn2fyn79wALeUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615735"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 4/7] wifi: iwlwifi: back off on continuous errors
Date: Sun, 20 Apr 2025 09:59:58 +0300
Message-Id: <20250420095642.8816e299efa2.I82cde34e2345a2b33b1f03dbb040f5ad3439a5aa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When errors occur repeatedly, the driver shouldn't go into a
tight loop trying to reset the device. Implement the backoff
I had already defined IWL_TRANS_RESET_DELAY for, but clearly
forgotten the implementation of.

Fixes: 9a2f13c40c63 ("wifi: iwlwifi: implement reset escalation")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 27 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 +++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 ++-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index c1607b6d0759..6125fe70ce72 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -21,6 +21,7 @@ struct iwl_trans_dev_restart_data {
 	struct list_head list;
 	unsigned int restart_count;
 	time64_t last_error;
+	bool backoff;
 	char name[];
 };
 
@@ -125,13 +126,20 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 	if (!data)
 		return at_least;
 
-	if (ktime_get_boottime_seconds() - data->last_error >=
+	if (!data->backoff &&
+	    ktime_get_boottime_seconds() - data->last_error >=
 			IWL_TRANS_RESET_OK_TIME)
 		data->restart_count = 0;
 
 	index = data->restart_count;
-	if (index >= ARRAY_SIZE(escalation_list))
+	if (index >= ARRAY_SIZE(escalation_list)) {
 		index = ARRAY_SIZE(escalation_list) - 1;
+		if (!data->backoff) {
+			data->backoff = true;
+			return IWL_RESET_MODE_BACKOFF;
+		}
+		data->backoff = false;
+	}
 
 	return max(at_least, escalation_list[index]);
 }
@@ -140,7 +148,8 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 
 static void iwl_trans_restart_wk(struct work_struct *wk)
 {
-	struct iwl_trans *trans = container_of(wk, typeof(*trans), restart.wk);
+	struct iwl_trans *trans = container_of(wk, typeof(*trans),
+					       restart.wk.work);
 	struct iwl_trans_reprobe *reprobe;
 	enum iwl_reset_mode mode;
 
@@ -168,6 +177,12 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 		return;
 
 	mode = iwl_trans_determine_restart_mode(trans);
+	if (mode == IWL_RESET_MODE_BACKOFF) {
+		IWL_ERR(trans, "Too many device errors - delay next reset\n");
+		queue_delayed_work(system_unbound_wq, &trans->restart.wk,
+				   IWL_TRANS_RESET_DELAY);
+		return;
+	}
 
 	iwl_trans_inc_restart_count(trans->dev);
 
@@ -227,7 +242,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	trans->dev = dev;
 	trans->num_rx_queues = 1;
 
-	INIT_WORK(&trans->restart.wk, iwl_trans_restart_wk);
+	INIT_DELAYED_WORK(&trans->restart.wk, iwl_trans_restart_wk);
 
 	return trans;
 }
@@ -271,7 +286,7 @@ int iwl_trans_init(struct iwl_trans *trans)
 
 void iwl_trans_free(struct iwl_trans *trans)
 {
-	cancel_work_sync(&trans->restart.wk);
+	cancel_delayed_work_sync(&trans->restart.wk);
 	kmem_cache_destroy(trans->dev_cmd_pool);
 }
 
@@ -403,7 +418,7 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 
 	iwl_trans_pcie_op_mode_leave(trans);
 
-	cancel_work_sync(&trans->restart.wk);
+	cancel_delayed_work_sync(&trans->restart.wk);
 
 	trans->op_mode = NULL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 25fb4c50e38b..2b341bad7102 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -962,7 +962,7 @@ struct iwl_trans {
 	struct iwl_dma_ptr invalid_tx_cmd;
 
 	struct {
-		struct work_struct wk;
+		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
 		bool during_reset;
 	} restart;
@@ -1163,7 +1163,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_work(system_unbound_wq, &trans->restart.wk);
+	queue_delayed_work(system_unbound_wq, &trans->restart.wk, 0);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
@@ -1262,6 +1262,9 @@ enum iwl_reset_mode {
 	IWL_RESET_MODE_RESCAN,
 	IWL_RESET_MODE_FUNC_RESET,
 	IWL_RESET_MODE_PROD_RESET,
+
+	/* keep last - special backoff value */
+	IWL_RESET_MODE_BACKOFF,
 };
 
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c917ed4c19bc..b1ccace7377f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2351,7 +2351,8 @@ void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 	struct iwl_trans_pcie_removal *removal;
 	char _msg = 0, *msg = &_msg;
 
-	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY))
+	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY ||
+		    mode == IWL_RESET_MODE_BACKOFF))
 		return;
 
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
-- 
2.34.1


