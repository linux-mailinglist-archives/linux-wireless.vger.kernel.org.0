Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0270FD1B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjEXRrF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjEXRrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:47:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFDAE67
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950395; x=1716486395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bwSzEKT/W3pqk5cAk1HSOf61Bv0rFq1odTsOEeBF7X0=;
  b=T4VkRYXcdQaaR3Th17r4M6xsylBFnebuP28+pDFeEDPxW2Woyd5BrqL0
   fIS8yPwEGNpYOCNDZWWZG2uUe0IPc7HZg4nVCm24Ql9gwD2MyuJ48nKQF
   e3in75gCAaUkxh/3EVUB6kTdgXRFILFYa3YUzxisIooIm6hiaLdmizDIX
   IhlQI1DUxXwfkq4fcTUyIeV48+tj2C60UmlqYgQukSI0DsiLXEyASiv5v
   dxskJoYOUx1T+l7PElKNbOk6Cu4ZBp0CjQ/Oqp2y0RcgsyFYAVUZYxA2Z
   GtUqmnizbKV5v0QUhe5ik6jSnjlSF+Wb2LJz4DuGZNVjFaODGzpRtdNvc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000745"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000745"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548564"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548564"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:43:39 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: support PPAG in China for older FW cmd version
Date:   Wed, 24 May 2023 20:42:10 +0300
Message-Id: <20230524203151.3cc19e799eeb.I9054b1d63fd7ae2b5f0e416825b4b1dc9f79cc80@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
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

From: Alon Giladi <alon.giladi@intel.com>

Allows the China bit in the ppag flags to turn on also when
FW cmd version is 1 (if FW has the capability).

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9dfd2497d495..e6abd16f8677 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1155,7 +1155,15 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
                         IWL_DEBUG_RADIO(fwrt,
                                         "PPAG table rev is %d but FW supports v1, sending truncated table\n",
                                         fwrt->ppag_ver);
-                        cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+			if (!fw_has_capa(&fwrt->fw->ucode_capa,
+					 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
+				cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+				IWL_DEBUG_RADIO(fwrt,
+						"FW doesn't support ppag China bit\n");
+			} else {
+				IWL_DEBUG_RADIO(fwrt,
+						"FW supports ppag China bit\n");
+			}
 		}
 	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
                 num_sub_bands = IWL_NUM_SUB_BANDS_V2;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index cddf09d6be1c..ef2ff7517534 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -462,6 +462,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT		= (__force iwl_ucode_tlv_capa_t)109,
 	IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT		= (__force iwl_ucode_tlv_capa_t)110,
 	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
+	IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)112,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
-- 
2.38.1

