Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D67187CE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEaQve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaQvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F4A135
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551888; x=1717087888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXGnb7yNgfqrW6NfI9pN4xdmAyVF0f0AgsNV2HaV9d0=;
  b=fWU5ZY4onlm70qUKxCxtaqvZXJXZLNrDbMwM8ajGtKYObFLvGndpWXPK
   3e+w1/4vWtplDkKA0UMRCAtnJUCFUV17jfa/XWQwHf7iMzK+eiND+P7up
   4jZYMONpuN2E8ICuUmpf4onuWzeDHFhMGSjMhQnYfKA8QqiaI3IFc8Job
   JossHVgb1p1j+lAiaLj6xwUAWNOLM3R+QZW4rCClKoeFPhyHgsjKMj4g2
   Oo+Fg7MWyPXAYGCVWWBSJf/B7NZw0OuEl4S+j9FKgHxoD6lbU+/Xyi0mH
   /OSPOC8ibRTfIh3EoNBM3+NK7CmLXoPemL/AdEg2V3saEUYXV0O+7GlQ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890515"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890515"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987969"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987969"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: mvm: offload BTM response during D3
Date:   Wed, 31 May 2023 19:49:59 +0300
Message-Id: <20230531194629.d95ae6f2804c.I9457acc55bc23ce715c714b5088058f52540c224@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

There are mainly two types of BTM (BSS Transition Management)
requests, recommendations and notifications. For the first type,
a response is needed otherwise, most probably the STA will be
disconnected.
Since we don't want to wake up the host on it, set the BTM to reject
offload flag (if the device supports it) and rely on the FW to take
care of it. The FW will reject the BTM request and in case the AP
sends DEAUTH the FW can wake up the host to let it decide on the
next steps.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h      | 2 ++
 drivers/net/wireless/intel/iwlwifi/fw/file.h        | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 8a613e150a02..37ac2364e714 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -47,12 +47,14 @@ struct iwl_d3_manager_config {
  * @IWL_D3_PROTO_OFFLOAD_NS: NS (Neighbor Solicitation) is enabled
  * @IWL_D3_PROTO_IPV4_VALID: IPv4 data is valid
  * @IWL_D3_PROTO_IPV6_VALID: IPv6 data is valid
+ * @IWL_D3_PROTO_REJECT_BTM: reject BTM request
  */
 enum iwl_proto_offloads {
 	IWL_D3_PROTO_OFFLOAD_ARP = BIT(0),
 	IWL_D3_PROTO_OFFLOAD_NS = BIT(1),
 	IWL_D3_PROTO_IPV4_VALID = BIT(2),
 	IWL_D3_PROTO_IPV6_VALID = BIT(3),
+	IWL_D3_PROTO_REJECT_BTM = BIT(4),
 };
 
 #define IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V1	2
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index ef2ff7517534..42de95a22784 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -463,6 +463,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT		= (__force iwl_ucode_tlv_capa_t)110,
 	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
 	IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)112,
+	IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT	= (__force iwl_ucode_tlv_capa_t)113,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index a8bd0f5f795c..797b1f70937e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -198,6 +198,10 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 		memcpy(common->arp_mac_addr, vif->addr, ETH_ALEN);
 	}
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT))
+		enabled |= IWL_D3_PROTO_REJECT_BTM;
+
 	if (!disable_offloading)
 		common->enabled = cpu_to_le32(enabled);
 
-- 
2.38.1

