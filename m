Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC13E1204
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhHEKHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhHEKHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:07:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D4C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 03:06:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g13so9946696lfj.12
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxg+U2+cCAMSnY8gYu0zMGcksf6Zd64obD25eHmFvcM=;
        b=kCEY2vscZd3ZoZCrG4y9XjYg8lkRAnyah8cnLJ529v+PKcbnMipA7DsMo/pLjkrPf3
         KOZQ3LQqCZ3JomNs65ovANfLg9wU++iRyZg4cl2A0xF0Ry1kXUOiqLxbmdiwAKisPBf5
         aSr4eq1q5iV53tfVFyOqVZwCJZso3OEYbyL/0LORvbYlJZytuY19isRRGwgSs7WiYyIx
         jzF1OFVqB3+M6imnKVf1YgGR6untODrvu8DlKRBtaPsHqQJjQP8pAFS42STeX5Wv5sO1
         fa6+rtloIm2bxX07nrVa+m0pk9rn9MmDPpoB6unLuaIwlAGDvB+ye3KbRCHz2Jub4ua0
         Nupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxg+U2+cCAMSnY8gYu0zMGcksf6Zd64obD25eHmFvcM=;
        b=mlnwtI5kD8QY+SLzDeqf9RVVnJ8813/SR21ltufkh6s/l5gixk5eBKW1zWq+W98Jxe
         vSL1Gld1wP/gT25afhkMrbOQM63jI9ABjqlpg5K6PFv7aELtXpUUeV9raLcYS07kSpg4
         9rEZ8X2npFoQESRMEw+xcgD18n0g/IXBFOet043/pnaxCJx1evskVw6neo/zpfl7hhZl
         mm+ziG5/PgHHVcgyLFTqbEZm94EcBRG2En32UERgPfI2QsvD69wwdC2vAXdl/jvCBV48
         TLtOlOBMtBr6T5Jo4HlMVvZv0v1kfbfoAgx+y4Ztji+egA4HznUZADBhsEEG58fS2sik
         tg9A==
X-Gm-Message-State: AOAM533EA42W8XBD+apuMPT4sx7XmDZZTxJik0ebdcBFqALUpCParaI9
        WZ+igT4P22Lm7HG2Zptfl60=
X-Google-Smtp-Source: ABdhPJy2+TX7IKaOl79sSDBLlmOFCZXnUhnAUsjaX+bCFZqUn8jUEVkLWBnJggmayGIrm4n+vEvKJA==
X-Received: by 2002:ac2:57c5:: with SMTP id k5mr3178890lfo.72.1628158018412;
        Thu, 05 Aug 2021 03:06:58 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id p4sm374144ljg.2.2021.08.05.03.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:06:58 -0700 (PDT)
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
 <74e24409-aeb2-5297-6888-7af2b1126ccd@gmail.com>
 <CACRpkdam=PzCf4ojxb4ASjyPBmVM8ZDWDFXqX+BukhQ+f38J0A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a32bc17b-a895-0e8b-0f2f-bc0abe9c7efe@gmail.com>
Date:   Thu, 5 Aug 2021 13:06:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdam=PzCf4ojxb4ASjyPBmVM8ZDWDFXqX+BukhQ+f38J0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2021 12:17, Linus Walleij пишет:
> On Thu, Aug 5, 2021 at 3:35 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>> 04.08.2021 18:34, Linus Walleij пишет:
>>> +     bool tested_board_variant;
>>
>> What about s/tested/tried/?
> 
> OK that is clearer, I fix!
> 
>>> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
>>> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>>
>> Is it really worthwhile to rename this function? There is no "done_second".
> 
> It is to reflect the actual use, because it fooled me as it could
> be interpreted (intuitively) as "this is called when all firmware requests
> are done" since it doesn't specify. But that is not the case, it is
> only called when done with the first first firmware in the list.
> Hence the name change.

AFAICS, it's called for both first and when done.

> The philosophy is in line with Rusty Russell's API design hierarchy:
> http://sweng.the-davies.net/Home/rustys-api-design-manifesto

Why you can't split that function in two then?

brcmf_fw_request_done_first()
{
	if (!fw) {
		request_firmware_nowait(THIS_MODULE, true, first->path,
					fwctx->dev, GFP_KERNEL, fwctx,
					brcmf_fw_request_done);
	} else {
		brcmf_fw_request_done();
	}
}
