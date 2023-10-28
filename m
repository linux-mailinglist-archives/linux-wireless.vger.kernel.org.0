Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B587DA561
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Oct 2023 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjJ1GvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1GvS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 02:51:18 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED9AB
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 23:51:17 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4a06fb5331bso1208629e0c.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698475876; x=1699080676; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JvvfvSgDFS7GtxnOd/4iFylUaLSTyPmT1cY1LtqNNY=;
        b=TX8qJduTOHvskKj1i/ran6FwgmgV5CHyyvnpQBlSv8Q83nIgBxydgwnrcZgm6REY/+
         Pmg3Lv6yH/YD8u09BM7FCOMBEdmDCzjelu8c4kD8+KSuyS24qOLYP6RApnJ+vOUFtfjo
         QlIEoPLnZf2ky+9XEDRV+wrc5fIZZBy6cub6Gqzv8bv0J0XMWglVIwHvS9ss7Svyzzl7
         U56xWyX7lRWhtw8BWkEpo7Oawj9eSVV7truU4Ix5jpURagKSwiVlcawdqNBi9oVoFQBr
         k5mU9QiheqaZCnMJSMpLPKDq5CaVXorj2SQVQdYbp0HCEL6i3oHbz/GFaJPfqLiDk+qi
         8kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698475876; x=1699080676;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JvvfvSgDFS7GtxnOd/4iFylUaLSTyPmT1cY1LtqNNY=;
        b=oMICRYMGVWMQlb04E6eSSfW0AZlNgn5ysidLee5aclS7MAney5nPF4cE74KM5gj3Ey
         kmCoONNc7Qcy3ZKXbBvfvj5nKP9zwfDKRnptk1Fn3GRuXBh+q5lWS83byiID0T8fC/F7
         Vndwf6y/yhM+qy3RTjn83uP0bwHZcy+Whd7g21Txdb9kOEjS1prRyicXQscQ69oo+r5j
         TpD1pxuqqpKwz/BtWKHcz4ALVuSrX37uWn6XcAulfvSfIekPuae2NIFU+jWNZ5MZmIeu
         725llfYePXVAgw26fjNqRYDOx09sDh3SlVZf8G9yVXEQUeJum/9uU7OzwMMBy0LDbdgb
         kgLg==
X-Gm-Message-State: AOJu0YzVx9jp0ovD5UkR+bqOvJr7zNQFBSf1BShzarUSvcV/fkQ9pWKa
        5cdpKLTpGLLbcDl632Yd089/mMjw2DupHpgzbCwHdIIJ
X-Google-Smtp-Source: AGHT+IHSuuo5q4b15h1SN+KpFWsFlHVzLkQUeKCMgiwl2Gt3vsyCnn2D+RMK6fD7Sh/2VaodPp2Fnp0aJF6nF9wWtxk=
X-Received: by 2002:a1f:2f52:0:b0:49e:1eca:f84d with SMTP id
 v79-20020a1f2f52000000b0049e1ecaf84dmr4868729vkv.14.1698475875868; Fri, 27
 Oct 2023 23:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMes48--xvNjYZdO1DKjfkXRv7AJcqJaWYzJ9fYSPPxQ_M7muw@mail.gmail.com>
 <ce544a72-2af6-4448-8817-1d4cb54f456a@lockie.ca> <CAMes488xPhpKuYUxgHd1WnnQUCUwmeOseCGtTv+Y9Z52b4MRnQ@mail.gmail.com>
In-Reply-To: <CAMes488xPhpKuYUxgHd1WnnQUCUwmeOseCGtTv+Y9Z52b4MRnQ@mail.gmail.com>
From:   Jon Doe <tuksgig@gmail.com>
Date:   Sat, 28 Oct 2023 08:51:04 +0200
Message-ID: <CAMes48-XTQoqR7WqVmbcOsoiLen_9E9Qz+SR7SeGm=SZz6gOQg@mail.gmail.com>
Subject: Re: rtw88 usb adapter can't authenticate
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Also tested with AP encryption set to the older WPA1 and Open
encryption - no joy. Tried random stuff like disabling WMM and setting
20MHz bandwidth - makes no difference. Scanning works on both 2.4 and
5.8GHz but can't join any Access Point.

On Fri, Oct 20, 2023 at 7:30=E2=80=AFAM Jon Doe <tuksgig@gmail.com> wrote:
>
> I re-tested with different SSIDS on 2.4 and 5GHz, same problem, fails
> to authenticate. Tested with 3 different access points. Latest kernel
> I tested with is 6.5.5 on Manjaro Linux.
>
> On Thu, Oct 19, 2023 at 6:11=E2=80=AFPM James <bjlockie@lockie.ca> wrote:
> >
> > Oct 19, 2023 11:00:56 AM Jon Doe <tuksgig@gmail.com>:
> >
> > > Hi,
> > >
> > > I have a Cudy AC1300 model WU1400 USB Wifi adapter that fails to
> > > authenticate properly. Driver for this device is rtw88_8822bu.
> > > Reported this previously at
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2188243 with logs of th=
e
> > > error messages.
> > >
> > > Scanning works but authentication fails after 3 attempts. Any ideas?
> > Have different SIDs for 2.4ghz and 5ghz.
> > That causes problems.
