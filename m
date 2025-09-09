Return-Path: <linux-wireless+bounces-27121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF16B49FF0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5086E4E0820
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF02701D8;
	Tue,  9 Sep 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL33VWvu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAA26F467
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388120; cv=none; b=FJG/bNZdcYa1jxVCi/opDcDtoaxXzhDFpM2Td6om6RTM4diKM60VMXe0QPLgcTEjYw5cqnq0ocnlgO0GC9NHRkGXSpJti1qR1MdnK5h+SupMje/vUMPDE4SK75cR2tqF10TQgf0xAcxhghWtcnk1+hZz6xJVQcJZVQ5f0sJHTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388120; c=relaxed/simple;
	bh=MUkj+3AhjcGGLyD5ym+6EyqnFCafMF+yLKLmf6zceMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XV8AWteO2//GdCSjr4wK65kgNHhQis8ucJO32CE0GRTBce3pnkLI+BxfXw0Cm/wO2f4E9+axvrcSSPvHLmCgnW9og+alhwq5Au1+mcLUG+GoA+9lOX6T8/0ywzUQ5WGXEAvPzY9kMfiEJ9oV4Im444Kn+KXQykISJUT7sDAq7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL33VWvu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388118; x=1788924118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUkj+3AhjcGGLyD5ym+6EyqnFCafMF+yLKLmf6zceMk=;
  b=aL33VWvuK6xKd81Xw0GMCNwJxjzihYvs4O/skAzf+6+hKlCa/khPtdK1
   /g2lhbp48R4wKDWcqaFlLQcUUzV1f2WASKFKVwT37YFrKq8a7IVzYMZbm
   WHWowiupffaRaGJ6XPI6yxE69vtozEQ5RocMf87PvuUZGYDkLt9j9yT58
   AYngEkqLd8IcrzPsa5O9uNGdjXWBcAX3LorUEakshphq9is8UzbdU3Gml
   1W6elSASoIWwSrLmlmlH0vyndo3rs0apNmN6GcUcKh79Xyh1MbcGvcSil
   3Z0IZmxcw8aGfIaLC68UEBEFw/ThZcPvUOOFx9Y5ASqEYGhgYyI1lo11+
   A==;
X-CSE-ConnectionGUID: aj5IaYlpRIqLLNdxFXLkjg==
X-CSE-MsgGUID: d7wQHDsBTUyBmTeEm0RD3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281053"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:58 -0700
X-CSE-ConnectionGUID: CrQaHKR9TF+ApiuGuQYz+w==
X-CSE-MsgGUID: CSBmp1hLR82sUr2GmPG2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950294"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH v2 iwlwifi-next 02/15] wifi: iwlwifi: replace SUPPRESS_CMD_ERROR_ONCE status bit with a boolean
Date: Tue,  9 Sep 2025 06:21:15 +0300
Message-Id: <20250909061931.b33366c11a45.I75aac05afd8c4d8ef217d03327c1a027d6e7667e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Convert STATUS_SUPPRESS_CMD_ERROR_ONCE from a status bit to a simple
bool field in struct iwl_trans, as atomicity is not needed.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h      | 11 +++--------
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c |  5 +++--
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b9e41b8e2f15..3d5b47aaa4dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -284,8 +284,6 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
  * @STATUS_RFKILL_OPMODE: RF-kill state reported to opmode
  * @STATUS_FW_ERROR: the fw is in error state
  * @STATUS_TRANS_DEAD: trans is dead - avoid any read/write operation
- * @STATUS_SUPPRESS_CMD_ERROR_ONCE: suppress "FW error in SYNC CMD" once,
- *	e.g. for testing
  * @STATUS_IN_SW_RESET: device is undergoing reset, cleared by opmode
  *	via iwl_trans_finish_sw_reset()
  * @STATUS_RESET_PENDING: reset worker was scheduled, but didn't dump
@@ -302,7 +300,6 @@ enum iwl_trans_status {
 	STATUS_RFKILL_OPMODE,
 	STATUS_FW_ERROR,
 	STATUS_TRANS_DEAD,
-	STATUS_SUPPRESS_CMD_ERROR_ONCE,
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
 	STATUS_TRANS_RESET_IN_PROGRESS,
@@ -849,6 +846,8 @@ struct iwl_trans_info {
  * @pnvm_loaded: indicates PNVM was loaded
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
+ * @suppress_cmd_error_once: suppress "FW error in SYNC CMD" once,
+ *	e.g. for testing
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
  * @reduce_power_loaded: indicates reduced power section was loaded
  * @failed_to_load_reduce_power_image: set to true if pnvm loading failed
@@ -883,6 +882,7 @@ struct iwl_trans {
 	const struct iwl_trans_info info;
 	bool reduced_cap_sku;
 	bool step_urm;
+	bool suppress_cmd_error_once;
 
 	bool pm_support;
 	bool ltr_enabled;
@@ -1194,11 +1194,6 @@ static inline u16 iwl_trans_get_num_rbds(struct iwl_trans *trans)
 	return result;
 }
 
-static inline void iwl_trans_suppress_cmd_error_once(struct iwl_trans *trans)
-{
-	set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &trans->status);
-}
-
 static inline bool iwl_trans_device_enabled(struct iwl_trans *trans)
 {
 	return test_bit(STATUS_DEVICE_ENABLED, &trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 372204bf8452..b9c9cd3f44e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -86,7 +86,7 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mld *mld, char *buf,
 
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		mld->fw_status.do_not_dump_once = true;
-		iwl_trans_suppress_cmd_error_once(mld->trans);
+		mld->trans->suppress_cmd_error_once = true;
 	}
 
 	/* take the return value to make compiler happy - it will
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 289a0db1f91f..683c0ba5fb39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1134,7 +1134,7 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
-		iwl_trans_suppress_cmd_error_once(mvm->trans);
+		mvm->trans->suppress_cmd_error_once = true;
 	}
 
 	/* take the return value to make compiler happy - it will fail anyway */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 84a05cc1c27a..24f1849d9eac 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -2601,8 +2601,9 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 	}
 
 	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		if (!test_and_clear_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE,
-					&trans->status)) {
+		if (trans->suppress_cmd_error_once) {
+			trans->suppress_cmd_error_once = false;
+		} else {
 			IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
 			dump_stack();
 		}
-- 
2.34.1


