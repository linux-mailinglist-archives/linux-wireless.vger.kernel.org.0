Return-Path: <linux-wireless+bounces-3356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C199F84E5C8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37951C25810
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ABB77F33;
	Thu,  8 Feb 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6xF2kdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017482895
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411560; cv=none; b=lFkXGOMJLpFgmhbZ6jLh4C9xNbIGuDJxwxriKVGGVU3PJT2B7N1XDbyPIKDPvFd+Bp72KtAijflvSZPf6oCr2PwypIQNI3DuiMhTnocJQv+sclZD3EGb8J5lq1E4hoe1fU448n7PkgwWEvPaHO1wCpfimTrcFUS/mCxj9q1DsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411560; c=relaxed/simple;
	bh=jABBgEkssKz0pXoh+uBZvMhxsVwcBwysa0pmID/XuKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pc0MqP1nwoOkoIUq4CCfz8+ncnJIhCC5IGeFfRdxXrjxY4HftdOf4K6VjC9EYWjf+NiJOePL04AIIm4xEkKlVFyfOIXYgqgZN+BSZCp5uiJTZxvrSwvt2nNum9Gyn5/gMNhDFrNi9+1xX+ht9UBL1xlG4nYrRYZNhhp4dxvKb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6xF2kdp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411559; x=1738947559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jABBgEkssKz0pXoh+uBZvMhxsVwcBwysa0pmID/XuKw=;
  b=A6xF2kdpZlDiVOAu2QxflMthBCvWhuCjuC7Mr8zqfAAYtH7SWlPD4yO8
   fhnXTdnxd6wNv0IZF0jhyYRpuWTDzk8Emy2Qp4Pka6DFi82dQXqMP73km
   FnoCUeOrta0SCBIGzU0t3lSXjucNoEhujHxmHbE+YRUTXGEW9HXKHHEJ0
   jpKRaYGGQxh4eO7oAPGo1YBY1tIdGA8qX36k88vpyE2gsS9fJWuHiGx+F
   sLYSaFcMyVJaw0qvjevkLSacaxUje9GcaeBurW5DXGylWj/3XR3KMS0/3
   0EN3kNvNfyn42V24TUTbkNKFEikjB6zXIgX2KThti+A8u9phBT5R6iT1e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404018"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404018"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318866"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/13] wifi: iwlwifi: fw: file: clean up kernel-doc
Date: Thu,  8 Feb 2024 18:58:44 +0200
Message-Id: <20240208185302.c41fddd32c18.I1978ed9aa0484b37504f2bd4614ae0f620821f81@changeid>
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

Add missing kernel-doc and otherwise fix things.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 08d9aeaedd99..f69d29e531c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -216,6 +216,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	ADD_MODIFY_STA_KEY_API_S_VER_2.
  * @IWL_UCODE_TLV_API_STA_TYPE: This ucode supports station type assignement.
  * @IWL_UCODE_TLV_API_NAN2_VER2: This ucode supports NAN API version 2
+ * @IWL_UCODE_TLV_API_ADAPTIVE_DWELL: support for adaptive dwell in scanning
  * @IWL_UCODE_TLV_API_NEW_RX_STATS: should new RX STATISTICS API be used
  * @IWL_UCODE_TLV_API_QUOTA_LOW_LATENCY: Quota command includes a field
  *	indicating low latency direction.
@@ -239,10 +240,15 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	SCAN_OFFLOAD_PROFILES_QUERY_RSP_S.
  * @IWL_UCODE_TLV_API_MBSSID_HE: This ucode supports v2 of
  *	STA_CONTEXT_DOT11AX_API_S
+ * @IWL_UCODE_TLV_API_FTM_RTT_ACCURACY: version 7 of the range response API
+ *	is supported by FW, this indicates the RTT confidence value
  * @IWL_UCODE_TLV_API_SAR_TABLE_VER: This ucode supports different sar
  *	version tables.
  * @IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG: This ucode supports v3 of
- *  SCAN_CONFIG_DB_CMD_API_S.
+ *	SCAN_CONFIG_DB_CMD_API_S.
+ * @IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP: support for setting adaptive dwell
+ *	number of APs in the 5 GHz band
+ * @IWL_UCODE_TLV_API_BAND_IN_RX_DATA: FW reports band number in RX notification
  * @IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX: Firmware offloaded the station disable tx
  *	logic.
  * @IWL_UCODE_TLV_API_INT_DBG_BUF_CLEAR: Firmware supports clearing the debug
@@ -573,6 +579,7 @@ enum iwl_fw_dbg_reg_operator {
  * struct iwl_fw_dbg_reg_op - an operation on a register
  *
  * @op: &enum iwl_fw_dbg_reg_operator
+ * @reserved: reserved
  * @addr: offset of the register
  * @val: value
  */
@@ -619,6 +626,7 @@ struct iwl_fw_dbg_mem_seg_tlv {
  * @version: version of the TLV - currently 0
  * @monitor_mode: &enum iwl_fw_dbg_monitor_mode
  * @size_power: buffer size will be 2^(size_power + 11)
+ * @reserved: reserved
  * @base_reg: addr of the base addr register (PRPH)
  * @end_reg:  addr of the end addr register (PRPH)
  * @write_ptr_reg: the addr of the reg of the write pointer
@@ -729,6 +737,8 @@ enum iwl_fw_dbg_trigger_vif_type {
  * @trig_dis_ms: the time, in milliseconds, after an occurrence of this
  *	trigger in which another occurrence should be ignored.
  * @flags: &enum iwl_fw_dbg_trigger_flags
+ * @reserved: reserved (for alignment)
+ * @data: trigger data
  */
 struct iwl_fw_dbg_trigger_tlv {
 	__le32 id;
@@ -769,7 +779,7 @@ struct iwl_fw_dbg_trigger_missed_bcon {
 
 /**
  * struct iwl_fw_dbg_trigger_cmd - configures trigger for messages from FW.
- * cmds: the list of commands to trigger the collection on
+ * @cmds: the list of commands to trigger the collection on
  */
 struct iwl_fw_dbg_trigger_cmd {
 	struct cmd {
@@ -779,7 +789,7 @@ struct iwl_fw_dbg_trigger_cmd {
 } __packed;
 
 /**
- * iwl_fw_dbg_trigger_stats - configures trigger for statistics
+ * struct iwl_fw_dbg_trigger_stats - configures trigger for statistics
  * @stop_offset: the offset of the value to be monitored
  * @stop_threshold: the threshold above which to collect
  * @start_offset: the offset of the value to be monitored
-- 
2.34.1


