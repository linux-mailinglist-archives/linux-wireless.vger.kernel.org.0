Return-Path: <linux-wireless+bounces-19950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F13A55954
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4686418981F7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734727C852;
	Thu,  6 Mar 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAnzT2il"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C852276D33
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298722; cv=none; b=ag1uj1jIQQEPSbyK7n60ksiyIO9OiP4jlomZRa7NjkHCTB/Zo9lGVtgj1z7bhVodag6xdQaV5MXK/D39x0tD6f+4dgfdXs+9K4eOwucU/Bxjt2bePLzMCPwmfh9hk3XZDFBb2FLLAfWz8Sz+gwYbfc6ydu3O7zXVWifLuN4zmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298722; c=relaxed/simple;
	bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpsjnYucqkn3/j1O3wxjzXmwi5KCX/J4P1D4/OqyQS+8IvVeZGwk0jTxVJrOb23xE2AO0sj/SQFsxNcLNw6roC4lgApTkJTHIUh7BpflHvLTJLzM1Z5GtwQY3MhmY3DfaNMJj6K5kIyxxGg2kmg5ixj5vO/0pX6TJAiOoX9+4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAnzT2il; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298721; x=1772834721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzX5tu+ew83PjbPqBkcMUrtdK5UVT24DkjBm499PVt0=;
  b=aAnzT2ilIXAEqli1S3RFK5C1POseGyYPSyMgxsAFQUL5BIEMQoPiElkj
   1QXmos5QM7R9yeb2w+hrtSKj+KiCONWhXqIr/VxGZOuu7kJNTWiRAAIvP
   +OsETproDd9Xa/dWKfGkK/Oog2D6r5rdHZJupEIor8bJ+S8mFvF1Pl8Db
   tn0D2xeAHVpLLn+2EXklPNdi+R/eddMcJGBw77yEubZ7fZNcJVifqE/tw
   Dry1egcKPeA+PyxVe/gE6FiJi63XwJQKaa6kcQpptDNiTU1SkZSzmpgkt
   JXEJQvrlppYAu6POHY21oG67+MHs6Vv4l/AEYbHB+hHhEVPPCOVg2SpgF
   g==;
X-CSE-ConnectionGUID: PhF/+3q0SAyx+3qef5cJLA==
X-CSE-MsgGUID: jGf4IH91QeeCeoCk59FkOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474264"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474264"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:18 -0800
X-CSE-ConnectionGUID: eNRjQ0HdSSyRkFrrjgOHug==
X-CSE-MsgGUID: alXfnwRiSZ2iMc8twQ9Gvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061891"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: iwlwifi: Add new TAS disable reason for invalid table source
Date: Fri,  7 Mar 2025 00:04:45 +0200
Message-Id: <20250307000213.828a33b7c7c5.I24f668ae716bee20cba15fdc73c3363693bbaf73@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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


