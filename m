Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12101B7A7D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgDXPsd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57888 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbgDXPsb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z3-000OY2-Dp; Fri, 24 Apr 2020 18:48:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:09 +0300
Message-Id: <iwlwifi.20200424182644.34e74106bad3.Ic3a9f0a35fed47b02ebcd27c2dc2b50cb1e56bdf@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: yoyo: use hweight_long instead of bit manipulating
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Also we can only have one fid1 or fid2 set so no need to check
if the fid2 is set in case fid1 wasn't set.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 25 +++++++++++----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 914f0eb07d52..37c8b6cc2ec7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1367,28 +1367,30 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	u32 fid1 = le32_to_cpu(reg->fifos.fid[0]);
 	u32 fid2 = le32_to_cpu(reg->fifos.fid[1]);
-	u32 fifo_idx;
+	u8 fifo_idx;
 
 	if (!data)
 		return;
 
+	/* make sure only one bit is set in only one fid */
+	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
+		      "fid1=%x, fid2=%x\n", fid1, fid2))
+		return;
+
 	memset(data, 0, sizeof(*data));
 
-	if (WARN_ON_ONCE((fid1 && fid2) || (!fid1 && !fid2)))
-		return;
+	if (fid1) {
+		fifo_idx = ffs(fid1) - 1;
+		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
+			      fifo_idx))
+			return;
 
-	fifo_idx = ffs(fid1) - 1;
-	if (fid1 && !WARN_ON_ONCE((~BIT(fifo_idx) & fid1) ||
-				  fifo_idx >= MAX_NUM_LMAC)) {
 		data->size = fwrt->smem_cfg.lmac[fifo_idx].rxfifo1_size;
 		data->fifo_num = fifo_idx;
-		return;
-	}
-
-	fifo_idx = ffs(fid2) - 1;
-	if (fid2 && !WARN_ON_ONCE(~BIT(fifo_idx) & fid2)) {
+	} else {
 		u8 max_idx;
 
+		fifo_idx = ffs(fid2) - 1;
 		if (iwl_fw_lookup_notif_ver(fwrt->fw, SYSTEM_GROUP,
 					    SHARED_MEM_CFG_CMD, 0) <= 3)
 			max_idx = 0;
@@ -1416,7 +1418,6 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 						     RXF2C_DIFF_FROM_PREV);
 			break;
 		}
-		return;
 	}
 }
 
-- 
2.26.2

