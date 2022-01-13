Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB048D726
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 13:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiAMMHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 07:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiAMMHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 07:07:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1612C061751
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 04:07:45 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m3so4677387lfu.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 04:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAP1FMAcpDzFu2Al3uF90uC2rPxA7nQ6In3o8LmKt5s=;
        b=qpmGhEHzag2mgXSZKa5TAnx3QaK1NbGnAER0oaVqrs4235lfxcPYEu6RkZZSJCOoPv
         fPoBNLE1aUJ9aRcwT7ubxdZ7LLxN9JWAOCAia51t3hCZHXDctKsSq3DKxK4DrIxUroFK
         tjjKbu+vV2oHJuYMHZGk5ky3D5wThluYs7C+51WPc9XiU8XOBH+0iAYGryx20S8qu6Ku
         fy1xI80rk8VYsjWTdipBraXmPvbtN/ESxHap5ICZG+ZMzrtbCQMbgG+QXs2kT1r39Cm2
         eHBQPtVFcE/nACv6lSC5hfV2IXGd7VAmKmLMtwIVSX/nhteT4iwRZNtmmqVQGnlKqNfn
         7oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAP1FMAcpDzFu2Al3uF90uC2rPxA7nQ6In3o8LmKt5s=;
        b=p+j3oQqqMhsKzOiQXHgOENoOQDGJMUePuQ3bl8UUxVGWItXUJQxwW3FgdTNrQ74E73
         p0xRtRe04qVjG/4gDBiIGzgYGaFDojZNq6NN7HLm16yguCpZdAcqDIvVb9cI1MdDzSxU
         oFDO3poHf4b7NHPZxJXp5L5n/nb2JAxr0UlNGfbWi+TLf+0sbNO9D5A8Spj3EZnYmZ4f
         bpH6pZu4MaXusXME13Pt6dlexJH2XVZaC8uw+28qle6Kujd/8lhtPN2nBZOIHGIe98VU
         zZegs6b2RAeycLKZfXGjcBVdMzmZi3ptewr6gJtgOykyzdIWhHwvYPfNdX1VXvTu7ljN
         WiiQ==
X-Gm-Message-State: AOAM5320XbwNCP8RthOJP2lrke+Vjb5qOWJMOwDTEoGDD4093dTH/L2B
        qdkSgRESsBd4Go+aBVBKnTxBknEp66T8GQFbtr5HiQ==
X-Google-Smtp-Source: ABdhPJzxAe/t75YtFir2L4jJA4G2mrPispiMgqp0nFdc982lOD9tckYYL9T6XUM9QO4bDrmKBqAue0W3sTdc9U0ygKE=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr3035788lfr.71.1642075664297;
 Thu, 13 Jan 2022 04:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
 <2680707.qJCEgCfB62@pc-42> <20220112174848.db5osolurllpc7du@pali> <1655654.vHqhSpDN13@pc-42>
In-Reply-To: <1655654.vHqhSpDN13@pc-42>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jan 2022 13:07:06 +0100
Message-ID: <CAPDyKFpP-Ta=wUuOE1m4wqsoKACV564nhJ=c2OeL0H5LjG2yrg@mail.gmail.com>
Subject: Re: [PATCH v9 08/24] wfx: add bus_sdio.c
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 12 Jan 2022 at 19:24, J=C3=A9r=C3=B4me Pouiller
<jerome.pouiller@silabs.com> wrote:
>
> On Wednesday 12 January 2022 18:48:48 CET Pali Roh=C3=A1r wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> > On Wednesday 12 January 2022 17:45:45 J=C3=A9r=C3=B4me Pouiller wrote:
> > > On Wednesday 12 January 2022 12:43:32 CET Pali Roh=C3=A1r wrote:
> > > >
> > > > On Wednesday 12 January 2022 12:18:58 J=C3=A9r=C3=B4me Pouiller wro=
te:
> > > > > On Wednesday 12 January 2022 11:58:59 CET Pali Roh=C3=A1r wrote:
> > > > > > On Tuesday 11 January 2022 18:14:08 Jerome Pouiller wrote:
> > > > > > > +static const struct sdio_device_id wfx_sdio_ids[] =3D {
> > > > > > > +     { SDIO_DEVICE(SDIO_VENDOR_ID_SILABS, SDIO_DEVICE_ID_SIL=
ABS_WF200) },
> > > > > > > +     { },
> > > > > > > +};
> > > > > >
> > > > > > Hello! Is this table still required?
> > > > >
> > > > > As far as I understand, if the driver does not provide an id_tabl=
e, the
> > > > > probe function won't be never called (see sdio_match_device()).
> > > > >
> > > > > Since, we rely on the device tree, we could replace SDIO_VENDOR_I=
D_SILABS
> > > > > and SDIO_DEVICE_ID_SILABS_WF200 by SDIO_ANY_ID. However, it does =
not hurt
> > > > > to add an extra filter here.
> > > >
> > > > Now when this particular id is not required, I'm thinking if it is =
still
> > > > required and it is a good idea to define these SDIO_VENDOR_ID_SILAB=
S
> > > > macros into kernel include files. As it would mean that other broke=
n
> > > > SDIO devices could define these bogus numbers too... And having the=
m in
> > > > common kernel includes files can cause issues... e.g. other develop=
ers
> > > > could think that it is correct to use them as they are defined in c=
ommon
> > > > header files. But as these numbers are not reliable (other broken c=
ards
> > > > may have same ids as wf200) and their usage may cause issues in fut=
ure.
> > >
> > > In order to make SDIO_VENDOR_ID_SILABS less official, do you prefer t=
o
> > > define it in wfx/bus_sdio.c instead of mmc/sdio_ids.h?
> > >
> > > Or even not defined at all like:
> > >
> > >     static const struct sdio_device_id wfx_sdio_ids[] =3D {
> > >          /* WF200 does not have official VID/PID */
> > >          { SDIO_DEVICE(0x0000, 0x1000) },
> > >          { },
> > >     };
> >
> > This has advantage that it is explicitly visible that this device does
> > not use any officially assigned ids.
>
> Ulf, are you also agree?

Sure, that works for me too.

Kind regards
Uffe
