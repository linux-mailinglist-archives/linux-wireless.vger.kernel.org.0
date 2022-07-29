Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6E584E25
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiG2Jir (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiG2Jiq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 05:38:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71D4F674
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 02:38:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so7550441ejr.5
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/ihBcPf8ekOmNH8kJREtxReVH3CGAUHro+nyW2sYDV8=;
        b=g8y96oA7GC1kdSBt3Z3VVnwZH5fnYLX2Inwo47Ne0T0DOqsGu5smHRxCnJw/C6/4hj
         mgatE0hmV+zWeJea/8Y4BxrGFMzAuSW1x0l7rDIHZ04EeUjcWPSYUWfPICWkeASW6rZv
         Hhut+57qbb6FJUwkrT59I3avN93oZBmCF2QRK8TmNQV7y0D05AwCHVxjEwzUwPMQBHIa
         ZwxcGtPbzlw50TqYBWXzmv2umyzpeP1f+I3U4VXed28NZrmN12783PpIgdpfpTLNGSy4
         b4uzTOKK5CD8RS6eO6yzOHQst62DF3Q4aNtc3tODgWCnsN52rolkrbPZFvIF1gwyfoba
         T8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ihBcPf8ekOmNH8kJREtxReVH3CGAUHro+nyW2sYDV8=;
        b=tDPtf9oGpBlDr9nWfq2w0wg3BKcTv6jL07Que8tZqXAiRn1v40vp82Xt3b86lvrK4R
         nu2ggC58DUR7FQ6KKtlSAUhyEoeVFjgJzcgQT7yg/JEj6eqR8cvkMyJegPj5Go3ZWHYx
         uJrkFXkIn6IfpekslWGgdIDZniZrY7gq/xp3yDk1tmyM7LVcdvIfr7crhPG2iGeu/QVZ
         zV0gft0JJKx9NNdbm8CVeUsMg+/MjM68nCT2r/vj8ulQGB/Nf0dbR/gUAou7ytSBIZSt
         DgM0Ek7gphAYfkIpQjdnDAeY6bQlo3umy9o1RWCqHYiS8ilmOy9AnCpRTpPilT5Wm4Hc
         rkiQ==
X-Gm-Message-State: AJIora8drxjQYGVi8vMqi/O6uYJWMDMJnU8dshLF9DKWlxKybCJAtZvm
        sZJ7CyzGrGR8XSikukFpaxI0VFqlH4Y=
X-Google-Smtp-Source: AGRyM1vrZjUEWu/JTvNYUrGdQvoZqgucY5s9XM8W0YZM4Vb0OwJL/Z5jphrKoZ2TS9xhdAAfg/y3cQ==
X-Received: by 2002:a17:907:2807:b0:72b:4530:29d5 with SMTP id eb7-20020a170907280700b0072b453029d5mr2323543ejc.69.1659087523574;
        Fri, 29 Jul 2022 02:38:43 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b00722dcb4629bsm1481412ejo.14.2022.07.29.02.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 02:38:42 -0700 (PDT)
Message-ID: <a88a130f-dc5d-e3d0-b707-dea4df14a48a@gmail.com>
Date:   Fri, 29 Jul 2022 11:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] brcmfmac: introduce BRCMFMAC exported symbols
 namespace
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
 <CAJ65rDwMzF8hhuykrikSdsPMgy4GhLkTUfqTfn-cbHwCL5OE2Q@mail.gmail.com>
 <87fsilo9so.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87fsilo9so.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/28/2022 11:39 AM, Kalle Valo wrote:
> aspriel@gmail.com writes:
> 
>> Instead of using EXPORT_SYMBOL() use namespace variant and only if
>> build vendor-specific code as separate module.
> 
> The commit log should always answer to the question "why?".

Let me try:

Exported symbols are usable from any kernel module. Using the namespace 
variant requires the caller to explicitly import the symbols. This makes 
it more clear that these are only intended to be used by brcmfmac 
driver. When vendor-support is built-in there is no reason to export the
symbols at all.

If the above is acceptable I will use that when resending the patch series.

Regards,
Arend
