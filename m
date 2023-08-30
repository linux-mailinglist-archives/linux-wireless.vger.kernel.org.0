Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01A78D999
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjH3Sde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjH3Ibg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B841A6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384294; x=1724920294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+6ZD56FOk2eKaqtxKlE8HpvhGkTXLOER3pcib5rtRQ=;
  b=gETZAusfsmvjUDRCOmO7u2WNLYaYrlnAwyynBpXpdI3IbUowfsW5Eov0
   Byd4eZChAWlruPqQPbALaensJZGQ1stHkv6uyyLy50JORqLrP9yjyA6sn
   g0/pqvAtPMORg4EId/LxD6UiTsAgSMZuuT8TiObSiS32EIOZeTgXAuP1d
   VNSIltTMPiy5mWnWQ73MzyPfzUlXZnsTYqysAxt7Y68VCIe0k8+SdTGCq
   E58kd5h1WdaXiBdB/xwmchi5EeLpqK3loiNiOBorm3gRDoKj9+tp3/sjk
   Re5btH9S6ZucoGLG6dpbxkCpyGtW3tJld3Tn5YibZlFjf91Huvv2Qw/lD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958922"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152088"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152088"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/16] wifi: iwlwifi: don't use an uninitialized variable
Date:   Wed, 30 Aug 2023 11:30:54 +0300
Message-Id: <20230830112059.431b01bd8779.I31fc4ab35f551b85a10f974a6b18fc30191e9c35@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Don't use variable err uninitialized.
The reason for removing the check instead of initializing it
in the beginning of the function is because that way
static checkers will be able to catch issues if we do something
wrong in the future.

Fixes: bf976c814c86 ("wifi: iwlwifi: mvm: implement link change ops")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8b6c641772ee..9615bfff7f7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1084,9 +1084,6 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (err)
-		goto out_err;
-
 	err = 0;
 	if (new_links == 0) {
 		mvmvif->link[0] = &mvmvif->deflink;
-- 
2.38.1

