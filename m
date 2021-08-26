Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62923F8C01
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhHZQXt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbhHZQXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 12:23:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FCC0613C1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 09:23:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w19so5305678oik.10
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yr1uAb5Ak5IBNGd+lP4ceoLekYOhJeheizNJ0VZLsgc=;
        b=jg1FpWnHh0qmTemU/B4hda3yo3fi+5IwG/mzxITLMl4ZVWYOB9UwlAsDUpp4GqqQMX
         MXZjWXlTMAo8xkk4rokK/TGscD/kc/mD3u/wYvovhzmL+3qR1PN0PLQH0HkkIyWVCZMH
         JdKf/3Bknpuj4+HqPfoYgBP5IVAYACTAedGhTM8c3+7GsjqDp8QN3T+DVNGx6DV1Utvy
         wc1DAAhkodRKpzZJgzu6c8sKa2tER3LM5WhXNa2IQtd/66JAHKaIySjAweflO+uvZ7xT
         BdahnDNZqeXPXY1bgDDH5vvx/5GUJqzM3fbiX+dibzaVL/VyzNlTbIywCn/W7mW5H6sD
         RNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yr1uAb5Ak5IBNGd+lP4ceoLekYOhJeheizNJ0VZLsgc=;
        b=gOrDu2EQU06lXFoHClmmedK2yYTEVAtNJGDCgjCTCq5I+9Pa4pQeMmMfkBdOUFVWw0
         HlU3fHyLMBbAOT8X1WgWUiCNQTrOx4iVvucwPWVeBt17700Qr2FXku26AIP9F1BcJzed
         HrHM8bCDlJECvEciogvMLIbtAIT//krwXRVEmJAjUHqopH5olPazsJQm3LRFmuNkt9se
         DvPICNi1nKm7fFPZNsEy62A+JoaER5BJIOO68V8gn6RevWDmefM+4XTpMNXo4KADmYsX
         hfKDGlHq9OxwZuVKeiQMI5mG7mTbSqE0X1mjbgeN5cPA3KqpCQHqolSrT2BzkK585HaJ
         JfrA==
X-Gm-Message-State: AOAM5305TN9f0UIxFvvJMCw0VfuaFKSUUKlNLs0Fs/c6z28+5Z1bhbwe
        f0sNKmLe6vyG6T7bFM74Z6NoovyOwyD6xyXCiSw=
X-Google-Smtp-Source: ABdhPJyFlXDH+U3YZzWCMj+b1k9fU0ViVQ8R82nUiK7gr7VVaz7cb8wRNwoXEcsHFGy44btH5iMq1g35t0hEDBR0OT0=
X-Received: by 2002:a54:4093:: with SMTP id i19mr11610126oii.156.1629994980330;
 Thu, 26 Aug 2021 09:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210825031409.10552-1-victorsbayas@gmail.com> <YSemAGfADr2WTey8@ubuntu-x1>
In-Reply-To: <YSemAGfADr2WTey8@ubuntu-x1>
From:   Victor Bayas <victorsbayas@gmail.com>
Date:   Thu, 26 Aug 2021 11:22:49 -0500
Message-ID: <CAD+f07-egB+kgjbbY2mN=0KaV+HddQfxRB019o65um3QR4ceaw@mail.gmail.com>
Subject: Re: [PATCH] Update regulatory rules for Ecuador (EC)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My apologies, I forgot to CC the mailing list in my previous reply.

El jue, 26 de ago. de 2021 a la(s) 09:32, Seth Forshee
(sforshee@kernel.org) escribi=C3=B3:
>
> On Tue, Aug 24, 2021 at 10:14:09PM -0500, Victor Bayas wrote:
> > Update the frequency ranges and power limits according to the current E=
cuadorian norm [1],
> > corrected 5GHz maximum bandwidth since there are no legal restrictions =
in this subject.
> >
> > Note: 60GHz channels 1 to 3 are allowed without license for Point-to-Po=
int links but
> > they aren't for Point-to-Multipoint links so they were omitted in this =
patch.
> >
> > [1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTR=
O-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> >
> > Signed-off-by: Victor Bayas <victorsbayas@gmail.com>
>
> Thanks for the patch! A few comments below.
>

Thank you for your feedback.

> > ---
> >  db.txt | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index e7b11cf..4630854 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -504,12 +504,14 @@ country DZ: DFS-JP
> >       (5250.000 - 5330.000 @ 80.000), (23.00), DFS, AUTO-BW
> >       (5490.000 - 5670.000 @ 160.000), (23.00), DFS
> >
> > +# Source:
> > +# https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO=
-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> >  country EC: DFS-FCC
> > -     (2402 - 2482 @ 40), (20)
> > -     (5170 - 5250 @ 20), (17)
> > -     (5250 - 5330 @ 20), (24), DFS
> > -     (5490 - 5730 @ 20), (24), DFS
> > -     (5735 - 5835 @ 20), (30)
> > +     (2400 - 2483.5 @ 40), (1000 mW)
> > +     (5150 - 5250 @ 80), (50 mW), AUTO-BW
>
> It looks like 5150-5250 MHz also requires DFS.

Yes, I tried contacting ARCOTEL without success to get a clarification
from them because other countries don't require DFS for 5150-5250 MHz.

>
> > +     (5250 - 5350 @ 80), (250 mW), AUTO-BW, DFS
> > +     (5470 - 5725 @ 160), (250 mW), DFS
>
> 5250-5350 and 5470-5725 MHz require TPC. Since Linux does not support
> TPC the power limits need to be reduced by 3 dBm, which puts them at 125
> mW.

Thanks for the heads up, I forgot there was a TPC requirement.

>
> I also don't see any DFS requirement for 5470-5725 MHz.

Section 2.1.6 says that users of 5250 - 5350 MHz and 5470 - 5725 MHz
should apply the interference mitigation measures mitigation measures in
Recommendation ITU-R M.1652 to ensure compatible behavior with
radiodetermination systems.

ITU-R M.1652 norm section 1.1 recommends the usage of DFS for
5250 - 5350 MHz and 5470 - 5725 MHz, so I inferred the DFS
requirement for 5470 - 5725 MHz as well.

https://www.itu.int/dms_pubrec/itu-r/rec/m/R-REC-M.1652-1-201105-I!!PDF-E.p=
df

Greetings,
Victor Bayas.
