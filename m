Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA7373BFB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhEENH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 09:07:56 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:59156 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhEENHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 09:07:55 -0400
Date:   Wed, 05 May 2021 13:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620220017;
        bh=Ksv5hc0zLM8WPCwZOTk+3YocqmO6w9TcnQh09Nl+3gI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=o+sfvF93T3b4VO5Et1IhZoxrLfBAqbjeSsWENRQoFM1xKdxKjT5zp5asa0BUUsj6X
         0LrudC3XnDHVB0wglu/AxU2/ZAnWOrfoqBecWHrfFJ5J5+7EnzoYEZZhWH3RHCIHVv
         vFizzin7oTAqpcavU5yi8uXCwdv3pH43C2yBBESA=
To:     Johannes Berg <johannes@sipsolutions.net>
From:   Michael Yartys <michael.yartys@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: Re: Possible bug in iwlwifi
Message-ID: <0IuWBg5tqXtBE836_CvCmwVzEXWDOGZ4dyETg5_WBWUC8bMDR9vFORGkgY6_WBqSi61GYW07WwH6aVzkc2-zhqWYp5JugyjWU_Bg1leD0vk=@protonmail.com>
In-Reply-To: <E3bg7aVzJHQEHxAd21kjOlTrLqG0U3Jt7iBCDDTVCI4FYSdGROu-UKmRuM05cl8pxTBlo4pjeoYkTtKFFFYiezrdXVybrKs-6qBCAkZJ-sU=@protonmail.com>
References: <qnvkj7tfHuYKasegaKViuXD0K4KlchNwXkLn4NUZu_KWsp7nEBa4LyQm7SNRm27eQLALJTyi1-xIYXMChMeuZAKS5F_q-rhb0DVVGqv0oUc=@protonmail.com> <7a5d0173cbfdef24b1e74c0bfc8f7410ff044817.camel@sipsolutions.net> <_p2InUu49ZKWc_249MDFWW8bre6iNHIJDvsoV6Rsb3oLyWj7wat48aLpnqIDVeKZKwSq-uZ1Fy_wlDwHMYJ5-JacdxF75NL5fLvpWrNCUO8=@protonmail.com> <E3bg7aVzJHQEHxAd21kjOlTrLqG0U3Jt7iBCDDTVCI4FYSdGROu-UKmRuM05cl8pxTBlo4pjeoYkTtKFFFYiezrdXVybrKs-6qBCAkZJ-sU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry for being a bit spammy here, but I forgot that I could simply run "iw=
 scan" on one of my two routers to see how it sees the network on the other=
 router:

$ iw dev wlan1 scan -u
BSS redacted(on wlan1)
=09TSF: 0 usec (0d, 00:00:00)
=09freq: 2412
=09beacon interval: 100 TUs
=09capability: ESS (0x0431)
=09signal: -65.00 dBm
=09last seen: 1930 ms ago
=09Information elements from Probe Response frame:
=09SSID: OpenWrt_
=09RSN:=09 * Version: 1
=09=09 * Group cipher: CCMP
=09=09 * Pairwise ciphers: CCMP
=09=09 * Authentication suites: PSK FT/PSK PSK/SHA-256 SAE FT/SAE
=09=09 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-capable (0x008c)
=09HT capabilities:
=09=09Capabilities: 0x19ed
=09=09=09RX LDPC
=09=09=09HT20
=09=09=09SM Power Save disabled
=09=09=09RX HT20 SGI
=09=09=09RX HT40 SGI
=09=09=09TX STBC
=09=09=09RX STBC 1-stream
=09=09=09Max AMSDU length: 7935 bytes
=09=09=09DSSS/CCK HT40
=09=09Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
=09=09Minimum RX AMPDU time spacing: 8 usec (0x06)
=09=09HT TX/RX MCS rate indexes supported: 0-31
=09HT operation:
=09=09 * primary channel: 1
=09=09 * secondary channel offset: no secondary
=09=09 * STA channel width: 20 MHz

Michael Yartys

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Wednesday, May 5th, 2021 at 2:37 PM, Michael Yartys <michael.yartys@prot=
onmail.com> wrote:

> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>
> On Wednesday, May 5th, 2021 at 2:25 PM, Michael Yartys michael.yartys@pro=
tonmail.com wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> >
> > On Wednesday, May 5th, 2021 at 2:09 PM, Johannes Berg johannes@sipsolut=
ions.net wrote:
> >
> > > On Wed, 2021-05-05 at 12:05 +0000, Michael Yartys wrote:
> > >
> > > > Hello
> > > >
> > > > I've been testing out WPA3/WPA2-mixed networks on my OpenWrt router=
,
> > > >
> > > > and I noticed whenever I enable 802.11r the network doesn't show up=
 in
> > > >
> > > > the list of Wi-Fi networks in NetworkManager. I initially thought t=
his
> > > >
> > > > was due to some bug with wpa_supplicant, but running "iw dev wlp18s=
0
> > > >
> > > > scan" also fails to list the network. If I'm not mistaken, iw doesn=
't
> > > >
> > > > use wpa_supplicant to scan for networks, so that rules out
> > > >
> > > > wpa_supplicant. That means something deeper in the stack is causing
> > > >
> > > > this, and my guess falls on iwlwifi.
> > >
> > > Indeed, that's super strange.
> > >
> > > Are you able to see the network from another linux machine, and could
> > >
> > > maybe do a packet capture there? Or maybe just do
> > >
> > > iw wlan0 scan dump -u
> > >
> > > on another system that can see it?
> >
> > Unfortunately my other laptop also has a Intel 7260 card and can't see =
the network. My iPad and Android phone are both able to see the network, bu=
t they're unable to connect to it.
>
> I don't know if it's of any help, but here's what WiFiAnalyzer reports ab=
out the network on my Android 11 phone: https://imgur.com/a/dn0HwhG
>
> > > johannes
