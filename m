Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A8701C7F
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjENJQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjENJQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584F1BE5
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055797; x=1715591797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2a0c6csWwNKpik/AcjqzmB2UjxQ3OYfVNuG+Gfm5mC4=;
  b=lDnhu/FbPkkhQXXsQekP1s4TERlCje0JfEEmpJN4iQRwmCowtv2njixA
   +U932YmYG3QEamCZoXfTJEwslPrEID7XHVkiya+5YFAs1Ugg81g3xmQhn
   GEsQUJLbf+OM22sStVHE3YW0a1kY/MtlyNjx04T5xK1RZmhQvaKRl1pfR
   95630fsVNADC1dGV2O1okGXAfETgsqIuHkT1q3gi3V2xiF2RPa6SaMKFi
   VU5ioY1SAnhQpZlnGY6BJqZ48Y455DSXP55DGJiiZEudkCzcDPCcKNKZA
   niuMc6FoCR6Vfv+w3iOsBM7/fPvJ4kaXnddHFw80X3prEMcLSOhUrYBKs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366863"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366863"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300458"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300458"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 10/12] wifi: iwlwifi: mvm: don't trust firmware n_channels
Date:   Sun, 14 May 2023 12:15:53 +0300
Message-Id: <20230514120631.d7b233139eb4.I51fd319df8e9d41881fc8450e83d78049518a79a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

If the firmware sends us a corrupted MCC response with
n_channels much larger than the command response can be,
we might copy far too much (uninitialized) memory and
even crash if the n_channels is large enough to make it
run out of the one page allocated for the FW response.

Fix that by checking the lengths. Doing a < comparison
would be sufficient, but the firmware should be doing
it correctly, so check more strictly.

Fixes: dcaf9f5ecb6f ("iwlwifi: mvm: add MCC update FW API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 6d18a1fd649b..fdf60afb0f3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -445,6 +445,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp *mcc_resp = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kmemdup(mcc_resp, resp_len, GFP_KERNEL);
@@ -456,6 +461,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp_v3 *mcc_resp_v3 = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp_v3->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp_v3, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kzalloc(resp_len, GFP_KERNEL);
-- 
2.38.1

