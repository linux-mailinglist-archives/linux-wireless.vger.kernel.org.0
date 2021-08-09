Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29613E490B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhHIPm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPmz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 11:42:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC4C0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 08:42:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g21so25310928edb.4
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=0zXAtQHdd07V35NiTn2+J5ezXJkaTtSBp+so832S6p0=;
        b=H++kCQmCz5iCHApjx0MUKVgncY5x9Zr8UL0BwzM6FK5eRVNlNLRkOmVAgRmKa6hVkl
         fZfo1KqLrXh/8PAQWJ32vBEpcTfgjJqSgh6U0qR+NbqVOt1rF5Y8W8JQ28f/b54vLEYy
         xYNKp6I18qT6eevA+dUuEe14R51c+iIPup7HF0Y9yBdXDtJsbB/Xspn2ByQM5FKBuoTq
         Fy1nsNzlHaIPaiLsq6PPmAL0rzs1yQlhXMfdaw13w5IMYB/886P3rK4OXn9APh9WIBb9
         dVqGPCCFKYzQCUPkMHDh/T7AMyK6ambNSG5L05VTQo5VE72GAtWMYGWSEWreVoQ+GkwZ
         Ny8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=0zXAtQHdd07V35NiTn2+J5ezXJkaTtSBp+so832S6p0=;
        b=PAorswwjTD3KxN9KyZv9daWYRqOWwwDOT60gl8TDCrDaXTXb+fYKEGsUll2ieiCkVK
         q6/OrXtvkseGoJ6WFFHOSJxdZ+cm1XK9/5yJPZWNQ5GYHnja+zaBUsWweFz9GglTVZKl
         q4Gtxw8kEyojO8n6+Ys11ZnfxRs2Kf0JRbWZZrEvjJnLhEAfnnJesEWFBi98YwmZEFdX
         dYGIevNZCk9HwQjDPgt6sCiZgmHFDLe7X8PdK/gtA/0oErugWZ1118CiuyAPEgfw3Ke4
         VKzqHQ5IEpbZK06/SwDul9AyPfcPNnG4p1C1qQ9v7cQtTw9rpp/R6bQvI0R7oHqLgJBJ
         1i7w==
X-Gm-Message-State: AOAM533LyIim0XgnaBeNBOR26kExtwsLsoeSGWc7LRUbhO1dX2RwKARi
        ZVNWR64xOX9cYtpXXg3lSi4=
X-Google-Smtp-Source: ABdhPJzEuAkRKVTP0JqEy6VDR9Ahz4SBzoqjUmVvLjSbaJgIu+OD6xQVF3ugImQZhioskcm7yvBJHg==
X-Received: by 2002:a05:6402:c1b:: with SMTP id co27mr30626089edb.147.1628523753386;
        Mon, 09 Aug 2021 08:42:33 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id g9sm8328125edl.52.2021.08.09.08.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 08:42:30 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-hsien Lin" <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        "Chung-hsien Hsu" <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>
Date:   Mon, 09 Aug 2021 17:42:29 +0200
Message-ID: <17b2b945e88.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <36277b51-b647-898c-c1b4-a0e363c52b0d@gmail.com>
References: <20210808180510.8753-1-digetx@gmail.com>
 <902984be-2c27-e6b0-247b-8d9a94c08cc4@broadcom.com>
 <36277b51-b647-898c-c1b4-a0e363c52b0d@gmail.com>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH v5] brcmfmac: firmware: Fix firmware loading
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 9, 2021 4:56:46 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> 09.08.2021 11:23, Arend van Spriel пишет:
>> On 8/8/2021 8:05 PM, Dmitry Osipenko wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> The patch that would first try the board-specific firmware
>>> had a bug because the fallback would not be called: the
>>> asynchronous interface is used meaning request_firmware_nowait()
>>> returns 0 immediately.
>>>
>>> Harden the firmware loading like this:
>>>
>>> - If we cannot build an alt_path (like if no board_type is
>>>   specified) just request the first firmware without any
>>>   suffix, like in the past.
>>>
>>> - If the lookup of a board specific firmware fails, we get
>>>   a NULL fw in the async callback, so just try again without
>>>   the alt_path from a dedicated brcm_fw_request_done_alt_path
>>>   callback.
>>>
>>> - Drop the unnecessary prototype of brcm_fw_request_done.
>>>
>>> - Added MODULE_FIRMWARE match for per-board SDIO bins, making
>>>   userspace tools to pull all the relevant firmware files.
>> The original idea was to setup the path names in
>> brcmf_fw_alloc_request() function, but with the introduction of the
>> board_type for NVRAM files that was abandoned and we cook up alternative
>> paths. Now similar is done for the firmware files. So I would want to
>> rework the code, but for now I am going with Linus's/Your fix for the
>> sake of having the regression more or less quickly resolved.
>
> Thanks, indeed it could be improved further later on.
>
>> You reported an issue earlier where the firmware callback was called
>> from the probe context causing it to hang and it is not clear to me
>> whether that is fixed with this version of the patch.
>
> It's independent minor problem that can't be easily reproduced in
> practice and seems it existed for a long time. It's not fixed by this patch.

Ok. I understand the issue and I have a fix lined up for it. I noticed my 
reviewed-by tag got lost between V2 and latest version. Feel free to add it 
back.

Regards,
Arend


