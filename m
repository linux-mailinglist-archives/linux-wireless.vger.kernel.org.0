Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E523BD97
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHDPxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDPxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 11:53:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BEC06174A
        for <linux-wireless@vger.kernel.org>; Tue,  4 Aug 2020 08:53:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so33929831ljj.7
        for <linux-wireless@vger.kernel.org>; Tue, 04 Aug 2020 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sRCHmaRWrj71+p+/CjUrSN9Jr6wXyLPJ7hErKYgqGA4=;
        b=D1ATvsotv6H5IFowhT8XoO+WT+quO4nRfXwAp9F5eUg+fjoZKZBIFrJ1XZBsX2foTV
         oEAbgunCskKneycUlZmF4PXlVx/5AfiGbzjkxK5iWVC5kKIjrzdauos7gWmEMzjnENQH
         UlSOyOis97IFwU2tAMcDjmZzGqyrFyzjraaS0v7Pos7+6PdfLmKREd7pENZzbBncH7x3
         RHgR5a8DLpQbHExpgLZllr4eydaz2ncLY4PxaeCbq3n2brA0JffuUSsA5lqXRHb/+XWs
         JcBxrpzv4Uyz5aAR5UlivNUT8PTJDF76kMau7tPhkuV2v5mieZDH8SRNxTxIw85Jb3oi
         kU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sRCHmaRWrj71+p+/CjUrSN9Jr6wXyLPJ7hErKYgqGA4=;
        b=iD6vkcOQM/1kks4QxmJtsm/zUfIwZ1+qH8PQIG3BFzm1CiZXMCS0Zy5TKjWpyZkl4c
         Hhkdsi3FHzbn0HIHCMCHqnBBQTG4lBHWkjh5o1ZgyxDUdjUhr0do0SLY05z4ZgM9YYDQ
         /2PNOxzK9QaLwv2sEnqlv+Gl8aUr0njX9z0oYBbYLFQtWNpS+AF2Gq+Go5zuuXGzsOke
         Jba3csKBdZH71niK6jhgJvKwhKOTbv7HYXIYBErMQw55Qn3448T2Z3H5U+6n2IfHsdi5
         hnCS0/Ds4laKIlDDpfhQbSf4Z0wKYcBet8AwxrhvRWwmKpomstNGoj2ZZp2ye44xqJsI
         +jyg==
X-Gm-Message-State: AOAM533wKy5aq7/VtQDYd9IE+5tcska3empMaL2pEV8MH1USVHgYGSAm
        lSv0yEthW1RUpdxkKFfsMoY=
X-Google-Smtp-Source: ABdhPJyKUbPuAlHqyiBsqYSnkNd0jZU3n53Sfies6mqW6o6DKUaaz5+XHM6rhXiv4Qy5ZKk16FcnUw==
X-Received: by 2002:a2e:9acc:: with SMTP id p12mr11116397ljj.363.1596556402524;
        Tue, 04 Aug 2020 08:53:22 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id a7sm3381785ljk.2.2020.08.04.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:53:21 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
Date:   Tue, 4 Aug 2020 18:53:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z9yr7lg.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

04.08.2020 14:08, Kalle Valo пишет:
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> 10.06.2020 18:21, Chi-Hsien Lin пишет:
>>> From: Amar Shankar <amsr@cypress.com>
>>>
>>> It is observed that sometimes when sdiod is low in tx credits in low
>>> rssi scenarios, the data path consumes all sdiod rx all credits and
>>> there is no sdiod rx credit available for control path causing host
>>> and card to go out of sync resulting in link loss between host and
>>> card. So in order to prevent it some credits are reserved for control
>>> path.
>>>
>>> Note that TXCTL_CREDITS can't be larger than the firmware default
>>> credit update threshold 2; otherwise there will be a deadlock for both
>>> side waiting for each other.
>>>
>>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> 
> [...]
> 
>> This patch causes a severe WiFi performance regression on BCM4329.
>> Please fix or revert this patch, thanks in advance.
>>
>> Before this patch:
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec    0             sender
>> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
>> receiver
>>
>>
>> After this patch:
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec    3             sender
>> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
>> receiver
> 
> Can someone please send a revert patch (with the explanation above) if a
> fix is not quickly found? The commit id is:
> 
> commit b41c232d33666191a1db11befc0f040fcbe664e9
> Author:     Amar Shankar <amsr@cypress.com>
> AuthorDate: Wed Jun 10 10:21:03 2020 -0500
> Commit:     Kalle Valo <kvalo@codeaurora.org>
> CommitDate: Tue Jul 14 12:46:43 2020 +0300
> 
>     brcmfmac: reserve 2 credits for host tx control path
> 

Hello Kalle,

I'll send the revert if nobody will stand up to address the problem in a
two weeks, thanks.
