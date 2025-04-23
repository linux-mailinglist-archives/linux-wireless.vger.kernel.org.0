Return-Path: <linux-wireless+bounces-21882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AFA97EFE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D343A56E6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555061F30DD;
	Wed, 23 Apr 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq5EY0vo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2541F4CAB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389018; cv=none; b=dJ9KaEFNqBe646HnNDdnHABhL3sM+oqQntGEh7y57KLFVA0eceLzWjLaadzK+uuloaTZSFnsx8CdqLklNS75BwobTuspf4D92Vom9iyqUE4yCyDZZW34tiZg8ySfR1jEK1RQVpQgU5GDpc2LCmTv3pd7ja1FLvyXF/Kt0BMd3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389018; c=relaxed/simple;
	bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIpNmOri85dx7Y9p6DfOboKaaXOuftJaeEWMHbCGxPduXcibxuO8XDtqxv3pwG2jxVG/+odELYCfqowyzMf+YN4x0HAeHWauku4z+2RnzWppoMkKe/taBvEHFyqRy40lHBO8Ymf8d725rhtFeO5WtxSDi2hKubiJ8txNkSZ5j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wq5EY0vo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389016; x=1776925016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
  b=Wq5EY0voq/gzLLGcHePtQdf8EJNvnPIPHvslVC00/NOAXB4TCbVf3lgY
   AORK/imfAxGLaYWls2NlEDwO/WsuzcBXXxxbiRkpxT8C8J+EeQbBKke3x
   mDofGNL/yamtEU5R9yxf6SQrg91HvfP7tV/9QvZX4uA2VawTWoGzYCElT
   IuhoGT1VjkxsA0fVR2NfvBjvg+y36M5nlIM6l7nKeuAFFaAzv6BbJpK2l
   ejfPDY4iukMHV9dka+aX8g0ESUXERF9EOINZHMsq6qGj6gFoLQ2vzuAoF
   E8/2ZDlFYsLrF1CNAZBcgmu1a9rrPfePfgyJYooNOf+EUiIQeQdM3FFOU
   A==;
X-CSE-ConnectionGUID: iqh2Mr+zS12c7bDTYv7HZQ==
X-CSE-MsgGUID: mM62ciC/QB6e7hVAWSHg6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843614"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843614"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:56 -0700
X-CSE-ConnectionGUID: oLiZTL4CRsGIewpJqAvd/g==
X-CSE-MsgGUID: Ah9+z3eKSKqu1+UkiMrzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269008"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
Date: Wed, 23 Apr 2025 09:16:27 +0300
Message-Id: <20250423091408.e8a20fb41dc5.I9cd41a15148c90e953335e7020405103ba3fc7f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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


