Return-Path: <linux-wireless+bounces-33495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJkqBjBFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B72D14AB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BE5C3027359
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36522DF3FD;
	Thu, 19 Mar 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8vl8YTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C03164AA
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946153; cv=none; b=ZVrVbc5D6Gwp5tcmTTuJNGD2kZkTeZfzL5jVH2LDuYbKcriFMRuKgjPDP7EoCAbasQt+Ke5YhM94K3Jpvx5qGzXaY4Ap//LOa+ahsioC4KhJX9X3w7ZInXvwKtWs/JP4gq+em6sRyKha5Ya3uUDJh/V7qUVbifY4yc2OJ2miEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946153; c=relaxed/simple;
	bh=qKC+pAjQVFlhJ9kZh5OfRO3Rx0ILnKrOSwZIbFhvvMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsJyHkLBQCLlv3fsm95yeXC76bApZQy/+FeSuZvTcFZiuAmY2WwEo9+GmJdOzEJxmpI1dnPAcf3gd+TS2pSVa2wF6/c145zfD1aL+ssCjpe/ZKhuhx97RBJYHCDPPmMZqVNLueA3UWo+zuFlAwAUdCWMBEu7JfAIMEleAYOr2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8vl8YTx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946153; x=1805482153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKC+pAjQVFlhJ9kZh5OfRO3Rx0ILnKrOSwZIbFhvvMA=;
  b=Q8vl8YTxCYtJ59STh+/0uFwHVFilp+dfVrQ2jrMR5sZFrFP1n1ZSmMKc
   XvYr1LFLOzwCs6lFzQCjVkwN4Xqj6iFxC/5vPqHOMBJQNNoCPSDy1LSPG
   xUzxEsfsmupdZOBxYMa66quITE/jz0ZLOJtcHMq6eRC+GTmycmlCzRzWV
   xawYgFMmQQG5DZ6iutXiDxaILjd6Ot8IS56CBRyY9/lVh1kC/TTvtDYNQ
   VjO4wdqsfyNP6sMRMGe4AbJm8GDcAdRFqpBhtmXCc3tUJ/OyvBIqwaCnz
   hELANFzI8Qek5I5xclvdE32qAnTUAHEhnVsaNX65Ini07DTXrzgnHDAV1
   w==;
X-CSE-ConnectionGUID: DFchpOsBSTWXsVaSGpXwrg==
X-CSE-MsgGUID: jMdIkFi1Rt+ZtiYhpz2AyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656471"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656471"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:10 -0700
X-CSE-ConnectionGUID: LTFLZSOJRZar7ynjzdLgFg==
X-CSE-MsgGUID: 00W927QBQBWRoBYU3/UzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998496"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: restrict TOP reset to some devices
Date: Thu, 19 Mar 2026 20:48:42 +0200
Message-Id: <20260319204647.6c4479f4e49d.I5023d70cb33f1e18f7cb15981fc3acfbb00862b7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33495-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: C80B72D14AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Due to the Bluetooth implementation needing to match, not all
devices can actually do TOP reset. Restrict it to Sc2/Sc2f or
later, with Wh RF or later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 18 ++++++++++++++++++
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 89901786fd68..16b2c313e72b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -138,7 +138,7 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 		IWL_RESET_MODE_FUNC_RESET,
 		IWL_RESET_MODE_PROD_RESET,
 	};
-	static const enum iwl_reset_mode escalation_list_sc[] = {
+	static const enum iwl_reset_mode escalation_list_top[] = {
 		IWL_RESET_MODE_SW_RESET,
 		IWL_RESET_MODE_REPROBE,
 		IWL_RESET_MODE_REPROBE,
@@ -159,14 +159,14 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 
 	if (trans->request_top_reset) {
 		trans->request_top_reset = 0;
-		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC)
+		if (iwl_trans_is_top_reset_supported(trans))
 			return IWL_RESET_MODE_TOP_RESET;
 		return IWL_RESET_MODE_PROD_RESET;
 	}
 
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
-		escalation_list = escalation_list_sc;
-		escalation_list_size = ARRAY_SIZE(escalation_list_sc);
+	if (iwl_trans_is_top_reset_supported(trans)) {
+		escalation_list = escalation_list_top;
+		escalation_list_size = ARRAY_SIZE(escalation_list_top);
 	} else {
 		escalation_list = escalation_list_old;
 		escalation_list_size = ARRAY_SIZE(escalation_list_old);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index aa0952a011e0..61e4f4776dcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1258,4 +1258,22 @@ bool iwl_trans_is_pm_supported(struct iwl_trans *trans);
 
 bool iwl_trans_is_ltr_enabled(struct iwl_trans *trans);
 
+static inline bool iwl_trans_is_top_reset_supported(struct iwl_trans *trans)
+{
+	/* not supported before Sc family */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+		return false;
+
+	/* for Sc family only supported for Sc2/Sc2f */
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_SC &&
+	    CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_SC)
+		return false;
+
+	/* so far these numbers are increasing - not before Pe */
+	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) < IWL_CFG_RF_TYPE_PE)
+		return false;
+
+	return true;
+}
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d76fe..a05f60f9224b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3197,7 +3197,7 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			return -EINVAL;
 		if (mode == IWL_RESET_MODE_TOP_RESET) {
-			if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+			if (!iwl_trans_is_top_reset_supported(trans))
 				return -EINVAL;
 			trans->request_top_reset = 1;
 		}
-- 
2.34.1


