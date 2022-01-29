Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CF4A2E1E
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiA2LQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37884 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237441AbiA2LQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:35 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliZ-0002ji-Uz;
        Sat, 29 Jan 2022 13:16:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:18 +0200
Message-Id: <iwlwifi.20220129105618.209c6fe4364a.I5b21769d297d6fcfafc58ddf1db87d88349fe06f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: yoyo: fix DBGC allocation flow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

number of DBGCs and number of fragments per DBGC
is hw family dependency and not capability.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 29a04bb02a6d..9a58eca7e2c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -577,8 +577,7 @@ static int iwl_dbg_tlv_alloc_fragments(struct iwl_fw_runtime *fwrt,
 		return 0;
 
 	num_frags = le32_to_cpu(fw_mon_cfg->max_frags_num);
-	if (!fw_has_capa(&fwrt->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP)) {
+	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		if (alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 			return -EIO;
 		num_frags = 1;
-- 
2.34.1

