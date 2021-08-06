Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D93E2DE8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhHFPqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbhHFPqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 11:46:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1793C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 08:45:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u3so18742589lff.9
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G1s0SmGB6SLLAExqdCsWoJrk/+ubF5ahJAwxSO8mdu8=;
        b=Jtl+du7vMxwHHrZvdoXe5IVzWW4RjC/qJaWgyuJMai3aP7ZE1WkTpJlWq7zV55tRjD
         AE3YNAr0oBHZ9TWurYCE7OBgKcCJM+JNR4qIBxEsnFuEhQbb1Z3rIsUJriZ4SmkDHFXG
         3tT6TJYh7gefNFMYUInz4dYxynn1yNLd7FVsFuE3JmRb7dkA9MSneTvQdF60/J2CZesv
         WTH4/M+1Aevzv314TbyHoCag+JnSnDkRkSniaGeyyy3ZCQ0MU0a9z+TWfoUz20Cegrb2
         ldVk0EeDpKIxOQmk3EL5Gxl8D3RoV8oa8HL2Ojs5Op4ATGNPCLBTsXSVhmqDL+ouXbvZ
         q5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1s0SmGB6SLLAExqdCsWoJrk/+ubF5ahJAwxSO8mdu8=;
        b=IDN4KBYL0aKfCmeUaGbjskR6paz+Rrno5uLwHKBb+FQ70YD08GaiwarGRsL3UeN48H
         R3kuqPyGIUj9K4tLzkluyfL0uxzGx5lZiagV/odhRUe6WLc5IODbv9LUC6SbeDLS4EoG
         jWSZipmmH3s7+gxgosVuLkCNQL7swle5driBOHubHFM1gbyQGY5nsWAlNEHbcJH0iAiI
         n/is1qLTjxoyzrfJI6O0h6OTL5bKbhaMXWLhe5INV6hzvtVkk8hixE8cvcxD+JgmVTBe
         wgM4ppHL/RH2oRYTac0PJNvwJZW9qaU7Hdj/DB6oWIqmjPPrifXCuNsZ8LKg5ns9QSLY
         4HBA==
X-Gm-Message-State: AOAM530ujYDLN3i4/lsvdNyiZhNEtM5bI3/XkICwmGnSvnyN5unwx0v+
        gcSbrHaS3y1UPqyVTnl/XqA=
X-Google-Smtp-Source: ABdhPJxaRoxS4oE8TmirhnP5oTHCPIeUuQvc0nCcjYkIwVOa6OR4QwJgc8periZyVZPbcUJJ80epfA==
X-Received: by 2002:a19:e21e:: with SMTP id z30mr1527705lfg.579.1628264758124;
        Fri, 06 Aug 2021 08:45:58 -0700 (PDT)
Received: from [192.168.2.145] (46-138-20-31.dynamic.spd-mgts.ru. [46.138.20.31])
        by smtp.googlemail.com with ESMTPSA id h13sm716751ljc.37.2021.08.06.08.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 08:45:57 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
To:     Arend van Spriel <aspriel@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210805093023.3465081-1-linus.walleij@linaro.org>
 <CAJ65rDx1ab8gBZRpnyp5kb__VVA+_Vy3VS-0xesYC_+VmEKchw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d8a1d349-91ee-9ab5-6706-91090082d7f4@gmail.com>
Date:   Fri, 6 Aug 2021 18:45:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ65rDx1ab8gBZRpnyp5kb__VVA+_Vy3VS-0xesYC_+VmEKchw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2021 14:35, Arend van Spriel пишет:
> On Thu, Aug 5, 2021 at 11:32 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> The patch that would first try the board-specific firmware
>> had a bug because the fallback would not be called: the
>> asynchronous interface is used meaning request_firmware_nowait()
>> returns 0 immediately.
>>
>> Harden the firmware loading like this:
>>
>> - If we cannot build an alt_path (like if no board_type is
>>   specified) just request the first firmware without any
>>   suffix, like in the past.
>>
>> - If the lookup of a board specific firmware fails, we get
>>   a NULL fw in the async callback, so just try again without
>>   the alt_path. Use a context state variable to check that
>>   we do not try this indefinitely.
>>
>> - Rename the brcm_fw_request_done to brcm_fw_request_done_first
>>   reflecting the fact that this callback is only used for the
>>   first (main) firmware file, and drop the unnecessary
>>   prototype.
> 
> While implementing the firmware.c module at first I was doing every
> firmware request with the 'nowait' variant hence the callback was used
> repeatedly. However, I abandoned that as the reason for async request
> was to avoid delay it may cause on kernel boot. Decoupling the initial
> firmware request was sufficient for that and simplified things quite a
> bit. As to the naming maybe 'brcmf_fw_async_request_done()' is a clear
> alternative.
> 
>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
>> Cc: Dmitry Osipenko <digetx@gmail.com>
>> Cc: Stefan Hansson <newbyte@disroot.org>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v2->v3:
>> - Rename state variable to "tried_board_variant".
>> ChangeLog v1->v2:
>> - Instead of using a static variable, add a context variable
>>   "tested_board_variant"
>> - Collect Arend's review tag.
>> - Collect Tested-by from Dmitry.
>> ---
>>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 31 +++++++++++++------
>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> index adfdfc654b10..d32491fd74fe 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> @@ -428,11 +428,10 @@ struct brcmf_fw {
>>         struct device *dev;
>>         struct brcmf_fw_request *req;
>>         u32 curpos;
>> +       bool tried_board_variant;
>>         void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
>>  };
>>
>> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
>> -
>>  #ifdef CONFIG_EFI
>>  /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
>>   * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
>> @@ -638,11 +637,25 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>>         return request_firmware(fw, cur->path, fwctx->dev);
>>  }
>>
>> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
>> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>>  {
>>         struct brcmf_fw *fwctx = ctx;
>> +       struct brcmf_fw_item *first = &fwctx->req->items[0];
>>         int ret;
>>
>> +       /* Something failed with the first firmware request, such as not
>> +        * getting the per-board firmware. Retry this, now using the less
>> +        * specific path for the first firmware item, i.e. without the board
>> +        * suffix.
>> +        */
>> +       if (!fw && !fwctx->tried_board_variant) {
>> +               fwctx->tried_board_variant = true;
>> +               ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>> +                                             fwctx->dev, GFP_KERNEL, fwctx,
>> +                                             brcmf_fw_request_done_first);
>> +               return;
>> +       }
>> +
> 
> So here we could use the synchronous variant instead for the reason
> explained earlier.

The blocking variant doesn't work as-is, it locks up the probe.
