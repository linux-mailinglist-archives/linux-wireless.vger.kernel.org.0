Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926073615E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 04:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFTCDg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 22:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTCDf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 22:03:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A1DC
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 19:03:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b6824141b4so802295ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 19:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687226611; x=1689818611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tAsvE1pinGCofjVRzp2jxO2djEmDqJJ+2E/EZW9AG4=;
        b=YqguyFufPwAYJfbpy3ngdUkmEBWkObhlBL+rC5njA+wR4y2gd8J8HMas5qlf1u9EfO
         8sac5zDDBfYgFpEKYZTMK8pu62JVBuHCgg+jvBcGchyCeq5o2AWqcv1JWMEJ+Y5brVLV
         1y3imPnBIHD5bjbz2LwUqWvklwPtr70BgXsgevkYzGaPeu7ZRSweoPxVF0cl2uq7bQH7
         YaDQ0pYJEwT4c9lYUlbOT7wmPDhCyFJtQmabHS4BMicZOJk7Ubpth3gRvjm8CJmKp2GX
         Jqy9d2vsPqqV45fOZtT9YkDo8NG2yHrbCGfhRrQSeeGImT/K3rr4sgqFjvNT/1Wznk8B
         Qq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687226611; x=1689818611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tAsvE1pinGCofjVRzp2jxO2djEmDqJJ+2E/EZW9AG4=;
        b=YVcwZaET1tl3v6nYRD/lpn6325k/3BQszVUeeL4aw2P/Xf51QLLXn9xY3Eo2Oj8hLT
         JMZVoF2IsQp0N3fbcx6+AUhRMk9Ft/VO9ZtrOTT6XwZaU0iyOiSSMhVoKgZ1dp2GtLDn
         DAw5te2SPUzm03Hrzla2vm2Nh6Y8g1GNAsX8CSTTDjnvMxsJFnzGmdwta2fz1+YFJnGh
         xns5wdSzF0XT6uBPFLAObCujJZu3VlevHOyemF7niZcxSutfCI5doi4GH71kxcTaMcuE
         kPFOTqbPWNnACH4n26984+6WlxzzjhMSLxX6y/9asbeONomKIjDwhSIfUzWQ2hSJj/rs
         Hz2A==
X-Gm-Message-State: AC+VfDzAKgmIhCW9Xwd2Z3wImY0nzpK8GMvbVpjT1jr79qF4Htt436C3
        m/3uNCYFZALklQKOGVZbSf7K7LhY0iF3+MTkclMSpSHgV8pVdw==
X-Google-Smtp-Source: ACHHUZ57ck1uR4bUCzAJR5TyfajwxAXqwZisQ93voU2/UUCbAZbzg8uU1WuVKFBQ8r7eVK38E3Z27CWUzkIdWJs/shU=
X-Received: by 2002:a17:903:22c4:b0:1b1:1168:656b with SMTP id
 y4-20020a17090322c400b001b11168656bmr16246307plg.26.1687226611487; Mon, 19
 Jun 2023 19:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
 <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca> <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
 <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca> <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
 <CALKa4bTJMQqhH5rDcReMWehdc1=Dj3J+danGToMpqe0hj6nNSg@mail.gmail.com> <1231d03d-722a-4282-8066-27dd8a516163@lwfinger.net>
In-Reply-To: <1231d03d-722a-4282-8066-27dd8a516163@lwfinger.net>
From:   Utkarsh Verma <utkarsh.naveen@gmail.com>
Date:   Tue, 20 Jun 2023 07:33:20 +0530
Message-ID: <CALKa4bSUR8UOjpue8nxkS61PkO6U6xygCdVqR-MMDH2w4XVwWg@mail.gmail.com>
Subject: Re: RTL8822BE not working after suspend
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

Hi,

I just wanted to that after a couple of weeks of testing, I still
couldn't get reliable behaviour. I installed the new Realtek drivers
with the systems loading/unloading script. Sometimes my WiFi works
after resume, sometimes it doesn't. I tried finding patterns, but
couldn't. Please let me know how we can investigate this.

Regards,
Utkarsh


On Wed, Jun 7, 2023 at 9:25=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger.=
net> wrote:
>
> On 6/6/23 20:04, Utkarsh Verma wrote:
> > I have a small request from my side as a user. Please mention on the
> > GitHub repo that these drivers are not in the kernel yet and will be
> > merged around Linux 6.5. This is because I stumbled upon this repo a
> > couple of times before as well, but I did not trust it enough and even
> > thought that they might be older than the kernel's drivers.
> >
> > Additionally, is there any way we can have this working without the
> > systems module loading/unloading shenanigans? I would love to see this
> > work by default, as it does on Windows. I can help you with the driver
> > testing if you wish.
>
> I could make it more clear in the README.md that the rtw88 repo has code =
that
> will be in a future kernel, but that information is available in the git =
logs. I
> cannot help your trust issues!
>
> The problems with your BIOS that require unloading and reloading the driv=
er when
> suspending or hibernating are found only in some HP or Lenovo laptops. It=
 is
> beyond my capability to fix the actual bug, thus we give you a workaround=
. What
> does the Windows driver actually do to overcome this problem? As none of =
us have
> seen that code, we have no idea!!
>
> What harm is there in running the unload/restore script? On my laptop, it=
 is
> totally transparent except for a few extra lines in the log.
>
> Larry
>
