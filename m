Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA36E1457
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDMSmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDMSmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:42:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762A83F5
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411343; x=1712947343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhR5YMhFEHD/3i6I88f26DmRxUOrdW9fnYIcHq+mDJY=;
  b=l1hgvBB5coahGhOv/+7uaovxn+4lbhvwCUyOtIYnV6i6UM8h//waVbz+
   nj5nmnpJ5x9lWwlLpBpKybQV0w2XpABrWJ/8bVgIg8okAGSMXu0QBLWPj
   palnZE4bUVrsBQLcA5NZNDcNK6mAo6SivqIN6/j2SSYwZIYrtp23JjkhU
   r6u8/XRt39/QLKeDTVCpZFpi7tW93tupvJ3WFKHRNUB30mr9kmGr0+mYT
   w3UhFmk20N2xNnhIoFZCLVOS8uRM/DrLfx6fGW/JohFyB6G5QOvSS0yxQ
   VdO5+Py8mK5ftOSv45ldC/+IuriD9q/y1fG/voDPYBgfJXHqhTi9BvwOy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127126"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984510"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984510"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: scan legacy bands and UHB channels with same antenna
Date:   Thu, 13 Apr 2023 21:40:35 +0300
Message-Id: <20230413213309.fd582c423ad8.I35239f94cb3ee1642d16936199c336a07ec2df8f@changeid>
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

In case of UHB scan that follows a scan on legacy bands,
consider both scan commands as part of the same scan cycle,
and thus configure them to use the same antenna configuration.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/fw/file.h     | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c    | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 7ba0e3409199..ec96ba053a5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -709,10 +709,13 @@ enum iwl_umac_scan_general_flags_v2 {
  *     should be aware of a P2P GO operation on the 2GHz band.
  * @IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB: scan event scheduling
  *     should be aware of a P2P GO operation on the 5GHz or 6GHz band.
+ * @IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_DONT_TOGGLE_ANT: don't toggle between
+ *     valid antennas, and use the same antenna as in previous scan
  */
 enum iwl_umac_scan_general_params_flags2 {
 	IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_LB = BIT(0),
 	IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB = BIT(1),
+	IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_DONT_TOGGLE_ANT   = BIT(2),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index a0260a1fa099..34ef106a2274 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -459,6 +459,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SYNCED_TIME			= (__force iwl_ucode_tlv_capa_t)106,
 	IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM        = (__force iwl_ucode_tlv_capa_t)108,
 	IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT		= (__force iwl_ucode_tlv_capa_t)109,
+	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 07045092c717..7749f15b7f14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2081,6 +2081,11 @@ static u8 iwl_mvm_scan_umac_flags2(struct iwl_mvm *mvm,
 				IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB;
 	}
 
+	if (params->scan_6ghz &&
+	    fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT))
+		flags |= IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_DONT_TOGGLE_ANT;
+
 	return flags;
 }
 
-- 
2.38.1

