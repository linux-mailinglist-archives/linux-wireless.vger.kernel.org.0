Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E76CB8EE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjC1IAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjC1IAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E7420A
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990412; x=1711526412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Dz1JlyF8uBPoyRKq5x2mnVKdAEcD3KlKtT4HxawejQ=;
  b=ds+4rkMvi5BWvURd7OTbuepRMnQpV6p0+yY/PXRIITaCd2u5qUl6dC5u
   d3KDnejMbcTyhYWH0CnTgHd9un/zWnjmVw6f8AZC5lkHQuoYOzphV+h4N
   WHlQvy0fSXqP55EI2idgD0wV7k7bBupYOFpye9lr797OYQL+GQ8rkdOKZ
   6QQc+lMKT3W2hG+/JQXYF8fB1sESxHpxeJCcdLgYbW/1/71pdcRg3B7fA
   LHP4MP7JRJkHPFCTGRyCCnGCA6kQS9/VCIvJ6p7qcaHUzoqkpVHpVmYQQ
   osh6rIO8mdm4MPilu7smE6/5ftYBYTAU2W0MhV7fvDST6ORuebxIsMbZ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958130"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958130"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045144"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045144"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/31] wifi: iwlwifi: mvm: fix "modify_mask" value in the link cmd.
Date:   Tue, 28 Mar 2023 10:58:51 +0300
Message-Id: <20230328104948.19ddbee0c98d.I595abb79d0419c9a21e5234303c2c3fd5290a52a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This bitmap indicates what fields of the cmd got changed.
A field will be ignored by the FW if the corresponding flag wasn't set.
There are a few cases in which we currently set the wrong bits when
sending this cmd, which caused FW asserts. Fix this by setting the
correct bits in each case.

Fixes: 1ab26632332e ("wifi: iwlwifi: mvm: Add an add_interface() callback for mld mode")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5f54e57de8e6..33368e5945f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -54,9 +54,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		if (ret)
 			goto out_unref_phy;
 
-		ret = iwl_mvm_link_changed(mvm, vif,
-					   LINK_CONTEXT_MODIFY_ACTIVE |
-					   LINK_CONTEXT_MODIFY_RATES_INFO,
+		ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
 					   true);
 		if (ret)
 			goto out_remove_link;
@@ -162,7 +160,8 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	ret = iwl_mvm_add_link(mvm, vif);
 	if (ret)
 		goto out;
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE |
+				   LINK_CONTEXT_MODIFY_RATES_INFO,
 				   true);
 	if (ret)
 		goto out_remove_link;
@@ -270,7 +269,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		goto out_remove_mac;
 
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ALL,
 				   true);
 	if (ret)
 		goto out_remove_link;
-- 
2.38.1

