Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D9A1FB1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfH2Ptv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 11:49:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfH2Ptv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 11:49:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D929E86449; Thu, 29 Aug 2019 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567078430;
        bh=byN0+oRJ97XKqT9ACdxABqAh2yXx1PCB8rvsaIeSLoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzR3Ek4glgzurQ1+Tvb7ENxoeXz/NzgeEHOd4OSOqiCZ3wcX+uVQCHvw6hcFCTb5r
         OrK9gjGtbsUzREooBoedwIIhNvn5K2/VpxfrRgEcA6sIY5y477IzZEMFg9CvUfA7G8
         ufbEbgxoZ39VtRlHT1zxVnXU2ypDiu2QZh2Aawi0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2CAE88A19;
        Wed, 28 Aug 2019 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566998194;
        bh=byN0+oRJ97XKqT9ACdxABqAh2yXx1PCB8rvsaIeSLoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZBJxs+MId26vBvWg/JGYNa2Skw9hXxWo9ja8Hz/QJihbMcsDfBI7zYLe5xTtPgOi
         fZIZDpMOUgwVYoRGbT3thQlb6/HE//Kf4Gvl4nP3GgmAH8yPAezQxP8UkRV19kdz4Z
         Ri53XhOQOfO7NX5rBFFuxynNT5Y78E2KeE1QkCoE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2CAE88A19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 2/8] ath10k: enable RX bundle receive for sdio
Date:   Wed, 28 Aug 2019 21:16:11 +0800
Message-Id: <1566998177-2658-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alagu Sankar <alagusankar@silex-india.com>

The existing implementation of initiating multiple sdio transfers for
receive bundling is slowing down the receive speed. Combining the
transfers using a bundle method would be ideal.

The transmission utilization ratio for sdio bus for small packet is
slow, because the space and time cost for sdio bus is same for large
length packet and small length packet. So the speed of data for large
length packet is higher than small length.

Test result of different length of data:
data packet(byte)   cost time(us)   calculated rate(Mbps)
      256               28                73
      512               33               124
     1024               35               234
     1792               45               318
    14336              168               682
    28672              333               688
    57344              660               695

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: fix incorrect skb tail of rx bundle in ath10k_sdio_mbox_rx_process_packet
v3: change some code style
split fix incorrect skb tail of rx bundle to patch "adjust skb length in ath10k_sdio_mbox_rx_packet"

 drivers/net/wireless/ath/ath10k/sdio.c | 106 +++++++++++++++++++++------------
 drivers/net/wireless/ath/ath10k/sdio.h |   7 ++-
 2 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 1127e44..23c998d 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -24,6 +24,9 @@
 #include "trace.h"
 #include "sdio.h"
 
+#define ATH10K_SDIO_DMA_BUF_SIZE	(32 * 1024)
+#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)
+
 /* inlined helper functions */
 
 static inline int ath10k_sdio_calc_txrx_padded_len(struct ath10k_sdio *ar_sdio,
@@ -484,11 +487,11 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 	return ret;
 }
 
-static int ath10k_sdio_mbox_alloc_pkt_bundle(struct ath10k *ar,
-					     struct ath10k_sdio_rx_data *rx_pkts,
-					     struct ath10k_htc_hdr *htc_hdr,
-					     size_t full_len, size_t act_len,
-					     size_t *bndl_cnt)
+static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
+					 struct ath10k_sdio_rx_data *rx_pkts,
+					 struct ath10k_htc_hdr *htc_hdr,
+					 size_t full_len, size_t act_len,
+					 size_t *bndl_cnt)
 {
 	int ret, i;
 
@@ -529,6 +532,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 	size_t full_len, act_len;
 	bool last_in_bundle;
 	int ret, i;
+	int pkt_cnt = 0;
 
 	if (n_lookaheads > ATH10K_SDIO_MAX_RX_MSGS) {
 		ath10k_warn(ar,
@@ -572,20 +576,22 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 			 */
 			size_t bndl_cnt;
 
-			ret = ath10k_sdio_mbox_alloc_pkt_bundle(ar,
-								&ar_sdio->rx_pkts[i],
-								htc_hdr,
-								full_len,
-								act_len,
-								&bndl_cnt);
+			struct ath10k_sdio_rx_data *rx_pkts =
+				&ar_sdio->rx_pkts[pkt_cnt];
+
+			ret = ath10k_sdio_mbox_alloc_bundle(ar,
+							    rx_pkts,
+							    htc_hdr,
+							    full_len,
+							    act_len,
+							    &bndl_cnt);
 
 			if (ret) {
 				ath10k_warn(ar, "alloc_bundle error %d\n", ret);
 				goto err;
 			}
 
-			n_lookaheads += bndl_cnt;
-			i += bndl_cnt;
+			pkt_cnt += bndl_cnt;
 			/*Next buffer will be the last in the bundle */
 			last_in_bundle = true;
 		}
@@ -597,7 +603,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 		if (htc_hdr->flags & ATH10K_HTC_FLAGS_RECV_1MORE_BLOCK)
 			full_len += ATH10K_HIF_MBOX_BLOCK_SIZE;
 
-		ret = ath10k_sdio_mbox_alloc_rx_pkt(&ar_sdio->rx_pkts[i],
+		ret = ath10k_sdio_mbox_alloc_rx_pkt(&ar_sdio->rx_pkts[pkt_cnt],
 						    act_len,
 						    full_len,
 						    last_in_bundle,
@@ -606,9 +612,10 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 			ath10k_warn(ar, "alloc_rx_pkt error %d\n", ret);
 			goto err;
 		}
+		pkt_cnt++;
 	}
 
-	ar_sdio->n_rx_pkts = i;
+	ar_sdio->n_rx_pkts = pkt_cnt;
 
 	return 0;
 
@@ -622,10 +629,10 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 	return ret;
 }
 
-static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
-				      struct ath10k_sdio_rx_data *pkt)
+static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct ath10k_sdio_rx_data *pkt = &ar_sdio->rx_pkts[0];
 	struct sk_buff *skb = pkt->skb;
 	struct ath10k_htc_hdr *htc_hdr;
 	int ret;
@@ -633,46 +640,62 @@ static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
 	ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
 				 skb->data, pkt->alloc_len);
 
-	if (!ret) {
-		/* Update actual length. The original length may be incorrect,
-		 * as the FW will bundle multiple packets as long as their sizes
-		 * fit within the same aligned length (pkt->alloc_len).
-		 */
-		htc_hdr = (struct ath10k_htc_hdr *)skb->data;
-		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
-		if (pkt->act_len <= pkt->alloc_len) {
-			skb_put(skb, pkt->act_len);
-		} else {
-			ath10k_warn(ar, "rx packet too large (%zu > %zu)\n",
-				    pkt->act_len, pkt->alloc_len);
-			ret = -EMSGSIZE;
-		}
+	if (ret) {
+		ar_sdio->n_rx_pkts = 0;
+		ath10k_sdio_mbox_free_rx_pkt(pkt);
+		return ret;
 	}
 
+	htc_hdr = (struct ath10k_htc_hdr *)skb->data;
+	pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
 	pkt->status = ret;
+	skb_put(skb, pkt->act_len);
 
 	return ret;
 }
 
-static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
+static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct ath10k_sdio_rx_data *pkt;
+	struct ath10k_htc_hdr *htc_hdr;
 	int ret, i;
+	u32 pkt_offset, virt_pkt_len;
 
+	virt_pkt_len = 0;
 	for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
-		ret = ath10k_sdio_mbox_rx_packet(ar,
-						 &ar_sdio->rx_pkts[i]);
+		virt_pkt_len += ar_sdio->rx_pkts[i].alloc_len;
+	}
+
+	if (virt_pkt_len < ATH10K_SDIO_DMA_BUF_SIZE) {
+		ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
+					 ar_sdio->vsg_buffer, virt_pkt_len);
 		if (ret)
 			goto err;
+	} else {
+		ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_len);
+	}
+
+	pkt_offset = 0;
+	for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
+		pkt = &ar_sdio->rx_pkts[i];
+		htc_hdr = (struct ath10k_htc_hdr *)(ar_sdio->vsg_buffer + pkt_offset);
+		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
+
+		skb_put_data(pkt->skb, htc_hdr, pkt->act_len);
+		pkt->status = 0;
+		pkt_offset += pkt->alloc_len;
 	}
 
 	return 0;
 
 err:
 	/* Free all packets that was not successfully fetched. */
-	for (; i < ar_sdio->n_rx_pkts; i++)
+	for (i = 0; i < ar_sdio->n_rx_pkts; i++)
 		ath10k_sdio_mbox_free_rx_pkt(&ar_sdio->rx_pkts[i]);
 
+	ar_sdio->n_rx_pkts = 0;
+
 	return ret;
 }
 
@@ -715,7 +738,10 @@ static int ath10k_sdio_mbox_rxmsg_pending_handler(struct ath10k *ar,
 			 */
 			*done = false;
 
-		ret = ath10k_sdio_mbox_rx_fetch(ar);
+		if (ar_sdio->n_rx_pkts > 1)
+			ret = ath10k_sdio_mbox_rx_fetch_bundle(ar);
+		else
+			ret = ath10k_sdio_mbox_rx_fetch(ar);
 
 		/* Process fetched packets. This will potentially update
 		 * n_lookaheads depending on if the packets contain lookahead
@@ -1123,7 +1149,7 @@ static int ath10k_sdio_bmi_get_rx_lookahead(struct ath10k *ar)
 					 MBOX_HOST_INT_STATUS_ADDRESS,
 					 &rx_word);
 		if (ret) {
-			ath10k_warn(ar, "unable to read RX_LOOKAHEAD_VALID: %d\n", ret);
+			ath10k_warn(ar, "unable to read rx_lookahd: %d\n", ret);
 			return ret;
 		}
 
@@ -2018,6 +2044,12 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		goto err_core_destroy;
 	}
 
+	ar_sdio->vsg_buffer = devm_kmalloc(ar->dev, ATH10K_SDIO_VSG_BUF_SIZE, GFP_KERNEL);
+	if (!ar_sdio->vsg_buffer) {
+		ret = -ENOMEM;
+		goto err_core_destroy;
+	}
+
 	ar_sdio->irq_data.irq_en_reg =
 		devm_kzalloc(ar->dev, sizeof(struct ath10k_sdio_irq_enable_regs),
 			     GFP_KERNEL);
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index b8c7ac0..4896eca 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -138,8 +138,8 @@ struct ath10k_sdio_irq_proc_regs {
 	u8 rx_lookahead_valid;
 	u8 host_int_status2;
 	u8 gmbox_rx_avail;
-	__le32 rx_lookahead[2];
-	__le32 rx_gmbox_lookahead_alias[2];
+	__le32 rx_lookahead[2 * ATH10K_HIF_MBOX_NUM_MAX];
+	__le32 int_status_enable;
 };
 
 struct ath10k_sdio_irq_enable_regs {
@@ -196,6 +196,9 @@ struct ath10k_sdio {
 	struct ath10k *ar;
 	struct ath10k_sdio_irq_data irq_data;
 
+	/* temporary buffer for sdio read */
+	u8 *vsg_buffer;
+
 	/* temporary buffer for BMI requests */
 	u8 *bmi_buf;
 
-- 
1.9.1

