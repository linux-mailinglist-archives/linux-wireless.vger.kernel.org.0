Return-Path: <linux-wireless+bounces-26643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9CB36F3B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FAD8E282B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020417736;
	Tue, 26 Aug 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkV3d3i7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF22417D9
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223749; cv=none; b=kmUNdgELWb32rX2TE/Nhkl3lomNK8G/o6fhyAdNvaMWeQM99lYFoJWFvUWh1gRCi91qm9mnONiVeX7gaYJZnLznt/VSbY/p3eOEAHMqLzlut82ut348VPQOEFOyp6lLC+xi1oiCV7pkTvuN7ueTOfspFusUe6SJwadCRx32JKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223749; c=relaxed/simple;
	bh=jdz8/3k+nF6FEmroHUrpeTplKaGQT5ezughmvkkyF3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGtNQ20OGece56WCdQBTyWYJGJxcCGwT9noxGTqwFxjomfKsCWnC04R3nRgj4VDvZTPmT43XWor+CnHH5UMPTZMyjcwtil6gQZ/NCb+7JqNTkU3FWF8Ra5yW9JEM3BwXF5b+PUL15Gtvrv/9Z34rtsErTcOajZ5FEG4VCSHw7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkV3d3i7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223748; x=1787759748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jdz8/3k+nF6FEmroHUrpeTplKaGQT5ezughmvkkyF3k=;
  b=kkV3d3i7vXghQeK3Dbl9sxm2PT/+WoB00Rto47HDBktzJPK3Ist3y9Li
   gcY77pZDej6egh3Pfg8wTQkoNoM6wNYs/yCTeDYw6NrIPpfMhmtJyGCOs
   TVo+D3GZonj0CSyS+YQc41049a5FTQjRR2JMDHkV6HGoPnvKyqVCUe5It
   cwkfStWnmpC/LocMEsshwH7N9LBWH9iUs71Hj9iMrlHEhsFQZ5qTaYono
   Hi3UnCMj2BDY93s9VX5CVC/hjI9MW/nY0X/okemQq74arHcjAJyuPrIIE
   K6B98CyPUEnJ+/9dm6GTSsG2wL7z/YppFcaESAOn2td/6LmF/Bx/Ev7dm
   g==;
X-CSE-ConnectionGUID: RqUb1sNqTfGLd9boPnd15g==
X-CSE-MsgGUID: 9ttT1wQIQNWe1QfYIg4zIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108420"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108420"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:39 -0700
X-CSE-ConnectionGUID: 7+PIVcFGTkyaplIK5j643A==
X-CSE-MsgGUID: XqGFmZFKT3+eB8G9RylTxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218257"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: add few missing hcmd/notif names
Date: Tue, 26 Aug 2025 18:54:55 +0300
Message-Id: <20250826184046.badba3cc8be8.Ic8bc3ed4a1b05e80bbbc08636463a22ccbd8568f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

- SEC_KEY_CMD
- REPLY_ERROR
- PHY_CONFIGURATION_CMD
- BT_CONFIG

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 7b46ccc306ab..a6962256bdd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -147,6 +147,7 @@ iwl_mld_construct_fw_runtime(struct iwl_mld *mld, struct iwl_trans *trans,
  */
 static const struct iwl_hcmd_names iwl_mld_legacy_names[] = {
 	HCMD_NAME(UCODE_ALIVE_NTFY),
+	HCMD_NAME(REPLY_ERROR),
 	HCMD_NAME(INIT_COMPLETE_NOTIF),
 	HCMD_NAME(PHY_CONTEXT_CMD),
 	HCMD_NAME(SCAN_CFG_CMD),
@@ -158,12 +159,14 @@ static const struct iwl_hcmd_names iwl_mld_legacy_names[] = {
 	HCMD_NAME(LEDS_CMD),
 	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION),
 	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
+	HCMD_NAME(PHY_CONFIGURATION_CMD),
 	HCMD_NAME(SCAN_OFFLOAD_UPDATE_PROFILES_CMD),
 	HCMD_NAME(POWER_TABLE_CMD),
 	HCMD_NAME(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION),
 	HCMD_NAME(BEACON_NOTIFICATION),
 	HCMD_NAME(BEACON_TEMPLATE_CMD),
 	HCMD_NAME(TX_ANT_CONFIGURATION_CMD),
+	HCMD_NAME(BT_CONFIG),
 	HCMD_NAME(REDUCE_TX_POWER_CMD),
 	HCMD_NAME(MISSED_BEACONS_NOTIFICATION),
 	HCMD_NAME(MAC_PM_POWER_TABLE),
@@ -251,6 +254,7 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(RX_BAID_ALLOCATION_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
+	HCMD_NAME(SEC_KEY_CMD),
 	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
-- 
2.34.1


