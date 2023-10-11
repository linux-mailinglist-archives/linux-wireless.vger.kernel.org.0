Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D987C4FEA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346256AbjJKKS3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjJKKSL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:18:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F361BFA
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018874; x=1728554874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWANzQ9T/QGDKqgs06ShgCH2sHgnaVQIv/mfQCgfJpk=;
  b=UkbHJpg+yLHVF32KtQwKrn4+PZ2MLVb9xHkXsOe8X0aEi+Uf7lDSgj2x
   Dv8gkl61cDl1R2kQswT2F1z/p1nfAAwYLkNm9rjKMFo2mJ41mE7yEPJ4U
   dsfACXJ9IM3dps9oOZVkrQ8ZhnLn0DCQPH/sE4goAD9JQuu3bZXml1+3n
   rZYPTUcIKkDy3wTNsfVFNj9t6tGrJPTYFRrMoSZ04ju2JDJF1WLab3V/G
   wH5kIXg8iIUh5fJ+oWtHUjvD/YB83cej6RYPrIoFXbpZCyKn/X/RslSpD
   59li5qUBYUlN7U5bNd0sNok0jI3UZBcpq+wyPL3n+eePtpx/qaHyCGbT/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670583"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670583"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050266"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050266"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/16] wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface
Date:   Wed, 11 Oct 2023 13:07:20 +0300
Message-Id: <20231011130030.f67005e2d4d2.I6832c6e87f3c79fff00689eb10a3a30810e1ee83@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When an IGTK is installed for an AP interface, there is no station
associated with it. However, the MFP flag must be set for the installed
key as otherwise the FW wouldn't use it.

Fix the security key flag to set the MFP flag also when the AP is
an AP interface and the key index matches that of an IGTK.

Fixes: 5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index f49820647041..ea3e9e9c6e26 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -96,7 +96,12 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
 		sta = mvmvif->ap_sta;
 
-	if (!IS_ERR_OR_NULL(sta) && sta->mfp)
+	/* Set the MFP flag also for an AP interface where the key is an IGTK
+	 * key as in such a case the station would always be NULL
+	 */
+	if ((!IS_ERR_OR_NULL(sta) && sta->mfp) ||
+	    (vif->type == NL80211_IFTYPE_AP &&
+	     (keyconf->keyidx == 4 || keyconf->keyidx == 5)))
 		flags |= IWL_SEC_KEY_FLAG_MFP;
 
 	return flags;
-- 
2.38.1

