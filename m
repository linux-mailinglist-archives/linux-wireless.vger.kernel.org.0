Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41211ACAF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfLKOCd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:02:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727554AbfLKOCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576072952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS1ulbpjbL3cpC4UOh1VrRrE49CxlddKySSCHyYBN1w=;
        b=QRmetT7Y+pt4vvvN+FrtPnpYmnlakiirlLRBJjotDpwo5bVHJuPQeyOv8hU8lZ9rS0H9cy
        v6IV3BjRbD1Jd7sST2X6fEbgm7oF+bSWTC1fe09A1SkwDyeVy1WpEwX/9kV6+bKMuO9vrz
        xFjfmergK1M78Cp0AKR+6LJAe+klV7M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-axVz19PnNJ-h8I6OIYQUXA-1; Wed, 11 Dec 2019 09:02:30 -0500
Received: by mail-lj1-f198.google.com with SMTP id g16so4406495ljj.12
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 06:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bbVO1TAkugzzVKgAPW45q9SGgy0QAxF8d9CLJkj10AM=;
        b=XicUvJZx1Caj2anXJVzJZ/oE1jwrqE5ux6BrpoVJhLWnKLUVWssgNhQOecG9GKExec
         CdoCF+w+RM7h53zxE2FrSJ4uqJeNEAWGcwaQK8uzp0thBeZsS5fqiHR81ChYuQckyYdY
         LakRX4epwAVtn6BnIPmFhCLgWtDyMPbMye2XUYfITv3HyMLdSzj70TTitHdzBieOAuvv
         3DBhHzhnTY6QwENplUZXV/RV71V6dNB9cFFz9R9z4FwkitPkoVYKYiuY2zc04wpZZw1+
         VUW9CpZ5336WD0UQKy3Qn8nLWXaRGvZuLbmpbnUcIT3ysQaQ89orDX37/o/e1D9Pu/Sp
         syGw==
X-Gm-Message-State: APjAAAXMa6kDX8LtpyEJSOhfyEJ27zvXA9yV4cY4uxHuBhjbdKewN+HC
        c40srNquV6uenfU6o+9P4RYpoxrbSXJTZeR5SaV3LEeVXggE8Rn5rdhMZM93SQJVxl7KrJEDQnO
        pwyJnDIdLbQT05To79B+6RD8Svy4=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr2162217ljm.53.1576072949091;
        Wed, 11 Dec 2019 06:02:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHQoPGTnI+zpqMpPfV9tvoxC4sSartkEWyyTZZPeoEHC552cp+Q9YvAkEg3UkGVXDz2NNEPg==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr2162203ljm.53.1576072948844;
        Wed, 11 Dec 2019 06:02:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j19sm1210984lja.100.2019.12.11.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:02:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EF69418033F; Wed, 11 Dec 2019 15:02:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@kernel.dk>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: iwlwifi warnings in 5.5-rc1
In-Reply-To: <bfab4987668990ea8d86a98f3e87c3fa31403745.camel@sipsolutions.net>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk> <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net> <878snjgs5l.fsf@toke.dk> <3420d73e667b01ec64bf0cc9da6232b41e862860.camel@sipsolutions.net> <875zingnzt.fsf@toke.dk> <bfab4987668990ea8d86a98f3e87c3fa31403745.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 15:02:26 +0100
Message-ID: <87tv67ez9p.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: axVz19PnNJ-h8I6OIYQUXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Hi Toke,
>
>> > OK, I talked with Emmanuel and I think it's the GSO path - it'll end u=
p
>> > with skb_clone() and then report both of them back.
>>=20
>> Right, figured it was something like that; just couldn't find the place
>> in the driver where it did that from my cursory browsing.
>
> Yeah, deeply hidden in the guts :)
>
>> > Regardless, I think I'll probably have to disable AQL and make it more
>> > opt-in for the driver - I found a bunch of other issues ...
>>=20
>> Issues like what? Making it opt-in was going to be my backup plan; I was
>> kinda hoping we could work out any issues so it would be a "no harm"
>> kind of thing that could be left as always-on. Maybe that was a bit too
>> optimistic; but it's also a pain having to keep track of which drivers
>> have which features/fixes...
>
> Sorry to keep you in suspense, had to run when I sent that email and
> didn't have time to elaborate.
>
> 1) Hardware building A-MPDU will probably make the airtime estimate
>    quite a bit wrong. Maybe this doesn't matter? But I wasn't sure how
>    this works now with ath10k where (most of?) the testing was.

Yeah, not too worried about this...

> 2) GSO/TSO like what we have - it's not really clear how to handle it.
>    The airtime estimate will shoot *way* up (64kB frame) once that frame
>    enters, and then ... should it "trickle back down" as the generated=20
>    parts are transmitted? But then the driver needs to split up the
>    airtime estimate? Or should it just go back down entirely? On the
>    first frame? That might overshoot. On the last frame? Opposite
>    problem ...

Well, ideally it would be divided out over the component packets; but
yeah, who is going to do that? I think reporting it on the first packet
would be the safest if we had to choose. Also, ideally we would want the
GSO/TSO mechanism to lower the size of the superpackets at lower rates
(does it?). At higher rates this matters less...

> 3) I'm not quite convinced that all drivers report the TX rate
>    completely correctly in the status, some don't even use this path
>    but the ieee80211_tx_status_ext() which doesn't update the rate.
>
> 4) Probably most importantly, this is completely broken with HE because
>    there's currently no way to report HE rates in the TX status at all!
>    I just worked around that in our driver for 'iw' reporting purposes
>    by implementing the rate reporting in the sta_statistics callback,
>    but that data won't be used by the airtime estimates.

Hmm, yeah, both of those are good points. I guess I just kinda assumed
that the drivers were already doing the right thing there... :)

> Now, (1) probably doesn't matter, the estimates don't need to be that
> accurate. (2) I'm not sure how to solve; (3) and (4) could both be
> solved by having some mechanism of the rate scaling to tell us what the
> current rate is whenever it updates, rather than relying on the
> last_rate. Really we should do that much more, and even phase out
> last_rate entirely, it's a stupid concept.

Yes, that last bit would be good!

> There's an additional wrinkle here - what about HE scheduled mode, where
> the AP decided when and at what rate you're allowed to send? We don't
> report that at all, not even as part of rate scaling, since rate scaling
> only affects *our* decision, not when we send as a response to a trigger
> frame. This is _still_ relevant for AQL, but there we can only see what
> the AP used last (**), but we don't track that now nor do we track the
> proportion of packets that we sent triggered vs. normal medium
> access...

Huh, wasn't aware that was a thing in HE; that's cool! And yeah, could
have interesting interactions with AQL...

-Toke

