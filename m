Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93760ADEC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiJXOkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiJXOj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 10:39:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22FEC521
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 06:16:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r14so16715355lfm.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ReonXTU/oR54+QMi5uf85CVfAogVPV2vNFrZJcUe4I=;
        b=Fnt8eXGpFel5IGyypg0nhRZnalWrgjBwO7ZU0SgJyEaMCA+CHZp8Ag4CnqyFCVh94/
         d8OziUvqJNKwZ91AoxTC0POdB4qZ7k0lff4CAsLe1worabEi97YRh6CO2cXApfGEHyKx
         fLC4pdC5bHPRhLnDqr2FF8RkjMCCdd0XgLCoUDraZyjY5I6VN0+TCNbaAJmx0Plqj5j6
         nwX292lSLZeW/q3dh0MinwwKvGhLbW0d/u7j+sxUQc4QXAPI/ZGf3VI6KeK5zPquoPXO
         IvO58a+1QgnVKf1Fz3k/u1Fmv/OGoTy6YCSBGoqPA6ii7ZAGqjSVk3x6hk89lyoNkjwZ
         oZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ReonXTU/oR54+QMi5uf85CVfAogVPV2vNFrZJcUe4I=;
        b=amjC5pTDT/be1ta2151cWw+A5mqcGWnqNl+iCcVPAnsNerDvTWz8VCMAR5XYYboe3z
         jAcRfjtV7Re7ouXVC5UH6juZeahdvMwXenlvYY6H+hFduGZvA9PRN8wxqMuhajqQWfC6
         Ohlq0hhLRwefZX8L7eEVG1PTm/LHYZQzPLtjxZRJrtgoQDEg0Vugwp5SZbkqJoAr/QEP
         /SS5wazWLetbpRVAe8Q6HqOkwhhqyQ0KnJsroVQE9m78ZNnlKxfs/U7lH9jva788affF
         CwHb/ZN0Yqv35Bw78bUBJMuwzOk2Fc5QcPQpjxUBcGgoo11QIiQmFQFKYPgty1V2a0AQ
         rERw==
X-Gm-Message-State: ACrzQf1ryRCWppARAJ8+Y4esWb5ivdZwbNEYNOnxYiPMlXy7yo1VR26N
        3j5PYM2Jcd3AzqwXfso0AXMg4zhAftU=
X-Google-Smtp-Source: AMsMyM4tLgjryovUmNZ9+uVmjkdkNm2cnU3QlsR+roaH4XPvz4fbD5mZ2iPXMoDdf1m56kMY3EmNOQ==
X-Received: by 2002:aa7:d744:0:b0:45c:e353:e891 with SMTP id a4-20020aa7d744000000b0045ce353e891mr31223603eds.36.1666616770225;
        Mon, 24 Oct 2022 06:06:10 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906774700b0077086d2db8esm15799405ejn.140.2022.10.24.06.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:06:09 -0700 (PDT)
Message-ID: <1d9e13ce-98b6-45a2-1d31-d1ca4ea7968d@gmail.com>
Date:   Mon, 24 Oct 2022 16:06:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: How to use the rate control in mac80211?
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
 <472d5d4687ddbecfbf97419d223b4d1b472777e1.camel@sipsolutions.net>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <472d5d4687ddbecfbf97419d223b4d1b472777e1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/10/2022 18:53, Johannes Berg wrote:
> Hi,
> 
>> I thought it's like this:
>> 1) don't set HAS_RATE_CONTROL
> 
> yes
> 
>> 2) tell the chip to use the rate from tx_info->control.rates[0]
> 
> I'd prefer you didn't, that's also very limited :-)
> 
>> 3) report if the frame was acked or not
> 
> Kind of.
> 
> It'd be better if new drivers used sta_rate_tbl_update method, so it'd
> be something like
> 
>  1) don't set HAS_RATE_CONTROL
>  2) implement sta_rate_tbl_update(), using the table of rates given
>     there to instruct the device to transmit frames at those rates
>  3) on TX success/failure, fill in a struct ieee80211_rate_status array 
>     that indicates which rates were used and how many times until the
>     eventual success or failure; this is in struct ieee80211_tx_status
>  3) alternatively, fill in the tx_info rates array the same way and
>     report it that way, but that's less flexible
> 
> 
> johannes

I got it to work! But I had to use tx_info->control.rates[0] when 
IEEE80211_TX_CTL_RATE_CTRL_PROBE is set, otherwise the rate table only
contains MCS0.
