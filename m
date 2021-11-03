Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519B444704
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhKCR2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 13:28:34 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:41793 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhKCR2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 13:28:33 -0400
Received: by mail-yb1-f182.google.com with SMTP id v138so8114104ybb.8
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 10:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJ4aF2Y0Hbv77sDGdBaCQ+PyHG4bBO9TOdXnmQZM9a0=;
        b=JDkHGKpzkIzYbMW4G3yBxf5QWyFKAd0PaBlEALekiUEBTOXwaMuPvqqFWWg5AmY1WZ
         xtdcT6sYigFeQVGiT0b7c6HpKlSodVW+P+oluT97ZL0SDusZ0PY8hDog3jy4YQpCK5/M
         hxpR5pMgMRFoADLn2rGenifWwYS3fGR+Gd5hmjrD0xZl0eTpwK5z9x79rPq0eeAhIkeQ
         pgsVI4WlFMekQ/0bz2Xf5TmOq8N9bbA872WyQ2bEFOnC0F2ay2bCkDn6PcQtye43Q3MK
         CFRzWaMzNjWiF2vOITCVPzKpes40MPxHe6NYpCoxIi16kGtGZ4CCDlMNiwTiQb/M1qP8
         as1Q==
X-Gm-Message-State: AOAM531Ew0FcjDnqMUs3YlKy1oYiknjSiQUP/QxeGNnoE4OyFNpqS32V
        i97iy6IB+pVb1flQNnvgvoinPg+jsEcqn/wNmF7rliuOAI0=
X-Google-Smtp-Source: ABdhPJwHmsnc++aFoUEn13B/erYZvI/H00YSYX8kUQVnQQeq/4rNlYBkzyb/goqAlmZygiM7kcgXgkWKC6NiQI6+RtA=
X-Received: by 2002:a25:c08e:: with SMTP id c136mr37459617ybf.461.1635960356631;
 Wed, 03 Nov 2021 10:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
 <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
In-Reply-To: <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
From:   Bogdan Nicolae <bogdan.nicolae@acm.org>
Date:   Wed, 3 Nov 2021 12:25:30 -0500
Message-ID: <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
Subject: Re: No support for Realtek 8821CE RFE Type 6
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Ping-Ke,

The Realtek Wifi 8821CE RFE Type 6 is used in a broad range of
embedded systems based on Intel Celeron J4125 SoCs. A popular example
is GK3 Mini PC, sold under a large number of brands, for example:
https://www.amazon.com/gp/product/B09FTCPBHK/
These systems are rising in popularity in favor of laptops, as people
tend to stay at home and are looking for affordable upgrades.
Unfortunately, lack of Wifi Linux support is a major drawback.

Best regards,
Bogdan Nicolae


On Wed, Nov 3, 2021 at 3:01 AM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Pkshih
> > Sent: Wednesday, November 3, 2021 1:45 PM
> > To: 'Bogdan Nicolae' <bogdan.nicolae@acm.org>; linux-wireless@vger.kernel.org
> > Subject: RE: No support for Realtek 8821CE RFE Type 6
> >
> >
> > > -----Original Message-----
> > > From: Bogdan Nicolae <bogdan.nicolae@acm.org>
> > > Sent: Thursday, October 28, 2021 1:05 PM
> > > To: linux-wireless@vger.kernel.org
> > > Subject: No support for Realtek 8821CE RFE Type 6
> > >
> > > All,
> > >
> > > The chipset in question is Realtek Wifi 8821CE RFE Type 6. Support is
> > > only available up to Type 4 (Kernel 5.14.14). Are there any plans to
> > > provide support for Type 6? If so, when?
> > >
> >
> > We will arrange resources to support RFE type 6.
> > ETA is about 3 months.
> >
>
> I check internally with this RFE type, but we don't clear which notebook/computer
> uses this type. Could you share the model name of your computer?
> Or, you buy the chipset somewhere?
> Or, you want to build this chipset into your product.
> Please give us more information to move further.
>
> --
> Ping-Ke
>


-- 
Bogdan Nicolae
Computer Scientist
Argonne National Laboratory
Web: www.bnicolae.net
