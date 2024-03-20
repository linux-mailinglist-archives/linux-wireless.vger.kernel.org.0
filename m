Return-Path: <linux-wireless+bounces-5050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9788190F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B1AB21185
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F885C43;
	Wed, 20 Mar 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ1FpEku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FE8613B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970026; cv=none; b=Hl8JtCzp9jTaVFSM++phyaO2ZTMoT5PAUwIxc7Rp23p6tVt59KEKPZ7HDn8qqVM2Jp3ZQATXCK39XFgP/aiu8YMigl/2ZvdSWQ610XBUn2we0+u4K91bgdi3OLEF5IJetnxVlR+OFFJ7v3bAxbbVOHU5Mx0mHMeNcp6lRoTUq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970026; c=relaxed/simple;
	bh=eKPpc4fkC7pSa4FVrpRGRWPnVe/nMvd+mpKIHaC68Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huuXkkTqzTGbdcp/kKnbUFmc2Nh61Fva0iG+1rLen/P3r4VtjBIWiig097Lwb9kwEi9EqugIQHSeCmqv9aL2NP66hErtju7/YUYENs/BrgZim6gAYLkPsq0zKcAi8On0EwwMPp+TSp6IPaqn7P+XPx7F9DuGlEAtpm+m73lwcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ1FpEku; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970023; x=1742506023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKPpc4fkC7pSa4FVrpRGRWPnVe/nMvd+mpKIHaC68Os=;
  b=OZ1FpEkuCfmyVyrS4m/14nfwmtYRjvyf53MMJz+B5UzzASxAeWnJ8Dl7
   TXaiGo8ywAPqqYs03zdNWrwzIchQJ7DUZEaOn8aOj1XIUa/PDT30zadxY
   BYCS68Z6q2hEltFclC5U+9NU5fFacrSOlCjmmzONu4RY1HYG5lVvLqzSH
   6umctD549UsBRpFxw66GlAklCwDfyq2/WFJVLlnry+gr7agIfTa1/Y+V6
   FyDpTGTf/PyQgSsOEbvyNO85wRlXUhK4kh1oYbWtLplHGpRuYVJrLfePO
   lvqemhmkk64rlUtCEkw+h4/rhfchcbjUyTBNhAyR4bJw4IplQpFamirf6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698072"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698072"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184139"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: remove devices that never came out
Date: Wed, 20 Mar 2024 23:26:27 +0200
Message-Id: <20240320232419.b3715c0d4bdd.I1337ed9c3edbec4ea9ff7e8a8b02410d5e69bf74@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  6 -----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  4 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 26 -------------------
 5 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f1e7b15458c1..9baa6b2c37db 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -430,8 +430,6 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_HR2		0x10A
 #define IWL_CFG_RF_TYPE_HR1		0x10C
 #define IWL_CFG_RF_TYPE_GF		0x10D
-#define IWL_CFG_RF_TYPE_MR		0x110
-#define IWL_CFG_RF_TYPE_MS		0x111
 #define IWL_CFG_RF_TYPE_FM		0x112
 #define IWL_CFG_RF_TYPE_WH		0x113
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4696d73c8971..ec756e50091d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -192,12 +192,6 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	case IWL_CFG_RF_TYPE_GF:
 		rf = "gf";
 		break;
-	case IWL_CFG_RF_TYPE_MR:
-		rf = "mr";
-		break;
-	case IWL_CFG_RF_TYPE_MS:
-		rf = "ms";
-		break;
 	case IWL_CFG_RF_TYPE_FM:
 		rf = "fm";
 		break;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9a8d2b69f154..03ff6ee546ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1025,8 +1025,6 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 
 	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_GF:
-	case IWL_CFG_RF_TYPE_MR:
-	case IWL_CFG_RF_TYPE_MS:
 	case IWL_CFG_RF_TYPE_FM:
 	case IWL_CFG_RF_TYPE_WH:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index a7d44df06eab..8df6ec12b74e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -453,8 +453,6 @@ enum {
 #define REG_CRF_ID_TYPE_HR_NONE_CDB_1X1	0x501
 #define REG_CRF_ID_TYPE_HR_NONE_CDB_CCP	0x532
 #define REG_CRF_ID_TYPE_GF			0x410
-#define REG_CRF_ID_TYPE_GF_TC			0xF08
-#define REG_CRF_ID_TYPE_MR			0x810
 #define REG_CRF_ID_TYPE_FM			0x910
 #define REG_CRF_ID_TYPE_FMI			0x930
 #define REG_CRF_ID_TYPE_FMR			0x900
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4cf811afdfa5..75e5177cf140 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -944,11 +944,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_ma, iwl_ax211_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma, iwl_ax221_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1100,24 +1095,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
-/* MsP */
-/* For now we use the same FW as MR, but this will change in the future. */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma, iwl_ax204_name),
-
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
@@ -1224,9 +1201,6 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	case REG_CRF_ID_TYPE_GF:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
 		break;
-	case REG_CRF_ID_TYPE_MR:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_MR << 12);
-		break;
 	case REG_CRF_ID_TYPE_FM:
 	case REG_CRF_ID_TYPE_FMI:
 	case REG_CRF_ID_TYPE_FMR:
-- 
2.34.1


