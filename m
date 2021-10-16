Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23B430136
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhJPIqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52886 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243841AbhJPIqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIV-000Xqv-91; Sat, 16 Oct 2021 11:44:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:59 +0300
Message-Id: <iwlwifi.20211016114029.8b5480113f53.I80b5b4ebea84e56f3b3143fc1ee7097be8b4ae78@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi>
References: <20211016084359.246930-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 5/5] iwlwifi: cfg: set low-latency-xtal for some integrated So devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The integrated So devices covered by the iwl_so_long_latency_trans_cfg
configuration should all have low-latency-xtal enabled, so do that.
While at it, remove the TODO, I've checked the other values as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6f60fb03c8e7 ("iwlwifi: move SnJ and So rules to the new tables")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d8231cc821ae..c18b27b0d60e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -355,7 +355,7 @@ const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
 	.base_params = &iwl_ax210_base_params,
 	.umac_prph_offset = 0x300000,
 	.integrated = true,
-	/* TODO: the following values need to be checked */
+	.low_latency_xtal = true,
 	.xtal_latency = 12000,
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
-- 
2.33.0

