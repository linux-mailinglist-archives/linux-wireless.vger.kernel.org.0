Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A87CBEC1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjJQJRY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJQJRU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60860F1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534238; x=1729070238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k44QySGI2YxEHJuk2q0UCleWVP6Pf1pZHYrooOZONW8=;
  b=TaNe1cOMZ6AmuQ7a8Pv63Z1e5UvDBkpYZoZzsv+8cFSCEmyu3Q1lpcv9
   qa/5Tj4kdnusPqbwJPTA5k/vywLoyxqGFMiBDIShRv4n2rUFqNlq1/46c
   a2k4mc2TBIm+L9tsKxs/Ya2WIgi2jVY3M5qDgjxV0QRT1SVQteDIZd1u3
   6uUCBNbBfJgoUmzDL3Y0RB3FjrZTVcsKHHknoWBRBQwmaiQH+aucC839u
   QgiqK+pICHPPszHLtZ0b4+1/iX3JB1OVyvX1sFFaXkpR7xW9QwQDN73Io
   5rMxfEMPVvV/Xgd/4q8XP1Xl2zfdfPtvg2K7Xb1ABTscVnBZVKLzHiRdp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808548"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808548"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731919"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731919"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: add support for SNPS DPHYIP region type
Date:   Tue, 17 Oct 2023 12:16:42 +0300
Message-Id: <20231017115047.c859539194e7.I965482de2871e28b09f4572f1aa87ae4e3b366be@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

Add the required logic for parsing and dumping this new region.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  3 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 56 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  4 ++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index fb421500f261..394747deb269 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -159,6 +159,7 @@ struct iwl_fw_ini_region_internal_buffer {
  *	&IWL_FW_INI_REGION_PAGING, &IWL_FW_INI_REGION_CSR,
  *	&IWL_FW_INI_REGION_DRAM_IMR and &IWL_FW_INI_REGION_PCI_IOSF_CONFIG
  *	&IWL_FW_INI_REGION_DBGI_SRAM, &FW_TLV_DEBUG_REGION_TYPE_DBGI_SRAM,
+ *	&IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP,
  * @dev_addr_range: device address range configuration. Used by
  *	&IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE and
  *	&IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE
@@ -392,6 +393,7 @@ enum iwl_fw_ini_buffer_location {
  * @IWL_FW_INI_REGION_DBGI_SRAM: periphery registers of DBGI SRAM
  * @IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE: a range of periphery registers of MAC
  * @IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE: a range of periphery registers of PHY
+ * @IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP: periphery registers of SNPS DPHYIP
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
@@ -416,6 +418,7 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_DBGI_SRAM,
 	IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE,
 	IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE,
+	IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP,
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index a20be3642848..3975a53a9f20 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1416,6 +1416,53 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_prph_snps_dphyip_iter(struct iwl_fw_runtime *fwrt,
+				   struct iwl_dump_ini_region_data *reg_data,
+				   void *range_ptr, u32 range_len, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	__le32 *val = range->data;
+	__le32 offset = reg->dev_addr.offset;
+	u32 indirect_rd_wr_addr = DPHYIP_INDIRECT;
+	u32 addr = le32_to_cpu(reg->addrs[idx]);
+	u32 dphy_state, dphy_addr, prph_val;
+	int i;
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = reg->dev_addr.size;
+
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
+		return -EBUSY;
+
+	indirect_rd_wr_addr += le32_to_cpu(offset);
+
+	dphy_addr = offset ? WFPM_LMAC2_PS_CTL_RW : WFPM_LMAC1_PS_CTL_RW;
+	dphy_state = iwl_read_umac_prph_no_grab(fwrt->trans, dphy_addr);
+
+	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
+		if (dphy_state == HBUS_TIMEOUT ||
+		    (dphy_state & WFPM_PS_CTL_RW_PHYRF_PD_FSM_CURSTATE_MSK) !=
+		    WFPM_PHYRF_STATE_ON) {
+			*val++ = cpu_to_le32(WFPM_DPHY_OFF);
+			continue;
+		}
+
+		iwl_write_prph_no_grab(fwrt->trans, indirect_rd_wr_addr,
+				       addr + i);
+		/* wait a bit for value to be ready in register */
+		udelay(1);
+		prph_val = iwl_read_prph_no_grab(fwrt->trans,
+						 indirect_rd_wr_addr);
+		*val++ = cpu_to_le32((prph_val & DPHYIP_INDIRECT_RD_MSK) >>
+				     DPHYIP_INDIRECT_RD_SHIFT);
+	}
+
+	iwl_trans_release_nic_access(fwrt->trans);
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 struct iwl_ini_rxf_data {
 	u32 fifo_num;
 	u32 size;
@@ -2537,6 +2584,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mon_dbgi_fill_header,
 		.fill_range = iwl_dump_ini_dbgi_sram_iter,
 	},
+	[IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_prph_snps_dphyip_iter,
+	},
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
@@ -2580,7 +2633,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 			continue;
 
 		if ((reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
-		     reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE) &&
+		     reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE ||
+		     reg_type == IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP) &&
 		    tp_id != IWL_FW_INI_TIME_POINT_FW_ASSERT) {
 			IWL_WARN(fwrt,
 				 "WRT: trying to collect phy prph at time point: %d, skipping\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index da035dbfbdb0..dd32c287b983 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -516,4 +516,8 @@ enum {
 #define WFPM_LMAC2_PD_NOTIFICATION 0xA033CC
 #define WFPM_LMAC2_PD_RE_READ BIT(31)
 
+#define DPHYIP_INDIRECT			0xA2D800
+#define DPHYIP_INDIRECT_RD_MSK		0xFF000000
+#define DPHYIP_INDIRECT_RD_SHIFT	24
+
 #endif				/* __iwl_prph_h__ */
-- 
2.38.1

