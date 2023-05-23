Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316370DD3D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjEWNLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjEWNLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 09:11:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25FDB
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 06:11:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f50e26b8bso995773766b.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684847479; x=1687439479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAIryHNEtCnqBOdyUGoJtWIfwm8yNg+Rwt+Ukts9CwY=;
        b=ILDQLxu8jx5/QhRyJ5YbKDn7it9geVgiIhJm1JLppPnaQB90fomz6Hrl3sfRvxJ+HY
         f99MkSqG21xCzV7l2mF1J0qqCjFHnmeXKrc7sD7IZ4pgvcm/I2xjA0hJTipRkjJI1Zik
         EM8UDV0IdYnpTMK2ZsODQ8Cf0BKN7Xohb1zjXUXMA5jBOIsG/dwchsSosuAbjyLeMXTT
         FWLmq0GU4yZ0fOYCRKcS3tRZbnSFO8oz5JK0SuhLTCveovzWNM90KHpgczjxS6haAzfD
         okPgZmV9fTrmSJitm4eJBCDKfipixe07bNFjaDolZgXXVYhWFSa3pTtqEUWnwf1W6/Jo
         krPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684847479; x=1687439479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAIryHNEtCnqBOdyUGoJtWIfwm8yNg+Rwt+Ukts9CwY=;
        b=DikPFfPhGzFN6hKvb/5hu91aA/+wl1tiGGvO/D//HA8oulYU6lZ0xp/QJxT8MxLzVu
         VncJoNB3cIva5z3KGmYJAoBh2fsQiuYt3V0w0IGybg8zWw4wR667op38ooLzReif01g6
         W9I9SzqQLNRnTSjiVqUzKYFqw1/amA81/Z5CF8cG3q1S/q5uOJe8YQ9MRXb9wCGRB73x
         ZYN0sTI2SBmIvazSmprf45xBpz7usp7uAW783RS0yQJaAMzxillu4Q/1QLbTc2hEzMBL
         5mUt89Bhi7GW6IJAQ2FggEZ+CUdWZ+Uq9y6+DYOCJn8BqCjGGZYjqx0q10WZB0eWp36v
         VLnA==
X-Gm-Message-State: AC+VfDy/BQSk8VTivegh/1wMh1TjGQcZdzxCp6/lF8dv9IjQ2ek9lX3g
        KJr3uRfXvgmw1Pp6hAxFcnhLW1f7RyqeCDgtZotiZsWeuug=
X-Google-Smtp-Source: ACHHUZ4ImqKi/18f91AtV9zbsmIBA2YykOrg5E5wN/SqerS5BqP6p8DRxMxbYbTryThIZjjK0uYKayhC85CoXA0Vdws=
X-Received: by 2002:a17:907:7ea7:b0:96f:d07e:a1ce with SMTP id
 qb39-20020a1709077ea700b0096fd07ea1cemr9029116ejc.60.1684847479338; Tue, 23
 May 2023 06:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca> <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com> <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
 <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com> <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
In-Reply-To: <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
From:   Fabrizio del Tin <devotedmystic@gmail.com>
Date:   Tue, 23 May 2023 15:11:07 +0200
Message-ID: <CAMzNfvPtmGyXDV9m-whhptH5n3xJL1-ZPNed3yrkXG-DSF==+w@mail.gmail.com>
Subject: Re: Realtek RTL8832CU compatibility
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I found that rtl8852cu should already be in linux-firmware:
https://www.mail-archive.com/kernel-packages@lists.launchpad.net/msg490319.=
html

Maybe it is just matter of adding rtl8832cu as a variant.

Fabrizio

On Tue, May 23, 2023 at 9:28=E2=80=AFAM Fabrizio del Tin
<devotedmystic@gmail.com> wrote:
>
> I got the common.mk file from here:
> https://github.com/lwfinger/rtl8852au/blob/dwa-x1850/common.mk
>
> It seemed to me it could be fit.
>
> It compiled for a long while, then died:
>
>   CC [M]  /usr/src/rtw8852cu/phl/hal_g6/phy/rf/halrf_8852c/halrf_kfree_88=
52c.o
>   CC [M]  /usr/src/rtw8852cu/phl/hal_g6/phy/rf/halrf_8852c/halrf_psd_8852=
c.o
>   LD [M]  /usr/src/rtw8852cu/8852cu.o
>   MODPOST /usr/src/rtw8852cu/Module.symvers
> ERROR: modpost: "dump_radar_detect_status"
> [/usr/src/rtw8852cu/8852cu.ko] undefined!
> ERROR: modpost: "rtw_dfs_rd_hdl" [/usr/src/rtw8852cu/8852cu.ko] undefined=
!
> ERROR: modpost: "rtw_chset_search_ch" [/usr/src/rtw8852cu/8852cu.ko] unde=
fined!
> ERROR: modpost: "dump_chinfos" [/usr/src/rtw8852cu/8852cu.ko] undefined!
> ERROR: modpost: "rtw_rfctl_dfs_init" [/usr/src/rtw8852cu/8852cu.ko] undef=
ined!
> ERROR: modpost: "get_ch_type_from_str" [/usr/src/rtw8852cu/8852cu.ko] und=
efined!
> ERROR: modpost: "rtw_5ghz_a_channels" [/usr/src/rtw8852cu/8852cu.ko] unde=
fined!
> ERROR: modpost: "rtw_ap_check_ecsa_allow"
> [/usr/src/rtw8852cu/8852cu.ko] undefined!
> ERROR: modpost: "rtw_chset_is_bchbw_non_ocp"
> [/usr/src/rtw8852cu/8852cu.ko] undefined!
> ERROR: modpost: "rtw_chset_search_bch" [/usr/src/rtw8852cu/8852cu.ko] und=
efined!
> WARNING: modpost: suppressed 41 unresolved symbol warnings because
> there were too many)
> make[2]: *** [scripts/Makefile.modpost:136:
> /usr/src/rtw8852cu/Module.symvers] Error 1
> make[1]: *** [Makefile:1977: modpost] Error 2
> make: *** [Makefile:705: modules] Error 2
>
> Fabrizio
>
> On Tue, May 23, 2023 at 9:16=E2=80=AFAM Fabrizio del Tin
> <devotedmystic@gmail.com> wrote:
> >
> > Hello Larry,
> > great news really!
> >
> > Actually, the file common.mk is missing, so it fails.
> >
> > #rm -f .symvers.8852cu
> > make ARCH=3Dx86_64 CROSS_COMPILE=3D -C /lib/modules/6.3.3-arch1-1/build
> > M=3D/usr/src/rtw8852cu  modules
> > /usr/src/rtw8852cu/Makefile:654: /usr/src/rtw8852cu/common.mk: No such
> > file or directory
> > make[2]: *** No rule to make target '/usr/src/rtw8852cu/common.mk'.  St=
op.
> > make[1]: *** [Makefile:2025: /usr/src/rtw8852cu] Error 2
> > make: *** [Makefile:705: modules] Error 2
> >
> > Fabrizio
> >
> > On Tue, May 23, 2023 at 7:45=E2=80=AFAM Larry Finger <Larry.Finger@lwfi=
nger.net> wrote:
> > >
> > > On 5/22/23 10:35, Fabrizio del Tin wrote:
> > > > Thank you Larry, that would be great.
> > > >
> > > > I was just advised to return the dongle, but I still keep it.
> > >
> > > The RTW8832CU is a variant of the RTW8852CU. I received a copy of the=
 driver
> > > from Realtek and fixed it to build on kernels thru 6.4.0. The driver =
gives
> > > reasopnable performance (350 Mpps up and down) when connected to the =
5G band of
> > > my ax1500 router. This router does not support the 6G band, thus I ca=
nnot say
> > > whether it would work for that 3rd band.
> > >
> > > To get a copy, do the following:
> > >
> > > git clone https://github.com/lwfinger/rtw8852cu.git
> > > cd rtw8852cu
> > > make
> > > sudo make install
> > >
> > > I suggest that you install the modeswitch package for your distro. Th=
at will
> > > automatically eject the CDROM device and enable the wifi interface.
> > >
> > > I will be making improvements in the coming days, but I wanted you to=
 have
> > > access as soon as possible.
> > >
> > > Larry
> > >
