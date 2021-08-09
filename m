Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED24A3E495C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhHIP7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhHIP7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 11:59:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCDC0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 08:58:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y7so13372452ljp.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RgEOe7Od7bDg92a0XIpNOIo50DQDEnLGX2aqehjzU/k=;
        b=Yv5UZ9k/8yxidHAV0VEA3su4Jt1SjNh0ELLOdgNGf4EzLnny0ifXjLU9nIxNOw1BWx
         f17t7+L7CZGRrEsn70zADD2n9sbQe6hGvRDAqlToPzVGlS6pfMCwnrx1lkVIARhlEg4M
         fVC3K0shtC5D67bjhbFYXF7U4ACcd81409ywEpK4e4mKJRvmWkX+3529UL6dAMW+ZTdt
         shCgsCxyuNHXJR0wBNkL668+OXZMoTWfkWT/6MiWLkgHKVErg0aioSJkzOr9v6Ku5owj
         MO5+tSgUcbLkXxX1C8/H4+iIsv5vWmz/OajmUPloYey0Gi9ZFm1sq5aAuxg9YKkmx0KN
         Qv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RgEOe7Od7bDg92a0XIpNOIo50DQDEnLGX2aqehjzU/k=;
        b=l7U1Sd6n8WrcHPMynX0yxd/TYXs4F4GqcgheX82nVGGNv2OlwcHMeHKIjy3lCjxtha
         j+KZ1TEi1pU+9MoPhr7gIJXkOgc+96GCGK9QZ3gzxPG2onqYhg+QYPWOrqnvxIQ3ALz8
         pOshCv770QItXaflnBzDVFethfAUA4JxkcxpTsR2Ombohni8DUbPOhlJ3e+7Yphudj3S
         b0YtT0ca0Eja2bInsfUV9XjtWiqhQJKFuJDx/Jf0hT+wqRi7jlkwO06kMIp0cLZvW7Zn
         o/ltCFYnJESDNPe2JZEiWS8ETJx20AcT/DzQJ4g1JQTOZ+1ph2PxcmgNDmhqJjpvjHdz
         a1Tw==
X-Gm-Message-State: AOAM532IicMPuCTF7gVn3V5lfz+y9AIyrOiR3sojg1Uu9q4b5A7uxaro
        bFfpJOCJudb0h3LX2gwWp04=
X-Google-Smtp-Source: ABdhPJz1tyCxAHL0OtW5RT9ycNC5L9wdOk5JDxZfD5/XCKYDG5Fnt4Q8AP5PM2WqvWCFqspkQyYclg==
X-Received: by 2002:a2e:7811:: with SMTP id t17mr16345548ljc.372.1628524720909;
        Mon, 09 Aug 2021 08:58:40 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id n18sm1130234lfu.257.2021.08.09.08.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 08:58:40 -0700 (PDT)
Subject: Re: [PATCH v5] brcmfmac: firmware: Fix firmware loading
To:     Arend van Spriel <aspriel@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>
References: <20210808180510.8753-1-digetx@gmail.com>
 <902984be-2c27-e6b0-247b-8d9a94c08cc4@broadcom.com>
 <36277b51-b647-898c-c1b4-a0e363c52b0d@gmail.com>
 <17b2b945e88.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <06d7d16b-b2ca-dd67-f6a3-06b3b8b1722f@gmail.com>
Date:   Mon, 9 Aug 2021 18:58:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <17b2b945e88.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

09.08.2021 18:42, Arend van Spriel пишет:
> On August 9, 2021 4:56:46 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> 09.08.2021 11:23, Arend van Spriel пишет:
>>> On 8/8/2021 8:05 PM, Dmitry Osipenko wrote:
>>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> The patch that would first try the board-specific firmware
>>>> had a bug because the fallback would not be called: the
>>>> asynchronous interface is used meaning request_firmware_nowait()
>>>> returns 0 immediately.
>>>>
>>>> Harden the firmware loading like this:
>>>>
>>>> - If we cannot build an alt_path (like if no board_type is
>>>>   specified) just request the first firmware without any
>>>>   suffix, like in the past.
>>>>
>>>> - If the lookup of a board specific firmware fails, we get
>>>>   a NULL fw in the async callback, so just try again without
>>>>   the alt_path from a dedicated brcm_fw_request_done_alt_path
>>>>   callback.
>>>>
>>>> - Drop the unnecessary prototype of brcm_fw_request_done.
>>>>
>>>> - Added MODULE_FIRMWARE match for per-board SDIO bins, making
>>>>   userspace tools to pull all the relevant firmware files.
>>> The original idea was to setup the path names in
>>> brcmf_fw_alloc_request() function, but with the introduction of the
>>> board_type for NVRAM files that was abandoned and we cook up alternative
>>> paths. Now similar is done for the firmware files. So I would want to
>>> rework the code, but for now I am going with Linus's/Your fix for the
>>> sake of having the regression more or less quickly resolved.
>>
>> Thanks, indeed it could be improved further later on.
>>
>>> You reported an issue earlier where the firmware callback was called
>>> from the probe context causing it to hang and it is not clear to me
>>> whether that is fixed with this version of the patch.
>>
>> It's independent minor problem that can't be easily reproduced in
>> practice and seems it existed for a long time. It's not fixed by this
>> patch.
> 
> Ok. I understand the issue and I have a fix lined up for it. I noticed
> my reviewed-by tag got lost between V2 and latest version. Feel free to
> add it back.

Please reply with yours r-b to the patch, it should be enough.

