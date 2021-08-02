Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D423DDAB1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHBOTx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:19:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50868 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238124AbhHBOTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:19:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdc-001xoA-Ed; Mon, 02 Aug 2021 17:09:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:41 +0300
Message-Id: <iwlwifi.20210802170640.5e35f930d0ed.I5f94575a835f060bdc8ed3477871256f8a2cbaaa@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 09/12] iwlwifi: print PNVM complete notification status in hexadecimal
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This value is not a simple incrementing integer, it contains some
flags as well, so reading it in hexadecimal is easier.  Change the
print to do it in hex instead of decimal.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 2403490cbc26..1de30bae7829 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -24,7 +24,7 @@ static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_pnvm_init_complete_ntfy *pnvm_ntf = (void *)pkt->data;
 
 	IWL_DEBUG_FW(trans,
-		     "PNVM complete notification received with status %d\n",
+		     "PNVM complete notification received with status 0x%0x\n",
 		     le32_to_cpu(pnvm_ntf->status));
 
 	return true;
-- 
2.32.0

