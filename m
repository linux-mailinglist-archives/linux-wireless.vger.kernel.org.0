Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503BC35F172
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhDNKYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 06:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233660AbhDNKYD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 06:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618395821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZqYT9t2piVtl5gM97DyIAGPrWmtSb/NUDNs5QRC42wM=;
        b=gXLYJvt+J6a1MGYl0Mt4jH691niGF626oG4YEXW1P8XbnO3d8ATfzAviFFJDVdHnoEf24m
        1Mj4CUilgtNc6w1OWjMjwPHivKJIi8ZpeeNNj4L3VkVJkrDf5bZQAWRDb9BuREjI9qjmU4
        oAsGhsCM4veDhSMR+u5olwR7jD/xars=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551--QQxOc5sPdy1NYJq-FYzKA-1; Wed, 14 Apr 2021 06:23:38 -0400
X-MC-Unique: -QQxOc5sPdy1NYJq-FYzKA-1
Received: by mail-ed1-f70.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so3084236edc.12
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 03:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:mime-version:date:user-agent;
        bh=ZqYT9t2piVtl5gM97DyIAGPrWmtSb/NUDNs5QRC42wM=;
        b=ILEGsivZdXpwO8v7jg668fxe04x7Rh0r0sqjS/drfkp9y/Bnij9hBCiT95avYQD/ko
         dsLC0BrO9nN4HFmjT/ocLsanJO9dCUXUtEli68VxpSP9w0aCP9GZHWQXT40GcwQKq49r
         5NspCHgjiUKKTs0d8pyTAbxqKv0ccLG+Q0GxAFBQmKZwgE+rm5QfePpXyK5vyTXdBqZM
         EzrlyXDIZtuUHPxuS2WCtMrLatpnzcJX4ih8EWiF1bYWH87dlk0b/NBGKtdJYLms4CRR
         xtj3abxL0Dw70tkT/rMjodnRur7VhB6yYpo9VPuDxpzHcjiXa02Stn0u83TjJ3NQx3iG
         kVOA==
X-Gm-Message-State: AOAM5335/YgkUiFodLNFrbARymEtBTRtM8SVYYhIMeNdksvMqix0YGd0
        61k84X0H7VReQWBZvB55CqGFXx+fTHbwkPlPPB/w56+gSm/q9TVLOV/fxT3DotgsAaACGvSoQ0d
        w+GgR4kiuiuWRyRDc5W7tqpI7MeU=
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr36563206ejq.416.1618395817419;
        Wed, 14 Apr 2021 03:23:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPWOep4lpgo5xpv3UmoS7D8RInQqAOTTyMPrVKZRqDFmafWvtzv7ssYWxyxgAvQ/82KlupZw==
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr36563190ejq.416.1618395817180;
        Wed, 14 Apr 2021 03:23:37 -0700 (PDT)
Received: from ?IPv6:2a01:c23:bc42:200:9f6:6454:d932:88fe? (dynamic-2a01-0c23-bc42-0200-09f6-6454-d932-88fe.c23.pool.telefonica.de. [2a01:c23:bc42:200:9f6:6454:d932:88fe])
        by smtp.gmail.com with ESMTPSA id n11sm1500061edo.15.2021.04.14.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:23:36 -0700 (PDT)
Message-ID: <bb6eece123644f32e861456f9aa1056a9db78066.camel@redhat.com>
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
From:   Benjamin Berg <bberg@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
         <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
         <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
         <e06b4ca8-6f1f-1c49-5454-b96af9fdd7df@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qnT43y1TaLSgMUIEC6FV"
MIME-Version: 1.0
Date:   Wed, 14 Apr 2021 11:52:26 +0200
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-qnT43y1TaLSgMUIEC6FV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2021-04-14 at 10:17 +0200, Hans de Goede wrote:
> Hi,
>=20
> Adding Benjamin Berg who is one of the gnome-settings-daemon
> maintainers to the Cc.
>=20
> On 4/14/21 9:07 AM, Johannes Berg wrote:
> > On Wed, 2021-04-14 at 05:12 +0000, Grumbach, Emmanuel wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > I've been debugging a userspace rfkill issue today which boils
> > > > down
> > > > to the
> > > > "rfkill: add a reason to the HW rfkill state" patch:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?i
> > > > d=3D14486c82612a177cb910980c70ba900827ca0894
> > > > breaking userspace.
> > >=20
> > > This has been rolled back by:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/co=
mmit/?id=3D71826654ce40112f0651b6f4e94c422354f4adb6
> > > Other userspace broke (systemd) so Johannes rolled this back by
> > > default.
>=20
> I see, but this change is not in:
>=20
> kernel-headers-5.11.11-300.fc34.x86_64
>=20
> Meaning that basically all of Fedora 34 has been built with the "bad"
> headers.
>=20
> > > Userspace that is interested in the new byte will read 9 bytes.
> >=20
> > Which, unfortunately, doesn't address *this* particular case, because
> > it
> > uses gio and that will fill the buffer with arbitrary size?
> >=20
> > When you (Hans) say you saw in strace a read of size 8, did you mean
> > the
> > size passed to it, or the return size? I guess it must be the return
> > size, and the size passed to it was way larger.
>=20
> No for some reason, for some later read calls gio was actually passing
> 8 as size to the read() syscall. And g-s-d was compiled with headers
> where sizeof(struct rfkill_event) was 9. This is/was the issue, g-s-d
> would do 2 read(fd, buf, 8) calls and then take the first 9 bytes read
> out of the 16 bytes it got to fill a single rfkill_event which is fine,
> except that it uses the remaining 7 bytes as the first 7 bytes of the
> next rfkill_event which it processes making that next event be
> completely bogus.
>=20
> I do believe this really is a g-s-d bug though, it should not have
> been using a "buffered" gio-channel on a /dev/foo node; and so far it
> only got away with this by the rfkill_event size being a nice power of
> 2 value.
>=20
> As I mentioned in an email to Benjamin, g-s-d should really switch
> to making direct read() calls on the fd circumventing the gio-channel
> read code all together:
>=20
> "Right, notice I just realized that even after my fix there still is an
> issue, when running code compiled against new kernel headers gsd-rfkill
> will now always expect 9 bytes per event. But when running on an older
> kernel that will not be true.

This confuses me. i.e. if g-s-d is compiled against headers where the
struct is 9 bytes long, then we should just be getting a short read of
8 bytes. And that should be the same, whether we use plain read() or
g_io_channel_read_chars().

I was under the impression that with
  https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/232
merged, the read should be fine on the GNOME side.

That said, the g-s-d event handler is checking the size of the read
against the struct size. This is obviously wrong, it should only check
that the read was successful (or check for >=3D V1 size).

Benjamin

> To fix this the code should probably just directly call read() itself
> on the fd (only using g_io_channel for the polling) and then accept
> anything
> between 8 bytes and sizeof(struct rfkill_event) as valid return value
> from the
> read() call..."
>=20
> Notice that the problem which I described there will go away when
> compiled
> against even newer kernel-headers where sizeof(struct rfkill_event) is
> back to 8 again.
>=20
> So question, for code like g-s-d, which does not care about the new
> hard_block_reasons field. What would be the preferred / max
> compatibility
> way to do the reads. Also keeping in mind that there are "bad" kernel
> headers out there where sizeof(struct rfkill_event) =3D=3D 9 ?
>=20
> I think that this would be best:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D read(fd, &event, =
RFKILL_EVENT_SIZE_V1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D RFKILL_EVE=
NT_SIZE_V1) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* Valid event process it */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> This should produce the same code regardless of the kernel-headers
> version
> and should work on both old and new kernels, correct ?
>=20
> > The commit Emmanuel linked to fixes cases such as systemd that were
> > just
> > completely garbage (reading with one size, and then checking they got
> > another), but it wouldn't fix this case.
> >=20
> > Unfortunately, as you also said, it does seem a bit late now - it's
> > been
> > released in various kernels since 5.10, and while the default
> > rollback
> > will improve the situation somewhat, read(..., size>8) will still
> > return
> > 9 bytes rather than 8 as it used to. Switching that *also* back
> > *should*
> > be safe, but who knows what other bugs were introduced in the
> > meantime?
> >=20
> > I certainly don't really have a major objection to rolling that also
> > back, but would it really help that much at this point? I guess it
> > could
> > be going into 5.10/5.11 stable kernels though.
>=20
> I don't think that rolling back the new extended-event support
> altogether
> will help. Since this has been out there for 2 released kernel versions
> now, I believe the best way to fix this is to fix userspace; and to fix
> userspace in such a way (at least g-s-d) that this problem cannot
> happen again.
>=20
> Regards,
>=20
> Hans
>=20


--=-qnT43y1TaLSgMUIEC6FV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmB2uuIACgkQq6ZWhpmF
Y3DWXA//fWlIQ68wpHR3yd05Btw3phYNLQT3VyTD1RkuNliS2QhiSA+j5NDOZ50J
QePW3YDBC/iJdr3quFlmAh7WbspGodhXPA3Ay6oVMu2z5zE3yW+LxUmuNbosRTb2
uerltCON7bxc7JGfmhERnEP90zShaBGY7FHZ/y2tUVfzxUuZyaO+qzr+/kkxVKxm
dW2L0j0egKHlBIcKiT5RosPrZn07vZqa3M4t88BMNV/9UYyhzrVXFp/gwFJtIzux
Bj+BpICACnQ1FOmzk9gtGoeXg7bP7poDQxHpIK1HRp7JfIMLb5qAMZzOu6uj+VGZ
kWkPm6BV+gUdleYRBhKcgVQLI2iQe+qKg9eStL92+UBPnnQ4laaetrZy2ZPlqxkQ
lWyLNy4abwhY5RzeW4HTFxDN+OcSAoLseU6WQ6F7MJP/svNuu+kYo/WGQQex8lIL
1Qd/V7pix8w10GfDOv6MhLAWaREpuBKDwUda6dkBo2BhFkIFP2U/aFgCJI/N6EeT
SAQRaoutInO9pS9+A+YWGF3mZuL/6P9yi2La9q3vyD6gMEIg8GEK0dhGDh9C7miM
izc/69VqR7eeLC0BfMVLLkkoMO++pjCfuhNDo2/N6e505NOu8pYts/Fez/YOtEtt
EB8HIkFnTCSD0OzF7b1suDMa0DtTcKslmI/ootUKsugJ/WmOXQs=
=7LQB
-----END PGP SIGNATURE-----

--=-qnT43y1TaLSgMUIEC6FV--

