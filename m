Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D67187CF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEaQvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEaQvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6E134
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551892; x=1717087892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIOBt2Li3b9zlD54zBAZPhD4mnjpOQBkmMh2KXsfCH4=;
  b=kper3ATHZCmgChQq2Umv/b45e/Ysi9KpHr8KgzJ5JXNfxbIvulWxDHYO
   OnHGkXhXTCbPBqWPJY5LsF+UN7t6yeUFyJoJsPA0Y4QxkOE8BVDAN4eC+
   ZGdIzoNXXkZUDscWxt4Bzv5oNmRuHoXnLiULbe8t8CD9oo6IaDz7V1LUp
   W5E8aM5XiRcCJjCuChqjnMxw/CMt4/RU8Dh3C8VC2tTM9O63xbILcuO4M
   ofpUbTzu8+hoS0L831uYD8bWb/hFTLe4V7relE/DB598TrI+BIQhb7Ju1
   Ho2H+6AIhzdDw/rWRYxO0kLbJMe67pIPJaxnKxv7q8KutISotguyc1jC3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890522"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890522"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987973"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987973"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: pcie: adjust Bz device timings
Date:   Wed, 31 May 2023 19:50:00 +0300
Message-Id: <20230531194629.9a5627c1ff18.Ifcfbccd5458bd9ebd496aa834284fb0facfcaaef@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The 100ms shouldn't be needed, only 10ms. However after
reset we should have 10ms as well for these devices.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b281850fbf7a..db10bd3c1058 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -131,13 +131,15 @@ static int iwl_trans_pcie_sw_reset(struct iwl_trans *trans,
 				   bool retake_ownership)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
-	else
+		usleep_range(10000, 20000);
+	} else {
 		iwl_set_bit(trans, CSR_RESET,
 			    CSR_RESET_REG_FLAG_SW_RESET);
-	usleep_range(5000, 6000);
+		usleep_range(5000, 6000);
+	}
 
 	if (retake_ownership)
 		return iwl_pcie_prepare_card_hw(trans);
@@ -475,7 +477,7 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
 				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
 				   100);
-		msleep(100);
+		usleep_range(10000, 20000);
 	} else {
 		iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
 
-- 
2.38.1

