Return-Path: <linux-wireless+bounces-21861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E8A97E4A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB363B9006
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD5EAFA;
	Wed, 23 Apr 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMwcBulD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FC26462C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387453; cv=none; b=n20JIL1ArIWMc6r3OmYCdCdWjDqSariEhwZ5wdFLcMP8yhgWnHr82KpxdU7WdslIvh6YeE7ZszpE7BPhG7SAts1JN5kdRd+DC8zp6wPOQ4ez4OdHQc6lMuqKxiTnjYmTInQFXUPp/+f8nLaKZHuQjinsR/DRyMvB69i55Euweq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387453; c=relaxed/simple;
	bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFY9z3WYWaIrlTacZGELRohZh7EC9IfeTp9lWPceSgRNSnpqU8w09WdR5UZvNqYzqzmwT8WMF75S42Il9+1VIlGzxMur94mQ8ow8CWrJwdYRiRhx6BfgYYApF0gX+sM6B/2WC7KzF4bsVak7EG/QpTiRRLbffgNELuyOmLjY8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMwcBulD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387451; x=1776923451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
  b=SMwcBulDqjJCJ3jrizVTZqONC5/MOjPA6F+j1yqNYKU5SvhyToSIL1Dj
   vnap3tnefWxNVDGvs/IFgMaH8xh/+dMf4mN8uVwSm3xnUv40WKXGCF4hr
   rUuxa7s70MpCOvy1t86WGnP/pqc7WW2gc0boEzgjUQgMSe/OL3+xkF1fi
   cDZl5RpA40uj3bNjT/xBzcKY7AYKTtPdLrUypEc6kmXfq9DlaDtEhVN4L
   0aUKFuVepqTG05MyO6EgIAH5KTOdBjOmDQqgB/bm843rO9rFHzLkIssxw
   /7A3IvAsGx0cpBsG1lYEjMfJdyUNJ1CvtLSai5hOkpHMIP1HyhMfiyfHo
   g==;
X-CSE-ConnectionGUID: wrulUb98T7q0vuIBzrpkJw==
X-CSE-MsgGUID: om9a3sRySpWY6scWnxH8Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844613"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:51 -0700
X-CSE-ConnectionGUID: EesnaCyRTD6/g/ZImoroGg==
X-CSE-MsgGUID: s7DCOzJxTcy9CDXFwEbKTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164298"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 01/17] wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
Date: Wed, 23 Apr 2025 08:50:20 +0300
Message-Id: <20250423084826.e8a20fb41dc5.I9cd41a15148c90e953335e7020405103ba3fc7f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This state can never be entered, since the last place using it was
removed with non-DQA mode in commit c8f54701bdbf ("iwlwifi: mvm:
remove non-DQA mode"). Clean up this code too.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h |  5 +----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c  | 14 ++------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 19c905b641e2..af62c7f7c834 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -225,8 +225,6 @@ struct iwl_mvm_vif;
  * @IWL_AGG_ON: aggregation session is up
  * @IWL_EMPTYING_HW_QUEUE_ADDBA: establishing a BA session - waiting for the
  *	HW queue to be empty from packets for this RA /TID.
- * @IWL_EMPTYING_HW_QUEUE_DELBA: tearing down a BA session - waiting for the
- *	HW queue to be empty from packets for this RA /TID.
  */
 enum iwl_mvm_agg_state {
 	IWL_AGG_OFF = 0,
@@ -234,7 +232,6 @@ enum iwl_mvm_agg_state {
 	IWL_AGG_STARTING,
 	IWL_AGG_ON,
 	IWL_EMPTYING_HW_QUEUE_ADDBA,
-	IWL_EMPTYING_HW_QUEUE_DELBA,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f67afb66ef2b..91f6945f3f98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1372,8 +1372,7 @@ static void iwl_mvm_check_ratid_empty(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvmsta->lock);
 
-	if ((tid_data->state == IWL_AGG_ON ||
-	     tid_data->state == IWL_EMPTYING_HW_QUEUE_DELBA) &&
+	if (tid_data->state == IWL_AGG_ON &&
 	    iwl_mvm_tid_queued(mvm, tid_data) == 0) {
 		/*
 		 * Now that this aggregation or DQA queue is empty tell
@@ -1402,15 +1401,6 @@ static void iwl_mvm_check_ratid_empty(struct iwl_mvm *mvm,
 		tid_data->state = IWL_AGG_STARTING;
 		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
-
-	case IWL_EMPTYING_HW_QUEUE_DELBA:
-		IWL_DEBUG_TX_QUEUES(mvm,
-				    "Can continue DELBA flow ssn = next_recl = %d\n",
-				    tid_data->next_reclaimed);
-		tid_data->state = IWL_AGG_OFF;
-		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
-
 	default:
 		break;
 	}
-- 
2.34.1


