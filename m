Return-Path: <linux-wireless+bounces-3177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EE84A6DF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2445D29174E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91658AAF;
	Mon,  5 Feb 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcUdb14Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A657894
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160932; cv=none; b=hD1ls1NPa50P37nuNYa67rspnXA0STRmVVXgE/GAtSZHjtforUO+A0vPpX523ojhzR8NUGFixdZ2ZuL1GQFSwBMWjuimBqmtOt92a7XUqShheEAXQxS/21G5Q7i4S+zahTw2RVRv1VFqfhuEznb7u9zkVdETgGJA45rWErfEPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160932; c=relaxed/simple;
	bh=FCJJokMSRhpmPJ4PXwTVrhz1gqxgUyRSRxMhFpliiU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpLl13skKM/MVXLyJ5GoC19UfQCStwV+uEnclIlmRI2hVnzEX/VVztXIVU2IIKOX+dY9AFoXzoP+OVNPUK/GsISne/fjZHbTfIGzHHIXksE+4npdvHtp0OJ2QHcGfY7E+Qw8JyhyGLxLFWDM3zsxX+U6AtK09KLXYT/mKt9s2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcUdb14Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160931; x=1738696931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FCJJokMSRhpmPJ4PXwTVrhz1gqxgUyRSRxMhFpliiU8=;
  b=KcUdb14Y0rmtNMxN87Lq0rA7Dvgryq/1uurWiDqMDtuwTjkJcmoC63G0
   RGJmD9ZBBVRbbh2AUWnTnGGeZ52GDt0RQE1uy23Xp8iQ76SNI1praeNT5
   +onE0lISn3bBO8DDxytY2S0qL1jB5fs6rhyMOP+YuUgq+JXjV4wphr6rV
   +5G2L3rSXfT8jRE6V18o/FH0Q3zChIuAIxoF4Y+9N+CtnmkhZsc85vJb6
   gB79jwkQYu+u4LjmpkjpyNbCHOPg5DJDmxkP9oPO+xjyJmuTDjE0Wmws8
   rOKeoKEnd3uE7Yrw0KFG08Sbnw64RZzZUI0uUElUiB/9m0QPvIcTtsEU0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381666"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381666"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403201"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: fix erroneous queue index mask
Date: Mon,  5 Feb 2024 21:21:14 +0200
Message-Id: <20240205211151.4148a6ef54e0.I733a70f679c25f9f99097a8dcb3a1f8165da6997@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When retrieving the queue index ("SCD SSN") from the TX response,
it's currently masked with 0xFFF. However, now that we have queues
longer than 4k, that became wrong, so make the mask depend on the
hardware family.

This fixes an issue where if we get a single frame reclaim while
in the top half of an 8k long queue, we'd reclaim-wrap the queue
twice (once on this and then again on the next non-single reclaim)
which at least triggers the WARN_ON_ONCE() in iwl_txq_reclaim(),
but could have other negative side effects (such as unmapping a
frame that wasn't transmitted yet, and then taking an IOMMU fault)
as well.

Fixes: 7b3e42ea2ead ("iwlwifi: support multiple tfd queue max sizes for different devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ea1a4283f72b..c5fafaaee521 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1661,12 +1661,18 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
  * of the batch. This is why the SSN of the SCD is written at the end of the
  * whole struct at a variable offset. This function knows how to cope with the
  * variable offset and returns the SSN of the SCD.
+ *
+ * For 22000-series and lower, this is just 12 bits. For later, 16 bits.
  */
 static inline u32 iwl_mvm_get_scd_ssn(struct iwl_mvm *mvm,
 				      struct iwl_mvm_tx_resp *tx_resp)
 {
-	return le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
-			    tx_resp->frame_count) & 0xfff;
+	u32 val = le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
+			       tx_resp->frame_count);
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return val & 0xFFFF;
+	return val & 0xFFF;
 }
 
 static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
-- 
2.34.1


