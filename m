Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF05E9480
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Sep 2022 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiIYQx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Sep 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiIYQxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Sep 2022 12:53:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941A2AC51
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:53:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ml1so3117288qvb.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=KH6jZ6LVgvFmFAU0WXE41MsbZbRc0yEyvSXXvAIrn2Q=;
        b=ZL8bCBiEPUHBLD/EvN5ru3EJxDYYnNqga7gFNfU3+KwTSrztpTGq8CZ2OgpLU8Ex1p
         pjSyb4ngGJakpzeWZHOBEGV7VCkKf7NH8bJsW4trZKmwW2V0nsTmq9umTe11Mp6bIany
         AC3I+fbH0tNg+It+uxHhD32ooZ1cMVlcBGGkcfdGyT+twetcSWTt17eVXqmhpM1ikQn/
         xwE1ATvB8u5dZm3xhMbW8AHtO88Ub5iRqumKtinlF5Fph+ZIZ11zUu09ho4eN8AhGMKM
         5wcn+5gDnUPpkjJRgpUKzxnECEXLZmGRNbkh+NCPolVgXvticQIPWaWizLwIqpxOEYVG
         YrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=KH6jZ6LVgvFmFAU0WXE41MsbZbRc0yEyvSXXvAIrn2Q=;
        b=Fm4jKAnn1+h3bhtrBcbav1QN2AEpOAWMTXg2FLkL+mznYkC0DYh02LcexQgIrUthPI
         P80G5/z98VvezdCNldJFfCJuWHXRnVEnRYQ39JnUXfF7lOuGWQqlaXKG/Z026SyPrtLH
         U26sH0yUz52/vhR7EAoOuhpaTf6NNQ386qtycnJ5OWXf+XhaRbzVKyQJY09UPSw2/5aH
         XXFYZMjUzLX4UirmZ1XIix8oESdRbaN817t8PoQLDcg8nTJV56nczlUSFmccyMx8+k7g
         bMWv6IIWu2/NrtaC9S9bmOCxqLVS51wf5A4fdhes7i4uumd2wb7a+sOe73gh3worOBZE
         puPw==
X-Gm-Message-State: ACrzQf08I65GBZep3VYW7mmdmbqHEEvsWcFD96O3bOOc2l4lB1LpVd0x
        clmxJO6ZvTQHbpxeRULNjB0=
X-Google-Smtp-Source: AMsMyM5jExAJ44z1oq9REC24jbiKVV5E86z2hV4yXer0R8gdM85nfiFESyMjvLJIBpYwMhrPjOUwkg==
X-Received: by 2002:a05:6214:2387:b0:496:c9db:82b0 with SMTP id fw7-20020a056214238700b00496c9db82b0mr14752946qvb.111.1664124827703;
        Sun, 25 Sep 2022 09:53:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::c4? ([2620:10d:c091:480::af4b])
        by smtp.gmail.com with ESMTPSA id i12-20020a05620a404c00b006b8d1914504sm11619891qko.22.2022.09.25.09.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 09:53:47 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <ac73924f-4c52-b8e6-1628-e34fc673a35d@gmail.com>
Date:   Sun, 25 Sep 2022 12:53:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: gen2: Turn on the rate control
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     chris.chiu@canonical.com
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
In-Reply-To: <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/22 08:35, Bitterblue Smith wrote:
> Inform the firmware when connecting to a network. This makes the
> firmware enable the rate control, which makes the upload faster.
> 
> Don't inform the firmware when disconnecting from a network, because
> that makes reconnecting impossible for some reason:

Have you dug through the vendor driver to see what it does here?

Thanks,
Jes


> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
> wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out
> 
> Not informing the firmware about disconnecting doesn't seem to have
> any downside.
> 
> Tested only with RTL8188FU. Someone should test the other gen2 chips:
> RTL8723BU and RTL8192EU.
> 
> Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu devices not reconn…")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 32ab6ed5b9b6..7978d5dcc826 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4471,25 +4471,34 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
>  void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
>  				  u8 macid, bool connect)
>  {
> -#ifdef RTL8XXXU_GEN2_REPORT_CONNECT
>  	/*
>  	 * Barry Day reports this causes issues with 8192eu and 8723bu
>  	 * devices reconnecting. The reason for this is unclear, but
>  	 * until it is better understood, leave the code in place but
>  	 * disabled, so it is not lost.
>  	 */
> +	/*
> +	 * It also affects 8188FU. However, without this the rate control
> +	 * is not on. Probably it only enables the rate control when it
> +	 * knows it's connected to a network.
> +	 *
> +	 * Hack: don't report the disconnect. This way the rate control
> +	 * is on and reconnecting also works. TODO Test 8192EU and 8723BU.
> +	 */
>  	struct h2c_cmd h2c;
>  
>  	memset(&h2c, 0, sizeof(struct h2c_cmd));
>  
>  	h2c.media_status_rpt.cmd = H2C_8723B_MEDIA_STATUS_RPT;
> -	if (connect)
> +	if (connect) {
>  		h2c.media_status_rpt.parm |= BIT(0);
> +	/*
>  	else
>  		h2c.media_status_rpt.parm &= ~BIT(0);
> +	*/
>  
> -	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
> -#endif
> +		rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
> +	}
>  }
>  
>  void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)

