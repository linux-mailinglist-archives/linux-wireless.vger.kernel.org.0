Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC3A52A4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfIBJWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 05:22:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfIBJWm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 05:22:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D576260850; Mon,  2 Sep 2019 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567416160;
        bh=XmntMnNVEauXBbfZhlh2Q0B6nfOLDvXlQX4m6gfNuAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv/Job7EopKViwiZ9Iwk2Wo2H54QFLazl5xg7D8ZTde/28umfS2TfPsBEHdwx5LRq
         oEksTxVeqxve4InaUxWCRnBMK1tMEHt3Y0lsd7PHzok04AwEs2SEVH0Yk6T78W6Ned
         +h9yET7YRjWZvX6mlJcNqV1WAHeSM+rvND1mx95w=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 975E9605A2;
        Mon,  2 Sep 2019 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567416160;
        bh=XmntMnNVEauXBbfZhlh2Q0B6nfOLDvXlQX4m6gfNuAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv/Job7EopKViwiZ9Iwk2Wo2H54QFLazl5xg7D8ZTde/28umfS2TfPsBEHdwx5LRq
         oEksTxVeqxve4InaUxWCRnBMK1tMEHt3Y0lsd7PHzok04AwEs2SEVH0Yk6T78W6Ned
         +h9yET7YRjWZvX6mlJcNqV1WAHeSM+rvND1mx95w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 975E9605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
Date:   Mon,  2 Sep 2019 17:22:19 +0800
Message-Id: <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

When the FW bundles multiple packets, pkt->act_len may be incorrect
as it refers to the first packet only (however, the FW will only
bundle packets that fit into the same pkt->alloc_len).

Before this patch, the skb length would be set (incorrectly) to
pkt->act_len in ath10k_sdio_mbox_rx_packet, and then later manually
adjusted in ath10k_sdio_mbox_rx_process_packet.

The first problem is that ath10k_sdio_mbox_rx_process_packet does not
use proper skb_put commands to adjust the length (it directly changes
skb->len), so we end up with a mismatch between skb->head + skb->tail
and skb->data + skb->len. This is quite serious, and causes corruptions
in the TCP stack, as the stack tries to coalesce packets, and relies
on skb->tail being correct (that is, skb_tail_pointer must point to
the first byte_after_ the data).

Instead of re-adjusting the size in ath10k_sdio_mbox_rx_process_packet,
this moves the code to ath10k_sdio_mbox_rx_packet, and also add a
bounds check, as skb_put would crash the kernel if not enough space is
available.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Fixes: 8530b4e7b22bc3b ("ath10k: sdio: set skb len for all rx packets")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: no this patch
v3: new added
v4: change commit log

 drivers/net/wireless/ath/ath10k/sdio.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 8ed4fbd..1127e44 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -381,16 +381,11 @@ static int ath10k_sdio_mbox_rx_process_packet(struct ath10k *ar,
 	struct ath10k_htc_hdr *htc_hdr = (struct ath10k_htc_hdr *)skb->data;
 	bool trailer_present = htc_hdr->flags & ATH10K_HTC_FLAG_TRAILER_PRESENT;
 	enum ath10k_htc_ep_id eid;
-	u16 payload_len;
 	u8 *trailer;
 	int ret;
 
-	payload_len = le16_to_cpu(htc_hdr->len);
-	skb->len = payload_len + sizeof(struct ath10k_htc_hdr);
-
 	if (trailer_present) {
-		trailer = skb->data + sizeof(*htc_hdr) +
-			  payload_len - htc_hdr->trailer_len;
+		trailer = skb->data + skb->len - htc_hdr->trailer_len;
 
 		eid = pipe_id_to_eid(htc_hdr->eid);
 
@@ -632,13 +627,29 @@ static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	struct sk_buff *skb = pkt->skb;
+	struct ath10k_htc_hdr *htc_hdr;
 	int ret;
 
 	ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
 				 skb->data, pkt->alloc_len);
+
+	if (!ret) {
+		/* Update actual length. The original length may be incorrect,
+		 * as the FW will bundle multiple packets as long as their sizes
+		 * fit within the same aligned length (pkt->alloc_len).
+		 */
+		htc_hdr = (struct ath10k_htc_hdr *)skb->data;
+		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
+		if (pkt->act_len <= pkt->alloc_len) {
+			skb_put(skb, pkt->act_len);
+		} else {
+			ath10k_warn(ar, "rx packet too large (%zu > %zu)\n",
+				    pkt->act_len, pkt->alloc_len);
+			ret = -EMSGSIZE;
+		}
+	}
+
 	pkt->status = ret;
-	if (!ret)
-		skb_put(skb, pkt->act_len);
 
 	return ret;
 }
-- 
1.9.1

