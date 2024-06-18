Return-Path: <linux-wireless+bounces-9216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71290DA2F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16536284AB6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B613BC35;
	Tue, 18 Jun 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx2wKnpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69E39AEC
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730195; cv=none; b=Z0/j08g9QcuiUH+i9XqbBreeTlRwFXIf695gMPwQxEic6u8/cAh6bmXH7en6LmDepEfHtStF84jmIu9XXbtLbep+V8MpzvHZrxF+h1IMrRLohyzzI3JKrpT2aGeoel7B65Zg804DRhoxZ8fPnjToqJ3j+xyoGNj7lNshQnti31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730195; c=relaxed/simple;
	bh=av+GWUXwrf2nUJ1+wNxeFiyu41GnuO7XRYcvy3Jn+gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVtGHK2B4gPkbeb2spAgxYkDltwAHdAxsh2WNJy4AVeWuLxy48qq66QSmKssuN3ZLkctIrGXw5vcIPZCGUswTTOLmgnRBdWKrhlOCZv3lPovggbZlR5OiRgQFAHr/47G0M2LGelJHDgcBXvn3atXB25wMtZq3bDJQQnjbcdHqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xx2wKnpA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718730193; x=1750266193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=av+GWUXwrf2nUJ1+wNxeFiyu41GnuO7XRYcvy3Jn+gY=;
  b=Xx2wKnpAieQBHSqQrIrO2+okRMtlulL2JUBBdeeenEOgEQO3lOwXeugf
   o0Su5Lt8gRdvI0zPCphYWbsnKsUGEUHw4fxb6uHj+aA7lD2AINieinzJW
   5v69eXs7LMosPRuyAZqD4RFao92X47tjcwcRIa5d1znJTfaSeA5F/Sl4p
   oCiaPU/41/8uVBHsv2qbCcdLoUUIT1al+f1y4e0LnQcqjFpiNxWfJjIqy
   Edpjhwkyr7edNsWveq9E0pvyion8awe5PJmQI8sZeCt806xGMj9hYI1+1
   irDImKEQU6+ejFaarhkddDYkdTRlC2cXaiffjMk4uyQd+EfHbOUCHdcO0
   w==;
X-CSE-ConnectionGUID: aCrWNgFcQLq8klQlZwvpDQ==
X-CSE-MsgGUID: yYfvmvFFT7qBiLoyWCn3Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33093999"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33093999"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:13 -0700
X-CSE-ConnectionGUID: JVqU+bDXQa6FYGWavfc3cg==
X-CSE-MsgGUID: DiBgkrf6QrOJC8KDT157PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46541780"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/3] wifi: iwlwifi: pcie: fix a few legacy register accesses for new devices
Date: Tue, 18 Jun 2024 20:03:01 +0300
Message-Id: <20240618200104.399d4d215210.Id12e7fdb7bab9f2c4c0d292519b5c1b4753a8c84@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
References: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Do not access legacy bits for new devices, this has no effect.
Somehow, wowlan worked despite the usage of the wrong bits. Now
that we want to keep the firmware loaded during suspend even without
wowlan, this change is needed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  4 ++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 22 ++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index c60f9466c5fd..060becfd64f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2022, 2024 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
 #include <linux/delay.h>
@@ -460,7 +460,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans)
 	 */
 	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_set_bit(trans, CSR_GP_CNTRL,
-			    CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
+			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ |
 			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
 		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
 	} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d5a887b3a4bb..200d4c1c3108 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1505,9 +1505,17 @@ void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 
 	iwl_pcie_synchronize_irqs(trans);
 
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
-	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+	} else {
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+	}
 
 	if (reset) {
 		/*
@@ -1586,8 +1594,12 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 		goto out;
 	}
 
-	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	ret = iwl_finish_nic_init(trans);
 	if (ret)
-- 
2.34.1


