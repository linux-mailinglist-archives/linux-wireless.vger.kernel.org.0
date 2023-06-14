Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E772F9AD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjFNJpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbjFNJot (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240E2712
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735833; x=1718271833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hL+OGXLwo2Va+5yYsooSBGEKMXV3AfpcFsayzF+ssj4=;
  b=RmOIB+xeFefBvi6i5A4RxHwkmlOnuShwxM+vysDDptkMVwTV72LTEeaI
   o6TRhyYKQ5regrOH++wKn77VWN7OHkTHJqy9DAuIIrZbEAOkZZdZWDici
   1OwgiBXIjuhmcToAade6Stuy2Ainb8STS518ggUShVF/JYk15jzJhYRO/
   aUwWscjBArspWx6yukhooDL92HUf7sO3osCJhAOb1dncpnYY0PT6XWVuU
   vdB6yQ+BpkCLcZRVvb+cNVaUFv5yDX6ZDtatJXXFUlRWMSdvjzX4K66Xv
   zrsZsia8dAY1agcfjBVsGLzr9P40Iz4qNqh+inWZu76NiDOIGjFr388YU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049869"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049869"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989879"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989879"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/20] wifi: iwlwifi: use array as array argument
Date:   Wed, 14 Jun 2023 12:41:29 +0300
Message-Id: <20230614123446.6fb4a9743b1b.I801007d207f6539a9e0996366ec593e2038b1f90@changeid>
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

When calling iwl_mvm_set_fw_qos_params() we explicitly pass
a pointer to the first array element, but the function will
treat it as an array. Simplify and clarify the code and pass
the array instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index dc31f8de7d1d..af9ace787ec5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -183,7 +183,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 					&cmd.protection_flags,
 					ht_flag, LINK_PROT_FLG_TGG_PROTECT);
 
-	iwl_mvm_set_fw_qos_params(mvm, vif, link_conf, &cmd.ac[0],
+	iwl_mvm_set_fw_qos_params(mvm, vif, link_conf, cmd.ac,
 				  &cmd.qos_flags);
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 61c1ec46a2fb..a2583d045525 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -563,7 +563,7 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	cmd->filter_flags = 0;
 
-	iwl_mvm_set_fw_qos_params(mvm, vif, &vif->bss_conf, &cmd->ac[0],
+	iwl_mvm_set_fw_qos_params(mvm, vif, &vif->bss_conf, cmd->ac,
 				  &cmd->qos_flags);
 
 	/* The fw does not distinguish between ht and fat */
-- 
2.38.1

