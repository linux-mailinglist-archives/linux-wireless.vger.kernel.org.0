Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987964A3586
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354551AbiA3JxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37918 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354542AbiA3JxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:17 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tX-0003JO-MM;
        Sun, 30 Jan 2022 11:53:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:05 +0200
Message-Id: <iwlwifi.20220130115024.59d00c6e5f09.I331bf18af0b80b5cc41b379ff0cc1b26a89dd915@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mei: avoid -Wpointer-arith and -Wcast-qual warnings
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These cause extra warnings (at least with W=3), avoid them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mei/net.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index d9733aaf6f6e..8295cbbb497c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -312,7 +312,7 @@ static ssize_t iwl_mei_write_cyclic_buf(struct mei_cl_device *cldev,
 		memcpy(q_head + wr, hdr, tx_sz);
 	} else {
 		memcpy(q_head + wr, hdr, q_sz - wr);
-		memcpy(q_head, (u8 *)hdr + q_sz - wr, tx_sz - (q_sz - wr));
+		memcpy(q_head, (const u8 *)hdr + q_sz - wr, tx_sz - (q_sz - wr));
 	}
 
 	WRITE_ONCE(notif_q->wr_ptr, cpu_to_le32((wr + tx_sz) % q_sz));
@@ -432,7 +432,7 @@ void iwl_mei_add_data_to_ring(struct sk_buff *skb, bool cb_tx)
 	u32 q_sz;
 	u32 rd;
 	u32 wr;
-	void *q_head;
+	u8 *q_head;
 
 	if (!iwl_mei_global_cldev)
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/net.c b/drivers/net/wireless/intel/iwlwifi/mei/net.c
index 5f966af69720..fa2dbdca5592 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/net.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
@@ -102,8 +102,8 @@ static bool iwl_mei_rx_filter_arp(struct sk_buff *skb,
 	 * src IP address    - 4 bytes
 	 * target MAC addess - 6 bytes
 	 */
-	target_ip = (void *)((u8 *)(arp + 1) +
-			     ETH_ALEN + sizeof(__be32) + ETH_ALEN);
+	target_ip = (const void *)((const u8 *)(arp + 1) +
+				   ETH_ALEN + sizeof(__be32) + ETH_ALEN);
 
 	/*
 	 * ARP request is forwarded to ME only if IP address match in the
-- 
2.34.1

