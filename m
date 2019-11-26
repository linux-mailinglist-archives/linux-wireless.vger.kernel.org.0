Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF1109B01
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKZJTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:19:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57918 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727150AbfKZJTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574759990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+Jxe4wUa6taaXTyx/M9wM4rkK/IQNNd01d40LpvJBw=;
        b=R+XgIg0PeWGa4WJRyccEG8FS1zq+6m4+DQ8CnrHckSqwO/JXbq+ieuRrsTi73yj7o7U+Ac
        LZjuEKuJtbLrNKndsaebG+YGCX+jSsznfS7UK3QKWnUrdrZwv10Ty9dIwIoVukJbvPmm+/
        dI9ALTKTaBwsvJvDfEyTlr3Qp6Ci1uE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-X8T1AE5GObaP-WDYSawojw-1; Tue, 26 Nov 2019 04:19:49 -0500
Received: by mail-lj1-f199.google.com with SMTP id l10so2179058ljb.15
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2019 01:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OHk3QyZlc+rm4lFfxeoDeCGOk4m7yPb7g+ZsqulMHdw=;
        b=F9CGAM+qgoPaF05+A3kCJCcMIxOeIDB8pP5ah3Rbyjzn7GoUij5YfZmv01tHQDWGOm
         tHyx9iSzOi/ylH51bJK6w9CsdATx9f6JtoHhrsjBtvMFATXTgEirIsVC1udyApnJbJhC
         Ad2mI86SQEquFm7e63Rce6O4qSwYbBvNj62H0REH7BBpV4LmliffVCvLBLRYvjDzPFbK
         scI0khQ2l/oR685e8GBJpJgjuyY53u2KV4fXauYeHmDsYsiuqEjyJ+A8ETxKnVqIqDAf
         q90H2PFh9J1Ro0t6kmC1N4VRXKsfKi6uSIG88OrIZvrZVSwV/T1rctGxWbX9SY2p3f3L
         2cEw==
X-Gm-Message-State: APjAAAWqxIYY8GxRNC2xaCJH8GWX+8OMR9qVl9npGddh+HrikUvznxs8
        +LtXqzQVSxwV23Yuq4HFR/n1/8ho7pLWIDmaXXWZAHYSxwQypB9u9P95K8Y+Pl7/5kBLlPynXd8
        MaUbW9sgC2aOEkn9Nw/pGeY+aj6c=
X-Received: by 2002:ac2:5999:: with SMTP id w25mr23601714lfn.42.1574759985549;
        Tue, 26 Nov 2019 01:19:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoLhXuBNTaChzNFc9fdd9sulEQ6j+4V7Nqx9wfEw69Kf7LMshjczbh40km3d6Hx8mRgN0jrQ==
X-Received: by 2002:ac2:5999:: with SMTP id w25mr23601698lfn.42.1574759985192;
        Tue, 26 Nov 2019 01:19:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g5sm5180757ljn.101.2019.11.26.01.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 01:19:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64DFF1818BF; Tue, 26 Nov 2019 10:19:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Dave Taht <dave.taht@gmail.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com> <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com> <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com> <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com> <87a78p8rz7.fsf@toke.dk> <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com> <87muco5gv5.fsf@toke.dk> <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 10:19:43 +0100
Message-ID: <87eexvyoy8.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: X8T1AE5GObaP-WDYSawojw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> Yeah, bpftrace can be a bit of a pain to get running; but it may be
>> worth the investment longer term as well. It really is quite useful! :)
>
> My attempt to build bpftrace didn't work out, so I just got the
> sojourn time using old fashioned trace event.
> The raw trace, parsed data in csv format and plots can be found here:
> https://drive.google.com/open?id=3D1Mg_wHu7elYAdkXz4u--42qGCVE1nrILV
>
> All tests are done with 2 TCP download sessions that oversubscribed
> the link bandwidth.
> With AQL on, the mean sojourn time about ~20000us, matches the default
> codel "target".

Yeah, since CoDel is trying to control the latency to 20ms, it makes
sense that the value is clustered around that. That means that the
algorithm is working as they're supposed to :)

While you're running tests, could you do one with the target changed to
10ms, just to see what it looks like? Both sojourn time values and
throughput would be interesting here, of course.

> With AQL off, the mean sojourn time is less than 4us even the latency
> is off the charts, just as we expected that fd_codel with mac80211
> alone is not effective for drivers with deep firmware/hardware queues.

Yup, also kinda expected; but another good way to visualise the impact.
Nice!

-Toke

