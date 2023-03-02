Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946BF6A87FA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCBRgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 12:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCBRge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 12:36:34 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3951F9E
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 09:36:32 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p6-20020a4ab386000000b005252182b0e0so34771ooo.6
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nz7UdN3UZifkbL4HP91WEy4zNrvAZ943EKLoXom4cLM=;
        b=A/01cjhY0rVTXEERJHOuoBMb3/nro64MmF+rnuISdJm3xaQPbSjM3oZYazuwHq0ND3
         nCpVlBLA63s7bTbfyoHE4FS6zMUdXbo+JN/MWOkgzHz7blNo7wlteETkKCSdPKUeevye
         bbWSEThkwY9Bpu26qmSl9ursud4zNxzuyHWEJX/uHDXqeO8SXy2Vy4vbZPNVaC3hmKow
         HCjAnSlmBjydvbHuOGdocxGG9u75DwjNBNSOdbY+KoYeUmUaL0iahMdtqhDL98qoxKpo
         dMtUwpXnHDCauZqvSSQZ4g5GWenvQpK7gGAAhIz03o4QdIzZdN/mY+CNMP8IiwvcUkHc
         U5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nz7UdN3UZifkbL4HP91WEy4zNrvAZ943EKLoXom4cLM=;
        b=hboL9jxwP1gVzKIP0BvtFBIXayiCXopt5T3tRlf+rGLy9oG2N3mkwsDAsdMKs3R6oG
         wU2by0vVcqJeQDRtuiYuSaIx/LQboZaUfR1Gi1Rk+QVN+LALopaePn3zVAOozT84R4Yg
         ysm1St9fdN8ONnwhHkpCXnf+j5K3vdxhoXifYUw+tvGudj4CYIK7M/GVksWKYhK3ob7I
         GsGcwqHkn89IotVX/qdt+GerHeTa1+MYuskRuoBkexSasY04qJLFvVRAiVZbM2kuBVxB
         x1oRS2XWKORfIo46zCF9P6aNgczplHLeUmfLKkVtaAm5FkWLl/L4g7rok+TVoFSY+03w
         4qqA==
X-Gm-Message-State: AO0yUKV1ZpwznoVJtV37LSYpnbBSCXb29JvdsXhr349X8BaRtDT+3Jjv
        uNPqrDQ6RclP0SJNvwLnn2YmmMfS7tk=
X-Google-Smtp-Source: AK7set+kfRkzty/GHiQ7TyteSwwcTefB4BUf1qi7yqwU7G5RUUyWb+9do6EDHyl6gJHfD5GgYaUr2w==
X-Received: by 2002:a4a:c716:0:b0:51a:aa79:bc09 with SMTP id n22-20020a4ac716000000b0051aaa79bc09mr4524081ooq.5.1677778591595;
        Thu, 02 Mar 2023 09:36:31 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w16-20020a056870431000b00172428894e0sm115198oah.28.2023.03.02.09.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:36:31 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bf10220f-de74-8ea2-dcd4-05c1a6ff9b79@lwfinger.net>
Date:   Thu, 2 Mar 2023 11:36:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
 <ad187d12189d45a68bc8bdc229ab5d4e@realtek.com>
 <c92df9a9-bff0-6dff-6416-5ee761334c2a@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c92df9a9-bff0-6dff-6416-5ee761334c2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/2/23 00:24, François Valenduc wrote:
> 
> Le 2/03/23 à 02:27, Ping-Ke Shih a écrit :
>>
>>> -----Original Message-----
>>> From: François Valenduc <francoisvalenduc@gmail.com>
>>> Sent: Wednesday, March 1, 2023 2:26 PM
>>> To: linux-wireless@vger.kernel.org
>>> Subject: Hangs with NetworkManager and rtw8723_de with kernel 6.1
>>>
>>> Good morning,
>>>
>>> systemrescue recently switched from kernel 5.15 to kernel 6.1 and
>>> NetworkManager started to hangs at startup. This seems to be linked to
>>> my wifi card (RTL8723DE). I am also able to reproduce the problem under
>>> gentoo with the same versions for NetworkManager and linux-firmware than
>>> those used in systemrescue (1.42.2 and 20230210). Under gentoo, the
>>> problem appears with kernel 6.1.14 and 6.2.1. I am able to use
>>> NetworkManager and systemrescue without problem on another computer
>>> which has another wifi card.
>>>
>>> Does anybody have a solution to this problem ?
>>>
>> I think this problem is the same as
>> https://bugzilla.kernel.org/show_bug.cgi?id=217016
>>
>> Ping-Ke
>>
>>
> This is indeed the same bug. I applied this patch on top of kernel 6.1.14 and 
> the hang doesn't occur anymore, neither in Gentoo or in SystemRescue. I see this 
> patch has been merged in mainline and marked for stable. However, it is not 
> included in the current review for 6.1.15. I hope it will make it to stable 
> kernels soon.

Thanks Ping-Ke for the help here. I am glad the problem is solved.

For your information, that patch is included in the rtw88 repo at GitHub.com.

Larry


