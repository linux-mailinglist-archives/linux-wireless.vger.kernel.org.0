Return-Path: <linux-wireless+bounces-1039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD6819128
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474132871DD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F43B78B;
	Tue, 19 Dec 2023 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPb9mHdw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F033B78E
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015997; x=1734551997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrGbN54njcR2m69EMA/fkaBjiMY+Gxoq776vfAQ7+pc=;
  b=EPb9mHdwqDnIxAqOAiurdpyB6zZfI9Q4IP8s92kkfO2/8Czu711z4lqc
   CN+Y5SA+L7+ZUC0hNbdpY62M+jIT6c+ZIkN6NAOBcOD9kK3Bf2OPWdrJL
   NfJjBTn4LeVNCoT2JWbKtRR4AIcOR77zb6Q1KjDJ9ee7e9XPudBrxs2zK
   ywmEBujHQtpq4V7KeRM+ELhJnQKH6e/heaotC65E3SolgiUOrhBl9dhsD
   ysfbD4TYUFD5ZbBq7ixNSdpu3JbW/8Sk7gv7WJ5AWmkQxHLZsN88bAucg
   2wjahp03sSo2CMH6oWqAJ6YBgK0PWqQ+TnlNn0P3mtlngXD6WNGn0A0yj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694981"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694981"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589152"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589152"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: use the new command to clear the internal buffer
Date: Tue, 19 Dec 2023 21:59:01 +0200
Message-Id: <20231219215605.99aed3efbacb.Ib5bda1d1ff4bae476667737d4081ad066d1d7e6b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware can allow to clear the internal debug buffer. This can be
used to sanitize the data when requested to.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c       | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h      | 4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 7b18e098b125..798731ecbefd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -59,6 +59,12 @@ enum iwl_debug_cmds {
 	 * &struct iwl_dbg_dump_complete_cmd
 	 */
 	FW_DUMP_COMPLETE_CMD = 0xB,
+	/**
+	 * @FW_CLEAR_BUFFER:
+	 * clears the firmware's internal buffer
+	 * no payload
+	 */
+	FW_CLEAR_BUFFER = 0xD,
 	/**
 	 * @MFU_ASSERT_DUMP_NTF:
 	 * &struct iwl_mfu_assert_dump_notif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index f6e399d1e95c..e27774e7ed74 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3401,6 +3401,15 @@ void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt)
 	struct iwl_fw_dbg_params params = {0};
 
 	iwl_fw_dbg_stop_sync(fwrt);
+
+	if (fw_has_api(&fwrt->fw->ucode_capa,
+		       IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR)) {
+		struct iwl_host_cmd hcmd = {
+			.id = WIDE_ID(DEBUG_GROUP, FW_CLEAR_BUFFER),
+		};
+		iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	}
+
 	iwl_dbg_tlv_init_cfg(fwrt);
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index c38e5194c55f..bfc39bd5bbc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -245,6 +245,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *  SCAN_CONFIG_DB_CMD_API_S.
  * @IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX: Firmware offloaded the station disable tx
  *	logic.
+ * @IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR: Firmware supports clearing the debug
+ *	internal buffer
  *
  * @NUM_IWL_UCODE_TLV_API: number of bits used
  */
@@ -282,7 +284,9 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
 	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
 	IWL_UCODE_TLV_API_BAND_IN_RX_DATA	= (__force iwl_ucode_tlv_api_t)59,
+	/* API Set 2 */
 	IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX	= (__force iwl_ucode_tlv_api_t)66,
+	IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR     = (__force iwl_ucode_tlv_api_t)67,
 
 	NUM_IWL_UCODE_TLV_API
 /*
-- 
2.34.1


