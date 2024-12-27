Return-Path: <linux-wireless+bounces-16830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D579FD1B9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379087A11E0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3014D2B9;
	Fri, 27 Dec 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3OwkdG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC614AD3D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286499; cv=none; b=OcB2vNKHu3VAazmNIA/FAdrKcnIT58BYgnAm9qUVknfasqkntIPfzdF/c9+jdkIsqW25tl8YrE/6sqotSAo60WU7w5Rde+fWLRWDkrOsaCCfUKx32pksMCHudZJCNJkwZh54X1c+R166o4AQ4nAMcc1sR1B2pKfGQD1eCZMJiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286499; c=relaxed/simple;
	bh=5Aob6PSefLellkmKLr0+OnWET7v5npiSOTkOyydEpZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swGNlvmULlubX3riEBuZL1174ktSktX0nLKLwxjMmJ7JRpbbqWLCZRY/rPEUajiRb61JJSJJrlQXWAm9l8h9N29t6UGdHMCvpMyHXNBaCWmxB6Ou14OvVh5OIQy9LIUJYf2aqhO/xej9Ktgb7IyO+7OOKKx454XkHqG6uKxf+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3OwkdG/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286498; x=1766822498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Aob6PSefLellkmKLr0+OnWET7v5npiSOTkOyydEpZs=;
  b=H3OwkdG/7Ne11Lhy9hLUS/8NPWEZmH7snBEOXsDlKDzWTwh6Lfv8AcjK
   e0v6AF2SDZ0o8B/pmsr+kvwV4XKaHKGM37t1xsqfsMf+q3WOvSTvf1Bhw
   CYZSustgR6oijqv3gs2Q8wGQkA01fKBlg4dY4W+88Sp4SsiGb2SwaDpwC
   y1Y6OCdkMQyLapn9w9f8p0LyN8YSgR6DKTcH1nO6nYIhWLValcPuNk/kT
   fS3GZzAP1cSPbmM1b2gs2Mwhbmcd/zCjDTeuTeuNCqb9eLBJrcLVHNHZK
   0S1u5lXw+O9ZJhRoyI8bCfUuZ4DCEqYPmh6bLQA1j5InS2c3RG9qSUzOZ
   g==;
X-CSE-ConnectionGUID: VYgnWFtpS6ixWfApX9XTtQ==
X-CSE-MsgGUID: tjc5o3k4SkKeVje0NDUBLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690948"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:37 -0800
X-CSE-ConnectionGUID: m0dKtUkYSt2uuHusuL+spQ==
X-CSE-MsgGUID: GQYBxsLbSyGmpj5Y1/0Z0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858313"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/17] wifi: iwlwifi: context-info: add kernel-doc markers
Date: Fri, 27 Dec 2024 10:01:03 +0200
Message-Id: <20241227095718.c5c04b641479.I702b8122d307a0d9d09df038cda10be063f7f2d7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These comments have kernel-doc markup and were meant to
be handled as such, add the right /** marker to them.

Add missing entries where needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     | 25 +++++++++-------
 .../wireless/intel/iwlwifi/iwl-context-info.h | 30 ++++++++++++-------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 6b246ec3ff03..cd25a1b9f2ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -86,7 +86,7 @@ enum iwl_prph_scratch_ext_flags {
 	IWL_PRPH_SCRATCH_EXT_URM_PERM	= BIT(5),
 };
 
-/*
+/**
  * struct iwl_prph_scratch_version - version structure
  * @mac_id: SKU and revision id
  * @version: prph scratch information version id
@@ -100,7 +100,7 @@ struct iwl_prph_scratch_version {
 	__le16 reserved;
 } __packed; /* PERIPH_SCRATCH_VERSION_S */
 
-/*
+/**
  * struct iwl_prph_scratch_control - control structure
  * @control_flags: context information flags see &enum iwl_prph_scratch_flags
  * @control_flags_ext: context information for extended flags,
@@ -111,7 +111,7 @@ struct iwl_prph_scratch_control {
 	__le32 control_flags_ext;
 } __packed; /* PERIPH_SCRATCH_CONTROL_S */
 
-/*
+/**
  * struct iwl_prph_scratch_pnvm_cfg - PNVM scratch
  * @pnvm_base_addr: PNVM start address
  * @pnvm_size: the size of the PNVM image in bytes
@@ -131,7 +131,8 @@ struct iwl_prph_scratch_pnvm_cfg {
 struct iwl_prph_scrath_mem_desc_addr_array {
 	__le64 mem_descs[IPC_DRAM_MAP_ENTRY_NUM_MAX];
 } __packed; /* PERIPH_SCRATCH_MEM_DESC_ADDR_ARRAY_S_VER_1 */
-/*
+
+/**
  * struct iwl_prph_scratch_hwm_cfg - hwm config
  * @hwm_base_addr: hwm start address
  * @hwm_size: hwm size in DWs
@@ -143,7 +144,7 @@ struct iwl_prph_scratch_hwm_cfg {
 	__le32 debug_token_config;
 } __packed; /* PERIPH_SCRATCH_HWM_CFG_S */
 
-/*
+/**
  * struct iwl_prph_scratch_rbd_cfg - RBDs configuration
  * @free_rbd_addr: default queue free RB CB base address
  * @reserved: reserved
@@ -153,10 +154,11 @@ struct iwl_prph_scratch_rbd_cfg {
 	__le32 reserved;
 } __packed; /* PERIPH_SCRATCH_RBD_CFG_S */
 
-/*
+/**
  * struct iwl_prph_scratch_uefi_cfg - prph scratch reduce power table
  * @base_addr: reduce power table address
  * @size: the size of the entire power table image
+ * @reserved: (reserved)
  */
 struct iwl_prph_scratch_uefi_cfg {
 	__le64 base_addr;
@@ -164,7 +166,7 @@ struct iwl_prph_scratch_uefi_cfg {
 	__le32 reserved;
 } __packed; /* PERIPH_SCRATCH_UEFI_CFG_S */
 
-/*
+/**
  * struct iwl_prph_scratch_step_cfg - prph scratch step configuration
  * @mbx_addr_0: [0:7] revision,
  *		[8:15] cnvi_to_cnvr length,
@@ -178,13 +180,14 @@ struct iwl_prph_scratch_step_cfg {
 	__le32 mbx_addr_1;
 } __packed;
 
-/*
+/**
  * struct iwl_prph_scratch_ctrl_cfg - prph scratch ctrl and config
  * @version: version information of context info and HW
  * @control: control flags of FH configurations
  * @pnvm_cfg: ror configuration
  * @hwm_cfg: hwm configuration
  * @rbd_cfg: default RX queue configuration
+ * @reduce_power_cfg: UEFI power reduction table
  * @step_cfg: step configuration
  */
 struct iwl_prph_scratch_ctrl_cfg {
@@ -197,7 +200,7 @@ struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_step_cfg step_cfg;
 } __packed; /* PERIPH_SCRATCH_CTRL_CFG_S */
 
-/*
+/**
  * struct iwl_prph_scratch - peripheral scratch mapping
  * @ctrl_cfg: control and configuration of prph scratch
  * @dram: firmware images addresses in DRAM
@@ -213,7 +216,7 @@ struct iwl_prph_scratch {
 	struct iwl_context_info_dram dram;
 } __packed; /* PERIPH_SCRATCH_S */
 
-/*
+/**
  * struct iwl_prph_info - peripheral information
  * @boot_stage_mirror: reflects the value in the Boot Stage CSR register
  * @ipc_status_mirror: reflects the value in the IPC Status CSR register
@@ -227,7 +230,7 @@ struct iwl_prph_info {
 	__le32 reserved;
 } __packed; /* PERIPH_INFO_S */
 
-/*
+/**
  * struct iwl_context_info_gen3 - device INIT configuration
  * @version: version of the context information
  * @size: size of context information in DWs
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 1a1321db137c..7abd153d56f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2022 Intel Corporation
+ * Copyright (C) 2018-2020, 2022, 2024 Intel Corporation
  */
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
@@ -53,11 +53,12 @@ enum iwl_context_info_flags {
 	IWL_CTXT_INFO_RB_SIZE_32K	= 0xe,
 };
 
-/*
+/**
  * struct iwl_context_info_version - version structure
  * @mac_id: SKU and revision id
  * @version: context information version id
  * @size: the size of the context information in DWs
+ * @reserved: (reserved)
  */
 struct iwl_context_info_version {
 	__le16 mac_id;
@@ -66,16 +67,17 @@ struct iwl_context_info_version {
 	__le16 reserved;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_control - version structure
  * @control_flags: context information flags see &enum iwl_context_info_flags
+ * @reserved: (reserved)
  */
 struct iwl_context_info_control {
 	__le32 control_flags;
 	__le32 reserved;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_dram - images DRAM map
  * each entry in the map represents a DRAM chunk of up to 32 KB
  * @umac_img: UMAC image DRAM map
@@ -88,7 +90,7 @@ struct iwl_context_info_dram {
 	__le64 virtual_img[IWL_MAX_DRAM_ENTRY];
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_rbd_cfg - RBDs configuration
  * @free_rbd_addr: default queue free RB CB base address
  * @used_rbd_addr: default queue used RB CB base address
@@ -100,10 +102,11 @@ struct iwl_context_info_rbd_cfg {
 	__le64 status_wr_ptr;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_hcmd_cfg  - command queue configuration
  * @cmd_queue_addr: address of command queue
  * @cmd_queue_size: number of entries
+ * @reserved: (reserved)
  */
 struct iwl_context_info_hcmd_cfg {
 	__le64 cmd_queue_addr;
@@ -111,10 +114,11 @@ struct iwl_context_info_hcmd_cfg {
 	u8 reserved[7];
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_dump_cfg - Core Dump configuration
  * @core_dump_addr: core dump (debug DRAM address) start address
  * @core_dump_size: size, in DWs
+ * @reserved: (reserved)
  */
 struct iwl_context_info_dump_cfg {
 	__le64 core_dump_addr;
@@ -122,10 +126,11 @@ struct iwl_context_info_dump_cfg {
 	__le32 reserved;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_pnvm_cfg - platform NVM data configuration
  * @platform_nvm_addr: Platform NVM data start address
  * @platform_nvm_size: size in DWs
+ * @reserved: (reserved)
  */
 struct iwl_context_info_pnvm_cfg {
 	__le64 platform_nvm_addr;
@@ -133,11 +138,12 @@ struct iwl_context_info_pnvm_cfg {
 	__le32 reserved;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info_early_dbg_cfg - early debug configuration for
  *	dumping DRAM addresses
  * @early_debug_addr: early debug start address
  * @early_debug_size: size in DWs
+ * @reserved: (reserved)
  */
 struct iwl_context_info_early_dbg_cfg {
 	__le64 early_debug_addr;
@@ -145,16 +151,20 @@ struct iwl_context_info_early_dbg_cfg {
 	__le32 reserved;
 } __packed;
 
-/*
+/**
  * struct iwl_context_info - device INIT configuration
  * @version: version information of context info and HW
  * @control: control flags of FH configurations
+ * @reserved0: (reserved)
  * @rbd_cfg: default RX queue configuration
  * @hcmd_cfg: command queue configuration
+ * @reserved1: (reserved)
  * @dump_cfg: core dump data
  * @edbg_cfg: early debug configuration
  * @pnvm_cfg: platform nvm configuration
+ * @reserved2: (reserved)
  * @dram: firmware image addresses in DRAM
+ * @reserved3: (reserved)
  */
 struct iwl_context_info {
 	struct iwl_context_info_version version;
-- 
2.34.1


