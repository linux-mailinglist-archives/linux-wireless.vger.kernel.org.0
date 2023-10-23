Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D897D4061
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjJWTkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJWTkQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 15:40:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F8110
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 12:40:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079fa1bbf8so5436108e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698090012; x=1698694812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knbRKCNr/48dYW/ty2/g2Bi0KtwUKr3Mfp3qta38ig0=;
        b=CkQBM7beqoxYfqa6guOltKn1NtUsbbikkNaGjqp1XUimfKkWnsOSLyXXhh8Rew0QxC
         CIp13vmkiz1hcoKRBvZxOYyyP7LRUTy63oBJls+csPGWQNfjrZ2mFvhkCSw8KbQ2T553
         hqT5XFFJjbzfj1YaHsOLJAK4GYe4mxDCUmFY1d6mx4kdQ6hjMSJdsEZYnrY4q0B/QRVm
         YrgFnCa5kdhWuNiRw0ve4F/KBXlD1nacsbhh+psqVQqyIqWZrnHVIA2E08TtsKA/R+fp
         x5aep4VnudyzQcKpCh98RbYxUxbNosaWBPyLifsAN3BTaaiqANJN7f9c9vVVU2E/oHOI
         kFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090012; x=1698694812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knbRKCNr/48dYW/ty2/g2Bi0KtwUKr3Mfp3qta38ig0=;
        b=kfzZKGvqt57A6xv2tKxIg5NI70ZIRaUjR7GinR6T1amBK1/wD+WCAIrFVfDnxySOZe
         rrJaK/hHAzhB2q+5XetFydc0IFwaa121q9pevp2kQWXGmBBYA9RFOFhxjHs5NTgj/PUB
         apC/avkqY4F0IHfZ3Z36oKZfQBbBgqxl6YJUOhZaH+VAOEOxA1P/zXnsHtYFcYMyhMvF
         ei0+bkpv3Ym5eRszuAWnU5Nrb0ZXf48g5VSiQ0k6ztv2/mxUjpuGCMmZPKqsTR3WWFXm
         pTPZN3nIS8ljkKVhuqyxHOC5M3TzSxgPxEnHJc2S3peg4UZXvNItTrVjzutApB6QiHM8
         tyyw==
X-Gm-Message-State: AOJu0YyqiQ0JWwQa74Buq0YUFz7xsATMIBzIpSmlGRu5C6epGSFypWxW
        n9ni6shcbFNZ+A==
X-Google-Smtp-Source: AGHT+IFsTkAX5wEj0PGudv6iBxKf8P3tM9Q7QxLcz13mGF2gCk9FxJiCUIGSW3hmCcDOw++xKoKmtg==
X-Received: by 2002:ac2:58e8:0:b0:505:7113:1d0f with SMTP id v8-20020ac258e8000000b0050571131d0fmr6255534lfo.13.1698090011979;
        Mon, 23 Oct 2023 12:40:11 -0700 (PDT)
Received: from [192.168.25.111] (ip-176-198-172-126.um43.pools.vodafone-ip.de. [176.198.172.126])
        by smtp.googlemail.com with ESMTPSA id e16-20020adfef10000000b0032d8354fb43sm8444701wro.76.2023.10.23.12.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 12:40:11 -0700 (PDT)
Message-ID: <bd3f17ca-9b12-4ea4-b326-370ceda7aa90@googlemail.com>
Date:   Mon, 23 Oct 2023 21:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
Content-Language: de-DE
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20231023131953.2876682-1-arnd@kernel.org>
 <20231023131953.2876682-11-arnd@kernel.org>
From:   =?UTF-8?Q?Frank_Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>
In-Reply-To: <20231023131953.2876682-11-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 23.10.23 um 15:19 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two drivers were used for the earliest "Centrino" branded Intel
> laptops during the late 32-bit Pentium-M era, roughly 2003 to 2005, which
> probably makes it the most modern platform that still uses the wireless
> extension interface instead of cfg80211. Unlike the other drivers that
> are suggested for removal, this one is still officially maintained.
>
> According to Johannes Berg, there was an effort to finish the move away
> from wext in the past, but the last evidence of this that I could find
> is from commit a3caa99e6c68f ("libipw: initiate cfg80211 API conversion
> (v2)") in 2009.
>
> Link: https://lore.kernel.org/all/87fs2fgals.fsf@kernel.org/
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Cc: Linux Wireless <ilw@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not convinced this should be in the same set of drivers as the
> rest, since this is clearly less obsolete than the other hardware
> that I would remove support for.
> ---

FYI, I'm still using this driver in my old diagnostic laptop.
I din't test recent kernels (yet), but the only issue I noticed over the 
years is that I can't connect to hidden networks (IIRC that never worked).

So I personally would be happy if the driver could remain for a while.
But I don't care too much. If noone else uses it and/or it is too hard 
to maintain - R.I.P.

