Return-Path: <linux-wireless+bounces-22680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF1AACE3B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C459840E3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F26214A7D;
	Tue,  6 May 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJAVokMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F952147FC
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560485; cv=none; b=pwQV9yekNv5EzXO/15z+ZttKFt1vX8vSypqtbawX4F7MTFEy8a2jBEl7IzDN5WxVrzlkEyoNbOe3O/cP7z5npTGDLG5yCSH7TL+1cogirfW8bWoiXbRgtlDrMR14Nlzok60i2uqeCEZ6kh2Edtwdwh2ZXoJeQeUq3XtqhAeQn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560485; c=relaxed/simple;
	bh=MtEMjSk68vSBroPneEVZcVKGcWRWTbJCfXTr7fyqA+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1WqyD9IVBj9GVyEOxzcDwBg03xY8/WEjzx6WVd2rm/mnIMuLKveuIDAkBPvVbQWdOMs10sVgMb6Ha4nRGIg0LJa0dC2fOG/LycbTYGhRDNIE4nEhB3Z87NO8MRR6is06mZLcR8RG7cfzKI+luUbVsmEfJfaHDOE9r8F5RhJnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJAVokMp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560485; x=1778096485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MtEMjSk68vSBroPneEVZcVKGcWRWTbJCfXTr7fyqA+s=;
  b=PJAVokMpAiHp4YIRZ6vpj+CEogh94I/9QoUXAMwl3l5evcLMOiqGFbz+
   +1RBx+PUjuuv+qiuZCbAVNBKIQWZN2wPIwfrUWYonSkXz7RV4g+boJMtx
   RqyUbIBfNa8H5lNL3Bo80rP83UK/e3PpGT7ijLx3dVHzgESCvddidgA8g
   InHBZGycI2GNMFwVZMm3LY28g19OiZaWcQT+DaaVeiE5tkMuL+jSDOrOi
   3JC21KvE87Phqnlt+OOgFx85IZ2YNMOyonKJSGkG8cDl3zgdEcC5n3trA
   SsmNQ/+FUxBQ4TAGWfRs3SSSZiMOVDEsfK96dmOCIU/wTTsMRO+/03dU4
   A==;
X-CSE-ConnectionGUID: fBH/w95zS1qn93y718c4Xg==
X-CSE-MsgGUID: TvkveLKFRiSuWSERuROpvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961633"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:25 -0700
X-CSE-ConnectionGUID: 6TujbkZCTXuyBzsr1mQoiA==
X-CSE-MsgGUID: 69UuE3TQQjKUT/Lf0OpX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465438"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: Add support for a new version for link config command
Date: Tue,  6 May 2025 22:40:52 +0300
Message-Id: <20250506194102.3407967-6-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Add support for a new version of link configuration command
which includes NPCA and high priority TX traffic support for wifi8.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Message-Id: <20250506223834.e01d31bfbc73.I62ccc53963ebf6dc3ed8aec233569a4d343903bc@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 26 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  6 ++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 53b7340ef8a1..b9f559dac39f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -488,6 +488,24 @@ enum iwl_link_modify_bandwidth {
 	IWL_LINK_MODIFY_BW_320,
 };
 
+/**
+ * struct iwl_npca_params - NPCA parameters (non-primary channel access)
+ *
+ * @switch_delay: after switch, delay TX according to destination AP
+ * @switch_back_delay: switch back to control channel before OBSS frame end
+ * @min_dur_threshold: minimum PPDU time to switch to the non-primary
+ *	NPCA channel
+ * @flags: NPCA flags - bit 0: puncturing allowed, bit 1: new TX allowed
+ * @reserved: reserved for alignment purposes
+ */
+struct iwl_npca_params {
+	u8 switch_delay;
+	u8 switch_back_delay;
+	__le16 min_dur_threshold;
+	__le16 flags;
+	__le16 reserved;
+} __packed; /* NPCA_PARAM_API_S_VER_1 */
+
 /**
  * struct iwl_link_config_cmd - command structure to configure the LINK context
  *	in MLD API
@@ -545,6 +563,8 @@ enum iwl_link_modify_bandwidth {
  *	IEEE802.11REVme-D5.0
  * @ibss_bssid_addr: bssid for ibss
  * @reserved_for_ibss_bssid_addr: reserved
+ * @npca_params: NPCA parameters
+ * @prio_edca_params: priority EDCA parameters for enhanced QoS
  * @reserved3: reserved for future use
  */
 struct iwl_link_config_cmd {
@@ -592,8 +612,10 @@ struct iwl_link_config_cmd {
 	u8 ul_mu_data_disable;
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
-	__le32 reserved3[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5, _VER_6 */
+	struct iwl_npca_params npca_params; /* since _VER_7 */
+	struct iwl_ac_qos prio_edca_params; /* since _VER_7 */
+	__le32 reserved3[4];
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5, _VER_6, _VER_7 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 26301c0b06a1..2a174c00b712 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022, 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022, 2024-2025 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_mac_h__
@@ -287,9 +287,9 @@ struct iwl_ac_qos {
 	__le16 cw_min;
 	__le16 cw_max;
 	u8 aifsn;
-	u8 fifos_mask;
+	u8 fifos_mask; /* not in use since _VER_3 */
 	__le16 edca_txop;
-} __packed; /* AC_QOS_API_S_VER_2 */
+} __packed; /* AC_QOS_API_S_VER_2, _VER_3 */
 
 /**
  * struct iwl_mac_ctx_cmd - command structure to configure MAC contexts
-- 
2.34.1


