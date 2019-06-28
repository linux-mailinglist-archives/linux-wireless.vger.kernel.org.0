Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4032159E63
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF1PET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 11:04:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45417 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1PES (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 11:04:18 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so13112934ioc.12
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2019 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1IzoFsZk5LqS2cRTEBVCjz3mGbTcz0MMJeXo87+63Y=;
        b=MvNSFWpzsxFk5AIIkgaYDKXyzPk9/PdAzXLETkZQRaEZNrrn0vJ5XRQ5uKEwAvKaxl
         3qfYCTNQ0+MZYbbxx+5z8j/jY7b2vw2ufX1y4uSh9wloSEW5WHlDzz7n/lyyCM8jlcKC
         PQnUQb1C9oKq3eCZBErmQTCpb/YoV6paGj5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1IzoFsZk5LqS2cRTEBVCjz3mGbTcz0MMJeXo87+63Y=;
        b=umjoi2UWsQKujk2Wwb2/uBZ1bpO7ll8SI99RbYHvX3IEgXazXeHJtojHw3f+0EW7cU
         Z+quiDdezTFNnglSksScsCo87e25VdVfAidgBogp+9GxprtSaEf7Gxay4+xBB4luoolu
         v/PspCzOnnDqaOHOnmG14YZLsivi81MKiP2e/dFTQXJAPYoI9I/ydDpwHdqCihAdK4GC
         +RrY58dg196rzv9BeNt3YFYFW/4Y+N4J/R1ZL0E2MGt3PmTvB97vxxzHo1j1j5vq3B5y
         kiuB7tgASKUU2RtRJo85Kg3LU34b6NfV9Eu0Ht5K2ktZP9uZEFfcf1jarw7mzvGQ5jUb
         W8tQ==
X-Gm-Message-State: APjAAAXmGUVohV0aONp/i3vnagd/Ql7gv9vC7r3OeWgz8UCuq85EIY1K
        Mpnq9HWP2V4+/0d8njTH7oXFPA==
X-Google-Smtp-Source: APXvYqymBA+yRdMC+IAMhiuSMnvDgZNtIJg/DM/UGr3vhxnQF81pj8UzRIlvdsQNe/Pn6XZ7mdgZVg==
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr696097ioi.51.1561734258040;
        Fri, 28 Jun 2019 08:04:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j23sm2401337ioo.6.2019.06.28.08.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:04:17 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior
 in bit shift
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
 <20190627032532.18374-4-c0d1n61at3@gmail.com>
 <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
 <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e17c585-bd42-8c65-a37a-add6aa4d5ca4@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 09:04:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/28/19 7:57 AM, Johannes Berg wrote:
> On Wed, 2019-06-26 at 21:34 -0600, Shuah Khan wrote:
>> On 6/26/19 9:25 PM, Jiunn Chang wrote:
>>> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
>>> significant bit to unsigned.
>>>
>>> Changes included in v2:
>>>     - use subsystem specific subject lines
>>>     - CC required mailing lists
>>>
>>> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
>>> ---
>>
>> Move version change lines here. They don't belong in the commit log.
> 
> FWIW, in many cases people (maintainers) now *do* want them in the
> commit log. Here, they're just editorial, so agree, but if real
> technical changes were made due to reviews, they can indeed be useful.
> 
> johannes
> 

I went looking in the git log. Looks like there are several commits with
"Changes since" included in the commit log. It still appears to be
maintainer preference. Probably from networking and networking related
areas - wireless being one of them. This trend is recent it appears in
any case.

There is a value to seeing changes as the work evolves. However, there
is the concern that how log should it be.

This example commit has history from RFC stage and no doubt very useful
since this is a new driver.

8ef988b914bd449458eb2174febb67b0f137b33c

If we make this more of a norm, we do want to make sure, we evolve
from informal nature of these "Changes since", to "Commit log" text.

thanks,
-- Shuah
