Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30DD3AC5B0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFRIFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48102 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233122AbhFRIEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:04:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RS-001YIf-B6; Fri, 18 Jun 2021 11:01:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:20 +0300
Message-Id: <iwlwifi.20210618105614.dc658639e07f.I69ab6d59ff10c55c8517621eb20a52194dc4783a@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 09/10] iwlwifi: fix NUM_IWL_UCODE_TLV_* definitions to avoid sparse errors
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were assigning these macros manually when sparse is running, but
with newer versions of sparse, it started causing other warnings.  Fix
it by making it a macro when sparse is running.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index d189e5de478b..ef1a24504c8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -277,10 +277,11 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_BAND_IN_RX_DATA	= (__force iwl_ucode_tlv_api_t)59,
 
 
-	NUM_IWL_UCODE_TLV_API
 #ifdef __CHECKER__
-		/* sparse says it cannot increment the previous enum member */
-		= 128
+	/* sparse says it cannot increment the previous enum member */
+#define NUM_IWL_UCODE_TLV_API 128
+#else
+	NUM_IWL_UCODE_TLV_API
 #endif
 };
 
@@ -447,10 +448,11 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
 	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)102,
 
-	NUM_IWL_UCODE_TLV_CAPA
 #ifdef __CHECKER__
-		/* sparse says it cannot increment the previous enum member */
-		= 128
+	/* sparse says it cannot increment the previous enum member */
+#define NUM_IWL_UCODE_TLV_CAPA 128
+#else
+	NUM_IWL_UCODE_TLV_CAPA
 #endif
 };
 
-- 
2.32.0

