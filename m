Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA86AAF5F
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCEMRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4310126EE
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018619; x=1709554619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T39OvKb3n8omLMv+7klYaUvuT9QCMb+ffIJhA+cTWrg=;
  b=QS3248Uqn3LnCyPm0SXKalFOBl/VPqwNoXsGIdPMuu3I19xvfTDftW47
   PNcZbdT0v1RzbRPUnbfT4IrAaZ0A9xYPFDhpk/5H/u9elkGvdex3WeI+k
   idglkDnUwV0i5BAC9jwEjvPZ1gP45qycc6EgghcOGarHZvdXuR3ZAjhYP
   b3tyDbC6wgQivIa6OudiQMf31uueqaxamb9hOKCLIIL+W+EehNiiJwa/b
   PrV5Jx+DHv+xIjRl7nj1JuSFplw39TGYIs1b8g8rnxPlvSiT49PxQu8I8
   F8J+CdRTxyQZbUMA/cnTOIDBYI4/q0XBa3vFhe9E6PXKdnXZuVkcrYXtG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193161"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355002"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355002"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:57 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/21] wifi: iwlwifi: Adding the code to get RF name for MsP device
Date:   Sun,  5 Mar 2023 14:16:17 +0200
Message-Id: <20230305124406.ae831f21ec55.Iad71cc30f9930f7ebe079d210ebe6c968a159273@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add missing RF name extraction for MsP device from hardware rf-id.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h         | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 3e1f011e93aa..bece76b1a514 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -348,6 +348,7 @@ enum {
 #define CSR_HW_RF_ID_TYPE_HRCDB		(0x00109F00)
 #define CSR_HW_RF_ID_TYPE_GF		(0x0010D000)
 #define CSR_HW_RF_ID_TYPE_GF4		(0x0010E000)
+#define CSR_HW_RF_ID_TYPE_MS		(0x00111000)
 
 /* HW_RF CHIP STEP  */
 #define CSR_HW_RF_STEP(_val) (((_val) >> 8) & 0xF)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 94f40c4d2421..1e263154e9eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -277,6 +277,9 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HRCDB):
 		pos = scnprintf(buf, buflen, "HRCDB");
 		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_MS):
+		pos = scnprintf(buf, buflen, "MS");
+		break;
 	default:
 		return;
 	}
-- 
2.38.1

