Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C06AAF69
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCEMRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCEMR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15F1258A
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018645; x=1709554645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=viagR4b3/lpV4dgTqkGjp0s048quuQJ9fIcyntoLuDI=;
  b=nZgVVpBq+PX4Gbe6BnTgMqh9LWnOWL7BfQLxKglHMD8Yd9iLmwks9Pe7
   CWNa2FMuOk3N2iMiQQfsBrw6J39no8N+otMJaiG0Zeq75BBgMQ4VuZQ3i
   iVAZnfAjw/A7bBBe8Nbn3jfvQk/ObXoxiIQF6Vdkwt/aTe2KyS69ChXBw
   mFvTx+NMuPxzICxUA2vQWdHxsyMczIf44IWZ11XXoDJEll3i3Cn6GuYmq
   Af/qwEQSQVQfMosRQzt9ZVeNINqqGZta385IoDFIlKnRacag1MGReReFp
   4H6BkQ95bpejyQNqzeiIxNAQijUX7ee3MXJge0NB2c6yoSKXSoGf0KVIi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193244"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355148"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355148"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:23 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/21] wifi: iwlwifi: mvm: avoid UB shift of snif_queue
Date:   Sun,  5 Mar 2023 14:16:27 +0200
Message-Id: <20230305124407.b8da0b7eb194.I53744fd7cfb6e146a9393272a2a61852841238d9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For the old TX API we need the tfd_queue_msk, but for the
new TX API we don't need it here because we add it to the
station later. However, for the new API mvm->snif_queue is
set to IWL_MVM_INVALID_QUEUE == 0xffff, so the BIT() here
is undefined behaviour.

Since we don't need the tfd_queue_msk value for the new TX
API at all, simply fill it in only for the old API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index aa791dbc3066..114c96ba39ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -654,7 +654,7 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 					 u32 action)
 {
 	struct iwl_mac_ctx_cmd cmd = {};
-	u32 tfd_queue_msk = BIT(mvm->snif_queue);
+	u32 tfd_queue_msk = 0;
 	int ret;
 
 	WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);
@@ -669,6 +669,14 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 				       MAC_FILTER_ACCEPT_GRP);
 	ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
 
+	/*
+	 * the queue mask is only relevant for old TX API, and
+	 * mvm->snif_queue isn't set here (it's still set to
+	 * IWL_MVM_INVALID_QUEUE so the BIT() of it is UB)
+	 */
+	if (!iwl_mvm_has_new_tx_api(mvm))
+		tfd_queue_msk = BIT(mvm->snif_queue);
+
 	/* Allocate sniffer station */
 	ret = iwl_mvm_allocate_int_sta(mvm, &mvm->snif_sta, tfd_queue_msk,
 				       vif->type, IWL_STA_GENERAL_PURPOSE);
-- 
2.38.1

