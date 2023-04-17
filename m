Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59B6E42C5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjDQImK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDQImI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2F44AC
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720926; x=1713256926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GUzS5xP6pui6pvwHlMgpajTrUyejiD7BuPpvrNmApSM=;
  b=BbLFVpJiHGR3Gz+dDG25fJMuDQUW88LmPVLrEkwRwvPHlpj9Q+3TG9Ha
   swPCryFV0zYKQXy4Ose009a3PKYQkB+gsab03XqmJQGnof0/9nkeo2Rl1
   ehXwBGaUUjGLD6/m6Sv6UDE0m9BbYbyD3yiacNCM7Q/L/5rNWnLYuy6In
   +vdey3f7vqSLLw2ASbUYQsQatHOM6A2jtFjElQlVMbUefDiKeVuZAybFX
   ZjEbzNuwGBfMCsK2fLrIPo2KfKEFxs7tLfrI2q1zyLXSrdr4XOnVEXMJq
   NthO1kO4rilmjCnoyYU6pERSK9abehxSNHkb/pw74Ly4SshzLSw9V3LIG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634312"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173803"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173803"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: update mac id management
Date:   Mon, 17 Apr 2023 11:41:21 +0300
Message-Id: <20230417113648.e4355615da92.Iba934ccf8589c3c27a25a390dc5e938312889b45@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The restriction where MAC ID 0 could be used only for the
managed/IBSS vif is not required when using the new MLO FW API.
Update the driver.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 389eef453d17..cc90f2884cff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -225,16 +225,20 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * that we should share it with another interface.
 	 */
 
-	/* Currently, MAC ID 0 should be used only for the managed/IBSS vif */
-	switch (vif->type) {
-	case NL80211_IFTYPE_ADHOC:
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (!vif->p2p)
+	/* MAC ID 0 should be used only for the managed/IBSS vif with non-MLO
+	 * FW API
+	 */
+	if (!mvm->mld_api_is_used) {
+		switch (vif->type) {
+		case NL80211_IFTYPE_ADHOC:
 			break;
-		fallthrough;
-	default:
-		__clear_bit(0, data.available_mac_ids);
+		case NL80211_IFTYPE_STATION:
+			if (!vif->p2p)
+				break;
+			fallthrough;
+		default:
+			__clear_bit(0, data.available_mac_ids);
+		}
 	}
 
 	ieee80211_iterate_active_interfaces_atomic(
-- 
2.38.1

