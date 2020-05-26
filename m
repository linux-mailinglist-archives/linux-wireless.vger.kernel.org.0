Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2641B1B7A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgDXPsd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgDXPsc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z2-000OY2-Fx; Fri, 24 Apr 2020 18:48:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:08 +0300
Message-Id: <iwlwifi.20200424182643.97cc25d96b53.I65fd0400d80f505bd6d7eed442f12db24b25bbe3@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: yoyo: add support for parsing SHARED_MEM_ALLOC version 4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The new version adds the information for RX2C FIFO addresses.

Use the new addresses to parse the FIFO info when dumping.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 14 +++++----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 29 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  5 ++--
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  | 14 ++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 11 ++++---
 5 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 98e957ecbeed..94b1a1268476 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2007 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -218,6 +216,8 @@ struct iwl_shared_mem_lmac_cfg {
  * @page_buff_size: size of %page_buff_addr
  * @lmac_num: number of LMACs (1 or 2)
  * @lmac_smem: per - LMAC smem data
+ * @rxfifo2_control_addr: start addr of RXF2C
+ * @rxfifo2_control_size: size of RXF2C
  */
 struct iwl_shared_mem_cfg {
 	__le32 shared_mem_addr;
@@ -229,8 +229,10 @@ struct iwl_shared_mem_cfg {
 	__le32 page_buff_addr;
 	__le32 page_buff_size;
 	__le32 lmac_num;
-	struct iwl_shared_mem_lmac_cfg lmac_smem[2];
-} __packed; /* SHARED_MEM_ALLOC_API_S_VER_3 */
+	struct iwl_shared_mem_lmac_cfg lmac_smem[3];
+	__le32 rxfifo2_control_addr;
+	__le32 rxfifo2_control_size;
+} __packed; /* SHARED_MEM_ALLOC_API_S_VER_4 */
 
 /**
  * struct iwl_mfuart_load_notif - mfuart image version & status
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 39c8332be3ac..914f0eb07d52 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1386,13 +1386,36 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	}
 
 	fifo_idx = ffs(fid2) - 1;
-	if (fid2 && !WARN_ON_ONCE(fifo_idx != 0)) {
-		data->size = fwrt->smem_cfg.rxfifo2_size;
-		data->offset = RXF_DIFF_FROM_PREV;
+	if (fid2 && !WARN_ON_ONCE(~BIT(fifo_idx) & fid2)) {
+		u8 max_idx;
+
+		if (iwl_fw_lookup_notif_ver(fwrt->fw, SYSTEM_GROUP,
+					    SHARED_MEM_CFG_CMD, 0) <= 3)
+			max_idx = 0;
+		else
+			max_idx = 1;
+
+		if (WARN_ONCE(fifo_idx > max_idx,
+			      "invalid umac fifo idx %d", fifo_idx))
+			return;
+
 		/* use bit 31 to distinguish between umac and lmac rxf while
 		 * parsing the dump
 		 */
 		data->fifo_num = fifo_idx | IWL_RXF_UMAC_BIT;
+
+		switch (fifo_idx) {
+		case 0:
+			data->size = fwrt->smem_cfg.rxfifo2_size;
+			data->offset = iwl_umac_prph(fwrt->trans,
+						     RXF_DIFF_FROM_PREV);
+			break;
+		case 1:
+			data->size = fwrt->smem_cfg.rxfifo2_control_size;
+			data->offset = iwl_umac_prph(fwrt->trans,
+						     RXF2C_DIFF_FROM_PREV);
+			break;
+		}
 		return;
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 9906d9b9bdd5..9629ef94b214 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -86,6 +86,7 @@ struct iwl_fwrt_shared_mem_cfg {
 		u32 rxfifo1_size;
 	} lmac[MAX_NUM_LMAC];
 	u32 rxfifo2_size;
+	u32 rxfifo2_control_size;
 	u32 internal_txfifo_addr;
 	u32 internal_txfifo_size[TX_FIFO_INTERNAL_MAX_NUM];
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index 409b2dd854ac..700fdab14209 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -71,6 +69,8 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 	struct iwl_shared_mem_cfg *mem_cfg = (void *)pkt->data;
 	int i, lmac;
 	int lmac_num = le32_to_cpu(mem_cfg->lmac_num);
+	u8 api_ver = iwl_fw_lookup_notif_ver(fwrt->fw, SYSTEM_GROUP,
+					     SHARED_MEM_CFG_CMD, 0);
 
 	if (WARN_ON(lmac_num > ARRAY_SIZE(mem_cfg->lmac_smem)))
 		return;
@@ -80,6 +80,12 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 		ARRAY_SIZE(mem_cfg->lmac_smem[0].txfifo_size);
 	fwrt->smem_cfg.rxfifo2_size = le32_to_cpu(mem_cfg->rxfifo2_size);
 
+	if (api_ver >= 4 &&
+	    !WARN_ON_ONCE(iwl_rx_packet_payload_len(pkt) < sizeof(*mem_cfg))) {
+		fwrt->smem_cfg.rxfifo2_control_size =
+			le32_to_cpu(mem_cfg->rxfifo2_control_size);
+	}
+
 	for (lmac = 0; lmac < lmac_num; lmac++) {
 		struct iwl_shared_mem_lmac_cfg *lmac_cfg =
 			&mem_cfg->lmac_smem[lmac];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 1136d9784f9d..8e254c0eda13 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -326,6 +324,7 @@
 #define RXF_SIZE_BYTE_CND_POS		(7)
 #define RXF_SIZE_BYTE_CNT_MSK		(0x3ff << RXF_SIZE_BYTE_CND_POS)
 #define RXF_DIFF_FROM_PREV		(0x200)
+#define RXF2C_DIFF_FROM_PREV		(0x4e00)
 
 #define RXF_LD_FENCE_OFFSET_ADDR	(0xa00c10)
 #define RXF_FIFO_RD_FENCE_ADDR		(0xa00c0c)
-- 
2.26.2

