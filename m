Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03C25FDC6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgIGP5P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgIGP5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 11:57:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB1C061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 08:57:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so18875454ejk.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=tN/xi/K33hSzLhlnHvwEfSPc0J4JC2agdpMi5R5ulms=;
        b=XXMr+0KVcfwLVtACV+5XhszZiAr/IlRFuPw0JES53pNrVeJKlDPYEvQRTLp4s6qqg6
         dlQWQJ1hRfdJG5CBwkJWtc/nPWJ05fA9045fIL9PJp3EC+6jDhVDzr/1idkILEJScMDH
         wrdw7edgJYvc5dgcmR7qjazoLuHUUZ9KGCldo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=tN/xi/K33hSzLhlnHvwEfSPc0J4JC2agdpMi5R5ulms=;
        b=uXL/dyhpgA0Rg2pZBzxnu7VAQbA/tTQV6rwkaYdUoCTFQthf0CrekprJZtqfUPQIK+
         IceBYvnAA+je6+7D2rehHGj1tjo9kTyECs0NzgWxqDCQ9l54kvQLi4eCSOjbdta0Vhz6
         TIMPUtic143fXJiEy43gT3ybFFn+LvDhyuDdVFutmInvP7tTYBcL+seZUoeM+kLPPzxJ
         3CF8s8DYeIb0BbEWvkwJLa+xzXVvhWDvdWKIYtPyxtgbmpz/Fcfa2w//XEVMIBRsvDyi
         pKucsZCtHkB/+E4cL6NGEkxtayjPCdmcQbBVFP2G00QiTpGqgvWoEv05ugCN9oIqP35U
         7BdA==
X-Gm-Message-State: AOAM5309snKtqrOkIpbq+9wMr0aEGvSGOmcIVNc456YzWYsuNl27ufdi
        8opY+4YybQDzdNtS1eZrO0PI0g==
X-Google-Smtp-Source: ABdhPJxDQ1FJa76uWlaeUs8jSBCU8MRqqE0xLRD4VJfSYDgF65ZfTQVrLYhGXVanfwX7uTp4eDZG6A==
X-Received: by 2002:a17:906:82d1:: with SMTP id a17mr21255056ejy.385.1599494223163;
        Mon, 07 Sep 2020 08:57:03 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id d8sm15539782ejm.56.2020.09.07.08.57.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 08:57:02 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wright Feng <Wright.Feng@cypress.com>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list" <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-Hsien Lin" <Chi-Hsien.Lin@cypress.com>
Date:   Mon, 07 Sep 2020 17:57:01 +0200
Message-ID: <1746948ecc8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <01010174692f7c3f-4b7369b2-0665-4324-b1c8-57bd22ac9ce7-000000@us-west-2.amazonses.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
 <20200901063237.15549-2-wright.feng@cypress.com>
 <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
 <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
 <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
 <9c5de429-ff6f-cad2-39a7-d5812fd3df09@cypress.com>
 <01010174692f7c3f-4b7369b2-0665-4324-b1c8-57bd22ac9ce7-000000@us-west-2.amazonses.com>
User-Agent: AquaMail/1.26.0-1689 (build: 102600004)
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On September 7, 2020 5:29:14 PM Kalle Valo <kvalo@codeaurora.org> wrote:

> Wright Feng <Wright.Feng@cypress.com> writes:
>
>>>>>> +brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
>>>>>> +  struct bss_parameters *params)
>>>>>> +{
>>>>>> + struct brcmf_if *ifp;
>>>>>> + int ret = 0;
>>>>>> + u32 ap_isolate;
>>>>>> +
>>>>>> + brcmf_dbg(TRACE, "Enter\n");
>>>>>> + ifp = netdev_priv(dev);
>>>>>> + if (params->ap_isolate >= 0) {
>>>>>> + ap_isolate = (u32)params->ap_isolate;
>>>>>> + ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
>>>>>
>>>>> Is the cast to u32 really necessary? Please avoid casts as much as
>>>>> possible.
>>>>
>>>> It seems to me. struct bss_parameters::ap_isolate is typed as int. It
>>>> is passed to brcmf_fil_iovar_int_set() which requires a u32 (maybe
>>>> function name is causing the confusion).
>>>
>>> What extra value does this explicit type casting bring here? I don't see
>>> it. Implicit type casting would work the same, no?
>>
>> The value will be -1, 0 or 1.
>> I will submit v2 patch that ignores doing iovar if getting
>> params->ap_isolate -1 and removes explicit type casting. Thanks for the
>> comment.
>
> Oh, I didn't realise ap_isolate can be -1 as struct bss_parameters
> didn't document that. Can someone submit a patch to fix that?
>
> * @ap_isolate: do not forward packets between connected stations

Me too. I assumed it was a boolean reading that description.

Regards,
Arend


