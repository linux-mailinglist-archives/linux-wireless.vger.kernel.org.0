Return-Path: <linux-wireless+bounces-19910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283BA54A07
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1D2188BD91
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579D20B207;
	Thu,  6 Mar 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4kvM9Yc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582920CCD2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261777; cv=none; b=QTYCwNoiPMu1aNQtePDOk4tCGr2B5wkMs49NBxpguZBhIJWX/G6oOWAzGw3dFQcwgaSqSlNfjypTnLklrkiwb/YdK+TJ5sujcofXkHSg5gLSnTsL7wh7Vn+J8I8Ggsg2FShGNqp340LAWcR/avVo+aruKhUiPsjJt/VCVvPUIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261777; c=relaxed/simple;
	bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OC7+pCbT+0nZ+IoBTTiSLIGfeWUyjmWzvvO1U3pzVybZAVnwUNZpy5mXF2BN9Cbv2DXpFJQAD5mpAhlHLE0tLS8odAv5tVfI4SEtqWu8mb2UfoqHdS6TvnXmv52lisc5hlVDEQwA85O929nlomuaLrBsl5vGhJ38aKnhzvdYqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4kvM9Yc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261776; x=1772797776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjWMqa+PLxdUGrCT7fLZo+1F/pQQ3ynROXEYgLdn02Y=;
  b=m4kvM9YcCvaVnJuLEazE4hcL3xkwpm1AUmHPLDAW6wqPMa9hoq+HMxdl
   VjY60m4vFJgVb8gg0V2pO8bKSl96iPJmiN3DNXJFIN3RV89DXIA7mx6cb
   LpEpFGqyOEqHOcHLjhXtfIvdBO42GzbziGDbdVdvDT6HZe8HOfVLfIvUQ
   IciTrXj0cBcktSeTr26a+OCkmIrJNwpryhr8FEoAFo4n7lqcYCyLz/8cE
   L01sEV9BhMQ/Pvpy6BmXm02tmA64izbyj/bnb1dsaAggGIT4w3HQLx/TC
   83RGKMQV+zNb6YoOopFdbzLFcN8hUezacDhlfAHilW4obvmEUgmnmojwj
   A==;
X-CSE-ConnectionGUID: TT6WaamtRnu+h3HfYp5Lhg==
X-CSE-MsgGUID: CbiIexa/Sb+I9TXg8XSfnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474568"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:36 -0800
X-CSE-ConnectionGUID: ol2AZJtRQ1mMBjT9pjjNlQ==
X-CSE-MsgGUID: eYU8UeVfS82ECiemV/0leA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915593"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 17/19] wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
Date: Thu,  6 Mar 2025 13:48:53 +0200
Message-Id: <20250306134559.b1e93424803e.I9cd41a15148c90e953335e7020405103ba3fc7f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
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


