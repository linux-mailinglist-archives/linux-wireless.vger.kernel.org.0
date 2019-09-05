Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1AA9FD9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfIEKit (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 06:38:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfIEKit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 06:38:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B5246058E; Thu,  5 Sep 2019 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567679928;
        bh=Jm/65CSBXoW4Qkeip2gI3KoQx4bVP4GnBIN/HeTvZv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hf2vfchAmsEVzNQSKjaV+vCtInGf/Z7OqqQn5OJmZiOVRmst36zmNvfbeOdzo80VT
         oEh5xW2U/zslv22uVcq+KQKC4UjXhOrQFWfDZSr88qOw4Pi05Z3KhWxQTwlOU0xtyS
         IYzfmCUhEzI/CeRpQ2y2OfDd7w6UCchAYzn3nUH8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19FA160592;
        Thu,  5 Sep 2019 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567679927;
        bh=Jm/65CSBXoW4Qkeip2gI3KoQx4bVP4GnBIN/HeTvZv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU1hEVBZSx1cHDiXjncm1BkqcDvKe3DbVjWO7yK4x4f0RUJvczVFSzcRJRMvy04Ba
         Ht7qLqmE/7gMipPY/yWqokNt1Q/9ZFCIT41xa+oQjail5usSiQO4nC0bFsIafLJqji
         VIHU+Xc3wxc2CUu7g4sgUUJvtl5k0SjyKZSnDQas=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19FA160592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v5 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
Date:   Thu,  5 Sep 2019 18:38:06 +0800
Message-Id: <1567679893-14029-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
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
v5: no change
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

