Return-Path: <linux-wireless+bounces-28059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D5BEE0EC
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F300A34A877
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B422A1D4;
	Sun, 19 Oct 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsYJXl5T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1364189F20
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863536; cv=none; b=OED/n/zUn4UYWPcku2sqS2gVT4xR2Fi/vL9WoIyZoAyixZQyDOnW8Op7Ybvn17vzDkfJl28dl5xMlRTSF9g/SpOHK77ojAjD9Fvqp0SCu0EUQ9HjOhsUNXOWfTO0If2/If9Y9/ab6M7HJc8WEIOBSeOfgv8qU4Z80pzG8oELyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863536; c=relaxed/simple;
	bh=EEk9UWzlPw/QxJfshXah/g9dxwVvNz8YgwK8LGU6I8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARBBst7lI1zrihW9bQrT/d+2gkFfOf1OhECjT8kcfuM2XmxlqyhjYfgd9dp7sVWSXubUk/TbuwrgYFygYt48RB3oPNDLwF03FM+XCGcPjuw7zltzGFWUviBacrg/ZmiQeXfFqmlBN3XBDRiSNvdThXvYLKf3f+8nAP1DMD/qnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsYJXl5T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863535; x=1792399535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEk9UWzlPw/QxJfshXah/g9dxwVvNz8YgwK8LGU6I8U=;
  b=gsYJXl5TMvx3JBJqoFUT2ibNJcDfeJKPlD4yTGvdq/OESKXVb9qmemjw
   OOQ0LQ7L855zmI400CKyPH21ufckHuJYtku9NUCy5rbz/s0KzbTkww/W2
   Q5ZW7FmGppLdph3CQ4U7dq7iWYpLJQFa10VcK5x2Ck6gH1GvrLveUOi3A
   0gNnOsTO0wvAjEJwhudQqkVO1vZ4n8BCtH0w3SOa7APs/6VJwF0CmxW2I
   rddxUYqzsahG1ovop8NHgUzx7d3M+9Sp9cFS1TV4IiuJ7HERDm1UFDX92
   JIOJeST+VOrRbEhMaRpgEy3+MsyJqaKs1J4v4ZKGm7AyPssiyf/LCDgrI
   A==;
X-CSE-ConnectionGUID: u0Gdo61LQqyi7NFkh2aZYQ==
X-CSE-MsgGUID: wAC4fflHTTWN3k21TFDrqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363182"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363182"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:34 -0700
X-CSE-ConnectionGUID: hcgbXtfZSyOsgk7Ah2Vxfg==
X-CSE-MsgGUID: lJ/3G2EJQ5iDnHSLYab9Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279870"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: be more chatty when we fail to find a wifi7 device
Date: Sun, 19 Oct 2025 11:45:05 +0300
Message-Id: <20251019114304.071dae9a5de2.I1603085bac5a796442faa75982f8675647becfec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

All wifi7 devices need CONFIG_IWLMLD to be enabled.
If we can't support the wifi7 device and the module is not enabled,
complain to the user.
The check in iwl_req_fw_callback is then no longer required.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           | 7 -------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 7d58e294618d..a51d8b878412 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1859,13 +1859,6 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 #if IS_ENABLED(CONFIG_IWLMLD)
 	if (iwl_drv_is_wifi7_supported(drv->trans))
 		op = &iwlwifi_opmode_table[MLD_OP_MODE];
-#else
-	if (iwl_drv_is_wifi7_supported(drv->trans)) {
-		IWL_ERR(drv,
-			"IWLMLD needs to be compiled to support this firmware\n");
-		mutex_unlock(&iwlwifi_opmode_table_mtx);
-		goto out_unbind;
-	}
 #endif
 
 	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 59307b5df441..164d060ec617 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4218,6 +4218,15 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 		 pdev->device, pdev->subsystem_device,
 		 info.hw_rev, info.hw_rf_id);
 
+#if !IS_ENABLED(CONFIG_IWLMLD)
+	if (iwl_drv_is_wifi7_supported(iwl_trans)) {
+		IWL_ERR(iwl_trans,
+			"IWLMLD needs to be compiled to support this device\n");
+		ret = -EOPNOTSUPP;
+		goto out_free_trans;
+	}
+#endif
+
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
 					 CSR_HW_RFID_TYPE(info.hw_rf_id),
 					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
-- 
2.34.1


