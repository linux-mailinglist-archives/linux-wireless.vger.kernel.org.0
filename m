Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BA7B7C48
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbjJDJhI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbjJDJhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFEBB
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412220; x=1727948220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XOJfRA7fD/qH1Lpl/dpTVEk3Z/yesN2kDKnrtMg0Cpg=;
  b=AjVQKFxpGsQR/Tg6LqxWWFBDS2MHUxGzvloY6whsCOoP90bHwSw2+ywz
   N3VBdqm71InSFRCUGEoYM9Bzh8mJGr8eTL16wR9t/Jr0n1noxgCtiCJ3Q
   3WgYL+JmU90KPOZlll+Zo41WTHdc+p7JFkHGWVh9nEyunoMvyiDmbMtTE
   xAzUxE7ks68ZBjm02NV6qQlbY78sq5/qjWuyjZAtf7ETA9gRu2UjUgjm/
   B4kzh2cq7XadmzGJM7xXCz3RbXAO/OetU0dV8JB59fC95eb6XEYc8p4Q7
   WFxyysnGgmISdf8fmwLVU86p/yluQgMm04f4UFhpaOlNGgAAMaIVetycf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611685"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611685"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415148"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415148"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: Extract common prph mac/phy regions data dump logic
Date:   Wed,  4 Oct 2023 12:36:20 +0300
Message-Id: <20231004123422.16f06414c65c.Ie911bc83a1e2f8fddb27b4c5bd24f933f8b674b6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

YoYo (debug data collection mechanism) is introducing 2 new types
of regions: prph mac/phy ranges.
These types will have a common logic of reading the data from the
device as the mac/phy prph has. Put it in a separate function so it can
be reused.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 52 ++++++++++++++-------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e236c1d95e8e..6c03ffdcd3f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1021,22 +1021,18 @@ struct iwl_dump_ini_region_data {
 	struct iwl_fwrt_dump_data *dump_data;
 };
 
-static int
-iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
-			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, u32 range_len, int idx)
+static int iwl_dump_ini_prph_mac_iter_common(struct iwl_fw_runtime *fwrt,
+					     void *range_ptr, u32 addr,
+					     __le32 size)
 {
-	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	__le32 *val = range->data;
 	u32 prph_val;
-	u32 addr = le32_to_cpu(reg->addrs[idx]) +
-		   le32_to_cpu(reg->dev_addr.offset);
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
-	range->range_data_size = reg->dev_addr.size;
-	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
+	range->range_data_size = size;
+	for (i = 0; i < le32_to_cpu(size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
 		if (iwl_trans_is_hw_error_value(prph_val))
 			return -EBUSY;
@@ -1047,38 +1043,47 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int
-iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
+iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
 			   void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 addr = le32_to_cpu(reg->addrs[idx]) +
+		   le32_to_cpu(reg->dev_addr.offset);
+
+	return iwl_dump_ini_prph_mac_iter_common(fwrt, range_ptr, addr,
+						 reg->dev_addr.size);
+}
+
+static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
+					     void *range_ptr, u32 addr,
+					     __le32 size, __le32 offset)
+{
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	__le32 *val = range->data;
 	u32 indirect_wr_addr = WMAL_INDRCT_RD_CMD1;
 	u32 indirect_rd_addr = WMAL_MRSPF_1;
 	u32 prph_val;
-	u32 addr = le32_to_cpu(reg->addrs[idx]);
 	u32 dphy_state;
 	u32 dphy_addr;
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
-	range->range_data_size = reg->dev_addr.size;
+	range->range_data_size = size;
 
 	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		indirect_wr_addr = WMAL_INDRCT_CMD1;
 
-	indirect_wr_addr += le32_to_cpu(reg->dev_addr.offset);
-	indirect_rd_addr += le32_to_cpu(reg->dev_addr.offset);
+	indirect_wr_addr += le32_to_cpu(offset);
+	indirect_rd_addr += le32_to_cpu(offset);
 
 	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return -EBUSY;
 
-	dphy_addr = (reg->dev_addr.offset) ? WFPM_LMAC2_PS_CTL_RW :
-					     WFPM_LMAC1_PS_CTL_RW;
+	dphy_addr = (offset) ? WFPM_LMAC2_PS_CTL_RW : WFPM_LMAC1_PS_CTL_RW;
 	dphy_state = iwl_read_umac_prph_no_grab(fwrt->trans, dphy_addr);
 
-	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
+	for (i = 0; i < le32_to_cpu(size); i += 4) {
 		if (dphy_state == HBUS_TIMEOUT ||
 		    (dphy_state & WFPM_PS_CTL_RW_PHYRF_PD_FSM_CURSTATE_MSK) !=
 		    WFPM_PHYRF_STATE_ON) {
@@ -1097,6 +1102,19 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
+			   struct iwl_dump_ini_region_data *reg_data,
+			   void *range_ptr, u32 range_len, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 addr = le32_to_cpu(reg->addrs[idx]);
+
+	return iwl_dump_ini_prph_phy_iter_common(fwrt, range_ptr, addr,
+						 reg->dev_addr.size,
+						 reg->dev_addr.offset);
+}
+
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, u32 range_len, int idx)
-- 
2.38.1

