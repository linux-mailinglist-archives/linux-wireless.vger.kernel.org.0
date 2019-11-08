Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD36AF4511
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKHKzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:55:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52738 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbfKHKzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573210540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsPfNwlAkGOPfmWxI5u777tBP7n0JZnEAYYAZmhM14E=;
        b=NHV9K5Ztv0xnFig0glSuA//YhiyYpfDZvtH9EyD+zxcs7KR1Nq69x7AC1XvrhMnj+qA5oo
        MnfpKVYS8ICyut6WwgZUH+TxOcDMSTu8YANMr0ecwdD7TQkt8pN8H40mFFELoLetzFh/YN
        urwMGm+eyo7u0zlPQk9WjaRD0Vh7Wzw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Z90XCaXJPWyH33a6R9uQpA-1; Fri, 08 Nov 2019 05:55:39 -0500
Received: by mail-lf1-f70.google.com with SMTP id d11so1232048lfj.3
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 02:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YJrXGtCnMlroIEY2nnixcaaDlLt4fqJ7BPUU7uurxtY=;
        b=hdX9kce5AY/iLBFFkCVef9CVZgQ61i7c4lB/EkL7JZg3tv+0UTlM/RAdN9jxpjuQAo
         3iotzANqzRGS2LKOUoJioF5Ji+DJ47P8+pdqKozAXDKOtsTvDbjPjz2yS3MGeRdFamn4
         4P8XtcREjSuRs2+uRmlv18md+Qp9jN0O/Icf7SnumWAi7Cuz/UwYoXQL92RRdvQuYRMY
         C9GvCCKhCdiBCAibCk1GxJDLmHq0bgQ1XhFqeimwkuVRX7Doxhpdg+YQ4joELjmPwP8+
         oE4Vy5OhOGPeoqq7hd/3hxGHCMIwLpLSHKzA0DJqWqJ4713A8zq05WjTelmtbKn5utLg
         Iocg==
X-Gm-Message-State: APjAAAVBa1ypt3VKREXoshyKU7irJ7bavXlKgUvYBmtRjOx8T15XJKJT
        ueujcggri7DVK3cCpC8Z8vX/Gy3Hr5SGmMYSc0LFtqrpZaYfIpYeggPcTK0Grhfm/JD1nc369fO
        jYWwr8B/fhoBFItU780wbCDouPzg=
X-Received: by 2002:a2e:998a:: with SMTP id w10mr6332841lji.66.1573210537774;
        Fri, 08 Nov 2019 02:55:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEGKU7zYVEzHqvutjPdhb0Ch2cJ7Jo3JKjhWNBQYUJrGbfwFRDp8nlKlaaBjRUW80eWrShhw==
X-Received: by 2002:a2e:998a:: with SMTP id w10mr6332815lji.66.1573210537418;
        Fri, 08 Nov 2019 02:55:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v12sm2326039ljg.14.2019.11.08.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 02:55:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D26D61818B5; Fri,  8 Nov 2019 11:55:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v6 2/4] mac80211: Import airtime calculation code from mt76
In-Reply-To: <42266e95f45d5772e04c9c016bd6179ea14ffefa.camel@sipsolutions.net>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <157182474174.150713.17459330922820192258.stgit@toke.dk> <42266e95f45d5772e04c9c016bd6179ea14ffefa.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 11:55:35 +0100
Message-ID: <87d0e2fxi0.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Z90XCaXJPWyH33a6R9uQpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-10-23 at 11:59 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Felix recently added code to calculate airtime of packets to the mt76
>> driver. Import this into mac80211 so we can use it for airtime queue lim=
it
>> calculations later.
>>=20
>> The airtime.c file is copied verbatim from the mt76 driver, and adjusted=
 to
>> use mac80211 data structures instead (which is fairly straight forward).
>> The per-rate TX rate calculation is split out to its own
>> function (ieee80211_calc_tx_airtime_rate()) so it can be used directly f=
or
>> the AQL calculations added in a subsequent patch.
>
> Any way it could be exposed by mac80211 back to the drivers, perhaps, to
> share it?

Didn't I already export some of the functions? My intention was to do
that, certainly, and to patch mt76 to switch to using them once the
trees have converged...

>> The only thing that it was not possible to port directly was the bit tha=
t
>> read the internal driver flags of struct ieee80211_rate to determine
>> whether a rate is using CCK or OFDM encoding. Instead, just look at the
>> rate index, since at least mt76 and ath10k both seem to have the same
>> number of CCK rates (4) in their tables.
>
> This is highly questionable ...
>
>> +=09switch (status->encoding) {
>> +=09case RX_ENC_LEGACY:
>> +=09=09if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
>> +=09=09=09return 0;
>> +
>> +=09=09sband =3D hw->wiphy->bands[status->band];
>> +=09=09if (!sband || status->rate_idx > sband->n_bitrates)
>> +=09=09=09return 0;
>> +
>> +=09=09rate =3D &sband->bitrates[status->rate_idx];
>> +=09=09cck =3D (status->rate_idx < CCK_NUM_RATES);

Heh, yeah this did feel like a hack to me as well ;)

> Why not
>
> =09cck =3D rate->flags & IEEE80211_RATE_MANDATORY_B;
>
> I mean .. we know that IEEE80211_RATE_MANDATORY_B rates are exactly the
> CCK rates, and that's not really going to change?
>
> Alternatively, we could do
>
> =09cck =3D sband->band =3D=3D NL80211_BAND_2GHZ &&
> =09      !(rate->flags & IEEE80211_RATE_ERP_G);
>
> or even
>
> =09cck =3D rate->bitrate =3D=3D 10 || rate->bitrate =3D=3D 20 ||
> =09      rate->bitrate =3D=3D 55 || rate->bitrate =3D=3D 110;

I am fine with either of those; I just wasn't sure what assumptions I
could actually make here. I guess I'll just pick one :)

>> +=09default:
>> +=09=09WARN_ON_ONCE(1);
>
> You can't do that in mac80211 either. That might be fine for mt76, but
> mac80211 already supports HE.

Good point, will fix.

-Toke

