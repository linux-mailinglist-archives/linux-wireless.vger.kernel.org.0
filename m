Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8402D3F5254
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhHWUkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhHWUkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 16:40:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAEFC061575
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 13:39:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h1so5474033ljl.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JFZLEAhA30rNPUlpm88OHaIhK1CzHABrd7DB+Lg/9bQ=;
        b=ixsz1gejAEC+D5e0OPLB2PH3Ffo41Nu/tzUHz79iC2ZFSvtXKQnJLeHxIPz1Kn3IYH
         Sm/K0ZXxrItBBPBDNzqxxa5+SK/GW+M0KruNhaj9jw68+rADxbyQtJjGdkl/G0JcfMTs
         yau875ER8hjPTKcESljcyDCyw4AUI9+M0TZQ2fgtTW2CVxYYUHSEdbradDbUkLlV/y1k
         TJPkeMmFshyKPdroUO2yd29uTBlP2gcUfhfgnIiZNsK2aybiNe2UdxvktfB4AtBREf4U
         27ziJ0s4T3qATrDG0rdcYFRipuGYZgG3Xp7kdnd0JwPwhyuIJi2hvT66LQfubq6I3L3s
         2gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JFZLEAhA30rNPUlpm88OHaIhK1CzHABrd7DB+Lg/9bQ=;
        b=NM31hn4I40TS0n3ow+SaEuaeYG3M8VUmyXxURvq0duG4HHmf2QgO73YpxQDdP7wuKH
         cIgotsjBKug7LvUreKN8XxX51N1Tr9tXtVh3PAkDnue/8Ja53rIPStRriaMZnuZe+ThA
         xSaNueJJii0jgGmd1BMx04pvwepsTwjIcS9lvaMJ0KgUC3+lWPrlElc9o+k1v8jL73iz
         0fgm6LkZc1nXOc/7P7W/yZHDnx9pExMimzLuEhQbZ8dmBqtV5Uej5DrDg8+MwQnHYJOZ
         50jM3nOmPC3SQQFcNANKwErzeFmOgSM9mCrDzY2bJoYKvmYQjzWb1EJJWAmyOwwQXz1d
         0lJA==
X-Gm-Message-State: AOAM531T3cc28X6HyQiilGbrsA3M8jjn8j50D47sSbeSTa8QI+oi2C3/
        CAXkPM6bKfsJXquglTY95Qw=
X-Google-Smtp-Source: ABdhPJxcrkej2m+w34/8wZgqh89Nn40/n/KBhvMgoMj3eaqocRQEdySUWeXWqRjxvtBs3p4KcCMrWg==
X-Received: by 2002:a05:651c:211a:: with SMTP id a26mr15593430ljq.305.1629751180124;
        Mon, 23 Aug 2021 13:39:40 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id u21sm790667lfc.239.2021.08.23.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:39:39 -0700 (PDT)
Date:   Mon, 23 Aug 2021 23:39:38 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Peter Oh <peter.oh@eero.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Brian Norris <briannorris@chromium.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
Message-ID: <YSQHijyArNZW38Qq@skv.local>
References: <YSJ//ki/A1EgfLga@skv.local>
 <15d3d071-61a2-0847-de13-634a0c2077d5@eero.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15d3d071-61a2-0847-de13-634a0c2077d5@eero.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21-08-23 11:15, Peter Oh wrote:
>=20
> On 8/22/21 9:49 AM, Andrey Skvortsov wrote:
>=20
> > 1) Current behaviour maps 0x0 regulatory domain to the most restrictive
> > world domain. According to the wiki (probably based on Atheros
> > documentation) 0x0 means US. Does wiki contain wrong information?
>=20
> 0x0 means country section in OTP is not written yet and open to set to any
> country.
>=20
> QCA sets to US in this case as a default value.

Do you mean it's set to US by code fragment described below?


> > 2) If I understand correctly, 0x0 is always replaced with 0x64 and that
> > makes the following code useless, because it will never be executed. Is=
 it
> > ok?
> >=20
> > drivers/net/wireless/ath/regd.c:703:708
> >=20
> > if (reg->country_code =3D=3D CTRY_DEFAULT &&
> >          regdmn =3D=3D CTRY_DEFAULT) {
> >              printk(KERN_DEBUG "ath: EEPROM indicates default "
> >                  "country code should be used\n");
> >              reg->country_code =3D CTRY_UNITED_STATES;
> > }
> I don't think that's true. If you're seeing 0x0 is replaced with 0x64
> (CTRY_BULGARIA =3D 100), it could be because your device's manufacturer
> preconfigured country code with the value.

0x64 is not BULGARIA, it's not the country code in this case, but regulator=
y domain - WOR4_WORLD
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/wireless/ath/regd_common.h?h=3Dv5.14-rc7#n84

country code is still default (CTRY_DEFAULT =3D=3D 0x00), but regdmn is
sanitized (set to 0x64) and is not CTRY_DEFAULT (0x00), therefore
country_code is not set to CTRY_UNITED_STATES any more.

> > 3) Previously it was possible to get regulatory information using 'iw r=
eg
> > get', but now it doesn't work anymore. Is it expected behavior?
> >=20
> > [--------------------4.19 ---------------------------------]
> > # iw reg get
> > global
> > country 98: DFS-UNSET
> > (2400 - 2483 @ 40), (N/A, 20), (N/A)
> > (5150 - 5250 @ 100), (N/A, 20), (N/A), NO-OUTDOOR
> > (5250 - 5350 @ 100), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
> > (5650 - 5730 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
> > (5730 - 5850 @ 80), (N/A, 20), (N/A), NO-OUTDOOR
> > (57240 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR
> >=20
> >=20
> > [--------------------- 5.10 --------------------------------]
> > #iw reg get
> > global
> > country RU: DFS-UNSET
> > (2400 - 2483 @ 40), (N/A, 20), (N/A)
> > (5150 - 5350 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
> > (5650 - 5850 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
> > (57000 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR
> >=20
> > [-----------------------------------------------------------]
>=20
> The 4.19 output tells you that country code is changed to different one f=
rom
> manufacturer is set(US).
>=20
> The 5.10 output seems manufacture set country code to RU. If it's the cas=
e,
> No phy level country code looks wrong or a bug.

There hardware is the same in both cases. RU is displayed just because
I played with 'iw reg set RU/US/..'. My question is more about why on
newer kernels 'iw reg get' doesn't report regulatory information about
these cards (phy#..) any more.

I mean following lines:

phy#0
country US: DFS-FCC
(2400 - 2483 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A)
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#1
country US: DFS-FCC
(2400 - 2483 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A)
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

--=20
Best regards,
Andrey Skvortsov
