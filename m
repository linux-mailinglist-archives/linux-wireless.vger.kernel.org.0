Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E900529D79
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244401AbiEQJIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C523170
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778404; x=1684314404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqAcVvj8Iaveho+UptY7zpPaFNxnh6HtT8Kpw9jk40M=;
  b=XnQFJmr6enfp7+h3cH9agD4oqMBhts7OfhEg/D//orqrV4QRpAye5N0I
   c90LDnZXuZPD+6b7yeDYbz1Lu2TP7+Hrm7w5PV9LHtUf2Itd/lqjlssQC
   ZLWyMQZyHm8hchpNlohLJgUe+gAepp0TF6lTxL8NCU687Z+sQEHybCAmc
   iduSbID3dR8Rzc8EM1c+itzBQyW2nmzltLucgUS++TEqQEm2qwKUqMxxV
   TqgY20CEF1q+QKacoX2xyUtk3TWXgvYwyA+J4ElxnfeyKbaY/t8m2zdyF
   IuYlWwjiUm6ttKGmUbo11CcMfW/lHGCEV2VwXV7XMglyi9mGzck8y/CwX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064723"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064723"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679697"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:20 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Subject: [PATCH 02/10] iwlwifi: mvm: use NULL instead of ERR_PTR when parsing wowlan status
Date:   Tue, 17 May 2022 12:05:06 +0300
Message-Id: <20220517120044.78a7651327bb.I77480de7c26db850680f96a3440fb6a1b45dd9d2@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

We anyway don't differentiate between the errors so it is pointless,
returning NULL will be simpler in this case.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index bcc4ed20fe5b..61f9136a333d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1956,18 +1956,18 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 									\
 	if (len < sizeof(*data)) {					\
 		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");	\
-		return ERR_PTR(-EIO);					\
+		return NULL;						\
 	}								\
 									\
 	data_size = ALIGN(le32_to_cpu(data->wake_packet_bufsize), 4);	\
 	if (len != sizeof(*data) + data_size) {				\
 		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");	\
-		return ERR_PTR(-EIO);					\
+		return NULL;						\
 	}								\
 									\
 	status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);	\
 	if (!status)							\
-		return ERR_PTR(-ENOMEM);				\
+		return NULL;						\
 									\
 	/* copy all the common fields */				\
 	status->replay_ctr = le64_to_cpu(data->replay_ctr);		\
@@ -2097,7 +2097,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		struct iwl_wowlan_status_v6 *v6 = (void *)cmd.resp_pkt->data;
 
 		status = iwl_mvm_parse_wowlan_status_common_v6(mvm, v6, len);
-		if (IS_ERR(status))
+		if (!status)
 			goto out_free_resp;
 
 		BUILD_BUG_ON(sizeof(v6->gtk.decrypt_key) >
@@ -2128,7 +2128,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
 		status = iwl_mvm_parse_wowlan_status_common_v7(mvm, v7, len);
-		if (IS_ERR(status))
+		if (!status)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc);
@@ -2141,7 +2141,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		 * difference is only in a few not used (reserved) fields.
 		 */
 		status = iwl_mvm_parse_wowlan_status_common_v9(mvm, v9, len);
-		if (IS_ERR(status))
+		if (!status)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters(status, &v9->gtk[0].rsc.all_tsc_rsc);
@@ -2153,7 +2153,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		struct iwl_wowlan_status_v12 *v12 = (void *)cmd.resp_pkt->data;
 
 		status = iwl_mvm_parse_wowlan_status_common_v12(mvm, v12, len);
-		if (IS_ERR(status))
+		if (!status)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters_v5(status, &v12->gtk[0].sc);
@@ -2165,7 +2165,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		IWL_ERR(mvm,
 			"Firmware advertises unknown WoWLAN status response %d!\n",
 			notif_ver);
-		status = ERR_PTR(-EIO);
+		status = NULL;
 	}
 
 out_free_resp:
@@ -2203,7 +2203,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvm_ap_sta;
 
 	status = iwl_mvm_get_wakeup_status(mvm, mvmvif->ap_sta_id);
-	if (IS_ERR(status))
+	if (!status)
 		goto out_unlock;
 
 	IWL_DEBUG_WOWLAN(mvm, "wakeup reason 0x%x\n",
@@ -2370,7 +2370,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 	int i, n_matches, ret;
 
 	status = iwl_mvm_get_wakeup_status(mvm, IWL_MVM_INVALID_STA);
-	if (!IS_ERR(status)) {
+	if (status) {
 		reasons = status->wakeup_reasons;
 		kfree(status);
 	}
-- 
2.35.1

