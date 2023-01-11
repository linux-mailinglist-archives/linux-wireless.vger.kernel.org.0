Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD1665580
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 08:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAKHyw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 02:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjAKHym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 02:54:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F76272
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 23:54:16 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFVw5-00048B-Ez; Wed, 11 Jan 2023 08:54:13 +0100
Message-ID: <b8a3fa69-a4c2-51b5-d193-d4d933cf6627@leemhuis.info>
Date:   Wed, 11 Jan 2023 08:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6.2-rc3] wifi: mt76: fix dma error
Content-Language: en-US, de-DE
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <45e57883822389266ab67f7e0b6aa737db047cdd.camel@web.de>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <45e57883822389266ab67f7e0b6aa737db047cdd.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673423657;34bad227;
X-HE-SMSGID: 1pFVw5-00048B-Ez
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing Felix]

On 10.01.23 23:39, Bert Karwatzki wrote:
> Since linux-6.2-rc1 the mediatek mt76 wlan driver suffers from problems
> https://bugzilla.kernel.org/show_bug.cgi?id=216901. I bisected this to
> commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae and noticed that the
> 
> 	if (txwi) {
> 		q->entry[q->head].txwi = DMA_DUMMY_DATA;
> 		q->entry[q->head].skip_buf0 = true;
> 	}
> 
> part is moved from the beginning of mt76_dma_add_buf to the
> inside of the for loop. But q->head is modified at the beginning of
> this loop.

Thx for your patch. TWIMC, a earlier (and tested) patch to address that
regression can afaics be found here:

https://lore.kernel.org/lkml/3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name/

Makes me wonder: Felix, btw, did you ever properly submit that patch for
inclusion? Where? I can't find it with lore. :-/ Or will it be addressed
by a different patch?

/me really hopes we can get this resolved this week before rc4 ships, as
it seems this regressions bothers quite a few people

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

P.S.:

#regzbot ^backmonitor: https://bugzilla.kernel.org/show_bug.cgi?id=216901

>  This patch puts at the beginning of mt76_dma_add_buf
> diff -aur linux-6.2-rc3.old/drivers/net/wireless/mediatek/mt76/dma.c
> linux-6.2-rc3/drivers/net/wireless/mediatek/mt76/dma.c
> --- linux-6.2-rc3.old/drivers/net/wireless/mediatek/mt76/dma.c	2023-
> 01-08 18:49:43.000000000 +0100
> +++ linux-6.2-rc3/drivers/net/wireless/mediatek/mt76/dma.c	2023-
> 01-09 22:07:29.533248047 +0100
> @@ -215,6 +215,11 @@
>  	u32 ctrl;
>  	int i, idx = -1;
>  
> +	if (txwi) {
> +		q->entry[q->head].txwi = DMA_DUMMY_DATA;
> +		q->entry[q->head].skip_buf0 = true;
> +	}
> +
>  	for (i = 0; i < nbufs; i += 2, buf += 2) {
>  		u32 buf0 = buf[0].addr, buf1 = 0;
>  
> @@ -238,11 +243,6 @@
>  			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0,
> buf[0].len) |
>  			       MT_DMA_CTL_TO_HOST;
>  		} else {
> -			if (txwi) {
> -				q->entry[q->head].txwi =
> DMA_DUMMY_DATA;
> -				q->entry[q->head].skip_buf0 = true;
> -			}
> -
>  			if (buf[0].skip_unmap)
>  				entry->skip_buf0 = true;
>  			entry->skip_buf1 = i == nbufs - 1; 
> 
> Bert Karwatzki
