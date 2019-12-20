Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061DC127B47
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTMve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54048 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbfLTMve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkh-0007lx-Ub; Fri, 20 Dec 2019 14:51:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:15 +0200
Message-Id: <20191220125124.1315679-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 02/11] iwlwifi: dbg_ini: don't skip a TX FIFO when dumping
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Before we start looping over the internal TX FIFOs increase the fifo
number, but that's incorrect and causes a FIFO to be skipped.  This is
probably due to a copy and paste from the previous loop.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ed90dd104366..c8bc6b9b53a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1230,13 +1230,15 @@ static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 			iter->lmac = 0;
 	}
 
-	if (!iter->internal_txf)
+	if (!iter->internal_txf) {
 		for (iter->fifo++; iter->fifo < txf_num; iter->fifo++) {
 			iter->fifo_size =
 				cfg->lmac[iter->lmac].txfifo_size[iter->fifo];
 			if (iter->fifo_size && (lmac_bitmap & BIT(iter->fifo)))
 				return true;
 		}
+		iter->fifo--;
+	}
 
 	iter->internal_txf = 1;
 
-- 
2.24.0

