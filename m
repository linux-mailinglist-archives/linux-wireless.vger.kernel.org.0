Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF66CB8F9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjC1IA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC1IAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32CA422A
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990419; x=1711526419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8o0+UYJLTXzkachVRluZe4nma5arc7xEmE3a0IQJxx4=;
  b=jvHpd+/eGZRQEOmEb9FsRMjsOfSUOruih/ZVAXEnDe7EuFETskj3cvGh
   Jxfeiwf4t/y+Ll5MXXxymdAcEKJ5/vABwGVkwaxV6CnpHQDSdcvWwk/py
   v6fi99Gqyxv+bjG1AHegq4VDqJ/qMU6TvP4xwvOBXg155j4B5rLbt2rUX
   2tZE853AWaMy97iqXus0830KkFo7vx97Zpou1WCWzMXsn+NnigC/6xaxJ
   4PobEL8CzllLXGnaAA25e7rC0wRtzp5AQcn6QfaC8NifTSCE3hYZQNBaw
   z4JFCXA1VBXa9T98fH+Am8UWX/Y+3DEbd4CiJdgLd824VJ3QkLN5g3gXQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958231"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045283"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045283"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 22/31] wifi: iwlwifi: mvm: don't check dtim_period in new API
Date:   Tue, 28 Mar 2023 10:59:02 +0300
Message-Id: <20230328104949.02354241fede.Id957bed3851fdf1fe902d79a1b0338c6d80bc0e1@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

In newer firmware APIs the firmware is responsible for tracking
the DTIM period and other beacon timing, so we don't need to
wait with setting associated. In real MLO operation, mac80211
isn't tracking this anyway, and connections wouldn't work.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index c9a0f68c5d48..ab0ba85936b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -102,9 +102,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 		cmd.client.ctwin =
 			iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(mvm, vif);
 
-	/* FIXME: assume for now that DTIM period is the same for all links */
-	if (vif->cfg.assoc && vif->bss_conf.dtim_period &&
-	    !force_assoc_off) {
+	if (vif->cfg.assoc && !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 		cmd.client.is_assoc = cpu_to_le32(1);
-- 
2.38.1

