Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668A272F999
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbjFNJp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244298AbjFNJor (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8244D2708
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735830; x=1718271830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZdrH+0fm+EyPDVvKWUDpYe/CxE09ZUKG7S0mnLcE3bM=;
  b=VATPI3tnQUyuXS3sfVlPLaund8G2g/G4xrSXOS8z/AlTnlQN1vamuO8I
   69Lfrr+AJx7TjGqFu2GrVEG3QwCSVxRDMrFPhTA3cnrLl1o1NCA3OdPqY
   whUWOI5CZhRiTQAYUC+E5cuNBykxZ+yNqeIhGmzZlSPTUf2xjvnwO3SoA
   kp6Vr7NND7/DarPOVC0h9eu2dD/dth1ob+/tfzslxnhRk0Hye1OqMH2Xb
   qLCCY3F/5Tgfi1sp+HQ8Gxrkp10whO8BwgJ1uXUFUZwR6UvNxgcZ5QmG8
   I9TUgOw3g/c+Eclzhb+DwjD+TCGOkWLck4J6+DVFKRh4/Il8mlWWj7l/r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049861"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049861"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989867"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989867"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/20] wifi: iwlwifi: mvm: disable new TX csum mode completely
Date:   Wed, 14 Jun 2023 12:41:27 +0300
Message-Id: <20230614123446.aded25a6c288.Ia6921e4b8a9624d4f57489ac775105ed0e400313@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

For now, disable this mode completely; we need to do some
real validation/integration of this new feature on some of
the hardware first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d8d6681e9411..97ec100103b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1545,15 +1545,7 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 
 static inline bool iwl_mvm_has_new_tx_csum(struct iwl_mvm *mvm)
 {
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
-		return false;
-
-	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	    mvm->trans->hw_rev_step <= SILICON_B_STEP)
-		return false;
-
-	return true;
+	return false;
 }
 
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
-- 
2.38.1

