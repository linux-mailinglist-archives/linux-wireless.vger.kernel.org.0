Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC372CAAD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjFLPvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjFLPvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB110C7
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585108; x=1718121108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUgsLydm42k1NLWRGtiGNHBwLqEZKDnCnXT7L1Ax4GM=;
  b=euhKsw53irDk1elTPWpd8gPaY2ttSsgUkJtBqQl00QXi9NqeZnh2taJo
   rj8I8DGjpXThDVjQit+eM9hv+o4HENSAHAvlVKHObwe0UssX1uGlxuOM1
   VWe2Df9kapknnn9WQD2erI11DQ6l+7jayxq1HdHGFpi7ldyevBGTN1pH0
   yDJS6irA1XlTZVcXHOVaZkag/pvrTIai+N//pW4ZW7sjK7N4aY8r+xh6F
   uLrOgR2M/cU0UbSnmCGf3A9XPibPBPQLHY4O4iG2wWjMLtCPeNh7qjONi
   wHAyYhYyynvVQ/CXfuP/7AAdqxDXXTAJt/G2ikyRo5dgDuzaeS4vLBfXV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674246"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674246"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499336"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499336"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
Date:   Mon, 12 Jun 2023 18:51:09 +0300
Message-Id: <20230612184434.cf7a5ce82fb0.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The p2p, bss and ap vif pointers are assigned based on the mode.
All pointers will not have valid value at same time and can be
NULL, based on configured mode. This can lead to NULL pointer
access. Add NULL pointer check before accessing the data from
vif pointer.

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

