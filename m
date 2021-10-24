Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E64389C7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJXPXP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58638 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231452AbhJXPXL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIn-000czj-72; Sun, 24 Oct 2021 18:20:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:30 +0300
Message-Id: <iwlwifi.20211024181719.90e42cd8cb37.I89ac9910e38006a2e5c9e87d371a8507f475572d@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: update RFI TLV
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

RFI TLV was moved in FW from set3 to set1 due to FW internal
dependency. Adjust driver to this change.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 565918054ed1..3d572f5024bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -421,6 +421,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)59,
 	IWL_UCODE_TLV_CAPA_BROADCAST_TWT		= (__force iwl_ucode_tlv_capa_t)60,
 	IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO		= (__force iwl_ucode_tlv_capa_t)61,
+	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)62,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
@@ -454,7 +455,6 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
 
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
-	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)102,
 	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
 
 #ifdef __CHECKER__
-- 
2.33.0

