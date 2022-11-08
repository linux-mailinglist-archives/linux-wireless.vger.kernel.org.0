Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CA6213F6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 14:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiKHNzv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 08:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiKHNzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 08:55:46 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B365E77
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 05:55:45 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id hh9so8624049qtb.13
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRgti1AWBjnTTJaZ0Fv30I87v7d0nKRmTUdLKIiQo7k=;
        b=F/Jt23xAbMWJU3rFUM+I5UIIoKJntT2n2ZM+V6EKr3TMF04i0DyRQ9f1zNDD7Su16/
         sdNPVSOiAqTtBnHljvr0i2DJX7LkA/vhhHhemCLGd12VFmvzWN1R/VLV9TJeGmpRAxgv
         KRe0hLrkBimvZTZmpI7BmwqtSWIuLtjrnNYrll1rjI4qVIZZhbLkBpyXTOlmGwkBMYhB
         20thLP8aW9J8B/Ykwy2/M7UbvGYVCH0Vf6aYByRAXq452MYZDo5id2+oTIXT7XtPDYqV
         TaSKpo9Nb47cyZwvDzezb6GsAPtEpI1whraPbHbBDBvje6EunGxP7iiMWpw7eUoGicdX
         23EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRgti1AWBjnTTJaZ0Fv30I87v7d0nKRmTUdLKIiQo7k=;
        b=wt+dCy5ncXL4fnk1izVXvNpXy2Wq3rDCv8p0SAc9f32kU2oBDpPcU8lxPQE9SiBNDC
         8dnZA7QFazWn5tFJywMyNC/EeLbzSMS6HCNfhsd2jvmg0kCjPzr+PtC4zV/F4nqMK8YF
         2FZN+rjN9ZQTu54rdkK/TuSqsXmo7MW4mgYSQeX6z8BWEsMsYV0FSaGn+X4gj/Ukqodf
         n/2556LDt4U3PoMSANGILx1+98Swafgn68Zy1HYFpZfc+j5Nygfo4wrLRwiBuAwj1Lyr
         BX98CY5i8EVwanlKMFZP4QTa7a6bC9O28TJCC9IJOAtVp0o4BIPIp6tczsH+ln0AB0zj
         xPVA==
X-Gm-Message-State: ANoB5plzuGFSYn6I4GsS8HZ+3fDlbaZs4TwTfr/3OpsON6C4NzRsBXCI
        pue70BwOsmAK2yrZ1Oj8sR8=
X-Google-Smtp-Source: AA0mqf45gffI8cdPeyuXM8PlcGZTvxf9fIOsXrFMic45OkVwWhk3TWViV6/7e/6FhKpqabn9sDuHcw==
X-Received: by 2002:a05:622a:1ba7:b0:3a5:925c:dcdf with SMTP id bp39-20020a05622a1ba700b003a5925cdcdfmr6694942qtb.87.1667915744341;
        Tue, 08 Nov 2022 05:55:44 -0800 (PST)
Received: from ?IPV6:2620:10d:c0a8:1102::1024? ([2620:10d:c091:480::88bd])
        by smtp.gmail.com with ESMTPSA id cd7-20020a05622a418700b00359961365f1sm8072790qtb.68.2022.11.08.05.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:55:43 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <61438e78-7e84-e8e2-e822-8f477a206aeb@gmail.com>
Date:   Tue, 8 Nov 2022 08:55:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/3] wifi: rtl8xxxu: Rename
 rtl8xxxu_8188f_channel_to_group
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
 <ba8e3ea2-74f5-e1db-296e-4ae5f03084dc@gmail.com>
In-Reply-To: <ba8e3ea2-74f5-e1db-296e-4ae5f03084dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/5/22 18:54, Bitterblue Smith wrote:
> This name is an anomaly. Change it to rtl8188f_channel_to_group to
> follow the same pattern as the other functions.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - No change.
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Jes Sorensen <jes@trained-monkey.org>

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> index 4d044a8baa30..0f77312dd0ca 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -352,7 +352,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
>  	return ret;
>  }
>  
> -static void rtl8xxxu_8188f_channel_to_group(int channel, int *group, int *cck_group)
> +static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
>  {
>  	if (channel < 3)
>  		*group = 0;
> @@ -378,7 +378,7 @@ rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>  	u8 cck, ofdmbase, mcsbase;
>  	int group, cck_group;
>  
> -	rtl8xxxu_8188f_channel_to_group(channel, &group, &cck_group);
> +	rtl8188f_channel_to_group(channel, &group, &cck_group);
>  
>  	cck = priv->cck_tx_power_index_A[cck_group];
>  

