Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145B63E1246
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhHEKKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbhHEKK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:10:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D847C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 03:10:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m9so6343827ljp.7
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nowSQTwIvjMrJLGQCHoXonlYyJagP1iBzjQYAek7DVs=;
        b=e/aiO0Bt4icpPm8iEuxXKkOAsi20JskuEOnSLD+eLZcvEd+eavU6nwr93xUqDJZXDv
         7Z/EgD2MD1pFCZAKommQKBlPW1156tm0UL45YxB39hhpSZfcIQgIJvDKTjbVDTqMUbKs
         LAH065WtHpLiD5Y6c9xyWLBQmKksYuzuCC+PJz3tRv0obo0EPXK3H9y1MgMOsuombDFv
         A06fMD0S+SRxruq9Dspd6+Xf+jPzL8opwPIBEXv0O+fI0t5xuVpA2SIHl7dx7TqF2hxZ
         WPBHkVrBPMDaC9wwMx/XBNjLdJ/tLs58t2TXErTAUhGlWxzz6UkLJNuoh8bHqqLrdce3
         5pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nowSQTwIvjMrJLGQCHoXonlYyJagP1iBzjQYAek7DVs=;
        b=jmL434DYzifJwo+pPKHOs6gys2wHvUCm+VQeXTKBu8umj5QkgN+tBIzPL0d7cUyDpr
         CqjA1vGsF+1yk8QfZPg8jKeAQr5pn8W77T6a4vFi0NI7eWhk961i0gVJHv+bkPbGQhTe
         HWx13/FfjGiyIiy5h6Q+r9+R618FCeFXebNrtH4yf/WFzjGs1a9N9RTo0Qe4T4HtB37A
         pBUelA+fs/4XGWAorqPhUW/Gwa/I4EbJYyP+G1I95WxnT91ou9qiJ48tIQKey5aVpScw
         JsZs9OkoJJWpCFPA4Rp8G9CSpL0d6uiGbACSU0hlpCkdKg6V34Gzk6rEGHPtDKG5d5Fb
         MjAQ==
X-Gm-Message-State: AOAM532DXJzghAWAI4Dt8AerZuxfmuRm7m9twl0cL4rghvE3caCfpdYT
        ZGz6LNe4+OJVHTp21QEVbZ0=
X-Google-Smtp-Source: ABdhPJynrbmgy4kOnT7WS7QMGB0ySgpXC/1ymWZ5BNVTaVdQPNIz+HorWO1QRpB3vdo6P8KWG68twg==
X-Received: by 2002:a2e:a5ca:: with SMTP id n10mr2675619ljp.62.1628158213808;
        Thu, 05 Aug 2021 03:10:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id o19sm363587ljp.129.2021.08.05.03.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:10:13 -0700 (PDT)
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
 <0f439074-83ea-087d-7eec-aa6d4d3d4689@gmail.com>
 <CACRpkdY_PrEus+DQ7PKH=1E5eMsDAS=M6ObB97TKUeP-vzeFZg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b958619-b86b-5265-0d3a-e3dd6bf47ee8@gmail.com>
Date:   Thu, 5 Aug 2021 13:10:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY_PrEus+DQ7PKH=1E5eMsDAS=M6ObB97TKUeP-vzeFZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2021 12:27, Linus Walleij пишет:
>>> +     } else {
>>> +             fwctx->tested_board_variant = true;
>>>               ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>>>                                             fwctx->dev, GFP_KERNEL, fwctx,
>>> -                                           brcmf_fw_request_done);
>>> +                                           brcmf_fw_request_done_first);
>>>       }
>>>       if (ret < 0)
>>> -             brcmf_fw_request_done(NULL, fwctx);
>>> +             brcmf_fw_request_done_first(NULL, fwctx);
>> This "else" can be replaced with:
>>
>> if (!alt_path || ret < 0)
>>         brcmf_fw_request_done(NULL, fwctx);
> Sorry I don't quite get this... both branches of the if/else clause will
> assign ret also if alt_path is set request_firmware_nowait() can return
> nonzero and then brcmf_fw_request_done() needs to get
> called?

That call will request the first->path from brcmf_fw_request_done()
since fw=NULL and fwctx->tested_board_variant=false. Hence the "else"
branch can be omitted.
