Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30DBB1A2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 11:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407284AbfIWJtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 05:49:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407268AbfIWJtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 05:49:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E38660274; Mon, 23 Sep 2019 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569232145;
        bh=l+G9gwJkMnxph70rqdX1rD9rOffkiVc7oJo/k+NvESY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IKBos90GHXlfK2JuiZhirbfaklsQ+qGaunjJ0dRZdPY9QQG9nJgQULBiO6B3W03fN
         X2/UQ8cyc02HB2im3bK+v6OGGJNUM1i2L99ZNXpfXgaU+GXTfe4Ez1jvOdQ0FMjS6R
         ovbHceBHgPZk3RQ/MP1tIh8kgoxiroiVBiSVrKWk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7ED366021C;
        Mon, 23 Sep 2019 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569232144;
        bh=l+G9gwJkMnxph70rqdX1rD9rOffkiVc7oJo/k+NvESY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nj4BAorwAPI+DHUjmC4Sd4Cob+CL+rJN5/YXon3Pk+95rbDvrA0R9Ofy25UScVB99
         H1Yq/Vgc0CmQIDveNyGSIKZg/8MXLw50zFfd2Bnixo7vt6/6VOZIW0G7oLbokX4HWj
         Jx/mJsF9sUUYPQ8V9RDbO2+AhgVbs7GLADVQNtTw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7ED366021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 4/8] ath10k: add workqueue for RX path of sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <1567679893-14029-5-git-send-email-wgong@codeaurora.org>
Date:   Mon, 23 Sep 2019 12:49:01 +0300
In-Reply-To: <1567679893-14029-5-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:09 +0800")
Message-ID: <87o8zb8hrm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The thread of read rx message by sdio bus from firmware is
> synchronous, it will cost much time for process the left part
> of rx message which includes indicate the rx packet to uppper
> net stack. It will reduce the time of read from sdio.

This paragraph is hard to read.

> This patch move the indication to a workqueue, it results in
> significant performance improvement on RX path.

How much is "significant"? Some numbers would make it a lot easier to
understand the importance of the changes.

> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +static struct ath10k_sdio_rx_request *ath10k_sdio_alloc_rx_req(struct ath10k *ar)
> +{
> +	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +	struct ath10k_sdio_rx_request *rx_req;
> +
> +	spin_lock_bh(&ar_sdio->rx_lock);
> +
> +	if (list_empty(&ar_sdio->rx_req_freeq)) {
> +		rx_req = NULL;
> +		ath10k_dbg(ar, ATH10K_DBG_SDIO, "rx_req alloc fail\n");
> +		goto out;
> +	}
> +
> +	rx_req = list_first_entry(&ar_sdio->rx_req_freeq,
> +				  struct ath10k_sdio_rx_request, list);
> +	list_del(&rx_req->list);
> +
> +out:
> +	spin_unlock_bh(&ar_sdio->rx_lock);
> +	return rx_req;
> +}

The name of the function is "alloc" but it does not allocate anything?

> +static void ath10k_sdio_free_rx_req(struct ath10k *ar,
> +				    struct ath10k_sdio_rx_request *rx_req)
> +{
> +	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +
> +	memset(rx_req, 0, sizeof(*rx_req));
> +
> +	spin_lock_bh(&ar_sdio->rx_lock);
> +	list_add_tail(&rx_req->list, &ar_sdio->rx_req_freeq);
> +	spin_unlock_bh(&ar_sdio->rx_lock);
> +}

And this neither frees anything. IMHO that's quite misleading naming.
Maybe call _get() and _put()? Or maybe there's some more common naming
in kernel?

> +static int ath10k_sdio_prep_async_rx_req(struct ath10k *ar,
> +					 struct sk_buff *skb,
> +					 struct ath10k_htc_ep *ep)
> +{
> +	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +	struct ath10k_sdio_rx_request *rx_req;
> +
> +	/* Allocate a rx request for the message and queue it on the
> +	 * SDIO rx workqueue.
> +	 */
> +	rx_req = ath10k_sdio_alloc_rx_req(ar);
> +	if (!rx_req) {
> +		ath10k_warn(ar, "unable to allocate rx request for async request\n");
> +		return -ENOMEM;
> +	}
> +
> +	rx_req->skb = skb;
> +	rx_req->ep = ep;
> +
> +	spin_lock_bh(&ar_sdio->wr_async_lock_rx);
> +	list_add_tail(&rx_req->list, &ar_sdio->wr_asyncq_rx);
> +	spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
> +
> +	return 0;
> +}

Is there enough room in struct ath10k_skb_cb so that you could add
struct ath10k_htc_ep there? That way struct ath10k_sdio_rx_request would
be useless and you could just use skb_queue_*() functions, which would
make this patch a lot simpler.

> @@ -209,6 +224,11 @@ struct ath10k_sdio {
>  	struct list_head wr_asyncq;
>  	/* protects access to wr_asyncq */
>  	spinlock_t wr_async_lock;
> +
> +	struct work_struct wr_async_work_rx;
> +	struct list_head wr_asyncq_rx;
> +	/* protects access to wr_asyncq_rx */
> +	spinlock_t wr_async_lock_rx;
>  };

I think the naming is now confusing. I'm guessing "wr_async_lock" means
"write asynchronous lock"? So what is wr_asyncq_rx then? It would a lot
simpler if we have tx_lock and rx_lock, or something like that.

Naturally all cleanup for wr_async_lock needs to be done in a separate
patch.

-- 
Kalle Valo
