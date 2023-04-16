Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE06E3856
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDPMsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDPMsJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0704687
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649287; x=1713185287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJEhjYmKIqQQydZMPowi8xLPOG+Gw7NG1gNA74D/z08=;
  b=ZOlTvu3GVxmvFAybkYpk+w4T0bSRBYF3StMn05D4QKsLk9cEZM6UQRy5
   DYxW9FuJLYON7eOag+ptYnKeqtryhTPhGc63M7RD1XSojm3+DxAOHaza4
   KOoE7GzfxHviA+77ka4dhEhzVv6+GrdoZg0iI94gBlyyoM0FBC1In6HTU
   MXD1GII+14DgmGb2YSurMoV3aHb4SUL5WsGS+StJAt5ktFS74Kg2qF1Sm
   zFv1ZpAbfk10BJZ27SE3lZ2nzAPomIsyVbaQYskCQx5dLwdx1r73AK4ew
   rONQry6g+pxu7miFvE/7yRFU1g8D856ylA9vQ7g9eDUajEo8hZAcLZKtw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520560"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670431"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670431"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: avoid iterating over an un-initialized list
Date:   Sun, 16 Apr 2023 15:47:31 +0300
Message-Id: <20230416154301.b50b1fe9a576.Ie348ffae110612d2e252ac120a3ba0aea063b1b6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The initiator smooth list is initialized only in iwl_mvm_up(), but is
cleared in iwl_mvm_mac_stop. This may result in iterating over the
list before it was initialized in case iwl_mvm_up() failed early.
Fix it by moving the list initialization to an earlier stage.

Fixes: b68bd2e3143a ("iwlwifi: mvm: Add FTM initiator RTT smoothing logic")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 3f5cc6bf3f1c..b35c96cf7ad2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1727,8 +1727,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
 
-	iwl_mvm_ftm_initiator_smooth_config(mvm);
-
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_RFIM_SUPPORT)) {
 		if (iwl_mvm_eval_dsm_rfi(mvm) == DSM_VALUE_RFI_ENABLE)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 6f082059025a..8bb865e708dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1367,6 +1367,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	else
 		memset(&mvm->rx_stats, 0, sizeof(struct mvm_statistics_rx));
 
+	iwl_mvm_ftm_initiator_smooth_config(mvm);
+
 	iwl_mvm_init_time_sync(&mvm->time_sync);
 
 	mvm->debugfs_dir = dbgfs_dir;
-- 
2.38.1

