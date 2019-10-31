Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3FEAC54
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfJaJIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 05:08:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJaJIX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 05:08:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 639AE609CA; Thu, 31 Oct 2019 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572512902;
        bh=j3G5XDKojh3EkWpKdPoVwJcpf4Ab2nMDbcYHAvYEDh4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ch2eDcQyPErAf3I/V9dQb1EvbrmBAP8r9rYmYet7OHzzmgkR524nY9fb3iExhVkri
         qDjX+YjKU9WUbk96PwIkzbBoiwX507vgNqlYQRUJERnXnTBK+MJsbpc9sbIumMm7Y9
         rH0b5MF4HZYW7JHs5ivP9S/AeQTc9UiMStnWFElE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A34760112;
        Thu, 31 Oct 2019 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572512901;
        bh=j3G5XDKojh3EkWpKdPoVwJcpf4Ab2nMDbcYHAvYEDh4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OMI0bkdW4Fyzvb+PC8IxL9HNwHu0auLHeGU5JUrup1voV+7AwcqJk1REtfP+9gcX4
         0syA90MxSuzFv9i2ZkfC3YYGDfzCsKwM4t6FPPPOfGYGUv8EzYJxEzMwSi3h1C3KI8
         Abm0u3pH2U+HT9GdPFCbCjW41MQdNwd/okg6c93w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A34760112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
Date:   Thu, 31 Oct 2019 11:08:18 +0200
In-Reply-To: <1569402639-31720-4-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:39 +0800")
Message-ID: <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> For RX, it has two parts, one is to read data from sdio, another
> is to indicate the packets to upper stack. Recently it has only
> one thread to do all RX things, it results that it is sequential
> for RX and low throughout, change RX to parallel for the two parts
> will increase throughout.
>
> This patch move the indication to a workqueue, it results in
> significant performance improvement on RX path.
>
> Udp rx throughout is 200Mbps without this patch, and it arrives
> 400Mbps with this patch.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +static void ath10k_rx_indication_async_work(struct work_struct *work)
> +{
> +	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
> +						   async_work_rx);
> +	struct ath10k *ar = ar_sdio->ar;
> +	struct ath10k_htc_ep *ep;
> +	struct ath10k_skb_cb *cb;
> +	struct sk_buff *skb;
> +
> +	while (true) {
> +		skb = skb_dequeue(&ar_sdio->rx_head);
> +		if (!skb)
> +			break;
> +		cb = ATH10K_SKB_CB(skb);
> +		ep = &ar->htc.endpoint[cb->eid];
> +		ep->ep_ops.ep_rx_complete(ar, skb);
> +	}
> +}

I just realised that this is RX path so we should use ATH10K_SKB_RXCB()
instead. I made the change below to this commit in pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28da1fe7a3ffa5c55c52328c21165d9efdf2e94c

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index af68eb5d0776..c5407f5080b2 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -124,6 +124,7 @@ struct ath10k_skb_cb {
 struct ath10k_skb_rxcb {
 	dma_addr_t paddr;
 	struct hlist_node hlist;
+	u8 eid;
 };
 
 static inline struct ath10k_skb_cb *ATH10K_SKB_CB(struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index c34637881219..c7d09b07a382 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -419,7 +419,7 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 	struct ath10k_htc *htc = &ar->htc;
 	struct ath10k_sdio_rx_data *pkt;
 	struct ath10k_htc_ep *ep;
-	struct ath10k_skb_cb *cb;
+	struct ath10k_skb_rxcb *cb;
 	enum ath10k_htc_ep_id id;
 	int ret, i, *n_lookahead_local;
 	u32 *lookaheads_local;
@@ -466,7 +466,7 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 			goto out;
 
 		if (!pkt->trailer_only) {
-			cb = ATH10K_SKB_CB(pkt->skb);
+			cb = ATH10K_SKB_RXCB(pkt->skb);
 			cb->eid = id;
 
 			skb_queue_tail(&ar_sdio->rx_head, pkt->skb);
@@ -1333,14 +1333,14 @@ static void ath10k_rx_indication_async_work(struct work_struct *work)
 						   async_work_rx);
 	struct ath10k *ar = ar_sdio->ar;
 	struct ath10k_htc_ep *ep;
-	struct ath10k_skb_cb *cb;
+	struct ath10k_skb_rxcb *cb;
 	struct sk_buff *skb;
 
 	while (true) {
 		skb = skb_dequeue(&ar_sdio->rx_head);
 		if (!skb)
 			break;
-		cb = ATH10K_SKB_CB(skb);
+		cb = ATH10K_SKB_RXCB(skb);
 		ep = &ar->htc.endpoint[cb->eid];
 		ep->ep_ops.ep_rx_complete(ar, skb);
 	}

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
