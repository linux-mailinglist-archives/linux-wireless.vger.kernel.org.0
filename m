Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D36CD29D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjC2HIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2HIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908830ED
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073699; x=1711609699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VoUaCKJz1zPDVqUDp1cNNOyUZJBcbbcqVnm+2sOP6UQ=;
  b=KC6TrO2MCnV1k0mFquIvpZDvEwFnqw4mdO1EKAlTUrIbe5hBjMdA9Mm8
   MMeJArFoU8NAL6JA8y2U44N+fybRiW2YLSAvvtqMhqgPJeXemMK0YzDmS
   zNuNWhhPkXRl+ZiEiRPtXzW5ZTkTvZHnVQAQdZjOeLy5XDmEmONKPyJRk
   aPSIrIFO4kKaTP5aV60PwxLWwv0rByW6hX3xVdYOAL2ukpDoyYVRrb3Q0
   GfR7Ucp8wMyMQA3df3To3nEbLRgxoM1/O2U879q3v7aVg5jVXu3WFSRoP
   8vfyiUs6mgTdCC9oQaVE9mRayiK2mxy3GXjIig+RwTT+HFUJjWskPRq8g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450972"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450972"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111439"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111439"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 27/34] wifi: iwlwifi: mvm: update mac config when assigning chanctx
Date:   Wed, 29 Mar 2023 10:05:33 +0300
Message-Id: <20230329100040.d7882a0d6e04.Ie38cd854a237c46cf85fd7143dc757326f30da6e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Some mac parameters, such as HE support, can change at this stage.
Update mac config before updating links.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index beef706d0598..4d56b2fc5f33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -231,6 +231,18 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
+	/* mac parameters such as HE support can change at this stage
+	 * For sta, need first to configure correct state from drv_sta_state
+	 * and only after that update mac config.
+	 */
+	if (vif->type == NL80211_IFTYPE_AP) {
+		ret = iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
+		if (ret) {
+			IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
+			return -EINVAL;
+		}
+	}
+
 	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
 
 	if (switching_chanctx) {
-- 
2.38.1

