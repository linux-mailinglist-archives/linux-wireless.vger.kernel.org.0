Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93043F8DD0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbhHZS1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 14:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235411AbhHZS1l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 14:27:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FE3160FD7;
        Thu, 26 Aug 2021 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630002414;
        bh=32hkB1Jyko2pe+hQm7VRhZiAhBPBd8eLpRR+hQOOdpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNoeq9Umus/dho31BYfRtfnkgcSTJIRGgQC7QtnjDs6dSzYni/zJv+vsROpb4v2yO
         DFkfikQZUsFsDGDr2whHBycPQt8pueGbZkHjgS6EYq98hPPWxO0RQxJD4ZGzUwnBv1
         /2FrtOXIWJSDkoPZj2FEgfSbucMyyX4rBP3VS/jSbW1kDEDMsgfT2fOZKV7WkyF6YA
         NJlVZwombBJ+23tQxfYkQgKAf14Hg3ElYV7KMX0PSLGMAh5fbgHUzRoQKnYwP4cHTI
         wBu9UTLDmoQ74tf9yHf/BWwyfM4c1+QukqIjqiNLg8dst/vx64k/dAhKIYH3gVll7Y
         Aj3ev/A+jU6uQ==
Date:   Thu, 26 Aug 2021 13:26:53 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Victor Bayas <victorsbayas@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Update regulatory rules for Ecuador (EC)
Message-ID: <YSfc7T61r/H9Tz7m@ubuntu-x1>
References: <20210825031409.10552-1-victorsbayas@gmail.com>
 <YSemAGfADr2WTey8@ubuntu-x1>
 <CAD+f07-egB+kgjbbY2mN=0KaV+HddQfxRB019o65um3QR4ceaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+f07-egB+kgjbbY2mN=0KaV+HddQfxRB019o65um3QR4ceaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 26, 2021 at 11:22:49AM -0500, Victor Bayas wrote:
> My apologies, I forgot to CC the mailing list in my previous reply.
> 
> El jue, 26 de ago. de 2021 a la(s) 09:32, Seth Forshee
> (sforshee@kernel.org) escribió:
> >
> > On Tue, Aug 24, 2021 at 10:14:09PM -0500, Victor Bayas wrote:
> > > Update the frequency ranges and power limits according to the current Ecuadorian norm [1],
> > > corrected 5GHz maximum bandwidth since there are no legal restrictions in this subject.
> > >
> > > Note: 60GHz channels 1 to 3 are allowed without license for Point-to-Point links but
> > > they aren't for Point-to-Multipoint links so they were omitted in this patch.
> > >
> > > [1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> > >
> > > Signed-off-by: Victor Bayas <victorsbayas@gmail.com>
> >
> > Thanks for the patch! A few comments below.
> >
> 
> Thank you for your feedback.
> 
> > > ---
> > >  db.txt | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index e7b11cf..4630854 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -504,12 +504,14 @@ country DZ: DFS-JP
> > >       (5250.000 - 5330.000 @ 80.000), (23.00), DFS, AUTO-BW
> > >       (5490.000 - 5670.000 @ 160.000), (23.00), DFS
> > >
> > > +# Source:
> > > +# https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> > >  country EC: DFS-FCC
> > > -     (2402 - 2482 @ 40), (20)
> > > -     (5170 - 5250 @ 20), (17)
> > > -     (5250 - 5330 @ 20), (24), DFS
> > > -     (5490 - 5730 @ 20), (24), DFS
> > > -     (5735 - 5835 @ 20), (30)
> > > +     (2400 - 2483.5 @ 40), (1000 mW)
> > > +     (5150 - 5250 @ 80), (50 mW), AUTO-BW
> >
> > It looks like 5150-5250 MHz also requires DFS.
> 
> Yes, I tried contacting ARCOTEL without success to get a clarification
> from them because other countries don't require DFS for 5150-5250 MHz.

In the absence of any clarification we should stick with the rules as
documented. The database can always be updated later if it turns out DFS
is not a requirement.

> 
> >
> > > +     (5250 - 5350 @ 80), (250 mW), AUTO-BW, DFS
> > > +     (5470 - 5725 @ 160), (250 mW), DFS
> >
> > 5250-5350 and 5470-5725 MHz require TPC. Since Linux does not support
> > TPC the power limits need to be reduced by 3 dBm, which puts them at 125
> > mW.
> 
> Thanks for the heads up, I forgot there was a TPC requirement.
> 
> >
> > I also don't see any DFS requirement for 5470-5725 MHz.
> 
> Section 2.1.6 says that users of 5250 - 5350 MHz and 5470 - 5725 MHz
> should apply the interference mitigation measures mitigation measures in
> Recommendation ITU-R M.1652 to ensure compatible behavior with
> radiodetermination systems.
> 
> ITU-R M.1652 norm section 1.1 recommends the usage of DFS for
> 5250 - 5350 MHz and 5470 - 5725 MHz, so I inferred the DFS
> requirement for 5470 - 5725 MHz as well.
> 
> https://www.itu.int/dms_pubrec/itu-r/rec/m/R-REC-M.1652-1-201105-I!!PDF-E.pdf

Ah, yes, I missed that.

Thanks,
Seth
