Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365A6E206A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNKMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDNKM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812983E3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467145; x=1713003145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ioi21VNimn9NCkgVisaqSddQ78yOJID/2dnxCJn4Lho=;
  b=cASz8CEd6UDRoiRT7XgJxRNiCVo3J+1TFYfYFY3xVoCl9L2FUI+n3B2R
   JYBzf8pN/liBGYbi3JLCn5vl2VLiZbOwlusDlrnm+VMXATCJ20NOvz3Nt
   3cVHNNsrWLTvahaZ43tWwq7XFRTZbJF17W1A6nbWz8XcQHCD0V5We0wlU
   N5xOXJwgpaiCPLXzBbYErs72zNSJ3Wra2VcTACZLxsRAMyzo2YmN7YqGi
   AXhDcbPVl6LHHpiJvzKFaLx7DKuxsJxBNFbhV/Hg9q4McU9w9kk9jtpCY
   D96P9kayQYQG4EBQi0rFipEYVeU9dooFtGxCDFlvq4Vid/KsYOeDsBvoT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263556"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263556"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351642"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351642"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: enable new MLD FW API
Date:   Fri, 14 Apr 2023 13:11:54 +0300
Message-Id: <20230414130637.5dc66b08539e.I1c65024c879346b0349e1e431d36ec2b5fd85dd7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Enable the new FW API with MLD based on FW TLV.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 20 ++------------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 34ef106a2274..b00174c9ebce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -459,6 +459,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SYNCED_TIME			= (__force iwl_ucode_tlv_capa_t)106,
 	IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM        = (__force iwl_ucode_tlv_capa_t)108,
 	IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT		= (__force iwl_ucode_tlv_capa_t)109,
+	IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT		= (__force iwl_ucode_tlv_capa_t)110,
 	IWL_UCODE_TLV_CAPA_SCAN_DONT_TOGGLE_ANT         = (__force iwl_ucode_tlv_capa_t)111,
 
 #ifdef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 76ac8a480712..42e67df13a1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1401,24 +1401,8 @@ static inline bool iwl_mvm_has_new_rx_api(struct iwl_mvm *mvm)
 
 static inline bool iwl_mvm_has_mld_api(const struct iwl_fw *fw)
 {
-	return (iwl_fw_lookup_cmd_ver(fw, LINK_CONFIG_CMD,
-				      IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN) &&
-		(iwl_fw_lookup_cmd_ver(fw, MAC_CONFIG_CMD,
-				       IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN) &&
-		(iwl_fw_lookup_cmd_ver(fw, STA_CONFIG_CMD,
-				       IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN) &&
-		(iwl_fw_lookup_cmd_ver(fw, AUX_STA_CMD,
-				       IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN) &&
-		(iwl_fw_lookup_cmd_ver(fw, STA_REMOVE_CMD,
-				       IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN) &&
-		(iwl_fw_lookup_cmd_ver(fw, STA_DISABLE_TX_CMD,
-				       IWL_FW_CMD_VER_UNKNOWN) !=
-				IWL_FW_CMD_VER_UNKNOWN);
+	return fw_has_capa(&fw->ucode_capa,
+			   IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT);
 }
 
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
-- 
2.38.1

