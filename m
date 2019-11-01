Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30496EBE8B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 08:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfKAHmu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 03:42:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfKAHmt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 03:42:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8794660A19; Fri,  1 Nov 2019 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572594168;
        bh=8L181n29D2wv/Vu1RML6oHrvstHDa8RPAf92NzGwY0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2s/h6tm7Umoq2m7Sjao9Sn3G+pSX3Zg1ZClKPNhkPfk5vdmlhoDGw5U/9Acvaq6D
         0lhhTPrHdjbYTGqYZipTIT4XB52RmAuTZXOHxJvkq81r2e2U3yBf/ho4L2/r4YvnU6
         RpiklyyO2pfkmV4fqjZmWuidXMR3Rp9hD9iR2EA0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E1E6C602F0;
        Fri,  1 Nov 2019 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572594167;
        bh=8L181n29D2wv/Vu1RML6oHrvstHDa8RPAf92NzGwY0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jgYQzoPJ6IDZz0ctM3DJL0mt4WM9OWVFepHrpNEdtDFcoC9a6HakEnm+ipyMvKFt1
         2AyegcQGmDGSoFKpyGeztfnm9irC3fdEjTY/tj0b0jRydVBIIDxlU4tu+gYOvl3KJu
         O5Ae5IbO7HLGa9kK5Rj64SKKolXszRxNkCCJFoJE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 01 Nov 2019 15:42:47 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
In-Reply-To: <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
 <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
Message-ID: <3f3641ad49a2664d346558760e38b404@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-31 17:08, Kalle Valo wrote:
、> I just realised that this is RX path so we should use 
ATH10K_SKB_RXCB()
> instead. I made the change below to this commit in pending branch:
> 
I will test with the new patch together with other performance patches.
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28da1fe7a3ffa5c55c52328c21165d9efdf2e94c
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h
> b/drivers/net/wireless/ath/ath10k/core.h
> index af68eb5d0776..c5407f5080b2 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -124,6 +124,7 @@ struct ath10k_skb_cb {
>  struct ath10k_skb_rxcb {
>  	dma_addr_t paddr;
>  	struct hlist_node hlist;
> +	u8 eid;
>  };
> 
>  static inline struct ath10k_skb_cb *ATH10K_SKB_CB(struct sk_buff *skb)
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c
> b/drivers/net/wireless/ath/ath10k/sdio.c
> index c34637881219..c7d09b07a382 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -419,7 +419,7 @@ static int
> ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
>  	struct ath10k_htc *htc = &ar->htc;
>  	struct ath10k_sdio_rx_data *pkt;
>  	struct ath10k_htc_ep *ep;
> -	struct ath10k_skb_cb *cb;
> +	struct ath10k_skb_rxcb *cb;
>  	enum ath10k_htc_ep_id id;
>  	int ret, i, *n_lookahead_local;
>  	u32 *lookaheads_local;
> @@ -466,7 +466,7 @@ static int
> ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
>  			goto out;
> 
>  		if (!pkt->trailer_only) {
> -			cb = ATH10K_SKB_CB(pkt->skb);
> +			cb = ATH10K_SKB_RXCB(pkt->skb);
>  			cb->eid = id;
> 
>  			skb_queue_tail(&ar_sdio->rx_head, pkt->skb);
> @@ -1333,14 +1333,14 @@ static void
> ath10k_rx_indication_async_work(struct work_struct *work)
>  						   async_work_rx);
>  	struct ath10k *ar = ar_sdio->ar;
>  	struct ath10k_htc_ep *ep;
> -	struct ath10k_skb_cb *cb;
> +	struct ath10k_skb_rxcb *cb;
>  	struct sk_buff *skb;
> 
>  	while (true) {
>  		skb = skb_dequeue(&ar_sdio->rx_head);
>  		if (!skb)
>  			break;
> -		cb = ATH10K_SKB_CB(skb);
> +		cb = ATH10K_SKB_RXCB(skb);
>  		ep = &ar->htc.endpoint[cb->eid];
>  		ep->ep_ops.ep_rx_complete(ar, skb);
>  	}
