Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB2249B38
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHSKwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHSKvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 06:51:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F37C061757
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 03:51:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1699897wma.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=irmVpbnG5alyyRJ2SD6vF/DBORANZd962TmnEDTELrY=;
        b=ocfR54KTZ4+HQU7soP1CdA7SqtBuvER8VIy9aQ/sBy6ZZqZSAEv1d6oKctiC8no+I2
         BlJqsBR4dpVaxcAODOwkyI3QvrbskhMOchAR9VqYg/zpMzZ99xF5KXaawMJUfGrm2icO
         mOhDsb47c+lXkV3OF2/VtXsk9aS7BvdslsWHns4Jrqc4sgkJROBdU6WxE58Xe6ErNb95
         gSSS+GaeXQWKF+plw9OEWjbDy9TLU2yIMF7m9gUmvd1L038WD7K9Owva4uIUGaD+I7Db
         VYlceZwytDNiND7pO2BIq/1Rusm/BjEzT7lpugRuhFbgHzbmyqejQinh445YKf8K8kdb
         4K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irmVpbnG5alyyRJ2SD6vF/DBORANZd962TmnEDTELrY=;
        b=BGJ7xVq/r21Wk98v5DlH2rObuyJ4NQAyiGBY64s+go9bZJ7E9AY5K/v9NCE/kwanZy
         w63Or7oq1NVZbfadILohwRcdhnhL2PkxOu0/UwzZ2pedz7223NcTl5RnTwnE8ggr2ypv
         dwgLL8wVbXaLJlVBRqQJGUhZ1eez9vtPsss+iFZvQvUXeHh2eP9c/jZ8Lt/dQfs8m2R3
         mqB4qaScO6j6jP8V9Lw54Ka6jA34s9rBzTQPtj633nAvlZ39WUEsETs28aZACqwwMHzD
         uKDRZ78GBrVJrF4MdR5gxMQ+wQOgy1GkZm2J6NgVxdbd5zXARYLbKAoTTggImTdPAMb0
         LmIw==
X-Gm-Message-State: AOAM532PAyiodA24j0pG2wRHdV+XLzXf5SO3Ri008vmWWsMgMkQ8Q22j
        kB6TTPJnI2PcWYCLEZazpViHUJ00H3Ok1Awg
X-Google-Smtp-Source: ABdhPJxzPntlOygH33hOrNtui/BczOuRPsMjwPtmo5AHgbX33dAQD07idjYxCJhsih+ur0v0zQPnDw==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr4637265wmi.180.1597834308834;
        Wed, 19 Aug 2020 03:51:48 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t11sm36802941wrs.66.2020.08.19.03.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 03:51:48 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
 <87pn7ojx8g.fsf@codeaurora.org>
 <CAMZdPi9sQ2BM4G2cSKNfE06fOtvOtgb+ELqAkxUJdtLbuoeYzQ@mail.gmail.com>
 <9ff7836b-2d84-91bc-0691-f8696541ffc2@nexus-software.ie>
 <CAMZdPi9MN=pJ_j0py4egeR=HM2d=T+h8JXgH=WiN1PpnbTX3qg@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <bec1a210-1bfc-8d80-d2a0-41b6be7f807a@linaro.org>
Date:   Wed, 19 Aug 2020 11:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi9MN=pJ_j0py4egeR=HM2d=T+h8JXgH=WiN1PpnbTX3qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/08/2020 09:15, Loic Poulain wrote:
> Hi Bryan,
> 
> On Tue, 18 Aug 2020 at 20:00, Bryan O'Donoghue
> <pure.logic@nexus-software.ie> wrote:
>>
>> On 18/08/2020 14:34, Loic Poulain wrote:
>>> On Tue, 18 Aug 2020 at 08:15, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>
>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>
>>>>> For software-driven scan, rely on mac80211 software scan instead
>>>>> of internal driver implementation. The internal implementation
>>>>> cause connection trouble since it keep the antenna busy during
>>>>> the entire scan duration, moreover it's only a passive scanning
>>>>> (no probe request). Therefore, let mac80211 manages sw scan.
>>>>>
>>>>> Note: we fallback to software scan if firmware does not report
>>>>> scan offload support or if we need to scan the 5Ghz band (currently
>>>>> not supported by the offload scan...).
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>
>>>> What changed since v2? Please always include a changelog so that I don't
>>>> need to guess what you have changed in the patch. No need to resend, a
>>>> reply is enough.
>>>
>>> Yes sorry, this patch has been rebased on ath master and squashed with
>>> Bryan's fix:
>>>        wcn36xx: Set sw-scan chan to 0 when not associated
>>> No additional changes have been made on top of the initial patches.
>>>
>>> Regards,
>>> Loic
>>>
>>
>> This is excruciatingly slow on Android.
>>
>> Android I'm finding unlike Debian where this stuff was tested, merrily
>> issues scan requests every 30 seconds.
>>
>> For me this ends up looking like this
>>
>> [  162.296995] wcn36xx: mac config changed 0x00000040
>> [  162.297001] wcn36xx: wcn36xx_config channel switch=1
>> [  162.297005] wcn36xx: hal init scan mode 2
>> [  162.300011] wcn36xx: indication arrived
>> [  162.300525] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
>> [  162.300529] wcn36xx: hal start scan channel 1
>> [  162.306930] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
>>
>> Big gap here
>>
>> [  162.368198] wcn36xx: mac config changed 0x00000040
>> [  162.368205] wcn36xx: wcn36xx_config channel switch=40
>> [  162.368209] wcn36xx: hal finish scan mode 2
>> [  162.379085] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  162.382218] wcn36xx: indication arrived
>> [  162.583396] wcn36xx: indication arrived
>> [  162.684336] wcn36xx: mac config changed 0x00000040
>> [  162.684344] wcn36xx: wcn36xx_config channel switch=2
>> [  162.684348] wcn36xx: hal init scan mode 2
>> [  162.687547] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  162.687552] wcn36xx: hal start scan channel 2
>> [  162.693935] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  162.756359] wcn36xx: mac config changed 0x00000040
>> [  162.756367] wcn36xx: wcn36xx_config channel switch=40
>> [  162.756371] wcn36xx: hal finish scan mode 2
>> [  162.767361] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  162.770445] wcn36xx: indication arrived
>> [  162.971533] wcn36xx: indication arrived
>> [  163.072318] wcn36xx: mac config changed 0x00000040
>> [  163.072325] wcn36xx: wcn36xx_config channel switch=3
>> [  163.072329] wcn36xx: hal init scan mode 2
>> [  163.075449] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  163.075453] wcn36xx: hal start scan channel 3
>> [  163.081648] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  163.144202] wcn36xx: mac config changed 0x00000040
>> [  163.144210] wcn36xx: wcn36xx_config channel switch=40
>> [  163.144214] wcn36xx: hal finish scan mode 2
>> [  163.155103] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  163.158219] wcn36xx: indication arrived
>> [  163.359477] wcn36xx: indication arrived
>> [  163.460428] wcn36xx: mac config changed 0x00000040
>> [  163.460435] wcn36xx: wcn36xx_config channel switch=4
>> [  163.460439] wcn36xx: hal init scan mode 2
>> [  163.463572] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  163.463576] wcn36xx: hal start scan channel 4
>> [  163.469851] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  163.532373] wcn36xx: mac config changed 0x00000040
>> [  163.532381] wcn36xx: wcn36xx_config channel switch=40
>> [  163.532384] wcn36xx: hal finish scan mode 2
>> [  163.543736] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  163.546987] wcn36xx: indication arrived
>> [  163.747577] wcn36xx: indication arrived
>> [  163.848431] wcn36xx: mac config changed 0x00000040
>> [  163.848439] wcn36xx: wcn36xx_config channel switch=5
>> [  163.848442] wcn36xx: hal init scan mode 2
>> [  163.851668] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  163.851672] wcn36xx: hal start scan channel 5
>> [  163.857929] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  163.920386] wcn36xx: mac config changed 0x00000040
>> [  163.920394] wcn36xx: wcn36xx_config channel switch=40
>> [  163.920398] wcn36xx: hal finish scan mode 2
>> [  163.931279] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  163.934460] wcn36xx: indication arrived
>> [  164.135411] wcn36xx: indication arrived
>> [  164.236376] wcn36xx: mac config changed 0x00000040
>> [  164.236383] wcn36xx: wcn36xx_config channel switch=6
>> [  164.236387] wcn36xx: hal init scan mode 2
>> [  164.239669] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  164.239673] wcn36xx: hal start scan channel 6
>> [  164.245868] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  164.308339] wcn36xx: mac config changed 0x00000040
>> [  164.308347] wcn36xx: wcn36xx_config channel switch=40
>> [  164.308351] wcn36xx: hal finish scan mode 2
>> [  164.319240] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  164.322405] wcn36xx: indication arrived
>> [  164.523510] wcn36xx: indication arrived
>> [  164.624238] wcn36xx: mac config changed 0x00000040
>> [  164.624245] wcn36xx: wcn36xx_config channel switch=7
>> [  164.624249] wcn36xx: hal init scan mode 2
>> [  164.627352] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  164.627356] wcn36xx: hal start scan channel 7
>> [  164.633425] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  164.696365] wcn36xx: mac config changed 0x00000040
>> [  164.696374] wcn36xx: wcn36xx_config channel switch=40
>> [  164.696378] wcn36xx: hal finish scan mode 2
>> [  164.707355] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  164.710683] wcn36xx: indication arrived
>> [  164.911285] wcn36xx: indication arrived
>> [  165.012228] wcn36xx: mac config changed 0x00000040
>> [  165.012236] wcn36xx: wcn36xx_config channel switch=8
>> [  165.012240] wcn36xx: hal init scan mode 2
>> [  165.015434] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  165.015439] wcn36xx: hal start scan channel 8
>> [  165.021509] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  165.084204] wcn36xx: mac config changed 0x00000040
>> [  165.084212] wcn36xx: wcn36xx_config channel switch=40
>> [  165.084217] wcn36xx: hal finish scan mode 2
>> [  165.095164] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  165.098269] wcn36xx: indication arrived
>> [  165.299691] wcn36xx: indication arrived
>> [  165.400304] wcn36xx: mac config changed 0x00000040
>> [  165.400309] wcn36xx: wcn36xx_config channel switch=9
>> [  165.400313] wcn36xx: hal init scan mode 2
>> [  165.403424] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  165.403428] wcn36xx: hal start scan channel 9
>> [  165.409695] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  165.472378] wcn36xx: mac config changed 0x00000040
>> [  165.472386] wcn36xx: wcn36xx_config channel switch=40
>> [  165.472390] wcn36xx: hal finish scan mode 2
>> [  165.483390] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  165.486478] wcn36xx: indication arrived
>> [  165.687641] wcn36xx: indication arrived
>> [  165.788548] wcn36xx: mac config changed 0x00000040
>> [  165.788556] wcn36xx: wcn36xx_config channel switch=10
>> [  165.788561] wcn36xx: hal init scan mode 2
>> [  165.791729] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  165.791734] wcn36xx: hal start scan channel 10
>> [  165.797986] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  165.860337] wcn36xx: mac config changed 0x00000040
>> [  165.860346] wcn36xx: wcn36xx_config channel switch=40
>> [  165.860349] wcn36xx: hal finish scan mode 2
>> [  165.871185] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  165.874560] wcn36xx: indication arrived
>> [  166.075631] wcn36xx: indication arrived
>> [  166.176336] wcn36xx: mac config changed 0x00000040
>> [  166.176344] wcn36xx: wcn36xx_config channel switch=11
>> [  166.176348] wcn36xx: hal init scan mode 2
>> [  166.179753] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  166.179758] wcn36xx: hal start scan channel 11
>> [  166.186033] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  166.248204] wcn36xx: mac config changed 0x00000040
>> [  166.248211] wcn36xx: wcn36xx_config channel switch=40
>> [  166.248216] wcn36xx: hal finish scan mode 2
>> [  166.259127] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  166.262339] wcn36xx: indication arrived
>> [  166.463387] wcn36xx: indication arrived
>> [  166.564353] wcn36xx: mac config changed 0x00000040
>> [  166.564362] wcn36xx: wcn36xx_config channel switch=12
>> [  166.564366] wcn36xx: hal init scan mode 2
>> [  166.567517] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  166.567522] wcn36xx: hal start scan channel 12
>> [  166.573823] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  166.684383] wcn36xx: mac config changed 0x00000040
>> [  166.684390] wcn36xx: wcn36xx_config channel switch=40
>> [  166.684394] wcn36xx: hal finish scan mode 2
>> [  166.695665] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  166.698857] wcn36xx: indication arrived
>> [  166.899623] wcn36xx: indication arrived
>> [  167.000265] wcn36xx: mac config changed 0x00000040
>> [  167.000273] wcn36xx: wcn36xx_config channel switch=13
>> [  167.000277] wcn36xx: hal init scan mode 2
>> [  167.003459] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  167.003463] wcn36xx: hal start scan channel 13
>> [  167.009787] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  167.120339] wcn36xx: mac config changed 0x00000040
>> [  167.120348] wcn36xx: wcn36xx_config channel switch=40
>> [  167.120351] wcn36xx: hal finish scan mode 2
>> [  167.131208] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  167.134376] wcn36xx: indication arrived
>> [  167.335469] wcn36xx: indication arrived
>> [  167.436335] wcn36xx: mac config changed 0x00000040
>> [  167.436343] wcn36xx: wcn36xx_config channel switch=14
>> [  167.436347] wcn36xx: hal init scan mode 2
>> [  167.439492] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  167.439497] wcn36xx: hal start scan channel 14
>> [  167.446075] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  167.556358] wcn36xx: mac config changed 0x00000040
>> [  167.556367] wcn36xx: wcn36xx_config channel switch=40
>> [  167.556372] wcn36xx: hal finish scan mode 2
>> [  167.567787] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  167.570712] wcn36xx: indication arrived
>> [  167.771184] wcn36xx: indication arrived
>> [  167.872093] wcn36xx: mac config changed 0x00000040
>> [  167.872104] wcn36xx: wcn36xx_config channel switch=36
>> [  167.872110] wcn36xx: hal init scan mode 2
>> [  167.875463] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  167.875469] wcn36xx: hal start scan channel 36
>> [  167.880887] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  167.944229] wcn36xx: mac config changed 0x00000040
>> [  167.944238] wcn36xx: wcn36xx_config channel switch=40
>> [  167.944243] wcn36xx: hal finish scan mode 2
>> [  167.953262] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  167.956751] wcn36xx: indication arrived
>> [  168.159485] wcn36xx: indication arrived
>> [  168.260233] wcn36xx: mac config changed 0x00000040
>> [  168.260243] wcn36xx: wcn36xx_config channel switch=40
>> [  168.260248] wcn36xx: hal finish scan mode 2
>> [  168.268055] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  168.332250] wcn36xx: mac config changed 0x00000040
>> [  168.332259] wcn36xx: wcn36xx_config channel switch=40
>> [  168.332264] wcn36xx: hal finish scan mode 2
>> [  168.340018] wcn36xx: SMD command (req 10, rsp 11) completed in 4ms
>> [  168.343231] wcn36xx: indication arrived
>> [  168.547404] wcn36xx: indication arrived
>> [  168.652662] wcn36xx: mac config changed 0x00000040
>> [  168.652666] wcn36xx: wcn36xx_config channel switch=44
>> [  168.652670] wcn36xx: hal init scan mode 2
>> [  168.655732] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  168.655736] wcn36xx: hal start scan channel 44
>> [  168.660968] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  168.772327] wcn36xx: mac config changed 0x00000040
>> [  168.772334] wcn36xx: wcn36xx_config channel switch=40
>> [  168.772338] wcn36xx: hal finish scan mode 2
>> [  168.781369] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  168.784371] wcn36xx: indication arrived
>> [  168.987575] wcn36xx: indication arrived
>> [  169.088390] wcn36xx: mac config changed 0x00000040
>> [  169.088398] wcn36xx: wcn36xx_config channel switch=48
>> [  169.088402] wcn36xx: hal init scan mode 2
>> [  169.091527] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  169.091532] wcn36xx: hal start scan channel 48
>> [  169.097022] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  169.208455] wcn36xx: mac config changed 0x00000040
>> [  169.208463] wcn36xx: wcn36xx_config channel switch=40
>> [  169.208467] wcn36xx: hal finish scan mode 2
>> [  169.218407] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  169.221568] wcn36xx: indication arrived
>> [  169.423420] wcn36xx: indication arrived
>> [  169.524402] wcn36xx: mac config changed 0x00000040
>> [  169.524409] wcn36xx: wcn36xx_config channel switch=52
>> [  169.524413] wcn36xx: hal init scan mode 2
>> [  169.527559] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  169.527563] wcn36xx: hal start scan channel 52
>> [  169.532973] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  169.644216] wcn36xx: mac config changed 0x00000040
>> [  169.644223] wcn36xx: wcn36xx_config channel switch=40
>> [  169.644227] wcn36xx: hal finish scan mode 2
>> [  169.653367] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  169.656579] wcn36xx: indication arrived
>> [  169.859998] wcn36xx: indication arrived
>> [  169.960478] wcn36xx: mac config changed 0x00000040
>> [  169.960489] wcn36xx: wcn36xx_config channel switch=56
>> [  169.960494] wcn36xx: hal init scan mode 2
>> [  169.963757] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  169.963762] wcn36xx: hal start scan channel 56
>> [  169.969107] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  170.080126] wcn36xx: mac config changed 0x00000040
>> [  170.080136] wcn36xx: wcn36xx_config channel switch=40
>> [  170.080141] wcn36xx: hal finish scan mode 2
>> [  170.089183] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  170.092346] wcn36xx: indication arrived
>> [  170.295765] wcn36xx: indication arrived
>> [  170.396072] wcn36xx: mac config changed 0x00000040
>> [  170.396079] wcn36xx: wcn36xx_config channel switch=60
>> [  170.396083] wcn36xx: hal init scan mode 2
>> [  170.399139] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  170.399144] wcn36xx: hal start scan channel 60
>> [  170.404547] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  170.516260] wcn36xx: mac config changed 0x00000040
>> [  170.516268] wcn36xx: wcn36xx_config channel switch=40
>> [  170.516272] wcn36xx: hal finish scan mode 2
>> [  170.525323] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  170.528989] wcn36xx: indication arrived
>> [  170.731306] wcn36xx: indication arrived
>> [  170.832258] wcn36xx: mac config changed 0x00000040
>> [  170.832266] wcn36xx: wcn36xx_config channel switch=64
>> [  170.832270] wcn36xx: hal init scan mode 2
>> [  170.835453] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  170.835457] wcn36xx: hal start scan channel 64
>> [  170.840746] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  170.952490] wcn36xx: mac config changed 0x00000040
>> [  170.952497] wcn36xx: wcn36xx_config channel switch=40
>> [  170.952501] wcn36xx: hal finish scan mode 2
>> [  170.961563] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  170.964663] wcn36xx: indication arrived
>> [  171.167256] wcn36xx: indication arrived
>> [  171.268465] wcn36xx: mac config changed 0x00000040
>> [  171.268474] wcn36xx: wcn36xx_config channel switch=100
>> [  171.268478] wcn36xx: hal init scan mode 2
>> [  171.271622] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  171.271626] wcn36xx: hal start scan channel 100
>> [  171.277068] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  171.388309] wcn36xx: mac config changed 0x00000040
>> [  171.388316] wcn36xx: wcn36xx_config channel switch=40
>> [  171.388320] wcn36xx: hal finish scan mode 2
>> [  171.397462] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  171.400449] wcn36xx: indication arrived
>> [  171.603380] wcn36xx: indication arrived
>> [  171.704307] wcn36xx: mac config changed 0x00000040
>> [  171.704315] wcn36xx: wcn36xx_config channel switch=104
>> [  171.704318] wcn36xx: hal init scan mode 2
>> [  171.707472] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  171.707476] wcn36xx: hal start scan channel 104
>> [  171.712907] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  171.824322] wcn36xx: mac config changed 0x00000040
>> [  171.824330] wcn36xx: wcn36xx_config channel switch=40
>> [  171.824334] wcn36xx: hal finish scan mode 2
>> [  171.833404] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  171.836577] wcn36xx: indication arrived
>> [  172.039628] wcn36xx: indication arrived
>> [  172.140321] wcn36xx: mac config changed 0x00000040
>> [  172.140329] wcn36xx: wcn36xx_config channel switch=108
>> [  172.140333] wcn36xx: hal init scan mode 2
>> [  172.143442] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  172.143447] wcn36xx: hal start scan channel 108
>> [  172.149071] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  172.260211] wcn36xx: mac config changed 0x00000040
>> [  172.260219] wcn36xx: wcn36xx_config channel switch=40
>> [  172.260222] wcn36xx: hal finish scan mode 2
>> [  172.269482] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  172.272333] wcn36xx: indication arrived
>> [  172.475588] wcn36xx: indication arrived
>> [  172.576210] wcn36xx: mac config changed 0x00000040
>> [  172.576217] wcn36xx: wcn36xx_config channel switch=112
>> [  172.576221] wcn36xx: hal init scan mode 2
>> [  172.579357] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  172.579362] wcn36xx: hal start scan channel 112
>> [  172.584763] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  172.696318] wcn36xx: mac config changed 0x00000040
>> [  172.696325] wcn36xx: wcn36xx_config channel switch=40
>> [  172.696329] wcn36xx: hal finish scan mode 2
>> [  172.705421] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  172.708542] wcn36xx: indication arrived
>> [  172.911501] wcn36xx: indication arrived
>> [  173.012248] wcn36xx: mac config changed 0x00000040
>> [  173.012255] wcn36xx: wcn36xx_config channel switch=116
>> [  173.012259] wcn36xx: hal init scan mode 2
>> [  173.015521] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  173.015532] wcn36xx: hal start scan channel 116
>> [  173.020870] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  173.132338] wcn36xx: mac config changed 0x00000040
>> [  173.132346] wcn36xx: wcn36xx_config channel switch=40
>> [  173.132350] wcn36xx: hal finish scan mode 2
>> [  173.141388] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  173.144426] wcn36xx: indication arrived
>> [  173.347588] wcn36xx: indication arrived
>> [  173.448338] wcn36xx: mac config changed 0x00000040
>> [  173.448347] wcn36xx: wcn36xx_config channel switch=120
>> [  173.448350] wcn36xx: hal init scan mode 2
>> [  173.451499] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  173.451503] wcn36xx: hal start scan channel 120
>> [  173.456889] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  173.568336] wcn36xx: mac config changed 0x00000040
>> [  173.568344] wcn36xx: wcn36xx_config channel switch=40
>> [  173.568348] wcn36xx: hal finish scan mode 2
>> [  173.577465] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  173.580602] wcn36xx: indication arrived
>> [  173.783414] wcn36xx: indication arrived
>> [  173.884494] wcn36xx: mac config changed 0x00000040
>> [  173.884504] wcn36xx: wcn36xx_config channel switch=124
>> [  173.884508] wcn36xx: hal init scan mode 2
>> [  173.887627] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  173.887633] wcn36xx: hal start scan channel 124
>> [  173.892978] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  174.004293] wcn36xx: mac config changed 0x00000040
>> [  174.004303] wcn36xx: wcn36xx_config channel switch=40
>> [  174.004308] wcn36xx: hal finish scan mode 2
>> [  174.013188] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  174.017060] wcn36xx: indication arrived
>> [  174.219812] wcn36xx: indication arrived
>> [  174.320551] wcn36xx: mac config changed 0x00000040
>> [  174.320559] wcn36xx: wcn36xx_config channel switch=128
>> [  174.320563] wcn36xx: hal init scan mode 2
>> [  174.324192] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
>> [  174.324197] wcn36xx: hal start scan channel 128
>> [  174.329545] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
>> [  174.440367] wcn36xx: mac config changed 0x00000040
>> [  174.440374] wcn36xx: wcn36xx_config channel switch=40
>> [  174.440378] wcn36xx: hal finish scan mode 2
>> [  174.449705] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  174.452983] wcn36xx: indication arrived
>> [  174.655452] wcn36xx: indication arrived
>> [  174.756428] wcn36xx: mac config changed 0x00000040
>> [  174.756438] wcn36xx: wcn36xx_config channel switch=132
>> [  174.756443] wcn36xx: hal init scan mode 2
>> [  174.759554] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  174.759560] wcn36xx: hal start scan channel 132
>> [  174.764959] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  174.876237] wcn36xx: mac config changed 0x00000040
>> [  174.876245] wcn36xx: wcn36xx_config channel switch=40
>> [  174.876250] wcn36xx: hal finish scan mode 2
>> [  174.885310] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  174.888341] wcn36xx: indication arrived
>> [  175.091324] wcn36xx: indication arrived
>> [  175.192423] wcn36xx: mac config changed 0x00000040
>> [  175.192430] wcn36xx: wcn36xx_config channel switch=140
>> [  175.192433] wcn36xx: hal init scan mode 2
>> [  175.195530] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  175.195534] wcn36xx: hal start scan channel 140
>> [  175.200805] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  175.312321] wcn36xx: mac config changed 0x00000040
>> [  175.312329] wcn36xx: wcn36xx_config channel switch=40
>> [  175.312333] wcn36xx: hal finish scan mode 2
>> [  175.321295] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  175.324800] wcn36xx: indication arrived
>> [  175.527611] wcn36xx: indication arrived
>> [  175.628313] wcn36xx: mac config changed 0x00000040
>> [  175.628320] wcn36xx: wcn36xx_config channel switch=149
>> [  175.628324] wcn36xx: hal init scan mode 2
>> [  175.631414] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  175.631419] wcn36xx: hal start scan channel 149
>> [  175.636846] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  175.748358] wcn36xx: mac config changed 0x00000040
>> [  175.748367] wcn36xx: wcn36xx_config channel switch=40
>> [  175.748371] wcn36xx: hal finish scan mode 2
>> [  175.758146] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  175.761536] wcn36xx: indication arrived
>> [  175.963887] wcn36xx: indication arrived
>> [  176.064314] wcn36xx: mac config changed 0x00000040
>> [  176.064322] wcn36xx: wcn36xx_config channel switch=153
>> [  176.064326] wcn36xx: hal init scan mode 2
>> [  176.067659] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  176.067663] wcn36xx: hal start scan channel 153
>> [  176.072911] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  176.184091] wcn36xx: mac config changed 0x00000040
>> [  176.184099] wcn36xx: wcn36xx_config channel switch=40
>> [  176.184104] wcn36xx: hal finish scan mode 2
>> [  176.193195] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  176.196177] wcn36xx: indication arrived
>> [  176.399382] wcn36xx: indication arrived
>> [  176.500288] wcn36xx: mac config changed 0x00000040
>> [  176.500295] wcn36xx: wcn36xx_config channel switch=157
>> [  176.500299] wcn36xx: hal init scan mode 2
>> [  176.503417] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  176.503421] wcn36xx: hal start scan channel 157
>> [  176.508762] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  176.620389] wcn36xx: mac config changed 0x00000040
>> [  176.620396] wcn36xx: wcn36xx_config channel switch=40
>> [  176.620400] wcn36xx: hal finish scan mode 2
>> [  176.629516] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  176.632609] wcn36xx: indication arrived
>> [  176.835319] wcn36xx: indication arrived
>> [  176.936427] wcn36xx: mac config changed 0x00000040
>> [  176.936435] wcn36xx: wcn36xx_config channel switch=161
>> [  176.936440] wcn36xx: hal init scan mode 2
>> [  176.939590] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  176.939595] wcn36xx: hal start scan channel 161
>> [  176.945005] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  177.056380] wcn36xx: mac config changed 0x00000040
>> [  177.056388] wcn36xx: wcn36xx_config channel switch=40
>> [  177.056392] wcn36xx: hal finish scan mode 2
>> [  177.065466] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
>> [  177.068489] wcn36xx: indication arrived
>> [  177.271739] wcn36xx: indication arrived
>> [  177.372381] wcn36xx: mac config changed 0x00000040
>> [  177.372389] wcn36xx: wcn36xx_config channel switch=165
>> [  177.372393] wcn36xx: hal init scan mode 2
>> [  177.375538] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
>> [  177.375543] wcn36xx: hal start scan channel 165
>> [  177.380982] wcn36xx: SMD command (req 6, rsp 7) completed in 8ms
>> [  177.492402] wcn36xx: mac config changed 0x00000040
>> [  177.492409] wcn36xx: wcn36xx_config channel switch=40
>> [  177.492413] wcn36xx: hal finish scan mode 2
>>
>> Basically it takes 15 seconds to complete.
>>
>> Interleaved scan seems very slow and is IMO unusable on Android
> 
> 
> The software scan is driven by mac80211 which interleaves channels scanning
> with the regular data operations. In worst case, it scans during 111ms on the
> channel and switches back to the operating channel for 200ms.
> So, with 35 channels to scan that would take about 11 seconds to complete...
> So yes, it's quite slow...

Yes looks a scheduling thing in mac80211.

> However, one remaining
> thing to try would be to send an update-channel-list command to the
> firmware before each offload scan (cf UPDATE_CHANNEL_LIST_REQ
> in the downstream driver). That's not something I've tried yet.

I've tried

1. Setting the operating frequency to a 5ghz band before the scan
2. Updating the channel list with 2g/5g channels via UPDATE_CHANNEL_LIST_REQ
3. Updating the channel list with 5g only with UPDATE_CHANNEL_LIST_REQ
4. Doing 5g channels only in the channel list of 
WCN36XX_HAL_START_SCAN_OFFLOAD_REQ

I don't think the channel list matters, if I recall rightly I've also 
tried leaving out the channel list in WCN36XX_HAL_START_SCAN_OFFLOAD_REQ 
and get back the same set of channels in the result

I guess we should take this patch anyway, since it makes wcn36xx and 
mac80211 agree on ownership of the antenna...

---
bod
