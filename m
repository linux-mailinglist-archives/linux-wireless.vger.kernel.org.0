Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5348892C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jan 2022 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiAIMAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jan 2022 07:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiAIMAh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jan 2022 07:00:37 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD4C06173F
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jan 2022 04:00:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 30so40491760edv.3
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jan 2022 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:date:message-id:in-reply-to:references:user-agent:subject
         :mime-version:content-transfer-encoding;
        bh=poUgC5wKRDFbB2X+5xZYyIxQ2hN/TiHg2QZl46PgYUI=;
        b=a+o2YFGPzTgBkanAK4XXWl1I/BbokDrY2UcZTekKOfb1983MsBPjDys8L2IfRn2hzu
         aI5cQ7maW8fqKKmERL1sS9EPJG+F4Y0VvfGqenR/iSfQ8eXmmOJMprN0RWegQ3DoZy/W
         tJMk7P0AR+5bZfMFixG/ijNISTst+rozgnEVihgBSpLmEXlrkZg9bLCVSZisZfNnadMT
         DjcbeMhV2dUKTBrYQQ0HHpmYnOO/VYRNO+znGsGu+83vwrlRW0UI9VHoAtT41Rs0FD+x
         uQbMpSQxVThSxGHc55lzrGX2OHJ91q4JGkDdc3GA3O5KpFY3L3V2tmjdXaGSeJNZ+/M7
         7eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:date:message-id:in-reply-to:references
         :user-agent:subject:mime-version:content-transfer-encoding;
        bh=poUgC5wKRDFbB2X+5xZYyIxQ2hN/TiHg2QZl46PgYUI=;
        b=i6yOYlS+6zElmZQGn0ufTwNCOPZjo4EZMUyZVERlxNf7gkReH9VKKQuxCWvaVjFB6V
         CNy1HulU3VwCguJIj6bWb2lBWHsyBLKLWHv/I8zUBKjIe3oE7MI4lKtQR/+knsTyHmU8
         u8JlEFEycUf3H53/LlKcAouwPvPzwkNeYcUZtYFE4HxqLk1Uiox8pT/QqMIpzeUrbrOR
         l0SNiEztYJrcqD4VhWUZH85upTF35RWkXXuJx3ZFAAl8qhd2KN4ndDxC211Xr08koT5H
         WAs89CkJIKZT1U9rZrkvOKz5Lzk0i0mW+Ku11/IimPrvXrx/ixWms0ONjhrgnf6d/oF1
         VHPQ==
X-Gm-Message-State: AOAM530D8/T3xn06iJuUpBU0P8yACaKITkuLolcgamD/wrHhIa9ojkui
        EWxck6K9q/KWARqdSsQwjEY=
X-Google-Smtp-Source: ABdhPJzYTxEFuzfBHKuxkqcrWSz77CXk9qRDFaUsgMYQenaTrNprXF1roV3hOl/O+7dmXrtov3hHQQ==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr11831633eju.173.1641729635512;
        Sun, 09 Jan 2022 04:00:35 -0800 (PST)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id w11sm1940351edd.21.2022.01.09.04.00.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 04:00:34 -0800 (PST)
From:   Arend van Spriel <aspriel@gmail.com>
To:     James Prestwood <prestwoj@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
Date:   Sun, 09 Jan 2022 13:00:34 +0100
Message-ID: <17e3eb62ed0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <58ebff51d64d1ae6b01d85cff7bb9e137e19848a.camel@gmail.com>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
 <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
 <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
 <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
 <58ebff51d64d1ae6b01d85cff7bb9e137e19848a.camel@gmail.com>
User-Agent: AquaMail/1.33.0 (build: 103300102)
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On January 8, 2022 12:31:19 AM James Prestwood <prestwoj@gmail.com> wrote:

> On Thu, 2022-01-06 at 23:01 +0100, Johannes Berg wrote:
>> Hi Preston,
>>
>> Ugh, sorry. I'm way behind on a whole bunch of emails (about 4 dozen
>> to
>> be honest) ... trying to catch up, but only so many hours a day.
>
> No worries, thanks for getting to it :)
>
>>

[...]

>
>>
>> At which point it's probably not really worth it? Emulating it in the
>> driver by repeatedly issuing time events also seems like a bad idea,
>> worse even than doing it in the application, since the application
>> could
>> at least try to synchronise it a bit with whatever it needs to be
>> doing,
>> whereas the driver can't do that at all.
>
> If this is the case then sure, its just offloading the same nasty
> procedure into the driver/FW. You know more than me about this topic
> but I'm still trying to understand how this would differ much from AP
> mode?
>
> In my own mind I see SET_CHANNEL doing the same thing as START_AP, just
> without sending out beacons/probes and the iftype being station. Maybe
> this is an oversimplifation but it seems like the FW/driver *can* sit
> on channel without some time constraint if it supports AP mode.

Even if it only supports STA mode it can. The constraint being that it is 
not associated (or busy trying to associate) to an AP. When it is 
associated it has to sit on the channel of the AP, as announced in it's 
beacon and/or probe response, at regular intervals. You referred to DPP to 
provision the STA so I assume it is not associated, right? Could you write 
out the whole scenario as you think it should/could be done?

Regards,
Arend


