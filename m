Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391176E5D5A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDRJ2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJ2i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8ED61B4
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810117; x=1713346117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbDkro8/rCs1aEMDOqM1IrT828sNwMOOKezHeP13VeU=;
  b=YmsMCJ9OM/6NqKB2GFPdr/SyVPlqoiaiTGJgey/AlM+sGD2uw2sunAwe
   wTRejd4/3HBFjWmnUzqWjs/gAWk2pILlvKnF0y7LKNWZnyId1C4E5vkg5
   CcCsWNKALeUERbeY3jhZGh4F/Wtq11Y+CFd1WOm8BJHSEzpt4eitQL1lE
   SRKp7u098j4Q0Oiu5n2x4eh/1RM8iqKzCrOESVVSN9T9DN2no4sdaSD1d
   gup9EBEmag03FV6FLvLV+yA8+5oxH6f+GnEbDj1ajEYqnheB/qiqpqiq+
   4MOvP+J9OnRL0kA/mk7Lewwut3xZF3Au6Y+jzoNUMQPHiNBTfl0TDcDTd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341175"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511224"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511224"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: mvm: fix potential memory leak
Date:   Tue, 18 Apr 2023 12:28:08 +0300
Message-Id: <20230418122405.116758321cc4.I8bdbcbb38c89ac637eaa20dda58fa9165b25893a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we do get multiple notifications from firmware, then
we might have allocated 'notif', but don't free it. Fix
that by checking for duplicates before allocation.

Fixes: 4da46a06d443 ("wifi: iwlwifi: mvm: Add support for wowlan info notification")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 798a7a1299e1..37aa4676dc94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2722,6 +2722,13 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
 		struct iwl_wowlan_info_notif *notif;
 
+		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
+			/* We might get two notifications due to dual bss */
+			IWL_DEBUG_WOWLAN(mvm,
+					 "Got additional wowlan info notification\n");
+			break;
+		}
+
 		if (wowlan_info_ver < 2) {
 			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
 
@@ -2740,13 +2747,6 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			notif = (void *)pkt->data;
 		}
 
-		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
-			/* We might get two notifications due to dual bss */
-			IWL_DEBUG_WOWLAN(mvm,
-					 "Got additional wowlan info notification\n");
-			break;
-		}
-
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
-- 
2.38.1

