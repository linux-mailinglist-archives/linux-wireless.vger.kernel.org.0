Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0117D9AE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCIHQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33112 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726428AbgCIHQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeV-0007CP-Td; Mon, 09 Mar 2020 09:16:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:18 +0200
Message-Id: <iwlwifi.20200309091348.3387a6c8fdbe.I98284457f26c5695754964b28f0257a7dc7c6b1c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309071619.670108-1-luca@coelho.fi>
References: <20200309071619.670108-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 12/13] iwlwifi: remove trans entries from COMMON 9260 macro
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

These entries are decided at runtime using the new parameters now, so
they are not needed in the macro that is reused in the configs.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 9fcc1d97d6b7..d02936a8e11d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -123,8 +123,6 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 #define IWL_DEVICE_9000							\
 	.ucode_api_max = IWL9000_UCODE_API_MAX,				\
 	.ucode_api_min = IWL9000_UCODE_API_MIN,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_9000,			\
-	.trans.base_params = &iwl9000_base_params,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
 	.non_shared_ant = ANT_B,					\
@@ -137,11 +135,9 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.thermal_params = &iwl9000_tt_params,				\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.num_rbds = 512,						\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = true,					\
-	.trans.rf_id = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
-- 
2.25.1

