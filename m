Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7389635F19C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 12:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhDNKqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 06:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233163AbhDNKqh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 06:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618397175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxzptn/WNWZbZmaKTU3YqWDaB+C5Qm75i3ZcmOQN6Ko=;
        b=M/eYEfwyG16WiVQQ4Vwv9dLm1StponsDW5qIL1lp9MIYqLeiYN6kml4hJj8tX65frwWHZY
        GCWTKnqbvjE4V0YcS8cKI/GEJYaAWYfcDrkIS0uZB6BND5XyxPtn7Y4ffk+676RciPTdOm
        X2ES3RCWQZKynRs+rcgUhlASJ9uo1tM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-U9peeBUnM5eXvlG1BVkaUA-1; Wed, 14 Apr 2021 06:46:10 -0400
X-MC-Unique: U9peeBUnM5eXvlG1BVkaUA-1
Received: by mail-ed1-f70.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so3090525edr.20
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 03:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=qxzptn/WNWZbZmaKTU3YqWDaB+C5Qm75i3ZcmOQN6Ko=;
        b=PA01ca8LPaV4r6AciVCUF83V599ponNcONbWDLKxmBP++N7xjEJ1WUyfGobr17b5vc
         1qPdbhZ6h5PsHHGyCihaU56L2hLjUb/m4tj8tJ2uEm/vzG9bsDhoVjiO5SgU5rGSdPPW
         VbPHHiwokNHTsEBAZn6GNkGN1NQvPPxeuXa/6Y9Byk4DVzx8zGOLNCVMt6mn8tOWVM8+
         CIh+c8Ldo/kSJfeGhwXDvq//OqONyxMzzy+TQTuJ3Tg4fQPNO3qZLEhnuWPpiR/IICur
         0uOyAB89RfT/LR5aBOWJS0X/v8pXRVoWOr47vLmjdE9NTAV24FpAZgtENC89YK6+DaiR
         0ELg==
X-Gm-Message-State: AOAM5338WEkB+bdk8OHCaPRAcRw4T7xR/H1adJOE63+TUskuH1r4MnYL
        Oup53p9JZGHdnL11Vx/srDGsQT0Cm7p26LG1i2NDx00x4fEfAAlfzfr8pq/clLyN7HjI80aM04V
        dTt4iJIDK6Y5pbw74Wy6RRKtsu0A=
X-Received: by 2002:a17:906:7fd3:: with SMTP id r19mr11687198ejs.286.1618397169544;
        Wed, 14 Apr 2021 03:46:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv6mH3sQshcfB9ir8Zq8WD8JOqW7xgtt5YKhaGTwbVVDINDhtdC4sl7Aa3WfBXBu6pf6fZXg==
X-Received: by 2002:a17:906:7fd3:: with SMTP id r19mr11687185ejs.286.1618397169412;
        Wed, 14 Apr 2021 03:46:09 -0700 (PDT)
Received: from ?IPv6:2a01:c23:bc42:200:9f6:6454:d932:88fe? (dynamic-2a01-0c23-bc42-0200-09f6-6454-d932-88fe.c23.pool.telefonica.de. [2a01:c23:bc42:200:9f6:6454:d932:88fe])
        by smtp.gmail.com with ESMTPSA id cq26sm11601748edb.60.2021.04.14.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:46:08 -0700 (PDT)
Message-ID: <e9e7425cf7bbbf20f0dac74e222d28f747216804.camel@redhat.com>
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
From:   Benjamin Berg <bberg@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 14 Apr 2021 12:46:07 +0200
In-Reply-To: <b3273466-7978-241f-9773-56cd87490a9b@redhat.com>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
         <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
         <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
         <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
         <bb6eece123644f32e861456f9aa1056a9db78066.camel@redhat.com>
         <b3273466-7978-241f-9773-56cd87490a9b@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/f/SYqvIY9aNtepX36bE"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-/f/SYqvIY9aNtepX36bE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2021-04-14 at 12:29 +0200, Hans de Goede wrote:
> On 4/14/21 11:52 AM, Benjamin Berg wrote:
> > [SNIP]
> >=20
> > That said, the g-s-d event handler is checking the size of the read
> > against the struct size. This is obviously wrong, it should only
> > check
> > that the read was successful (or check for >=3D V1 size).
>=20
> Right this is what I was referring to a g-s-d compiled against the
> new headers with a struct size of 9 will read 8 bytes on an old
> kernel
> and that will fail the len check, so it won't work.
>=20
> But this will actually never happen as I just noticed that g-s-d
> uses a private rfkill.h copy with the old 8 bytes struct definition.
>=20
> So with the buffered-io disabled everything should work fine,
> see my other email in this thread.

OK, so at least that part of the fix should be backported to older
release branches.

> We should probably still fix / clean the code a bit though, as
> you are working on in:
>  =20
> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/234

Yeah, the code there is somewhat messy overall. It could probably be
improved more than the MR does, but hopefully at least the biggest
inconsistencies are gone now.

Benjamin

--=-/f/SYqvIY9aNtepX36bE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmB2x+8ACgkQq6ZWhpmF
Y3BMyRAA2GbVGUiyG1mAn3Uzu/Wp79FAlGhu7q7QFUumi3OEHWoyz+NnYnWCur7r
1tc2U0ZD9wYUA33NPpH6wDxD5Hh09MX0nYyuYLLnguY9IC93bNAzflvthyQUbQG6
ZKQg8JBvH+LzV/RTcMUF81c7Zu41BecAeW7N4mXP/T76DkzS4m6zGQ+Lk6XuebxW
ESaHnsz7IPcdkCBFHfyJbjRRciPaLemCZi9CPO2jYC6FjB/5QFQnSrBVk6RJLGom
NUC54+a03QvlHnksl/YtHEH8ZJ54PaInxnZhy7Kqpz9C0FNp0iIhMPH84tqstz2H
CPCQm2UdZFwVURPpdmCgzDJiLa4wOVSPaHrYSpo+858DHVVzX8wgQL7vhUEGcTJ5
Rpt1uS7eSrvcRr55PtivQD+CgMID4E6/n96lzvmqOz5MFF8nI3JECsngpTq3yfT2
dj2udgGDmGMBQOxQiloMYHL8zQP3qUfZDBV3IRqpkYAj2sZLkO5whYpUhr3G2olq
jAP9kcYapj8IXvMIrb7jl9HNj5hEkZ5fxLIAABpCt5buV+YNFV8ynJft3na6IPHn
rBzM262Zy1B7SqwbD9CXQQHOpl0yOt3SuE/MeFrOHPFeWbjSQfHvua4Ogq+8JN2u
40HCz3LVDoEbFPt30oPyWCH1fSrguybhIDib0YHGJv9F8EYAdhE=
=HHBN
-----END PGP SIGNATURE-----

--=-/f/SYqvIY9aNtepX36bE--

