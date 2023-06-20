Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC47368BB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFTKFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFTKEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA14170A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255475; x=1718791475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkc1CTFyJB127sT2X9YtR5meF92MSH89pGlRicmhgQc=;
  b=mVP3LIH+ELG8a4dmW7KKCD6UT2wegTMBL1WNoKVVylsFjT2aUlw1kQdU
   I1d1E7kBA3lXgWR7PuX+Zlam4WcvQaQIp2TgUjlmtvxhnJKF9i0cBw7yu
   e1DPfcsvs2bkAnoatRLbieeG4kMeL6VSUrj8e/M9qlv4SljWNsLCMiKD9
   Xu3aG74Avq6vrO5z10S6kQEyS4GH80LHJhWJOI3S3LxPdnOl28Kh2GofR
   SPegQJ5QM/iSDk/HFK3nAIAx93Fp8TV15j1v2wBVxipF5arIuGS3kz8X4
   98v1itg45Ecz/VyKQkHddvoGmK8yAruamum/SS3EWXsUN7LS80QOEnjKS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819525"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819525"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838142796"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838142796"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/19] wifi: iwlwifi: pcie: add size assertions
Date:   Tue, 20 Jun 2023 13:03:48 +0300
Message-Id: <20230620125813.8f54f2990b92.If19a038dfd633d4601e3d44dd0ff678bc0a851e9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Ensure that the TX command scratch fits into the buffer
provided by the first TB. It does, of course, but add
some build-time validations in case we touch this code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 3546c5269c3b..1337fa95f657 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1547,6 +1547,9 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	/* there must be data left over for TB1 or this code must be changed */
 	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
+		     offsetofend(struct iwl_tx_cmd, scratch) >
+		     IWL_FIRST_TB_SIZE);
 
 	/* map the data for TB1 */
 	tb1_addr = ((u8 *)&dev_cmd->hdr) + IWL_FIRST_TB_SIZE;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 245bff01b4f8..fbacbe9ada15 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -648,6 +648,13 @@ struct iwl_tfh_tfd *iwl_txq_gen2_build_tfd(struct iwl_trans *trans,
 
 	/* There must be data left over for TB1 or this code must be changed */
 	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen2) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
+		     offsetofend(struct iwl_tx_cmd_gen2, dram_info) >
+		     IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen3) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
+		     offsetofend(struct iwl_tx_cmd_gen3, dram_info) >
+		     IWL_FIRST_TB_SIZE);
 
 	memset(tfd, 0, sizeof(*tfd));
 
-- 
2.38.1

