Return-Path: <linux-wireless+bounces-16844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC59FDC2C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6641C1881802
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FF38DC8;
	Sat, 28 Dec 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQE1BC7B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4478F5B
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418079; cv=none; b=ITMhvZqE2E4C5u7CvRAMLc/fq7CHRp1JD3CWVI3U9BrrWAvJbv1aBX1HMm4ZIYSX0EZeSqDasyrmjcIntOBijMTdibU+ZUmlmKnXZBqgtf/00uOp+kfI8DVqil9SQoXQBRsAIEnEncuV6PggG2tQANmlfgknqMDYEtmzd/G+91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418079; c=relaxed/simple;
	bh=3bJJU0d6ZdWjYX1AEwzEdxbEnuu1q75GYZCV5jtFEFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIVZpBzNsjAJDsldtFcWpPMHZvV6+mhO1VX8mNE639BAoO93rU5CV+9w/3z4rQ9aVnb6exrLsHE7nd3qJkyUVcuyIwbbquX53i+YmZg+cwzvgvdysuux7A+1Mbl3jedG8uVcoYuJ94dLep5QN+e6LOqZsOgB2nZgWj70jWdsGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQE1BC7B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418077; x=1766954077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bJJU0d6ZdWjYX1AEwzEdxbEnuu1q75GYZCV5jtFEFI=;
  b=TQE1BC7BY1ETfwb6x/+KTvVsJpe51Pt/Xr43SCX4GjPv8Hl22Zca8S/0
   jPtyku2ZIsnGCiopJYznbhyLtk4EksebHsg4LjWYRVE35dUAW9AbBZB07
   OFhbhdnHO58HTJqIBw3ocT3Huw1TioAQdvSI72lWqtJUfLBzyOOZmWQlu
   tTaiEL7VYLfWEISuLQNGEsHHQ4apb11AdletGMR6oVsvC+bh2hoHPzsu5
   I5HUjiLLaOB7uR7S6VRl/raz2K1EAg0O/0tvE1W5PBOWTgKhEccVpu5it
   uop73xHsqxN6HJNblpw3piodMbcQJnFMN9BTPipnxa8eiL2FONVziFf8N
   Q==;
X-CSE-ConnectionGUID: wkOoy8aGTEaDcwkTAK1xYg==
X-CSE-MsgGUID: 1VcFvJtTTn6o5R4sDHf6vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479752"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:37 -0800
X-CSE-ConnectionGUID: f4qnMzlBR2mEV9T5OkVa9Q==
X-CSE-MsgGUID: tVfMtpdERwyGM8YF7ZSeLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488358"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: move fw_ver debugfs to firmware runtime
Date: Sat, 28 Dec 2024 22:34:06 +0200
Message-Id: <20241228223206.98bdc5e62828.Iee7a8365dd63ebf580d324f90e1e04466d8ef5d5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is really where it belongs.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 23 ++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 32 -------------------
 2 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 893b21fcaf87..e79fdb5fe387 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -282,6 +282,26 @@ static ssize_t iwl_dbgfs_fw_dbg_domain_read(struct iwl_fw_runtime *fwrt,
 
 FWRT_DEBUGFS_READ_FILE_OPS(fw_dbg_domain, 20);
 
+static ssize_t iwl_dbgfs_fw_ver_read(struct iwl_fw_runtime *fwrt,
+				     size_t size, char *buf)
+{
+	char *pos = buf;
+	char *endpos = buf + size;
+
+	pos += scnprintf(pos, endpos - pos, "FW id: %s\n",
+			 fwrt->fw->fw_version);
+	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
+			 fwrt->fw->human_readable);
+	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
+			 fwrt->trans->name);
+	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
+			 fwrt->dev->bus->name);
+
+	return pos - buf;
+}
+
+FWRT_DEBUGFS_READ_FILE_OPS(fw_ver, 1024);
+
 struct iwl_dbgfs_fw_info_priv {
 	struct iwl_fw_runtime *fwrt;
 };
@@ -404,4 +424,5 @@ void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(enabled_severities, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0400);
+	FWRT_DEBUGFS_ADD_FILE(fw_ver, dbgfs_dir, 0400);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index b8ae86039045..340f3a026c42 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -538,36 +538,6 @@ static ssize_t iwl_dbgfs_disable_power_off_write(struct iwl_mvm *mvm, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	char *buff, *pos, *endpos;
-	static const size_t bufsz = 1024;
-	int ret;
-
-	buff = kmalloc(bufsz, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-
-	pos = buff;
-	endpos = pos + bufsz;
-
-	pos += scnprintf(pos, endpos - pos, "FW id: %s\n",
-			 mvm->fwrt.fw->fw_version);
-	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
-			 mvm->fwrt.fw->human_readable);
-	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
-			 mvm->fwrt.trans->name);
-	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
-			 mvm->fwrt.dev->bus->name);
-
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
-	kfree(buff);
-
-	return ret;
-}
-
 static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 					     char __user *user_buf,
 					     size_t count, loff_t *ppos)
@@ -1969,7 +1939,6 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(disable_power_off, 64);
 MVM_DEBUGFS_READ_FILE_OPS(fw_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(drv_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(fw_system_stats);
-MVM_DEBUGFS_READ_FILE_OPS(fw_ver);
 MVM_DEBUGFS_READ_FILE_OPS(phy_integration_ver);
 MVM_DEBUGFS_READ_FILE_OPS(tas_get_status);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_restart, 10);
@@ -2169,7 +2138,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(force_ctkill, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(stations, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(disable_power_off, mvm->debugfs_dir, 0600);
-	MVM_DEBUGFS_ADD_FILE(fw_ver, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_rx_stats, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(drv_rx_stats, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_system_stats, mvm->debugfs_dir, 0400);
-- 
2.34.1


