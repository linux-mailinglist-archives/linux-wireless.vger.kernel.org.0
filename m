Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAEE11E6BE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfLMPio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:38:44 -0500
Received: from nbd.name ([46.4.11.11]:54822 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfLMPio (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:38:44 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifn1e-0005pC-FD; Fri, 13 Dec 2019 16:38:42 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 3/9] ath11k: drop memset when setting up a tx cmd desc
Date:   Fri, 13 Dec 2019 16:38:33 +0100
Message-Id: <20191213153839.12372-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213153839.12372-1-john@phrozen.org>
References: <20191213153839.12372-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no point in zero'ing out the structure if we set all values in the
following line.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 2 --
 drivers/net/wireless/ath/ath11k/hal_tx.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a8b9557c2346..28ebc414533e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -167,8 +167,6 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	skb_cb->vif = arvif->vif;
 	skb_cb->ar = ar;
 
-	memset(cached_desc, 0, HAL_TCL_DESC_LEN);
-
 	ath11k_hal_tx_cmd_desc_setup(ab, cached_desc, &ti);
 
 	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index cbe549798762..72a51ed65a51 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -71,6 +71,7 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 				    ti->dscp_tid_tbl_idx) |
 			 FIELD_PREP(HAL_TCL_DATA_CMD_INFO3_SEARCH_INDEX,
 				    ti->bss_ast_hash);
+	tcl_cmd->info4 = 0;
 }
 
 /* Commit the descriptor to hardware */
-- 
2.20.1

