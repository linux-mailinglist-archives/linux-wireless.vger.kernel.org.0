Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D17C4FAB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjJKKJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJKKIp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E6130
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018868; x=1728554868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O6WrMWOjyycMbPSY/pHH3ZNWt5VaLRiqLFq+3uVf5p4=;
  b=k0zbda2aCsf7KHCPYkiYWvCKaYf5Ar5wd11i9jkTjEuCU9J45jbUClwE
   jkvd1yANQ1ISMQ/h7sBFUvh1wSnptBZtu7vD0klVKg0UJBqh6o5LKn9V7
   Ko/gMvWTWiGiYgEabGjsuT0eqp83aGcxXOIeiGdPTytZNMKaF6rIzG/0+
   OUj6shzJfXEx7/HJjFemM+eyfNwHlPQWl4LAoLfw5GDEp2MEx1yBuNEaN
   YKeZI5uK7ENOCcMhiBBq+im+GAQiiil0Xs+fPzIJ5ufzlvVnz0mZcj8Wa
   rq+Yb27N5Ku0BcWewuZk4Z+aTmRFMj5sPKFE6kc2tl6JqyMJfA3Xv77v8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670564"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050248"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050248"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/16] wifi: iwlwifi: add new RF support for wifi7
Date:   Wed, 11 Oct 2023 13:07:17 +0300
Message-Id: <20231011130030.d902aa8cfd1b.I7c7b357ba41c00015d6c6255b45b3d17549948f0@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add the support for new RF based on step-id.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h |  3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 3653a9fd9d8c..a4df67ff21ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -313,6 +313,7 @@ enum {
 	SILICON_C_STEP,
 	SILICON_D_STEP,
 	SILICON_E_STEP,
+	SILICON_TC_STEP = 0xe,
 	SILICON_Z_STEP = 0xf,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c4e50f204630..3753e2ae582f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -162,6 +162,8 @@ static inline char iwl_drv_get_step(int step)
 {
 	if (step == SILICON_Z_STEP)
 		return 'z';
+	if (step == SILICON_TC_STEP)
+		return 'a';
 	return 'a' + step;
 }
 
@@ -178,6 +180,8 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 
 	mac_step = iwl_drv_get_step(trans->hw_rev_step);
 
+	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->hw_rf_id));
+
 	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_HR1:
 	case IWL_CFG_RF_TYPE_HR2:
@@ -196,7 +200,13 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		rf = "fm";
 		break;
 	case IWL_CFG_RF_TYPE_WH:
-		rf = "wh";
+		if (SILICON_Z_STEP ==
+		    CSR_HW_RFID_STEP(trans->hw_rf_id)) {
+			rf = "whtc";
+			rf_step = 'a';
+		} else {
+			rf = "wh";
+		}
 		break;
 	default:
 		return "unknown-rf";
@@ -204,8 +214,6 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 
 	cdb = CSR_HW_RFID_IS_CDB(trans->hw_rf_id) ? "4" : "";
 
-	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->hw_rf_id));
-
 	scnprintf(buf, FW_NAME_PRE_BUFSIZE,
 		  "iwlwifi-%s-%c0-%s%s-%c0",
 		  trans->cfg->fw_name_mac, mac_step,
-- 
2.38.1

