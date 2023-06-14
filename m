Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08FC72FF11
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbjFNMu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbjFNMuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 08:50:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A71FDC
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686747021; x=1718283021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1YUrde8WAlqhx1ssREX3yqssgOgZ1qyi2/9x6R85LQI=;
  b=KHFBR8HsEizU/yGC2dXGWhUP9GPMroSRpYDqm/0aEvgXuopJ3pGs9lLp
   3yysC8fzXUaKow8vxSFPRWfvyEX8c2RyO0VXC9BWEPNJWqPuaSd3kpi65
   /RPKU5aOr5NYju7M4YfDfFh1fQ7akzQQyt87d+hWyC46XRIJmceruBrjR
   Wi7Caa8QUeyZhJRNgqHtFu8OxYDeTM4yz558o1Bgpqdh/c73gAzlORSqQ
   yIYP7GPb+//h5GW5MyZkKOgmF0EyP8utZrwzaTaYc3D+X12zKfTir7boi
   /wpotoIKBZzJOlw0YVLakdyszGiueuXXsX5Idpi7zBL0FF74Q/CjAQvU/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="444970854"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="444970854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="836256816"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="836256816"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:50:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 08/15] wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
Date:   Wed, 14 Jun 2023 15:50:08 +0300
Message-Id: <20230614154951.78749ae91fb5.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

While vif pointers are protected by the corresponding "*active"
fields, static checkers can get confused sometimes. Add an explicit
check.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index ac1dae52556f..19839cc44eb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -647,30 +647,32 @@ static void iwl_mvm_power_set_pm(struct iwl_mvm *mvm,
 		return;
 
 	/* enable PM on bss if bss stand alone */
-	if (vifs->bss_active && !vifs->p2p_active && !vifs->ap_active) {
+	if (bss_mvmvif && vifs->bss_active && !vifs->p2p_active &&
+	    !vifs->ap_active) {
 		bss_mvmvif->pm_enabled = true;
 		return;
 	}
 
 	/* enable PM on p2p if p2p stand alone */
-	if (vifs->p2p_active && !vifs->bss_active && !vifs->ap_active) {
+	if (p2p_mvmvif && vifs->p2p_active && !vifs->bss_active &&
+	    !vifs->ap_active) {
 		p2p_mvmvif->pm_enabled = true;
 		return;
 	}
 
-	if (vifs->bss_active && vifs->p2p_active)
+	if (p2p_mvmvif && bss_mvmvif && vifs->bss_active && vifs->p2p_active)
 		client_same_channel =
 			iwl_mvm_have_links_same_channel(bss_mvmvif, p2p_mvmvif);
 
-	if (vifs->bss_active && vifs->ap_active)
+	if (bss_mvmvif && ap_mvmvif && vifs->bss_active && vifs->ap_active)
 		ap_same_channel =
 			iwl_mvm_have_links_same_channel(bss_mvmvif, ap_mvmvif);
 
 	/* clients are not stand alone: enable PM if DCM */
 	if (!(client_same_channel || ap_same_channel)) {
-		if (vifs->bss_active)
+		if (bss_mvmvif && vifs->bss_active)
 			bss_mvmvif->pm_enabled = true;
-		if (vifs->p2p_active)
+		if (p2p_mvmvif && vifs->p2p_active)
 			p2p_mvmvif->pm_enabled = true;
 		return;
 	}
-- 
2.38.1

