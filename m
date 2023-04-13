Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89BA6E1444
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDMSlc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMSlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DC40C4
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411290; x=1712947290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zg8JPzKMZrbUBXTYqM2zXTWbjDh2Y9lr72BZeurZJDE=;
  b=QXCIG669HhmsvHDAa7FlDO9R/SSz52HzUbT8km8+c5mVF/OF64+k1V72
   M3CX0ouTi5YRijGpQrt3UL6W47id8S3Uem5HLfeQaG6URVoPk3eCeHyxz
   ClgKwDYTGRSJKeUpn3p1/bzJCygjDTSE1QzXKvY2B1Nf9TDse/MH9eQ9d
   EDiuucmgsc2+odydkbeYBwpu3Bc5HSkV+PrN7jyhtytvxxYYv3lWfnKmI
   X922Qa7OdqqAMbPnydtEjUSKVUASxq/3pwEvMsx9W9xq2AmR4yATQuAH8
   lSQIyXMadV4oi5gCmLXsWBB1cireAhipgTYevt1eg1+UKiwuI/Q6HmguS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372126952"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372126952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984330"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984330"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: don't drop unencrypted MCAST frames
Date:   Thu, 13 Apr 2023 21:40:22 +0300
Message-Id: <20230413213309.9cedcc27db60.I8fb7057981392660da482dd215e85c15946d3f4b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

MCAST frames are filtered out by the driver if we are not
authorized yet.
Fix it to filter out only protected frames.

Fixes: 147eb05f24e6 ("iwlwifi: mvm: always tell the firmware to accept MCAST frames in BSS")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index e08dca8d2baa..b38b24246675 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -383,9 +383,10 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		 * Don't even try to decrypt a MCAST frame that was received
 		 * before the managed vif is authorized, we'd fail anyway.
 		 */
-		if (vif->type == NL80211_IFTYPE_STATION &&
+		if (is_multicast_ether_addr(hdr->addr1) &&
+		    vif->type == NL80211_IFTYPE_STATION &&
 		    !mvmvif->authorized &&
-		    is_multicast_ether_addr(hdr->addr1)) {
+		    ieee80211_has_protected(hdr->frame_control)) {
 			IWL_DEBUG_DROP(mvm, "MCAST before the vif is authorized\n");
 			kfree_skb(skb);
 			rcu_read_unlock();
-- 
2.38.1

