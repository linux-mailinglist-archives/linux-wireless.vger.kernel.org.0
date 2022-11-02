Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFABC61657E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKBPBM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKBPBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:01:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BEE2A974
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401268; x=1698937268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t52MlG452EomOIcuvqgpmKPAVzIKYRvDLfN++Xk9CL0=;
  b=YYpj4b977awRPvNlP8x4Fz+vPtxoIPEkfH1uBsTFKxrTlc0P5DEln+Yc
   mKjgTyJQy7qAbEpFARRJ83SJh33+dpChVxDL30jq/eAdc9Bwnjt546AHs
   YKy3V5/MPTJpApH4pxsxsQIhFz7By4AyM5eWIsgeRk3Jsjxk8BK9594BQ
   BO0yXurK6kgT08Kalo2mHr1MGooBRKz5Veysb1sK+CB0WN3Tn+DM04DuP
   SkHHI4lWKZFV2jT2TEzm77CZaQ6pIAyLGK796yEY7iz2BmUpSjNNBDYCY
   sNFEFa7wIlSDTowOEKnZMSUvE7n0y3I2KpXGpBD+UIrU44tNM3TQ3dVA6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523574"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523574"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810685"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810685"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:56 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: mei: use wait_event_timeout() return value
Date:   Wed,  2 Nov 2022 16:59:56 +0200
Message-Id: <20221102165239.33159054626f.Ief9e2dc42f96f8044c197d32172003a5ead0f8d3@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

wait_event_timeout() return value indicates whether the condition
evaluated to true or not, so no need to re-take the lock and
check the got_ownership flag.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index a467da8b2aed..ef5d2938deb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1447,26 +1447,7 @@ int iwl_mei_get_ownership(void)
 
 	ret = wait_event_timeout(mei->get_ownership_wq,
 				 mei->got_ownership, HZ / 2);
-	if (!ret)
-		return -ETIMEDOUT;
-
-	mutex_lock(&iwl_mei_mutex);
-
-	/* In case we didn't have a bind */
-	if (!iwl_mei_is_connected()) {
-		ret = 0;
-		goto out;
-	}
-
-	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
-
-	if (!mei) {
-		ret = -ENODEV;
-		goto out;
-	}
-
-	ret = !mei->got_ownership;
-
+	return (!ret) ? -ETIMEDOUT : 0;
 out:
 	mutex_unlock(&iwl_mei_mutex);
 	return ret;
-- 
2.35.3

