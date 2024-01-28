Return-Path: <linux-wireless+bounces-2611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812E83F46E
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F1928431C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CDD53E;
	Sun, 28 Jan 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHKz7USk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD24D536
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424886; cv=none; b=IRPu4G45+oQ+2kE9dq3AKm1UBVfOCr29jM3z6J7lZaBhCaxB1JHHZJYR9Cyc4B6HFoeTwvQYSGNGjwdMVulzVL+5kfkGmfbZ5yGuLj2heW8fkJ2oDY+qMktTgv+tTtiQojdD34NwyRkosm/FhSCdLMjPPkqnq+hANsFClB3ZpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424886; c=relaxed/simple;
	bh=SS5qiWLtgnSXrKYJAekezJ7NzkWTyqSYKGMoAVdFyak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjwTuSb2k92OJZJC1uDgjC1txuGMmTNLrea7aDrP9WtyI6WZZPZdYTiVghhUqcFiQEv+UGoIbSMboksERQ6/LbeqrrILEixqLE3CzU8Vihh4pCEy6gHjtOC02KiW4qjBWaJ806AaA6mucviCCt+qgKlY4wKhrUX8MZOp2WbSO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHKz7USk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424885; x=1737960885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SS5qiWLtgnSXrKYJAekezJ7NzkWTyqSYKGMoAVdFyak=;
  b=DHKz7USkgY9/I5CMqlv4VP6cdylvf2cQ7j5CAuVBOTcpZlwNtkcEa2Jh
   6dS/XwJ6vcDpMosmcqnA/5v13khsRYqK6sGqla9+SCjFXR9w5f7V7WVgh
   4dio1qEfadPKR1GOU2dHhqqNgj9geUPNhe41yfzXYTnnvKuNzLQey+XUe
   bLCMojwfAruEENmwIpbpzLDgLD683y0+TRWXz5sQpR7B18JZ9s83sZXdN
   qd7uFwro/rF8firh44O8zz8PtuznQmytzCJMD08avYhk4TOjU2QiRLS/M
   idD97YkIc1W+SGU/sWBO/QzkUcaRDvJhV8JRg+Fo5f+eqzouqwwkoKeYS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217650"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217650"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833349"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: dbg-tlv: avoid extra allocation/copy
Date: Sun, 28 Jan 2024 08:53:51 +0200
Message-Id: <20240128084842.075c8b9f7030.Id5a61e1a87a9c6932727fb4e2c9b54ed6070362a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In iwl_dbg_tlv_alloc_trigger() the code makes a copy just
to modify it and pass it to another function to make a copy
again. Change the API to return the copy so the adjustment
can be done without another copy.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 72075720969c..7b145b417810 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -64,21 +64,22 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_CONF_SET]	= {.min_ver = 1, .max_ver = 1,},
 };
 
-static int iwl_dbg_tlv_add(const struct iwl_ucode_tlv *tlv,
-			   struct list_head *list)
+/* add a new TLV node, returning it so it can be modified */
+static struct iwl_ucode_tlv *iwl_dbg_tlv_add(const struct iwl_ucode_tlv *tlv,
+					     struct list_head *list)
 {
 	u32 len = le32_to_cpu(tlv->length);
 	struct iwl_dbg_tlv_node *node;
 
 	node = kzalloc(sizeof(*node) + len, GFP_KERNEL);
 	if (!node)
-		return -ENOMEM;
+		return NULL;
 
 	memcpy(&node->tlv, tlv, sizeof(node->tlv));
 	memcpy(node->tlv.data, tlv->data, len);
 	list_add_tail(&node->list, list);
 
-	return 0;
+	return &node->tlv;
 }
 
 static bool iwl_dbg_tlv_ver_support(const struct iwl_ucode_tlv *tlv)
@@ -106,7 +107,9 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
 	IWL_DEBUG_FW(trans, "WRT: Loading debug cfg: %s\n",
 		     debug_info->debug_cfg_name);
 
-	return iwl_dbg_tlv_add(tlv, &trans->dbg.debug_info_tlv_list);
+	if (!iwl_dbg_tlv_add(tlv, &trans->dbg.debug_info_tlv_list))
+		return -ENOMEM;
+	return 0;
 }
 
 static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
@@ -175,7 +178,9 @@ static int iwl_dbg_tlv_alloc_hcmd(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].hcmd_list);
+	if (!iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].hcmd_list))
+		return -ENOMEM;
+	return 0;
 }
 
 static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
@@ -246,11 +251,9 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 				     const struct iwl_ucode_tlv *tlv)
 {
 	const struct iwl_fw_ini_trigger_tlv *trig = (const void *)tlv->data;
-	struct iwl_fw_ini_trigger_tlv *dup_trig;
 	u32 tp = le32_to_cpu(trig->time_point);
 	u32 rf = le32_to_cpu(trig->reset_fw);
-	struct iwl_ucode_tlv *dup = NULL;
-	int ret;
+	struct iwl_ucode_tlv *new_tlv;
 
 	if (le32_to_cpu(tlv->length) < sizeof(*trig))
 		return -EINVAL;
@@ -267,20 +270,18 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 		     "WRT: time point %u for trigger TLV with reset_fw %u\n",
 		     tp, rf);
 	trans->dbg.last_tp_resetfw = 0xFF;
+
+	new_tlv = iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].trig_list);
+	if (!new_tlv)
+		return -ENOMEM;
+
 	if (!le32_to_cpu(trig->occurrences)) {
-		dup = kmemdup(tlv, sizeof(*tlv) + le32_to_cpu(tlv->length),
-				GFP_KERNEL);
-		if (!dup)
-			return -ENOMEM;
-		dup_trig = (void *)dup->data;
-		dup_trig->occurrences = cpu_to_le32(-1);
-		tlv = dup;
-	}
+		struct iwl_fw_ini_trigger_tlv *new_trig = (void *)new_tlv->data;
 
-	ret = iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].trig_list);
-	kfree(dup);
+		new_trig->occurrences = cpu_to_le32(-1);
+	}
 
-	return ret;
+	return 0;
 }
 
 static int iwl_dbg_tlv_config_set(struct iwl_trans *trans,
@@ -304,7 +305,9 @@ static int iwl_dbg_tlv_config_set(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].config_list);
+	if (!iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].config_list))
+		return -ENOMEM;
+	return 0;
 }
 
 static int (*dbg_tlv_alloc[])(struct iwl_trans *trans,
@@ -1148,7 +1151,9 @@ iwl_dbg_tlv_add_active_trigger(struct iwl_fw_runtime *fwrt,
 	if (!match) {
 		IWL_DEBUG_FW(fwrt, "WRT: Enabling trigger (time point %u)\n",
 			     le32_to_cpu(trig->time_point));
-		return iwl_dbg_tlv_add(trig_tlv, trig_list);
+		if (!iwl_dbg_tlv_add(trig_tlv, trig_list))
+			return -ENOMEM;
+		return 0;
 	}
 
 	return iwl_dbg_tlv_override_trig_node(fwrt, trig_tlv, match);
-- 
2.34.1


