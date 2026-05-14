Return-Path: <linux-wireless+bounces-36432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE64Bn8mBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:46:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 716055467B0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543E9304D266
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A139AD32;
	Thu, 14 May 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsYNqifR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D623BB683
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787907; cv=none; b=G7PKUWrHpMdAaYuVr/tXoKJmcfg17RWR3gDsfdOTBtotZ6lP2vMwHaD4to4OwaIkIt1iiLXDLUb/mLEDZPCrdiV9oKK51ZLyIz83rtQgmUKyvLG0+ONhKPy7uZcOvqB6jYq4ddan1iHhMWsn31lOjf330QQSXmYW7rh70fm2CPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787907; c=relaxed/simple;
	bh=Ww27I9VL6mfwPpc8AWTX+2rHK2+DsU2opn46FV+tRuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltSjqr/Ivu/BLfkbPmqpxYZPNYuxuNhCgPWgJIv3kWy+m7pS5bZQEM5EPrV2HwZRan4dbHXplKO7+pogXHAZIAGj53dx5swcAamCUALQa40ZIN2SJmrvFtFbkmvA3dlFtiqoCIeXDeFfuNJEQBGOYolMIjb+Zem7FF8AmqHGzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsYNqifR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787907; x=1810323907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ww27I9VL6mfwPpc8AWTX+2rHK2+DsU2opn46FV+tRuI=;
  b=IsYNqifRRnl0nAAN9K37cQ5L1CBMC2zBo3PFklFDgjoDxDjXhFfu6OWT
   VUJ7TaEOUEpZ+GlesXKS95DIINgu51LttAV16y5CskfdDSPKIswumJIty
   rv5+/eplwA+T77/VnHl6bD+4EkQf9UgitHNGX99lGT5uvLJuvl5la/trK
   mCS3KCNN/1KtxoBWowTlbD0fuK3GbBYSHKmaB0z1+I2iUHZK/dZ32Km9T
   k5T/P2xpzeFDKwH7GyQVM5ITNjtPL37/85NOGBvbqBixEFvw41yk3H6KQ
   8JQEDSDwoB8gpZCa12WhlpCzQJgprW2Ba3WhTNSr+U0hJRSuqEBtqmt4b
   A==;
X-CSE-ConnectionGUID: GP/AYJtLS9mm7SzdefTnjA==
X-CSE-MsgGUID: LdmU6I7jRjuIjzPJfAAc7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352611"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352611"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:07 -0700
X-CSE-ConnectionGUID: ZuliZJ3sROWlS8neUEhjYw==
X-CSE-MsgGUID: t2+IQKg/SDGpqPx9Lshciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616364"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: api: clean up/fix some kernel-doc references
Date: Thu, 14 May 2026 22:44:31 +0300
Message-Id: <20260514224230.1e65dc357cbf.I454805593324e51ff71ec5e6bac83aa6dace5383@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 716055467B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36432-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Some of these structs just don't exist (any more), or other
versions should be referenced, clean that up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 7 +++----
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 7 ++++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 24bac3f00310..abd259350589 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -57,8 +57,7 @@ enum iwl_legacy_cmds {
 	/**
 	 * @UCODE_ALIVE_NTFY:
 	 * Alive data from the firmware, as described in
-	 * &struct iwl_alive_ntf_v3 or &struct iwl_alive_ntf_v4 or
-	 * &struct iwl_alive_ntf_v5 or &struct iwl_alive_ntf_v7.
+	 * &struct iwl_alive_ntf_v3 or &struct iwl_alive_ntf_v7.
 	 */
 	UCODE_ALIVE_NTFY = 0x1,
 
@@ -384,7 +383,7 @@ enum iwl_legacy_cmds {
 	 * @STATISTICS_NOTIFICATION:
 	 * one of &struct iwl_notif_statistics_v10,
 	 * &struct iwl_notif_statistics_v11,
-	 * &struct iwl_notif_statistic,
+	 * &struct iwl_notif_statistics,
 	 * &struct iwl_statistics_operational_ntfy_ver_14
 	 * &struct iwl_statistics_operational_ntfy
 	 */
@@ -558,7 +557,7 @@ enum iwl_legacy_cmds {
 	WOWLAN_CONFIGURATION = 0xe1,
 
 	/**
-	 * @WOWLAN_TSC_RSC_PARAM: &struct iwl_wowlan_rsc_tsc_params_cmd_v4,
+	 * @WOWLAN_TSC_RSC_PARAM: &struct iwl_wowlan_rsc_tsc_params_cmd_ver_2,
 	 *	&struct iwl_wowlan_rsc_tsc_params_cmd
 	 */
 	WOWLAN_TSC_RSC_PARAM = 0xe2,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 2ee3a48aa5df..d3f774ffacde 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  * Copyright (C) 2018-2022 Intel Corporation
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
@@ -81,8 +81,9 @@ enum iwl_location_subcmd_ids {
 	 * @TOF_RANGE_RESPONSE_NOTIF: ranging response, using one of
 	 *	&struct iwl_tof_range_rsp_ntfy_v5,
 	 *	&struct iwl_tof_range_rsp_ntfy_v6,
-	 *	&struct iwl_tof_range_rsp_ntfy_v7 or
-	 *	&struct iwl_tof_range_rsp_ntfy_v8
+	 *	&struct iwl_tof_range_rsp_ntfy_v7,
+	 *	&struct iwl_tof_range_rsp_ntfy_v9 or
+	 *	&struct iwl_tof_range_rsp_ntfy
 	 */
 	TOF_RANGE_RESPONSE_NOTIF = 0xFF,
 };
-- 
2.34.1


