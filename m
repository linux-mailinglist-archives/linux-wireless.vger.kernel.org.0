Return-Path: <linux-wireless+bounces-19954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357ACA55958
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22E4189A116
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612627CB0A;
	Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/NnwlPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3B27C86B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298725; cv=none; b=Yy7Y2lpQ92uCy/sgBzN4tv4AKbjsMTfLEoVwAeIbc9+1LVB+MCr70Nv1pazb15a9QDpfBkAZw94+Me5djI86f91s7r5xJqxc8xdwhRNRgH8necKojCvt4matQ+jq11EDsTAn8BVGyjqGeiHPvPx5iTZhOOwgkRHEW3jYlKcrjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298725; c=relaxed/simple;
	bh=sa7vOZzSkawInADUnsvelr4iWp2BgINI7uEkWPmoFzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0onJ9eKtKX3TMEaj0jTkeiILfwO1WJpHZQA/e5dfUnRkNOvynyrTpz0Stdw08ZxDLxVQFafck2t4yWSXCzjlQEJZgCr6zbkMFuqQ5LRux/ID8/CPZ7kryxnC8yRzeEqSbvLCjO9m+vTrPUjLsaIG+lniezpBqs30P1pHZkmPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/NnwlPz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298723; x=1772834723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sa7vOZzSkawInADUnsvelr4iWp2BgINI7uEkWPmoFzE=;
  b=e/NnwlPzJuU8dVTHlFR6zplHpYQYzTQYRf6BCmIxNDVJYM/9MpMLvphn
   72EwOZkSlGkenPM58AuaPdRfvii32HqacwYWLwj3GUM4e9erA2ofKnKRO
   L1oadu7AYPVQwmJ54XtTiBARKlKlcQejyFdiL1pty55W6h7ZWVsMBXdzq
   wyE1a7FYS9sazaE5fJTHY+nSId/OYSGqACLA0OASXS9uUhghzIHM9rfjT
   aqXJ3DajDIHM+c2or8k8dtIqTyZYd3x0GYCYNvEceVCEIcMpNMQYzrV8E
   ZF8gmWXYTEzOPKwaLnsmQEvFOn6XzReOIJ5dLSNycxU73Jo07lJPy90Zd
   A==;
X-CSE-ConnectionGUID: WBSHdTG8RjC8WBwBRBGCeg==
X-CSE-MsgGUID: q58F6GaQQ6Oc+UZPdb7qBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474267"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474267"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:19 -0800
X-CSE-ConnectionGUID: j9PgmF//R42cAb/pxinf5w==
X-CSE-MsgGUID: pvpF9TKFTa6VDbiYKuzPKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061900"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: iwlwifi: fix debug actions order
Date: Fri,  7 Mar 2025 00:04:47 +0200
Message-Id: <20250307000213.39d064dddef4.I40632c48e2a67a8aca05def572a934b88ce7934b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The order of actions taken for debug was implemented incorrectly.
Now we implemented the dump split and do the FW reset only in the
middle of the dump (rather than the FW killing itself on error.)
As a result, some of the actions taken when applying the config
will now crash the device, so we need to fix the order.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 08d990ba8a79..ce787326aa69 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -1372,15 +1372,15 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	switch (tp_id) {
 	case IWL_FW_INI_TIME_POINT_EARLY:
 		iwl_dbg_tlv_init_cfg(fwrt);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_update_drams(fwrt);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
 		iwl_dbg_tlv_apply_buffers(fwrt);
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	case IWL_FW_INI_TIME_POINT_PERIODIC:
 		iwl_dbg_tlv_set_periodic_trigs(fwrt);
@@ -1390,14 +1390,14 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	case IWL_FW_INI_TIME_POINT_MISSED_BEACONS:
 	case IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFICATION:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data,
 				       iwl_dbg_tlv_check_fw_pkt);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		break;
 	}
 }
-- 
2.34.1


