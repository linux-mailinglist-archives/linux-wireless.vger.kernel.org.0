Return-Path: <linux-wireless+bounces-16855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AAA9FDC37
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A201614C4
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E916C69F;
	Sat, 28 Dec 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwieGeqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF252199249
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418095; cv=none; b=DbBG3U1Knzy9w0fAFTeTKjrabzePKQJE08nDJMO4n8Z5n1+ZmfLO0S6VEXXqjar8wgEi8fF4y/bu6m0rtKbn3ITrXlOLXZyVnKRIjpewDWDxD4BmgIzr+wq7YpEJXRBn2eOSdd1e2tcB8ADnhgCZDa35fUJa73ENcen0ZtGgGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418095; c=relaxed/simple;
	bh=lGUbBWdPLvKK82hHeko5pq0AbxZmGbzR2K2u47WOZVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D23dg1lkMx9l9E6asFip1A5Upauv9mU8nxX4808qYWXbH7NidMe59/Sq6LvofSkYpQxfXLyVKb06Z3Xa3fvTusirrQl4TgiP35rnltOp9tZ7adoGZl9f0SCRf6XoPx7XFohzTVWwglhuOabmLV7xopbWBdVeDFsBCZaWq4v7C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwieGeqC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418093; x=1766954093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGUbBWdPLvKK82hHeko5pq0AbxZmGbzR2K2u47WOZVg=;
  b=jwieGeqCC2X79i53vFAUlv+m2KtE6XlQ9f3wxYEi/aG9FGQ0UaROs4rF
   sZvC0L1jieBR8+PQorQ531Q4RTPjHGgjYT0zyjVkj/i6vhn5He77Du2As
   ip8I1y5GTR9f4Laez4hieT9vv5Dc/g27Bwk6/fiTQlL2JmArohyoWd8oL
   xmJKlHa+F0qYOqMoyjEWrPgVBn4HZK7SErmyMk2DesX022ejeoLsF3U35
   f/1bL9Bw0PQly8+EPyXsrdxs99vzn0UjtibIxMItFCmSPaePCa+dmjVEb
   xN2gOos1FJPw3nlwAd1hXpSKoNZaVuF+0H6KxfKiY3rlfKPaXX9eF3SXU
   g==;
X-CSE-ConnectionGUID: HLm5ayPFRpGXA+b1zSKQHQ==
X-CSE-MsgGUID: jDPlUQzyQMyqTyJM32s0Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479778"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479778"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:53 -0800
X-CSE-ConnectionGUID: nhj75iZCSNOV0hZSqHn2lA==
X-CSE-MsgGUID: xSDY/vifTF+2hkMF6O0Tig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: move fw_dbg_collect to fw debugfs
Date: Sat, 28 Dec 2024 22:34:17 +0200
Message-Id: <20241228223206.d31f5994c6a6.Ibe3bc7a25e2bbf7a575287e19db58833bb3e6b9e@changeid>
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

This debugfs hook really belongs to the firmware handling code and then
we can use it across different op_modes.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 19 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index e79fdb5fe387..f0c813d675f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -123,6 +123,24 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 #define FWRT_DEBUGFS_ADD_FILE(name, parent, mode) \
 	FWRT_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
 
+static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_fw_runtime *fwrt,
+					      char *buf, size_t count)
+{
+	if (count == 0)
+		return 0;
+
+	if (!iwl_trans_fw_running(fwrt->trans))
+		return count;
+
+	iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_USER_TRIGGER, NULL);
+
+	iwl_fw_dbg_collect(fwrt, FW_DBG_TRIGGER_USER, buf, (count - 1), NULL);
+
+	return count;
+}
+
+FWRT_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 16);
+
 static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
 					      char *buf, size_t count)
 {
@@ -423,6 +441,7 @@ void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 	FWRT_DEBUGFS_ADD_FILE(fw_info, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(enabled_severities, dbgfs_dir, 0200);
+	FWRT_DEBUGFS_ADD_FILE(fw_dbg_collect, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0400);
 	FWRT_DEBUGFS_ADD_FILE(fw_ver, dbgfs_dir, 0400);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 340f3a026c42..2472a78ada47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1470,22 +1470,6 @@ static ssize_t iwl_dbgfs_fw_dbg_conf_write(struct iwl_mvm *mvm,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_mvm *mvm,
-					      char *buf, size_t count,
-					      loff_t *ppos)
-{
-	if (count == 0)
-		return 0;
-
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_USER_TRIGGER,
-			       NULL);
-
-	iwl_fw_dbg_collect(&mvm->fwrt, FW_DBG_TRIGGER_USER, buf,
-			   (count - 1), NULL);
-
-	return count;
-}
-
 static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
 					    char *buf, size_t count,
 					    loff_t *ppos)
@@ -1945,7 +1929,6 @@ MVM_DEBUGFS_WRITE_FILE_OPS(fw_restart, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_nmi, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
-MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_clear, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(dbg_time_point, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(indirection_tbl,
@@ -2146,7 +2129,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(scan_ant_rxchain, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(prph_reg, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_conf, mvm->debugfs_dir, 0600);
-	MVM_DEBUGFS_ADD_FILE(fw_dbg_collect, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_clear, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(dbg_time_point, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(send_echo_cmd, mvm->debugfs_dir, 0200);
-- 
2.34.1


