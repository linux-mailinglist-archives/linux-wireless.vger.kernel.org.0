Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833F6E2C29
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438197AbfJXI3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 04:29:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJXI3N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 04:29:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C364D60B12; Thu, 24 Oct 2019 08:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571905752;
        bh=nSCA5+OR5K46lqvfoqS2k/eQ02BuOgI9IqOuCIqU72k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P1joCsWjGHBNZH60E3aEvYQg02N4bHB2oPCJFz6j0Y0flAA1jN50HVyWaTnjB10z7
         LZaJP5Ij4rNEOp5O6tVZZbCHYuh09fxY1TYnibFdydWToT2Q+2es7DkSmN2wkdq6nr
         8AQydLtDR6zd38FxP8X96EHW9aJMA/auD9Wydz8w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5175260B16;
        Thu, 24 Oct 2019 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571905750;
        bh=nSCA5+OR5K46lqvfoqS2k/eQ02BuOgI9IqOuCIqU72k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DswJ17HlcX2AQLy7Cay2azkZW/oqrGm1QKP9tSSl28xXKA4uhL+gAbFpctbb9RA7a
         5WbZUh2dIh+vgZU59U6IazyNn1yA9/BluL+hcXZBdRm3zrBUctJbBP8CgRZnJBFzRT
         eRuLcRU1kQwZM+056Ee1Ud7bohU+DPbgfM3M5hIo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5175260B16
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 1/3] ath10k: enable RX bundle receive for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-2-git-send-email-wgong@codeaurora.org>
Date:   Thu, 24 Oct 2019 11:29:06 +0300
In-Reply-To: <1569402639-31720-2-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:37 +0800")
Message-ID: <87v9sesg19.fsf@kamboji.qca.qualcomm.com>
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
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
>  {
>  	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +	struct ath10k_sdio_rx_data *pkt;
> +	struct ath10k_htc_hdr *htc_hdr;
>  	int ret, i;
> +	u32 pkt_offset, virt_pkt_len;
>  
> +	virt_pkt_len = 0;
> +	for (i = 0; i < ar_sdio->n_rx_pkts; i++)
> +		virt_pkt_len += ar_sdio->rx_pkts[i].alloc_len;
> +
> +	if (virt_pkt_len > ATH10K_SDIO_VSG_BUF_SIZE) {
> +		ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_len);
> +		ret = -E2BIG;
> +		goto err;
> +	}

This should use ath10k_warn(), fixed in the pending branch. I also
improved the log message.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
