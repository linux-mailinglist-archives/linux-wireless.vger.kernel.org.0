Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0247368B7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFTKEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFTKEe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3AE68
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255471; x=1718791471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HUDAYakNHzR01gNJQ0rWizq4vb3DPm9bHjmrZkUzn4=;
  b=KxP2srJr7ysgL5qQ3QIihtJjqrNKGf6uztFTBg7IW6gNAa7q7qoUL6jr
   eaGptDhasIIzAfnYv9mVoU3gg+ha6Kol335cJsuNGkSBYJLP2U7QaRcI6
   SBD9brNL3jwCjKlg+aM1m0tBhZkLJwK8LfYS+hTxHJlWvLqEOphTe8RY4
   AnmtMIplMQRbg3TKl0+CaUSt4XkYDAT98sNXjC3P51CEn/8BHhwbqJOe5
   fypvR7I6L2JeRF/Xoxvi9tfY+5Xk2epTvEPNXHNRR7rhYNGpNkI7Dv2q3
   fTBy8ymzq+ffc+A5uV0XZPqEopOyOBpI9t46Y+LPa3wylJetz8F3QZvKc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819517"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838142654"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838142654"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/19] wifi: iwlwifi: pcie: refactor RB status size calculation
Date:   Tue, 20 Jun 2023 13:03:47 +0300
Message-Id: <20230620125813.f3e87ddd5bce.Ifefba753043b68c394590a35bc6914a0f6497fd3@changeid>
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

We have three places doing this check, and even in
slightly different ways (with/without an intermediate).
Refactor that to a new small inline function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index da1a27b1d8b6..f87b28edc267 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -699,17 +699,25 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 	rxq->used_bd = NULL;
 }
 
+static size_t iwl_pcie_rb_stts_size(struct iwl_trans *trans)
+{
+	bool use_rx_td = (trans->trans_cfg->device_family >=
+			  IWL_DEVICE_FAMILY_AX210);
+
+	if (use_rx_td)
+		return sizeof(__le16);
+
+	return sizeof(struct iwl_rb_status);
+}
+
 static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t rb_stts_size = iwl_pcie_rb_stts_size(trans);
 	struct device *dev = trans->dev;
 	int i;
 	int free_size;
-	bool use_rx_td = (trans->trans_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_AX210);
-	size_t rb_stts_size = use_rx_td ? sizeof(__le16) :
-			      sizeof(struct iwl_rb_status);
 
 	spin_lock_init(&rxq->lock);
 	if (trans->trans_cfg->mq_rx_supported)
@@ -757,11 +765,9 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t rb_stts_size = iwl_pcie_rb_stts_size(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i, ret;
-	size_t rb_stts_size = trans->trans_cfg->device_family >=
-				IWL_DEVICE_FAMILY_AX210 ?
-			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
 	if (WARN_ON(trans_pcie->rxq))
 		return -EINVAL;
@@ -1193,11 +1199,9 @@ int iwl_pcie_gen2_rx_init(struct iwl_trans *trans)
 void iwl_pcie_rx_free(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t rb_stts_size = iwl_pcie_rb_stts_size(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i;
-	size_t rb_stts_size = trans->trans_cfg->device_family >=
-				IWL_DEVICE_FAMILY_AX210 ?
-			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
 	/*
 	 * if rxq is NULL, it means that nothing has been allocated,
-- 
2.38.1

