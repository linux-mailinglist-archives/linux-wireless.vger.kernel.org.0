Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFE177DBCC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbjHPILf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbjHPILN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA894
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173471; x=1723709471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGTMei5/u54eWFeKSsHE7erBUQYV5TXVjxUiJ3B3FnE=;
  b=VIYxuu6Gp+mKt28VRyXh0+7oX5yYOvj2kGRz932XNGAIEO9EFo+XB88p
   FeKTySPOTaLJNSESbK5rgP44eCO38k9GhPg5G2AS7k3oKURRKxl4KnbcT
   jmgAq275A9ZANTcLleE9486aQh0HWhag+8hNbttcN8VVb8ylZYKgvKqnw
   9X8tFFVhXKPEDdtvGT9Yrx4WtgByNhFzWXz6HkFQ452xUBgG4E8uVZFxK
   JexH8PoyhyPl9YQw1LwUK3AkPJpnjkO6DzPP2gYYHL4ebMujcPX5hkVBA
   F0RNXTlT+8eVdjgKEgSsogGRL64GUvQbenB2JbpkuYuvCjuoKEdvvvTbk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447779"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447779"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098729"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098729"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/12] wifi: iwlwifi: mvm: advertise MLO only if EHT is enabled
Date:   Wed, 16 Aug 2023 11:10:43 +0300
Message-Id: <20230816104355.ae4f9151440e.I6ce0b98d063d5005fd7a613454fcdb8b866a417a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If 11ax/EHT is disabled, then we shouldn't advertise MLO
support either.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ce7905faa08f..e7fe5b76def4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -315,8 +315,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
 
 	/* Set this early since we need to have it for the check below */
-	if (mvm->mld_api_is_used &&
-	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
+	    !iwlwifi_mod_params.disable_11ax &&
+	    !iwlwifi_mod_params.disable_11be)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 
 	/* With MLD FW API, it tracks timing by itself,
-- 
2.38.1

