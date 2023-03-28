Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47D6CB8EB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjC1IAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC1IAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA944694
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990414; x=1711526414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ce1lmHq4VM7PlmQRhonJMLBx6S0dZD3mMfcbCd0+oBk=;
  b=Oc7bE4koe7Sq/mRLLO0bzBCFjbxulAFQ/9DqezZgjoK3PVaWKmkfWFI1
   BfuLGoUIlP9x5swyVWiQSl6JmQRdHieaH9nI0zBgV9oTNeFC99vne4pTm
   an2mYfuqXb44FJLGBIpZpDLWxUH9iK5GdnrWMjMPTAhE6V52V662RR3JS
   PkZSsBq/IMsqvckvSSz0u2dyyGJPg34qSXa/T+fUn5N7lLn8VexOXpodG
   76/2h5/pQea8ml3ZYaGv+hvZt4YV1tOQINxDi/3rRfY2DFjoz9mJ34k1g
   xwcyJ2jwpUibgF8LKyBbm3NUZCWZ3SsyNDgXKINYzyKseFnwSXYuu/f0Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958145"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045152"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045152"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/31] wifi: iwlwifi: mvm: modify link instead of removing it during csa
Date:   Tue, 28 Mar 2023 10:58:53 +0300
Message-Id: <20230328104948.c07ca7aace29.I4ed5c77f4afe1b5da19322734e2f84d51aa541ad@changeid>
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

During CSA the PHY used by the link is changing, So the driver
needs to modify the links phy to the FW. Currently the driver is doing
it by removing the link and adding a new one with the new phy_id, but the
FW expects the link only to be modified. Fix this by modifying the links
phy_id instead of removing it and adding a new one

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 33368e5945f4..5be8058ca669 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -157,9 +157,16 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 						switching_chanctx, &ret))
 		goto out;
 
-	ret = iwl_mvm_add_link(mvm, vif);
-	if (ret)
-		goto out;
+	if (!switching_chanctx) {
+		ret = iwl_mvm_add_link(mvm, vif);
+		if (ret)
+			goto out;
+	} else {
+		ret = iwl_mvm_link_changed(mvm, vif, 0, false);
+		if (ret)
+			goto out_remove_link;
+	}
+
 	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE |
 				   LINK_CONTEXT_MODIFY_RATES_INFO,
 				   true);
@@ -219,10 +226,9 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	/* Link needs to be deactivated before removal */
 	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif);
-
+	if (!switching_chanctx)
+		iwl_mvm_remove_link(mvm, vif);
 out:
 	if (switching_chanctx)
 		return;
-- 
2.38.1

