Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701926D47EB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjDCOYi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjDCOYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 10:24:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1FB10419
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 07:24:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so118004045edb.11
        for <linux-wireless@vger.kernel.org>; Mon, 03 Apr 2023 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680531853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29oRmA9CZPFaDOffDvmyGltkFrJO8PgAbbZcb5IVqWU=;
        b=WrP2yqTD21i611cjbsCwsUQqOSRcsWOaDeCFvrhBBbv1nzGRbtI07g59oE0cPhwH/F
         e+jVNzgquAr2mzMVvD0Cyx+VHj27QG5KKb6sw2/5F3LbGkbFqR3XoiBsrmrGbH1maVc8
         YvdnDKcJoZqUFZK0pwynD3maW7HQ1Hs7z1o4s1cd8/CutoPfkOuqZVGnx3xjnZDNriq1
         wmF7PX4PxbWvyysQaED4h5rKb32oFwddhRVA31KbSLe6xQvZ2gmdBW4QqA2Wq/OxzvBL
         WUVoldL3JdbKOh2mZ2uYjmmu+a4OuJMp+UKFMjKtjhcNZHkb1mV0Qv9uRnLdxEpl8v/y
         7rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29oRmA9CZPFaDOffDvmyGltkFrJO8PgAbbZcb5IVqWU=;
        b=X7jQzWsrvUqm3/HgwOnDUujGvtzHQSx4nJHC1PGdPFU4fP/2DRP5PVpmFupZX1gzcg
         UKbzXCfvhNgfR1A6XtuP7z+lcZrSvtT8z/Spl9T/cc2BcBN5ztjCKhHpINXmv8B38EJ0
         IET7K7Prmf8lntq/Y++A5/tihOXA0sB8S+OGengZVIpdoFeCWtLa9ekh8+C2sfbdJtKK
         TZV2FKeqPxcLRtWp7nF8L7VfP1Yrd6tumxTcd5tPw1z9t+DyIwqPY0HcCkOcMwtno+h3
         aIepHTVZ3jr4Tp7kZ4JvTwZg69r7r2SRfqn7xaI1fA1//Vnlw+wb5m3LMrvSxLln6mfT
         YmkQ==
X-Gm-Message-State: AAQBX9elWT0haDIx/Q624xu83Bej+x4Qp2Skbc2MXRF5IR5F/AEL1yew
        JHPdbswKikJSzS8lNPZiAUw=
X-Google-Smtp-Source: AKy350al+VX3isdUGCN4hPrHVf3CTMcN9f/wP3lfy3d20mg4ekGtNXrd84ejmae7WkkbVxOxfOW90g==
X-Received: by 2002:aa7:da4e:0:b0:4fa:a1a1:9e14 with SMTP id w14-20020aa7da4e000000b004faa1a19e14mr31016104eds.30.1680531853082;
        Mon, 03 Apr 2023 07:24:13 -0700 (PDT)
Received: from [192.168.1.15] (cable-24-135-222-102.dynamic.sbb.rs. [24.135.222.102])
        by smtp.gmail.com with ESMTPSA id q20-20020a50cc94000000b004bd6e3ed196sm4701934edi.86.2023.04.03.07.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:24:12 -0700 (PDT)
Message-ID: <8d6316ef-fd66-0b18-ca5b-bb945ebc5370@gmail.com>
Date:   Mon, 3 Apr 2023 16:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: wilc1000 kernel crash
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>, Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
 <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
 <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
 <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
 <20221216101842.jjz3glyotqbbqlk4@0002.3ffe.de>
From:   Kirill Buksha <kirbuk200@gmail.com>
In-Reply-To: <20221216101842.jjz3glyotqbbqlk4@0002.3ffe.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.12.22. 11:18, Michael Walle wrote:
> Hi,
>
> On 22/12/09 02:14, Ajay.Kathat@microchip.com wrote:
>> No progress yet. I tried to simulate the condition a few times but was 
>> unable to see the exact failure in my setup so I need to try more.
> Shouldn't it also be possible to see the issue by code reading? I've
> provided the call tree in my previous mail and my concerns regarding
> the locking. Either I'm missing something there or there is no
> locking between these threads which could cause this issue.
>
>> For the other "FW not responding" continuous logs, I got some clue. 
>> Probably, will try to send that patch first.
> Ok, let me know if you have some patches, I'm happy to test them.
>
> -michael
>
>

Hello,

I faced the same kernel oops issue. After analyzing my logs and brief
debugging, I agree with Mikhail: the problem seems to be accessing the
scan_result pointer after it has been nulled.

Regarding the solution: if there is a race between two threads (as
Michael described earlier), then I think that the locking mechanism will
be the most reliable solution. We ran into problems during
deinitialization, but driver contains two more places
(handle_scan_done() and wilc_disconnect() functions in wilc1000/hif.c),
where scan_result is set to NULL.

I use NetworkManager to manage networks and I have experienced the same
failure multiple times when switching from one WiFi network to another.
Keep in mind that switching between networks calls wilc_disconnect() and
wilc_deinit() functions and it is not yet clear which one is causing a
core dump. I think it's worth at least taking a look at these areas of
the code. What do you think?

Best regards,
Kirill Buksha.
