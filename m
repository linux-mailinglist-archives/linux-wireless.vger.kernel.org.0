Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B143098D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhJQOCT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53982 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343808AbhJQOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hn-000Yi6-NS; Sun, 17 Oct 2021 17:00:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:53 +0300
Message-Id: <iwlwifi.20211017165728.8025bd29d86a.I3ecb4e273bf714e426d82217e0590264cb763419@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/10] iwlwifi: dbg: treat non active regions as unsupported regions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

If a region is not active, it means that it was not defined as a region
TLV in the FW image.  We should treat them as unsupported in that case.

This saves operational driver memory and run time when collecting debug
data by skipping unsupported regions.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 75d5ed0c3204..f487cc8b9fe0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1179,8 +1179,10 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 			&fwrt->trans->dbg.active_regions[i];
 		u32 reg_type;
 
-		if (!*active_reg)
+		if (!*active_reg) {
+			fwrt->trans->dbg.unsupported_region_msk |= BIT(i);
 			continue;
+		}
 
 		reg = (void *)(*active_reg)->data;
 		reg_type = le32_to_cpu(reg->type);
-- 
2.33.0

