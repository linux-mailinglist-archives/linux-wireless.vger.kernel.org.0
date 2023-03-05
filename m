Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944966AAF60
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCEMRE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMRD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864A12F37
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018622; x=1709554622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NAOCvuDIcZHu+uqWoIGhbA+eNV6/9QWaQoGE/Q3tY1s=;
  b=bNLgvKEG1lYJ93aMacT6UfK1EUpPujUUzN/VLtJCvk6kg1J66vCymRRz
   jRE9GMb145DgSQUnjqWYsNL8a0yhFfptPtif+F5ioPNQa+kjlBjpegaDN
   qOnOt6w04Khu19Q5Q6yVyEl50LUitg3LlDkpCfSkFEGJWvxRi0LfIEyEe
   88vVtr035J4R0cX20kfc0B0OwBXeeq60H9DyqIGFPXJJXHqFVM9NDyTcC
   fAgbZptqu3jDyQWxWlci1javarQ3L2wXj+7b+KAgYEtWEPLGZLGx2dE2f
   5cYXL6r0+WxtP7d5eqmz/8UCb6tufg3DaWz0A99Pig1GRMJCnb5ZMmsju
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193167"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355014"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355014"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:00 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/21] wifi: iwlwifi: reduce verbosity of some logging events
Date:   Sun,  5 Mar 2023 14:16:18 +0200
Message-Id: <20230305124407.5eea0f58a74f.Ifb6b35903a5a452a757bfe50b6a7e58b3fd2ef23@changeid>
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

From: Golan Ben Ami <golan.ben.ami@intel.com>

These are cases in which we'd like to warn that something
unexpected happened but they may not be errors.

Reduce verbosity.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 48e7376a5fea..8e0bc1f5f6c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -350,9 +350,9 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, const struct iwl_ucode_tlv *tlv,
 
 	ret = dbg_tlv_alloc[tlv_idx](trans, tlv);
 	if (ret) {
-		IWL_ERR(trans,
-			"WRT: Failed to allocate TLV 0x%x, ret %d, (ext=%d)\n",
-			type, ret, ext);
+		IWL_WARN(trans,
+			 "WRT: Failed to allocate TLV 0x%x, ret %d, (ext=%d)\n",
+			 type, ret, ext);
 		goto out_err;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 49ca1e168fc5..ab9a51375c8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -190,7 +190,7 @@ static u32 iwl_mvm_set_mac80211_rx_flag(struct iwl_mvm *mvm,
 	default:
 		/* Expected in monitor (not having the keys) */
 		if (!mvm->monitor_on)
-			IWL_ERR(mvm, "Unhandled alg: 0x%x\n", rx_pkt_status);
+			IWL_WARN(mvm, "Unhandled alg: 0x%x\n", rx_pkt_status);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ba9f79ada82f..2db4f68becff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -444,7 +444,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		 */
 		if (!is_multicast_ether_addr(hdr->addr1) &&
 		    !mvm->monitor_on && net_ratelimit())
-			IWL_ERR(mvm, "Unhandled alg: 0x%x\n", status);
+			IWL_WARN(mvm, "Unhandled alg: 0x%x\n", status);
 	}
 
 	return 0;
-- 
2.38.1

