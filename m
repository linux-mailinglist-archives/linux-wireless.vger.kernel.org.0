Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F344D559
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKKK5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 05:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhKKK5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 05:57:04 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58279C061766
        for <linux-wireless@vger.kernel.org>; Thu, 11 Nov 2021 02:54:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 1so11152706ljv.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Nov 2021 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dRLHwqrTsyOcJE6upu8cYqSGo8L6w9AqKKbX0nen3sw=;
        b=wZApJBu/3B1yHkQcgDVreFJ7//jvgeJqTiRJ6+ZhbbfvOzSz67+TRphnj0F5LBuwC5
         Ue0I0Dpd+TxARhQS5XIH3awjfUV/m2BrKG96BOdWVOWtlvDKbqZ8KBcC5yUlJilKeI2U
         NpR/puDDnZY4xx3iGxHX+eCa5+iJ7HeGWKk4VqPFzvhBUh4MRJLUSSN04EI2ezansRQe
         qzL/8xQS+DNdP8XObh68b/kNBNKRMvTXySvMMraAXAnC59fLFoVFTfDLbhIU3GarrmHW
         NPzXm+gbm0AWj84uhVmdtp6KP4oGQV7uuoS03xFT48jtW1JmYMdis/gD8aYDOW4uepjF
         KBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dRLHwqrTsyOcJE6upu8cYqSGo8L6w9AqKKbX0nen3sw=;
        b=Ww+Wojb+pK16212+KRDoPt6uj3HrvcbE/rXvEaLFr4mkUTp/Wm+MsXNLF00owrkToo
         8RQZ3XkkRjfOlGBHLYrvocH6MFhftXd3MgGPnp37fizJwqIrS85AqzCSW+GzLywvFVCP
         P8TLhy6yrp0gwBly0jMS5bohbykBFwuHPAtvSP1Q42GOwOplygO73c44NNdFY/xj7rS0
         1xZPSsa50WUGgTF6Uz7ue/jfTFaoGjfSEuVCCMi07cT1SX4+Lpdt1c9rYzgBPjuQF6eZ
         2fv8xMDwn8sK+3y3pvHl4YoQVHXml18Yk+cwER/81R48AQLAMDQD3zXu1rz3wXp4dHJi
         nfPw==
X-Gm-Message-State: AOAM5314WnxLWDGBreZsl3DB0ma1L54OEgAyPAJf4WhjyE2UMidw60Xb
        osr2p08gCs4zZSZ0Q9WtRnLCgA==
X-Google-Smtp-Source: ABdhPJwbtGi5L/PvJf7+aam1+CKynLnSusufMnfQGhdyJqzPdnhEbj4xQmeUz+eV4u8InDRxUNksIw==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr6147076ljf.384.1636628053744;
        Thu, 11 Nov 2021 02:54:13 -0800 (PST)
Received: from ?IPV6:2001:9b0:218:2b00::30? ([2001:9b0:218:2b00::30])
        by smtp.googlemail.com with ESMTPSA id y1sm252858lfd.204.2021.11.11.02.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:54:13 -0800 (PST)
Message-ID: <b3b9c143-485f-5fe1-312c-c64a8ce33f8a@exuvo.se>
Date:   Thu, 11 Nov 2021 11:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: rt2x00 regression
Content-Language: en-US
To:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
 <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
 <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
 <20211109073127.ga109212@wp.pl> <20211109120737.ga120005@wp.pl>
 <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
 <cc85b4e8a038417b865069c6578acf50@grupawp.pl> <87wnlgo5rp.fsf@codeaurora.org>
 <20211110080141.GA123566@wp.pl>
From:   Exuvo <exuvo@exuvo.se>
In-Reply-To: <20211110080141.GA123566@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes that patch works :D

Anton "exuvo" Olsson
    exuvo@exuvo.se

On 2021-11-10 09:01, Stanislaw Gruszka wrote:
> On Wed, Nov 10, 2021 at 08:59:22AM +0200, Kalle Valo wrote:
>> Stanisław Gruszka <stf_xl@wp.pl> writes:
>>
>>> Dnia 9 listopada 2021 16:22 Exuvo <exuvo@exuvo.se> napisał(a):
>>>
>>>   Just tested it and it passes the rt2x00lib_load_firmware but still errors on
>>>   rt2800usb_set_device_state:
>>>
>>> <snip>
>>>
>>>   @@ -30,7 +30,8 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
>>>     else
>>>     rt2x00dev->num_proto_errs = 0;
>>>    
>>>   - if (rt2x00dev->num_proto_errs > 3)
>>>   + if (rt2x00dev->num_proto_errs > 3 &&
>>>   +    !test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
>>>     return true;
>>>    
>>>     return false;
>>>
>>> Sorry, I screwed logic in my patch. It should be test_bit() instead of !test_bit().
>>> And also we should not count when device did not start. So patch should be somewhat different. I'll
>>> send tomorrow hopefully better patch.
>> No HTML, please :) I'll reply so that lists see your email.
> Eh, I sent from my phone to give quick update, did not realize
> it send in HTML.
>
> Anyway, below is updated patch. I hope it will work correctly now.
>
> Regards
> Stanislaw
>
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index e4473a551241..74c3d8cb3100 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -25,6 +25,9 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
>   	if (status == -ENODEV || status == -ENOENT)
>   		return true;
>   
> +	if (!test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
> +		return false;
> +
>   	if (status == -EPROTO || status == -ETIMEDOUT)
>   		rt2x00dev->num_proto_errs++;
>   	else
>
>
