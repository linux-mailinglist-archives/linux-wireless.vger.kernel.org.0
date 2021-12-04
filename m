Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9594F468461
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384772AbhLDLOa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50408 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350310AbhLDLO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:29 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwY-0017RD-2n; Sat, 04 Dec 2021 13:11:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:49 +0200
Message-Id: <iwlwifi.20211204130722.488268ffb2a6.I4fd9ee9dc43d04953a640e19ecac7575ad34fe94@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: yoyo: support for DBGC4 for dram
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add DBGC4 memory for debug handling in driver which will be created,
freed and collected from the FW in case of crash.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 3988f5fea33a..b37392719398 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -306,6 +306,7 @@ enum iwl_fw_ini_config_set_type {
  * @IWL_FW_INI_ALLOCATION_ID_DBGC1: allocation meant for DBGC1 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC2: allocation meant for DBGC2 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC3: allocation meant for DBGC3 configuration
+ * @IWL_FW_INI_ALLOCATION_ID_DBGC4: allocation meant for DBGC4 configuration
  * @IWL_FW_INI_ALLOCATION_NUM: number of allocation ids
 */
 enum iwl_fw_ini_allocation_id {
@@ -313,6 +314,7 @@ enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_ID_DBGC1,
 	IWL_FW_INI_ALLOCATION_ID_DBGC2,
 	IWL_FW_INI_ALLOCATION_ID_DBGC3,
+	IWL_FW_INI_ALLOCATION_ID_DBGC4,
 	IWL_FW_INI_ALLOCATION_NUM,
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
-- 
2.33.1

