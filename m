Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D811A8CB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfLKKXK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 05:23:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728757AbfLKKXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 05:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576059787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hM1lsKszqVVW7xdJguXodLHtzH+CDtVuMqOIlsaB+gI=;
        b=R5Qf+fcLtOP6YE0P424/8Y0Selqy/xlEk9ZQNl0rAN+Rr8cT3pfUu1i8UL+7U7LIpKvuvs
        vObXoEmCzWCwCGGEC5fDdNdyJa/S2tmgrhOc5jUWw3sMKD0ixxiiWjqPLQuQ3QhxY7fdg9
        aUOGOUuYmbbGJYahxFgrQon8xqVEEw0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-qlGCxu6xOL-tFeaRJGWdBw-1; Wed, 11 Dec 2019 05:23:05 -0500
Received: by mail-lf1-f71.google.com with SMTP id i29so4914509lfc.18
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 02:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xtky7BBHwRXTXA6G0HOwZ/5cGWXqDvl3mPuhDaTdQGc=;
        b=DoYi7hIdTqwE5k6ygZj8TJuXX1C652pSnQm6IR2MBxKQH8Yzp3gRqoQtTc1elgXGI6
         AMXfh2gA863rVvXLGrt0XQiAgW2AnIGOBHd27vfGqVGOjzB/RBi/MqQAqrOspU6cckbm
         UAUFs1ImtXiTyL5HiOEIrT4/xmpy4rcYVRoznM1Q9IgfXq8UKb8V4HhHcURLXPIm3NKp
         Yohw6S9JEbeP5W4lv0ce/Sl53DEvuYaINWVAHbesI0KNRjNvzmPRns0OjIU/X67d1+KL
         9oEog3YAn6rkBxAbUfW7S6ADWOmNeLIvcg7OZSrtilIdilyp0uAUQfcyrOgcFofPHkGl
         I8Bg==
X-Gm-Message-State: APjAAAWb/f2yq0elJZNEu65k5y2I++yE51J4DTy4XKMFxoIqfSg9+r9P
        o8UPW4EaROamjiICfVexXT+rX+ca6frqGIrO+eu/0W4sjHxYEDeHWcvF7Q/7/E18aJghEM4THT7
        QYcOYWe7xzkQl8Nu2PxxjD/UJeRA=
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr1524259ljo.169.1576059783758;
        Wed, 11 Dec 2019 02:23:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqJDm3LCJOvpYWrqQko1RdnmT5mm9x9VwK6WfbjT4PSSxVY1TNatidj+Kqr9o5xXlTc4z+5w==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr1524250ljo.169.1576059783585;
        Wed, 11 Dec 2019 02:23:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b17sm861754ljd.5.2019.12.11.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 02:23:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D2E518033F; Wed, 11 Dec 2019 11:23:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@kernel.dk>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: iwlwifi warnings in 5.5-rc1
In-Reply-To: <3420d73e667b01ec64bf0cc9da6232b41e862860.camel@sipsolutions.net>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk> <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net> <878snjgs5l.fsf@toke.dk> <3420d73e667b01ec64bf0cc9da6232b41e862860.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 11:23:02 +0100
Message-ID: <875zingnzt.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: qlGCxu6xOL-tFeaRJGWdBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-11 at 09:53 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
>> > On Tue, 2019-12-10 at 13:46 -0700, Jens Axboe wrote:
>> > > Hi,
>> > >=20
>> > > Since the GRO issue got fixed, iwlwifi has worked fine for me.
>> > > However, on every boot, I get some warnings:
>> > >=20
>> > > ------------[ cut here ]------------
>> > > STA b4:75:0e:99:1f:e0 AC 2 txq pending airtime underflow: 4294967088=
, 208
>> >=20
>> > Yeah, we've seen a few reports of this.
>>=20
>> FWIW I've tried reproducing but I don't get the error with the 8265 /
>> 8275 chip in my laptop. I've thought about sending a patch for mac80211
>> to just clear the tx_time_est field after calling
>> ieee80211_sta_update_pending_airtime() - that should prevent any errors
>> from double-reporting of skbs (which is what I'm guessing is going on
>> here).
>
> It does feel like it, but I'm not sure how that'd be possible?
>
> OK, I talked with Emmanuel and I think it's the GSO path - it'll end up
> with skb_clone() and then report both of them back.

Right, figured it was something like that; just couldn't find the place
in the driver where it did that from my cursory browsing.

> Regardless, I think I'll probably have to disable AQL and make it more
> opt-in for the driver - I found a bunch of other issues ...

Issues like what? Making it opt-in was going to be my backup plan; I was
kinda hoping we could work out any issues so it would be a "no harm"
kind of thing that could be left as always-on. Maybe that was a bit too
optimistic; but it's also a pain having to keep track of which drivers
have which features/fixes...

-Toke

