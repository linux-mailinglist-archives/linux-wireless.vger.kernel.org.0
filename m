Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA83C1314B5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgAFPUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:20:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgAFPUI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578324007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UblVWdJc4n/0gl7aQh/psh4RpiFlXhIRnt5gwjxTyuM=;
        b=GVRTovDsfhZwaglLwiVbVquy4cTHn/Ke4A1bh2N6Qxi2JqfFS2FhoOHzK0GGXDrZmHx2UY
        Zi20NftlGHdfia4oRNWxj6XVe6MJB5Ltnxk0g1K6ySTLXQi4v4kiK4XRyoluAyd8btUW5a
        LNMSZ45GPG5qKKz3vI32a8KIqh0EGbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-LrZfgCWwMre_Y15mcnyBGw-1; Mon, 06 Jan 2020 10:20:04 -0500
X-MC-Unique: LrZfgCWwMre_Y15mcnyBGw-1
Received: by mail-wm1-f71.google.com with SMTP id 18so2960814wmp.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 07:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UblVWdJc4n/0gl7aQh/psh4RpiFlXhIRnt5gwjxTyuM=;
        b=NO/0Y7YtXmUgVas/Vj0cEzSUgq1ZK5IDg45bT0njaIAp81dc6B4rBk8xU42a0iNqm5
         OHBDXiOg4CJkVJunsMhcruw74a67WjYfMjl+VBlNdJyxpCXtV8cxNOGoQUzvQiKEIoKu
         SSsNqb9CXYwnFsLYqb39kB3dYzUi5EctRS7spgsFITXXxMqIQ+vMjFnrTiWEaWPxG2eM
         snqoZ01yptw5BaYu4bUbYcRbptP5HnSoB7UZspV2jstKQKF18kp7sOS9QnGTbaj+2K6T
         MFSexpFF2aJdjkssAcOYXH1SNTBFNcdZf3L/EA1W0a7CfbdZdCx+d4dRrm2qDnVvyO22
         3HrA==
X-Gm-Message-State: APjAAAVBdp/QVjBhJUiJ6DQ8VU1gmpVU/+FaQprW9muW00SDLnZTxazR
        BEULdwBjd9bhlCwrPn/BwRkZqMUZQfFQbtuU611gNs9YPCDKtb5lenYqzyL7BLigGBvCI1XX+Ul
        eAmNLYGLddwDXxu7WUBz4X1xVROk=
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr100889296wrw.313.1578324003764;
        Mon, 06 Jan 2020 07:20:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJof0Fmo3+7yd3GLwvMkbv0ZPUBM52GYZBVRnWsziRHi0+urnyb1BckDVFiso6nIxX2KN9vA==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr100889279wrw.313.1578324003567;
        Mon, 06 Jan 2020 07:20:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l15sm73359642wrv.39.2020.01.06.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:20:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 16BA6180ADA; Mon,  6 Jan 2020 16:20:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>,
        make-wifi-fast@lists.bufferbloat.net,
        Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH v5] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net>
References: <20191222172423.131033-1-toke@redhat.com> <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 16:20:02 +0100
Message-ID: <87r20ck3x9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Sun, 2019-12-22 at 18:24 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>  Didn't have a chance to
>> do anything other than compile-test it yet, but wanted to get it out
>> before the holidays (which I almost managed, since technically my
>> holiday started two days ago)...
>
> Didn't help you much, I at least was already on vacation by then too
> :P

Yeah, well, I did say "almost". But at least it gave *me* peace of mind
over the holidays :)

>> @@ -1948,6 +1978,7 @@ void ieee80211_sta_update_pending_airtime(struct i=
eee80211_local *local,
>>  			       tx_pending, 0);
>>  }
>>=20=20
>> +
>
> nit, what's that doing here? :)

Pining for the fjords?

>> +#define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
>> +#define IEEE80211_RECIPROCAL_SHIFT 32
>
> Could we live with less precision and use 32-bit arithmetic only? That
> might help 32-bit systems?
>
> This is basically a 32.32 (31.32 for signed) fixed point number, right?
> So I guess I'm asking if we could live with 16.16 (or 15.16), or
> similar.

Hmm, not sure. For the per-station weights, probably; I expect that in
most cases individual station weights won't be big enough to cause
rounding. However, the weight sum is a different matter. We go above a
10% rounding error once that goes above 2^13, which is certainly not
unrealistic. The worst-case error is 50% if the weight sum happens to
land at 2^15+1.

The impact of a rounding error ends up being that a station's next
transmission is delayed longer than it should be. As long as the
rounding error is constant (i.e., the same set of stations keeps being
active), this should cancel out, I guess; but since stations tend to
cycle between being active and not, I fear it could end up impacting
fairness to a measurable degree.

So IDK; we could say we'll live with this in the interest of
performance? Or we could decide the performance hit is worth keeping
precision? Or do a middle ground thing where we use 32-bit arithmetic
for the per-station weights, but go to 64-bit for the weight sum? I
don't really have a good grip on how much of a performance impact we're
talking about here, so I'm not sure which I prefer...

> I think overall this looks good. I guess you should subject it to some
> testing since I can't.

Heh, yeah, testing is definitely needed :)

I'm hoping Yibo will take it for a spin. If not, I'll try to see if I
can get my old testbed to work; but I seem to recall there being a
hardware issue with it, and I don't have physical access anymore, so it
may be beyond rescue...

-Toke

