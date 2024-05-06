Return-Path: <linux-wireless+bounces-7202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D918BC802
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3312FB21212
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84E140395;
	Mon,  6 May 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhGMvMKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46725136E3B
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979079; cv=none; b=gINXho/T3QYsOCwkAYsske4vFfHASoyR7eU7UUt3BxbC67OBwUQTWMY2eDX8d+Bz6rYohi5MsxVYFxRsGMjaTQ+h/e4VXo6INKGQ8NjZ+5rgjhG7mSXZPVxzhE9qPw877eJcPxh1/WbPU7hlr/7mbzRz92/Ye1rGAZpxWYYy8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979079; c=relaxed/simple;
	bh=HFj3x3fBA4CPZUDwNEnBz8uTrLXThsh+3Yb3h+yY/O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8t4S+TWUabKxZl4pyJCJVbH5kI11HADYz1Ixs0hyq9iU+8LfpbP3Z43p+/A/qXCKTYkmdPONcl47n5TCxHJp/2GJchw7wChBabyTnvEgtkhdoIdMGpZWxMWqxnst1cwaGkhfzKWeXOVt4FYDmJxATHkQPDiEQylJuw5cWYloPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhGMvMKb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979079; x=1746515079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HFj3x3fBA4CPZUDwNEnBz8uTrLXThsh+3Yb3h+yY/O8=;
  b=XhGMvMKbuPMYt3hhzoVEPIHJUrFZWFyMbUb7VpiTZ/Z2quksp4aFvs8J
   Z39w01Mtsr+pTFAkFo2pUinVbKkonRnrp+x2JjADFTsfEwmpewN+gxggC
   6W0xAFp+fCo3lMvKnUHtq3ECQ9/O4FWdijNpoAWB/DEx4umCeHD3/Dbhd
   pc4urNkv4xerBBoCwstIItMaJDBPeM/Xe1y0yZ7qU896wh6GnJssJZG5l
   BWNpio6beyVFro2qwoj6iSl5ys5KYF4pStbtEwtYoB0xyVkEb1N89TbCh
   QKN6x9PGiKUYiQOYUrIlDP/SK671KpWAOikfmRcMI594+u5HPbeRj+wmw
   Q==;
X-CSE-ConnectionGUID: 4HrTEQ+gQ6iYg8Q08KeqyA==
X-CSE-MsgGUID: HgVeScmqQSCnMzNPvCUrkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638180"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:38 -0700
X-CSE-ConnectionGUID: J/P14oKwTdmlQbf6+O7fNw==
X-CSE-MsgGUID: MAExFwNETn6NzxppqhNTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264908"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: add a debugfs for reading EMLSR blocking reasons
Date: Mon,  6 May 2024 10:04:09 +0300
Message-Id: <20240506095953.6d494a335e81.Ic0fa6a9636e3c1a3b1420e85e704a19d4a56e8d9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Add a reading for all active EMLSR blocking reasons for testing
purposes.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 41 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 213de638f132..17c97dfbc62a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -722,8 +722,41 @@ static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_block_esr_write(struct ieee80211_vif *vif, char *buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_esr_disable_reason_read(struct file *file,
+						 char __user *user_buf,
+						 size_t count, loff_t *ppos)
+{
+	struct ieee80211_vif *vif = file->private_data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	unsigned long esr_mask;
+	char *buf;
+	int bufsz, pos, i;
+	ssize_t rv;
+
+	mutex_lock(&mvm->mutex);
+	esr_mask = mvmvif->esr_disable_reason;
+	mutex_unlock(&mvm->mutex);
+
+	bufsz = hweight32(esr_mask) * 32 + 40;
+	buf = kmalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos = scnprintf(buf, bufsz, "EMLSR state: '0x%lx'\nreasons:\n",
+			esr_mask);
+	for_each_set_bit(i, &esr_mask, BITS_PER_LONG)
+		pos += scnprintf(buf + pos, bufsz - pos, " - %s\n",
+				 iwl_get_esr_state_string(BIT(i)));
+
+	rv = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	kfree(buf);
+	return rv;
+}
+
+static ssize_t iwl_dbgfs_esr_disable_reason_write(struct ieee80211_vif *vif,
+						  char *buf, size_t count,
+						  loff_t *ppos)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
@@ -769,7 +802,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
 MVM_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
-MVM_DEBUGFS_WRITE_FILE_OPS(block_esr, 32);
+MVM_DEBUGFS_READ_WRITE_FILE_OPS(esr_disable_reason, 32);
 
 void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -800,7 +833,7 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
 			    &mvmvif->ftm_unprotected);
 	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE_VIF(block_esr, mvmvif->dbgfs_dir, 0600);
+	MVM_DEBUGFS_ADD_FILE_VIF(esr_disable_reason, mvmvif->dbgfs_dir, 0600);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 5c17120dcc2a..21b5cc0413fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -22,7 +22,7 @@ static const char *const iwl_mvm_esr_states_names[] = {
 	HANDLE_ESR_REASONS(NAME_ENTRY)
 };
 
-static const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state)
+const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state)
 {
 	int offs = ilog2(state);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 56467b9de7f1..cb4088149d85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -385,6 +385,8 @@ enum iwl_mvm_esr_state {
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
 
+const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state);
+
 /**
  * struct iwl_mvm_esr_exit - details of the last exit from EMLSR mode.
  * @reason: The reason for the last exit from EMLSR.
-- 
2.34.1


