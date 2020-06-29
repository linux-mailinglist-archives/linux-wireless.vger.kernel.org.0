Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA120E0A3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgF2UsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbgF2TNu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57CC0086BB
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 02:55:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f23so16485433iof.6
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=i2cat.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=osFpWH5ezCDs3ovdI9rF9H2cXlgw1bDqX1r5/GU4kPE=;
        b=Cxt0lG9qOQDSh6iXT0jVpJUNWzkS9bL1PzV1nSu7PFueYUuN61QtiLZTE3cKHY+QdC
         gmvgQpuiUPkXSax1AORjXhJpMplympptUGBaQISgn/8NtnWI/8GDdFlWK0GBjU9oLvDZ
         aoR5U6GOVttaS1A1Rnn7wmckvnJABTkj4Kuy//uJZRx+YbuKdU44yhX+lMgGl43DTFJb
         s15FSwEk1sJ3BL+O3cop+g13ckzmtTA5V4XqgCjUgfXrLxRHkn61FlzfOVTk2nS5qd8b
         v2pt92nHFms7qN8YoG1mf48GupCQAmWv4yKMSMWx4XlGoGBHlqLq/aKmroRmYJuaqxH2
         xvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=osFpWH5ezCDs3ovdI9rF9H2cXlgw1bDqX1r5/GU4kPE=;
        b=JYZ1whe4DGtw7W+9frBEVHdIz/AZAoI8ZP9txVZjRbN5USjeOwTZdnLggSH+rWypx7
         c3ka3Ov+RVPxQQmiSTfi1uxrn0ntsbsAQDV/BayHHdO8BhI/4EgDjhcduwGGeRhcwM1V
         BISzPlXqJ48slseBB/5dtSochbPaYJ3G23ytJRssJkMjNr8ZZ7T0fi1j39aSDBgBbgmZ
         IdXjBGCRdDAbsvlGC/3h9y9VT1oBeuPGTtJ/jlTp0aD4weOcRUTI+7ysz61I1UZVQqRW
         HfxHssh+4YkeL/5VceQIi8LeHJSPhGg076ljrrEtlozVeIgkhaDBLIbj2NMvbAD75ic1
         rcRA==
X-Gm-Message-State: AOAM531h/GOLu4/p8UOVkvp+g5k+nCtZTZ4QaP/C9XQydrDILxhPDYuF
        Fo4luiMXVhVMqtf7unAs6I5eImLeAHnZsT5sMpMwcA==
X-Google-Smtp-Source: ABdhPJy10QLHp8XAwsC1JSjlFB/F6T95lO8g/hV4Ivdd9Pv9ZaYWd09Cl51Z2IxNzujHhb4XvL/CfqkS7kIregCP4Ww=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr497258ios.42.1593424549735;
 Mon, 29 Jun 2020 02:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com>
 <87zh8uruou.fsf@toke.dk>
In-Reply-To: <87zh8uruou.fsf@toke.dk>
From:   Miguel Catalan Cid <miguel.catalan@i2cat.net>
Date:   Mon, 29 Jun 2020 11:55:38 +0200
Message-ID: <CAMHmoouFjdOSBAq00SMeauO2GvEnXMvJG+vEMwhYUD4rdW9rxg@mail.gmail.com>
Subject: Re: [Make-wifi-fast] Support for airtime scheduling using ath10k
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

El mar., 23 jun. 2020 a las 11:35, Toke H=C3=B8iland-J=C3=B8rgensen
(<toke@redhat.com>) escribi=C3=B3:
>
> Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:
>
> > Hi,
> >
> > we are trying to apply different airtime weights to different stations =
in
> > order to have some prioritization among connected stations. While this =
is
> > working pretty well with ath9k, with ath10k we always obtain a fair
> > distribution of the airtime (i.e. 50%-50% in the case of two stations),
> > regardless of the airtime weight specified.
> >
> > E.g. STA1:
> > RX: 0 us
> > TX: 2295610622 us
> >
> > *Weight: 200*Deficit: VO: 256 us VI: 256 us BE: 34 us BK: 256 us
> >
> > E.g. STA2:
> > RX: 0 us
> > TX: 162597077 us
>
> 2295610622/162597077 ~=3D 14
>
> which is not *too* far from the 20/1 ratio you've configured? Does the
> ratio change at all when you change the weights (i.e., if they are
> equal, do you get closer to a 50/50 split?).
>
> Do the two stations have roughly the same signal strength / rate?

In this case I started the STA1 a bit earlier, so it had a higher
airtime aggregate. Indeed, to compare the airtime share, I was
continuously monitoring the "airtime rate" (i.e. the difference
between Airtime(now) and Airtime (now-4s)) and the results of both
STAs were the same (i.e. 50/50 split) independently of the weight
being used. But when using ath9k the same test runs perfectly
according to the weights.

>
> > *Weight: 10*Deficit: VO: 256 us VI: 256 us BE: 9 us BK: 256 us
> >
> > We are using Compex WLE650V5-18A cards.
> >
> > So, does ath10k support airtime scheduling? In such a case, do we need
> > specific Wi-Fi cards?
>
> It should. My guess would be that maybe you're not getting enough
> backpressure for the scheduler to actually enforce things correctly. You
> could try to look at the TXQ output and see if you actually have any
> drops ('iw dev wlan0 station dump -v' and look at the drops/marks
> columns).

ok, i will check!

>
> What kernel version are you running? If it's not new enough to have AQL,
> that might help moving the backlog to where the scheduler can do more
> with it.

Kernel 5.5.5.

>
> -Toke
>

Thanks for your reply.
Miguel.
--
Miguel Catal=C3=A1n Cid, PhD

Mobile Wireless Internet Group (MWI)
i2CAT Foundation, Barcelona, Spain
http://www.i2cat.net/
