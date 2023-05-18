Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E570867B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjERRNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjERRNu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 13:13:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890CCC
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 10:13:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96aadfb19d7so427984066b.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684430028; x=1687022028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGRch5MesMtfF1yR8AQyhdcSokQav62b9T0L9SqNNRs=;
        b=aOTJmvLHtnvgP/+rMWwzDzJ8rkrVJgrakF1pO6kXedoVhqGo2UHtU1OeTnx+1E2n9I
         xPNrBz1Rxy6RZiKaf+0v0u+ZKh5T64ywWoVr3nnM8Qo7fQV9HnB2vG0RLKk69Hkw0H+H
         XYJpUwm1q/F0mXgWnlvUBRu6jLyWP/T6M19V4iciTVckv7l+wkLQRvESAsj7H0KjlOSY
         WA+m4ntJmiZmqnmIN0GQcYUeWMpbASArk2pi1zIic73JGCGCuaMgn8iKxswUygzZRAfj
         YoXYaX4iPnCxHKTNYtOHXnYL/H/aK5asfZAi3CBex3k5J2SE+uYg4Tkd/NhdbL3edDqg
         XWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430028; x=1687022028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGRch5MesMtfF1yR8AQyhdcSokQav62b9T0L9SqNNRs=;
        b=VYnzXoS32VA8K3OYAnmO+5c7SOtzYXq4n6YaXHDQSzFLrH7a8/BntHu8CwX/P3oZEp
         hT/tS3h9UYb/nPPB+dVQ7/+Ol9bjl/q4yTFlQYhbcnoFa2McH3SGizCz+W43lgiObAY1
         RubEKe9vthxfXmnILoZqYUMg9NCu0aF6fDxl7ZFbtj48Zz6aBioZh8zDqgkpejT1WLBZ
         NzR2uPPWDaPPVn0KSIyIxJpIN3iSv+z7iDXrRhAxM/ZsxvnvDBmZVNeMtl5d/72epeEZ
         Izy0lXRD7EtBGu9OintbZcmBUPtjxigcOGYw5njk5U7k+R0cZhN+OVIwTNE1aFJ+hGJL
         Lpig==
X-Gm-Message-State: AC+VfDzHZcOpYDxI7mnTwjaZgQZbKB1IjW9Drdt2xElHBG6dymzB4ipH
        kAQ7ABiKP/A85kd9+4zhpmfL7MTs6agH/A==
X-Google-Smtp-Source: ACHHUZ7X32mZV7Oi9xZYkWfezwXLEJHIzkUMiNHV+uRFz7zriTGPU2sWTP0kEUStjvz2PgHk8SQrQg==
X-Received: by 2002:a17:907:94ca:b0:96b:e93:3aa8 with SMTP id dn10-20020a17090794ca00b0096b0e933aa8mr16179310ejc.21.1684430027687;
        Thu, 18 May 2023 10:13:47 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id kg10-20020a17090776ea00b0096ae4451c65sm1211090ejc.157.2023.05.18.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:13:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: Re: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
Date:   Thu, 18 May 2023 19:13:43 +0200
Message-ID: <5673351.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <CAFBinCD3nPPHUmtoqRch87SOXpLcfrzOT7SDdsJdGe-KGOK9Mg@mail.gmail.com>
References: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
 <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
 <CAFBinCD3nPPHUmtoqRch87SOXpLcfrzOT7SDdsJdGe-KGOK9Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dne =C4=8Detrtek, 18. maj 2023 ob 19:00:14 CEST je Martin Blumenstingl napi=
sal(a):
> Hi Ping-Ke,
>=20
> On Wed, May 17, 2023 at 4:06=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com>=
 wrote:
> >
> > Hi Martin,
> >
> > > -----Original Message-----
> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > Sent: Wednesday, May 17, 2023 12:40 AM
> > > To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
> > > Cc: Larry Finger <Larry.Finger@lwfinger.net>; tony0620emma@gmail.com;=
 jernej.skrabec@gmail.com
> > > Subject: wifi: rtw88: questions about adding support for RTL8723DS/RT=
L8723BS
> > >
> > > Hello Ping-Ke,
> > >
> > > as a next step I want to add support for RTW_WCPU_11N SDIO cards to
> > > the rtw88 driver.
> > > Currently only one RTW_WCPU_11N chip is supported: RTL8723D by the
> > > rtw88 (PCIe and USB HCIs).
> >
> > Originally, we intended to add 8723D to rtlwifi, because it is a 802.11=
n chip
> > and very similar to 8723BE. However, its PCIe HCI is changed to use cir=
cular
> > ring instead of own bit, like other chips implemented in rtw88.
> As far as I can tell such differences are not present in the SDIO HCI
>=20
> > >
> > > My first question is very hopefully a simple one:
> > > It seems that RTL8723DS has two SDIO IDs: 0xd723 and 0xd724.
> > > Do these have the same name or is there some kind of "revision" (like
> > > rev 2, revision B, ...) internally?
> >
> > 0xd723 is dual antenna, and 0xd724 is single antenna. Since 8723D is a
> > 1x1 WiFi BT combo chip, 0xd723 can have a dedicated antenna for BT.
> > The main difference will be BT-coex code.
> Awesome, thanks for the explanation. I sent patches to add RTL8723DS
> support to the rtw88 driver.
>=20
> > >
> > > My second question is more abstract:
> > > Based on my understanding of the vendor drivers for RTL8723BS and
> > > RTL8723DS both seem very close in terms of registers. initialization
> > > sequence, ...
> > > So I am hoping that it's possible to add RTL8723BS support to the rtw=
88 driver.
> > > There's two main differences that I found so far:
> > > - rtw_dump_hw_feature() doesn't work because REG_C2HEVT has an
> > > incorrect value (C2H_HW_FEATURE_REPORT is expected but it still
> > > contains C2H_HW_FEATURE_DUMP). It seems that this is a firmware issue.
> >
> > Not an issue. At that moment of developing 8723B, applications are simp=
le, so
> > we don't read feature from firmware, so just ignore this for 8723B.
> Jernej also suggested this as a first step. So I guess it's the way to go.
>=20
> [...]
> > > Have you considered adding RTW8723B support to the rtw88 driver?
> > > Do you have some initial suggestions on what would be needed to do so
> > > (is my list from above complete, what do do about these points, ...)?
> >
> > As my comment above, 8723BE use different PCIe design, and rtlwifi
> > has been supported it, so I don't have plan to support 8723BE in rtw88.
> > But, to add 8723BS to rtw88 seems workable.
> >
> > To add 8723B, you can make a copy from 8723D and change settings along
> > with vendor driver. The main things you need to review are:
> > 1. PCI probe when plugging wifi card
> > 2. hardware initialization when interface up
> > 3. RF calibration when starting connection (you may put this work later)
> > 4. connection setting after connected
> > 5. BT-coex you have mentioned
> >
> >
> > To make rtlwifi support SDIO is another way. It seems like add a HCI is
> > easier than an new chip, and we can have a simple support list of rtlwi=
fi
> > and rtw88 eventually, like
> >
> >         rtlwifi       rtw88
> > 8723BE    o
> > 8723BS    o?
> > 8723DE                  o
> > 8723DS                  o
> Per chip support matrix is:
> 8723BE: rtlwifi
> 8723BU: rtl8xxxu
> 8723BS: staging driver which I'd like to replace
> 8723DE/U/S: rtw88
>=20
> HCI support matrix:
> rtlwifi: PCIe, USB
> rtl8xxxu: USB
> rtw88: PCIe, USB and SDIO
>=20
> So it seems you are right: I should consider whether adding RTL8723BS
> support to rtw88 is the right choice.

While rtw88 might not be best choice by above matrix, it seems to be most
featureful, stable and at least from what I saw, easiest to add new variant=
s.

I'll do a bit of experiment with rtw88 to see how hard it would be...

Best regards,
Jernej




