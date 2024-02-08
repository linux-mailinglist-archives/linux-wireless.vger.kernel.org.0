Return-Path: <linux-wireless+bounces-3355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDF84E5C6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0711F2765A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258C7EEE9;
	Thu,  8 Feb 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1muGTL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A9823DE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411558; cv=none; b=UuO1KKVVDO9Ekw1tZRUjKeuQ0w0NE7U7n4br5vcmWz46NzHZzax9eZ0A8KAT8do/NLYSKdtdmVD2hLn4xT90slDUPXweOomeA2B/KjVMoU21i+usCqAXlVzAwo5OXyn7GmkmrGIGUx/4xqcwy6uVW+fwqv93l6gwele9iiClDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411558; c=relaxed/simple;
	bh=QWvjVn87YkGkuVxPkSh/yDL87T0YfKDpn63nGOZOggc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gnn93qAm56K07GY9KIS7aMxyfNGyi0mCLCo6En580jjHZgBNkYrLP9FDp0FfBusGyJ3vGokuLSF+mjytKGZUSAC3Pqn5+Aa6XJOF8tFCFufL1p4DILwNcGCUrdCKJQIvseMjEw6eYNDb62Aux9rqzR1G6H3ur5xw/hF85Gzer+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1muGTL1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411557; x=1738947557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QWvjVn87YkGkuVxPkSh/yDL87T0YfKDpn63nGOZOggc=;
  b=X1muGTL1qif9+yfqRNaABzKbK6Y+GXeSKfQWqoObu8rh0s4jCiVfYP/7
   fO5vJhYxf2hVImz8bVOW/M8CYDOveJEo7TzsWZw91m5KTRZDZFJ0jCxZY
   Tich9SJyhgl2fwKtk8qJWHO+8VCBPd6qQ9CpTObXWgm1pNggM4Y3fpB2X
   7CgSDZe197hE+MTVT++0RuzxvTFQG3Wy6cybm3KIxZMMv1jihZa5MLT+b
   ZuIdEijaUS5sI137XU9WwuNLw6tP6KQWXWg0BDC4nm/srS5okLpztRlD+
   UFg02JeKUwHyVsamFQSwEiu5m0H9Qvlpa3qTxurJqOVpzOnxl6vcT3B2U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404013"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318861"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/13] wifi: iwlwifi: api: dbg-tlv: fix up kernel-doc
Date: Thu,  8 Feb 2024 18:58:43 +0200
Message-Id: <20240208185302.895a2daa0e17.I4d4bdc4ebaf4bfef113a7e6c83848f5a4fb52977@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some things are misnamed or missing, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 394747deb269..47c914de2992 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __iwl_fw_dbg_tlv_h__
 #define __iwl_fw_dbg_tlv_h__
@@ -319,7 +319,7 @@ struct iwl_fw_ini_conf_set_tlv {
  * @IWL_FW_INI_CONFIG_SET_TYPE_CSR: for CSR configuration
  * @IWL_FW_INI_CONFIG_SET_TYPE_DBGC_DRAM_ADDR: for DBGC_DRAM_ADDR configuration
  * @IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM: for PERIPH SCRATCH HWM configuration
- * @IWL_FW_INI_ALLOCATION_NUM: max number of configuration supported
+ * @IWL_FW_INI_CONFIG_SET_TYPE_MAX_NUM: max number of configuration supported
 */
 
 enum iwl_fw_ini_config_set_type {
@@ -360,6 +360,7 @@ enum iwl_fw_ini_allocation_id {
  * @IWL_FW_INI_LOCATION_SRAM_PATH: SRAM location
  * @IWL_FW_INI_LOCATION_DRAM_PATH: DRAM location
  * @IWL_FW_INI_LOCATION_NPK_PATH: NPK location
+ * @IWL_FW_INI_LOCATION_NUM: number of valid locations
  */
 enum iwl_fw_ini_buffer_location {
 	IWL_FW_INI_LOCATION_INVALID,
@@ -439,6 +440,7 @@ enum iwl_fw_ini_region_device_memory_subtype {
  * Hard coded time points in which the driver can send hcmd or perform dump
  * collection
  *
+ * @IWL_FW_INI_TIME_POINT_INVALID: invalid timepoint
  * @IWL_FW_INI_TIME_POINT_EARLY: pre loading the FW
  * @IWL_FW_INI_TIME_POINT_AFTER_ALIVE: first cmd from host after alive notif
  * @IWL_FW_INI_TIME_POINT_POST_INIT: last cmd in series of init sequence
@@ -553,7 +555,7 @@ enum iwl_fw_ini_dump_policy {
  * enum iwl_fw_ini_dump_type - Determines dump type based on size defined by FW.
  *
  * @IWL_FW_INI_DUMP_BRIEF : only dump the most important regions
- * @IWL_FW_INI_DEBUG_MEDIUM: dump more regions than "brief", but not all regions
+ * @IWL_FW_INI_DUMP_MEDIUM: dump more regions than "brief", but not all regions
  * @IWL_FW_INI_DUMP_VERBOSE : dump all regions
  */
 enum iwl_fw_ini_dump_type {
-- 
2.34.1


