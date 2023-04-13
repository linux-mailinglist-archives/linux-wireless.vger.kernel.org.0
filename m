Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4B6E080E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDMHqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDMHqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:46:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102175FC6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371976; x=1712907976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QwIQBeHp9Ifk3lWccrFnj7ovqROOAirmygcX2aTI84A=;
  b=hNNWLq4nhjjkTBczB5zuorb6otZGfX7HdpWRi5sdM/gqgyO3g3qR94ht
   fb7qfMyVCMslhySoE8Rf/WMKTRHadP/ji9WmAEOth3uKQUDog/ziYmJzr
   2zkNDAtkNJk+N1NT+0cVoV0ax3/QTeqTrgPxNjOe31WuwF9pMEATR3dVz
   qzkmC+abQ2QB734pOIjK0pMeqvxakTHCEenPDwquD+wnRxp3CuiAWJlhk
   KTKLgufPRGlaw8mOUesB0me7LI5r9gtxVo+B//d9s5hBSQuv/EPiRVXR0
   VYfbwhGKde4CHwR03E3Yhx8JCAe/L5ri4cxUbVDUadk/D6PkR3ge1jjcr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736098"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736098"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034821"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034821"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: Update init sequence if tx diversity supported
Date:   Thu, 13 Apr 2023 10:44:12 +0300
Message-Id: <20230413102635.c2121c8694a7.Ibee3dd8765ef4b7504660fa228a7c7eff78920af@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

PHY configuration command need to be sent to FW if the tx diversity
with SISO is supported.
This need to be sent to get the init notification from FW.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a6b11bccb0c1..521eded39028 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -672,6 +672,13 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 		goto error;
 	}
 
+	ret = iwl_send_phy_cfg_cmd(mvm);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to run PHY configuration: %d\n",
+			ret);
+		goto error;
+	}
+
 	/* We wait for the INIT complete notification */
 	ret = iwl_wait_notification(&mvm->notif_wait, &init_wait,
 				    MVM_UCODE_ALIVE_TIMEOUT);
@@ -1538,12 +1545,11 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		ret = iwl_send_phy_db_data(mvm->phy_db);
 		if (ret)
 			goto error;
+		ret = iwl_send_phy_cfg_cmd(mvm);
+		if (ret)
+			goto error;
 	}
 
-	ret = iwl_send_phy_cfg_cmd(mvm);
-	if (ret)
-		goto error;
-
 	ret = iwl_mvm_send_bt_init_conf(mvm);
 	if (ret)
 		goto error;
-- 
2.38.1

