Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C716E3853
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDPMsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDPMsC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A626B5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649281; x=1713185281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0OH/Mtm0PDmaoJxSO0rIlda2qiI1rjUrPokMu5t52BY=;
  b=HjI8daPkTi/kSU/9n67Ao6QcBXa0U8H5sVEgCo2soCahh3neKVoqWQDj
   wA6YGxeDpkOGGm31juzlrppcm8CXqslTzzg8e3bXsWYSku3FvO7CZMxQ2
   0M//mD+Gjms7aQcy8E5wgP9NWDxjDemwCdFZidywjKjPzMM7AbdaDse05
   M6t6W3ryDouQw9hj3KB8+Nw9jw5eoQScAyMjw6VRBBkeyA91tq4nXfANv
   B5ZUanxE0IFQnFD7JJkCoJYdxmNUMo+f5KqoIc5l9xyb4loPf2EHsRP1q
   x67vQjh2JfsT1eylIDQEABoQjGLWU7jRd0YwUcPyIoCv3WnOcWR+MrzRf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520552"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670421"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670421"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: Fix _iwl_mvm_get_scan_type()
Date:   Sun, 16 Apr 2023 15:47:28 +0300
Message-Id: <20230416154301.e08293d6cace.I25f8cea3189472bd714676ca38b121d7c60fb9d9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The usage of the 'dtim_period' value was wrong, as it is only
a multiplier of the beacon interval, and thus, beacon interval should
also be considered. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7ac9bdbfe194..38b68827a4bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -240,8 +240,9 @@ iwl_mvm_scan_type _iwl_mvm_get_scan_type(struct iwl_mvm *mvm,
 		 * set all scan requests as fast-balance scan
 		 */
 		if (vif && vif->type == NL80211_IFTYPE_STATION &&
-		    vif->bss_conf.dtim_period < 220 &&
-		    data.is_dcm_with_p2p_go)
+		    data.is_dcm_with_p2p_go &&
+		    ((vif->bss_conf.beacon_int *
+		      vif->bss_conf.dtim_period) < 220))
 			return IWL_SCAN_TYPE_FAST_BALANCE;
 	}
 
-- 
2.38.1

