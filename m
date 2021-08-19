Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727313F1D00
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhHSPlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56908 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240526AbhHSPlU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9o-002Hje-Iw; Thu, 19 Aug 2021 18:40:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:28 +0300
Message-Id: <iwlwifi.20210819183728.5987f35883a2.I2d9ea5ecc69a5e5947b546fb15f33363a0595651@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/11] iwlwifi: pcie: avoid dma unmap/remap in crash dump
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

DMA-API debug code pointed out that in this code path we
never check the return value of dma_map_page(), which could
fail.

However, we don't really even want to unmap/remap, we just
want to ensure that we can actually access the last version
of the data that the (now-dead) device may have written, so
only need to dma_sync_single_for_cpu() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 86a949440486..1e6af3cbe026 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2968,8 +2968,8 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 		struct iwl_rx_mem_buffer *rxb = rxq->queue[i];
 		struct iwl_fw_error_dump_rb *rb;
 
-		dma_unmap_page(trans->dev, rxb->page_dma, max_len,
-			       DMA_FROM_DEVICE);
+		dma_sync_single_for_cpu(trans->dev, rxb->page_dma,
+					max_len, DMA_FROM_DEVICE);
 
 		rb_len += sizeof(**data) + sizeof(*rb) + max_len;
 
@@ -2978,10 +2978,6 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 		rb = (void *)(*data)->data;
 		rb->index = cpu_to_le32(i);
 		memcpy(rb->data, page_address(rxb->page), max_len);
-		/* remap the page for the free benefit */
-		rxb->page_dma = dma_map_page(trans->dev, rxb->page,
-					     rxb->offset, max_len,
-					     DMA_FROM_DEVICE);
 
 		*data = iwl_fw_error_next_data(*data);
 	}
-- 
2.33.0

