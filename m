Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3910D468610
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349105AbhLDPx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50508 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349513AbhLDPxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:25 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIT-0017qB-W2; Sat, 04 Dec 2021 17:49:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:42 +0200
Message-Id: <iwlwifi.20211204174546.91d33aa9dd3d.Ifb48e21fbb92ea25360856b5cc2afbb9b485d6b3@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: fw: correctly detect HW-SMEM region subtype
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is part of the "device memory" type, but with the
subtypes we can now detect it properly, rather than
having to make assumptions on the ID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 1c302cdbde5a..224525417424 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -7,7 +7,6 @@
 
 #include <linux/bitops.h>
 
-#define IWL_FW_INI_HW_SMEM_REGION_ID		15
 #define IWL_FW_INI_MAX_REGION_ID		64
 #define IWL_FW_INI_MAX_NAME			32
 #define IWL_FW_INI_MAX_CFG_NAME			64
@@ -387,6 +386,8 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
+#define IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_HW_SMEM	1
+
 /**
  * enum iwl_fw_ini_time_point
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fa3a7a3c3a61..a373a2bc964a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1165,8 +1165,7 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
 				 le32_to_cpu(reg->dev_addr.size));
 
-	if ((le32_to_cpu(reg->id) & IWL_FW_INI_REGION_V2_MASK) ==
-		IWL_FW_INI_HW_SMEM_REGION_ID &&
+	if (reg->sub_type == IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_HW_SMEM &&
 	    fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
 		fwrt->sanitize_ops->frob_txf(fwrt->sanitize_ctx,
 					     range->data,
-- 
2.33.1

