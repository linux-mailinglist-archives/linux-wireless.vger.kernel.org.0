Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4507330F9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFPMRi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbjFPMRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:17:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357AD30C6
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:17:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6667643e4b3so584804b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686917853; x=1689509853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi99fLv6YTyMW2x91KoXyXg12oz007UXSsco3xPyJqk=;
        b=DcIdfxzZPOT+L/X+mX1Ag6TQ4aH81opJIeSvVK0KbGWQHG8W5Akhhld1e3YmUK2/N/
         zZ0A7wpkemxlvcTP2QSZEI/Ki5ZncxH9V/jF2lJwCKYHjQ7r2lfwZOa+HY/XMs6ClM5D
         ccBVysx8qZfMCCSl/PjtAfu/8wek+WavKvpw2juh/4IXyZkYjnl16fhUOtYsYifdpRRv
         ZRF0Fdv1S1Hw6J5f69BbBHmmXkwsMRaqNYR2QMyU9/RwgFfhoDG6huk+/1LKOg6yTbup
         t9CY+WpNbn61Hye0+nXsqaN+PMAR7/yQf/0OlfZ7WKrt0SN3FEgUknzMp+rpev6Q6wLn
         p0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917853; x=1689509853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi99fLv6YTyMW2x91KoXyXg12oz007UXSsco3xPyJqk=;
        b=AAJHPXV54VCprbtzZ/CM6DzVZLilPrBXtkL57PWocTp02ZpCbmUjwT0ENSPEDDWPmW
         pgObwOvXXmtmJ1x96qrfZ4A/6a6naEM3zX2yJwQWk4fy/7GMZ2MZX8TBYtQ0kC3RGila
         6krD12LJ81cOgxmrtCkZWc4TJzBFVxwj9Z7TvJVSluC6hMBhvBqIJ79dApgFW1GY40zz
         NLqdCTCRYlTc2MTzEdY8oiRquQhEd2nnRgfn7jM9pTmnwOukcgi5r4Ff1Chjlz2A08qN
         mSOEIIhQgYvNSGp4p7x6L8Hi2c0XzbJnBXx/yFsNSEZK5mpO6O4Vp9PnYYL/S0QQd4de
         iAbA==
X-Gm-Message-State: AC+VfDxZ66ICHY2ONRyWA9IZ1RxjfR0vdWhpvd+bETmFweIkvHcmHk/Y
        3lJJcxbZ8TBKzzm/stU1+Ug=
X-Google-Smtp-Source: ACHHUZ4wHk1/pTm81xVV98FexsQMvN1MHJuEClbfKfoLcAp1FqqCs64b9SADoV/jkPg4TDoNOCljhA==
X-Received: by 2002:a05:6a00:13a9:b0:65c:8195:e6a2 with SMTP id t41-20020a056a0013a900b0065c8195e6a2mr2310658pfg.1.1686917853598;
        Fri, 16 Jun 2023 05:17:33 -0700 (PDT)
Received: from [192.168.0.103] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b0064ff855751fsm13397014pff.4.2023.06.16.05.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:17:33 -0700 (PDT)
Message-ID: <b33d3dd1-9765-c90e-4408-941e7d8025cf@gmail.com>
Date:   Fri, 16 Jun 2023 19:17:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Nicolas Escande <nico.escande@gmail.com>, nbd@nbd.name,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse> <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
 <50f7f64c-fe32-4362-fd4e-89ee99c4f581@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <50f7f64c-fe32-4362-fd4e-89ee99c4f581@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/16/23 16:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 16.06.23 09:45, Nicolas Escande wrote:
>> On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 10.06.23 08:44, Bagas Sanjaya wrote:
>>>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
> 
>>> Hmmm, Felix did not reply. But let's ignore that for now.
>> I haven't seen mails from felix on the list for a few days, I'm guessing he's
>> unavailable for now but I'll hapilly wait.
> 
> Okay.
> 
>>> Nicolas, I noticed there are a few patches in next that refer to the
>>> culprit. Might be worth giving this series a try:
>>> https://lore.kernel.org/all/20230314095956.62085-1-nbd@nbd.name/
>> Well this series already landed in 6.4 and that is the version I did my initial
>> testing with. So no luck there.
> 
> What? Ohh, sorry for the noise, I had missed that they were in mainline
> already.
> 

Hi Thorsten,

Should this be removed from tracking as inconclusive?

-- 
An old man doll... just what I always wanted! - Clara

