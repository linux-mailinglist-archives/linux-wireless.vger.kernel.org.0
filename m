Return-Path: <linux-wireless+bounces-22250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8530AA4B08
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150BB4C0A3A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6F25A2B9;
	Wed, 30 Apr 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msqf6Qqw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A35E25A63D
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015896; cv=none; b=ADu2SeC5wtqPux6bAibd+GQ2v9G+FJbWnK05B2l/yKtvnpnrdUYkl2rgTO1btSyUswC17EVkY8IiZmtujGirjeXcUy1Du83p3ZUGGqnyCSwgwPpb2BmMfoNlJaul7UZMqj6pt9rMgfGdRQV05orEBCpAyNd1XAtmVBlGZ8Y3UfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015896; c=relaxed/simple;
	bh=mqrMGZb1llaC0mVpJjcelLSxZZXn2uo8LMLTZNBVygk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN4Uo5ScaOlgWn7WN91E+6vX8eQalLro0wfghaYfLDTlngXLw92WfwWB4tm18ChpJjVAy3Sp4YF382J8Tg7TRh+//9SHy9jh0l7JMVnEo0JLRpVPT2w3fXvYu06W54kOlWOOonuylnMOLewnfHuavHkCO8iuEtekX/Fwipl1f9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msqf6Qqw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015894; x=1777551894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqrMGZb1llaC0mVpJjcelLSxZZXn2uo8LMLTZNBVygk=;
  b=msqf6QqwM0R8R8Hyhnq2aj1bsLGJtRRATJ2AUviKM13qpBx3yJXf6aOX
   VZ1XwcRalIlM/ex0D1NmTq020TvMpCtyEvzLE2I6u6Et/Wh5u+boAk8+I
   W53VjRHqYZFGlF6YdWC5MhJGscceZgY/k4qCoSmAZdQVpyr5ti7DwqFgl
   4yFgV3yqWFc6j6sZB/tHU2OB3U2y9b6KBl362USs0RPOifZ8J3xTZPnK6
   SsECYjAAOW0JY81o6D8xBHY4J4pcNGk3CZ9B6CXEvYFKUicXsXiv7tgGZ
   mdPHbh0E1OwDcmh+3cBCn/5o9KQDyRt2dFqu+pz+LunNPGglHkgZ4yUcj
   g==;
X-CSE-ConnectionGUID: N0swXRKiSJG0K8BRxST/8w==
X-CSE-MsgGUID: 1rdAeuCpQpWu2Iv+IWEYEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578275"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:54 -0700
X-CSE-ConnectionGUID: RFC2VdhtRrqS+lBrThx7ew==
X-CSE-MsgGUID: e1lGPJqtTJ6j2K75HOlmYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087869"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/14] wifi: iwlwifi: back off on continuous errors
Date: Wed, 30 Apr 2025 15:23:13 +0300
Message-Id: <20250430151952.bcc69e74bc7e.I82cde34e2345a2b33b1f03dbb040f5ad3439a5aa@changeid>
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

When errors occur repeatedly, the driver shouldn't go into a
tight loop trying to reset the device. Implement the backoff
I had already defined IWL_TRANS_RESET_DELAY for, but clearly
forgotten the implementation of.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 27 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 +++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 ++-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 75d70021ee03..9ce94af0920e 100644
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
 
@@ -405,7 +420,7 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 
 	iwl_trans_pcie_op_mode_leave(trans);
 
-	cancel_work_sync(&trans->restart.wk);
+	cancel_delayed_work_sync(&trans->restart.wk);
 
 	trans->op_mode = NULL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8fae7f59a73e..844f0c427de3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -966,7 +966,7 @@ struct iwl_trans {
 	struct iwl_dma_ptr invalid_tx_cmd;
 
 	struct {
-		struct work_struct wk;
+		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
 		bool during_reset;
 	} restart;
@@ -1170,7 +1170,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_work(system_unbound_wq, &trans->restart.wk);
+	queue_delayed_work(system_unbound_wq, &trans->restart.wk, 0);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
@@ -1269,6 +1269,9 @@ enum iwl_reset_mode {
 	IWL_RESET_MODE_RESCAN,
 	IWL_RESET_MODE_FUNC_RESET,
 	IWL_RESET_MODE_PROD_RESET,
+
+	/* keep last - special backoff value */
+	IWL_RESET_MODE_BACKOFF,
 };
 
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b2258c13f7f7..5e531227aec6 100644
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


