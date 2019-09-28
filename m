Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6167BC1099
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2019 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfI1KbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Sep 2019 06:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725932AbfI1KbM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Sep 2019 06:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569666671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pg4aLmP+lQVloEyALWu2QAwwXPoYhKHnJnWEpNq5AmM=;
        b=Oz6s3kGYq0ktekYxRdVLvlcsW0tUTC5hK7YWB8Db/vieEDdjSiJvJOFEyNbTpV1HCTiBkH
        s+1TVCZEAD+xBTkO65K/jospD2eLlpQijbc5/kvvE4NqdehKhf28iB55BYIiH7EApFDdjo
        /6W68j0Gds2caDRLbHkxqizQvFfI4BQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ubUGCaurO4O_arzegUaROw-1; Sat, 28 Sep 2019 06:31:09 -0400
Received: by mail-lj1-f197.google.com with SMTP id j10so1692501lja.21
        for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2019 03:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gcwSMxQXdG//mLXUyojzY5QJJkrtTJZKwKrM2hD/Fak=;
        b=R5QZB2hvWBkK1abdcKpihpPibeItfFWLgexm6cvaHFA1Y4zrsmz/MprCa2winDh8QV
         eJ59tiSmZhZ9ucSBXbtZ7HRK8KsY9YMBWVOyRvho+DdGXJhP6G+GjkDK5Cpo5heZOJBB
         X5yOV6bNpsOGlQDBe0AzW1MvkQR88Ld5XxmMWeOjCqCKkbkyNnDXn3KCi7sod1e1eXFH
         nvQnZWdo4aEBortEjgfSyAcC/g/Dy+QjfKrrGf4DrfoH/IOBBEpYBw73XpNfpoYluHZz
         3kOwWOkvqTVM01CSYhG1ozj8jgVGC4t7R+qUH+O49UT3Jd0SEvZPZbvxNd7r2aEEoDhh
         K4bA==
X-Gm-Message-State: APjAAAWNsiQpN1BxqnIqpOh1rgclCWnf+DDGOROmENy9EXDAeK6S983B
        pbmS6gUFs/59Xef76KUKzzjA9t2uQzUPxk6Ty7G26rEW2uMjuCAG7IYaqUIeBwfrCgRrKPFw8hh
        sfea6oQEDRZuWpeJHTxRkxukxwkY=
X-Received: by 2002:a2e:442:: with SMTP id 63mr6061818lje.66.1569666667332;
        Sat, 28 Sep 2019 03:31:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxknWmcA03yDjCsxkv9NZ+N9omHeF658VVk2x1oyK0LJIsFKJo9Gd2mjqHPE+mrSzhUhvnK0g==
X-Received: by 2002:a2e:442:: with SMTP id 63mr6061809lje.66.1569666667150;
        Sat, 28 Sep 2019 03:31:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n8sm1219319lfk.21.2019.09.28.03.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 03:31:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D907418063D; Sat, 28 Sep 2019 12:31:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
In-Reply-To: <88a9f47b-143e-d266-d5d8-606bcb6365cc@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-10-nbd@nbd.name> <871rw218ty.fsf@toke.dk> <2475938e-b82c-9924-f7db-f475ec2530b3@nbd.name> <87sgoiyw0p.fsf@toke.dk> <27bb95dd-1f0e-5862-3616-04452808e736@nbd.name> <87mueqyunz.fsf@toke.dk> <88a9f47b-143e-d266-d5d8-606bcb6365cc@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 28 Sep 2019 12:31:04 +0200
Message-ID: <87blv4zp93.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ubUGCaurO4O_arzegUaROw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-27 11:07, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> On 2019-09-27 10:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>=20
>>>>> On 2019-09-27 09:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>>>=20
>>>>>>> Estimate by calculating duration for EWMA packet size + estimated A=
-MPDU
>>>>>>> length on tx status events
>>>>>>=20
>>>>>> Would it make sense to move some of this code into mac80211? If we'r=
e
>>>>>> going to do airtime estimation for queue limiting it may make sense =
to
>>>>>> use this instead of the simplistic estimate I used in my RFC patch?
>>>>> Sure. I mainly put it in the driver because I wanted to get it workin=
g,
>>>>> tested and merged first without having to wait for a mac80211-next ->
>>>>> wireless-drivers-next merge.
>>>>=20
>>>> Right, OK. So that means another patch set on top of this to move it
>>>> afterwards? Don't suppose you can be convinced to take care of that as
>>>> well? :)
>>> I could, but I don't know when I will have time for it, since my plate
>>> is pretty full at the moment.
>>=20
>> Heh, I was afraid you'd say that. That makes two of us; guess we'll see
>> who gets around to it first, then :)
>>=20
>> Is there anything in your new airtime.c that is mt76-specific apart from
>> the struct mt76_dev and struct mt76_rx_status parameters?
> No, I made it as generic as possible to make it easy to move to
> mac80211. mt76_rx_status mirrors ieee80211_rx_status very closely, and
> going from mt76_dev to ieee80211_hw is easy as well.

Awesome, thanks!

-Toke

