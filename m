Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140FF103770
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfKTK06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:26:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58508 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727399AbfKTK06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:26:58 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCK-0001kS-3o; Wed, 20 Nov 2019 12:26:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:39 +0200
Message-Id: <20191120102650.514376-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/12] iwlwifi: pcie: fix support for transmitting SKBs with fraglist
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When the implementation of SKBs with fraglist was sent upstream, a
merge-damage occurred and half the patch was not applied.

This causes problems in high-throughput situations with AX200 devices,
including low throughput and FW crashes.

Introduce the part that was missing from the original patch.

Fixes: 0044f1716c4d ("iwlwifi: pcie: support transmitting SKBs with fraglist")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ This patch was created by me, but the original author of this code
  is Johannes, so his s-o-b is here and he's marked as the author of
  the patch. ]
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8323fa7c0762..1ca9a7e48c1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -468,6 +468,7 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 	dma_addr_t tb_phys;
 	int len, tb1_len, tb2_len;
 	void *tb1_addr;
+	struct sk_buff *frag;
 
 	tb_phys = iwl_pcie_get_first_tb_dma(txq, idx);
 
@@ -516,6 +517,19 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 	if (iwl_pcie_gen2_tx_add_frags(trans, skb, tfd, out_meta))
 		goto out_err;
 
+	skb_walk_frags(skb, frag) {
+		tb_phys = dma_map_single(trans->dev, frag->data,
+					 skb_headlen(frag), DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+			goto out_err;
+		iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, skb_headlen(frag));
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
+					frag->data,
+					skb_headlen(frag));
+		if (iwl_pcie_gen2_tx_add_frags(trans, frag, tfd, out_meta))
+			goto out_err;
+	}
+
 	return tfd;
 
 out_err:
-- 
2.24.0

