Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F91B808C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbfISSD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 14:03:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391267AbfISSD7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 14:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568916234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QaO0gOtKhuX+8OlGxkwTLKF5Zg57Hn0VdJHQz1aBUw=;
        b=BJamDPX0Fd7p5hGd5RSXw7b+LwDE6ucTOf5bBZDAqNboIEOu0h5UyODvV0cvpeAgwelCGc
        mqZxfTXRkJLwPVmTCv0NG9Gr1/CD8fy5oqRBVL0QcDm/bVJI1GY72A0T+MDV4uCOPFAbwj
        blXnUyGmZQTmcKiJv9o57mYk7K/kb8c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-QXjd8eOcPmmUhzSzXXqULQ-1; Thu, 19 Sep 2019 14:03:51 -0400
Received: by mail-ed1-f70.google.com with SMTP id 38so2470063edr.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 11:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S2e0JiRNmyIbr4laxcKVUear3+jg87b/DYub7J71vhs=;
        b=cqcUy+uhCOk4C1Oz0Gr0sYW9gfI1K3jz6XlsocbMbOvPHbpANWkeCIuBUHqOlOuGdz
         cBfQLaiI2u/bteJGBSTRlXqTb7zb7h84WBg7RA9Bp87p4W9ZjeqE8qK3kD9+vZywG8oz
         M74NCy77kmOf7oSSko2sjynCB429rNE5HJpePNAo7mF8XWZfy5Ux4IM8HM+huLaxlPs4
         1Ys/QirdRXOrMDHWTmMvfO3g8T25CCpLGF1ZycfXSlgoegUWSEb6WNNN6qE7NRDOJPYs
         woHozHbiWlty0ehktc/AZbkFeh3WaGkmgHRWBdTk1++I8JD8X5ObogwBIzIwkVH0AOV7
         QQ/g==
X-Gm-Message-State: APjAAAVMMVdgOj4WjuMghRQFMztp/3T4HBiEkzjD52G/14BmVTIwW97A
        XDivcUjhwe8hjxhVeqsrXpnxCPFa3Cq3bF8tQjJOCHHbi6vRXHkN7fZgQ+qOtEvL4XDynpnl5XO
        45jnOvRKUTgOLb+/JSsafZqskCkA=
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr8419828edv.225.1568916230744;
        Thu, 19 Sep 2019 11:03:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSyFS5Eo+++nRty//9QBerN1ddFRjy8cLyBjf8Pqw2Lpthi+nUXiZDM7KrgvsgLOjAl26E/Q==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr8419796edv.225.1568916230593;
        Thu, 19 Sep 2019 11:03:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o31sm1745716edd.17.2019.09.19.11.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 11:03:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 71F6118063E; Thu, 19 Sep 2019 20:03:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Peter Oh <peter.oh@eero.com>, Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com> <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com> <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 19 Sep 2019 20:03:49 +0200
Message-ID: <87k1a4duyi.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: QXjd8eOcPmmUhzSzXXqULQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <peter.oh@eero.com> writes:

> On 9/19/19 10:46 AM, Ben Greear wrote:
>> On 9/19/19 10:44 AM, Peter Oh wrote:
>>> On 9/19/19 5:22 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>
>>>> This patch ports that idea over to mac80211. The basic idea is simple
>>>> enough: Whenever we dequeue a packet from the TXQs and send it to the
>>>> driver, we estimate its airtime usage, based on the last recorded TX=
=20
>>>> rate
>>>> of the station that packet is destined for.
>>>
>>> The way to decide the last recorded TX rate could be vary among=20
>>> drivers. In terms of ath10k driver and FW, they use 4 PPDUs to update=
=20
>>> the Tx rate. Isn't it too small sampling number to be used for AQL?
>>
>> Probably it is not exactly the last 4 either, since the report comes=20
>> back indirectly and not
>> synchronized with the tx path?
>>
> The point of my question is "the last recorded Tx raith small nte is
> derived wumber of PPDUs and if it's ok to use it for AQL calculation
> or not".

We're leaving a bit of slack in the system by limiting the buffering to
two aggregates' worth of buffering instead of just one. This is to
prevent starvation in case our estimate is off. In the other direction,
(i.e., if the rate drops suddenly), that will translate to more bloat
until the queue drains. Not much we can do about that; we can only work
with the data we have...

Still, the Google guys reported pretty good results using this method
for ath10k with their out of tree patch. So I think that in many cases,
doing this will be an improvement; obviously, it won't be perfect. But
it beats the 1000 pkt+ queue limit currently in (some versions of)
ath10k firmware.

In an ideal world, the firmware would enforce this minimum queueing
and throttle itself, but, well, sadly we don't live an ideal world...

-Toke

