Return-Path: <linux-wireless+bounces-10627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D79893FC4F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B69B232DE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBB16D4C3;
	Mon, 29 Jul 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoshVsld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0916A947
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273643; cv=none; b=ARx0WVY9i3TP4KcNBm7UN+WGGjlh1pZM2sWtowI2ghoGpStN6XbMdjw0MNlSDtY56uC+fNQkT17QAplSX2mvS4JxK4RVBdeBQh+HbQ7QWGa/W9N/xf22CP5/008x1KS76LnGTSmEDS5/z/X7mhu5v5Vkrfotq0qDuY2g950RMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273643; c=relaxed/simple;
	bh=gLn3/L8TDyeZp6ftzGVow+iaxwpjnSL5oGreTkpsSTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuHoLv1EPF7Hj3jg7lR7pyL1s4v5GbqaTT5GbwqNvwFhPXC7NXcqDvC3R29q/Zy6lgvti8D49IjuJpC8YL9dPWICoUngpseqijsn05Qa0zrPQGaNrlHaCWp+W7iAJ4s3VTVlVI45g3iLq2PPVLh9zB8TH37F/t/Y+xT6FcelqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoshVsld; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273642; x=1753809642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLn3/L8TDyeZp6ftzGVow+iaxwpjnSL5oGreTkpsSTo=;
  b=KoshVsldAOXPCeq+S7A4eV+M8voaAIhta9lSVeYtMsD7+P/GReFuC4o1
   0ZN4q1xv35B4tS8sRQNxxRBUEzm7YaJFJMA4J7ZQ7MECBbpH6Gj+lNZNl
   uYu6VQH0CbaiJTAhhtWZzzG4z3aeSlA0nNYtLm/Hdr/YFIw6hzp9X94hE
   VegY690Qj46gwBr919/1E6eoxg6pHwafYAy3GO+YzYRPL9JWHDi7EL7z8
   6eEnId4tYDyGuoRuo22knKpomA9jMW5KE8OnMcgkbGc0F/OvkQj98/3MI
   df+uahdf89XdVfoqMoMckTT20xGSLcm2wmE5OUf1+lIdx6dYt0jUGjsqT
   w==;
X-CSE-ConnectionGUID: O7IX/aSgRUeJLBAbhd1xFw==
X-CSE-MsgGUID: VvQP17DkREKSgHFcPeqx3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445580"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:42 -0700
X-CSE-ConnectionGUID: RutFXPL3SGClff266zya4Q==
X-CSE-MsgGUID: EXklpQAyQjO1bOYuE9p+OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288293"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 07/17] wifi: iwlwifi: mei: add support for SAP version 4
Date: Mon, 29 Jul 2024 20:20:08 +0300
Message-Id: <20240729201718.8372e040282f.Ia0085784e08a35159c9293f986c3d2774038f4c4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

SAP version 4 uses larger Host to MEI notification queue.
Since it is unknown which SAP version is used by the CSME firmware
when the driver loads, try version 4 first. In case the CSME firmware
uses version 3, the memory allocation will fail. In this case the
driver will try again to allocate the memory for version 3.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  | 10 ++++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 58 ++++++++++++++-----
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 4900de3cc0d3..2081775e0ec9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -283,6 +283,16 @@ struct iwl_mei_colloc_info {
 	u8 bssid[ETH_ALEN];
 };
 
+/**
+ * enum iwl_mei_sap_version - SAP version
+ * @IWL_MEI_SAP_VERSION_3: SAP version 3
+ * @IWL_MEI_SAP_VERSION_4: SAP version 4
+ */
+enum iwl_mei_sap_version {
+	IWL_MEI_SAP_VERSION_3 = 3,
+	IWL_MEI_SAP_VERSION_4 = 4,
+};
+
 /*
  * struct iwl_mei_ops - driver's operations called by iwlmei
  * Operations will not be called more than once concurrently.
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 1dd9106c6513..dce0b7cf7b26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021-2023 Intel Corporation
+ * Copyright (C) 2021-2024 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -58,7 +58,6 @@ bool iwl_mei_is_connected(void)
 }
 EXPORT_SYMBOL_GPL(iwl_mei_is_connected);
 
-#define SAP_VERSION	3
 #define SAP_CONTROL_BLOCK_ID 0x21504153 /* SAP! in ASCII */
 
 struct iwl_sap_q_ctrl_blk {
@@ -110,16 +109,19 @@ struct iwl_sap_shared_mem_ctrl_blk {
 
 #define SAP_H2M_DATA_Q_SZ	48256
 #define SAP_M2H_DATA_Q_SZ	24128
-#define SAP_H2M_NOTIF_Q_SZ	2240
+#define SAP_H2M_NOTIF_Q_SZ_VER3	2240
+#define SAP_H2M_NOTIF_Q_SZ_VER4	32768
 #define SAP_M2H_NOTIF_Q_SZ	62720
 
-#define _IWL_MEI_SAP_SHARED_MEM_SZ \
+#define _IWL_MEI_SAP_SHARED_MEM_SZ_VER3 \
 	(sizeof(struct iwl_sap_shared_mem_ctrl_blk) + \
-	 SAP_H2M_DATA_Q_SZ + SAP_H2M_NOTIF_Q_SZ + \
+	 SAP_H2M_DATA_Q_SZ + SAP_H2M_NOTIF_Q_SZ_VER3 + \
 	 SAP_M2H_DATA_Q_SZ + SAP_M2H_NOTIF_Q_SZ + 4)
 
-#define IWL_MEI_SAP_SHARED_MEM_SZ \
-	(roundup(_IWL_MEI_SAP_SHARED_MEM_SZ, PAGE_SIZE))
+#define _IWL_MEI_SAP_SHARED_MEM_SZ_VER4 \
+	(sizeof(struct iwl_sap_shared_mem_ctrl_blk) + \
+	 SAP_H2M_DATA_Q_SZ + SAP_H2M_NOTIF_Q_SZ_VER4 + \
+	 SAP_M2H_DATA_Q_SZ + SAP_M2H_NOTIF_Q_SZ + 4)
 
 struct iwl_mei_shared_mem_ptrs {
 	struct iwl_sap_shared_mem_ctrl_blk *ctrl;
@@ -206,6 +208,7 @@ struct iwl_mei {
  * @mac_address: interface MAC address.
  * @nvm_address: NVM MAC address.
  * @priv: A pointer to iwlwifi.
+ * @sap_version: The SAP version to use. enum iwl_mei_sap_version.
  *
  * This used to cache the configurations coming from iwlwifi's way. The data
  * is cached here so that we can buffer the configuration even if we don't have
@@ -220,6 +223,7 @@ struct iwl_mei_cache {
 	u16 mcc;
 	u8 mac_address[6];
 	u8 nvm_address[6];
+	enum iwl_mei_sap_version sap_version;
 	void *priv;
 };
 
@@ -238,14 +242,17 @@ static void iwl_mei_free_shared_mem(struct mei_cl_device *cldev)
 
 #define HBM_DMA_BUF_ID_WLAN 1
 
-static int iwl_mei_alloc_shared_mem(struct mei_cl_device *cldev)
+static int iwl_mei_alloc_mem_for_version(struct mei_cl_device *cldev,
+					 enum iwl_mei_sap_version version)
 {
 	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
 	struct iwl_mei_shared_mem_ptrs *mem = &mei->shared_mem;
+	u32 mem_size = roundup(version == IWL_MEI_SAP_VERSION_4 ?
+			       _IWL_MEI_SAP_SHARED_MEM_SZ_VER4 :
+			       _IWL_MEI_SAP_SHARED_MEM_SZ_VER3, PAGE_SIZE);
 
-	mem->ctrl = mei_cldev_dma_map(cldev, HBM_DMA_BUF_ID_WLAN,
-				       IWL_MEI_SAP_SHARED_MEM_SZ);
-
+	iwl_mei_cache.sap_version = version;
+	mem->ctrl = mei_cldev_dma_map(cldev, HBM_DMA_BUF_ID_WLAN, mem_size);
 	if (IS_ERR(mem->ctrl)) {
 		int ret = PTR_ERR(mem->ctrl);
 
@@ -254,11 +261,30 @@ static int iwl_mei_alloc_shared_mem(struct mei_cl_device *cldev)
 		return ret;
 	}
 
-	memset(mem->ctrl, 0, IWL_MEI_SAP_SHARED_MEM_SZ);
+	memset(mem->ctrl, 0, mem_size);
 
 	return 0;
 }
 
+static int iwl_mei_alloc_shared_mem(struct mei_cl_device *cldev)
+{
+	int ret;
+
+	/*
+	 * SAP version 4 uses a larger Host to MEI notif queue.
+	 * Since it is unknown at this stage which SAP version is used by the
+	 * CSME firmware on this platform, try to allocate the version 4 first.
+	 * If the CSME firmware uses version 3, this allocation is expected to
+	 * fail because the CSME firmware allocated less memory for our driver.
+	 */
+	ret = iwl_mei_alloc_mem_for_version(cldev, IWL_MEI_SAP_VERSION_4);
+	if (ret)
+		ret = iwl_mei_alloc_mem_for_version(cldev,
+						    IWL_MEI_SAP_VERSION_3);
+
+	return ret;
+}
+
 static void iwl_mei_init_shared_mem(struct iwl_mei *mei)
 {
 	struct iwl_mei_shared_mem_ptrs *mem = &mei->shared_mem;
@@ -277,7 +303,9 @@ static void iwl_mei_init_shared_mem(struct iwl_mei *mei)
 	h2m->q_ctrl_blk[SAP_QUEUE_IDX_DATA].size =
 		cpu_to_le32(SAP_H2M_DATA_Q_SZ);
 	h2m->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF].size =
-		cpu_to_le32(SAP_H2M_NOTIF_Q_SZ);
+		iwl_mei_cache.sap_version == IWL_MEI_SAP_VERSION_3 ?
+		cpu_to_le32(SAP_H2M_NOTIF_Q_SZ_VER3) :
+		cpu_to_le32(SAP_H2M_NOTIF_Q_SZ_VER4);
 	m2h->q_ctrl_blk[SAP_QUEUE_IDX_DATA].size =
 		cpu_to_le32(SAP_M2H_DATA_Q_SZ);
 	m2h->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF].size =
@@ -647,7 +675,7 @@ iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
 		return;
 	}
 
-	if (rsp->supported_version != SAP_VERSION) {
+	if (rsp->supported_version != iwl_mei_cache.sap_version) {
 		dev_err(&cldev->dev,
 			"didn't get the expected version: got %d\n",
 			rsp->supported_version);
@@ -1281,7 +1309,7 @@ static int iwl_mei_send_start(struct mei_cl_device *cldev)
 		.hdr.type = cpu_to_le32(SAP_ME_MSG_START),
 		.hdr.seq_num = cpu_to_le32(atomic_inc_return(&mei->seq_no)),
 		.hdr.len = cpu_to_le32(sizeof(msg)),
-		.supported_versions[0] = SAP_VERSION,
+		.supported_versions[0] = iwl_mei_cache.sap_version,
 		.init_data_seq_num = cpu_to_le16(0x100),
 		.init_notif_seq_num = cpu_to_le16(0x800),
 	};
-- 
2.34.1


