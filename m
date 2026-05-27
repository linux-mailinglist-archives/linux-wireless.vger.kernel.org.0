Return-Path: <linux-wireless+bounces-37028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAkcGqhOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC05E9E47
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A633303EEA9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E23B4EA7;
	Wed, 27 May 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7+rxDxU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79C3B5F5D
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912334; cv=none; b=Ns+PL/UXkQH0jXLBlh0D0ha+TmpESx3mo0yOhyjTuNZ1O82qodV1W2A0zBeXdCdzHEnCn2+qUFWBdKfNZfM0X21GQfhNrko1FP4EV35lGSyNna3Dov+1NmAdJ98NU4bdbwtSDw3ABx+1xCoY/O7nc4NOPUsSRpdLfY9qVhJIi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912334; c=relaxed/simple;
	bh=N6nXubDXTNiwldxrSAuM/Nql+0aMqz1MgH+8qKMcCVo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hC4GbfpL3TFFxMA24Nj58QmKLHbOimxBMqOCTljbJsROGua9J1fYk8QDmNBHZCm6HGzgDuFmONg4NaEAEt+ae/lAUzLB8fZMWfG0jPwpWO/5XLHA62rdV7jeuoVb6oEokrElcGrstv2YUISTSzc09+ncwvS+2BcZ/ZBMkAQW+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7+rxDxU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912332; x=1811448332;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=N6nXubDXTNiwldxrSAuM/Nql+0aMqz1MgH+8qKMcCVo=;
  b=E7+rxDxUftKf+5fdy6Ro8YN2myhvwo/J+kQVou+40ivqKSk1wrjtspRN
   mfCH/Nvcn4+7mKN4eqVni581wEAAa7MH6T39VH6+yIc3G0uX9CcDfM74/
   76fq7T07FTqcHnpbI7jUWa1jqUbvSV++ruhfGn5onMJuQfZH81GurRsFB
   Xhg9sCoKb+0VTDW1p7WZFiHTZ9vFEUlnHrurKTzD2hruatZjyRtHJG9GN
   uGNvNg6eGQ28PKcjOha4/O2joLIgBHhxN8GzA2Nuu6QgXzQoBNsGTOXYV
   Ybb3hR6JT0KIWqAU1sjgSq+Av2q3YwBx8LPP+3KAgM+VYOkEhdooK+2LV
   g==;
X-CSE-ConnectionGUID: pQ1qP7JRTb6ERBDWdI8R1w==
X-CSE-MsgGUID: pIlsUkaMTM6cCXGKUOPTBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940855"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:32 -0700
X-CSE-ConnectionGUID: qVUwWtB0SF6yxbKapBmbKw==
X-CSE-MsgGUID: HS6f79YVRISjv8goYUJdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286951"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: remove mvm prefix from marker command
Date: Wed, 27 May 2026 23:05:00 +0300
Message-Id: <20260527230313.290e4d9db14a.Ia4edc64dacc8e298ab7817ab5c37843e92698b8d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4EC05E9E47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This command is sent in other opmodes as well. Remove the mvm prefix.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/commands.h |  4 ++--
 .../net/wireless/intel/iwlwifi/fw/api/debug.h    | 16 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c      |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index abd259350589..f76f76e54c4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -466,8 +466,8 @@ enum iwl_legacy_cmds {
 	MCC_CHUB_UPDATE_CMD = 0xc9,
 
 	/**
-	 * @MARKER_CMD: trace marker command, uses &struct iwl_mvm_marker
-	 * with &struct iwl_mvm_marker_rsp
+	 * @MARKER_CMD: trace marker command, uses &struct iwl_marker
+	 * with &struct iwl_marker_rsp
 	 */
 	MARKER_CMD = 0xcb,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 61a850de26fc..382d1c2581ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -262,20 +262,20 @@ struct iwl_mfu_assert_dump_notif {
 } __packed; /* MFU_DUMP_ASSERT_API_S_VER_1 */
 
 /**
- * enum iwl_mvm_marker_id - marker ids
+ * enum iwl_marker_id - marker ids
  *
  * The ids for different type of markers to insert into the usniffer logs
  *
  * @MARKER_ID_TX_FRAME_LATENCY: TX latency marker
  * @MARKER_ID_SYNC_CLOCK: sync FW time and systime
  */
-enum iwl_mvm_marker_id {
+enum iwl_marker_id {
 	MARKER_ID_TX_FRAME_LATENCY = 1,
 	MARKER_ID_SYNC_CLOCK = 2,
 }; /* MARKER_ID_API_E_VER_2 */
 
 /**
- * struct iwl_mvm_marker - mark info into the usniffer logs
+ * struct iwl_marker - mark info into the usniffer logs
  *
  * (MARKER_CMD = 0xcb)
  *
@@ -284,12 +284,12 @@ enum iwl_mvm_marker_id {
  * In the command response the ucode will return the GP2 time.
  *
  * @dw_len: The amount of dwords following this byte including this byte.
- * @marker_id: A unique marker id (iwl_mvm_marker_id).
+ * @marker_id: A unique marker id (iwl_marker_id).
  * @reserved: reserved.
  * @timestamp: in milliseconds since 1970-01-01 00:00:00 UTC
  * @metadata: additional meta data that will be written to the unsiffer log
  */
-struct iwl_mvm_marker {
+struct iwl_marker {
 	u8 dw_len;
 	u8 marker_id;
 	__le16 reserved;
@@ -298,11 +298,11 @@ struct iwl_mvm_marker {
 } __packed; /* MARKER_API_S_VER_1 */
 
 /**
- * struct iwl_mvm_marker_rsp - Response to marker cmd
+ * struct iwl_marker_rsp - Response to marker cmd
  *
  * @gp2: The gp2 clock value in the FW
  */
-struct iwl_mvm_marker_rsp {
+struct iwl_marker_rsp {
 	__le32 gp2;
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 337e312c2f43..6621ef9358bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2383,8 +2383,8 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 
 int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt)
 {
-	struct iwl_mvm_marker marker = {
-		.dw_len = sizeof(struct iwl_mvm_marker) / 4,
+	struct iwl_marker marker = {
+		.dw_len = sizeof(struct iwl_marker) / 4,
 		.marker_id = MARKER_ID_SYNC_CLOCK,
 	};
 	struct iwl_host_cmd hcmd = {
@@ -2392,7 +2392,7 @@ int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt)
 		.id = WIDE_ID(LONG_GROUP, MARKER_CMD),
 		.dataflags = {},
 	};
-	struct iwl_mvm_marker_rsp *resp;
+	struct iwl_marker_rsp *resp;
 	int cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
 					    WIDE_ID(LONG_GROUP, MARKER_CMD),
 					    IWL_FW_CMD_VER_UNKNOWN);
-- 
2.34.1


