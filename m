Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C723FB9DC5
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437809AbfIUMQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 08:16:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437806AbfIUMQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 08:16:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4BD4761418; Sat, 21 Sep 2019 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569068163;
        bh=wexDgknUrxzPZemPf9++eVSoD7b53DMLKuNNq26HWPA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BgDM/cnHTlD3sgocEHUR1AgZaF75mxpQF2RVexvqIr9u5UMtMjfydmumL6nR/Wq6Q
         EeENOWqn+ELlAVj0d1Ub9mBjmrb4m+BQFe/Uf3Cfa56NFwEi8Y7gQR2OCl24U1MNNU
         JTIyNtKsMTxbEYsZBnjSeiXnRbK+fJfqS7Zpt18M=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FF4460364;
        Sat, 21 Sep 2019 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569068162;
        bh=wexDgknUrxzPZemPf9++eVSoD7b53DMLKuNNq26HWPA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ulss5o2Mj2PEdoVC9gnHcNeXi00NWtoEwkQ6hPRl8RWuqR6puQNoT/FuuNohINDya
         kc91Q8Wfb4ewTYEkQmP346mxfBgs15fqmOE+rDlVZ21rdGJAPr2HEneefil2Kx0ppP
         gNij0nWLvxsrMmVGnEDSxhoo2PEvjpVUQWuOe8J4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FF4460364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 2/8] ath10k: enable RX bundle receive for sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <1567679893-14029-3-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 15:15:58 +0300
In-Reply-To: <1567679893-14029-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:07 +0800")
Message-ID: <87r249alq9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> From: Alagu Sankar <alagusankar@silex-india.com>
>
> The existing implementation of initiating multiple sdio transfers for
> receive bundling is slowing down the receive speed. Combining the
> transfers using a bundle method would be ideal.
>
> The transmission utilization ratio for sdio bus for small packet is
> slow, because the space and time cost for sdio bus is same for large
> length packet and small length packet. So the speed of data for large
> length packet is higher than small length.
>
> Test result of different length of data:
> data packet(byte)   cost time(us)   calculated rate(Mbps)
>       256               28                73
>       512               33               124
>      1024               35               234
>      1792               45               318
>     14336              168               682
>     28672              333               688
>     57344              660               695
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -24,6 +24,9 @@
>  #include "trace.h"
>  #include "sdio.h"
>  
> +#define ATH10K_SDIO_DMA_BUF_SIZE	(32 * 1024)
> +#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)

Why two defines? Seems error prone to me and using the latter should be
enough.

> @@ -529,6 +532,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
>  	size_t full_len, act_len;
>  	bool last_in_bundle;
>  	int ret, i;
> +	int pkt_cnt = 0;
>  
>  	if (n_lookaheads > ATH10K_SDIO_MAX_RX_MSGS) {
>  		ath10k_warn(ar,
> @@ -572,20 +576,22 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
>  			 */
>  			size_t bndl_cnt;
>  
> -			ret = ath10k_sdio_mbox_alloc_pkt_bundle(ar,
> -								&ar_sdio->rx_pkts[i],
> -								htc_hdr,
> -								full_len,
> -								act_len,
> -								&bndl_cnt);
> +			struct ath10k_sdio_rx_data *rx_pkts =
> +				&ar_sdio->rx_pkts[pkt_cnt];

You need to declare rx_pkts in the beginning of the block, not mixed
within the code.

> @@ -606,9 +612,10 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
>  			ath10k_warn(ar, "alloc_rx_pkt error %d\n", ret);
>  			goto err;
>  		}
> +		pkt_cnt++;

Empty line before 'pkt_cnt++'.

> -static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
> +static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
>  {
>  	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +	struct ath10k_sdio_rx_data *pkt;
> +	struct ath10k_htc_hdr *htc_hdr;
>  	int ret, i;
> +	u32 pkt_offset, virt_pkt_len;
>  
> +	virt_pkt_len = 0;
>  	for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
> -		ret = ath10k_sdio_mbox_rx_packet(ar,
> -						 &ar_sdio->rx_pkts[i]);
> +		virt_pkt_len += ar_sdio->rx_pkts[i].alloc_len;
> +	}
> +
> +	if (virt_pkt_len < ATH10K_SDIO_DMA_BUF_SIZE) {
> +		ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
> +					 ar_sdio->vsg_buffer, virt_pkt_len);
>  		if (ret)
>  			goto err;
> +	} else {
> +		ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_len);
> +		ret = -ENOMEM;
> +		goto err;
> +	}

Use common error handling style, ath10k_warn() and -E2BIG:

if (virt_pkt_len >= ATH10K_SDIO_DMA_BUF_SIZE) {
	ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_len);
	ret = -E2BIG;
	goto err;
}

ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
			 ar_sdio->vsg_buffer, virt_pkt_len);
if (ret) {
        ath10k_warn("failed to do foo: %d", ret)
	goto err;
}

> @@ -1123,7 +1151,7 @@ static int ath10k_sdio_bmi_get_rx_lookahead(struct ath10k *ar)
>  					 MBOX_HOST_INT_STATUS_ADDRESS,
>  					 &rx_word);
>  		if (ret) {
> -			ath10k_warn(ar, "unable to read RX_LOOKAHEAD_VALID: %d\n", ret);
> +			ath10k_warn(ar, "unable to read rx_lookahd: %d\n", ret);

Looks like an unnecessary change?

> @@ -196,6 +196,9 @@ struct ath10k_sdio {
>  	struct ath10k *ar;
>  	struct ath10k_sdio_irq_data irq_data;
>  
> +	/* temporary buffer for sdio read */
> +	u8 *vsg_buffer;

So how is vsg_buffer protected? You should document that here.

-- 
Kalle Valo
