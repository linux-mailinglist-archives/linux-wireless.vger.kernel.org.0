Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7271F97B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFBE6g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBE6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 00:58:36 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF706107
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 21:58:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so2372653a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jun 2023 21:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685681913; x=1688273913;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w18eu18dBjDSmTiodJ3rwDJr8Lyri7V+bzUYm/qpYpE=;
        b=PpyNM8dYd+wj2kLJ8PPY1ttMXO+bGoJnFN2qzrfM2RVloMkw5UoeIrCeRg53LBFRmZ
         fIB/8zTWi4t0TbFFTFto3RplTE1Jvz4VQgECou9fqjVdNu6DN9jb4xrFOKQGys2+nSyN
         sLAjucYba46Ylsd2wptmh1qrNdB74jn5Ews11QpN1xqxWPoSj+8HZfv8MI+WHc19d5Q3
         /qKDyrQD6WGRZNLINCen14DnWUmMWJ6tkdG8yY8psv8WcnXiP+tjfOlKO2dkkPVaKYlU
         u8iQpzFVM6bJHSf5v5jpn14cJZTpI5HZjXh35lS2RyWp2cQV0cBHDQ3Ab6mb3szFGDFF
         XeBA==
X-Gm-Message-State: AC+VfDwUkqTZrtQF0K3A3jDFnmKI2Rj6GVSa7hWZ8t/gEJpnlkVFhST5
        t6GicbAI2mb7B0R4aBdxvmk=
X-Google-Smtp-Source: ACHHUZ6Gg/QaBlU7xL8rL+XKCzPh5kWJwgoT6uKTE9bY7JEoKIVlt4/C4Y6K+A7mxTJKxgV/aNllQQ==
X-Received: by 2002:a17:906:4fc7:b0:96f:c988:941 with SMTP id i7-20020a1709064fc700b0096fc9880941mr9601002ejw.15.1685681912903;
        Thu, 01 Jun 2023 21:58:32 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090668da00b00947ed087a2csm262345ejr.154.2023.06.01.21.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 21:58:32 -0700 (PDT)
Message-ID: <d68c4b38-88e1-02ef-5779-08b93fd0d47b@kernel.org>
Date:   Fri, 2 Jun 2023 06:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     Shiji Yang <yangshiji66@outlook.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rg?= =?UTF-8?Q?ensen?= 
        <toke@toke.dk>, Robert Marko <robimarko@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Shiji Yang <yangshiji66@qq.com>
References: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
In-Reply-To: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02. 06. 23, 6:36, Shiji Yang wrote:
> From: Shiji Yang <yangshiji66@qq.com>
> 
> Add a struct_group to around all members in struct ath_cycle_counters.
> It can help the compiler detect the intended bounds of the memcpy() and
> memset().
> 
> This patch fixes the following build warning:
> 
> In function 'fortify_memset_chk',
>      inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
> ./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    314 |                         __write_overflow_field(p_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Hi,

what compiler/version is this with?

> Signed-off-by: Shiji Yang <yangshiji66@qq.com>
> ---
> More discussion on: https://github.com/openwrt/openwrt/pull/12764

No "__write_overflow_field" there. Is this the right link?

> ---
>   drivers/net/wireless/ath/ath.h                | 10 ++++++----
>   drivers/net/wireless/ath/ath5k/ani.c          |  2 +-
>   drivers/net/wireless/ath/ath5k/base.c         |  4 ++--
>   drivers/net/wireless/ath/ath5k/mac80211-ops.c |  2 +-
>   drivers/net/wireless/ath/ath9k/link.c         |  2 +-
>   drivers/net/wireless/ath/ath9k/main.c         |  4 ++--
>   drivers/net/wireless/ath/hw.c                 |  2 +-
>   7 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> index f02a308a9..4b42e401a 100644
> --- a/drivers/net/wireless/ath/ath.h
> +++ b/drivers/net/wireless/ath/ath.h
> @@ -43,10 +43,12 @@ struct ath_ani {
>   };
>   
>   struct ath_cycle_counters {
> -	u32 cycles;
> -	u32 rx_busy;
> -	u32 rx_frame;
> -	u32 tx_frame;
> +	struct_group(cnts,
> +		u32 cycles;
> +		u32 rx_busy;
> +		u32 rx_frame;
> +		u32 tx_frame;
> +	);

This is horrid.

>   };
>   
>   enum ath_device_state {
> diff --git a/drivers/net/wireless/ath/ath5k/ani.c b/drivers/net/wireless/ath/ath5k/ani.c
> index 850c608b4..fa95f0f0f 100644
> --- a/drivers/net/wireless/ath/ath5k/ani.c
> +++ b/drivers/net/wireless/ath/ath5k/ani.c
> @@ -379,7 +379,7 @@ ath5k_hw_ani_get_listen_time(struct ath5k_hw *ah, struct ath5k_ani_state *as)
>   	spin_lock_bh(&common->cc_lock);
>   
>   	ath_hw_cycle_counters_update(common);
> -	memcpy(&as->last_cc, &common->cc_ani, sizeof(as->last_cc));
> +	memcpy(&as->last_cc.cnts, &common->cc_ani.cnts, sizeof(as->last_cc.cnts));

So is this.

Care to elaborate why this is needed at all, provided we copy/zero a 
whole structure? And describe it in the commit log, not in random 
external sources.

thanks,
-- 
js
suse labs

