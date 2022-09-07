Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2335B07DD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIGPCb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIGPCa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 11:02:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E032D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 08:02:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g14so10579250qto.11
        for <linux-wireless@vger.kernel.org>; Wed, 07 Sep 2022 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date;
        bh=3r46zgR0SxCiGzmzzXUPWfV053YkrnQyc0E900AmOtw=;
        b=mspK/NIFjliTgC4+OsA1KdzuNXALsYKw9CwNCwlh/fmfQz/BKyECEtFZbNxH0rrvla
         vW03BKQH/QzK7j9S3nA5my2uWy44j0LCni1/dWu9kCEOqLuRTQeVfBSNbD7lTu9POhbm
         vxIqMnrg7Gj86GAoclSzal53M0B8TKCsuvGprkuW8/IIuR0D/MxjlUMDKwjbRW+Jqxmt
         pC9GHbTXV928Xd9e9LhMaHgD9uf9Tznl0eC7I+nXF/5CM7tUKdep1ixonCT+T4NsN27y
         UdyPpGWlY1EWz+Z/9lizAVvOI4ICWAf09jktecDjhE1fkdwtjrTHe0qu8wIEr4eRLOEp
         TYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3r46zgR0SxCiGzmzzXUPWfV053YkrnQyc0E900AmOtw=;
        b=Syga0/PIatmYIXH3a5qtjHcvJehcFI1VAe3L+4QVqXan4uDd7OO7Q7G5YFWLZaET7Y
         UJ1AdmUU3BYO9qSrNG59LOcJmW9wlON12fnVcUM2gxH3g9MsRGJ2WqnGL1djFN8rA9Ca
         EXhzdy7yzg0OsS1+Vu2BvqvhUUlBdpwCcBmv7YyZuSFWLWbG2JezSd2n3mCSNHEWWAVP
         UI328gDY1sw4aFG0jxNZKsS+rB3MVPA9tSKxHKDakkfNzyxc8ltSbwpBz11n1rcEQT+k
         3qNLxLSzboNWodtqjOvJzcNaDZ82oMgHOv0EgPhplvpXX8qHHxlKHm1lZVKhzp1iRNL2
         fNzQ==
X-Gm-Message-State: ACgBeo0WRa4goyLhYfkJPqQqMGCP/CAmUbgsldp1r6ORj4xbPE5ZaIKs
        nrL6NQYvbbjX1SFLVYORKkQ=
X-Google-Smtp-Source: AA6agR7Hlls1zlkfi2jVmFTTegZwymMMbi7VKkIE0fvTJB0pL4pfhuSV1eCQxr8jpMyTDH9FRjM5XA==
X-Received: by 2002:ac8:5ad2:0:b0:344:90e7:410f with SMTP id d18-20020ac85ad2000000b0034490e7410fmr3693684qtd.625.1662562947209;
        Wed, 07 Sep 2022 08:02:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::1244? ([2620:10d:c091:480::a525])
        by smtp.gmail.com with ESMTPSA id s2-20020ac87582000000b0034502695369sm12273356qtq.54.2022.09.07.08.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:02:26 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <acd30174-4541-7343-e49a-badd199f4151@gmail.com>
Date:   Wed, 7 Sep 2022 11:02:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
References: <7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com>
Content-Language: en-US
In-Reply-To: <7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/31/22 12:12, Bitterblue Smith wrote:
> rtl8xxxu_queue_select() selects the wrong TX queues because it's
> reading memory from the wrong address. It expects to find ieee80211_hdr
> at skb->data, but that's not the case after skb_push(). Move the call
> to rtl8xxxu_queue_select() before the call to skb_push().
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>   Add Fixes tag.
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Nice catch!

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 52240e945b58..8d6f693bf60b 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5177,6 +5177,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	if (control && control->sta)
>  		sta = control->sta;
>  
> +	queue = rtl8xxxu_queue_select(hw, skb);
> +
>  	tx_desc = skb_push(skb, tx_desc_size);
>  
>  	memset(tx_desc, 0, tx_desc_size);
> @@ -5189,7 +5191,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
>  		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
>  
> -	queue = rtl8xxxu_queue_select(hw, skb);
>  	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);

This could actually be made more resilient from someone moving the code
around by passing in 'hdr' instead of relying on using skb->data in
rtl8xxxu_queue_select(). We could also get rid of the hw argument to
that function since it isn't used.

Cheers,
Jes

