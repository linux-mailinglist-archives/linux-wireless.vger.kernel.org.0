Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555B7968C8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTSy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 14:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48171 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfHTSy6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 14:54:58 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66B06C05E740
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 18:54:57 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id y3so4676378edm.21
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 11:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HtvEDRGxrGPnS2T9W21mP3iUU6UOHzIexzmqOTTsKSc=;
        b=QaipWOOfGKL31XPpMDlXJyG7MIhG166olbxJYsoSdmVEON2mR5dA7YRlFRB/i6s6vF
         jQ7kmmxA6GiJXS7tMetY05zVSMFTNHwBnvhJfKx35TeB2fLkBPuEqSoiFuavSfhWmuAK
         pMRQBcIM8+wRp7X1+ROCBp/f1svxCmMMiE7VdySIPmJiVpN58cAi+dJYsE8bzjSOvOhq
         wWMXNidigvET5DZQvyDXKITRWObT2wm9wwoUqvxyJ2VjB1Yca/zCNucsQokKClk0z+Na
         3361GrZ3biuVlYjIwgM8qfSkjlhHda9qNo2vbqJ0iKnRVcEXag6FZQFtvIJ/3RKB9AXy
         na3A==
X-Gm-Message-State: APjAAAWTAIJqrOdLBB56zNCgwz4cvscyeMmj/o/dnPLmMRGvMbdDq5q4
        BJcLbkyVNMoBCyMHKTXj/QbldP/3xxq8xAOQX3otVcth/ezG/LB5NYCTrH26D7y3r3loyhoYaEB
        4+iZN/UfCL4v90/J4teJ9dLtheoI=
X-Received: by 2002:a50:f702:: with SMTP id g2mr17247782edn.261.1566327296186;
        Tue, 20 Aug 2019 11:54:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzh+t232moGtY4CgP1PjDJETKxf1Aas/+iGVi1ogST90QZztpLE1TAw0KtQl4cRPfE/H0KO7Q==
X-Received: by 2002:a50:f702:: with SMTP id g2mr17247772edn.261.1566327296054;
        Tue, 20 Aug 2019 11:54:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id f35sm3661099edf.70.2019.08.20.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 11:54:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6EE74181CE4; Tue, 20 Aug 2019 20:54:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Denis Kenzior <denkenz@gmail.com>, Dan Williams <dcbw@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC 0/1] Allow MAC change on up interface
In-Reply-To: <32a1bddd-2472-10a3-4d0d-5634814e635b@gmail.com>
References: <20190815185702.30937-1-prestwoj@gmail.com> <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net> <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com> <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net> <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com> <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net> <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com> <32547793981b3997f7e0f74137745f38615e5c54.camel@redhat.com> <32a1bddd-2472-10a3-4d0d-5634814e635b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Aug 2019 20:54:54 +0200
Message-ID: <87lfvnsm4h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Dan,
>
> On 8/20/19 12:53 PM, Dan Williams wrote:
>> On Tue, 2019-08-20 at 10:40 -0500, Denis Kenzior wrote:
>>> Hi Johannes,
>>>
>>>> Stop.
>>>>
>>>> Your tone, and in particular the constant snide comments and
>>>> attacks on
>>>> me are, quite frankly, getting extremely tiring.
>>>>
>>>
>>> Look, I'm sorry I hit a nerve, but from where I am sitting, it had to
>>> be
>>> said...
>> 
>> But did it really? And in that way?  There were certainly better ways
>> to go about that response.
>
> The issue is that this isn't the first such occurrence.  There is a 
> pattern here and it needs to change.  So +1 on handling this better.
>
>> 
>> I don't recall seeing a NAK anywhere his email chain (which you'd get
>> with some other kernel maintainers) but instead (a) an explanation of
>> why the proposed solution had some problems, (b) some alternative
>> possibilities and (c) requests for more information so the discussion
>> could continue.
>
> So the cover letter states:
> "Set IFF_LIVE_ADDR_CHANGE on net_device. Note: I know setting this
>     where I did is likely not the right way to do it, but for this
>     proof-of-concept it works. With guidance I can move this around
>     to a proper place."
>
> and I'll leave it up to you to read the first response from the
> maintainer.

I went back and re-read the whole thread, and all I see is Johannes and
James having a technical discussion, and you barging in with accusations
of bad faith. So yeah, going to agree with Dan here; you were not
"hitting a nerve", you were just being rude.

-Toke
