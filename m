Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6082C3E11CF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbhHEKCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbhHEKCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:02:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F59C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 03:01:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a7so6282630ljq.11
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDwwA9ZSvR1G7bXPVG/8yRbdzBxnn52wS0MPg0DlsMk=;
        b=VRpdP0Elzlv6VeU413ynYCANAoSnRa1t9NtdJG7MdE4RHTs7DSz3HcPSr7+QXAsiIf
         n5ckUcDXbuF3pcDxWwplwjl9ITqvRwUD90FS0FVH0ZbO1UJYlyZkO5dpfSWTx3vRcWyz
         KI5bEnePgpHNKhkiUu6vmNySlRALDrVdMTtqAAseo66Zvj/n3R+3OjlSAmrpzpt0ptuO
         Eafa0b2mzVkSEMy6Tqfml/PYXI1E6fww+H9Tcc+AHck8el4KkiXo1zEwo0MalRD5s4C8
         JlniU0HEKgwXNCO8uM6fzfw6PBC6I8FN/wQ+I8hAktGDQOknluQjIb1oXa95rjQJy6Ku
         ELvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDwwA9ZSvR1G7bXPVG/8yRbdzBxnn52wS0MPg0DlsMk=;
        b=X+ojf3yOJc6M2aNM1lodquCiJYAb4CrasEbZk/HTb0Ng9XMgQ02PhDisicHuTwoBEq
         dz9294y5JYi9IBZrmwlEwHSu1YzGl9Ax5IIhU4LU1i1DpDI0WPfIHvB77eYxk/7/gvg7
         iR1K00zkSNW4/ZRLcO3xCWWud6gMfvhuOIcDBK4CCTJm8OBZ0ZpgWxMxtE6XYYdTItDK
         Ik3gGWJxZuDKaI32g7/dxW9eQPP2UF13xnSAZz4ymEx+JgEDOhSj4cxc9oc7/jFg0Daa
         XsE6OoP29+qdzza1lQfjWgIriNLPS5ZW3ZV9Kgh+hsZZFHu//L1zNtk3/nKMqNSmo/zk
         4IzQ==
X-Gm-Message-State: AOAM531aCjghPl0U3+7tAL7+fLUfdJZeZKJQ8xysIeCPuT64T+lCJcsB
        gJfICjf4ffhudWctleHZoeY=
X-Google-Smtp-Source: ABdhPJyQBCW0BKwh0E0Qge4ILveN4Ubfcu5ZWcEpyB9NFjlaHlQhQxlLvm3ulvKsC2DqOF/KDPuzEA==
X-Received: by 2002:a2e:4801:: with SMTP id v1mr2596551lja.46.1628157705706;
        Thu, 05 Aug 2021 03:01:45 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id l13sm374543ljj.43.2021.08.05.03.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:01:45 -0700 (PDT)
Subject: Re: [PATCH v2] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210804153434.3429348-1-linus.walleij@linaro.org>
 <67ba8440-8f39-daa0-ef39-e506007fd46a@gmail.com>
 <CACRpkda+4CTeBpdFru82ekkF=PcN-5yGQtPBWuwXhE3biewoLA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4e7633d0-6e05-cddd-9a55-f73e7ff7108c@gmail.com>
Date:   Thu, 5 Aug 2021 13:01:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda+4CTeBpdFru82ekkF=PcN-5yGQtPBWuwXhE3biewoLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2021 12:14, Linus Walleij пишет:
> On Thu, Aug 5, 2021 at 3:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>> 04.08.2021 18:34, Linus Walleij пишет:
>>> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>>>  {
>>>       struct brcmf_fw *fwctx = ctx;
>>> +     struct brcmf_fw_item *first = &fwctx->req->items[0];
>>>       int ret;
>>>
>>> +     /* Something failed with the first firmware request, such as not
>>> +      * getting the per-board firmware. Retry this, now using the less
>>> +      * specific path for the first firmware item, i.e. without the board
>>> +      * suffix.
>>> +      */
>>> +     if (!fw && !fwctx->tested_board_variant) {
>>> +             fwctx->tested_board_variant = true;
>>> +             ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>>> +                                           fwctx->dev, GFP_KERNEL, fwctx,
>>> +                                           brcmf_fw_request_done_first);
>>> +             return;
>>
>> The original code was proceeding on error. Is this a typo here?
> 
> No, we are testing specifically for fw being NULL and in that case we issue
> a new request_firmware_nowait() call with ourselves as "done" callback,
> so we really need to return here.
> 
> The worker will call the same function again after this but now
> tested_board_variant is true.

The worker won't call the same function if request_firmware_nowait() fails.
