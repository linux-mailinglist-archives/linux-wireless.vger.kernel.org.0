Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B3A43CB
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHaJww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39730 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbfHaJww (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:52 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400P-0002OQ-R7; Sat, 31 Aug 2019 12:49:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:52 +0300
Message-Id: <20190831094859.6391-13-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 12/19] iwlwifi: remove unnecessary IWL_DEVICE_AX200_COMMON definition
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Remove the IWL_DEVICE_AX200_COMMON definition, since it's only used
once and relies mostly on IWL_DEVICE_22000_COMMON anyway.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index af52a26bcaca..894c1e4cc582 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -188,10 +188,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.fw_mon_smem_cycle_cnt_ptr_addr = 0xa0c174,			\
 	.fw_mon_smem_cycle_cnt_ptr_msk = 0xfffff
 
-#define IWL_DEVICE_AX200_COMMON						\
-	IWL_DEVICE_22000_COMMON,					\
-	.umac_prph_offset = 0x300000
-
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
 	.device_family = IWL_DEVICE_FAMILY_22000,			\
@@ -206,7 +202,8 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.csr = &iwl_csr_v2
 
 #define IWL_DEVICE_AX210						\
-	IWL_DEVICE_AX200_COMMON,					\
+	IWL_DEVICE_22000_COMMON,					\
+	.umac_prph_offset = 0x300000,					\
 	.device_family = IWL_DEVICE_FAMILY_AX210,			\
 	.base_params = &iwl_22560_base_params,				\
 	.csr = &iwl_csr_v1,						\
-- 
2.23.0.rc1

