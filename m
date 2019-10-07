Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE8CECF2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGTks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:40:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39647 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728212AbfJGTks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570477246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2Ph3icJn0W6wDmYyDFwH4B1x+sv1ciEVjfPrKs/LDI=;
        b=hCUigsd7MbfQSCxlfGUTRl0+kQ8a668WuhWtnfjV7/+jxG/+d6mqa5MlIyOuKRswTF5HDC
        w9PBqbNN6b6adnnMKeCl0eYNUSo3bdtJ9+WaSumTIOA6mpaEnvi8oNkqA/tQL/WanH5iaL
        THETwEbnO6qdnxUDdGXTbduHBULJpkk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-XHrXPFbWOM-F6ZDzqv4cUA-1; Mon, 07 Oct 2019 15:40:44 -0400
Received: by mail-lj1-f199.google.com with SMTP id 205so3839956ljf.13
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2019 12:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dGQcdmDOU5djooYj79l+KDc1Soqz551iHKq25ESjU+I=;
        b=KpUpSopuiRAvbygPIIq2m2Oru0iNLxMlfG0PJv2zPS3epu9rhiO6wBxS2s92vZrqxd
         c7Wp+KLme1O1wvZh+Wb0KLQ58aQiVDPhE7wmF7O3fhs4Ka2wG0nQCB1jVoWsaUeaJmcZ
         gr3jAzraHPppi1Epovg4kmPCg814G230xyK5X7a/8trFFi8fcp/J/kqyYQTIDsWAhNab
         gxZbaXVGkkV19P+emNUMuYa94gaIqNW1YewaxhD2u5o1uSaYcSXkBE/Z9+4uv8xR3DRU
         n31Kdw9edGenvyF/O/ikQegUQ9+erz1Uq6Q/YQjw1K4vzRxqDByb5HTDx/CX981uH2z4
         Q+Rg==
X-Gm-Message-State: APjAAAUFaDhHGH/l3R34U/KcZlynY9Cm52O6qgnFkBibdWfGWW2cfazR
        HjTt/WGaGkGbF86SjSUHKsClkbW0YzUU0yxLwGCY39JsdR9UXVjzbwWDwQnWUdixnm5MZm5zL0B
        a4xLLtPJMzXgNXjyrbfnsRIr/Ac8=
X-Received: by 2002:a2e:730a:: with SMTP id o10mr20348407ljc.214.1570477242945;
        Mon, 07 Oct 2019 12:40:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNCnUF881B+ASd51GbvvhhhTTw3DmRUBGe1LKyqDcA88YBX1NuI1aTa2BzRr4IFUyKru+GbA==
X-Received: by 2002:a2e:730a:: with SMTP id o10mr20348397ljc.214.1570477242735;
        Mon, 07 Oct 2019 12:40:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id l7sm3299248lji.46.2019.10.07.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 12:40:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B2B9418063D; Mon,  7 Oct 2019 21:40:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com> <87imp4o6qp.fsf@toke.dk> <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com> <87pnj9n55y.fsf@toke.dk> <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Oct 2019 21:40:40 +0200
Message-ID: <878spwmjif.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: XHrXPFbWOM-F6ZDzqv4cUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Sun, 2019-10-06 at 19:40 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
>> > That's a good point.  I haven't thought about real simultaneous dual
>> > band chipset and such chipset do exists now. Is RSDB support coming to
>> > mac80211 soon? Just curious if it will be just virtual interfaces or
>> > something else. I chose "local" instead of "sdata" thinking about the
>> > case of several virtual interfaces (AP, STA, MESH) operates in the
>> > same channel, then the interface total could be a better choice.
>> >=20
>> > I am ok with moving the "aql_total_pending_airtime" into sdata, but
>> > afraid that's not the most optimal choice for the case of multiple
>> > virtual interfaces operates in the same channel.
>> > Maybe we could leave it in "local" for now. What do you think?
>>=20
>> I'd lean towards keeping it in 'local' for consistency with all the
>> other airtime stuff. For now, I think having multiple SSIDs on the same
>> radio is more common than the reverse (multiple bands on a single
>> radio).
>>=20
>> In particular, the per-group airtime fairness stuff is definitely
>> designed on the assumption that all BSSes share the same band.
>
> s/band/channel/, presumably.

Indeed :)

>> So if and when we start supporting true multi-band devices we'll have to
>> change these things anyway. So might as well keep everything together so
>> it all gets fixed :)
>
> I guess I'm OK with that, but I'm pretty sure this will come up sooner
> rather than later ...
>
> What else is there though?

By "it all" I meant "all the airtime fairness stuff". Other than that, I
didn't have anything in particular in mind. I just kinda assumed there
would be lots of places that had an implicit assumption that all devices
on the same phy shares a channel...

-Toke

