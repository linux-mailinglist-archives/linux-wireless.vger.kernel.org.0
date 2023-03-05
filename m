Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460B6AAF6E
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCEMRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCEMRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7013510
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018659; x=1709554659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nEWZ5qUbiqao6s7ZHbESWYgnThkiHulN9P/fxwP9FCk=;
  b=icMfqxY5f6g4ppg/a6IpqmHCM1+Efm8CTCG5XpahxTfJcSwjabd9VEKF
   FjmMyHi6eBEeP9iOV/c+BHyOW0CRF9D55B81+D3STQPebHx5mtmFlStYU
   BxMOvsu0u0jwoaBY9m5F4NB+60zgazKt5ytAJ5ZJ074nIeAucsR9XFX4Q
   tp5BGbb4KmXFEZdwhEH3v8dkQmS6LdKLfAPp3GVynwQpKNbZ985jQU15D
   /doO8xw2G1y36i6tqGAd+za7hszRPR3ADaFJUi/vYUZEK7R7TcMqE9bUB
   TILl/GQReaqp6fLuYou7FV+73RsvW/aRMXnYF3jKMFRiOivuY+obL+bD8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193285"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355213"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355213"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:37 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/21] wifi: iwlwifi: Update logs for yoyo reset sw changes
Date:   Sun,  5 Mar 2023 14:16:32 +0200
Message-Id: <20230305124407.852a6b5f95fa.Ie67bd28da65c7e42424cacb37495930475de2dad@changeid>
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

Update the log category for the reset-fw changes.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 8e0bc1f5f6c6..14674ea33825 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1218,11 +1218,11 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 		}
 
 		fwrt->trans->dbg.restart_required = FALSE;
-		IWL_DEBUG_INFO(fwrt, "WRT: tp %d, reset_fw %d\n",
-			       tp, dump_data.trig->reset_fw);
-		IWL_DEBUG_INFO(fwrt, "WRT: restart_required %d, last_tp_resetfw %d\n",
-			       fwrt->trans->dbg.restart_required,
-			       fwrt->trans->dbg.last_tp_resetfw);
+		IWL_DEBUG_FW(fwrt, "WRT: tp %d, reset_fw %d\n",
+			     tp, dump_data.trig->reset_fw);
+		IWL_DEBUG_FW(fwrt, "WRT: restart_required %d, last_tp_resetfw %d\n",
+			     fwrt->trans->dbg.restart_required,
+			     fwrt->trans->dbg.last_tp_resetfw);
 
 		if (fwrt->trans->trans_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_9000) {
@@ -1235,18 +1235,18 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 			IWL_DEBUG_FW(fwrt, "WRT: FW_ASSERT due to reset_fw_mode-no restart\n");
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW) {
-			IWL_DEBUG_INFO(fwrt, "WRT: stop and reload firmware\n");
+			IWL_DEBUG_FW(fwrt, "WRT: stop and reload firmware\n");
 			fwrt->trans->dbg.restart_required = TRUE;
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
-			IWL_DEBUG_INFO(fwrt, "WRT: stop only and no reload firmware\n");
+			IWL_DEBUG_FW(fwrt, "WRT: stop only and no reload firmware\n");
 			fwrt->trans->dbg.restart_required = FALSE;
 			fwrt->trans->dbg.last_tp_resetfw =
 				le32_to_cpu(dump_data.trig->reset_fw);
 		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
 			   IWL_FW_INI_RESET_FW_MODE_NOTHING) {
-			IWL_DEBUG_INFO(fwrt,
-				       "WRT: nothing need to be done after debug collection\n");
+			IWL_DEBUG_FW(fwrt,
+				     "WRT: nothing need to be done after debug collection\n");
 		} else {
 			IWL_ERR(fwrt, "WRT: wrong resetfw %d\n",
 				le32_to_cpu(dump_data.trig->reset_fw));
-- 
2.38.1

