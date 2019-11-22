Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18876107017
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 12:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfKVLUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 06:20:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32424 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729575AbfKVKp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574419556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk4U8YS7q9LLa/grnzbGdGnG0Qz10lovogQ8pGu2fqo=;
        b=XSev2sTlBPMT1y9vX/qQoN7Fr8yOufdNdWx28kvqi/bO2lXwO/qM2NsbVmLL11srZ+I4Ev
        CNdYP8wIJJQL7/pXLGlUJZHTQgSErcxR08EdQJC3c36HftZozJ0nKoYE63foDq51feQvMP
        8j45P/RQEfVgJKLUJI9ysTuXAgS2IXQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-xJ--dzD3Oqe1wTIWcSapGQ-1; Fri, 22 Nov 2019 05:45:53 -0500
Received: by mail-lj1-f200.google.com with SMTP id p25so1211521lji.23
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 02:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3YUXrxz/9/yZd+6SITQARhpw627qctr8pyINzH15x7I=;
        b=MvJyxhLjbe/T4TcxIMLUGblFVuBsjHhfC89YuXtam5Ax7Or6FvqpcTPQLKj+85psWV
         Jn8ofd7fIoOwDN4DpAeUYVb1HE7bAgoaGx9BNq8iFujr0GClruaQm314YM5GmP2JhGiq
         9mrY+65vBMTGiXSsuQY9T3C2DbK6Dh0NDC7afkot9Co7ognpUnHdOADmCHI8IPM5NPqo
         vMAQWTbRukZ1GW9vk5B43c5EyYwzIE0u7RbCBxd5CYt9azBiCj593P0hHeR/rXTH46I/
         nK899SH00rjQzRirQopBd9a8zM1pnaVK8/CTFIXrzQIMztCQGa6IO0AxDUP89ZbELExF
         KosA==
X-Gm-Message-State: APjAAAV5BgBRNDs1jnG9OCCb/8bAAu9g/wsohBbgzdZDWYENLR/Rx42A
        5I+r4lT3QXiaUbk6CJq630P0GeoK9JZYQCV73xEuEUy967CKUj3lE1eDdSeOjLtyaDHoXKr8PYX
        +Farv9P4txqWF1dV8hOu6ta8Mid4=
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr11781013ljm.38.1574419552011;
        Fri, 22 Nov 2019 02:45:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwasaXDtX4MXmTufMchsNxvY8RgZ/y/8Wj+hpnVwKvzPvDpORYbjFKz7XUktpYMgpbvBTWFSw==
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr11780993ljm.38.1574419551804;
        Fri, 22 Nov 2019 02:45:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 129sm1015345lfj.86.2019.11.22.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:45:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 159341800B3; Fri, 22 Nov 2019 11:45:50 +0100 (CET)
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
In-Reply-To: <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com> <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com> <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com> <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com> <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com> <87a78p8rz7.fsf@toke.dk> <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Nov 2019 11:45:50 +0100
Message-ID: <87muco5gv5.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: xJ--dzD3Oqe1wTIWcSapGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> In theory, this ought to produce a histogram of sojourn times (in
>> microseconds):
>> bpftrace -e 'kretprobe:codel_skb_time_func { @sojourn =3D lhist((nsecs -
> (retval << 10))/1000, 0, 100000, 1000); }'
>
> Thanks for the tips!
>
>> Can't get the CoDel drop mechanism to trigger on my system at all,
>> though (a laptop running on iwl). I guess because there's queue
>> backpressure to userspace first?
>
> What's the tcp_congestion_control in your system? Maybe it is BBR that
> prevents bufferbloat.

It's not BBR, just plain old CUBIC. I've seen the issue before that it's
almost impossible to build a queue in the mac80211 layer when the TCP
session is originated on the local machine, though...

>> It would be interesting to see if it works for you, assuming you can get
>> bpftrace to work on your test system :)
>
> I can enable required kernel configuration easily, but cross-compile
> bpftrace for an ARM64 platform may take some time and effort.

Yeah, bpftrace can be a bit of a pain to get running; but it may be
worth the investment longer term as well. It really is quite useful! :)

Some links:

Install guide:
https://github.com/iovisor/bpftrace/blob/master/INSTALL.md

Tutorial by one-liners:
https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md

Reference guide:
https://github.com/iovisor/bpftrace/blob/master/docs/reference_guide.md#5-t=
racepoint-static-tracing-kernel-level

-Toke

