Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDE70864A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERRAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERRA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 13:00:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E6121
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 10:00:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-966287b0f72so417670666b.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684429226; x=1687021226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUXEtZJZvyLXh2AaJKDEr1FMVfNqtlJu5NqjuDtmtgI=;
        b=BNzwhzyc4fGvbOevYD1QpDzHd3fyDUhLS3QVtTMUvLDsl2SX1FIznY4f/usVvptHW7
         FRWsBVw36IdNxPg9q2Ddxqn3quDcZkmFtpficbw6U/JYb8IIa/Co6fA+6ke4tr0IBpx0
         45cjzzG9gkh9DmPq0IpvwGnUCt7PrL2lfvUdQLdfbwZqBgFfuR2Ke9v6Bp10ouNxkk1o
         EkWJMofsyo8l9QgG2jCVgIUpVaFO5J/1ba3sHuRYQmFM9aJnw48xJqRc9OZkmPFk3+G/
         7SH2rcvUc0e0pfT/sDRCRKG45BQbmOHT8Xzd7LPhIdwVGrvj3D0Ve7Z7KEM1vGcizeme
         vPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684429226; x=1687021226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUXEtZJZvyLXh2AaJKDEr1FMVfNqtlJu5NqjuDtmtgI=;
        b=jNQL5N/vGi6cNHixbhgG2yB5V+kYgy9hRog5f3hA2/EMmFNInpAIip6pvf5cOZVuBa
         fpbN+xzOOsrIlrKnqOAx+mbWJou10rbplLvx/P7L02+zTAeFuP6E6dtGefykvbAGH3V+
         YsGfRFTsGKxuSHATsque5bw4QXKTRNDBAVoowks0rWCUMorDVxhvbaMJOICQzvwxXUsN
         4C8/jG0mFD6T1yr2h1g+xPTLUMhNQm5aSh3i2jyFnTNq3YdwN9sAkVdaIQAD3+xyDWQW
         cvyyEexiaCE9bTvU+4yna7WIs1oP7CE2DqxTF6Vsrc8oT65GSa1r88dniw0Ol6z6V4k/
         bZDg==
X-Gm-Message-State: AC+VfDzIEaF4dkmAP/Q9opnO8j3oMemGbVJtU4+KdtTviLih5duM/hVX
        xwEBblPBB35J8/DTMlynLgpLbNilLsPfPGv2O0w=
X-Google-Smtp-Source: ACHHUZ4QcFOJP3j4RFclXGXRUcua132sojuFGIQXMMdkJZnnj8gTlN7+52pASP78SMjNXMj5iF1SwMIUjh7mb0iNsMw=
X-Received: by 2002:a17:907:9405:b0:957:12a6:a00f with SMTP id
 dk5-20020a170907940500b0095712a6a00fmr39750427ejc.21.1684429226284; Thu, 18
 May 2023 10:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
 <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
In-Reply-To: <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 May 2023 19:00:14 +0200
Message-ID: <CAFBinCD3nPPHUmtoqRch87SOXpLcfrzOT7SDdsJdGe-KGOK9Mg@mail.gmail.com>
Subject: Re: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
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

Hi Ping-Ke,

On Wed, May 17, 2023 at 4:06=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi Martin,
>
> > -----Original Message-----
> > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Sent: Wednesday, May 17, 2023 12:40 AM
> > To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
> > Cc: Larry Finger <Larry.Finger@lwfinger.net>; tony0620emma@gmail.com; j=
ernej.skrabec@gmail.com
> > Subject: wifi: rtw88: questions about adding support for RTL8723DS/RTL8=
723BS
> >
> > Hello Ping-Ke,
> >
> > as a next step I want to add support for RTW_WCPU_11N SDIO cards to
> > the rtw88 driver.
> > Currently only one RTW_WCPU_11N chip is supported: RTL8723D by the
> > rtw88 (PCIe and USB HCIs).
>
> Originally, we intended to add 8723D to rtlwifi, because it is a 802.11n =
chip
> and very similar to 8723BE. However, its PCIe HCI is changed to use circu=
lar
> ring instead of own bit, like other chips implemented in rtw88.
As far as I can tell such differences are not present in the SDIO HCI

> >
> > My first question is very hopefully a simple one:
> > It seems that RTL8723DS has two SDIO IDs: 0xd723 and 0xd724.
> > Do these have the same name or is there some kind of "revision" (like
> > rev 2, revision B, ...) internally?
>
> 0xd723 is dual antenna, and 0xd724 is single antenna. Since 8723D is a
> 1x1 WiFi BT combo chip, 0xd723 can have a dedicated antenna for BT.
> The main difference will be BT-coex code.
Awesome, thanks for the explanation. I sent patches to add RTL8723DS
support to the rtw88 driver.

> >
> > My second question is more abstract:
> > Based on my understanding of the vendor drivers for RTL8723BS and
> > RTL8723DS both seem very close in terms of registers. initialization
> > sequence, ...
> > So I am hoping that it's possible to add RTL8723BS support to the rtw88=
 driver.
> > There's two main differences that I found so far:
> > - rtw_dump_hw_feature() doesn't work because REG_C2HEVT has an
> > incorrect value (C2H_HW_FEATURE_REPORT is expected but it still
> > contains C2H_HW_FEATURE_DUMP). It seems that this is a firmware issue.
>
> Not an issue. At that moment of developing 8723B, applications are simple=
, so
> we don't read feature from firmware, so just ignore this for 8723B.
Jernej also suggested this as a first step. So I guess it's the way to go.

[...]
> > Have you considered adding RTW8723B support to the rtw88 driver?
> > Do you have some initial suggestions on what would be needed to do so
> > (is my list from above complete, what do do about these points, ...)?
>
> As my comment above, 8723BE use different PCIe design, and rtlwifi
> has been supported it, so I don't have plan to support 8723BE in rtw88.
> But, to add 8723BS to rtw88 seems workable.
>
> To add 8723B, you can make a copy from 8723D and change settings along
> with vendor driver. The main things you need to review are:
> 1. PCI probe when plugging wifi card
> 2. hardware initialization when interface up
> 3. RF calibration when starting connection (you may put this work later)
> 4. connection setting after connected
> 5. BT-coex you have mentioned
>
>
> To make rtlwifi support SDIO is another way. It seems like add a HCI is
> easier than an new chip, and we can have a simple support list of rtlwifi
> and rtw88 eventually, like
>
>         rtlwifi       rtw88
> 8723BE    o
> 8723BS    o?
> 8723DE                  o
> 8723DS                  o
Per chip support matrix is:
8723BE: rtlwifi
8723BU: rtl8xxxu
8723BS: staging driver which I'd like to replace
8723DE/U/S: rtw88

HCI support matrix:
rtlwifi: PCIe, USB
rtl8xxxu: USB
rtw88: PCIe, USB and SDIO

So it seems you are right: I should consider whether adding RTL8723BS
support to rtw88 is the right choice.


Thank you!
Martin
