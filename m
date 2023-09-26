Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB17AE76C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjIZIHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjIZIHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC3FB
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715663; x=1727251663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mz4aAs0CjLNvuyYeoxnIUSoOAqTJjhurNeKzRpiWVwY=;
  b=M4zrS8s4Zvbzb7symSnwHb6yr93aOOJSGmMgqr1C/Z2yERiJzyoqcNbr
   2rHxw5Y6qA6jvvBnGSeoUFKCAKzZ1NwoYSYeahEBpYpmxkhqVzaR9ZWjX
   DHijarmU8Vw7eRPw6hGA72dqFd68sGTez4ZAzKksU2ouy/soOBwftPkYq
   1el3t8HfDS/MX6gwB41FbWG6ycGj5+43+U/8AAFWdeBDxie4vCxMeYYB2
   IVPld1hgFccZW7gOz5NnVZv9ge+lRlt9KLIvlQ4poAZhL8bS+2TH6wZP2
   o1DY6rFe1YqyGPM0epuF/DQoLrr+/UAoILgsMvduY3OzW86EQyDzQ2jpN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797262"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369277"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369277"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/9] wifi: iwlwifi: fix opmode start/stop race
Date:   Tue, 26 Sep 2023 11:07:16 +0300
Message-Id: <20230926110319.85951554fed8.I62f20f40d79d0f136fa05e46d7fc16dc437fa3db@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a race when the device is unbound (maybe because the
module is unloaded) while the opmode start hasn't finished yet.
The complete(request_firmware_complete) after the opmode start
was meant (and commented accordingly) to prevent this problem,
but it's not sufficient when the opmode module is loaded after
the firmware load already completed, which happens regularly
now because firmware load doesn't require userspace, unlike
module load.

Fix this by using the existing opmode registration mutex to
protected the start/stop flows against each other properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 41ae4fae4b8a..c4e50f204630 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1415,6 +1415,9 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 	struct iwl_op_mode *op_mode = NULL;
 	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
 
+	/* also protects start/stop from racing against each other */
+	lockdep_assert_held(&iwlwifi_opmode_table_mtx);
+
 	for (retry = 0; retry <= max_retry; retry++) {
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -1445,6 +1448,9 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 
 static void _iwl_op_mode_stop(struct iwl_drv *drv)
 {
+	/* also protects start/stop from racing against each other */
+	lockdep_assert_held(&iwlwifi_opmode_table_mtx);
+
 	/* op_mode can be NULL if its start failed */
 	if (drv->op_mode) {
 		iwl_op_mode_stop(drv->op_mode);
@@ -1728,11 +1734,6 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	}
 	mutex_unlock(&iwlwifi_opmode_table_mtx);
 
-	/*
-	 * Complete the firmware request last so that
-	 * a driver unbind (stop) doesn't run while we
-	 * are doing the start() above.
-	 */
 	complete(&drv->request_firmware_complete);
 
 	/*
@@ -1837,11 +1838,12 @@ void iwl_drv_stop(struct iwl_drv *drv)
 {
 	wait_for_completion(&drv->request_firmware_complete);
 
+	mutex_lock(&iwlwifi_opmode_table_mtx);
+
 	_iwl_op_mode_stop(drv);
 
 	iwl_dealloc_ucode(drv);
 
-	mutex_lock(&iwlwifi_opmode_table_mtx);
 	/*
 	 * List is empty (this item wasn't added)
 	 * when firmware loading failed -- in that
-- 
2.38.1

