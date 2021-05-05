Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4E373B1F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhEEM0Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 08:26:25 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:58735 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhEEM0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 08:26:20 -0400
Date:   Wed, 05 May 2021 12:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620217522;
        bh=q5MZMKUayBVGS9z1PUVZxXJGB++YJiUNxivI4mLHxko=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=d7ORrSwRuZ68tlKSJbuyQjG1xBM1u4z7IahSWTOqz6Cpwxp0LATbVPdvxXQbrrbJZ
         E1rWwKlUZtOxHW2hSWtD7jzf/h98ldA+7V6s7ecy9l7aNe03VEPfXxrS/9IrnGPloh
         V4U8C6DedCzQkReWS8P4Y5mDqg41MPVIg9Jgd4tY=
To:     Johannes Berg <johannes@sipsolutions.net>
From:   Michael Yartys <michael.yartys@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: Re: Possible bug in iwlwifi
Message-ID: <_p2InUu49ZKWc_249MDFWW8bre6iNHIJDvsoV6Rsb3oLyWj7wat48aLpnqIDVeKZKwSq-uZ1Fy_wlDwHMYJ5-JacdxF75NL5fLvpWrNCUO8=@protonmail.com>
In-Reply-To: <7a5d0173cbfdef24b1e74c0bfc8f7410ff044817.camel@sipsolutions.net>
References: <qnvkj7tfHuYKasegaKViuXD0K4KlchNwXkLn4NUZu_KWsp7nEBa4LyQm7SNRm27eQLALJTyi1-xIYXMChMeuZAKS5F_q-rhb0DVVGqv0oUc=@protonmail.com> <7a5d0173cbfdef24b1e74c0bfc8f7410ff044817.camel@sipsolutions.net>
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

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Wednesday, May 5th, 2021 at 2:09 PM, Johannes Berg <johannes@sipsolution=
s.net> wrote:

> On Wed, 2021-05-05 at 12:05 +0000, Michael Yartys wrote:
>
> > Hello
> >
> > I've been testing out WPA3/WPA2-mixed networks on my OpenWrt router,
> >
> > and I noticed whenever I enable 802.11r the network doesn't show up in
> >
> > the list of Wi-Fi networks in NetworkManager. I initially thought this
> >
> > was due to some bug with wpa_supplicant, but running "iw dev wlp18s0
> >
> > scan" also fails to list the network. If I'm not mistaken, iw doesn't
> >
> > use wpa_supplicant to scan for networks, so that rules out
> >
> > wpa_supplicant. That means something deeper in the stack is causing
> >
> > this, and my guess falls on iwlwifi.
>
> Indeed, that's super strange.
>
> Are you able to see the network from another linux machine, and could
>
> maybe do a packet capture there? Or maybe just do
>
> iw wlan0 scan dump -u
>
> on another system that can see it?

Unfortunately my other laptop also has a Intel 7260 card and can't see the =
network. My iPad and Android phone are both able to see the network, but th=
ey're unable to connect to it.

>
> johannes
