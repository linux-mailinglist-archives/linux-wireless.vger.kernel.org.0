Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FEF19D236
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbgDCIaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 04:30:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45450 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390431AbgDCIaI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 04:30:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jKHiH-0008yu-SP; Fri, 03 Apr 2020 11:30:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  3 Apr 2020 11:29:50 +0300
Message-Id: <iwlwifi.20200403112332.e95201f80f1e.I0985c55223decf70182b9ef1d8edf4179f537853@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403082955.1126339-1-luca@coelho.fi>
References: <20200403082955.1126339-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v5.7 3/8] iwlwifi: pcie: indicate correct RB size to device
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the context info, we need to indicate the correct RB size
to the device so that it will not think we have 4k when we
only use 2k. This seems to not have caused any issues right
now, likely because the hardware no longer supports putting
multiple entries into a single RB, and practically all of
the entries should be smaller than 2k.

Nevertheless, it's a bug, and we must advertise the right
size to the device.

Note that right now we can only tell it 2k vs. 4k, so for
the cases where we have more, still use 4k. This needs to
be fixed by the firmware first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: cfdc20efebdc ("iwlwifi: pcie: use partial pages if applicable")
Cc: stable@vger.kernel.org # v5.6
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c        | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 01f248ba8fec..9d5b1e51b50d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -129,6 +129,18 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	int cmdq_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
 			      trans->cfg->min_txq_size);
 
+	switch (trans_pcie->rx_buf_size) {
+	case IWL_AMSDU_DEF:
+		return -EINVAL;
+	case IWL_AMSDU_2K:
+		break;
+	case IWL_AMSDU_4K:
+	case IWL_AMSDU_8K:
+	case IWL_AMSDU_12K:
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_4K;
+		break;
+	}
+
 	/* Allocate prph scratch */
 	prph_scratch = dma_alloc_coherent(trans->dev, sizeof(*prph_scratch),
 					  &trans_pcie->prph_scratch_dma_addr,
@@ -143,10 +155,8 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		cpu_to_le16((u16)iwl_read32(trans, CSR_HW_REV));
 	prph_sc_ctrl->version.size = cpu_to_le16(sizeof(*prph_scratch) / 4);
 
-	control_flags = IWL_PRPH_SCRATCH_RB_SIZE_4K |
-			IWL_PRPH_SCRATCH_MTR_MODE |
-			(IWL_PRPH_MTR_FORMAT_256B &
-			 IWL_PRPH_SCRATCH_MTR_FORMAT);
+	control_flags |= IWL_PRPH_SCRATCH_MTR_MODE;
+	control_flags |= IWL_PRPH_MTR_FORMAT_256B & IWL_PRPH_SCRATCH_MTR_FORMAT;
 
 	/* initialize RX default queue */
 	prph_sc_ctrl->rbd_cfg.free_rbd_addr =
-- 
2.25.1

