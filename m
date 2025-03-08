Return-Path: <linux-wireless+bounces-20050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3EA57E7D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481BA3B13E4
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D920FA9B;
	Sat,  8 Mar 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1FWTWb4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530B20E31D
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468787; cv=none; b=T9Ov15VEw50bT17NF/Blr2AEN76jGj8DOuVJfQ3a+lz+W89xghsj6pilaUsFATXeL2h4svGoDKKQJcR8JlQMm+hoJM1Rgeod8G7N9Dz7rLWJ/ZVAyQQnvOZH9PGQQ//4NEOsstlfJUgZVCqOywz+FxArKYPoKE9bxIOWFgTcAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468787; c=relaxed/simple;
	bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZHz02enqQ3lJER02YSRayMaDsUgH0o1CPtoFawSIyNNhn5BiSsOC0AxIJtF39mVHuLlja0rtkN9hlO8TKtcf2OAZlP0VPI/m0NiRIcB4nkMIkGLXiJWCE73/t4wcebMjR87eM7NCnhJtvUlWgARnh6VLlWNLh3pkibbHw5oFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1FWTWb4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468786; x=1773004786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
  b=L1FWTWb45w8qBAWVz6Ub5eColHH/UKx4kC0pQtO0JWgAqOKrugQ70Ilb
   449NCo9d6WeeXj6QiLe9IRiRed5L7N09DbF15brdqIwVpLCePyf+DF+Cz
   j1TYBcfxFqRFemKt+xcOylGfty3mwORLdo9DF5He+aMFUx/uGax8+LbY6
   qMle2N+XnJpesNrKmM8ocfT/mZOF53T8L0pZDxUYbSHtdEUMQBGj1tAlO
   nNkXd5n3TaebaW0o8o/h0F5ren3/KOz/srPBkZQmxpdeqZuVqPuOjrSAz
   UiUlaGi1hdASNsKXnSeg7RZoKiciDktB4p7VhXVmPHczq6iZkcs0MmxYA
   g==;
X-CSE-ConnectionGUID: V9YtvqmbTC+BuBwBCkzlug==
X-CSE-MsgGUID: CCDo9NzGQLW58cvNrVWfkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052371"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052371"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:46 -0800
X-CSE-ConnectionGUID: CmetSVOAR3qjKl578KHb5Q==
X-CSE-MsgGUID: RcLf6xpVRXyth5PAsYTfZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859915"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v3 wireless-next 05/14] wifi: iwlwifi: Add new TAS disable reason for invalid table source
Date: Sat,  8 Mar 2025 23:19:16 +0200
Message-Id: <20250308231427.5e1272ef3508.I24f668ae716bee20cba15fdc73c3363693bbaf73@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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


