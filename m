Return-Path: <linux-wireless+bounces-7465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A868C265D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B302B229E4
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44261171658;
	Fri, 10 May 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZzLyMvn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99725171647
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350023; cv=none; b=YPFbBHmwoqMVbiQ0EkqC/ixfJcU81WD9SqerCWkhGB64juZbB+Nd5HaRIX1mO5tVLvT8g+J8x/hfvLnYdA9PG5sgh+pPMqUzkDt1nOFPi2eDgFJQiVhb/hzlHPzSFPuEcocchzSieWpR0y8yxXV9HLt6OarAigFQzM9dp8HUQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350023; c=relaxed/simple;
	bh=HLO4ork3cmWOwA7GjcrT6kbZJEj1EJFIFeB0r1RV3Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO4aIbEEbIJuRf4ONNsFHeFVcem4MBolWdYHsr1wyRkfd3oycUgzyzfHiYaqCl26N+gFIY2iANyXw+qLzrmQgS4iZA3TPMs4fH/sBc1UVW5s8Sg4KcouvXMOUuyCTsjYlBiFlPhEKuJ3XOlzWhSBc9wVnrM/kBlZqskfRtFy/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZzLyMvn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350021; x=1746886021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HLO4ork3cmWOwA7GjcrT6kbZJEj1EJFIFeB0r1RV3Zk=;
  b=iZzLyMvnBxl6c3sRqUZ3w19FBDdQs6atl3vSpTsaxkeNGgPGrj4a4Zam
   ACjcZtXfNWHBi8bt+TYP33+f7WYFnxGRumfnELT965lFXTbAULVAsz1kR
   3T8yfnTsDNKgWf2HTbMjs/aWRNicG581PCh5hENUvtROo02baXoxIpXGo
   FdwDAPEJP/mg6LZw887W2LjcVJkKusA9kmgQzR05w6uFfKRBRUSOPZojY
   NRqmo4bbYrHwShNYiaWjbAWA7c2XJNZ47b92aEcnq7dxu4wDmlmAQG1uT
   sLR4HfOzGSWnXTsTBjQWt0zJui/A2LkCfvjmhgsW1ibpdbGXI6g5er/JJ
   w==;
X-CSE-ConnectionGUID: fsvXNz9DTrifwQw6pFpv/A==
X-CSE-MsgGUID: UPP8BL+pRE6pKq3DTiKeTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125547"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:01 -0700
X-CSE-ConnectionGUID: VxA7qhgvT4e4whPhEuBlOA==
X-CSE-MsgGUID: R0B5vv85Qn+8V4JH16LuXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101854"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time
Date: Fri, 10 May 2024 17:06:32 +0300
Message-Id: <20240510170500.b8d17a9c1731.I57c33574a61edd68bd0ec1aa7009f31111fd7efe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add an entry for setting the maximum TXOP time in microseconds.
The configured value can be read from the same entry.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 38 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  3 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 17c97dfbc62a..25f07e00db42 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -692,6 +692,42 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
+static ssize_t iwl_dbgfs_max_tx_op_write(struct ieee80211_vif *vif, char *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	u16 value;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mvm->mutex);
+	mvmvif->max_tx_op = value;
+	mutex_unlock(&mvm->mutex);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_max_tx_op_read(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct ieee80211_vif *vif = file->private_data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	char buf[10];
+	int len;
+
+	mutex_lock(&mvm->mutex);
+	len = scnprintf(buf, sizeof(buf), "%hu\n", mvmvif->max_tx_op);
+	mutex_unlock(&mvm->mutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
 static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
 					    char *buf, size_t count,
 					    loff_t *ppos)
@@ -801,6 +837,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(uapsd_misbehaving, 20);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
+MVM_DEBUGFS_READ_WRITE_FILE_OPS(max_tx_op, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(esr_disable_reason, 32);
 
@@ -830,6 +867,7 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(rx_phyinfo, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(quota_min, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(os_device_timediff, mvmvif->dbgfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE_VIF(max_tx_op, mvmvif->dbgfs_dir, 0600);
 	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
 			    &mvmvif->ftm_unprotected);
 	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1f58c727fa63..ca1c5944da67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -426,6 +426,7 @@ struct iwl_mvm_esr_exit {
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @csa_blocks_tx: CSA is blocking TX
  * @features: hw features active for this vif
+ * @max_tx_op: max TXOP in usecs for all ACs, zero for no limit.
  * @ap_beacon_time: AP beacon time for synchronisation (on older FW)
  * @bf_enabled: indicates if beacon filtering is enabled
  * @ba_enabled: indicated if beacon abort is enabled
@@ -538,6 +539,8 @@ struct iwl_mvm_vif {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
 
+	u16 max_tx_op;
+
 	u16 link_selection_res;
 	u8 link_selection_primary;
 	u8 primary_link;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 3ba62fb2c85e..884fd56e7426 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -609,6 +609,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 				cpu_to_le16(max_amsdu_len) : 0,
 	};
 	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
 	int cmd_ver;
 	int ret;
 
@@ -654,6 +655,8 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 */
 	sta->deflink.agg.max_amsdu_len = max_amsdu_len;
 
+	cfg_cmd.max_tx_op = cpu_to_le16(mvmvif->max_tx_op);
+
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0);
 	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, sta_id=%d, max_ch_width=%d, mode=%d\n",
 		       cfg_cmd.sta_id, cfg_cmd.max_ch_width, cfg_cmd.mode);
-- 
2.34.1


