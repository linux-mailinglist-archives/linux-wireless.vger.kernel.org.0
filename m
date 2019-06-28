Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34759EDA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfF1P1d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 11:27:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46722 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1P1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 11:27:33 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so13259559iol.13
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2019 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/jz6Q/942agKzdj96ybCaGF6RRB8/S8+u0X7TG8WqE=;
        b=V5rMYjAjAfqXrbDJIcFjdPalPLC99G4tV54G0KNrYd1ipKSEvMFqO5yWJCWN9mIyum
         nBcPVDbTCwu6acmmEm3EknYZHvcv7cQeulEKT/upNL3pB6px78xAJYm/OXrTTlz8i3wi
         f66oAlNagQJKmBqSb/29XkoC3kaEvBAN2gsjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/jz6Q/942agKzdj96ybCaGF6RRB8/S8+u0X7TG8WqE=;
        b=UYEUKGH5zYtDcIvItVlWUExH7EDCi3GOFTgGrFjrM2k27CBpNm7uz+awLXAbhUuwOv
         r3lgMpzddNx2V29CANz1z88zVflCjjMa3S9SBk0LO+/pNe5pV3pgJ/jELVJy7iC8siZp
         hwc8YQP9nDbCJEFXbA5bEIUJKJkvrcWjtswTXHnmEKZAELZON2rP2jO9JBiHhQ4Shg7H
         NIK0e2rWviTXnXw2n1+dLNmDYM9X7ATL+QiirsoAnY/D35UOqyBb/9g0PRdDnvsgaOLy
         GHdYYSBWVAnh9GM3yItyDmmM2G9Vvl6wpONhdIUkwTy0EldO9G2bffXdvY6OgR9xcwf/
         u4Uw==
X-Gm-Message-State: APjAAAXH7qUo1F8Tf+mnb8tM10PBGNZYv432HC5amvCqYkaRhpmuZZPu
        LE8ZiEOKR24DM/wjTKcqDK7ncg==
X-Google-Smtp-Source: APXvYqwVISoDJh0Gbzk7SaySQknFBIaoBQ0NwyzjcIEVlByAI+tNhfrPdERMI1UDmAKtJRjn1SQbpg==
X-Received: by 2002:a6b:cb07:: with SMTP id b7mr11204147iog.7.1561735652685;
        Fri, 28 Jun 2019 08:27:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm2245909ioi.72.2019.06.28.08.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:27:32 -0700 (PDT)
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
 <9e17c585-bd42-8c65-a37a-add6aa4d5ca4@linuxfoundation.org>
 <b5a247aa3bb21094c0a6ef1d8e3281d701bb6200.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <551305fd-bb35-7f9d-0243-ada0a8400074@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 09:27:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <b5a247aa3bb21094c0a6ef1d8e3281d701bb6200.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/28/19 9:17 AM, Johannes Berg wrote:
> Hi Shuah,
> 
>> I went looking in the git log. Looks like there are several commits with
>> "Changes since" included in the commit log. It still appears to be
>> maintainer preference. Probably from networking and networking related
>> areas - wireless being one of them. This trend is recent it appears in
>> any case.
> 
> Yeah. I was really just observing that I'd seen this, and some people (I
> guess 'many' was an exaggeration) actively request it to be in the
> commit log. I "grew up" with "changelog after ---" too ;-)
> 
>> There is a value to seeing changes as the work evolves. However, there
>> is the concern that how log should it be.
> 
> That doesn't parse, what did you mean?

Say we are on version 16 of a patch series, when does the commit log
become too long to be useful?

> 
>> This example commit has history from RFC stage and no doubt very useful
>> since this is a new driver.
>>
>> 8ef988b914bd449458eb2174febb67b0f137b33c
>>

This commit has a very long commit log starting from RFC stage. It is
very informative.

>> If we make this more of a norm, we do want to make sure, we evolve
>> from informal nature of these "Changes since", to "Commit log" text.
> 
> Not sure it's really worth it, but I guess some recommendations could be
> useful. If it is indeed to become the norm, and there aren't some people
> who strongly feel it should *not* be included.
> 

Yeah. If it becomes a norm, we probably will have to set some limits how
long, and reads like part of the commit log as opposed to something
slapped on at the end.

thanks,
-- Shuah
