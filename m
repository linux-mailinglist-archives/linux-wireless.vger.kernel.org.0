Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3036241CC4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgHKOyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgHKOyE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 10:54:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47444C06174A
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 07:54:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so13789188ljj.5
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jFruccA++WD7YGUtHCDHy45cLWQdIputDc+e+YiPSaU=;
        b=Auoyun0U1uJ3uTU08fy/0c0pVyLLJCFDPz839AiNZjPxspzBuwmVyo/Wy/Cf0G0yE1
         XrvlMMVR+y3pGTlfK0Ea3VTH9Uhvc95efi3EtMQ8NXBGlj0BqZrTi+AkwTDWtXpOrzGl
         eZIcGJulfbsTZaraodOWmnFwVowAChULnzRKZpKsf9DhqLK6L3V0yc939FCkx7oeZZkW
         sa8fmRrYLoEz0YYTnHF0WJs8DOQLr/7K9VuiuPwAgWbgEJs228hwJtxdEFtoWy4SiIAi
         V5PhNONvfLiIDk58oQ2IGcdEOTbmYb4TBZsBkXuDBVl0qCUGeLFW+HS5BNRsR3pun43l
         czcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFruccA++WD7YGUtHCDHy45cLWQdIputDc+e+YiPSaU=;
        b=HRpNsCZze2LRmPHufP3qaLv0+on5RjmtceHX0GiomcygNGLnv4S4NhRpCu6qEtG+8C
         h1jodZRqHIhNUGCKu0w62PMw8s6vQYRAx4AKcOW49Oo161VcKNRkQc2CDd3UB8pKODXX
         ZW3I6xquayV30RRLGby+eGR3AVeQj3IwrJxxoyKsZ904DSmNXGpKBP9R0pkvjCa0rAtG
         zPIerP0hbACgr2taXKnsVt4e1GL7PwlE/6IMyYyYBn1cWAUZ0ofKn1Vkwvpe76qJadp5
         sWRCGPt2vno6icVRx6+9GhcYE8EpAmbyf5DJ8NmQMKD6MI6dm25NeKK5SmqkjYzvSzVx
         GeVg==
X-Gm-Message-State: AOAM530Bv+tT6FOvDhzhTBscMUUbpvwICs5n4nfxGMx3oWn56LK3BPKY
        L7oBZbctcfj4n3JZ9gjjzqA=
X-Google-Smtp-Source: ABdhPJyV3aRRPX+rsldh0ejrx1gqEDu0iBe/QowLPqk30CkKTFOJ6fnQrchUAHC1oaSUdWgEPeOPyA==
X-Received: by 2002:a2e:164f:: with SMTP id 15mr3314331ljw.68.1597157642447;
        Tue, 11 Aug 2020 07:54:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id x14sm10085377ljd.1.2020.08.11.07.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:54:01 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
 <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
 <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
 <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <112956e1-df38-0a35-c2f0-8d9e1568d3c5@gmail.com>
Date:   Tue, 11 Aug 2020 17:54:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

11.08.2020 11:35, Wright Feng пишет:
..
> Hi Dmitry,
> We have a fix for this issue. But we got the different test result
> numbers from yours, so would you help us verify the same with
> following patch in your setup?
> With your confirmation, I can make sure we see the same issue.
> 
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index e8712ad3ac45..ea07bb1bfe27 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -664,8 +664,13 @@ static void pkt_align(struct sk_buff *p, int len,
> int align)
>  /* To check if there's window offered */
>  static bool data_ok(struct brcmf_sdio *bus)
>  {
> -    /* Reserve TXCTL_CREDITS credits for txctl */
> -    return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
> +    u8 tx_rsv = 0;
> +
> +    /* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
> +    if (bus->ctrl_frame_stat)
> +        tx_rsv = TXCTL_CREDITS;
> +
> +    return (bus->tx_max - bus->tx_seq) > tx_rsv &&
>             ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
>  }

Hello, Wright!

I tried this patch and it doesn't fix the problem.

Could you please tell what firmware you're using?

I'm using stock firmware that comes from the linux-firmware package and
this NVRAM [1].

[1]
https://github.com/grate-driver/linux-firmware/blob/master/brcm/brcmfmac4329-sdio.acer%2Cpicasso.txt

 brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4329-sdio for chip
BCM4329/3
 brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
device may have limited channels available
 brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: Sep  2 2011
14:48:19 version 4.220.48

It also interesting that you're getting 40Mbit/s. I never managed to get
that speed on 4329 using upstream brcmfmac driver, but was getting it
using downstream BCMDHD driver. At some point I even tried to figure out
what's the difference which makes the upstream driver to have
significantly lower throughput than downstream and had older BCMDHD
ported to a recent upstream kernel, unfortunately I couldn't spot
anything obvious. Having BCMDHD and brcmfmac back-to-back on the same
hardware, the same kernel and using same firmware (IIRC), the BCMDHD was
more than x2 faster. I also remember that I had to enforce HT mode on AP
in order to get speeds over 15Mbit/s using BCMDHD, which made me to
conclude that upstream brcmfmac driver just doesn't support that HT mode
for 4329, but now I'm seeing yours iperf results and it makes me wonder..
