Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4663896C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYMLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKYMK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 07:10:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102042196
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 04:10:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so6588950lfi.7
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwheS7W3PJSUlRY8b47wc0KETioQqU6W+QumFAOe5GA=;
        b=Ie4PK9vVTrfbphdAEVAsnpNCCVym61AlASjuuKkW3Airp2tY5blaHGxlNXSh9vrMs4
         SL3Ei4Kd7oEwHXIBW7eCV6ojFK4QoAq1BryS07BKqcjxb8Rq9tvW5Xo3r9QyMDF9tEJR
         H4XgGtewIWdY4AXNJ7Kxunfv3U1xWSZxnwbSlNKWVwbHPS6vAj4YV6tfrXJ2ndfkjRQg
         CFEcUY61ni9v3BwNcBOUPYklByQ7CpkD2jx09+MrD9GsW+je4D0MLJM7nM6vTgvX+/Lt
         TGs8sDsi+W2zKCRJgn0RmC9HZInzq0gjEKBSkhdr/kwNId44yIkVn4Eos3WFaOjino6B
         C3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwheS7W3PJSUlRY8b47wc0KETioQqU6W+QumFAOe5GA=;
        b=veUu5FVGwv/G6PxOrMNR7km+xAGXWvbdQR0HtBo5QOeCiGtdQ/Lsk+qfyTywwu/tCu
         oFtY6st0EolhvEWT5dzrLnbqmwdcU9s4l2kdpAHdB6cIhGZWLMyMjv1RNXujHkbDGs0p
         n7Dpp0zoeqKyIB0OwkM1V2Janzl1cmJfm7hVr2mC5i+XbRxyXVlkgTSoBfI70by+LjF6
         onKlNfTUEg4Tm8d4yePJQRxH/KUyXjJksJcqUxUfzylVVBbreC1yrnFJh1NjjhREjVZL
         CMfig3Ivkjb9VOTYd7ywZCRa3gujdhYC5Y+71x/mnJXF9DwTqmsmjRM4VWb2+GdrYzMT
         aJfg==
X-Gm-Message-State: ANoB5pnHdEpbYgoXszdcBIOYMUxLYU/tZUdeV4Sp6j9ZtVt08Z4khnvP
        GfAkQ/k/qj6+I27NJfHYeTo1cw==
X-Google-Smtp-Source: AA0mqf68tOvuTcSzyAPy6oW4Sx+ZczsMO12qtp1bc9Pp+m0Ch6uGXznDzBePxRQy+8SCkSWGbeTijg==
X-Received: by 2002:a05:6512:1184:b0:4af:a588:e8bd with SMTP id g4-20020a056512118400b004afa588e8bdmr12064931lfr.173.1669378256311;
        Fri, 25 Nov 2022 04:10:56 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id b23-20020ac247f7000000b004aa95889063sm509219lfp.43.2022.11.25.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:10:55 -0800 (PST)
Message-ID: <fc2812b1-db96-caa6-2ecb-c5bb2c33246a@linaro.org>
Date:   Fri, 25 Nov 2022 13:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] brcmfmac: Add support for BCM43596 PCIe Wi-Fi
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>,
        Hector Martin <marcan@marcan.st>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "martin.botka@somainline.org" <martin.botka@somainline.org>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "jamipkettunen@somainline.org" <jamipkettunen@somainline.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        "Zhao, Jiaqing" <jiaqing.zhao@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Soon Tak Lee <soontak.lee@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220921001630.56765-1-konrad.dybcio@somainline.org>
 <83b90478-3974-28e6-cf13-35fc4f62e0db@marcan.st>
 <13b8c67c-399c-d1a6-4929-61aea27aa57d@somainline.org>
 <0e65a8b2-0827-af1e-602c-76d9450e3d11@marcan.st>
 <7fd077c5-83f8-02e2-03c1-900a47f05dc1@somainline.org>
 <CACRpkda3uryD6TOEaTi3pPX5No40LBWoyHR4VcEuKw4iYT0dqA@mail.gmail.com>
 <20220922133056.eo26da4npkg6bpf2@bang-olufsen.dk> <87sfke32pc.fsf@kernel.org>
 <4592f87a-bb61-1c28-13f0-d041a6e7d3bf@linaro.org>
 <CACRpkdax-3VVDd29iH51mfumakqM7jyEc8Pbb=AQwAgp2WsqFQ@mail.gmail.com>
 <d03bd4d4-e4ef-681b-b4a5-02822e1eee75@linaro.org> <87fse76yig.fsf@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <87fse76yig.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 25.11.2022 12:53, Kalle Valo wrote:
> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
> 
>> On 21.11.2022 14:56, Linus Walleij wrote:
>>> On Fri, Nov 18, 2022 at 5:47 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>>> I can think of a couple of hacky ways to force use of 43596 fw, but I
>>>> don't think any would be really upstreamable..
>>>
>>> If it is only known to affect the Sony Xperias mentioned then
>>> a thing such as:
>>>
>>> if (of_machine_is_compatible("sony,xyz") ||
>>>     of_machine_is_compatible("sony,zzz")... ) {
>>>    // Enforce FW version
>>> }
>>>
>>> would be completely acceptable in my book. It hammers the
>>> problem from the top instead of trying to figure out itsy witsy
>>> details about firmware revisions.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> Actually, I think I came up with a better approach by pulling a page
>> out of Asahi folks' book - please take a look and tell me what you
>> think about this:
>>
>> [1]
>> https://github.com/SoMainline/linux/commit/4b6fccc995cd79109b0dae4e4ab2e48db97695e7
>> [2]
>> https://github.com/SoMainline/linux/commit/e3ea1dc739634f734104f37fdbed046873921af7
> 
> Instead of a directory path ("brcm/brcmfmac43596-pcie") why not provide
> just the chipset name ("brcmfmac43596-pcie")? IMHO it's unnecessary to
> have directory names in Device Tree.
I think it's common practice to include a full $FIRMWARE_DIR-relative
path when specifying firmware in DT, though here I left out the board
name bit as that's assigned dynamically anyway. That said, if you don't
like it, I can change it.

Konrad
> 
