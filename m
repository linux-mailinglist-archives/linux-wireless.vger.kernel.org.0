Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D268570D4F3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 09:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjEWH3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjEWH3L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 03:29:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07D188
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 00:28:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso966466a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684826925; x=1687418925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdB7HL8g/mrFbZSl63OCrNjlCjAXhZLrwWDrQJ8hyjU=;
        b=Or42sXMsILqQxB4/C3GgRRHMULpTluJLWzFwwsArydiAp0fTEg5Ct3VRScgv7X12ff
         7LXNI/cvNv64hsO0Sb8HRc0k00SYdypzXuclPqU3tBybJmaXtLSBd3TA9nSYD+5n/hjq
         UbtG7GATeRPiYytTS2z1nI9U6phvptaRzj0vObIlmWEnLA17KIPgPsdgdlINQ/P2lAqp
         Iv+ZgIwhUDPIHZUblfrrKqTe9Q3H33hutWXCdT4fCt7zfyEIsuGHVqGRqKcblIMk3R6l
         cCEQLUIvMZIY43hXmxhQGW9WeN1mF18e/PXbEyVlW20k57oiPY6X3aikhExkSL0Lmljx
         bURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826925; x=1687418925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdB7HL8g/mrFbZSl63OCrNjlCjAXhZLrwWDrQJ8hyjU=;
        b=cdBtK6OyBUnsDejY3QiNJu/vqiUQXRUYo0172OuwJopo4Z7RT0x/ydU4UZugbVfkRy
         7SIvVGiUIc7eB5Fu5A4EFsalbc5VnzXPHNIAtPqtEzrTLu0BifbERbnEh8kEigVzigLf
         s/T7PClS9mhrRftLScN3CpZcL5P8mT8Qj7Yihw5mFJleOJvuncd8L7oZklw+wLW4Y4zJ
         EH/lQSGUsU3jjkD/SsrhD7HQwq6DfkVJje8NTD7Npuaic5dva3z7AeW/vzhWez7rND0f
         ExBrLABRweGgdf2awxwNqGDC+V4yhngMDrP5ZcuXy7lB7cyyiR6TnmuQnekSMFVsbdi/
         OZ7w==
X-Gm-Message-State: AC+VfDyP3sTQrro58EDF8dGNvnz3QRK5bEWnoFTJB1iRIWGWnuE4Pj01
        ey1+SkmrTq1yihcEPgNxCM53oAFH2QRHcGcyXuvPZdw5
X-Google-Smtp-Source: ACHHUZ4LRHW5h2RN9vW3+4XOtc6vE7Onp7TZrclzV4as20PL3PD0skw51jNdgtzPRRW9LIL9dvA+Puca7gPNxGeXa/E=
X-Received: by 2002:aa7:d304:0:b0:50d:89d5:bf95 with SMTP id
 p4-20020aa7d304000000b0050d89d5bf95mr11907150edq.20.1684826925168; Tue, 23
 May 2023 00:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca> <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com> <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
 <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
In-Reply-To: <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
From:   Fabrizio del Tin <devotedmystic@gmail.com>
Date:   Tue, 23 May 2023 09:28:33 +0200
Message-ID: <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
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

I got the common.mk file from here:
https://github.com/lwfinger/rtl8852au/blob/dwa-x1850/common.mk

It seemed to me it could be fit.

It compiled for a long while, then died:

  CC [M]  /usr/src/rtw8852cu/phl/hal_g6/phy/rf/halrf_8852c/halrf_kfree_8852=
c.o
  CC [M]  /usr/src/rtw8852cu/phl/hal_g6/phy/rf/halrf_8852c/halrf_psd_8852c.=
o
  LD [M]  /usr/src/rtw8852cu/8852cu.o
  MODPOST /usr/src/rtw8852cu/Module.symvers
ERROR: modpost: "dump_radar_detect_status"
[/usr/src/rtw8852cu/8852cu.ko] undefined!
ERROR: modpost: "rtw_dfs_rd_hdl" [/usr/src/rtw8852cu/8852cu.ko] undefined!
ERROR: modpost: "rtw_chset_search_ch" [/usr/src/rtw8852cu/8852cu.ko] undefi=
ned!
ERROR: modpost: "dump_chinfos" [/usr/src/rtw8852cu/8852cu.ko] undefined!
ERROR: modpost: "rtw_rfctl_dfs_init" [/usr/src/rtw8852cu/8852cu.ko] undefin=
ed!
ERROR: modpost: "get_ch_type_from_str" [/usr/src/rtw8852cu/8852cu.ko] undef=
ined!
ERROR: modpost: "rtw_5ghz_a_channels" [/usr/src/rtw8852cu/8852cu.ko] undefi=
ned!
ERROR: modpost: "rtw_ap_check_ecsa_allow"
[/usr/src/rtw8852cu/8852cu.ko] undefined!
ERROR: modpost: "rtw_chset_is_bchbw_non_ocp"
[/usr/src/rtw8852cu/8852cu.ko] undefined!
ERROR: modpost: "rtw_chset_search_bch" [/usr/src/rtw8852cu/8852cu.ko] undef=
ined!
WARNING: modpost: suppressed 41 unresolved symbol warnings because
there were too many)
make[2]: *** [scripts/Makefile.modpost:136:
/usr/src/rtw8852cu/Module.symvers] Error 1
make[1]: *** [Makefile:1977: modpost] Error 2
make: *** [Makefile:705: modules] Error 2

Fabrizio

On Tue, May 23, 2023 at 9:16=E2=80=AFAM Fabrizio del Tin
<devotedmystic@gmail.com> wrote:
>
> Hello Larry,
> great news really!
>
> Actually, the file common.mk is missing, so it fails.
>
> #rm -f .symvers.8852cu
> make ARCH=3Dx86_64 CROSS_COMPILE=3D -C /lib/modules/6.3.3-arch1-1/build
> M=3D/usr/src/rtw8852cu  modules
> /usr/src/rtw8852cu/Makefile:654: /usr/src/rtw8852cu/common.mk: No such
> file or directory
> make[2]: *** No rule to make target '/usr/src/rtw8852cu/common.mk'.  Stop=
.
> make[1]: *** [Makefile:2025: /usr/src/rtw8852cu] Error 2
> make: *** [Makefile:705: modules] Error 2
>
> Fabrizio
>
> On Tue, May 23, 2023 at 7:45=E2=80=AFAM Larry Finger <Larry.Finger@lwfing=
er.net> wrote:
> >
> > On 5/22/23 10:35, Fabrizio del Tin wrote:
> > > Thank you Larry, that would be great.
> > >
> > > I was just advised to return the dongle, but I still keep it.
> >
> > The RTW8832CU is a variant of the RTW8852CU. I received a copy of the d=
river
> > from Realtek and fixed it to build on kernels thru 6.4.0. The driver gi=
ves
> > reasopnable performance (350 Mpps up and down) when connected to the 5G=
 band of
> > my ax1500 router. This router does not support the 6G band, thus I cann=
ot say
> > whether it would work for that 3rd band.
> >
> > To get a copy, do the following:
> >
> > git clone https://github.com/lwfinger/rtw8852cu.git
> > cd rtw8852cu
> > make
> > sudo make install
> >
> > I suggest that you install the modeswitch package for your distro. That=
 will
> > automatically eject the CDROM device and enable the wifi interface.
> >
> > I will be making improvements in the coming days, but I wanted you to h=
ave
> > access as soon as possible.
> >
> > Larry
> >
