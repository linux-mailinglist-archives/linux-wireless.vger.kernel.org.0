Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E051C6B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfFXUdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 16:33:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37206 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfFXUdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 16:33:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so6180478uaa.4
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU09tCSRmUULdd0C6u87fcmXQzQ5ozzb/dwDLZWm6Kk=;
        b=cS5s25U1Yl4Phf2cBvwfqTkvqBIKfvqvBBqyDuj7vomVCTPNPoMKwZ18OWJk8knlZU
         HU+XVsUVwB45F2sSrHdn4/u1dxhP7Zwf0LRjdRYZe4g45oNffCr1x1zv1m029nMdciVS
         zty+DRRLSIAiDgv08xX3Bx8zf/rkUcBHS4NE/YCcgID5+ipAQFXF/EVVDUhYXW1eAFzZ
         v4YQY4BXM0RTlzPBV7bZ26JeQTuAqHc/1eQwk7IPq3a1cII60pChvvyICPPRygsO4Dhj
         mjZQMz6Gwl4XznRzhfT6yKfgB7ht/Td2yuaXeRc9ef/lA8bH5MJn3IiWY0ay91wAnwPI
         ucMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU09tCSRmUULdd0C6u87fcmXQzQ5ozzb/dwDLZWm6Kk=;
        b=nxeHroMVlsQDV1B3mRldxGsw/4SwmWJFzvaCaFKnjQEjVs78R5FcHF9XIG/iq8WVpp
         K6jDowd3itutFXgNc2+r1C7hBrGGmP5q0gGvPc9+D8TuD3BR9r6LBOI/2CFY0C/dnZt3
         hC7/hHVLoTPSVrwLiOW3QTNK7uugmmh/mgGVCS2AU2+Jf0KGuVA5kKg0Ntbl2qwKWXbK
         W28y2IaiOpqODB+xZzdTywpeGHs8J6/gGKPNmMzcW2cESKaKp28ZE3KBg3ol9zK+qDAB
         nhvEufknRqYb/W968fDHgU2HydaDTsEAt8Cs8f7mV2EBf7XSOCi1PAQoxA56HZmiwhLz
         XAKw==
X-Gm-Message-State: APjAAAXH91U7/KmQCHiM5wsP6g/U5j6ThsfBGxe4igkmoMJJCJo4A3fi
        7EDrOpP2/MJc2eV1Nh7aeMEkWjNz9vXqD9sL1t0z89qvfQY=
X-Google-Smtp-Source: APXvYqwUu+EMrPQxJMau8qRhTCUyzSE7aR8VExZz42xGtDxYp8uZGK4jtkQusG8GDkQifByfkEGeSGFq7ccbg9iZReI=
X-Received: by 2002:ab0:7006:: with SMTP id k6mr61776365ual.42.1561408389983;
 Mon, 24 Jun 2019 13:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190620130148.1674-1-yegorslists@googlemail.com>
 <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
 <CAGm1_ksic4xcVdaPAObwwNdaQ19E3ZiK97SkmVmp8kz6H2KpOw@mail.gmail.com> <693753473768100f07de573dd74bf4033618aed8.camel@sipsolutions.net>
In-Reply-To: <693753473768100f07de573dd74bf4033618aed8.camel@sipsolutions.net>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 24 Jun 2019 22:32:57 +0200
Message-ID: <CAGm1_kvK3eWnZk7eDOoqoAiedReJLunKfb4tvhqXU-hriO3itg@mail.gmail.com>
Subject: Re: [PATCH] Add SPDX identifiers
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 24, 2019 at 12:36 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>
> > > You haven't included any documentation that says what the SPDX
> > > identifier, and specifically the "ISC" tag means in the context of the
> > > project, and it's not even the same license text as on spdx.org.
> >
> > What about such definition?
> >
> > SPDX short-form identifiers provide information about licenses that
> > apply to the source file.
>
> It just bothers me that this isn't self-contained - you always have to
> go to spdx.org to really figure out what it means.
>
> > As for the exact license I wasn't sure myself. Buildroot identifies it
> > as ISC [1]. How do you define its license in SPDX terms?
>
> Not sure. Maybe you cannot?
>
> spdx.org says "ISC" is the license that says:
>
> [...] THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS [...]
>
> while the license here says:
>
> [...] THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS [...]
>
> (and the same in one other place)
>
>
> This might just be an oversight on spdx.org, since the license with "THE
> AUTHOR" *is* typically referred to as "ISC" (e.g.
> https://opensource.org/licenses/ISC), but it still means it's not
> actually identical?
>
> Maybe spdx.org should switch, but then it changing the license text ...
> what if anyone refers to it already?
>
> It's all not very obvious to me.
>
> The kernel side-stepped it and said "let's make it all self-contained",
> which seems saner to me.

I have asked SPDX and this is their answer:
https://lists.spdx.org/g/Spdx-legal/message/2631
