Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FD730FAD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbjFOGtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjFOGtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF582D50
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811663; x=1718347663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kESiZymbmaUZuLh8Nxe6oQqaK8VgxkpElXFx8U/L6yk=;
  b=cBK9Iup1jSb12pCOE4HFCSCGrtT3pwBKCSO/F/wnm0b/2hc9o35c6D//
   atZ+V9bQSN6Qr33FwrcSvcK1BXDiIgcJOHFiPCAOZ9aea5/++bizL8UoO
   QcBJYBOpIls9w/LsGWiVOFOm8fh6fK0azBq9UDgnkVH/KFn2tqOMemrXa
   nMXPj0i+3CuPvVNj3P1Q1+66Eda7uGp4wUXfdWb0KtNnEUJ54pwNF4agR
   D7uOsY0Ck9XIZGrZUUMFC1ulcwGsvRPBB/wqxnktVHuiqx5CN4qK6azvj
   5JsjRst1O68SSNlPl0Ibxq97SvLMssHLiqpMLddCN5b677s8l6eAgoDs/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212256"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395963"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395963"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/5] wifi: iwlwifi: mvm: Add support for SCAN API version 16
Date:   Thu, 15 Jun 2023 09:47:19 +0300
Message-Id: <20230615094410.05bf3e612297.Ie3075f7068af38c335d26778ab7d0ec4b1c026c3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230615064720.459645-1-gregory.greenman@intel.com>
References: <20230615064720.459645-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Scan API version 16 use link ID for reporting the TSF of
scan results (instead of MAC ID used in previous versions).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 23 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 46 +++++++++++++++----
 2 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index ec96ba053a5c..9cbeef16cfe5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1003,7 +1003,8 @@ struct iwl_scan_channel_params_v6 {
  * struct iwl_scan_general_params_v11
  * @flags: &enum iwl_umac_scan_general_flags_v2
  * @reserved: reserved for future
- * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
+ * @scan_start_mac_or_link_id: report the scan start TSF time according to this
+ *     mac (up to verion 11) or link (starting with version 12) TSF
  * @active_dwell: dwell time for active scan per LMAC
  * @adwell_default_2g: adaptive dwell default number of APs
  *                        for 2.4GHz channel
@@ -1026,7 +1027,7 @@ struct iwl_scan_channel_params_v6 {
 struct iwl_scan_general_params_v11 {
 	__le16 flags;
 	u8 reserved;
-	u8 scan_start_mac_id;
+	u8 scan_start_mac_or_link_id;
 	u8 active_dwell[SCAN_TWO_LMACS];
 	u8 adwell_default_2g;
 	u8 adwell_default_5g;
@@ -1038,7 +1039,7 @@ struct iwl_scan_general_params_v11 {
 	__le32 scan_priority;
 	u8 passive_dwell[SCAN_TWO_LMACS];
 	u8 num_of_fragments[SCAN_TWO_LMACS];
-} __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_11 and *_VER_10 */
+} __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_12, *_VER_11  and *_VER_10 */
 
 /**
  * struct iwl_scan_periodic_parms_v1
@@ -1067,18 +1068,18 @@ struct iwl_scan_req_params_v12 {
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_params_v15
+ * struct iwl_scan_req_params_v16
  * @general_params: &struct iwl_scan_general_params_v11
  * @channel_params: &struct iwl_scan_channel_params_v6
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
  * @probe_params: &struct iwl_scan_probe_params_v4
  */
-struct iwl_scan_req_params_v15 {
+struct iwl_scan_req_params_v16 {
 	struct iwl_scan_general_params_v11 general_params;
 	struct iwl_scan_channel_params_v6 channel_params;
 	struct iwl_scan_periodic_parms_v1 periodic_params;
 	struct iwl_scan_probe_params_v4 probe_params;
-} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_15 and *_VER_14 */
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_16, *_VER_15 and *_VER_14 */
 
 /**
  * struct iwl_scan_req_umac_v12
@@ -1093,16 +1094,16 @@ struct iwl_scan_req_umac_v12 {
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_umac_v15
+ * struct iwl_scan_req_umac_v16
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
  */
-struct iwl_scan_req_umac_v15 {
+struct iwl_scan_req_umac_v16 {
 	__le32 uid;
 	__le32 ooc_priority;
-	struct iwl_scan_req_params_v15 scan_params;
-} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_15 and *_VER_14 */
+	struct iwl_scan_req_params_v16 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_16, *_VER_15 and *_VER_14 */
 
 /**
  * struct iwl_umac_scan_abort
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index d7ac9ddbcfba..b2154e9fcf01 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2292,11 +2292,12 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 }
 
 static void
-iwl_mvm_scan_umac_fill_general_p_v11(struct iwl_mvm *mvm,
+iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
 				     struct iwl_mvm_scan_params *params,
 				     struct ieee80211_vif *vif,
 				     struct iwl_scan_general_params_v11 *gp,
-				     u16 gen_flags, u8 gen_flags2)
+				     u16 gen_flags, u8 gen_flags2,
+				     u32 version)
 {
 	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -2313,7 +2314,23 @@ iwl_mvm_scan_umac_fill_general_p_v11(struct iwl_mvm *mvm,
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
 		gp->num_of_fragments[SCAN_HB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
 
-	gp->scan_start_mac_id = scan_vif->id;
+	if (version < 12) {
+		gp->scan_start_mac_or_link_id = scan_vif->id;
+	} else {
+		struct iwl_mvm_vif_link_info *link_info;
+		u8 link_id = 0;
+
+		/* Use one of the active link (if any). In the future it would
+		 * be possible that the link ID would be part of the scan
+		 * request coming from upper layers so we would need to use it.
+		 */
+		if (vif->active_links)
+			link_id = ffs(vif->active_links) - 1;
+
+		link_info = scan_vif->link[link_id];
+		if (!WARN_ON(!link_info))
+			gp->scan_start_mac_or_link_id = link_info->fw_link_id;
+	}
 }
 
 static void
@@ -2408,9 +2425,9 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
-	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
+	iwl_mvm_scan_umac_fill_general_p_v12(mvm, params, vif,
 					     &scan_p->general_params,
-					     gen_flags, 0);
+					     gen_flags, 0, 12);
 
 	ret = iwl_mvm_fill_scan_sched_params(params,
 					     scan_p->periodic_params.schedule,
@@ -2430,8 +2447,8 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 					   struct iwl_mvm_scan_params *params,
 					   int type, int uid, u32 version)
 {
-	struct iwl_scan_req_umac_v15 *cmd = mvm->scan_cmd;
-	struct iwl_scan_req_params_v15 *scan_p = &cmd->scan_params;
+	struct iwl_scan_req_umac_v16 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v16 *scan_p = &cmd->scan_params;
 	struct iwl_scan_channel_params_v6 *cp = &scan_p->channel_params;
 	struct iwl_scan_probe_params_v4 *pb = &scan_p->probe_params;
 	int ret;
@@ -2451,9 +2468,9 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	else
 		gen_flags2 = 0;
 
-	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
+	iwl_mvm_scan_umac_fill_general_p_v12(mvm, params, vif,
 					     &scan_p->general_params,
-					     gen_flags, gen_flags2);
+					     gen_flags, gen_flags2, version);
 
 	ret = iwl_mvm_fill_scan_sched_params(params,
 					     scan_p->periodic_params.schedule,
@@ -2507,6 +2524,13 @@ static int iwl_mvm_scan_umac_v15(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 15);
 }
 
+static int iwl_mvm_scan_umac_v16(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 16);
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -2622,6 +2646,7 @@ struct iwl_scan_umac_handler {
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(16),
 	IWL_SCAN_UMAC_HANDLER(15),
 	IWL_SCAN_UMAC_HANDLER(14),
 	IWL_SCAN_UMAC_HANDLER(12),
@@ -3210,7 +3235,8 @@ static size_t iwl_scan_req_umac_get_size(u8 scan_ver)
 		return sizeof(struct iwl_scan_req_umac_v12);
 	case 14:
 	case 15:
-		return sizeof(struct iwl_scan_req_umac_v15);
+	case 16:
+		return sizeof(struct iwl_scan_req_umac_v16);
 	}
 
 	return 0;
-- 
2.38.1

