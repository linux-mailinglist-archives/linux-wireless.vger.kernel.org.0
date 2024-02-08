Return-Path: <linux-wireless+bounces-3354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450D84E5C4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DF828CEA5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B68823C7;
	Thu,  8 Feb 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB3goD6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150A823D6
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411556; cv=none; b=it8Ch1GpulCjnXu/ZeInr1S9hnXs/KwYLaPtINy2KkSamMCA/HfYLXJKj310igKz2snvu8b24t8YZ2+y9D1x/AYsgAo9Dg0s3pf/baFBJbkN5kKJ+je9JvY21Ets9gPy+g/R+aqOvWjKWMocNqrIvA6Bd11gk+ZPLWkqAZ+TudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411556; c=relaxed/simple;
	bh=vEo+qIEc++oLtEE32J8xksVHe/IXSgahRO3tL8MqXpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1hOg7kjM/7ZAQ08dKbUV2rJ5GQSiJvpjo0xqeg9CcVB0h8QMqMFeJg0XftCIE5LvWejvbT98IJWG05/N6bMfnoQ3T8jDfDbYfyXYzG6RjJU0ok7Ysbo2HcU8Lm+XQbrCFc4REr2DIxk+bDmLGUcURlyaYKGpKPX3MU7USiL6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB3goD6a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411555; x=1738947555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEo+qIEc++oLtEE32J8xksVHe/IXSgahRO3tL8MqXpo=;
  b=RB3goD6alLpHKRziJTZFAFL78TZewtpCthc28zagUTgBQiQzWyGxhieO
   dAgbA/ENH9Mdefh+gQ4SVah0X47a5312fGWxJj4/7bCcEy2fIrSxfce7/
   QCzPHXIvefmIKBGwXYQ/Rw0Lzur3VkGwiUCGhN0XhizboVcEDTUvMn7Y0
   YPnzzTSPagHqboYAPZxPvJOM+DvuQplUW3yQwUJL1nIePkVVzEpGEkKMK
   OE/mtdU0xDWggM9SwGeESOfaKopw7LZLXz/78SK+WiJ8CVsZmYXC3sZHS
   o3uFrUwJzPgzEEnE710gkEHAYS+M51WRvKCx+eZ/hpvxVtk9SfdN8svtf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404006"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318858"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 08/13] wifi: iwlwifi: error-dump: fix kernel-doc issues
Date: Thu,  8 Feb 2024 18:58:42 +0200
Message-Id: <20240208185302.b4706117c97b.I5151b055dcf23ccab3ea7cd7d654aeb621cd5119@changeid>
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

Add missing and rename mismatched kernel-doc descriptions.

Also just remove the unused IWL_FW_ERROR_DUMP_MAX constant.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 06d6f7f66430..5c76e3b94968 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2014, 2018-2024 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -16,7 +16,7 @@
 /**
  * enum iwl_fw_error_dump_type - types of data in the dump file
  * @IWL_FW_ERROR_DUMP_CSR: Control Status Registers - from offset 0
- * @IWL_FW_ERROR_DUMP_RXF:
+ * @IWL_FW_ERROR_DUMP_RXF: RX FIFO contents
  * @IWL_FW_ERROR_DUMP_TXCMD: last TX command data, structured as
  *	&struct iwl_fw_error_dump_txcmd packets
  * @IWL_FW_ERROR_DUMP_DEV_FW_INFO:  struct %iwl_fw_error_dump_info
@@ -24,21 +24,24 @@
  * @IWL_FW_ERROR_DUMP_FW_MONITOR: firmware monitor
  * @IWL_FW_ERROR_DUMP_PRPH: range of periphery registers - there can be several
  *	sections like this in a single file.
+ * @IWL_FW_ERROR_DUMP_TXF: TX FIFO contents
  * @IWL_FW_ERROR_DUMP_FH_REGS: range of FH registers
  * @IWL_FW_ERROR_DUMP_MEM: chunk of memory
  * @IWL_FW_ERROR_DUMP_ERROR_INFO: description of what triggered this dump.
  *	Structured as &struct iwl_fw_error_dump_trigger_desc.
  * @IWL_FW_ERROR_DUMP_RB: the content of an RB structured as
  *	&struct iwl_fw_error_dump_rb
- * @IWL_FW_ERROR_PAGING: UMAC's image memory segments which were
+ * @IWL_FW_ERROR_DUMP_PAGING: UMAC's image memory segments which were
  *	paged to the DRAM.
  * @IWL_FW_ERROR_DUMP_RADIO_REG: Dump the radio registers.
+ * @IWL_FW_ERROR_DUMP_INTERNAL_TXF: internal TX FIFO data
  * @IWL_FW_ERROR_DUMP_EXTERNAL: used only by external code utilities, and
  *	for that reason is not in use in any other place in the Linux Wi-Fi
  *	stack.
  * @IWL_FW_ERROR_DUMP_MEM_CFG: the addresses and sizes of fifos in the smem,
  *	which we get from the fw after ALIVE. The content is structured as
  *	&struct iwl_fw_error_dump_smem_cfg.
+ * @IWL_FW_ERROR_DUMP_D3_DEBUG_DATA: D3 debug data
  */
 enum iwl_fw_error_dump_type {
 	/* 0 is deprecated */
@@ -59,8 +62,6 @@ enum iwl_fw_error_dump_type {
 	IWL_FW_ERROR_DUMP_EXTERNAL = 15, /* Do not move */
 	IWL_FW_ERROR_DUMP_MEM_CFG = 16,
 	IWL_FW_ERROR_DUMP_D3_DEBUG_DATA = 17,
-
-	IWL_FW_ERROR_DUMP_MAX,
 };
 
 /**
@@ -442,7 +443,7 @@ struct iwl_fw_ini_err_table_dump {
  * struct iwl_fw_error_dump_rb - content of an Receive Buffer
  * @index: the index of the Receive Buffer in the Rx queue
  * @rxq: the RB's Rx queue
- * @reserved:
+ * @reserved: reserved
  * @data: the content of the Receive Buffer
  */
 struct iwl_fw_error_dump_rb {
@@ -488,7 +489,7 @@ struct iwl_fw_ini_special_device_memory {
  * struct iwl_fw_error_dump_paging - content of the UMAC's image page
  *	block on DRAM
  * @index: the index of the page block
- * @reserved:
+ * @reserved: reserved
  * @data: the content of the page block
  */
 struct iwl_fw_error_dump_paging {
@@ -511,6 +512,7 @@ iwl_fw_error_next_data(struct iwl_fw_error_dump_data *data)
 /**
  * enum iwl_fw_dbg_trigger - triggers available
  *
+ * @FW_DBG_TRIGGER_INVALID: invalid trigger value
  * @FW_DBG_TRIGGER_USER: trigger log collection by user
  *	This should not be defined as a trigger to the driver, but a value the
  *	driver should set to indicate that the trigger was initiated by the
@@ -530,14 +532,15 @@ iwl_fw_error_next_data(struct iwl_fw_error_dump_data *data)
  * @FW_DBG_TRIGGER_TIME_EVENT: trigger log collection upon time events related
  *	events.
  * @FW_DBG_TRIGGER_BA: trigger log collection upon BlockAck related events.
- * @FW_DBG_TX_LATENCY: trigger log collection when the tx latency goes above a
- *	threshold.
- * @FW_DBG_TDLS: trigger log collection upon TDLS related events.
+ * @FW_DBG_TRIGGER_TX_LATENCY: trigger log collection when the tx latency
+ *	goes above a threshold.
+ * @FW_DBG_TRIGGER_TDLS: trigger log collection upon TDLS related events.
  * @FW_DBG_TRIGGER_TX_STATUS: trigger log collection upon tx status when
  *  the firmware sends a tx reply.
  * @FW_DBG_TRIGGER_ALIVE_TIMEOUT: trigger log collection if alive flow timeouts
  * @FW_DBG_TRIGGER_DRIVER: trigger log collection upon a flow failure
  *	in the driver.
+ * @FW_DBG_TRIGGER_MAX: beyond triggers, number for sizing arrays etc.
  */
 enum iwl_fw_dbg_trigger {
 	FW_DBG_TRIGGER_INVALID = 0,
-- 
2.34.1


