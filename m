Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC33783AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjHVHdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjHVHdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E513D
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689617; x=1724225617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je6fcHBQLDLFa9UuMYEzUWRMdccqeD5J37zjh2Q/UXo=;
  b=W4HTfMx1fcXyJuJfdQuTLMad4DFF965hf23aVQ7LBSVstrv1FhnDUtK/
   lduFFw9x7iFLZ3pppOpnNf+6GJPZu+ED6JXdiUnd0+z5+Yr2W2ietkBYn
   MNa6lmWFrKeFgFs9twiEmcCwJwEJ3Bd0Lu8ReUpOhaA44dHGZGPFCyOPa
   YtJ9FVKWkvWDyDBw93k64DGC3YSv4wU6loYQNfjKcPaSHqrd2kvTi0S/n
   +XEa8pNMEmlaOsU1gYfMEIMZICHbr1VtsIHH5v79sPLmSqykA6lfZcjgz
   1iux48PZzold0a+fg6ZqmQNYwhqDMxL78+pK/j43wLSsab6ky720GoVTb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968734"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229606"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229606"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/5] wifi: iwlmei: don't send SAP messages if AMT is disabled
Date:   Tue, 22 Aug 2023 10:33:16 +0300
Message-Id: <20230822103048.db16b55c27c1.I48834c14f5af8d31792f5048b3023509cba191dd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822073319.466640-1-gregory.greenman@intel.com>
References: <20230822073319.466640-1-gregory.greenman@intel.com>
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

From: Avraham Stern <avraham.stern@intel.com>

SAP messages should not be sent when AMT is disabled.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 54445f39fd55..908506f98242 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021-2022 Intel Corporation
+ * Copyright (C) 2021-2023 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -1532,7 +1532,7 @@ void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1561,7 +1561,7 @@ void iwl_mei_host_disassociated(void)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1597,7 +1597,7 @@ void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1626,7 +1626,7 @@ void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_address)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1654,7 +1654,7 @@ void iwl_mei_set_country_code(u16 mcc)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
@@ -1680,7 +1680,7 @@ void iwl_mei_set_power_limit(const __le16 *power_limit)
 
 	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
-	if (!mei && !mei->amt_enabled)
+	if (!mei || !mei->amt_enabled)
 		goto out;
 
 	memcpy(msg.sar_chain_info_table, power_limit, sizeof(msg.sar_chain_info_table));
-- 
2.38.1

