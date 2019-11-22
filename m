Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D788D107427
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 15:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVOls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 09:41:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKVOls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574433706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9q597YADqqlOEAZ+us4YqXW2SbwGTeVGSBbfV25zlZg=;
        b=aCczqNgbtHc5zMr8zHCS2woq7pFeT3970JI4VMcqiyBX1/7HlmFNy+D1GOjzuI1yRDgufa
        tVO9Wyq8TLrKDcveepucmOzuT6A+jZvBVCnamyYlPn08kkuxjx7+Ee10Srxe8V9GN6/liC
        q6d6dB0gi3D+A+Yp7iGDbC6HJo+czlo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-TmI_w7oBPUWNpC-xjuFc9Q-1; Fri, 22 Nov 2019 09:41:42 -0500
Received: by mail-lj1-f200.google.com with SMTP id h10so1130259ljl.18
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 06:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RgnI4HflXO3mCFoZIIPG2RpazzNJ3juOOlg+uXS6edE=;
        b=Ob91oF2pUMqmuTmFA7buE+G6rnW1GrzLRZZJF8GRxHeFj6ifXhxk+eLjd4oQoiOlD7
         VQQbmS0vNYXZVA+NI6cwTngno1XXwCVe1OPfOhX4KOK9vGVDKlfA/pR2oXEvUzWXDr58
         yKkUT4IJy4Fu6CxtFP68iUjZ4m5n46HhrEdiXF2Ou4kPBdi8j/qTsbPOfHXuqPZJgpQM
         JJZv3I3tSkYnSCMBkrGNJN67uRpb8VR/l9EJ7UZAl6bjH04NuhCD3gttxxNWUmmMDliN
         fF6XYeBLUyqTdXUfq13SsSRwDGkujUtoW1y8m0up/XupMcCRBHOPn+PSeHhVcL4qOZDr
         tg5Q==
X-Gm-Message-State: APjAAAXka1ZU2s6GrW2c7Vu2LTX8c1yu6CN5TbIJdnt0rqPhQBN8WSF+
        KHXCiPvj3lmg6SrX6DW+D//MYyUDB8T1JzlZRZfOruFlivQYkgM+GNECWqq7xsQdHFj4zXwV09T
        +WK82sY7xMCjGmxb0Lkp8x9gsBuw=
X-Received: by 2002:ac2:51c5:: with SMTP id u5mr12390780lfm.154.1574433700892;
        Fri, 22 Nov 2019 06:41:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQ5pnqBvua3JEIfWOGBY7JhXbOH3HzENeDJjuBPNzDFbI5KK+I99xCokTZBFOlPBUxPYt+Tw==
X-Received: by 2002:ac2:51c5:: with SMTP id u5mr12390767lfm.154.1574433700727;
        Fri, 22 Nov 2019 06:41:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t14sm3301298lfg.30.2019.11.22.06.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 06:41:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0C4B51800B9; Fri, 22 Nov 2019 15:41:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from mt76
In-Reply-To: <994e486e8e82c01e70150eacf59dedf61b80fc65.camel@sipsolutions.net>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-3-kyan@google.com> <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net> <87tv6w3w92.fsf@toke.dk> <dea9da1dd31900306c886c308c555691552290f5.camel@sipsolutions.net> <87imnc3vk9.fsf@toke.dk> <994e486e8e82c01e70150eacf59dedf61b80fc65.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Nov 2019 15:41:38 +0100
Message-ID: <874kyw3rdp.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: TmI_w7oBPUWNpC-xjuFc9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-11-22 at 14:11 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> as in bitrate =3D 1/airtime? Dunno, maybe? How important is precision to
>> the bitrate calculations?
>
> Not *that* important, it's just sort of advisory for userspace.
>
> Though I think there's at least one place in mac80211 related to
> radiotap that actually does use it for airtime calculation, which should
> probably be changed to the new code now ...

Yeah, I guess so. The ath9k driver is also doing software calculations
for RX, so that could also be converted; and mt76 should be, of course...

>> > Or maybe we should keep both and use them as a sanity check for each
>> > other :P
>>=20
>> Hmm, yeah, it should be possible to write a selftest to iterate through
>> all rates and compare the output of each calculation, shouldn't it?
>> Where would be a good place to put that?
>
> No idea ... make a new kselftest thing for wireless?

Right; was just wondering if there was something like that already which
I didn't know about :)

-Toke

