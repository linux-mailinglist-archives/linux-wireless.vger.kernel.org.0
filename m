Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F486CD28D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC2HHX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjC2HHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836340DC
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073627; x=1711609627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n3Y+x4SDdtN7RueS3Alov5U7wwsPeMJjRdkFWNotdfE=;
  b=k5YiDDIaogC/cLk/5ZWaMgCNsZpM+q3XDTlWxpzIqAoWSgx2v0m1iyg5
   ZGdzYlQXJYr1temywfET+YYK8WYm9hUMbiQvXSF913eJSPiJKcCYrHqNs
   xjYauvxjqq3EEJ2rxe3V41do20yzm/VmZC8O59X43yVJdTkFnlEusJpM/
   Q4hbchFig+5rjtK1SVvaUsIprntHiWzBvennVDUjL5V3Y/AxREv7TdZOU
   9c9LcwMSjDn2Y4O6bB/2AaU+xpVzc32D/60pknYOyRoDgOITiStD/JWGF
   UTvw5aTJwaCIgR9gmHMESvJXnJ8I3IN2sl83+DT8svbsKkqEYJme1Hsl3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450795"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111303"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111303"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/34] wifi: iwlwifi: mvm: use the link sta address
Date:   Wed, 29 Mar 2023 10:05:17 +0300
Message-Id: <20230329100039.03ab287da0ae.I88fb5ab4e3ea9c886a3fac7ce09c4791469c3c8e@changeid>
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

From: Shaul Triebitz <shaul.triebitz@intel.com>

Replace the deflink.addr with the proper link address
for setting the peer_link_address in the station command.
For a non-MLD station, it will be the deflink.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index da9d2cefa509..c877c94dd1d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -399,8 +399,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 
 	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
-	/* FIXME: use the correct link */
-	memcpy(&cmd.peer_link_address, sta->deflink.addr, ETH_ALEN);
+	memcpy(&cmd.peer_link_address, link_sta->addr, ETH_ALEN);
 
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		cmd.assoc_id = cpu_to_le32(sta->aid);
-- 
2.38.1

