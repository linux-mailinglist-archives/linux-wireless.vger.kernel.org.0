Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C446B9D9B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCNRyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCNRyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940611CADC
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816468; x=1710352468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i8u9LNPpPE2Z573Tx+lMQsQZ8hAqEZLIfOA9yPRaIY0=;
  b=gBFayUzu1ZUoSiwSpp0RSymaFyXwUloZUUn5o6Jpqa/L7odqQitCA9lV
   0hE6dDQ5gSje5siENTztPyut5aKjCy73tRsuaeAS6dcLZiLP3gCeo7GbI
   U84FkS7kMhXo1oQaBrNo8fdJJZi4ieE46LMJfIpOrjTw5IiaQuhbP7yh7
   T1r+pyfHorMksUiEyXIbycHNONgAM2Wc2QKZFKFKd+yBroq0pxKG6AdzM
   MvyNEUaVVsv+dN9qt1siX0fWo3flMII7k/uXQRi55yQWQqnzCJekmR3pG
   C4on626GSjxWYAzpt6EX4qw6ApsSn5RqXItdrzIhkoHuWEJ27jgioCvmc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149752"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200603"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200603"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 22/22] wifi: iwlwifi: fw: pnvm: fix uefi reduced TX power loading
Date:   Tue, 14 Mar 2023 19:49:34 +0200
Message-Id: <20230314194113.aa2cf2281f5d.I33b4ab3427f1921c184c52fecd0f46781a89dc8a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are a number of issues here:
 * if trans->reduce_power_loaded is already true, we call
   iwl_trans_set_reduce_power() with an uninitialized len
   value
 * in this case we also clobber a previous load/setting
 * if iwl_uefi_get_reduced_power() returns an ERR_PTR() we
   try to kfree() it

Move the iwl_trans_set_reduce_power() call into the success
case only to fix these issues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index b6d3ac6ed440..c6f2672fdc73 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2020-2021 Intel Corporation
+ * Copyright(c) 2020-2022 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -318,7 +318,6 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	kfree(data);
 
 skip_parse:
-	data = NULL;
 	/* now try to get the reduce power table, if not loaded yet */
 	if (!trans->reduce_power_loaded) {
 		data = iwl_uefi_get_reduced_power(trans, &len);
@@ -329,19 +328,16 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 * trying again over and over.
 			 */
 			trans->reduce_power_loaded = true;
-
-			goto skip_reduce_power;
+		} else {
+			ret = iwl_trans_set_reduce_power(trans, data, len);
+			if (ret)
+				IWL_DEBUG_FW(trans,
+					     "Failed to set reduce power table %d\n",
+					     ret);
+			kfree(data);
 		}
 	}
 
-	ret = iwl_trans_set_reduce_power(trans, data, len);
-	if (ret)
-		IWL_DEBUG_FW(trans,
-			     "Failed to set reduce power table %d\n",
-			     ret);
-	kfree(data);
-
-skip_reduce_power:
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
 				   iwl_pnvm_complete_fn, trans);
-- 
2.38.1

