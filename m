Return-Path: <linux-wireless+bounces-8536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A18FC9A7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62301F21CFB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3851922F3;
	Wed,  5 Jun 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkLeDOW4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7914BFB1
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585518; cv=none; b=Oys6gZfG9RBjI3osdO0Ie5J5TlckjBLWd1dBBSD5qcjtB+PcqlG2QmCbwmBvaa1iLq6LP67455UY2DpC+tz2YPqNjkzavxyh9UZ14zsm316THQt5cExV0KVJ7w1FFBqJNW1tDZDgLS3fvTpd6ZeV3g4bjJbVG4qg3Vtyy0V8oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585518; c=relaxed/simple;
	bh=5lucUeIEkTN3Ef2t9/SM6voP1kyYEeH0XICDyFHc5ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scJVruZQKwuzeKmGS8UWHGSjon8b059GfVIuILR8yfVCUS/mAcgIhdojuIF/l7HCM3jmfaCet9WwX/ietQUI0csqASae8xRE6Xi8zyrdqmw4JL4hROWEKU4Ie33oF8Qnl9R2vO43fwFyiTGX6pRNnTyuUneyHJHAqC+0Vbq5BUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkLeDOW4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585517; x=1749121517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lucUeIEkTN3Ef2t9/SM6voP1kyYEeH0XICDyFHc5ow=;
  b=QkLeDOW4v/WGIV6PIZ6jyw47LBJSqJuz+1cCqS1fi0kznGXBWiawgl9p
   ufYfat8iQpnkcDKeB5JxL23U3VHuqDF8hoW4Ch5wCsQNH4ySVs0v1Hjmv
   qZeEJZqS4g1xutxt2smEufnZTK3qV0TwQS90RBF5gJJYayQWfKaK+0R0i
   KDfXNx4KChjREv+kW4ldb0bvbO5buQkUIOeZPdks3nqIJ5UEAPhpZufJi
   PLbTkn5gUVdHSPMh+0HJHYKY66Xtak6LrlVLK3ZcgZCWMWvLEt9K5G10H
   rWVEZblLyLn0cMdF0UoxhPmgEMbCrzZ9Z2gmh816tYCMryuQWDxaxSMg7
   A==;
X-CSE-ConnectionGUID: 2usQTwVkRPKccO2+9pB1+A==
X-CSE-MsgGUID: 109ZQ1OpR2ONN/j+YR1Ccg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402171"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402171"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:16 -0700
X-CSE-ConnectionGUID: tslVYriZRRiBBCK+3R+VSA==
X-CSE-MsgGUID: qqXFPvEHQWmt10m7Q3NR+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997325"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: mvm: remove unneeded debugfs entries
Date: Wed,  5 Jun 2024 14:04:57 +0300
Message-Id: <20240605140327.0c7c520814d5.I19cefb3d81b03a5be94c029cfffd1c8b8c437182@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

These entries are not used, remove them.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  69 +-----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 221 ------------------
 2 files changed, 1 insertion(+), 289 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index bc27e15488f5..b97a43353779 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  * Copyright (C) 2013-2014, 2018-2019 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
@@ -77,73 +77,6 @@ struct iwl_bt_coex_ci_cmd {
 	__le32 secondary_ch_phy_id;
 } __packed; /* BT_CI_MSG_API_S_VER_2 */
 
-#define BT_MBOX(n_dw, _msg, _pos, _nbits)	\
-	BT_MBOX##n_dw##_##_msg##_POS = (_pos),	\
-	BT_MBOX##n_dw##_##_msg = BITS(_nbits) << BT_MBOX##n_dw##_##_msg##_POS
-
-enum iwl_bt_mxbox_dw0 {
-	BT_MBOX(0, LE_SLAVE_LAT, 0, 3),
-	BT_MBOX(0, LE_PROF1, 3, 1),
-	BT_MBOX(0, LE_PROF2, 4, 1),
-	BT_MBOX(0, LE_PROF_OTHER, 5, 1),
-	BT_MBOX(0, CHL_SEQ_N, 8, 4),
-	BT_MBOX(0, INBAND_S, 13, 1),
-	BT_MBOX(0, LE_MIN_RSSI, 16, 4),
-	BT_MBOX(0, LE_SCAN, 20, 1),
-	BT_MBOX(0, LE_ADV, 21, 1),
-	BT_MBOX(0, LE_MAX_TX_POWER, 24, 4),
-	BT_MBOX(0, OPEN_CON_1, 28, 2),
-};
-
-enum iwl_bt_mxbox_dw1 {
-	BT_MBOX(1, BR_MAX_TX_POWER, 0, 4),
-	BT_MBOX(1, IP_SR, 4, 1),
-	BT_MBOX(1, LE_MSTR, 5, 1),
-	BT_MBOX(1, AGGR_TRFC_LD, 8, 6),
-	BT_MBOX(1, MSG_TYPE, 16, 3),
-	BT_MBOX(1, SSN, 19, 2),
-};
-
-enum iwl_bt_mxbox_dw2 {
-	BT_MBOX(2, SNIFF_ACT, 0, 3),
-	BT_MBOX(2, PAG, 3, 1),
-	BT_MBOX(2, INQUIRY, 4, 1),
-	BT_MBOX(2, CONN, 5, 1),
-	BT_MBOX(2, SNIFF_INTERVAL, 8, 5),
-	BT_MBOX(2, DISC, 13, 1),
-	BT_MBOX(2, SCO_TX_ACT, 16, 2),
-	BT_MBOX(2, SCO_RX_ACT, 18, 2),
-	BT_MBOX(2, ESCO_RE_TX, 20, 2),
-	BT_MBOX(2, SCO_DURATION, 24, 6),
-};
-
-enum iwl_bt_mxbox_dw3 {
-	BT_MBOX(3, SCO_STATE, 0, 1),
-	BT_MBOX(3, SNIFF_STATE, 1, 1),
-	BT_MBOX(3, A2DP_STATE, 2, 1),
-	BT_MBOX(3, ACL_STATE, 3, 1),
-	BT_MBOX(3, MSTR_STATE, 4, 1),
-	BT_MBOX(3, OBX_STATE, 5, 1),
-	BT_MBOX(3, A2DP_SRC, 6, 1),
-	BT_MBOX(3, OPEN_CON_2, 8, 2),
-	BT_MBOX(3, TRAFFIC_LOAD, 10, 2),
-	BT_MBOX(3, CHL_SEQN_LSB, 12, 1),
-	BT_MBOX(3, INBAND_P, 13, 1),
-	BT_MBOX(3, MSG_TYPE_2, 16, 3),
-	BT_MBOX(3, SSN_2, 19, 2),
-	BT_MBOX(3, UPDATE_REQUEST, 21, 1),
-};
-
-#define BT_MBOX_MSG(_notif, _num, _field)				     \
-	((le32_to_cpu((_notif)->mbox_msg[(_num)]) & BT_MBOX##_num##_##_field)\
-	>> BT_MBOX##_num##_##_field##_POS)
-
-#define BT_MBOX_PRINT(_num, _field, _end)				    \
-			pos += scnprintf(buf + pos, bufsz - pos,	    \
-					 "\t%s: %d%s",			    \
-					 #_field,			    \
-					 BT_MBOX_MSG(notif, _num, _field),  \
-					 true ? "\n" : ", ")
 enum iwl_bt_activity_grading {
 	BT_OFF			= 0,
 	BT_ON_NO_CONNECTION	= 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2b2b5b76b5ec..010505020659 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -151,37 +151,6 @@ static ssize_t iwl_dbgfs_tx_flush_write(struct iwl_mvm *mvm, char *buf,
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_sta_drain_write(struct iwl_mvm *mvm, char *buf,
-					 size_t count, loff_t *ppos)
-{
-	struct iwl_mvm_sta *mvmsta;
-	int sta_id, drain, ret;
-
-	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
-		return -EIO;
-
-	if (sscanf(buf, "%d %d", &sta_id, &drain) != 2)
-		return -EINVAL;
-	if (sta_id < 0 || sta_id >= mvm->fw->ucode_capa.num_stations)
-		return -EINVAL;
-	if (drain < 0 || drain > 1)
-		return -EINVAL;
-
-	mutex_lock(&mvm->mutex);
-
-	mvmsta = iwl_mvm_sta_from_staid_protected(mvm, sta_id);
-
-	if (!mvmsta)
-		ret = -ENOENT;
-	else
-		ret = iwl_mvm_drain_sta(mvm, mvmsta, drain) ? : count;
-
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
-}
-
 static ssize_t iwl_dbgfs_sram_read(struct file *file, char __user *user_buf,
 				   size_t count, loff_t *ppos)
 {
@@ -568,186 +537,6 @@ static ssize_t iwl_dbgfs_disable_power_off_write(struct iwl_mvm *mvm, char *buf,
 	return ret ?: count;
 }
 
-static
-int iwl_mvm_coex_dump_mbox(struct iwl_bt_coex_profile_notif *notif, char *buf,
-			   int pos, int bufsz)
-{
-	pos += scnprintf(buf+pos, bufsz-pos, "MBOX dw0:\n");
-
-	BT_MBOX_PRINT(0, LE_SLAVE_LAT, false);
-	BT_MBOX_PRINT(0, LE_PROF1, false);
-	BT_MBOX_PRINT(0, LE_PROF2, false);
-	BT_MBOX_PRINT(0, LE_PROF_OTHER, false);
-	BT_MBOX_PRINT(0, CHL_SEQ_N, false);
-	BT_MBOX_PRINT(0, INBAND_S, false);
-	BT_MBOX_PRINT(0, LE_MIN_RSSI, false);
-	BT_MBOX_PRINT(0, LE_SCAN, false);
-	BT_MBOX_PRINT(0, LE_ADV, false);
-	BT_MBOX_PRINT(0, LE_MAX_TX_POWER, false);
-	BT_MBOX_PRINT(0, OPEN_CON_1, true);
-
-	pos += scnprintf(buf+pos, bufsz-pos, "MBOX dw1:\n");
-
-	BT_MBOX_PRINT(1, BR_MAX_TX_POWER, false);
-	BT_MBOX_PRINT(1, IP_SR, false);
-	BT_MBOX_PRINT(1, LE_MSTR, false);
-	BT_MBOX_PRINT(1, AGGR_TRFC_LD, false);
-	BT_MBOX_PRINT(1, MSG_TYPE, false);
-	BT_MBOX_PRINT(1, SSN, true);
-
-	pos += scnprintf(buf+pos, bufsz-pos, "MBOX dw2:\n");
-
-	BT_MBOX_PRINT(2, SNIFF_ACT, false);
-	BT_MBOX_PRINT(2, PAG, false);
-	BT_MBOX_PRINT(2, INQUIRY, false);
-	BT_MBOX_PRINT(2, CONN, false);
-	BT_MBOX_PRINT(2, SNIFF_INTERVAL, false);
-	BT_MBOX_PRINT(2, DISC, false);
-	BT_MBOX_PRINT(2, SCO_TX_ACT, false);
-	BT_MBOX_PRINT(2, SCO_RX_ACT, false);
-	BT_MBOX_PRINT(2, ESCO_RE_TX, false);
-	BT_MBOX_PRINT(2, SCO_DURATION, true);
-
-	pos += scnprintf(buf+pos, bufsz-pos, "MBOX dw3:\n");
-
-	BT_MBOX_PRINT(3, SCO_STATE, false);
-	BT_MBOX_PRINT(3, SNIFF_STATE, false);
-	BT_MBOX_PRINT(3, A2DP_STATE, false);
-	BT_MBOX_PRINT(3, A2DP_SRC, false);
-	BT_MBOX_PRINT(3, ACL_STATE, false);
-	BT_MBOX_PRINT(3, MSTR_STATE, false);
-	BT_MBOX_PRINT(3, OBX_STATE, false);
-	BT_MBOX_PRINT(3, OPEN_CON_2, false);
-	BT_MBOX_PRINT(3, TRAFFIC_LOAD, false);
-	BT_MBOX_PRINT(3, CHL_SEQN_LSB, false);
-	BT_MBOX_PRINT(3, INBAND_P, false);
-	BT_MBOX_PRINT(3, MSG_TYPE_2, false);
-	BT_MBOX_PRINT(3, SSN_2, false);
-	BT_MBOX_PRINT(3, UPDATE_REQUEST, true);
-
-	return pos;
-}
-
-static ssize_t iwl_dbgfs_bt_notif_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	struct iwl_bt_coex_profile_notif *notif = &mvm->last_bt_notif;
-	char *buf;
-	int ret, pos = 0, bufsz = sizeof(char) * 1024;
-
-	buf = kmalloc(bufsz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	mutex_lock(&mvm->mutex);
-
-	pos += iwl_mvm_coex_dump_mbox(notif, buf, pos, bufsz);
-
-	pos += scnprintf(buf + pos, bufsz - pos, "bt_ci_compliance = %d\n",
-			 notif->bt_ci_compliance);
-	pos += scnprintf(buf + pos, bufsz - pos, "primary_ch_lut = %d\n",
-			 le32_to_cpu(notif->primary_ch_lut));
-	pos += scnprintf(buf + pos, bufsz - pos, "secondary_ch_lut = %d\n",
-			 le32_to_cpu(notif->secondary_ch_lut));
-	pos += scnprintf(buf + pos,
-			 bufsz - pos, "bt_activity_grading = %d\n",
-			 le32_to_cpu(notif->bt_activity_grading));
-	pos += scnprintf(buf + pos, bufsz - pos, "bt_rrc = %d\n",
-			 notif->rrc_status & 0xF);
-	pos += scnprintf(buf + pos, bufsz - pos, "bt_ttc = %d\n",
-			 notif->ttc_status & 0xF);
-
-	pos += scnprintf(buf + pos, bufsz - pos, "sync_sco = %d\n",
-			 IWL_MVM_BT_COEX_SYNC2SCO);
-	pos += scnprintf(buf + pos, bufsz - pos, "mplut = %d\n",
-			 IWL_MVM_BT_COEX_MPLUT);
-
-	mutex_unlock(&mvm->mutex);
-
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-	kfree(buf);
-
-	return ret;
-}
-#undef BT_MBOX_PRINT
-
-static ssize_t iwl_dbgfs_bt_cmd_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	struct iwl_bt_coex_ci_cmd *cmd = &mvm->last_bt_ci_cmd;
-	char buf[256];
-	int bufsz = sizeof(buf);
-	int pos = 0;
-
-	mutex_lock(&mvm->mutex);
-
-	pos += scnprintf(buf + pos, bufsz - pos, "Channel inhibition CMD\n");
-	pos += scnprintf(buf + pos, bufsz - pos,
-			 "\tPrimary Channel Bitmap 0x%016llx\n",
-			 le64_to_cpu(cmd->bt_primary_ci));
-	pos += scnprintf(buf + pos, bufsz - pos,
-			 "\tSecondary Channel Bitmap 0x%016llx\n",
-			 le64_to_cpu(cmd->bt_secondary_ci));
-
-	mutex_unlock(&mvm->mutex);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-}
-
-static ssize_t
-iwl_dbgfs_bt_tx_prio_write(struct iwl_mvm *mvm, char *buf,
-			   size_t count, loff_t *ppos)
-{
-	u32 bt_tx_prio;
-
-	if (sscanf(buf, "%u", &bt_tx_prio) != 1)
-		return -EINVAL;
-	if (bt_tx_prio > 4)
-		return -EINVAL;
-
-	mvm->bt_tx_prio = bt_tx_prio;
-
-	return count;
-}
-
-static ssize_t
-iwl_dbgfs_bt_force_ant_write(struct iwl_mvm *mvm, char *buf,
-			     size_t count, loff_t *ppos)
-{
-	static const char * const modes_str[BT_FORCE_ANT_MAX] = {
-		[BT_FORCE_ANT_DIS] = "dis",
-		[BT_FORCE_ANT_AUTO] = "auto",
-		[BT_FORCE_ANT_BT] = "bt",
-		[BT_FORCE_ANT_WIFI] = "wifi",
-	};
-	int ret, bt_force_ant_mode;
-
-	ret = match_string(modes_str, ARRAY_SIZE(modes_str), buf);
-	if (ret < 0)
-		return ret;
-
-	bt_force_ant_mode = ret;
-	ret = 0;
-	mutex_lock(&mvm->mutex);
-	if (mvm->bt_force_ant_mode == bt_force_ant_mode)
-		goto out;
-
-	mvm->bt_force_ant_mode = bt_force_ant_mode;
-	IWL_DEBUG_COEX(mvm, "Force mode: %s\n",
-		       modes_str[mvm->bt_force_ant_mode]);
-
-	if (iwl_mvm_firmware_running(mvm))
-		ret = iwl_mvm_send_bt_init_conf(mvm);
-	else
-		ret = 0;
-
-out:
-	mutex_unlock(&mvm->mutex);
-	return ret ?: count;
-}
-
 static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 				     size_t count, loff_t *ppos)
 {
@@ -2156,15 +1945,12 @@ MVM_DEBUGFS_WRITE_FILE_OPS(stop_ctdp, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(start_ctdp, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(force_ctkill, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(tx_flush, 16);
-MVM_DEBUGFS_WRITE_FILE_OPS(sta_drain, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(send_echo_cmd, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(sram, 64);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(set_nic_temperature, 64);
 MVM_DEBUGFS_READ_FILE_OPS(nic_temp);
 MVM_DEBUGFS_READ_FILE_OPS(stations);
 MVM_DEBUGFS_READ_LINK_STA_FILE_OPS(rs_data);
-MVM_DEBUGFS_READ_FILE_OPS(bt_notif);
-MVM_DEBUGFS_READ_FILE_OPS(bt_cmd);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(disable_power_off, 64);
 MVM_DEBUGFS_READ_FILE_OPS(fw_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(drv_rx_stats);
@@ -2174,8 +1960,6 @@ MVM_DEBUGFS_READ_FILE_OPS(phy_integration_ver);
 MVM_DEBUGFS_READ_FILE_OPS(tas_get_status);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_restart, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_nmi, 10);
-MVM_DEBUGFS_WRITE_FILE_OPS(bt_tx_prio, 10);
-MVM_DEBUGFS_WRITE_FILE_OPS(bt_force_ant, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
@@ -2362,7 +2146,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	spin_lock_init(&mvm->drv_stats_lock);
 
 	MVM_DEBUGFS_ADD_FILE(tx_flush, mvm->debugfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(sta_drain, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(sram, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(set_nic_temperature, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(nic_temp, mvm->debugfs_dir, 0400);
@@ -2371,8 +2154,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(start_ctdp, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(force_ctkill, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(stations, mvm->debugfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(bt_notif, mvm->debugfs_dir, 0400);
-	MVM_DEBUGFS_ADD_FILE(bt_cmd, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(disable_power_off, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_ver, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_rx_stats, mvm->debugfs_dir, 0400);
@@ -2380,8 +2161,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(fw_system_stats, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_restart, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(fw_nmi, mvm->debugfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(bt_tx_prio, mvm->debugfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(bt_force_ant, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(scan_ant_rxchain, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(prph_reg, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_conf, mvm->debugfs_dir, 0600);
-- 
2.34.1


