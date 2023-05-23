Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA670D4C2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjEWHSv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjEWHSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 03:18:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D1E77
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 00:17:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510b6a24946so946909a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684826213; x=1687418213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyYlBZmHo9xw7tcNUvZCVn1HHbosaa4n5LM15HCGF3w=;
        b=gFa84NjMDavMsRg6UKzSR2MDCZ6BJdxuZrspFiAEzzX2HZiJkoso7m19Cm+3JaOD/+
         PyiING+FuucTM50fF/rRbG/2nBzNT8XyUPOrTjHDRNATliWOiuRMxz9FXB2FXeIMqowE
         JVewClvDkH7XmK7Ys+WaFTR5LMEg54sq0QE4vRzGpi4Llhis+vLb+6K7OkE+2pPPQYSz
         rbuydwYSd0Yz6i0QuHas5grGppa369C2bw2YECzAJTCIsU1hSs8cckjGOeVX4L/B+kYb
         00BfX4S0TkrMKdjWEuHAm1e2SB+DJ4lG8iK81+l6sVuKf4g9qkTWSCr5s46FWmEWLS/f
         vdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826213; x=1687418213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyYlBZmHo9xw7tcNUvZCVn1HHbosaa4n5LM15HCGF3w=;
        b=gI8zsvGicr/s6hJ/yWrsMWBR+Nr+Ka8VCGUzO3z+ISCt5IfFjxOzDTqZ/Kh/bkeha6
         iotmWJaXN0T40q0VJBPDcacsBhGBKkVRuIHvklLSH0KvXgFRm+UpssZ0XMFdPyJky1Et
         lM84cIWyh/IQY0iSBBoRxTDI0WhlwUajAim0DpWP0q51RpHEVTDpywPTszDtrlke73iw
         XXzqC24/oxapCTGg7tY3OhkfiKCDkomdzDJ6YjaFNnZRR31USQig/Z9zUGAprn7YGjjo
         SERC0QnVHtpYeZMnGLaU5l02xsNiwJfTqLjQ9Q3bEMY10jRG0CKmVsLu8IgCKsvWVqUJ
         clOA==
X-Gm-Message-State: AC+VfDxN4durgSvmt3EWceS8CQ1LUB3XGCkxV0lya/uuI9WZRueuorh3
        YyhUynIdqX/VogDDwJl8mqn5DpN+a4/AuFrxBUs5LjP15Eo=
X-Google-Smtp-Source: ACHHUZ4TPHD44WrNplIinlylRTR45aCYRJ9ONakE6dBZzWRevZJkIvRD3GYsbOACJf/zxa5UMLRFHTPrQNVMzXjbKm0=
X-Received: by 2002:aa7:c984:0:b0:510:d889:88cd with SMTP id
 c4-20020aa7c984000000b00510d88988cdmr11878983edt.1.1684826212958; Tue, 23 May
 2023 00:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca> <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com> <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
In-Reply-To: <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
From:   Fabrizio del Tin <devotedmystic@gmail.com>
Date:   Tue, 23 May 2023 09:16:41 +0200
Message-ID: <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
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

Hello Larry,
great news really!

Actually, the file common.mk is missing, so it fails.

#rm -f .symvers.8852cu
make ARCH=3Dx86_64 CROSS_COMPILE=3D -C /lib/modules/6.3.3-arch1-1/build
M=3D/usr/src/rtw8852cu  modules
/usr/src/rtw8852cu/Makefile:654: /usr/src/rtw8852cu/common.mk: No such
file or directory
make[2]: *** No rule to make target '/usr/src/rtw8852cu/common.mk'.  Stop.
make[1]: *** [Makefile:2025: /usr/src/rtw8852cu] Error 2
make: *** [Makefile:705: modules] Error 2

Fabrizio

On Tue, May 23, 2023 at 7:45=E2=80=AFAM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> On 5/22/23 10:35, Fabrizio del Tin wrote:
> > Thank you Larry, that would be great.
> >
> > I was just advised to return the dongle, but I still keep it.
>
> The RTW8832CU is a variant of the RTW8852CU. I received a copy of the dri=
ver
> from Realtek and fixed it to build on kernels thru 6.4.0. The driver give=
s
> reasopnable performance (350 Mpps up and down) when connected to the 5G b=
and of
> my ax1500 router. This router does not support the 6G band, thus I cannot=
 say
> whether it would work for that 3rd band.
>
> To get a copy, do the following:
>
> git clone https://github.com/lwfinger/rtw8852cu.git
> cd rtw8852cu
> make
> sudo make install
>
> I suggest that you install the modeswitch package for your distro. That w=
ill
> automatically eject the CDROM device and enable the wifi interface.
>
> I will be making improvements in the coming days, but I wanted you to hav=
e
> access as soon as possible.
>
> Larry
>
