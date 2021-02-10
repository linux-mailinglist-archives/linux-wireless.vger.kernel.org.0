Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCA3166BE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBJMcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:32:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45060 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231891AbhBJMaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:23 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9ocb-0049Yg-Bw; Wed, 10 Feb 2021 14:29:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:16 +0200
Message-Id: <iwlwifi.20210210142629.a0cc944040e8.I3ae37547452b39f8040428c21ed47bdc67ae8f71@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 01/12] iwlwifi: dbg: remove unsupported regions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In case user requested to register an unsupported regions,
remove it from active list and trigger list, this saves operational
driver memory and run time at collecting debug data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  6 ++--
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 36 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 1fdf80f154da..e87329265876 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2073,7 +2073,8 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->umac_minor = cpu_to_le32(fwrt->dump.fw_ver.umac_minor);
 
 	dump->fw_mon_mode = cpu_to_le32(fwrt->trans->dbg.ini_dest);
-	dump->regions_mask = trigger->regions_mask;
+	dump->regions_mask = trigger->regions_mask &
+			     ~cpu_to_le64(fwrt->trans->dbg.unsupported_region_msk);
 
 	dump->build_tag_len = cpu_to_le32(sizeof(dump->build_tag));
 	memcpy(dump->build_tag, fwrt->fw->human_readable,
@@ -2202,7 +2203,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	};
 	int i;
 	u32 size = 0;
-	u64 regions_mask = le64_to_cpu(trigger->regions_mask);
+	u64 regions_mask = le64_to_cpu(trigger->regions_mask) &
+			   ~(fwrt->trans->dbg.unsupported_region_msk);
 
 	BUILD_BUG_ON(sizeof(trigger->regions_mask) != sizeof(regions_mask));
 	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 12c49fe8608a..579bc81cc0ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -959,6 +959,7 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 {
 	enum iwl_fw_ini_buffer_location *ini_dest = &fwrt->trans->dbg.ini_dest;
 	int ret, i;
+	u32 failed_alloc = 0;
 
 	if (*ini_dest != IWL_FW_INI_LOCATION_INVALID)
 		return;
@@ -990,10 +991,43 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 			continue;
 
 		ret = iwl_dbg_tlv_alloc_fragments(fwrt, i);
-		if (ret)
+
+		if (ret) {
 			IWL_WARN(fwrt,
 				 "WRT: Failed to allocate DRAM buffer for allocation id %d, ret=%d\n",
 				 i, ret);
+			failed_alloc |= BIT(i);
+		}
+	}
+
+	if (!failed_alloc)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.active_regions) && failed_alloc; i++) {
+		struct iwl_fw_ini_region_tlv *reg;
+		struct iwl_ucode_tlv **active_reg =
+			&fwrt->trans->dbg.active_regions[i];
+		u32 reg_type;
+
+		if (!*active_reg)
+			continue;
+
+		reg = (void *)(*active_reg)->data;
+		reg_type = le32_to_cpu(reg->type);
+
+		if (reg_type != IWL_FW_INI_REGION_DRAM_BUFFER ||
+		    !(BIT(le32_to_cpu(reg->dram_alloc_id)) & failed_alloc))
+			continue;
+
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: removing allocation id %d from region id %d\n",
+			     le32_to_cpu(reg->dram_alloc_id), i);
+
+		failed_alloc &= ~le32_to_cpu(reg->dram_alloc_id);
+		fwrt->trans->dbg.unsupported_region_msk |= BIT(i);
+
+		kfree(*active_reg);
+		*active_reg = NULL;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3348d582a46c..70caee03bd1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -746,6 +746,7 @@ struct iwl_trans_debug {
 	bool hw_error;
 	enum iwl_fw_ini_buffer_location ini_dest;
 
+	u64 unsupported_region_msk;
 	struct iwl_ucode_tlv *active_regions[IWL_FW_INI_MAX_REGION_ID];
 	struct list_head debug_info_tlv_list;
 	struct iwl_dbg_tlv_time_point_data
-- 
2.30.0

