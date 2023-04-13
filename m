Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A146E0810
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDMHqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDMHqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:46:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603587D96
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371976; x=1712907976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AI0i/mcOmBHmzHfH1nOpFFDV3PqAp0+FBN+uMXQvlr4=;
  b=PDw0sFWq8/NeLCw5SYRY1ybsKrPLq+gaF9bclRMiMWKk87KMqUyymBLR
   R6GAiXzAp2/1jd8C8I+BB8P3uyezslrtN41Wwe55kcKRPV6x29EtpNe4/
   4dDSfhcw9QodisfNpFIXQQciDL7of/6mjO36fQNjy1mrmbyH61PNGJVBw
   zAcDUnWGMJ1e8VHrobymRoArVEPAtJlbwpZZycdskqXVbFDwRBC5HWSCk
   wJVNZCwQDDQwdUhHvXN6k2yfjzeFXZGmgop+BeqKlAZHt+BiV6a5s9V52
   NFs5x4JZR4Sp2EFrV2ZbEKv+kN79JQA+OpgKPOi+VAavKLD3EWY3tpPa6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736112"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034837"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034837"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: trans: don't trigger d3 interrupt twice
Date:   Thu, 13 Apr 2023 10:44:14 +0300
Message-Id: <20230413102635.b5f2f6e44d38.I4cb5b6ad4914db47a714e731c4c8b4db679cabce@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

When the IPC registers are used for sleep control, setting
the IPC sleep bit already triggers an interrupt to the fw, so
there is no need to also set the doorbell. Setting also the
doorbell triggers the sleep interrupt twice which lead to
an assert.

Fixes: af08571d3925 ("iwlwifi: pcie: support Bz suspend/resume trigger")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 0a9af1ad1f20..40283fe622da 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1522,19 +1522,16 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
 					      UREG_DOORBELL_TO_ISR6_RESUME);
-	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
 			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
 				      CSR_IPC_SLEEP_CONTROL_RESUME);
-		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
-				    UREG_DOORBELL_TO_ISR6_SLEEP_CTRL);
-	} else {
+	else
 		return 0;
-	}
 
 	ret = wait_event_timeout(trans_pcie->sx_waitq,
 				 trans_pcie->sx_complete, 2 * HZ);
-- 
2.38.1

