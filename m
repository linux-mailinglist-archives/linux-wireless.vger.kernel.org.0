Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382972F9B0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbjFNJp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbjFNJow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8682718
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735838; x=1718271838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nhvN+EHxnhNwPjf53yuSu39kH5ShuTGUixrptlcxMuA=;
  b=Sl1PO//jCbvmWmes2dxXKjnMBVcggUIwrHM+QKVOg9TmgWnqBOan4GxK
   hVdn4I5KUhSNlPyygVAwH5R8szn/iu+UbvpufdILyPVufvhSHj1wsO0qe
   b2DcrTNeqQRxAa0b2J8Uu7IcbHGyhO5XuhULPfdgiymIdOLCcV4pE0M+E
   sCckT5uFRb9tS0im4Un3jvxW8royf7+NC/Tb4iNtcDTvo01Bj/bR7n8Lc
   rPQtj4lRSP4CGgeo3dHXBmqywTR74xeTauvngn1G+F4XuFkx05Ugxpvx7
   LR3qvVVyJQTAjVFosUEHe817O5SEYdnedH+ZvXKAtrN4H6j2T56CbZqcW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049920"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989913"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989913"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/20] wifi: iwlwifi: mvm: Validate tid is in valid range before using it
Date:   Wed, 14 Jun 2023 12:41:35 +0300
Message-Id: <20230614123447.cea75e1f57e7.I03bc0a81d2c1bdbf4784c12c4c62b8538892ccba@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Validate tid is less then MAX TID when it is used to access
corresponding arrays.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 10 +++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 ++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index b38b24246675..542c192698a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -213,8 +213,12 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 	};
 	u16 thr;
 
-	if (ieee80211_is_data_qos(hdr->frame_control))
-		ac = tid_to_mac80211_ac[ieee80211_get_tid(hdr)];
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		u8 tid = ieee80211_get_tid(hdr);
+
+		if (tid < IWL_MAX_TID_COUNT)
+			ac = tid_to_mac80211_ac[tid];
+	}
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	mac = mvmsta->mac_id_n_color & FW_CTXT_ID_MSK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5c06839b87c2..9dbe71d299ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -484,7 +484,7 @@ static void iwl_mvm_rx_csum(struct iwl_mvm *mvm,
 }
 
 /*
- * returns true if a packet is a duplicate and should be dropped.
+ * returns true if a packet is a duplicate or invalid tid and should be dropped.
  * Updates AMSDU PN tracking info
  */
 static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
@@ -513,11 +513,14 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 		return false;
 	}
 
-	if (ieee80211_is_data_qos(hdr->frame_control))
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		/* frame has qos control */
 		tid = ieee80211_get_tid(hdr);
-	else
+		if (tid >= IWL_MAX_TID_COUNT)
+			return true;
+	} else {
 		tid = IWL_MAX_TID_COUNT;
+	}
 
 	/* If this wasn't a part of an A-MSDU the sub-frame index will be 0 */
 	sub_frame_idx = desc->amsdu_info &
-- 
2.38.1

