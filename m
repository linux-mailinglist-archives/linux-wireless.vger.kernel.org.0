Return-Path: <linux-wireless+bounces-27049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B2B4799D
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAF17D47E
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B361C84A6;
	Sun,  7 Sep 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8bLVAK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DA15853B
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233856; cv=none; b=fF+QxKDjHHZYYrhmua2kOebkUkivEwNqQ9iexeMFL+jzgaZY9pWZno6oBORSeLWFN4/DUYONxVlRoNkMersDPNnynZvG2TPHL8RzYZLMVkeR34ci08YrEKdiaCCgpxhBr6nZvrSVkpeSNmRmiQJuNn0JRwvvov8yrJo9K05bSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233856; c=relaxed/simple;
	bh=MUkj+3AhjcGGLyD5ym+6EyqnFCafMF+yLKLmf6zceMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5Nty7LO8EgwgCjhacUf7xb7bI41fRjjBPergTHItmIqEJM2XzPTuet1l4D4JUEXz4SmtbED6ujj2tDfYwRPjNTHf1iLKpjD6uj2mYit9fjsaXWCEEEegrtZbVV7q4f1xKtNgdVqQst0DpLSmmR5745qnVEMBc57MYacwyNf8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8bLVAK0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233855; x=1788769855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUkj+3AhjcGGLyD5ym+6EyqnFCafMF+yLKLmf6zceMk=;
  b=U8bLVAK0Nb+pfoFI53W9dKvBAA7x0tFLYuoWE8pX0a/SifYbaPxNG5QL
   hesv5Bm+/GKpI3nbu0WJn+cnJ2kzgOxAYW/fuFg6W5Zh6IHjSUpRgDG5J
   SVNHLxUNazI4MXTALqKN4MhXK0sA3ShMnU5Z2WHoxKeXid8emQpe4LCw8
   9Zg+wj18Po98G6HFN6o6F5G5PsNC7gMqvgAjVOA3bXQ7irnTaMbyZE+yu
   e2YdePB8XCUrqLccs7PaeH6Uvfuy7YtsfZoBlLcieP/7Rh2j+/JJezFSK
   TwYtdwO6RjmbrxNy+5A5Cy0LWZq4w/p7YwQDYyl4EsYoSM7+ACEbTIkEX
   Q==;
X-CSE-ConnectionGUID: FqIUAHlaR7Chb4UkukqIFQ==
X-CSE-MsgGUID: 6Imh5OaWRHu7j4ABUB03Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973603"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973603"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:54 -0700
X-CSE-ConnectionGUID: eVYzSkCFQP6HXUoBZS5fLg==
X-CSE-MsgGUID: lsfRToFJSXyN2B256aXjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790018"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: replace SUPPRESS_CMD_ERROR_ONCE status bit with a boolean
Date: Sun,  7 Sep 2025 11:30:01 +0300
Message-Id: <20250907112757.b33366c11a45.I75aac05afd8c4d8ef217d03327c1a027d6e7667e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
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


