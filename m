Return-Path: <linux-wireless+bounces-2874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C984A8438EC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EBF1F21213
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C267A16;
	Wed, 31 Jan 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnC2pNHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B816773B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689517; cv=none; b=WAsV0tWhLszQI7BpP46mGcAcy8dGVxJExK5q67oHjKCg9K1XQGIhAW+K1YAeTZZKAo0GOYmDJ51aTJfGplFxfh5BXv/RiNdN7KiFSZehD+db1yAqjkbltOqlX2iFAxGY5bilgeaMo/k7epnlrJQvXQ2+T4Z2T/HciITrLL0Gris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689517; c=relaxed/simple;
	bh=bXvUG6xogZ4Krlh5my7Vxx/puMXm2aCVQZmtlQaV7qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBf52BUC89bnJlmwhLXBmnTzKifQpYAwCy0wFIRhiosPR6FA4RBgvTAOydZCbHPgsIozexGnwnteOUvPvCWEWdeciNRL4GmdsgggRLZEXP55mkc1V0F/7Uu7Kgtaw3ULx/4wphi2OEQ+3JomMqNlF9hDp6HOGI8gWCyp0WfM9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnC2pNHm; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689515; x=1738225515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXvUG6xogZ4Krlh5my7Vxx/puMXm2aCVQZmtlQaV7qY=;
  b=cnC2pNHmx+rBn8NpZ3ad8FdrxQ27dVKJQoaFOYTbZbS3CfRqYVDWVgR0
   w7w6n1aNL+/IOQfYr6+8Jd50InF/yWh0liOdHAs9HJROxDhH+/Eroqw0V
   xWC4B6lABiFQQJ+uVeShJmdVGpSHimMMHrMfGGtIO6Wu8lrGqxXIEz1sH
   XbNaj96Af2gL+WxJMMMi9HAF00P77hcmcfaT5nERyV3FjvGsM59aSge/f
   mAlkq8EXu8gZCkwXA9I6e4aII01G2EPr7OxxlE/GHV++x0Nhd9Pgw2O8K
   0HmFDTulP76qV5SMKS9HjonBcukyFFEpvuuwalwtC/mu0KW56kKBjGoOj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249945"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968910"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: small cleanups in PPAG table flows
Date: Wed, 31 Jan 2024 10:24:40 +0200
Message-Id: <20240131091413.48acf340e817.I810e457b80015c1931d96d3e13c849f0339723c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

1. The name of iwl_read_ppag_table is misleading, as this function only
   fills the command structure from the previously read table. Rename it.
2. Don't initialize fwrt::ppag_flags to 0 as the entire fwrt is zeroed
   in the INIT stage anyway.
3. Don't filter out the reserved bits from fwrt::ppag_flags when printing
   it, as it is already done in 'read-from-bios' flow.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  8 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4e638287e9a4..d2689d93da0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -956,7 +956,6 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	int idx = 2;
 	u8 cmd_ver;
 
-	fwrt->ppag_flags = 0;
 	fwrt->ppag_table_valid = false;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_PPAG_METHOD);
@@ -1057,7 +1056,8 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_ppag_table);
 
-int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *cmd,
+int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+			union iwl_ppag_table_cmd *cmd,
 			int *cmd_size)
 {
         u8 cmd_ver;
@@ -1117,7 +1117,7 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
 	/* ppag mode */
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
-			cmd->v1.flags & cpu_to_le32(ACPI_PPAG_MASK));
+			cmd->v1.flags);
 	if ((cmd_ver == 1 && !fw_has_capa(&fwrt->fw->ucode_capa,
 					  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
 	    (cmd_ver == 2 && fwrt->ppag_ver == 2)) {
@@ -1129,7 +1129,7 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
 
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits going to be sent: %d\n",
-			cmd->v1.flags & cpu_to_le32(ACPI_PPAG_MASK));
+			cmd->v1.flags);
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
                 for (j = 0; j < num_sub_bands; j++) {
@@ -1143,7 +1143,7 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
 
 	return 0;
 }
-IWL_EXPORT_SYMBOL(iwl_read_ppag_table);
+IWL_EXPORT_SYMBOL(iwl_fill_ppag_table);
 
 bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 3498deec58a5..ef927d74bc7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -207,7 +207,8 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 
-int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *cmd,
+int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+			union iwl_ppag_table_cmd *cmd,
 			int *cmd_size);
 
 bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
@@ -283,8 +284,9 @@ static inline int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	return -ENOENT;
 }
 
-static inline int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt,
-				    union iwl_ppag_table_cmd *cmd, int *cmd_size)
+static inline int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+				      union iwl_ppag_table_cmd *cmd,
+				      int *cmd_size)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index c2267e0bd08e..d52fc3119972 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1085,7 +1085,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	union iwl_ppag_table_cmd cmd;
 	int ret, cmd_size;
 
-	ret = iwl_read_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
+	ret = iwl_fill_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
 	/* Not supporting PPAG table is a valid scenario */
 	if (ret < 0)
 		return 0;
-- 
2.34.1


