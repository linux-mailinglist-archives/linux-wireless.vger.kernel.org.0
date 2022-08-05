Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8857458AE4A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiHEQkT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiHEQkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 12:40:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0494F239
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 09:40:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 123so4599300ybv.7
        for <linux-wireless@vger.kernel.org>; Fri, 05 Aug 2022 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PNW/TpoxQuWXjNWkrP4BcxmdkeQWeoX0b9xkjKXtzZ4=;
        b=OnBRKbnnva8/X50X2qk/Vum05KB6on1i/kz0DuEgzG42dEuPfn19TJ7NOEbJsrZuae
         8Fip0xDGOqJ6xtgpTQYQ/aZf2N9J8nec93d39XhXZf+ZkN+RXuo+cd8mUhsHkjOaZwDP
         ZdhAJAWZSqedcwN3uKKk9fvuCHI897ZzXelPUd1x+00XTedyKMfCK7EZjkJrs9lIRAb5
         GNbVJnZVbq53kM8KqlDHd1OUPEVyI+yxFOm08oRP84GV5nWW1q6IRxjC4zcSKnD0p0MU
         +E1+AQDWmHaGcLU9vcsm4DXcM4Ttihra0Fvq9bi60toQgwQsg/MzIafIbCuU8fZDo+2o
         anXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PNW/TpoxQuWXjNWkrP4BcxmdkeQWeoX0b9xkjKXtzZ4=;
        b=DQTeJsiOTJIYPgKIOYhQD7/wfZDyhBIKWBPKky7cAQKfHOKt3IkhuoIauJy8PfB69d
         z1qysX0XenbZA5UPFREWqlsvjt1IuZELd6EuJZjSmYt3zja0KKqF2kC/DWGyivgCk4o9
         WmROAVH3ERHX9HB7tq+Bbqz/8WgzDFn+iPFJsQBQs3SugBZkbLYacXeX+qulrNJ9ll3O
         07U25/hECJA5mPP8Xqyy8hKMPCmqjPLM0Z7jiYNOboT+7X1fayUHVCVYK5SR5e5jcHJC
         zgDEAYyRmOLbdaU28LB06uEQajXvopfjqUci8FJFIEbfFA/oRI92J6z6lEDJY7GDRy+v
         q01Q==
X-Gm-Message-State: ACgBeo1j8OzU9KjmlmSmJXmEEf2Ev6+Ou8US1U4evVTwaXQnDOjpcctv
        J/4z4D/ijtbvoTcEzOgyjKcTt9HdzNv0ZpxR81x+VG804IY=
X-Google-Smtp-Source: AA6agR4L6q9M0UL+mhIAgeftvK/OclZ1Mqh+BUNCuF1PCljdDELnh2lSd2QoJu8v03zUznC+vYdE7KMrkRaC/jYN0hI=
X-Received: by 2002:a25:25d8:0:b0:671:80a8:2d73 with SMTP id
 l207-20020a2525d8000000b0067180a82d73mr5855713ybl.125.1659717610144; Fri, 05
 Aug 2022 09:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAATNLbwMFDj0UrG1PBNh-dj7GT+GJ2Ud38TzHL=FmMG7wgNNbQ@mail.gmail.com>
 <Yu000DvbyViZPeC+@ubuntu-x1>
In-Reply-To: <Yu000DvbyViZPeC+@ubuntu-x1>
From:   Murtaza Saeed <mnk.saeed@gmail.com>
Date:   Fri, 5 Aug 2022 21:39:51 +0500
Message-ID: <CAATNLbxXAnFQKEE=7e3XLEBjKw_Rbsoy2waQ0m4wPoxv9iixvA@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Pakistan (PK) on 5GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
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

Hi Seth,

That looks good, thanks for correcting me.

Thanks for updating this, it will really make things much easier for
me and the small Linux community in Pakistan.

Please go ahead and send the patch, I'd really appreciate it.

Regards,
Murtaza Saeed


On Fri, 5 Aug 2022 at 20:18, Seth Forshee <sforshee@kernel.org> wrote:
>
> On Fri, Aug 05, 2022 at 06:01:43PM +0500, Murtaza Saeed wrote:
> > Hi,
> >
> > The current regulatory rules for Pakistan (PK) for 5 GHz channels in
> > wireless-regdb are out of date and have been recently updated by the
> > Pakistan Telecommunication Authority (PTA) in June 2022.
> >
> > PTA has allowed the use of additional 5 GHz channels which were
> > previously restricted for use in Pakistan.
> >
> > (5150 - 5350) at =E2=89=A4 200 mW EIRP (23 dBm)
> > (5470 - 5725) at =E2=89=A4 200 mW EIRP (23 dBm)
> >
> > The current channels (5725 - 5875) remain allowed at a higher power of =
1W.
> >
> > (5725 - 5875) at =E2=89=A4 1W EIRP (30 dBm)
> >
> > The updated regulatory framework from PTA can be found at the link
> > below and the relevant information is available on Page 10.
> >
> > https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-=
2022.pdf
> >
> > If I am correct, the listing for PK in the database should show as foll=
ows:
> >
> > country PK: DFS-JP
> > # https://fab.gov.pk/type-approval/
> > # https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
> > # https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-0=
6-2022.pdf
> > (2402 - 2482 @ 40), (20)
> > (5150 - 5350 @ 80), (23)
> > (5470 - 5725 @ 80), (23)
> > (5725 - 5875 @ 80), (30)
>
> Thanks for the information! This isn't quite right though. Annex A1
> includes additional restrictions which need to be accounted for in the
> rules:
>
>  - 5150-5610 GHz are restricted to indoor use.
>  - 5270-5610 GHz requires DFS.
>  - 5270-5610 GHz also requires TPC, but since Linux doesn't support TPC
>    we have to lower the max EIRP by half.
>
> It also looks like 60 GHz is allowed, so we can also add a rule for
> that. So I think this is what we end up with for the new rules:
>
> country PK: DFS-JP
>         # https://fab.gov.pk/type-approval/
>         # https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocation=
s.pdf
>         # https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framewor=
k_01-06-2022.pdf
>         (2402 - 2482 @ 40), (100 mW)
>         (5150 - 5270 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
>         (5270 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
>         (5470 - 5610 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
>         (5610 - 5725 @ 80), (200 mW), AUTO-BW
>         (5725 - 5875 @ 80), (1000 mW)
>         (57000 - 66000 @ 2160), (40)
>
> Note that I also changed the EIRP to mW to match what's in the document,
> except for 60 GHz where it gives the limit in dBm. We generally try to
> have the rules match the regulatory documents.
>
> If this looks good to you, I can send a patch.
>
> Thanks,
> Seth
