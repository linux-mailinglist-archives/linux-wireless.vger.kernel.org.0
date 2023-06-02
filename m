Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67F071F93C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 06:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjFBETZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 00:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBETX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 00:19:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A498
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 21:19:22 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af78ce91b1so1532421a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jun 2023 21:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685679561; x=1688271561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bXgU/Gcsjr7qQ0EHAgshRoaBJvJQMrW2qGi+fPcPXY=;
        b=XDUsVmrfU3IPjtXUNrAWhJxLpbjg5605WN+cOlAx0nMzkYnkl0SohP+2w3n1YaH63c
         /aEwt2tQYszzVAHv4G1A034PvvLVUmePq3WVMtNb8QhmB5e/+46SaffMyhDw6muOgH/y
         6cAWvAsekgs0WI5eZ1yLF2Q2spt2mBNMcehYSfqVNqVdkbX/+xEPLWGMcfug8D6uzYM+
         cLYdW1aTyI/D0x4eKL38nuo1WQwl/Ri8CHjQ8j/83jczmzzRyEU0QkLqRYUxbgVssbyj
         7otTtRIe48loIDmztxNmHlGXacwJN3z/VT6wAHHYL8AizSrNInHS7KNbx6VpgIWgGQ47
         yJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679561; x=1688271561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bXgU/Gcsjr7qQ0EHAgshRoaBJvJQMrW2qGi+fPcPXY=;
        b=WOFrtg1XYt3eogoC87s1QGXVstDFG3nlPTqcmkc8EPbwZbekG9rLm9bvjXQy8MYK7A
         SrnpZKX1vKzkzd0yaX7mGdNv9lqkWln7DKxQObdXA2llSlUAsVUptioCzG16jsifjbkn
         0Sagi5kzVhb5uzw3Ht2YkXaWswxXFOKyC6GaDTdjixLDwPF5u1je73VyWcY1sqXVe275
         gZQZFIO6kobpZjdzBzP87bGmFzM7gmNz/CNpFkyiyEdUoBlwF6HP5Nik/H4c/w5QMDG7
         amEXSSvcXPXutP5BV5GQ202a3DT+0fG+3pE+mmxD9TVevCgAVYvO83yEaS1cPJi0YFwA
         jF7Q==
X-Gm-Message-State: AC+VfDwnXVfYG1QD1kU5MT81mAk6rlnloCaByUZpmx7LERvgevH+j3jG
        fhMQPI9X+Lf3hNWAF2O1bEms2ve2A8fc8XmrUWENNYddx3U=
X-Google-Smtp-Source: ACHHUZ7l1sbF/tXxJvBymUwrSyFIZCsGNOzGCFY2dfur4ooaOLesKX5Givc6BtnwHbdapE466wG8wqcpUCRUi43YSHU=
X-Received: by 2002:a05:6830:107:b0:6a8:b659:d46e with SMTP id
 i7-20020a056830010700b006a8b659d46emr1376668otp.8.1685679561551; Thu, 01 Jun
 2023 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com> <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
In-Reply-To: <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
From:   Utkarsh Verma <utkarsh.naveen@gmail.com>
Date:   Fri, 2 Jun 2023 09:49:10 +0530
Message-ID: <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
Subject: Re: RTL8822BE not working after suspend
To:     James <bjlockie@lockie.ca>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I had been using Linux v6.3.5 for a while and switched to v6.1.31-lts
only yesterday, hoping it might work. The same issue happens on newer
kernels like Linux v6.3.5 as well.

On Fri, Jun 2, 2023 at 9:20=E2=80=AFAM James <bjlockie@lockie.ca> wrote:
>
> Try a more recent kernel.
>
>
> On 2023-06-01 21:33, Utkarsh Verma wrote:
> > Additionally, here is the dmesg log after resuming the laptop:
> >
> > Jun 02 06:25:06.698947 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to poll offset=3D0x5 mask=3D0x2 value=3D0x0
> > Jun 02 06:25:06.699373 metia kernel: rtw_8822be 0000:04:00.0: mac
> > power on failed
> > Jun 02 06:25:06.699751 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to power on mac
> > Jun 02 06:25:08.698770 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to poll offset=3D0x5 mask=3D0x2 value=3D0x0
> > Jun 02 06:25:08.699414 metia kernel: rtw_8822be 0000:04:00.0: mac
> > power on failed
> > Jun 02 06:25:08.699800 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to power on mac
> > Jun 02 06:25:20.688984 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to poll offset=3D0x5 mask=3D0x2 value=3D0x0
> > Jun 02 06:25:20.689553 metia kernel: rtw_8822be 0000:04:00.0: mac
> > power on failed
> > Jun 02 06:25:20.689968 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to power on mac
> > Jun 02 06:25:22.692089 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to poll offset=3D0x5 mask=3D0x2 value=3D0x0
> > Jun 02 06:25:22.692584 metia kernel: rtw_8822be 0000:04:00.0: mac
> > power on failed
> > Jun 02 06:25:22.693016 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to power on mac
> > Jun 02 06:25:24.958755 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to poll offset=3D0x5 mask=3D0x2 value=3D0x0
> > Jun 02 06:25:24.959390 metia kernel: rtw_8822be 0000:04:00.0: mac
> > power on failed
> > Jun 02 06:25:24.959814 metia kernel: rtw_8822be 0000:04:00.0: failed
> > to power on mac
> >
> > On Fri, Jun 2, 2023 at 6:59=E2=80=AFAM Utkarsh Verma <utkarsh.naveen@gm=
ail.com> wrote:
> >> Hi everyone,
> >>
> >> This is my first bug report on the mailing list, so please let me know
> >> if I mess anything up.
> >>
> >> I have an ASUS TUF FX505DT which has the RTL8822BE WiFi card. It works
> >> fine normally without any issues. However, once I suspend my
> >> laptop(closing the lid) for a considerable amount of time (> ~30
> >> mins), the WiFi card doesn't work after resume and I have to reboot
> >> every time.
> >>
> >> This bug really undermines the portability aspect of the laptop as I
> >> can't simply close the lid and continue my work later. The WiFi simply
> >> dies every time I suspend, and I have to reboot.
> >>
> >> It would be really helpful if I could get this to work in the meantime
> >> as well with a workaround as I will be on the move soon.
> >>
> >> Lastly, thank you for all the work put into the drivers. They work
> >> mostly fine without any issues. This suspend issue is the only thing I
> >> can see, and I would be glad to help to get it fixed.
> >>
> >> My machine details:
> >> OS: Arch Linux w/Linux 6.1.31-1-lts
> >> Card: Realtek 8822BE WiFi
> >> Laptop: ASUS TUF FX505DT
> >>
> >> Please let me know if you need further information.
> >>
> >> Regards,
> >> Utkarsh Verma
>
