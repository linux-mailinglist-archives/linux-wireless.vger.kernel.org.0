Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF46ECECDA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfJGTcv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:32:51 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38809 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:32:51 -0400
Received: by mail-io1-f54.google.com with SMTP id u8so31267353iom.5
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2019 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AplFndiP6Wor9DSrV+Mkw7KBaeUV+n/7DkPYY1jxAvc=;
        b=lV1J6y0gQ/ipoz6j7koR753AuIsISC6RLe4+r5bMXqpQ8TvU7zg1IlJdUFVzXTFh4o
         d7fljqSJTlwwx/yaAUcOaUBP0nDjUOagZ8H4RTzynA1XROWMzpaEKhtnzF2MQyK1STJc
         LzboEtROg8EzobsOMpqwrXTY4qQW/eBNrxK1OTwkjPk3DXi4i38g4Sq7zA1EazuiWnRd
         kYUJoLZTjRbuJorx4B0Xo0kne2UrumPw08nRxM1/9OJ7mcThi9t3cuIWu6Dt7+Bqohjf
         tlI6ngIdXJEmFR40O9JI3k1uJl3JTnVmNidAue989WKHOXSi8ms6X9OW1o6hHNA447jk
         HeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AplFndiP6Wor9DSrV+Mkw7KBaeUV+n/7DkPYY1jxAvc=;
        b=qpTbY56EvOFDaQ9/8KlCvT/juDtIuuXCJjP7ZcWzQBJqOyu0hScaXIbx05txFKfyhx
         GMV2NGVldSnU844nqZncRkk7ZRtHhom6f4S3OxCDenWlINb4Zx8c8BDDl8J/NJqMBVS9
         mmhLMl42INvJq9wwj1v/LUPiHxf/Ue9yoe5ZOSQ0E+XsGIEx01aMUFd/hYu7BuxSdy/O
         LAD0dUjcWVVGEZ+z37+5noNbd8OWfe/b3jbc59vCukxMxni81AxBYrgbIWZkj7EercM7
         3pxuGfnMRZaky55MazM69QbYPtg7j/oz/k5DM8sIWQ20Ro6H0HdQso7IpBPiFCJU1Hx6
         n3qw==
X-Gm-Message-State: APjAAAVTuApbLcltyP/qqIzdQmrPSndMLZzIb2TCjKDUHYh+9cBqEdIa
        bIR48F7Nbmc4Q55DaFRtCv77GFjjVIvLaJPxTCY=
X-Google-Smtp-Source: APXvYqxeUJO7jGUAnHP1hoXWKhQRcJTfY/NPg/q44O2OfICk9GCqD4Yhg/6hq8XqPyP/PvoP6f9Vkrwma63cKn4p4aM=
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr13112917jad.61.1570476770526;
 Mon, 07 Oct 2019 12:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com>
 <87imp4o6qp.fsf@toke.dk> <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
 <87pnj9n55y.fsf@toke.dk> <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
In-Reply-To: <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Mon, 7 Oct 2019 12:32:39 -0700
Message-ID: <CAA93jw7xKNG+4HRPOsXKhy0GxX9-EAyu0XSxpyErwbe16wr3pQ@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH 1/2] mac80211: Implement Airtime-based
 Queue Limit (AQL)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 7, 2019 at 12:23 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Sun, 2019-10-06 at 19:40 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
> > > That's a good point.  I haven't thought about real simultaneous dual
> > > band chipset and such chipset do exists now. Is RSDB support coming t=
o
> > > mac80211 soon? Just curious if it will be just virtual interfaces or
> > > something else. I chose "local" instead of "sdata" thinking about the
> > > case of several virtual interfaces (AP, STA, MESH) operates in the
> > > same channel, then the interface total could be a better choice.
> > >
> > > I am ok with moving the "aql_total_pending_airtime" into sdata, but
> > > afraid that's not the most optimal choice for the case of multiple
> > > virtual interfaces operates in the same channel.
> > > Maybe we could leave it in "local" for now. What do you think?
> >
> > I'd lean towards keeping it in 'local' for consistency with all the
> > other airtime stuff. For now, I think having multiple SSIDs on the same
> > radio is more common than the reverse (multiple bands on a single
> > radio).
> >
> > In particular, the per-group airtime fairness stuff is definitely
> > designed on the assumption that all BSSes share the same band.
>
> s/band/channel/, presumably.
>
> > So if and when we start supporting true multi-band devices we'll have t=
o
> > change these things anyway. So might as well keep everything together s=
o
> > it all gets fixed :)
>
> I guess I'm OK with that, but I'm pretty sure this will come up sooner
> rather than later ...
>
> What else is there though?

World domination!

>
> johannes
>
> _______________________________________________
> Make-wifi-fast mailing list
> Make-wifi-fast@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/make-wifi-fast



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
