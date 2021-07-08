Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8593C1B54
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhGHWFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 18:05:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:40801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhGHWFI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 18:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625781743;
        bh=+GjNuMQByRgziynhFmap4POwPAnwXffpyKdziI+Cifo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=IAwdp8bV/+33iiTHN5xK8EnYhRCxeyNDLfwqrLNyZgMllnNHuFoRqxlpt/z6LXGNX
         DZyhMxSCOLutHKzaPDHNsesDAeUIaoxHNfcRQe3kiXixNqXCaLY4/IiKntwPSkgRQA
         fX54pRA+WqXdomNdHTqJQSITVy3aR9fhMciRvwMs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.78]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1lXDQf3iCV-00hvas; Fri, 09
 Jul 2021 00:02:22 +0200
Date:   Fri, 9 Jul 2021 00:02:21 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Petrosilius <petrosilius@posteo.de>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 &
 10MHz Bandwidth
Message-ID: <20210709000221.59899317@gmx.net>
In-Reply-To: <b98ffbe2-7995-9783-c74f-af1b5f32f575@dd-wrt.com>
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
        <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
        <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
        <b98ffbe2-7995-9783-c74f-af1b5f32f575@dd-wrt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02m8dgxxsKPfaAD0qSrERW8vHVJMdtogLboTmZRIDoSmrOskLbX
 nlBROJulK2GWaXUIEjMCNTgXu/Kc9bd4mhDIUUaK6uxGKARfVH5bYHioeAg5eplkJceP9Ky
 s7Ka/VqbynlfueqfZsbT/39c1MgrcZ//faVBE6YPAFK7CKKoqj1FiFIx4DCHIvuFuREdY02
 9dirjSW81aquAbuh7vU6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5DtBEHTQzA=:JNEFJqD+wOwdSAgOCXQtdr
 8t0ToboGG5vrbDk5Wg5QZOZERh529xw3yrqiXhW8FfrVvW0ibRf3Xg0eBp0GdE85U+/lczQ8W
 Cg1tNeKw9jw1CeDy380IrS2gCFGJy+NvIDNR37o9+zRxJO+eCf+0YUWqcXBfnlZ3i+CnSvzgG
 CgXXci/3S741+ndD08qUdhB9FWWIXswV/Au0TI2r2tQeov1cZQMLIjjnU2El9ueV3CiF3r6+/
 YxYwqF2u8Y+ixL9V1B5dv6IKEDyTwzEFGXyTc88ilNLYoNhIr9OiDHyQNZA5Pa+H4G0C41Zo3
 gPg0vwpdYtyIs/IMcZ3DpnXYw96rX+aC1pbakhX0q6E372pc99nJmE7+Go3ihlnJmjKGV5j38
 zzpy6WJrIMIrEYsX8rPvoTq+n7JmhU/SYQBcaFnQsgyHsbC+3aIWiZn7tsX2T2M41wyu57Zmz
 6ZaIqcaqi0I6/ZtxWyGUvoqZVvfkwvlFOZQOoX5mZHARc/NDYtp19MoyA04SXoL/UQqPmZzXA
 mAKlAuAANSlinHJS/UzYqIb0i4TZUM5sLIbqxoyUZo0DY6z07vaXP/87hN2z09d4LvpYsGA9F
 CJ6w1KdQWDX8rxITSJ8LwPJYiagJMIls89F1Ds+6oQHrMmA/Iec+vC/mXdCJ6fJLC+r/QMwVy
 YXVFIe12WZEXsGr/u7R3jXDOz5jQbt17W5u6G/FsdKwDxDVFNcJoQJ8ytmE8xbC7NyPpo4r0H
 4Hfa4b9EwRxWf6HFBgjbOfSS6H8YqUtZyAciZoEowvJ3bQs9s6e43pgbphqVkltb7tXpjBduT
 7k2v1tZZpWVnWw8ntng4GMS6WJEOtGGzCVmDZn989G/cVMx3DFHkVli6oas7IdCp52UqHibbJ
 xR+N5W3SkxFVsgWQoKa1Y/kxIj6qFtDCINTSmrHfrW+Dn+a9IAkdbFLTtE2wn4arPsKGpR3Ea
 IfhnBkD5I99Vvl7RWu0BW8KIgs9/PX4WkuQPi4OFvOqh5rmNRM54kNode+EkmaeUvLuJYT9Ve
 Qlk+ow8U5jJoH6WMZQrZYU/p8lesVgDqF2LcErob8Ri83XsAJBkiSypawk5m9OM35rADRUlQl
 9AiJe8LmMgDkx4z7kv9WP6Bc976Yp1t8UJm
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello *,

On Tue, 22 Jun 2021 12:40:31 +0200, Sebastian Gottschall <s.gottschall@dd-w=
rt.com> wrote:

> just some cents from me. i modified the algorithm a long time ago since=20
> the dynack way ath9k was going was not correct.
> i will look if it can make a patch out of my experiences, but dont=20
> expect it within the next 2 days.
>=20
> Am 22.06.2021 um 12:12 schrieb Petrosilius:
> > On 22.06.21 11:54, Koen Vandeputte wrote: =20
> >> On 18.06.21 13:13, Petrosilius wrote: =20
> >>> Hello Lorenzo Bianconi,
> >>>
> >>> we are running a set of R11e-2HPnD devices and having trouble getting
> >>> dynack working properly.
> >>> Setup:
> >>> * linux-5.4.123
> >>> * OpenWRT (current development branch) with wireless backports-5.10.3=
4-1
> >>> * distance 2m between ap and sta
> >>> * Low ambient noise wifi environment
> >>> We experienced some non working dynack or low performance in the
> >>> connection due to too high calculated ackto's.
> >>>
> >>> Here is a ath9k debug output example for a non working dynack @ 10Mhz
> >>> BW:
> >>>
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.500427] =
ath: phy0:
> >>> {48:8f:5a:3c:bb:03} tx sample 44905341 [dur 8720][h 29-t 30]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.500437] =
ath: phy0:
> >>> ack_ts 44844835 st_ts 44905341 st_dur 8720 [17-29]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.500445] =
ath: phy0:
> >>> ack_ts 44923425 st_ts 44905341 st_dur ackto.tar8720 [18-29]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.554642] =
ath: phy0: rx
> >>> sample 44977693 [h 18-t 20]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.554701] =
ath: phy0:
> >>> {48:8f:5a:3c:bb:03} tx sample 44964984 [dur 6032][h 30-t 31]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.554710] =
ath: phy0:
> >>> ack_ts 44923425 st_ts 44964984 st_dur 6032 [18-30]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.554718] =
ath: phy0:
> >>> ack_ts 44977693 st_ts 44964984 st_dur 6032 [19-30]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.577890] =
ath: phy0: rx
> >>> sample 45000939 [h 19-t 21]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.577946] =
ath: phy0:
> >>> {48:8f:5a:3c:bb:03} tx sample 44998471 [dur 912][h 31-t 32]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.577956] =
ath: phy0:
> >>> ack_ts 44977693 st_ts 44998471 st_dur 912 [19-31]
> >>> Wed Jun=C2=A0 2 19:08:50 2021 kern.debug kernel: [=C2=A0 400.577964] =
ath: phy0:
> >>> ack_ts 45000939 st_ts 44998471 st_dur 912 [20-31]
> >>>
> >>> THe above output is generated in dynack.c by
> >>>
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ath_dbg(ath9k_hw_common(=
ah), DYNACK,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "ack_=
ts %u st_ts %u st_dur %u [%u-%u]\n",
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ack_t=
s, st_ts->tstamp, st_ts->dur,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 da->a=
ck_rbf.h_rb, da->st_rbf.h_rb);
> >>>
> >>> The ackto is afterwards calculated by
> >>>
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ack_ts > st_ts->tsta=
mp + st_ts->dur) {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ackto=
 =3D ack_ts - st_ts->tstamp - st_ts->dur;
> >>>
> >>> Filling in the values of the first sample:
> >>>
> >>> (ack_ts > st_ts->tstamp + st_ts->dur) ?
> >>> (44844835 > 44905341+8720) ?
> >>> (44844835 > 44914061) ? ... not given
> >>>
> >>> Therefore a new ackto is not calculated and i can also see that in the
> >>> ack_to file:
> >>>
> >>> 600 A
> >>> 600 A
> >>> 600 A
> >>> ...
> >>>
> >>> These look like the default values to me (and do not change), but
> >>> ath_dynack_get_max_to() should return 750 A for our 10MHz BW case - t=
his
> >>> looks also suspecious to me.
> >>>
> >>> For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a bit =
too
> >>> high to me) but the performance is way below expectation (<1MBit)
> >>> For 20 MHz bandwidth there is a ackto calculated (51 A) and the
> >>> performance is fitting the expectation.
> >>> If you want to take a look at the logs for each of these cases for ap
> >>> and sta, you can download them here:
> >>> https://cloud.hs-augsburg.de/s/eworxkJoL6JXYzZ
> >>>
> >>> Did anyone else experience such a behaviour on non 20MHz Channels or
> >>> does anyone have an idea on where this behaviour might originate from?
> >>> I am not experienced in the ath9k driver code, but a uneducated guess
> >>> might be that the ring buffer where the dynack algorithm is taking its
> >>> frame-samples from is not behaving as expected for the 5&10MHz case.
> >>>
> >>> regards,
> >>> julian dorner =20
> >> Are you stressing the link?
> >> I'll try to simulate this later on
> >>
> >> Regards,
> >>
> >> Koen
> >> =20
> > Hi Koen,
> >
> > we didnt stress the link that much.
> >
> > There was only SSH from the ap to the sta running to get access to the =
sta.
> >
> > regards,
> >
> > Julian
> >
> > =20

Did observe same/similar problem, in my case with IBSS mode and three nodes/
stations A, B, C. IP traffic only between A, B. Node C is 'passive' (sending
only beacons and broadcasts), but the current algorithm keeps ackto at 600
(no update of the ackto value for node/station C - added an debugfs entry
ack_to_detailed dumping the ackto values per station which are evaluated
in ath_dynack_compute_ackto() where the highest value wins).

Fixed it by setting the initial ackto value to zero for new nodes/stations:

diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless=
/ath/ath9k/dynack.c
index fbeb4a739..ebf7800bd 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -235,7 +235,7 @@ void ath_dynack_sample_tx_ts(struct ath_hw *ah, struct =
sk_buff *skb,
                                struct ath_node *an;

                                an =3D (struct ath_node *)sta->drv_priv;
-                               an->ackto =3D -1;
+                               an->ackto =3D 0; /* do not vote for ackto u=
ntil real value is known */
                        }
                        da->lto =3D jiffies + LATEACK_DELAY;
                }
@@ -323,7 +323,7 @@ void ath_dynack_node_init(struct ath_hw *ah, struct ath=
_node *an)
 {
        struct ath_dynack *da =3D &ah->dynack;

-       an->ackto =3D da->ackto;
+       an->ackto =3D 0; /* do not vote for ackto until real value is known=
 */

        spin_lock_bh(&da->qlock);
        list_add_tail(&an->list, &da->nodes);
@@ -368,7 +368,7 @@ void ath_dynack_reset(struct ath_hw *ah)

        da->ackto =3D ath_dynack_get_max_to(ah);
        list_for_each_entry(an, &da->nodes, list)
-               an->ackto =3D da->ackto;
+               an->ackto =3D 0; /* do not vote for ackto until real value =
is known */

        /* init acktimeout */
        ath_dynack_set_timeout(ah, da->ackto);


Another observation is that the initial/default ackto value is dependent on
the order of the interface configure commands, e.g.:

	$ iw phy0 set distance auto
	$ iw wlan0 set type ibss
	$ ifconfig wlan0 10.11.0.3 up
	$ iw wlan0 ibss join test-ibss1 5180 1a:2b:3c:4d:5e:6f

results in an initial ackto value of 300,

	$ iw wlan0 set type ibss
	$ ifconfig wlan0 10.11.0.3 up
	$ iw wlan0 ibss join test-ibss1 5180 1a:2b:3c:4d:5e:6f
	$ iw phy0 set distance auto

results in an initial ackto value of 600...

Regards,
Peter


