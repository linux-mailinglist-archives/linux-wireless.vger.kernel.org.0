Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BA343E18
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 11:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCVKiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 06:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhCVKh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 06:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616409478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6G4g+Zzw9+IQi2i463gkQ927R/fhe4ocIM539Dt27bE=;
        b=MvhnK9L38MWeItCLW18IXhKG7LihGgPuH6HMorerjktjRVXC0BzL+nl6XPhAM8MZt26Ho+
        eRJR4wBxj7IsWKXDIvhrOHedFeh925M1NAdOkF4quWNYDW4XrsCTwtOAwMXRRhvFps3Xrj
        wg7Getr78KJ42QDwpdUCvDBGcJkYmRY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-vjDil1vzMdyPfoD4KubMgA-1; Mon, 22 Mar 2021 06:37:56 -0400
X-MC-Unique: vjDil1vzMdyPfoD4KubMgA-1
Received: by mail-ed1-f72.google.com with SMTP id i6so27327389edq.12
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 03:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6G4g+Zzw9+IQi2i463gkQ927R/fhe4ocIM539Dt27bE=;
        b=WTR8vyX1mjRUjH7imV93FrZkOuVKKP/8tTYmf1Uo3TqJ2+Eq6pI+RiZnu2VSH6YueW
         vwdSObCFnl0Oi+f07LRJMXQ0tz4DPzqUg/IAUS+KBvP1oD0Lvt6WVo8B28lQBE+o64QA
         SU6GxGmnC9GAbnbpqlBX0jSAWg/cZQFdgMEi/oWtmGdBjYVok/F7Xn+7cuavLAUG8E7F
         nvTUCBI+4UbCgpOsbr6hyTn+/swNxn7Hs/JMWWaQgW+oXbCuvhqrp+rWPjvxGD59g9SS
         nyAesVVcz8SIQzH0t8C4NujyekT9NwnaXUxDyFEzQArc3g8SL93vZpQL8ZzRzQ7oFzZ2
         NvcQ==
X-Gm-Message-State: AOAM532VVllREYTpM6sw0kTEFxA1s9Kv2gFQjSO198888NiW8VmbNnai
        9cZnWdQF3J9lXPhA3z8Vor+wLwL9rCqJrGma3hj/OyKlitTgWus3tf+XTeG8dmfIu/Jqoa6TfcT
        o2kC3zXxjrDqUjlHdSudHwEz5YYg=
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr24705682edb.279.1616409475050;
        Mon, 22 Mar 2021 03:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweWdswSYPWaqm/bGLt77H2MfgNKEDKFvr5bpbp+7pbBjqyq1gIImlMj2wQkGOHuSR8M2cW3w==
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr24705676edb.279.1616409474938;
        Mon, 22 Mar 2021 03:37:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p9sm10988833eds.66.2021.03.22.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:37:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EC3B6181F54; Mon, 22 Mar 2021 11:37:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: don't apply flow control on management frames
In-Reply-To: <e0ca70f2241307c44489653d7074c5017ad93943.camel@sipsolutions.net>
References: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
 <87h7l6adht.fsf@toke.dk>
 <e0ca70f2241307c44489653d7074c5017ad93943.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 22 Mar 2021 11:37:53 +0100
Message-ID: <87wntz8oe6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Sat, 2021-03-20 at 01:13 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> One consequence of this is that we create a strict priority queue for
>> management frames.
>
> Yes, for iwlwifi that's actually a change. For everyone else (not
> setting BUFF_MMPDU_TXQ or STA_MMPDU_TXQ) it already is since it goes
> directly to ->tx() and from there to the hardware queue(s).

Ah, right, of course; so not much change at all. Cool.

>> With all the possibilities for badness (such as the
>> ability of starving all other queues) that carries with it. I guess
>> that's probably fine for management frames, though, right? As in, there
>> is some other mechanism that prevents abuse of this?
>
> Well, there's just not that many management frames to start with? And
> only wpa_supplicant (or root in general) can create them. So I don't
> think we need to worry about that yet. With QoS-mgmt frames we might
> eventually want to think about that, but even there I'd say we never
> really want to drop them.

Yup, that's what I meant with "some other mechanism to prevent abuse".
Great.

Feel free to add my:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

