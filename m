Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7422667EE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIKRy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:54:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50272 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbgIKRy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:54:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6J-0028eU-Rz; Fri, 11 Sep 2020 20:44:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:30 +0300
Message-Id: <iwlwifi.20200911204056.c80b994d6bf0.Ifd45dfd5066283886f969313c20ff81edde428ff@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: mvm: add PROTECTED_TWT firmware API
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add the PROTECTED_TWT bit to the MAC context data_policy enum.
Define the PROTECTED_TWT TLV.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h | 16 +++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/file.h    |  3 ++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 73fb0030c496..afc3eccfa718 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -5,9 +5,8 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,9 +26,8 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -188,9 +186,17 @@ struct iwl_mac_data_ibss {
 /**
  * enum iwl_mac_data_policy - policy of the data path for this MAC
  * @TWT_SUPPORTED: twt is supported
+ * @MORE_DATA_ACK_SUPPORTED: AP supports More Data Ack according to
+ *	paragraph 9.4.1.17 in P802.11ax_D4 specification. Used for TWT
+ *	early termination detection.
+ * @FLEXIBLE_TWT_SUPPORTED: AP supports flexible TWT schedule
+ * @PROTECTED_TWT_SUPPORTED: AP supports protected TWT frames (with 11w)
  */
 enum iwl_mac_data_policy {
-	TWT_SUPPORTED	= BIT(0),
+	TWT_SUPPORTED = BIT(0),
+	MORE_DATA_ACK_SUPPORTED = BIT(1),
+	FLEXIBLE_TWT_SUPPORTED = BIT(2),
+	PROTECTED_TWT_SUPPORTED = BIT(3),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1fb45fd30ffa..044b9d4ca4d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -405,8 +405,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	to report the CSI information with (certain) RX frames
  * @IWL_UCODE_TLV_CAPA_FTM_CALIBRATED: has FTM calibrated and thus supports both
  *	initiator and responder
- *
  * @IWL_UCODE_TLV_CAPA_MLME_OFFLOAD: supports MLME offload
+ * @IWL_UCODE_TLV_CAPA_PROTECTED_TWT: Supports protection of TWT action frames
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -451,6 +451,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SET_PPAG			= (__force iwl_ucode_tlv_capa_t)52,
 	IWL_UCODE_TLV_CAPA_TAS_CFG			= (__force iwl_ucode_tlv_capa_t)53,
 	IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD		= (__force iwl_ucode_tlv_capa_t)54,
+	IWL_UCODE_TLV_CAPA_PROTECTED_TWT		= (__force iwl_ucode_tlv_capa_t)56,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
-- 
2.28.0

