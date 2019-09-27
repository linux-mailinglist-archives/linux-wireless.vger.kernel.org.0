Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5169C01B8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfI0JE0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 05:04:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfI0JE0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 05:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569575065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgIXk/C0RvbgqRAB7AXeg1r0pOMpXKTq3L1nU4U+SDY=;
        b=SotUTHVcqEzgILVzgF8PP4XOFolylaeQ9EPuKo80ceUheqTrylKv55KhFUJLI+J984j8jQ
        bD4aTMg/M4Lc18f1AIY3moPs3Rb3ld80F0uVrnhW754smQXl/8tZVzJiOjN2CBeUesn2K4
        0cIrpt4PKEe2+WPJSqcoXaCqNXOT99g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-XRYb-OhYP7WzSFm4wnF1Qg-1; Fri, 27 Sep 2019 05:04:23 -0400
Received: by mail-ed1-f72.google.com with SMTP id l9so1226859edi.8
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 02:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pE0xQ2NrWaIiQjMQcmvx2PhMOt4W7LUdJ1yd9KBMJh8=;
        b=gzaepWAjs6V8xS/0/Qq5wvG1o2/oKxNnwxvOsvOiZLISdDQDNqAzqXxRsAA7Gp+VZY
         ZmWGuSW6rGsz5z3iUVj0mtyBWQfyk3Rd3T3JlHthH2i/rGJ4cgfrhqCOeXun3Sk+Bvx+
         0JJIfSA7bgeM+DFeyPmrJRxFyGJxOJRzhwy9Ipb+PyfOc2knq/6LYECEX3yDEBkzScAq
         Z6qXyF9bn2QEs1alWYhmo8yM48QkOtEIAK/Um7gT5aUwZQ8apdoZWfsmK/Lfkn6RpYzu
         sdx1ou9eZC60ik4w26w+HS68fchDxS+9s6em8vhYU3R7zNUl97Iv6e8MT3dK91hzGwp1
         rgdQ==
X-Gm-Message-State: APjAAAUsTeBtrxsvTpRiN3TRVmZY626c4DNFMSQE58un6zn3tMW3XZnN
        /Hc8Cqp9x54Lq0bHKIyKiXvVdSscQVcvsgBikRaih4cberPNhmBLrSX1xrDVI2xOj0fVeRqIkzG
        QsYkc0PUCy8/VdozM+l58AOfmFX4=
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr3295946edr.82.1569575062786;
        Fri, 27 Sep 2019 02:04:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgd0Z3jgwod8XHElE4wcAaJUfr4Y4xvPIHfy7X6/OrPkoK7Eo28ipkrh7RW2NJz87tEZOkPg==
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr3295933edr.82.1569575062624;
        Fri, 27 Sep 2019 02:04:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b12sm390134edq.75.2019.09.27.02.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:04:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 37F7218063D; Fri, 27 Sep 2019 11:04:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/15] mt76: track rx airtime for airtime fairness and survey
In-Reply-To: <6af9b976-48e8-64c2-dffe-b3eaa03b9c73@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-5-nbd@nbd.name> <87v9teyw40.fsf@toke.dk> <6af9b976-48e8-64c2-dffe-b3eaa03b9c73@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 11:04:21 +0200
Message-ID: <87pnjmyusq.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: XRYb-OhYP7WzSFm4wnF1Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-27 10:35, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>> +=09switch (status->encoding) {
>>> +=09case RX_ENC_LEGACY:
>>> +=09=09if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
>>> +=09=09=09return 0;
>>> +
>>> +=09=09sband =3D dev->hw->wiphy->bands[status->band];
>>> +=09=09if (!sband || status->rate_idx > sband->n_bitrates)
>>> +=09=09=09return 0;
>>> +
>>> +=09=09rate =3D &sband->bitrates[status->rate_idx];
>>> +
>>> +=09=09return mt76_calc_legacy_rate_duration(rate, sp, len);
>>> +=09case RX_ENC_VHT:
>>> +=09=09streams =3D status->nss;
>>> +=09=09idx =3D status->rate_idx;
>>> +=09=09group =3D VHT_GROUP_IDX(streams, sgi, bw);
>>> +=09=09break;
>>> +=09case RX_ENC_HT:
>>> +=09=09streams =3D ((status->rate_idx >> 3) & 3) + 1;
>>> +=09=09idx =3D status->rate_idx & 7;
>>> +=09=09group =3D HT_GROUP_IDX(streams, sgi, bw);
>>> +=09=09break;
>>> +=09default:
>>> +=09=09WARN_ON_ONCE(1);
>>> +=09=09return 0;
>>> +=09}
>>> +
>>> +=09if (WARN_ON_ONCE(streams > 4))
>>> +=09=09return 0;
>>> +
>>> +=09duration =3D airtime_mcs_groups[group].duration[idx];
>>> +=09duration <<=3D airtime_mcs_groups[group].shift;
>>> +=09duration *=3D len;
>>> +=09duration /=3D AVG_PKT_SIZE;
>>> +=09duration /=3D 1024;
>>=20
>> On an earlier patch of mine you expressed concern over divisions in the
>> fast path. Does this mean this is no longer a concern? Or is the
>> compiler doing fancy things with the constant division here? :)
> I made the constants power-of-2, so that the compiler can turn them into
> bit shifts. I verified the disassembly: no divisions left in the code.

I see. Neat :)

There's still a regular division in the legacy rate calc further up,
though, right? But I guess that doesn't happen so often?

-Toke

