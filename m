Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59346CB8EA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjC1IAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjC1IAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD04206
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990416; x=1711526416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0wLooAAoIKcNn7GaTpnVxQo+VoRqyStoGBOHl89yzw=;
  b=gnpaV68qh/ou7njbezONNFhFoZDa8pjWnKjE3JyL7SDLzCiKk4yb+/tJ
   Gid+l9hbCZ02uvfoQPzexPskF/bd2vZW5WgoOZ3fVFwrWED5ctsOcpRXu
   EjgBCHQov5lV95lKt4vsBbxCAMxi9qcpzON6pRyJZpgjA7j7yFu3xRlDK
   mxKX1Z+aOIx1VqEII22YESJhcMET3nJPJJDIYuJYHm5gcpbMqqNObjjg5
   LNmqTN9REEQD8icoDh3wWFmn+JWAuWj3dmFDrVEYUCbNtCyIc4ZBcAQVT
   NWndGGzs+q55htAFa0OcmjS7m0mDjZ8udcurt8GO5NjYuhOO3jJil8FUg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958151"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045158"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045158"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/31] wifi: iwlwifi: mvm: always use the sta->addr as the peers addr
Date:   Tue, 28 Mar 2023 10:58:54 +0300
Message-Id: <20230328104948.4c104c3074c4.I78912bb85251033e60db99a65165890779203612@changeid>
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

Currently we're setting the sta->addr as the peers address only if
the iftype is NL80211_IFTYPE_AP, otherwise we are setting the bssid to
be the addr. This causes bugs in TDLS. Fix this by always using the
sta->addr.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index fc380e59c740..41f6be7fe75e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -380,13 +380,8 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	u32 agg_size = 0, mpdu_dens = 0;
 
 	/* For now the link addr is the same as the mld addr */
-	if (vif->type == NL80211_IFTYPE_AP) {
-		memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
-		memcpy(&cmd.peer_link_address, sta->addr, ETH_ALEN);
-	} else if (vif->bss_conf.bssid) {
-		memcpy(&cmd.peer_mld_address, vif->bss_conf.bssid, ETH_ALEN);
-		memcpy(&cmd.peer_link_address, vif->bss_conf.bssid, ETH_ALEN);
-	}
+	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
+	memcpy(&cmd.peer_link_address, sta->addr, ETH_ALEN);
 
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		cmd.assoc_id = cpu_to_le32(sta->aid);
-- 
2.38.1

