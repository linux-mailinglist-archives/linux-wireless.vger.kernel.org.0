Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC42B11045F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLCSmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 13:42:47 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38841 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLCSmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 13:42:46 -0500
Received: by mail-il1-f194.google.com with SMTP id u17so4123004ilq.5
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2019 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XN4AkH2tFjXNvWgUJtFFNH/pQJwENKwSLhbr4vK9+/U=;
        b=NcyVRt2eOS1thodxa4w9OCpvl79cHAvRdKCVzCTFEtvkgJNXiTc8b8WfKtnb8NLLjG
         zpnFqCZwJZYCd5fB+sMPMMbjVbvOPvMRG27G+bLtGC2JpU71OryBMjR/mmcIp1Lql+sp
         t909tJM9DtMf1Oz9+jEt4X4egXIMeNpfkamn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XN4AkH2tFjXNvWgUJtFFNH/pQJwENKwSLhbr4vK9+/U=;
        b=SxWlpSM4+pFIo9wk3pIzXO5K0bbcBXPOafh/IpGC6F0sW9LHX+BlrKLSbSPrkh9ll0
         EedTEZGRoX26fXhjGU0dFukDEcQgZNoHxIzbswmrb3n7LN23Ixlvyrwl1q5dPoW/2Lhx
         Qu+QQvcy+kkNfzjqFq8/qsFu81KDhjeYxru6V3vMubYQuqvTmha+lRdMR75XYWoa735M
         e630uMa3Ww83RMsqzqX5aVI7M701y86kXgGUoukmZn3yPsDkMa/d97wBBYpwFxaeY2zr
         jdmXOVqkdLLzWz/BlbRiIlRXPJFtF7lS6CEfWBs0Zo+kfXYA599NGJu9oHXzXePmMbUf
         g1Jg==
X-Gm-Message-State: APjAAAVRlkSxIfrh94+ivj+2/+o8InOgShcTj91vnDQvpLzycTpSqlaS
        uaCMoVsKJbO9vympXgwnadOn0JI3O7QUvD4afpknDA==
X-Google-Smtp-Source: APXvYqwNStKw4OxZQn9UVz2aItrTxCmmJBbWJuZbOF4pp9/jqWUsrtdzub14EFKxGomo2I6Vmi5yaow5fj8i0JqtAgY=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr6038632ill.55.1575398566067;
 Tue, 03 Dec 2019 10:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20191203095855.c4fradmsixgbq7mc@kili.mountain>
In-Reply-To: <20191203095855.c4fradmsixgbq7mc@kili.mountain>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Tue, 3 Dec 2019 10:42:20 -0800
Message-ID: <CA+8PC_ehSW=-eVC0qAbh-m+8WHwKrmbYWrhmX8w4ovGS8TVE0w@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix use after free in brcmf_sdio_readframes()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 3, 2019 at 1:59 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The brcmu_pkt_buf_free_skb() function frees "pkt" so it leads to a
> static checker warning:
>
>     drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1974 brcmf_sdio_readframes()
>     error: dereferencing freed memory 'pkt'
>
> It looks like there was supposed to be a continue after we free "pkt".

Good catch!

Acked-by: Franky Lin <franky.lin@broadcom.com>

>
> Fixes: 4754fceeb9a6 ("brcmfmac: streamline SDIO read frame routine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis.  Not tested.
>
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 264ad63232f8..1dea0178832e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -1935,6 +1935,7 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
>                                                BRCMF_SDIO_FT_NORMAL)) {
>                                 rd->len = 0;
>                                 brcmu_pkt_buf_free_skb(pkt);
> +                               continue;
>                         }
>                         bus->sdcnt.rx_readahead_cnt++;
>                         if (rd->len != roundup(rd_new.len, 16)) {
> --
> 2.11.0
>
