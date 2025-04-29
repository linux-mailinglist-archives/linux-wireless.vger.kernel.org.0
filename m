Return-Path: <linux-wireless+bounces-22212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF3AA1B9F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27F81B60744
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387225FA1F;
	Tue, 29 Apr 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq6bkGJl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EC25F7B3
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956455; cv=none; b=AOEnIyKIbuLA142aZmmH4ZdpCvxYzM9AEtamBZu4qIZSFrH6GEPwY7wVmgA4IcKShd+DhBMCPDU7zz2WjcL7bZW3aj3Rr8ZrmotUQvaAi2UVGJ3Q3ySF37rJpjjj4tush8r/0gw/fLxRdswwGMgUfy8EA4T3rvrq6UVoCVeL2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956455; c=relaxed/simple;
	bh=mqrMGZb1llaC0mVpJjcelLSxZZXn2uo8LMLTZNBVygk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnjmZFcRatXbNobTEci1M1Ql0AmlhmP22XkplrOjyPAFRE0cnji4tOcTXp0Pw//9H7FT+V+0f6Iu8BMqbNRE6jarjwDXmhuhEvgktlJ6ve37yKWYW03VeV9beUaP4sGn91AB9oAVo2KsLhJonpDvqq6QoBz/r7maUDPYxSD3UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq6bkGJl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956453; x=1777492453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqrMGZb1llaC0mVpJjcelLSxZZXn2uo8LMLTZNBVygk=;
  b=Gq6bkGJl6Xh1hF+E5q+VZn+4gcaXBk7018szJlnKGr5IDk/CvwJxz1sh
   YiqkQLdir7m04injD0rN/9BFRjeJ5mfVSQAM4L5L30fGGQXjxJ7xOrUXt
   SRopWjstZFOvYGRRMJ2TytaxH0BahK4FbLNxpfMk54+kH/1oFby2C2E2p
   JSH0uXOj1SdRPDxic/jgBBiZwui877LB11mxeS04vI1bhvOWXpdnhNrQ9
   cT9O2XL5sBHsF8ooUWK/Sqyedx5Tt4WfpvDw5YS9G/GxqzePgNEmVTqNF
   tJH60zg99E2KX0H/Q9WRrNXGhapQ5HyUzT84nppF9ORNoL86a4W8VkGCL
   w==;
X-CSE-ConnectionGUID: wEP3hIAwQFqRbnMMcoAyDg==
X-CSE-MsgGUID: 5n+2H0eVRUyPoMQMxICxyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713549"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:13 -0700
X-CSE-ConnectionGUID: /Nxv6VuISYazkGd6C0QgUg==
X-CSE-MsgGUID: K/aa7Z+ERVmfDiks+pOuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155007"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/14] wifi: iwlwifi: back off on continuous errors
Date: Tue, 29 Apr 2025 22:53:37 +0300
Message-Id: <20250429224932.bcc69e74bc7e.I82cde34e2345a2b33b1f03dbb040f5ad3439a5aa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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


