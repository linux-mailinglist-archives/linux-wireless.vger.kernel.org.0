Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82B3F503C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhHWSQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHWSQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:16:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E947C061575
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 11:16:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l24so14579586qtj.4
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dUaF/06OdVq28sYuAKcZ+UG02Qlt2ANrvGZ24fytqiA=;
        b=qk8a8qUjaSHG6VrN2+qP7Q6H8Y3xydSMaFluNjCL65k5iBIdsyxwrKN1X9t9EvozFc
         nBq9g2KQ8RPXltIoYbv+JIYR8xfB0uxObfvcqyaI5vW43OhqXWIwPOkW0BvX02+AZ1Eg
         7ro/hXdKP121dINH789NFUOr4/BEtwLDS7CBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dUaF/06OdVq28sYuAKcZ+UG02Qlt2ANrvGZ24fytqiA=;
        b=eli/apQIxv/be7H48KDhYbWu/EGwzzvUpiEWDkgbvr4zuc7UNINWQYXeF1r2LhcblV
         zXIT6MCJYZO+LYCPui7sNIEXlwNz7sbXtLxcaMvJn5miInLo/f1EiZ5NXQ5VwqlhT8L6
         N5bihvxDlAueng9AgYyJhVKKfRIiXf7mkEwa+jx3gm4kNvSISVZE27nhrjZtQwgK5f9p
         C7GkZlXHZJg7BCGATf2MvDodTjUyDXMruoIH3XU5IIpK5wKCUJ9krHGSQXD7w6tPLsPh
         G8cYhg+v5zqi1+Hov0XBoUv1yFdeTvBgFDAvMAIIdgdq8zgjp5nmFd5EbCBGy8BAwbw5
         AQOQ==
X-Gm-Message-State: AOAM531wPoMkmjs+UszZ93PjDOpBLqdbPEeLtatK5R//0N2lgVQibcOj
        NZAur+YjWKVQKpjxoaqsNoR6pQ==
X-Google-Smtp-Source: ABdhPJwwuakNawgGhvvrehReTxEtSonLBKWR/4Dia0llz5ad/xoiWeN+/AFmv+hxeISxDaAOAN9YSg==
X-Received: by 2002:a05:622a:118f:: with SMTP id m15mr30654958qtk.185.1629742560735;
        Mon, 23 Aug 2021 11:16:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:843c:2c3:2cb2:fa8? ([2600:1700:38c5:675f:843c:2c3:2cb2:fa8])
        by smtp.gmail.com with ESMTPSA id 12sm3054907qtt.16.2021.08.23.11.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:16:00 -0700 (PDT)
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Wen Gong <wgong@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Brian Norris <briannorris@chromium.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
References: <YSJ//ki/A1EgfLga@skv.local>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <15d3d071-61a2-0847-de13-634a0c2077d5@eero.com>
Date:   Mon, 23 Aug 2021 11:15:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSJ//ki/A1EgfLga@skv.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/22/21 9:49 AM, Andrey Skvortsov wrote:

> 1) Current behaviour maps 0x0 regulatory domain to the most restrictive
> world domain. According to the wiki (probably based on Atheros
> documentation) 0x0 means US. Does wiki contain wrong information?

0x0 means country section in OTP is not written yet and open to set to 
any country.

QCA sets to US in this case as a default value.

> 2) If I understand correctly, 0x0 is always replaced with 0x64 and that
> makes the following code useless, because it will never be executed. Is it
> ok?
>
> drivers/net/wireless/ath/regd.c:703:708
>
> if (reg->country_code == CTRY_DEFAULT &&
>          regdmn == CTRY_DEFAULT) {
>              printk(KERN_DEBUG "ath: EEPROM indicates default "
>                  "country code should be used\n");
>              reg->country_code = CTRY_UNITED_STATES;
> }
I don't think that's true. If you're seeing 0x0 is replaced with 0x64 
(CTRY_BULGARIA = 100), it could be because your device's manufacturer 
preconfigured country code with the value.
> 3) Previously it was possible to get regulatory information using 'iw reg
> get', but now it doesn't work anymore. Is it expected behavior?
>
> [--------------------4.19 ---------------------------------]
> # iw reg get
> global
> country 98: DFS-UNSET
> (2400 - 2483 @ 40), (N/A, 20), (N/A)
> (5150 - 5250 @ 100), (N/A, 20), (N/A), NO-OUTDOOR
> (5250 - 5350 @ 100), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
> (5650 - 5730 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
> (5730 - 5850 @ 80), (N/A, 20), (N/A), NO-OUTDOOR
> (57240 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR
>
>
> [--------------------- 5.10 --------------------------------]
> #iw reg get
> global
> country RU: DFS-UNSET
> (2400 - 2483 @ 40), (N/A, 20), (N/A)
> (5150 - 5350 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
> (5650 - 5850 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
> (57000 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR
>
> [-----------------------------------------------------------]

The 4.19 output tells you that country code is changed to different one 
from manufacturer is set(US).

The 5.10 output seems manufacture set country code to RU. If it's the 
case, No phy level country code looks wrong or a bug.


Thanks,

Peter

