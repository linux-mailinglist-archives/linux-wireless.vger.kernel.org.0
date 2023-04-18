Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABC6E5D5D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjDRJ2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDRJ2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB359DC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810121; x=1713346121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkKl8jtoJBNLR9RH54X6HK8GpbTAMsqO6yJ69P/JiK4=;
  b=lNEu8QN+4B8yb7OGd1KIjMi60a8pbUr/s67c+OStF6GlgGJIiPInlWXw
   uRHVu9fReku1ZG8HOb+b257lbCy/gEh37dpv+6YMgrTbBnolyTxvCAcvI
   DLL9sofGmFlAN4X2ZQEARcgzytIKu0/77MCbYkfnARmg1iVGuRggV3UcE
   p7m0h+2hauJv5PK/9DxI3n8aAxxMSfNj9qgi1OJqGPN6T5ApcHyGkI7KH
   N93CEQ7tdX2zv6jqQ0Bo2oie3/CUT+C1cwZBt07p3+4T7frkizfah7Yhi
   /DSGB9xdZzCHZjtmmdyDP/1VMa5Sq9YyqQC3F52WQF1zXdloLuJdlqOlP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341182"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511230"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511230"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: mvm: enable support for MLO APIs
Date:   Tue, 18 Apr 2023 12:28:10 +0300
Message-Id: <20230418122405.0ae0dd6f0481.Iec993cf0f28eacb2483fb9d1e755b0b2fd62e163@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Enable driver's support for MLO APIs to unlock this functionality.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 51399284e097..0f01b62357c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -305,6 +305,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	ieee80211_hw_set(hw, BUFF_MMPDU_TXQ);
 	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
 
+	/* Set this early since we need to have it for the check below */
+	if (mvm->mld_api_is_used &&
+	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+
 	/* With MLD FW API, it tracks timing by itself,
 	 * no need for any timing from the host
 	 */
-- 
2.38.1

