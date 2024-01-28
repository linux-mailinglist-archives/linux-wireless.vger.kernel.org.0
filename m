Return-Path: <linux-wireless+bounces-2610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3983F46D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A5728406C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F55D51E;
	Sun, 28 Jan 2024 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioYlB8/1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDBD2F7
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424883; cv=none; b=NQwe0mYPs7ZgOEixTza+2lMutxdp5CrioT36lAVRmBjnHOip8t6hx/Mq5J5mnUkqSPcjfDbfftAsQFSkEfog2HVnrYpWEccaZxZT7lewiSyoAQV8iudSvXOcxojEHI57Fm/pchu2v6iUJ1bxaC4eItxUFHVMkL7dBVTbc38q++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424883; c=relaxed/simple;
	bh=PbtJSmWlkqukXBm4GctopjfM+UkJoigY8UXRYFxgH5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2sMHMUpwHTY0Ps1dRniZIX5r7NDN9FBLjP/wH+Li/ujWE09EXO0aOEX1Qp7RM9Bigib8abmSuzeZheLwz1mQEngFHxpZstUs9faxWI2SgrPK1efJ+TvhwzGjdaDq6/mU2IC6lGnSdW49RpXXgiffKAA1Np4x+KiBqxsRQyiEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioYlB8/1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424882; x=1737960882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbtJSmWlkqukXBm4GctopjfM+UkJoigY8UXRYFxgH5c=;
  b=ioYlB8/1hv/c5x9UiDLe6zrzUGJbqdeNg1DM0hULxXXuv1O+aRtpN0mD
   L3aMP0OkZtAbA2WLkcreIS1q2Uin9dVVVcBAevnfhNugi4Ra9GZ6Xhu9E
   SOy0GM8GMZYAn7glpEulkKgbGr/7ipqHOdg9baqZ5VowuzN5mtLAx6XEc
   cnay6R5c2ugOdFiZrjUoS6aE129+xyn1Agv5wICNBju8DvnLjllc4+KMh
   GlNco5b8YcKlqsiKhtAcLiKQT1eFjeV7rlC5hqL+v06ZgrwcEra93YPam
   fF3iQtVNwdyN9zu8xOJeiPOjsD80oE4QumWblJ0Ed1cAtBAlvCgnFH3KS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217643"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833346"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: fix some kernel-doc issues
Date: Sun, 28 Jan 2024 08:53:50 +0200
Message-Id: <20240128084842.02ac00f67239.I4ad17097badfcbb82ccdb8c126f61a6f3170798e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add return descriptions, move description contents after
(parameter) sections and fix short descriptions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c       | 15 +++++++++------
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c       |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    |  2 ++
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e27774e7ed74..05e220173fa1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1728,10 +1728,12 @@ iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 /**
  * mask_apply_and_normalize - applies mask on val and normalize the result
  *
- * The normalization is based on the first set bit in the mask
- *
  * @val: value
  * @mask: mask to apply and to normalize with
+ *
+ * The normalization is based on the first set bit in the mask
+ *
+ * Returns: the extracted value
  */
 static u32 mask_apply_and_normalize(u32 val, u32 mask)
 {
@@ -2200,15 +2202,16 @@ struct iwl_dump_ini_mem_ops {
 };
 
 /**
- * iwl_dump_ini_mem
- *
- * Creates a dump tlv and copy a memory region into it.
- * Returns the size of the current dump tlv or 0 if failed
+ * iwl_dump_ini_mem - dump memory region
  *
  * @fwrt: fw runtime struct
  * @list: list to add the dump tlv to
  * @reg_data: memory region
  * @ops: memory dump operations
+ *
+ * Creates a dump tlv and copy a memory region into it.
+ *
+ * Returns: the size of the current dump tlv or 0 if failed
  */
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 			    struct iwl_dump_ini_region_data *reg_data,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index 5aab64c63a13..2b290fab1ef2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -270,7 +270,7 @@ enum iwl_eeprom_enhanced_txpwr_flags {
 };
 
 /**
- * struct iwl_eeprom_enhanced_txpwr
+ * struct iwl_eeprom_enhanced_txpwr - enhanced regulatory TX power limits
  * @flags: entry flags
  * @channel: channel number
  * @chain_a_max: chain a max power in 1/2 dBm
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 871274eea26f..20054a0c7892 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -259,7 +259,7 @@ static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
 }
 
 /**
- * enum iwl_rx_handler_context context for Rx handler
+ * enum iwl_rx_handler_context: context for Rx handler
  * @RX_HANDLER_SYNC : this means that it will be called in the Rx path
  *	which can't acquire mvm->mutex.
  * @RX_HANDLER_ASYNC_LOCKED : If the handler needs to hold mvm->mutex
@@ -279,7 +279,7 @@ enum iwl_rx_handler_context {
 };
 
 /**
- * struct iwl_rx_handlers handler for FW notification
+ * struct iwl_rx_handlers: handler for FW notification
  * @cmd_id: command id
  * @min_size: minimum size to expect for the notification
  * @context: see &iwl_rx_handler_context
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 481d68cbbbd8..a8c4e354e2ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -4161,6 +4161,8 @@ static int rs_drv_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
  * @mvm: The mvm component
  * @mvmsta: The station
  * @enable: Enable Tx protection?
+ *
+ * Returns: an error code
  */
 int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			  bool enable)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 91286018a69d..ab56ff87c6f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -249,6 +249,8 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx)
  * This is the special case in which init is set and we call a callback in
  * this case to clear the state indicating that station creation is in
  * progress.
+ *
+ * Returns: an error code indicating success or failure
  */
 int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
 {
-- 
2.34.1


