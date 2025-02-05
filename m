Return-Path: <linux-wireless+bounces-18537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B7A28B09
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC011881AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3DDF5C;
	Wed,  5 Feb 2025 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDceNejZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618C13B58D
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760201; cv=none; b=utCA5vqtJ3+iNmaK2CiBOw/Kexqhb9od5q7wHeJmZpXf+QKun7UsX1QTcX4hKffO5UIxUvsxPA+iVSx7grWTdl//JAWONbhZXA00YneW+gIEXq9SJOHGzfA9O3RuCqCvtF+NjyNO6mr8mJo1W800q5zEeote1O1xcyliX3x4VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760201; c=relaxed/simple;
	bh=S2xf2wxE9Pe+2kyB9FzOW3H3THYW3Ob3P90N2IEJUGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1BrfbN/lDrrxyO7qlWs2ra8BY3kS1SG6ZragqRBday9MiR5USyV/GSTsPsOwlMV1Al6t0mYxU0UAKB0I7nbTd4IVC8CEnTVAuUcagKG646z1RU4dC4v/5ZG7sT9f4xWjJ3F+Gj2Stuq//0OoqWYfIeM5eY7/Sa7g31LdSKbHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDceNejZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760196; x=1770296196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2xf2wxE9Pe+2kyB9FzOW3H3THYW3Ob3P90N2IEJUGE=;
  b=EDceNejZklv56p41oMmNiprFwOa2WTbaE2vMzDh6hrck+tFnDFQ0gaX8
   PSvme28Oe+gAhNhbt1KtMu9ysOzJGkPBjaVSSsLsTUHcAHWxsBC/Ms49n
   34WLHIYZZ6GvrnrDKQFXvLz3RTm9vbIU1W51b3h0XzLYzZqVYun6qEBFX
   u3i24kU5JmKLyWcVjJR/DJ8UOEYxP6IpU8/FR6+IWXL0Sc9n4zQOkxQTw
   XyfrX6TYXcoRJ9Qc5wqcUhtpsQKSkP3Hk2BU5F8HbsxG/Xmd7DoH0u5di
   W5N+XIziXSB6MhCDOWvIPCTgjUD5riMPJx6WiGK//izCiIUwDdFF7Gk85
   A==;
X-CSE-ConnectionGUID: QnoGUd2dREqtgm5Dg6NfxA==
X-CSE-MsgGUID: tlRyqmHORyiiBouXgoDjdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159226"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159226"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:36 -0800
X-CSE-ConnectionGUID: u+fLaz7uT7GdUfzvu4yZwg==
X-CSE-MsgGUID: DZhblLDMSIeZ5M2inqXWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745504"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 18/19] wifi: iwlwifi: add twt operation cmd
Date: Wed,  5 Feb 2025 14:55:47 +0200
Message-Id: <20250205145347.50a9f7bebe4c.I15ac1361fdab547dbf680a6fa6e88fdc5b177082@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add the firmware API.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 85 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 232e20482e2d..511e86ea11d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -61,6 +61,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @ROC_CMD: &struct iwl_roc_req
 	 */
 	ROC_CMD = 0xE,
+	/**
+	 * @TWT_OPERATION_CMD: &struct iwl_twt_operation_cmd
+	 */
+	TWT_OPERATION_CMD = 0x10,
 	/**
 	 * @MISSED_BEACONS_NOTIF: &struct iwl_missed_beacons_notif
 	 */
@@ -748,4 +752,83 @@ struct iwl_esr_trans_fail_notif {
 	__le32 err_code;
 } __packed; /* ESR_TRANSITION_FAILED_NTFY_API_S_VER_1 */
 
+/*
+ * enum iwl_twt_operation_type: TWT operation in a TWT action frame
+ *
+ * @TWT_OPERATION_REQUEST: TWT Request
+ * @TWT_OPERATION_SUGGEST: TWT Suggest
+ * @TWT_OPERATION_DEMAND: TWT Demand
+ * @TWT_OPERATION_GROUPING: TWT Grouping
+ * @TWT_OPERATION_ACCEPT: TWT Accept
+ * @TWT_OPERATION_ALTERNATE: TWT Alternate
+ * @TWT_OPERATION_DICTATE: TWT Dictate
+ * @TWT_OPERATION_REJECT: TWT Reject
+ * @TWT_OPERATION_TEARDOWN: TWT Teardown
+ * @TWT_OPERATION_UNAVAILABILITY: TWT Unavailability
+ */
+enum iwl_twt_operation_type {
+	TWT_OPERATION_REQUEST,
+	TWT_OPERATION_SUGGEST,
+	TWT_OPERATION_DEMAND,
+	TWT_OPERATION_GROUPING,
+	TWT_OPERATION_ACCEPT,
+	TWT_OPERATION_ALTERNATE,
+	TWT_OPERATION_DICTATE,
+	TWT_OPERATION_REJECT,
+	TWT_OPERATION_TEARDOWN,
+	TWT_OPERATION_UNAVAILABILITY,
+	TWT_OPERATION_MAX,
+}; /* TWT_OPERATION_TYPE_E_VER_1 */
+
+/**
+ * struct iwl_twt_operation_cmd - initiate a TWT session from driver
+ *
+ * @link_id: FW link id to initiate the TWT
+ * @twt_operation: &enum iwl_twt_operation_type
+ * @target_wake_time: TSF time to start the TWT
+ * @interval_exponent: the exponent for the interval
+ * @interval_mantissa: the mantissa for the interval
+ * @minimum_wake_duration: the minimum duration for the wake period
+ * @trigger: is the TWT triggered or not
+ * @flow_type: is the TWT announced (0) or not (1)
+ * @flow_id: the TWT flow identifier 0 - 7
+ * @twt_protection: is the TWT protected
+ * @ndp_paging_indicator: is ndp paging indicator set
+ * @responder_pm_mode: is responder pm mode set
+ * @negotiation_type: if the responder wants to doze outside the TWT SP
+ * @twt_request: 1 for TWT request (STA), 0 for TWT response (AP)
+ * @implicit: is TWT implicit
+ * @twt_group_assignment: the TWT group assignment
+ * @twt_channel: the TWT channel
+ * @restricted_info_present: is this a restricted TWT
+ * @dl_bitmap_valid: is DL (download) bitmap valid (restricted TWT)
+ * @ul_bitmap_valid: is UL (upload) bitmap valid (restricted TWT)
+ * @dl_tid_bitmap: DL TID bitmap (restricted TWT)
+ * @ul_tid_bitmap: UL TID bitmap (restricted TWT)
+ */
+struct iwl_twt_operation_cmd {
+	__le32 link_id;
+	__le32 twt_operation;
+	__le64 target_wake_time;
+	__le32 interval_exponent;
+	__le32 interval_mantissa;
+	__le32 minimum_wake_duration;
+	u8 trigger;
+	u8 flow_type;
+	u8 flow_id;
+	u8 twt_protection;
+	u8 ndp_paging_indicator;
+	u8 responder_pm_mode;
+	u8 negotiation_type;
+	u8 twt_request;
+	u8 implicit;
+	u8 twt_group_assignment;
+	u8 twt_channel;
+	u8 restricted_info_present;
+	u8 dl_bitmap_valid;
+	u8 ul_bitmap_valid;
+	u8 dl_tid_bitmap;
+	u8 ul_tid_bitmap;
+} __packed; /* TWT_OPERATION_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
-- 
2.34.1


