Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6890172E375
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjFMM5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbjFMM5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EFA6
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661064; x=1718197064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Gt7jsfu/NwIHAX+uk22jitrBoUz/VAhTZw3cnNnPVM=;
  b=fBTP2JM0CLt7llXHHx8EBysFSIGeRPy/mYI9bGV8Vug5xbQqKZdZd9JG
   LyNEParORbRROvNNfIDWd2EgNLNZ6Yh1UVb8/l1RGzND6sLEM0gfjNKWH
   O/cNCDSBB+KzuJS4S5n0Nyoxb9WRSJaGr7DjENHEqg1RbALTRHWCiVGFV
   waH38Oys0f77bgck/4BkT5P3xB/ZAlbbr4L9s+gmGfrd/G4vnWNF5mp+l
   J2KM8z5/7esf2w8Wemcyy9LS6MbxG2GfC4+CAcafX/wMV2qGwcifbBK+N
   J1cmpb4QFSQErPdY3nXcIF0M496FPgiLpSKcIe3rr0sbVefrBd+599omZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973713"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973713"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880774"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880774"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: rename BTM support flag and its TLV
Date:   Tue, 13 Jun 2023 15:57:15 +0300
Message-Id: <20230613155501.ad20f10668d1.Icbb3fbae50b2302b97225b183dd336b02a4f37ee@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
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

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

Currently, we only need to support BTM rejection.
However, in the future we might want to support other BTM modes.
Rephrase its naming.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 37ac2364e714..380eeb2363c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -47,14 +47,14 @@ struct iwl_d3_manager_config {
  * @IWL_D3_PROTO_OFFLOAD_NS: NS (Neighbor Solicitation) is enabled
  * @IWL_D3_PROTO_IPV4_VALID: IPv4 data is valid
  * @IWL_D3_PROTO_IPV6_VALID: IPv6 data is valid
- * @IWL_D3_PROTO_REJECT_BTM: reject BTM request
+ * @IWL_D3_PROTO_OFFLOAD_BTM: BTM offload is enabled
  */
 enum iwl_proto_offloads {
 	IWL_D3_PROTO_OFFLOAD_ARP = BIT(0),
 	IWL_D3_PROTO_OFFLOAD_NS = BIT(1),
 	IWL_D3_PROTO_IPV4_VALID = BIT(2),
 	IWL_D3_PROTO_IPV6_VALID = BIT(3),
-	IWL_D3_PROTO_REJECT_BTM = BIT(4),
+	IWL_D3_PROTO_OFFLOAD_BTM = BIT(4),
 };
 
 #define IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V1	2
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1a4f7c04ebae..b36e9613a52c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -465,7 +465,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT		= (__force iwl_ucode_tlv_capa_t)110,
 	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
 	IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)112,
-	IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT	= (__force iwl_ucode_tlv_capa_t)113,
+	IWL_UCODE_TLV_CAPA_OFFLOAD_BTM_SUPPORT		= (__force iwl_ucode_tlv_capa_t)113,
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index 797b1f70937e..dfb16ca5b438 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -199,8 +199,8 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 	}
 
 	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_OFFLOAD_REJ_BTM_SUPPORT))
-		enabled |= IWL_D3_PROTO_REJECT_BTM;
+			IWL_UCODE_TLV_CAPA_OFFLOAD_BTM_SUPPORT))
+		enabled |= IWL_D3_PROTO_OFFLOAD_BTM;
 
 	if (!disable_offloading)
 		common->enabled = cpu_to_le32(enabled);
-- 
2.38.1

