Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3890711CB33
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 11:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfLLKpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 05:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728679AbfLLKpt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 05:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576147548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tn1/nohwvbWHf4oSzQNqJtRfBfJIOmLgNk9Q2cykBDg=;
        b=OvmpuEQGE3X+bFzjgz/7dc4ShFpFIG5AcP9AjHkHUzAfq7+eJDB/qbBeovEj6cWKVedcMC
        2Xp/IIIsTek8V20ig8XGxkZMEcDA2iXdTFi7cfezLJ5wSuud/oLMcgmpQlnvPcwFSIlnxh
        5rKOIdG+KrFiK4rxI5g/7iegVfTKMEM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Cv1mRvGyMJK2IezAaq2jvw-1; Thu, 12 Dec 2019 05:45:46 -0500
X-MC-Unique: Cv1mRvGyMJK2IezAaq2jvw-1
Received: by mail-lf1-f69.google.com with SMTP id t8so466709lfc.21
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 02:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tn1/nohwvbWHf4oSzQNqJtRfBfJIOmLgNk9Q2cykBDg=;
        b=aiO7CGepvmlDqvQ5SQ7+LGrGlPZ5sjH1vP3pZOedHkrlJR5v5qycRC5VFMqzV8wK39
         3PgcO07nAaqClzFyOzRO/aOnIw+c0aFpicJpFR6ndjz4byLQLViIsL/CwjOMHnXPcsvL
         x/jJ30FOGfJ6QiRdKvcCZkpm3l/OZvibIQC3IksxsBojECI5iz9JvbVu8pMz6KGd+06/
         H/ILL5Gx9F2z87b2vjr+dlQRHhXZbyM/86rh2FPsGjCLZ6AJB2W43RsBqTc9rIGMhUkP
         VVreF40d/904IQVXEiQmQj/nkEfn6s0cGJH57oV8mAcl9BL/9hCh5Spzyea5k8X/JO++
         2kQA==
X-Gm-Message-State: APjAAAV5Cvaxe9smKQGKuNUxDyft2vgWojlxWgrL6lL3lK4CF1YIY1Md
        1+EIHveNShNVkLbTqFuQMRac32pBFHcgmwUWKSAb3veEvMv/D7x8DcD5lhTrGeF7bBdfH/bE5sb
        GxqE07M8gseL7uF+PkbU3mtGQjyE=
X-Received: by 2002:a2e:918c:: with SMTP id f12mr5361746ljg.66.1576147544943;
        Thu, 12 Dec 2019 02:45:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqweyaRisudrfp62jIayaDreWuaQeGouwa2wZFqQHf42Q6aUvVtaEjfeebmsO+9rUZCqPvVLUQ==
X-Received: by 2002:a2e:918c:: with SMTP id f12mr5361737ljg.66.1576147544779;
        Thu, 12 Dec 2019 02:45:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u25sm2742643lfk.46.2019.12.12.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:45:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1062F1819EA; Thu, 12 Dec 2019 11:45:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@kernel.dk>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: iwlwifi warnings in 5.5-rc1
In-Reply-To: <aa22bfce34e5a938e439b0507296a8b6a23f5c61.camel@sipsolutions.net>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk> <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net> <878snjgs5l.fsf@toke.dk> <3420d73e667b01ec64bf0cc9da6232b41e862860.camel@sipsolutions.net> <875zingnzt.fsf@toke.dk> <bfab4987668990ea8d86a98f3e87c3fa31403745.camel@sipsolutions.net> <14bbfcc8408500704c46701251546e7ff65c6fd0.camel@sipsolutions.net> <87r21bez5g.fsf@toke.dk> <b14519e81b6d2335bd0cb7dcf074f0d1a4eec707.camel@sipsolutions.net> <87k172gbrn.fsf@toke.dk> <aa22bfce34e5a938e439b0507296a8b6a23f5c61.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Dec 2019 11:45:42 +0100
Message-ID: <87y2vhesa1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-11 at 15:47 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> > Say you have some queues - some (Q1-Qn) got a LOT of traffic, and
>> > another (Q0) just has some interactive traffic.
>> >=20
>> > You could then end up in a situation where you have 24ms queued up on
>> > Q1-Qn (with n high enough to not have hit the per-queue AQL limit),
>> > right?
>> >=20
>> > Say also the last frame on Q0 was dequeued by the hardware, but the
>> > tx_dequeue() got NULL because of the AQL limit having been eaten up by
>> > all the packets on Q1-Qn.
>> >=20
>> > Now you'll no longer get a new dequeue attempt on Q0 (it was already
>> > empty last time, so no hardware reclaim to trigger new dequeues), and a
>> > new dequeue on the *other* queues will not do anything for this queue.
>>=20
>> Oh, right, I see; yeah, that could probably happen. I guess we could
>> either kick all available queues whenever the global limit goes from
>> "above" to "below"; or we could remove the "return NULL" logic from
>> tx_dequeue() and rely on next_txq() to throttle. I think the latter is
>> probably simpler, but I'm a little worried that the throttling will
>> become too lax (because the driver can keep dequeueing in the same
>> scheduling round)...
>
> I honestly have no idea what's better ... :)

Right, I guess we'll have to go and measure. Let's leave it as-is for
now, then, and we can adjust in a separate patch.

> You're the expert, I'm just poking holes into it ;-)

And you're doing that very well, as it turns out; thanks! ;)

-Toke

