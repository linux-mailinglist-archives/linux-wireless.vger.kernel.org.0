Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58743E482F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhHIO5H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhHIO5H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 10:57:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470EC0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 07:56:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g30so2304217lfv.4
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+egoCjJZRtbMT1nfOKmOSW+viPFzbcoNrm7MMAEra2A=;
        b=pEAoEKF4M90G6z3V08r2ja2Jg0708/c9vsUSsgV992a93WDBtGuIS2H0ymTkkgackv
         y8WXeNeYZIKS96xDswxmop7MHIJ1GgLbICX4NjEY+Sw17yXvsuYUL3VN6zjOjOJI1F9H
         /FI6Uu/iywx95pHPbbNdf8Eo8E1wPsUvzYC1JkE48eH4Kp15NZ5b/H3oosW/HFLSJ97L
         71c9wCt0Fz2w6edegqlox9GtoaQszw7ee7BsauTw6CC13ZKpLJDM34s6mzJx1gL9b6tv
         zHZF9KqM5m6dFoLTxy/idjP1NSeP4aTevW8iwbrvii2RiPgtV5jnxUf1+MGCSjt+wHJx
         f2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+egoCjJZRtbMT1nfOKmOSW+viPFzbcoNrm7MMAEra2A=;
        b=pKxyCXfXYE9E/uDX9XV/EztUXlaBFsVixFcGBHVN3NCOIkzUZQmqw8bvdsfoi7W7gj
         s9+Jc0dh+WI1RLMqw/DUe7Vd4nFiJiwBVfNz4DzLioSLuNrQE4ZbfQ4gS32dKabs8GK1
         gWbVUluGLpfcRyCfopSUAKGWfqY57ZqXBHZwE4xCSSh+ozIts66Acq6h0+93MLpoyX6b
         iN128mHcdNwyAXyuerAmpvtq57W/3Bcv5e5z39AeTQxb5FJxz/gBsrNxhnTzacLdqUXO
         mkcHUzpEIXABmkFr3wWi+dnyE0N1tDLfT6mhOw48h3r9j3hV5UCqs5hEwYa3cJpw21Ky
         HFqg==
X-Gm-Message-State: AOAM531fJ6fK1nrJ6L8LMOmYCbZETZpvpKTYq8VBGZ5h/T5QwOFnY55e
        mk3lgBb2L/5T96yKmkhwf30=
X-Google-Smtp-Source: ABdhPJx1O7H+XE5dNCRDAQ8Dh0w2uqBTS3ve5LT0AyavlxCMU/+3BN0N9nTzSun8GxKiamWRiiiVRQ==
X-Received: by 2002:a05:6512:2211:: with SMTP id h17mr18101263lfu.584.1628521004670;
        Mon, 09 Aug 2021 07:56:44 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id y20sm10850lji.126.2021.08.09.07.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 07:56:44 -0700 (PDT)
Subject: Re: [PATCH v5] brcmfmac: firmware: Fix firmware loading
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36277b51-b647-898c-c1b4-a0e363c52b0d@gmail.com>
Date:   Mon, 9 Aug 2021 17:56:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <902984be-2c27-e6b0-247b-8d9a94c08cc4@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

09.08.2021 11:23, Arend van Spriel пишет:
> On 8/8/2021 8:05 PM, Dmitry Osipenko wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The patch that would first try the board-specific firmware
>> had a bug because the fallback would not be called: the
>> asynchronous interface is used meaning request_firmware_nowait()
>> returns 0 immediately.
>>
>> Harden the firmware loading like this:
>>
>> - If we cannot build an alt_path (like if no board_type is
>>    specified) just request the first firmware without any
>>    suffix, like in the past.
>>
>> - If the lookup of a board specific firmware fails, we get
>>    a NULL fw in the async callback, so just try again without
>>    the alt_path from a dedicated brcm_fw_request_done_alt_path
>>    callback.
>>
>> - Drop the unnecessary prototype of brcm_fw_request_done.
>>
>> - Added MODULE_FIRMWARE match for per-board SDIO bins, making
>>    userspace tools to pull all the relevant firmware files.
> The original idea was to setup the path names in
> brcmf_fw_alloc_request() function, but with the introduction of the
> board_type for NVRAM files that was abandoned and we cook up alternative
> paths. Now similar is done for the firmware files. So I would want to
> rework the code, but for now I am going with Linus's/Your fix for the
> sake of having the regression more or less quickly resolved.

Thanks, indeed it could be improved further later on.

> You reported an issue earlier where the firmware callback was called
> from the probe context causing it to hang and it is not clear to me
> whether that is fixed with this version of the patch.

It's independent minor problem that can't be easily reproduced in
practice and seems it existed for a long time. It's not fixed by this patch.
