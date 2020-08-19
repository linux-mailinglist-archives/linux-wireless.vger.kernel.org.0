Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72E24AA07
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHSXyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 19:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHSXyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 19:54:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E7C061757
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 16:54:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so78089wma.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqaX86dC5VA+boOd8RnsKfnJi2rMsA9QEZNdQkHVhEw=;
        b=c5UTJzQv6QwaGL92SXgDw5PvuYHgmbuiLpIxaWxVQCgme2V/2KEH25lWe5Ta9vw2mM
         nId9fLRiIBltNAjHfA6tnGMKUKd7KGnKbKVfv2AXXnPd2F4+C78v7SOvuDz4N8XvPQsv
         hVvXWWAeA5i4a7cSRedwFNYkyTNEBZcb0KYP21Wmo261SC7k9NYjG1MEM9peHAbh2jnQ
         Dmx14MYwgkH/BxhwhI03gEYYFQBZZPkHzurFohb39uWoLsXXNIYmJwxjc+mquypMUCLd
         GgFPrbInpxHpAPy5FjyGo4Hb7VOa5YaH+PhMCq7BAkgwocB7ZgXelOuXLNMQm8DsFZ77
         wtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqaX86dC5VA+boOd8RnsKfnJi2rMsA9QEZNdQkHVhEw=;
        b=jjd60QBws9zfo1B6d7bf9sw2kkVAaPRVoyNeCT8LEvMwQDxvAVL9NJeX7LlXqvw4SR
         jJcIqeRzg3W+2iQAUr/PZhdc2JZOEQ1Y5zmMQpHmfUBiLkUpA+RGrCeUAk10zvZjrKg3
         PXheLJRhff5wxLq/HADLR5PRgi2KMCkRzEfFNIoP8kerwMZwpRc5ba2nHNv3pxNct4EP
         EmczhDoEjghrv8fHGHrPh8AkSqn1Lkh/f3uOeZXv3lCDCvpaLXk9FIOfsEifbihwYq0W
         Jws97ccaIi7lCjc+dbnhnVxXqrabyj/6kH92nRmFFUC8S8pQA+o9BNUu6+X8TcpXchka
         12TA==
X-Gm-Message-State: AOAM531vjRToB2y1jGwWPciQ0eTaX5NWN/v8D8QX/IB2tLMU2lsHnidh
        I33SBs2vw8IzvU/IdD0YjBEOFzVg0tnVh/D3
X-Google-Smtp-Source: ABdhPJwFlJsOvghS2DJWektF8L4zd2EahtOuMm6npoPE/3FzX8NtJ1TL88mgUwdLgYsE9E2CyAtN+A==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr631378wmb.93.1597881279818;
        Wed, 19 Aug 2020 16:54:39 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i7sm781378wrs.25.2020.08.19.16.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 16:54:39 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
 <87pn7ojx8g.fsf@codeaurora.org>
 <CAMZdPi9sQ2BM4G2cSKNfE06fOtvOtgb+ELqAkxUJdtLbuoeYzQ@mail.gmail.com>
 <9ff7836b-2d84-91bc-0691-f8696541ffc2@nexus-software.ie>
 <CAMZdPi9MN=pJ_j0py4egeR=HM2d=T+h8JXgH=WiN1PpnbTX3qg@mail.gmail.com>
 <bec1a210-1bfc-8d80-d2a0-41b6be7f807a@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <494f0978-7380-e2f5-3224-0131d9bd0935@linaro.org>
Date:   Thu, 20 Aug 2020 00:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bec1a210-1bfc-8d80-d2a0-41b6be7f807a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/08/2020 11:52, Bryan O'Donoghue wrote:
> On 19/08/2020 09:15, Loic Poulain wrote:
>> Hi Bryan,
>>
>> On Tue, 18 Aug 2020 at 20:00, Bryan O'Donoghue
>> <pure.logic@nexus-software.ie> wrote:
>>>
>>> On 18/08/2020 14:34, Loic Poulain wrote:
>>>> On Tue, 18 Aug 2020 at 08:15, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>>
>>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>>
>>>>>> For software-driven scan, rely on mac80211 software scan instead
>>>>>> of internal driver implementation. The internal implementation
>>>>>> cause connection trouble since it keep the antenna busy during
>>>>>> the entire scan duration, moreover it's only a passive scanning
>>>>>> (no probe request). Therefore, let mac80211 manages sw scan.
>>>>>>
>>>>>> Note: we fallback to software scan if firmware does not report
>>>>>> scan offload support or if we need to scan the 5Ghz band (currently
>>>>>> not supported by the offload scan...).
>>>>>>
>>>>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>>
>>>>> What changed since v2? Please always include a changelog so that I 
>>>>> don't
>>>>> need to guess what you have changed in the patch. No need to resend, a
>>>>> reply is enough.
>>>>
>>>> Yes sorry, this patch has been rebased on ath master and squashed with
>>>> Bryan's fix:
>>>>        wcn36xx: Set sw-scan chan to 0 when not associated
>>>> No additional changes have been made on top of the initial patches.
>>>>
>>>> Regards,
>>>> Loic
>>>>
>>>
>>> This is excruciatingly slow on Android.
>>>
>>> Android I'm finding unlike Debian where this stuff was tested, merrily
>>> issues scan requests every 30 seconds.
>>>
>>> For me this ends up looking like this
>>>
>>> [  162.296995] wcn36xx: mac config changed 0x00000040
>>> [  162.297001] wcn36xx: wcn36xx_config channel switch=1
>>> [  162.297005] wcn36xx: hal init scan mode 2
>>> [  162.300011] wcn36xx: indication arrived
>>> [  162.300525] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
>>> [  162.300529] wcn36xx: hal start scan channel 1
>>> [  162.306930] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
>>>
>>> Big gap here
>>>
>>> [  162.368198] wcn36xx: mac config changed 0x00000040
>>> [  162.368205] wcn36xx: wcn36xx_config channel switch=40
>>> [  162.368209] wcn36xx: hal finish scan mode 2
>>> [  162.379085] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  162.382218] wcn36xx: indication arrived
>>> [  162.583396] wcn36xx: indication arrived
>>> [  162.684336] wcn36xx: mac config changed 0x00000040
>>> [  162.684344] wcn36xx: wcn36xx_config channel switch=2
>>> [  162.684348] wcn36xx: hal init scan mode 2
>>> [  162.687547] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  162.687552] wcn36xx: hal start scan channel 2
>>> [  162.693935] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  162.756359] wcn36xx: mac config changed 0x00000040
>>> [  162.756367] wcn36xx: wcn36xx_config channel switch=40
>>> [  162.756371] wcn36xx: hal finish scan mode 2
>>> [  162.767361] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  162.770445] wcn36xx: indication arrived
>>> [  162.971533] wcn36xx: indication arrived
>>> [  163.072318] wcn36xx: mac config changed 0x00000040
>>> [  163.072325] wcn36xx: wcn36xx_config channel switch=3
>>> [  163.072329] wcn36xx: hal init scan mode 2
>>> [  163.075449] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  163.075453] wcn36xx: hal start scan channel 3
>>> [  163.081648] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  163.144202] wcn36xx: mac config changed 0x00000040
>>> [  163.144210] wcn36xx: wcn36xx_config channel switch=40
>>> [  163.144214] wcn36xx: hal finish scan mode 2
>>> [  163.155103] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  163.158219] wcn36xx: indication arrived
>>> [  163.359477] wcn36xx: indication arrived
>>> [  163.460428] wcn36xx: mac config changed 0x00000040
>>> [  163.460435] wcn36xx: wcn36xx_config channel switch=4
>>> [  163.460439] wcn36xx: hal init scan mode 2
>>> [  163.463572] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  163.463576] wcn36xx: hal start scan channel 4
>>> [  163.469851] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  163.532373] wcn36xx: mac config changed 0x00000040
>>> [  163.532381] wcn36xx: wcn36xx_config channel switch=40
>>> [  163.532384] wcn36xx: hal finish scan mode 2
>>> [  163.543736] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  163.546987] wcn36xx: indication arrived
>>> [  163.747577] wcn36xx: indication arrived
>>> [  163.848431] wcn36xx: mac config changed 0x00000040
>>> [  163.848439] wcn36xx: wcn36xx_config channel switch=5
>>> [  163.848442] wcn36xx: hal init scan mode 2
>>> [  163.851668] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  163.851672] wcn36xx: hal start scan channel 5
>>> [  163.857929] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  163.920386] wcn36xx: mac config changed 0x00000040
>>> [  163.920394] wcn36xx: wcn36xx_config channel switch=40
>>> [  163.920398] wcn36xx: hal finish scan mode 2
>>> [  163.931279] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  163.934460] wcn36xx: indication arrived
>>> [  164.135411] wcn36xx: indication arrived
>>> [  164.236376] wcn36xx: mac config changed 0x00000040
>>> [  164.236383] wcn36xx: wcn36xx_config channel switch=6
>>> [  164.236387] wcn36xx: hal init scan mode 2
>>> [  164.239669] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  164.239673] wcn36xx: hal start scan channel 6
>>> [  164.245868] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  164.308339] wcn36xx: mac config changed 0x00000040
>>> [  164.308347] wcn36xx: wcn36xx_config channel switch=40
>>> [  164.308351] wcn36xx: hal finish scan mode 2
>>> [  164.319240] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  164.322405] wcn36xx: indication arrived
>>> [  164.523510] wcn36xx: indication arrived
>>> [  164.624238] wcn36xx: mac config changed 0x00000040
>>> [  164.624245] wcn36xx: wcn36xx_config channel switch=7
>>> [  164.624249] wcn36xx: hal init scan mode 2
>>> [  164.627352] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  164.627356] wcn36xx: hal start scan channel 7
>>> [  164.633425] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  164.696365] wcn36xx: mac config changed 0x00000040
>>> [  164.696374] wcn36xx: wcn36xx_config channel switch=40
>>> [  164.696378] wcn36xx: hal finish scan mode 2
>>> [  164.707355] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  164.710683] wcn36xx: indication arrived
>>> [  164.911285] wcn36xx: indication arrived
>>> [  165.012228] wcn36xx: mac config changed 0x00000040
>>> [  165.012236] wcn36xx: wcn36xx_config channel switch=8
>>> [  165.012240] wcn36xx: hal init scan mode 2
>>> [  165.015434] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  165.015439] wcn36xx: hal start scan channel 8
>>> [  165.021509] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  165.084204] wcn36xx: mac config changed 0x00000040
>>> [  165.084212] wcn36xx: wcn36xx_config channel switch=40
>>> [  165.084217] wcn36xx: hal finish scan mode 2
>>> [  165.095164] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  165.098269] wcn36xx: indication arrived
>>> [  165.299691] wcn36xx: indication arrived
>>> [  165.400304] wcn36xx: mac config changed 0x00000040
>>> [  165.400309] wcn36xx: wcn36xx_config channel switch=9
>>> [  165.400313] wcn36xx: hal init scan mode 2
>>> [  165.403424] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  165.403428] wcn36xx: hal start scan channel 9
>>> [  165.409695] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  165.472378] wcn36xx: mac config changed 0x00000040
>>> [  165.472386] wcn36xx: wcn36xx_config channel switch=40
>>> [  165.472390] wcn36xx: hal finish scan mode 2
>>> [  165.483390] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  165.486478] wcn36xx: indication arrived
>>> [  165.687641] wcn36xx: indication arrived
>>> [  165.788548] wcn36xx: mac config changed 0x00000040
>>> [  165.788556] wcn36xx: wcn36xx_config channel switch=10
>>> [  165.788561] wcn36xx: hal init scan mode 2
>>> [  165.791729] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  165.791734] wcn36xx: hal start scan channel 10
>>> [  165.797986] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  165.860337] wcn36xx: mac config changed 0x00000040
>>> [  165.860346] wcn36xx: wcn36xx_config channel switch=40
>>> [  165.860349] wcn36xx: hal finish scan mode 2
>>> [  165.871185] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  165.874560] wcn36xx: indication arrived
>>> [  166.075631] wcn36xx: indication arrived
>>> [  166.176336] wcn36xx: mac config changed 0x00000040
>>> [  166.176344] wcn36xx: wcn36xx_config channel switch=11
>>> [  166.176348] wcn36xx: hal init scan mode 2
>>> [  166.179753] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  166.179758] wcn36xx: hal start scan channel 11
>>> [  166.186033] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  166.248204] wcn36xx: mac config changed 0x00000040
>>> [  166.248211] wcn36xx: wcn36xx_config channel switch=40
>>> [  166.248216] wcn36xx: hal finish scan mode 2
>>> [  166.259127] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  166.262339] wcn36xx: indication arrived
>>> [  166.463387] wcn36xx: indication arrived
>>> [  166.564353] wcn36xx: mac config changed 0x00000040
>>> [  166.564362] wcn36xx: wcn36xx_config channel switch=12
>>> [  166.564366] wcn36xx: hal init scan mode 2
>>> [  166.567517] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  166.567522] wcn36xx: hal start scan channel 12
>>> [  166.573823] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  166.684383] wcn36xx: mac config changed 0x00000040
>>> [  166.684390] wcn36xx: wcn36xx_config channel switch=40
>>> [  166.684394] wcn36xx: hal finish scan mode 2
>>> [  166.695665] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  166.698857] wcn36xx: indication arrived
>>> [  166.899623] wcn36xx: indication arrived
>>> [  167.000265] wcn36xx: mac config changed 0x00000040
>>> [  167.000273] wcn36xx: wcn36xx_config channel switch=13
>>> [  167.000277] wcn36xx: hal init scan mode 2
>>> [  167.003459] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  167.003463] wcn36xx: hal start scan channel 13
>>> [  167.009787] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  167.120339] wcn36xx: mac config changed 0x00000040
>>> [  167.120348] wcn36xx: wcn36xx_config channel switch=40
>>> [  167.120351] wcn36xx: hal finish scan mode 2
>>> [  167.131208] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  167.134376] wcn36xx: indication arrived
>>> [  167.335469] wcn36xx: indication arrived
>>> [  167.436335] wcn36xx: mac config changed 0x00000040
>>> [  167.436343] wcn36xx: wcn36xx_config channel switch=14
>>> [  167.436347] wcn36xx: hal init scan mode 2
>>> [  167.439492] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  167.439497] wcn36xx: hal start scan channel 14
>>> [  167.446075] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  167.556358] wcn36xx: mac config changed 0x00000040
>>> [  167.556367] wcn36xx: wcn36xx_config channel switch=40
>>> [  167.556372] wcn36xx: hal finish scan mode 2
>>> [  167.567787] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  167.570712] wcn36xx: indication arrived
>>> [  167.771184] wcn36xx: indication arrived
>>> [  167.872093] wcn36xx: mac config changed 0x00000040
>>> [  167.872104] wcn36xx: wcn36xx_config channel switch=36
>>> [  167.872110] wcn36xx: hal init scan mode 2
>>> [  167.875463] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  167.875469] wcn36xx: hal start scan channel 36
>>> [  167.880887] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  167.944229] wcn36xx: mac config changed 0x00000040
>>> [  167.944238] wcn36xx: wcn36xx_config channel switch=40
>>> [  167.944243] wcn36xx: hal finish scan mode 2
>>> [  167.953262] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  167.956751] wcn36xx: indication arrived
>>> [  168.159485] wcn36xx: indication arrived
>>> [  168.260233] wcn36xx: mac config changed 0x00000040
>>> [  168.260243] wcn36xx: wcn36xx_config channel switch=40
>>> [  168.260248] wcn36xx: hal finish scan mode 2
>>> [  168.268055] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  168.332250] wcn36xx: mac config changed 0x00000040
>>> [  168.332259] wcn36xx: wcn36xx_config channel switch=40
>>> [  168.332264] wcn36xx: hal finish scan mode 2
>>> [  168.340018] wcn36xx: SMD command (req 10, rsp 11) completed in 4ms
>>> [  168.343231] wcn36xx: indication arrived
>>> [  168.547404] wcn36xx: indication arrived
>>> [  168.652662] wcn36xx: mac config changed 0x00000040
>>> [  168.652666] wcn36xx: wcn36xx_config channel switch=44
>>> [  168.652670] wcn36xx: hal init scan mode 2
>>> [  168.655732] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  168.655736] wcn36xx: hal start scan channel 44
>>> [  168.660968] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  168.772327] wcn36xx: mac config changed 0x00000040
>>> [  168.772334] wcn36xx: wcn36xx_config channel switch=40
>>> [  168.772338] wcn36xx: hal finish scan mode 2
>>> [  168.781369] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  168.784371] wcn36xx: indication arrived
>>> [  168.987575] wcn36xx: indication arrived
>>> [  169.088390] wcn36xx: mac config changed 0x00000040
>>> [  169.088398] wcn36xx: wcn36xx_config channel switch=48
>>> [  169.088402] wcn36xx: hal init scan mode 2
>>> [  169.091527] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  169.091532] wcn36xx: hal start scan channel 48
>>> [  169.097022] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  169.208455] wcn36xx: mac config changed 0x00000040
>>> [  169.208463] wcn36xx: wcn36xx_config channel switch=40
>>> [  169.208467] wcn36xx: hal finish scan mode 2
>>> [  169.218407] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  169.221568] wcn36xx: indication arrived
>>> [  169.423420] wcn36xx: indication arrived
>>> [  169.524402] wcn36xx: mac config changed 0x00000040
>>> [  169.524409] wcn36xx: wcn36xx_config channel switch=52
>>> [  169.524413] wcn36xx: hal init scan mode 2
>>> [  169.527559] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  169.527563] wcn36xx: hal start scan channel 52
>>> [  169.532973] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  169.644216] wcn36xx: mac config changed 0x00000040
>>> [  169.644223] wcn36xx: wcn36xx_config channel switch=40
>>> [  169.644227] wcn36xx: hal finish scan mode 2
>>> [  169.653367] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  169.656579] wcn36xx: indication arrived
>>> [  169.859998] wcn36xx: indication arrived
>>> [  169.960478] wcn36xx: mac config changed 0x00000040
>>> [  169.960489] wcn36xx: wcn36xx_config channel switch=56
>>> [  169.960494] wcn36xx: hal init scan mode 2
>>> [  169.963757] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  169.963762] wcn36xx: hal start scan channel 56
>>> [  169.969107] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  170.080126] wcn36xx: mac config changed 0x00000040
>>> [  170.080136] wcn36xx: wcn36xx_config channel switch=40
>>> [  170.080141] wcn36xx: hal finish scan mode 2
>>> [  170.089183] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  170.092346] wcn36xx: indication arrived
>>> [  170.295765] wcn36xx: indication arrived
>>> [  170.396072] wcn36xx: mac config changed 0x00000040
>>> [  170.396079] wcn36xx: wcn36xx_config channel switch=60
>>> [  170.396083] wcn36xx: hal init scan mode 2
>>> [  170.399139] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  170.399144] wcn36xx: hal start scan channel 60
>>> [  170.404547] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  170.516260] wcn36xx: mac config changed 0x00000040
>>> [  170.516268] wcn36xx: wcn36xx_config channel switch=40
>>> [  170.516272] wcn36xx: hal finish scan mode 2
>>> [  170.525323] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  170.528989] wcn36xx: indication arrived
>>> [  170.731306] wcn36xx: indication arrived
>>> [  170.832258] wcn36xx: mac config changed 0x00000040
>>> [  170.832266] wcn36xx: wcn36xx_config channel switch=64
>>> [  170.832270] wcn36xx: hal init scan mode 2
>>> [  170.835453] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  170.835457] wcn36xx: hal start scan channel 64
>>> [  170.840746] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  170.952490] wcn36xx: mac config changed 0x00000040
>>> [  170.952497] wcn36xx: wcn36xx_config channel switch=40
>>> [  170.952501] wcn36xx: hal finish scan mode 2
>>> [  170.961563] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  170.964663] wcn36xx: indication arrived
>>> [  171.167256] wcn36xx: indication arrived
>>> [  171.268465] wcn36xx: mac config changed 0x00000040
>>> [  171.268474] wcn36xx: wcn36xx_config channel switch=100
>>> [  171.268478] wcn36xx: hal init scan mode 2
>>> [  171.271622] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  171.271626] wcn36xx: hal start scan channel 100
>>> [  171.277068] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  171.388309] wcn36xx: mac config changed 0x00000040
>>> [  171.388316] wcn36xx: wcn36xx_config channel switch=40
>>> [  171.388320] wcn36xx: hal finish scan mode 2
>>> [  171.397462] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  171.400449] wcn36xx: indication arrived
>>> [  171.603380] wcn36xx: indication arrived
>>> [  171.704307] wcn36xx: mac config changed 0x00000040
>>> [  171.704315] wcn36xx: wcn36xx_config channel switch=104
>>> [  171.704318] wcn36xx: hal init scan mode 2
>>> [  171.707472] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  171.707476] wcn36xx: hal start scan channel 104
>>> [  171.712907] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  171.824322] wcn36xx: mac config changed 0x00000040
>>> [  171.824330] wcn36xx: wcn36xx_config channel switch=40
>>> [  171.824334] wcn36xx: hal finish scan mode 2
>>> [  171.833404] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  171.836577] wcn36xx: indication arrived
>>> [  172.039628] wcn36xx: indication arrived
>>> [  172.140321] wcn36xx: mac config changed 0x00000040
>>> [  172.140329] wcn36xx: wcn36xx_config channel switch=108
>>> [  172.140333] wcn36xx: hal init scan mode 2
>>> [  172.143442] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  172.143447] wcn36xx: hal start scan channel 108
>>> [  172.149071] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  172.260211] wcn36xx: mac config changed 0x00000040
>>> [  172.260219] wcn36xx: wcn36xx_config channel switch=40
>>> [  172.260222] wcn36xx: hal finish scan mode 2
>>> [  172.269482] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  172.272333] wcn36xx: indication arrived
>>> [  172.475588] wcn36xx: indication arrived
>>> [  172.576210] wcn36xx: mac config changed 0x00000040
>>> [  172.576217] wcn36xx: wcn36xx_config channel switch=112
>>> [  172.576221] wcn36xx: hal init scan mode 2
>>> [  172.579357] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  172.579362] wcn36xx: hal start scan channel 112
>>> [  172.584763] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  172.696318] wcn36xx: mac config changed 0x00000040
>>> [  172.696325] wcn36xx: wcn36xx_config channel switch=40
>>> [  172.696329] wcn36xx: hal finish scan mode 2
>>> [  172.705421] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  172.708542] wcn36xx: indication arrived
>>> [  172.911501] wcn36xx: indication arrived
>>> [  173.012248] wcn36xx: mac config changed 0x00000040
>>> [  173.012255] wcn36xx: wcn36xx_config channel switch=116
>>> [  173.012259] wcn36xx: hal init scan mode 2
>>> [  173.015521] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  173.015532] wcn36xx: hal start scan channel 116
>>> [  173.020870] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  173.132338] wcn36xx: mac config changed 0x00000040
>>> [  173.132346] wcn36xx: wcn36xx_config channel switch=40
>>> [  173.132350] wcn36xx: hal finish scan mode 2
>>> [  173.141388] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  173.144426] wcn36xx: indication arrived
>>> [  173.347588] wcn36xx: indication arrived
>>> [  173.448338] wcn36xx: mac config changed 0x00000040
>>> [  173.448347] wcn36xx: wcn36xx_config channel switch=120
>>> [  173.448350] wcn36xx: hal init scan mode 2
>>> [  173.451499] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  173.451503] wcn36xx: hal start scan channel 120
>>> [  173.456889] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  173.568336] wcn36xx: mac config changed 0x00000040
>>> [  173.568344] wcn36xx: wcn36xx_config channel switch=40
>>> [  173.568348] wcn36xx: hal finish scan mode 2
>>> [  173.577465] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  173.580602] wcn36xx: indication arrived
>>> [  173.783414] wcn36xx: indication arrived
>>> [  173.884494] wcn36xx: mac config changed 0x00000040
>>> [  173.884504] wcn36xx: wcn36xx_config channel switch=124
>>> [  173.884508] wcn36xx: hal init scan mode 2
>>> [  173.887627] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  173.887633] wcn36xx: hal start scan channel 124
>>> [  173.892978] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  174.004293] wcn36xx: mac config changed 0x00000040
>>> [  174.004303] wcn36xx: wcn36xx_config channel switch=40
>>> [  174.004308] wcn36xx: hal finish scan mode 2
>>> [  174.013188] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  174.017060] wcn36xx: indication arrived
>>> [  174.219812] wcn36xx: indication arrived
>>> [  174.320551] wcn36xx: mac config changed 0x00000040
>>> [  174.320559] wcn36xx: wcn36xx_config channel switch=128
>>> [  174.320563] wcn36xx: hal init scan mode 2
>>> [  174.324192] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
>>> [  174.324197] wcn36xx: hal start scan channel 128
>>> [  174.329545] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
>>> [  174.440367] wcn36xx: mac config changed 0x00000040
>>> [  174.440374] wcn36xx: wcn36xx_config channel switch=40
>>> [  174.440378] wcn36xx: hal finish scan mode 2
>>> [  174.449705] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  174.452983] wcn36xx: indication arrived
>>> [  174.655452] wcn36xx: indication arrived
>>> [  174.756428] wcn36xx: mac config changed 0x00000040
>>> [  174.756438] wcn36xx: wcn36xx_config channel switch=132
>>> [  174.756443] wcn36xx: hal init scan mode 2
>>> [  174.759554] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  174.759560] wcn36xx: hal start scan channel 132
>>> [  174.764959] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  174.876237] wcn36xx: mac config changed 0x00000040
>>> [  174.876245] wcn36xx: wcn36xx_config channel switch=40
>>> [  174.876250] wcn36xx: hal finish scan mode 2
>>> [  174.885310] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  174.888341] wcn36xx: indication arrived
>>> [  175.091324] wcn36xx: indication arrived
>>> [  175.192423] wcn36xx: mac config changed 0x00000040
>>> [  175.192430] wcn36xx: wcn36xx_config channel switch=140
>>> [  175.192433] wcn36xx: hal init scan mode 2
>>> [  175.195530] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  175.195534] wcn36xx: hal start scan channel 140
>>> [  175.200805] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  175.312321] wcn36xx: mac config changed 0x00000040
>>> [  175.312329] wcn36xx: wcn36xx_config channel switch=40
>>> [  175.312333] wcn36xx: hal finish scan mode 2
>>> [  175.321295] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  175.324800] wcn36xx: indication arrived
>>> [  175.527611] wcn36xx: indication arrived
>>> [  175.628313] wcn36xx: mac config changed 0x00000040
>>> [  175.628320] wcn36xx: wcn36xx_config channel switch=149
>>> [  175.628324] wcn36xx: hal init scan mode 2
>>> [  175.631414] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  175.631419] wcn36xx: hal start scan channel 149
>>> [  175.636846] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  175.748358] wcn36xx: mac config changed 0x00000040
>>> [  175.748367] wcn36xx: wcn36xx_config channel switch=40
>>> [  175.748371] wcn36xx: hal finish scan mode 2
>>> [  175.758146] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  175.761536] wcn36xx: indication arrived
>>> [  175.963887] wcn36xx: indication arrived
>>> [  176.064314] wcn36xx: mac config changed 0x00000040
>>> [  176.064322] wcn36xx: wcn36xx_config channel switch=153
>>> [  176.064326] wcn36xx: hal init scan mode 2
>>> [  176.067659] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  176.067663] wcn36xx: hal start scan channel 153
>>> [  176.072911] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  176.184091] wcn36xx: mac config changed 0x00000040
>>> [  176.184099] wcn36xx: wcn36xx_config channel switch=40
>>> [  176.184104] wcn36xx: hal finish scan mode 2
>>> [  176.193195] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  176.196177] wcn36xx: indication arrived
>>> [  176.399382] wcn36xx: indication arrived
>>> [  176.500288] wcn36xx: mac config changed 0x00000040
>>> [  176.500295] wcn36xx: wcn36xx_config channel switch=157
>>> [  176.500299] wcn36xx: hal init scan mode 2
>>> [  176.503417] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  176.503421] wcn36xx: hal start scan channel 157
>>> [  176.508762] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  176.620389] wcn36xx: mac config changed 0x00000040
>>> [  176.620396] wcn36xx: wcn36xx_config channel switch=40
>>> [  176.620400] wcn36xx: hal finish scan mode 2
>>> [  176.629516] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  176.632609] wcn36xx: indication arrived
>>> [  176.835319] wcn36xx: indication arrived
>>> [  176.936427] wcn36xx: mac config changed 0x00000040
>>> [  176.936435] wcn36xx: wcn36xx_config channel switch=161
>>> [  176.936440] wcn36xx: hal init scan mode 2
>>> [  176.939590] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  176.939595] wcn36xx: hal start scan channel 161
>>> [  176.945005] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  177.056380] wcn36xx: mac config changed 0x00000040
>>> [  177.056388] wcn36xx: wcn36xx_config channel switch=40
>>> [  177.056392] wcn36xx: hal finish scan mode 2
>>> [  177.065466] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>>> [  177.068489] wcn36xx: indication arrived
>>> [  177.271739] wcn36xx: indication arrived
>>> [  177.372381] wcn36xx: mac config changed 0x00000040
>>> [  177.372389] wcn36xx: wcn36xx_config channel switch=165
>>> [  177.372393] wcn36xx: hal init scan mode 2
>>> [  177.375538] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>>> [  177.375543] wcn36xx: hal start scan channel 165
>>> [  177.380982] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>>> [  177.492402] wcn36xx: mac config changed 0x00000040
>>> [  177.492409] wcn36xx: wcn36xx_config channel switch=40
>>> [  177.492413] wcn36xx: hal finish scan mode 2
>>>
>>> Basically it takes 15 seconds to complete.
>>>
>>> Interleaved scan seems very slow and is IMO unusable on Android
>>
>>
>> The software scan is driven by mac80211 which interleaves channels 
>> scanning
>> with the regular data operations. In worst case, it scans during 111ms 
>> on the
>> channel and switches back to the operating channel for 200ms.
>> So, with 35 channels to scan that would take about 11 seconds to 
>> complete...
>> So yes, it's quite slow...
> 
> Yes looks a scheduling thing in mac80211.
> 
>> However, one remaining
>> thing to try would be to send an update-channel-list command to the
>> firmware before each offload scan (cf UPDATE_CHANNEL_LIST_REQ
>> in the downstream driver). That's not something I've tried yet.
> 
> I've tried
> 
> 1. Setting the operating frequency to a 5ghz band before the scan
> 2. Updating the channel list with 2g/5g channels via 
> UPDATE_CHANNEL_LIST_REQ
> 3. Updating the channel list with 5g only with UPDATE_CHANNEL_LIST_REQ
> 4. Doing 5g channels only in the channel list of 
> WCN36XX_HAL_START_SCAN_OFFLOAD_REQ
> 
> I don't think the channel list matters, if I recall rightly I've also 
> tried leaving out the channel list in WCN36XX_HAL_START_SCAN_OFFLOAD_REQ 
> and get back the same set of channels in the result
> 
> I guess we should take this patch anyway, since it makes wcn36xx and 
> mac80211 agree on ownership of the antenna...
> 
> ---
> bod

Ah.

If we implement ops->flush() we can slash that idle time down significantly

static void ieee80211_scan_state_resume(struct ieee80211_local *local,
                                         unsigned long *next_delay)
{

         if (local->ops->flush) {
                 ieee80211_flush_queues(local, NULL, false);
                 *next_delay = 0;
         } else
                 *next_delay = HZ / 10;
}

Trivial hack example:

+void wcn36xx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+                  u32 queues, bool drop)
+{
+}
+
  static const struct ieee80211_ops wcn36xx_ops = {
         .start                  = wcn36xx_start,
         .stop                   = wcn36xx_stop,
@@ -1187,7 +1192,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
         .sta_add                = wcn36xx_sta_add,
         .sta_remove             = wcn36xx_sta_remove,
         .ampdu_action           = wcn36xx_ampdu_action,
-
+       .flush                  = wcn36xx_flush,
         CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
  };

That ~ 20 seconds is cut to just 4 ! Which to be fair seems to be the 
kind of time it took to do the old version of the software scan.

[  869.625922] wcn36xx: mac config changed 0x00000040
[  869.625930] wcn36xx: wcn36xx_config channel switch=1
[  869.625938] wcn36xx: hal init scan mode 2
[  869.628080] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
[  869.628103] wcn36xx: hal start scan channel 1
[  869.633985] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  869.694216] wcn36xx: mac config changed 0x00000040
[  869.694233] wcn36xx: wcn36xx_config channel switch=2
[  869.694240] wcn36xx: hal init scan mode 2
[  869.695465] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  869.695472] wcn36xx: hal start scan channel 2
[  869.700504] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  869.762229] wcn36xx: mac config changed 0x00000040
[  869.762247] wcn36xx: wcn36xx_config channel switch=3
[  869.762252] wcn36xx: hal init scan mode 2
[  869.763425] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  869.763431] wcn36xx: hal start scan channel 3
[  869.768356] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  869.830220] wcn36xx: mac config changed 0x00000040
[  869.830237] wcn36xx: wcn36xx_config channel switch=4
[  869.830242] wcn36xx: hal init scan mode 2
[  869.831435] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  869.831441] wcn36xx: hal start scan channel 4
[  869.836358] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  869.898218] wcn36xx: mac config changed 0x00000040
[  869.898232] wcn36xx: wcn36xx_config channel switch=5
[  869.898237] wcn36xx: hal init scan mode 2
[  869.899401] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  869.899406] wcn36xx: hal start scan channel 5
[  869.904244] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  869.966234] wcn36xx: mac config changed 0x00000040
[  869.966248] wcn36xx: wcn36xx_config channel switch=6
[  869.966256] wcn36xx: hal init scan mode 2
[  869.967417] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  869.967423] wcn36xx: hal start scan channel 6
[  869.972551] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.034227] wcn36xx: mac config changed 0x00000040
[  870.034242] wcn36xx: wcn36xx_config channel switch=7
[  870.034248] wcn36xx: hal init scan mode 2
[  870.035426] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.035431] wcn36xx: hal start scan channel 7
[  870.040348] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.102225] wcn36xx: mac config changed 0x00000040
[  870.102240] wcn36xx: wcn36xx_config channel switch=8
[  870.102246] wcn36xx: hal init scan mode 2
[  870.103425] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.103430] wcn36xx: hal start scan channel 8
[  870.108288] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.170241] wcn36xx: mac config changed 0x00000040
[  870.170253] wcn36xx: wcn36xx_config channel switch=9
[  870.170258] wcn36xx: hal init scan mode 2
[  870.171801] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.171806] wcn36xx: hal start scan channel 9
[  870.176850] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.238228] wcn36xx: mac config changed 0x00000040
[  870.238245] wcn36xx: wcn36xx_config channel switch=10
[  870.238252] wcn36xx: hal init scan mode 2
[  870.239430] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.239435] wcn36xx: hal start scan channel 10
[  870.244371] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.306231] wcn36xx: mac config changed 0x00000040
[  870.306244] wcn36xx: wcn36xx_config channel switch=11
[  870.306250] wcn36xx: hal init scan mode 2
[  870.307409] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.307414] wcn36xx: hal start scan channel 11
[  870.312317] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.374252] wcn36xx: mac config changed 0x00000040
[  870.374265] wcn36xx: wcn36xx_config channel switch=12
[  870.374270] wcn36xx: hal init scan mode 2
[  870.375476] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.375481] wcn36xx: hal start scan channel 12
[  870.380445] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.490250] wcn36xx: mac config changed 0x00000040
[  870.490265] wcn36xx: wcn36xx_config channel switch=13
[  870.490271] wcn36xx: hal init scan mode 2
[  870.491464] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.491470] wcn36xx: hal start scan channel 13
[  870.496469] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.606269] wcn36xx: mac config changed 0x00000040
[  870.606280] wcn36xx: wcn36xx_config channel switch=14
[  870.606286] wcn36xx: hal init scan mode 2
[  870.607451] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.607457] wcn36xx: hal start scan channel 14
[  870.612376] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.722256] wcn36xx: mac config changed 0x00000040
[  870.722273] wcn36xx: wcn36xx_config channel switch=36
[  870.722278] wcn36xx: hal init scan mode 2
[  870.723462] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.723468] wcn36xx: hal start scan channel 36
[  870.729088] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.838293] wcn36xx: mac config changed 0x00000040
[  870.838320] wcn36xx: wcn36xx_config channel switch=40
[  870.838328] wcn36xx: hal init scan mode 2
[  870.839584] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.839593] wcn36xx: hal start scan channel 40
[  870.844505] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  870.954291] wcn36xx: mac config changed 0x00000040
[  870.954313] wcn36xx: wcn36xx_config channel switch=44
[  870.954321] wcn36xx: hal init scan mode 2
[  870.955544] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  870.955552] wcn36xx: hal start scan channel 44
[  870.960510] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.070288] wcn36xx: mac config changed 0x00000040
[  871.070312] wcn36xx: wcn36xx_config channel switch=48
[  871.070321] wcn36xx: hal init scan mode 2
[  871.071546] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.071553] wcn36xx: hal start scan channel 48
[  871.076610] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.186286] wcn36xx: mac config changed 0x00000040
[  871.186299] wcn36xx: wcn36xx_config channel switch=52
[  871.186306] wcn36xx: hal init scan mode 2
[  871.187547] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.187553] wcn36xx: hal start scan channel 52
[  871.192430] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.302301] wcn36xx: mac config changed 0x00000040
[  871.302316] wcn36xx: wcn36xx_config channel switch=56
[  871.302322] wcn36xx: hal init scan mode 2
[  871.303526] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.303532] wcn36xx: hal start scan channel 56
[  871.308372] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.418292] wcn36xx: mac config changed 0x00000040
[  871.418303] wcn36xx: wcn36xx_config channel switch=60
[  871.418308] wcn36xx: hal init scan mode 2
[  871.419511] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.419517] wcn36xx: hal start scan channel 60
[  871.424368] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.534320] wcn36xx: mac config changed 0x00000040
[  871.534335] wcn36xx: wcn36xx_config channel switch=64
[  871.534341] wcn36xx: hal init scan mode 2
[  871.535526] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.535532] wcn36xx: hal start scan channel 64
[  871.540434] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.650286] wcn36xx: mac config changed 0x00000040
[  871.650299] wcn36xx: wcn36xx_config channel switch=100
[  871.650306] wcn36xx: hal init scan mode 2
[  871.651480] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.651486] wcn36xx: hal start scan channel 100
[  871.656365] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.766292] wcn36xx: mac config changed 0x00000040
[  871.766305] wcn36xx: wcn36xx_config channel switch=104
[  871.766311] wcn36xx: hal init scan mode 2
[  871.767516] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.767522] wcn36xx: hal start scan channel 104
[  871.772388] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.882301] wcn36xx: mac config changed 0x00000040
[  871.882313] wcn36xx: wcn36xx_config channel switch=108
[  871.882319] wcn36xx: hal init scan mode 2
[  871.883488] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.883493] wcn36xx: hal start scan channel 108
[  871.888315] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  871.998313] wcn36xx: mac config changed 0x00000040
[  871.998326] wcn36xx: wcn36xx_config channel switch=112
[  871.998335] wcn36xx: hal init scan mode 2
[  871.999509] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  871.999514] wcn36xx: hal start scan channel 112
[  872.004329] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.114319] wcn36xx: mac config changed 0x00000040
[  872.114334] wcn36xx: wcn36xx_config channel switch=116
[  872.114340] wcn36xx: hal init scan mode 2
[  872.115511] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.115516] wcn36xx: hal start scan channel 116
[  872.120361] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.230319] wcn36xx: mac config changed 0x00000040
[  872.230330] wcn36xx: wcn36xx_config channel switch=120
[  872.230337] wcn36xx: hal init scan mode 2
[  872.231539] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.231545] wcn36xx: hal start scan channel 120
[  872.236431] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.346316] wcn36xx: mac config changed 0x00000040
[  872.346330] wcn36xx: wcn36xx_config channel switch=124
[  872.346336] wcn36xx: hal init scan mode 2
[  872.347521] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.347526] wcn36xx: hal start scan channel 124
[  872.352380] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.462328] wcn36xx: mac config changed 0x00000040
[  872.462343] wcn36xx: wcn36xx_config channel switch=128
[  872.462349] wcn36xx: hal init scan mode 2
[  872.463527] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.463534] wcn36xx: hal start scan channel 128
[  872.468355] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.578340] wcn36xx: mac config changed 0x00000040
[  872.578349] wcn36xx: wcn36xx_config channel switch=132
[  872.578354] wcn36xx: hal init scan mode 2
[  872.579558] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.579565] wcn36xx: hal start scan channel 132
[  872.584405] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.694321] wcn36xx: mac config changed 0x00000040
[  872.694337] wcn36xx: wcn36xx_config channel switch=140
[  872.694343] wcn36xx: hal init scan mode 2
[  872.695500] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.695506] wcn36xx: hal start scan channel 140
[  872.700290] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.810339] wcn36xx: mac config changed 0x00000040
[  872.810351] wcn36xx: wcn36xx_config channel switch=149
[  872.810357] wcn36xx: hal init scan mode 2
[  872.811528] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.811535] wcn36xx: hal start scan channel 149
[  872.816424] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  872.926347] wcn36xx: mac config changed 0x00000040
[  872.926359] wcn36xx: wcn36xx_config channel switch=153
[  872.926366] wcn36xx: hal init scan mode 2
[  872.927525] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  872.927531] wcn36xx: hal start scan channel 153
[  872.932361] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  873.042347] wcn36xx: mac config changed 0x00000040
[  873.042359] wcn36xx: wcn36xx_config channel switch=157
[  873.042366] wcn36xx: hal init scan mode 2
[  873.043531] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  873.043536] wcn36xx: hal start scan channel 157
[  873.048367] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  873.158352] wcn36xx: mac config changed 0x00000040
[  873.158366] wcn36xx: wcn36xx_config channel switch=161
[  873.158373] wcn36xx: hal init scan mode 2
[  873.159550] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  873.159557] wcn36xx: hal start scan channel 161
[  873.164385] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  873.274356] wcn36xx: mac config changed 0x00000040
[  873.274368] wcn36xx: wcn36xx_config channel switch=165
[  873.274374] wcn36xx: hal init scan mode 2
[  873.275673] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  873.275679] wcn36xx: hal start scan channel 165
[  873.280543] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  873.390365] wcn36xx: mac config changed 0x00000040
[  873.390376] wcn36xx: wcn36xx_config channel switch=36
[  873.390382] wcn36xx: hal init scan mode 2
[  873.391571] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
[  873.391582] wcn36xx: hal start scan channel 36
[  873.395275] wlan0: authenticate with e0:63:da:cc:a4:bd
[  873.396502] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
[  873.396522] wcn36xx: mac prepare multicast list
[  873.396539] wcn36xx: mac configure filter
[  873.396551] wcn36xx: hal finish scan mode 2
[  873.405870] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
[  873.405953] wcn36xx: mac config changed 0x00000100
[  873.406063] wcn36xx: mac config changed 0x00000100
[  873.406070] wcn36xx: mac config changed 0x00000040
[  873.406075] wcn36xx: wcn36xx_config channel switch=36

Not only that but I get the full scan-result list as expected...

So yeah I think this patch is good as-is.
We should add ops->flush() - I guess I'll send something out for comment 
on that in the next 12-18 hours.

---
bod
