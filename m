Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753AE430988
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbhJQOCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343799AbhJQOCM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hj-000Yi6-HY; Sun, 17 Oct 2021 16:59:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:48 +0300
Message-Id: <iwlwifi.20211017165728.4cd241abf1de.I8f6cf00a7266675dfebdc01a73c1ac6e001855b9@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/10] iwlwifi: dbg: treat dbgc allocation failure when tlv is missing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

in case allocation tlv is missing for specific dbgc id,
treat it as allocation failure.
with this behavior we removing later the unsupported regions
relating to the failed dbgc allocation.
this saves operational driver memory and run time at collecting
debug data.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 869270020763..75d5ed0c3204 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1149,8 +1149,10 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 			&fwrt->trans->dbg.fw_mon_cfg[i];
 		u32 dest = le32_to_cpu(fw_mon_cfg->buf_location);
 
-		if (dest == IWL_FW_INI_LOCATION_INVALID)
+		if (dest == IWL_FW_INI_LOCATION_INVALID) {
+			failed_alloc |= BIT(i);
 			continue;
+		}
 
 		if (*ini_dest == IWL_FW_INI_LOCATION_INVALID)
 			*ini_dest = dest;
-- 
2.33.0

