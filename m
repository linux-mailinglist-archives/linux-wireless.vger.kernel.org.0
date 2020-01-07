Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAA1323FE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 11:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgAGKnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 05:43:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGKnx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 05:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578393831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HreyvVESVBdgkhYgE7YdIkJiIbgwH2Igij/MagPRtS8=;
        b=KbZIXtLNTm7Wh9LGAqb3z3x9P46guCaqbk9nPvXDLWYLtzc033I7QfxUhxNBOOVWaUze9p
        CISRrLK2aEOSe35RaQne7Cb1yEsWUoIAdITtd/cHb9jurB6wFx3Sy6M1ENpJIKqhxfOGQH
        +yBl7jRPXqT2evBygOW69MyaZHHGnds=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-W7jGqqvQMEuAalvKYjJUCg-1; Tue, 07 Jan 2020 05:43:50 -0500
X-MC-Unique: W7jGqqvQMEuAalvKYjJUCg-1
Received: by mail-wm1-f70.google.com with SMTP id t4so3932366wmf.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2020 02:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HreyvVESVBdgkhYgE7YdIkJiIbgwH2Igij/MagPRtS8=;
        b=KI9Vher+ufjyaOF8HXiJ9wzic+RqTSVcbIyW0d+HQahf3PcaeMOqYspy62SCouT9i/
         Ly0hDZX55QATUhuCc/HtjMcrNTs5j3I7uvf1bvj196h42/OYCxIo9K8MrHqqGRjfNAPs
         qcjWsLpuqDA76ioBNHYQ7D/U2hRV8xLSeyXehMNu7qOOdi0ZiAOWbIjz2jJfHknV6Iwf
         33L1O1tA/Txycb3C/sB31qAYN3lp5KRH/XTUYjSoTmPhUPSohvGkEivqsqRVuFljCZ8G
         kSYPQUlxOgrmf44DuR850UnPkz4ergymgGW7iFIpm/4gGsBPcsiIZV+EAZXgZ2VyITMN
         JKDg==
X-Gm-Message-State: APjAAAWOJIbIMqB+rxFwfzQo+nJgLWxnRwnzeliUq5D2cwg7bExnhn8I
        kED1kWOEoyskpOmoXPgOiaw8Fh7qWliT0fw4zIJzVGyUd7Y01X2NetUvl2YXWFCIRHhQZkivkkg
        ILYqn6r6IPEQxR/V/rJiUlffLnrs=
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr39479736wml.107.1578393829491;
        Tue, 07 Jan 2020 02:43:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhqAe0MIUxLCEBxHeY/zXx0E6R+L+jUAUk8pqHkZQb/JZCT90nDRxmSPx5pmZtbaYuiI5qpA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr39479708wml.107.1578393829109;
        Tue, 07 Jan 2020 02:43:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b10sm78630008wrt.90.2020.01.07.02.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:43:47 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 74051180960; Tue,  7 Jan 2020 11:43:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Yates <john@yates-sheets.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kan Yan <kyan@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v5] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <CAJnXXogQCKQSLT+8_NnEfFd7MLc0=YxShvb4hY2Y+BDJjybQTg@mail.gmail.com>
References: <20191222172423.131033-1-toke@redhat.com> <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net> <87r20ck3x9.fsf@toke.dk> <CAJnXXoiyWKSLHqMzMcSzHBM-HhfYtcURW1hYd-3Yf7K00NTqgQ@mail.gmail.com> <87mub0k2cd.fsf@toke.dk> <CAJnXXogQCKQSLT+8_NnEfFd7MLc0=YxShvb4hY2Y+BDJjybQTg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Jan 2020 11:43:47 +0100
Message-ID: <875zhnk0m4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Yates <john@yates-sheets.org> writes:

> On Mon, Jan 6, 2020 at 10:54 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>> Yeah, we'd be doing the accumulation in 64bit values in any case; we're
>> talking about mainly multiplication here (the whole point of the
>> reciprocal stuff is to get the division out of the fast path). So how
>> big of an impact is one (or two) extra 64-bit multiplications going to
>> have on a 32bit platform?
>
> Top line: usually replacing 64 bit divide with multiply is a massive
> win.
>
> Many platforms make (32 bits * 32 bits) -> 64 bits quite cheap:
> - x86 has this as a single instruction: eax * edx -> eax:edx
> - arm has much the same, plus a variant that tacks ona  64 bit accumulati=
on!
> - mips leaves the 64 bit product in a dedicated register; retrieval
> requires 2 instructions
> - ppc, being more "RISCy", has two instruction: mullo and mulhi
> (performs multiply twice!)

Ah, this is very useful, thanks :)

> Best case is when the compiler can recognize a 64 bit multiply as really
>
>   widen_32_to_64(left) x widen_32_to_64(right) -> 64_bit_product
>
> In such a case only one of the above multiply cases is necessary.  Otherw=
ise
> one tends to get multiple partial products and double width additions.  S=
till,
> better than nearly any flavor of 64 bit divide.

So going back to the original patch, we don't really need to use 64-bit
divides to compute the reciprocals; not sure what I was thinking there.
That leaves us with a single 32-bit divide whenever a station is
scheduled or unscheduled, and two 64-bit multiplications in
ieee80211_register_airtime().

If we assume no more than 8ms of airtime is being reported at a time, we
can use 2^19 as the divisor and keep the multiplication in 32 bits
without overflowing, which would keep the rounding error <10% for
weights <2^15. This should be enough for single-station weights, at
least. I think it could also be sufficient for the weight_sum for most
uses, actually, so we could start out with that and only revert to
64-bit multiplication if it turns out people are pushing the weighted
fairness stuff to a point where this breaks?

Johannes, WDYT? Also, what is a good place to document this?

-Toke

