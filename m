Return-Path: <linux-wireless+bounces-19900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA7A549FB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872E1188945B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8A20B20A;
	Thu,  6 Mar 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhFbpuRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2720B7E2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261762; cv=none; b=hSNjuHSpKejl8nEDRg14H3N+x6soK9lfTED8ZB9jngV1leFqAtWFiDSvT7VvlV3E2U1wttxzRVTBprhMnBnjSZvoNawX5/4HwuWm9EgXH3uFIgBvh3CYvzBfmTiDb3RVUV1hfzKThOWZeb92FIf+GI/qG0rrdv7UxsN3AA1w6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261762; c=relaxed/simple;
	bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTAcgcxVIdGJotr+lLSawGTQXnoXVmsNXbauLRR4nLo0yvZZyg1z50s8VGJRTcS2bkqMMFnqlpJoSv83XE+fyOpahK4gYI4N3v1nLn7VvsqVG5eJ1kH9cMyebzrOPRgYRQ2rW80awwCC/YJqwUfH9CwdjycZpXz/t2sBvxLhMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhFbpuRk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261761; x=1772797761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
  b=FhFbpuRkZ7uWn4kMMubOYFwvymuFrZe96zxV/cnz4rcRD0jexHWgxmmu
   W+XVCJVl82G+6bEWzANQOHPKcsmyGziVSQIIxl1kzo8ruZcK7Y72gD7v0
   tYmNMPZFWVMRVEnf/fUjvKlT1XaZi/PmKOpPNLGGNdy5GgyuVQpPKMshU
   BGNwQpM+4M5RBsefxVjDq3GgTIyV5uL+Buwrn2Kx38003fxHUZQDSi2U/
   yXzNCf+4gOASepODtdzc9sEbOAnKSNhoyzR0UVqMr8wWIxurSeBgtbzl5
   o1gp1V9XmP/fx10URaTwV+oqfSyc58DYFVp7dRB0QaESxaC3jldPhelII
   g==;
X-CSE-ConnectionGUID: zLfp839qSkyK4CdRSm1I4A==
X-CSE-MsgGUID: Enenj+pZTWmY3nsCBE3rGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474527"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474527"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:20 -0800
X-CSE-ConnectionGUID: 025eNmD2TtWy2tVd+HUaDg==
X-CSE-MsgGUID: sbMCaQIfQmqFIJLkTk4b2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915556"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 07/19] wifi: iwlwifi: Add new TAS disable reason for invalid table source
Date: Thu,  6 Mar 2025 13:48:43 +0200
Message-Id: <20250306134559.6aadeaeaaeb7.I24f668ae716bee20cba15fdc73c3363693bbaf73@changeid>
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

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The new reason is added to the iwl_tas_statically_disabled_reason enum
and the corresponding message is updated in the
iwl_dbgfs_tas_get_status_read().

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index e1b6795c1f64..0cf1e5124fba 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -518,12 +518,15 @@ enum iwl_tas_dyna_status {
  * @TAS_DISABLED_DUE_TO_BIOS: TAS is disabled because TAS is disabled in BIOS
  * @TAS_DISABLED_DUE_TO_SAR_6DBM: TAS is disabled because SAR limit is less than 6 Dbm
  * @TAS_DISABLED_REASON_INVALID: TAS disable reason is invalid
+ * @TAS_DISABLED_DUE_TO_TABLE_SOURCE_INVALID: TAS is disabled due to
+ *	table source invalid
  * @TAS_DISABLED_REASON_MAX: TAS disable reason max value
  */
 enum iwl_tas_statically_disabled_reason {
 	TAS_DISABLED_DUE_TO_BIOS,
 	TAS_DISABLED_DUE_TO_SAR_6DBM,
 	TAS_DISABLED_REASON_INVALID,
+	TAS_DISABLED_DUE_TO_TABLE_SOURCE_INVALID,
 
 	TAS_DISABLED_REASON_MAX,
 }; /*_TAS_STATICALLY_DISABLED_REASON_E*/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index b453ad0000c8..6ffc04a23c6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -552,6 +552,8 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 			"Due To SAR Limit Less Than 6 dBm",
 		[TAS_DISABLED_REASON_INVALID] =
 			"N/A",
+		[TAS_DISABLED_DUE_TO_TABLE_SOURCE_INVALID] =
+			"Due to table source invalid",
 	};
 	const char * const tas_current_status[TAS_DYNA_STATUS_MAX] = {
 		[TAS_DYNA_INACTIVE] = "INACTIVE",
-- 
2.34.1


