Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59AD3E95C9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhHKQTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 12:19:46 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:53390 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKQTp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 12:19:45 -0400
Date:   Wed, 11 Aug 2021 16:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628698760;
        bh=HzJlQKp2vEDcv5QHMFvxuwBRR+J+RG73R9ydHLvkdSw=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=WPcKX8AXN0ZhI3k5zxirbne+eMxEaYWqGwTacFay3LCzTrnEecDbWXXqKvxsufKjW
         bGBWd9wrKOWur/edfb/p1FT9MpjOfGvrL1q6HMOwD1A5JAMX0cAbhBy4id6ut5iE0J
         v6nRXVLgnF+py9SYrCKXsqVgy2EwttMzhZbvz5LM=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Michael Yartys <michael.yartys@protonmail.com>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: Re: Not able to roam on FT-SAE network
Message-ID: <V0_IPYc_Npfn1PZUsG4j0O18IfrVvtou6oKpNYuaij5nYWJ1q8IALf7_C2trQiys9MSGzAPM22bxZAAPB2GbONz4Em5xGA116mR2N80qpV4=@protonmail.com>
In-Reply-To: <NB-cdP_zWop55KKgEYOXNh25URknq08i4hqQ2mRF9aVBi6YFIlJaYIk9pg1ewyJY7hLC1x8mtEFX5WyutbN3YZRoyaJMvOpn7MH2GsUTv7o=@protonmail.com>
References: <NB-cdP_zWop55KKgEYOXNh25URknq08i4hqQ2mRF9aVBi6YFIlJaYIk9pg1ewyJY7hLC1x8mtEFX5WyutbN3YZRoyaJMvOpn7MH2GsUTv7o=@protonmail.com>
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

Hi

I did a packet capture and I found out that what happens is that the client=
 attempts to authenticate with fast transition, but the AP rejects the requ=
est due to an invalid PMKID. What's interesting is that my iPad causes the =
same behaviour, which might indicate that the problem lies with hostapd rat=
her than the client implementations. I'll post this on the hostapd mailing =
list as well.

Michael

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, August 10th, 2021 at 21:59, Michael Yartys <michael.yartys@prot=
onmail.com> wrote:

> Hi
>
> I've been running an FT-SAE network for quite some time now, and I've lon=
g noticed that my both my laptops with Intel 7260AC cards are unable to roa=
m from one AP to another. When I move the laptops to an area with poor sign=
al strength the background scanning of NetworkManager/hostapd is triggered =
as expected and a roam appears to be initiated, but instead of successfully=
 roaming to the other AP with better signal strength it ends up returning t=
o the current AP. This keeps on happening until I either manually disable a=
nd re-enable wifi, or if I move back to an area where the current AP has go=
od signal strength. The laptops are running the following distros, kernels =
and wpa_supplicant versions:
>
> -- Laptop 1 --
>
> -   Fedora 34
> -   5.13.8-200
> -   wpa_supplicant v2.9
>
>     -- Laptop 2 --
> -   Ubuntu 20.04.2 LTS
> -   5.11.0-25
> -   wpa_supplicant v2.10-devel-hostap_2_9-2285-gc3155a725 (recent snapsho=
t)
>
>     I can provide relevant logs from wpa_supplicant and the APs to develo=
pers personally.
>
>     Michael
