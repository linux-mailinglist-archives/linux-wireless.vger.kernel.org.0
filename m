Return-Path: <linux-wireless+bounces-17046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC01A009C0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EF6188432F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEC1F8EFB;
	Fri,  3 Jan 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="yTkC66c6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5831494A7
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909812; cv=none; b=dlSQ0cBo/JH1NosdueJ7fMI1FkNpVawbtEYeD37wpHRyB+ItFOz5oc6jhzu3coUBJ8ghqG7mM1UmNv5xUAvZzrtOQ9TOVXgPuCyUvZJCxPB2J6wJXG87PrVidpz4xZ1MJIKLwNP3ufa9fyv8He087KnX8hvS6rA/9WbVKCaexvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909812; c=relaxed/simple;
	bh=JvVhyAdbUAhvkFQMi1kvS7IKbQpnKSQzJPls42mAAow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXeVSo/osnKkpcGocLaiAdi7Z1AYdJifavCg8pbxSwBxsKun2v11pJDz+WdmvYRl1pUYYLiAD65vU9FXkGkQ2Hm3HDA5eo+FI1mKNCFk6UVPGtn3huloh9XvMHT1j8dwfDhReqvU70IbEjJXmQM3JgP34Dbj4200OhgKiZVb5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=yTkC66c6; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 13103 invoked from network); 3 Jan 2025 14:10:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1735909803; bh=ybJQ7RREvOjFVGf7B2M/HrDARVZorTlm5j7ywVA7A34=;
          h=From:To:Cc:Subject;
          b=yTkC66c6hr16rdeaGhAzPZ3k80XsRlG3cNrB/KTZxmSwlRg9xJ4xn8O/Xq3wOMOVm
           X5QKeftyCEPDJpqnHnme5kyKluls7n48gcOk+5FiCkczQFeLU2U6DfSl4rsnvUhw4b
           R5tatEXGHNY9GdfUV8ZYmjal8L2aXf8TeAqbupfx5p4ZwAxeoX/FYqyL+gzZYECDza
           COcu9mC/OSm/z2DAZT8YxszPShEpV0FzduhTsTpgQWtt4TZ3lX0a7eRsJAUJrsRAyk
           XsUN7K0OnV7OkxbsbOS4HlwHAtcYLP2wezFAb5viAXIiVEIMstdW7bZD8zWG11i59D
           AiipQS4sWDhSQ==
Received: from 89-64-0-140.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.140])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 3 Jan 2025 14:10:02 +0100
Date: Fri, 3 Jan 2025 14:10:02 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <20250103131002.GA100011@wp.pl>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
X-WP-MailID: 26174e63bce7a1cf873a445020dca105
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [sTNE]                               

On Fri, Jan 03, 2025 at 11:40:52AM +0000, Daniel Golle wrote:
> On Fri, Jan 03, 2025 at 09:55:40AM +0100, Stanislaw Gruszka wrote:
> > On Sat, Dec 21, 2024 at 01:39:32PM +0100, Ariel Otilibili wrote:
> > > Coverity-ID: 1525307
> > > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > > ---
> > >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > index 60c2a12e9d5e..e5f553a1ea24 100644
> > > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > @@ -8882,13 +8882,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> > >  
> > >  	for (ch_idx = 0; ch_idx < 2; ch_idx = ch_idx + 1) {
> > >  		if (ch_idx == 0) {
> > > -			rfval = rfb0r1 & (~0x3);
> > >  			rfval = rfb0r1 | 0x1;
> > 
> > I wonder if intention here was different, for example:
> > 
> >  			rfval = rfb0r1 & (~0x3);
> >   			rfval = rfval | 0x1;
> > 
> > For me the patch looks ok - it does not change existing behaviour,
> > since rfval is overwritten by second line anyway.
> 
> I agree with the likely intention here, however, the vendor driver
> also comes with the dead code, see
> https://github.com/lixuande/rt2860v2/blob/master/files/rt2860v2/common/cmm_rf_cal.c#L2690
> 
> So this is certainly a bug in the vendor driver as well which got ported
> bug-by-bug to rt2x00... Not sure what is the best thing to do in this
> case.

As this was already tested and match vendor driver I would prefer
not to change behavior even if it looks suspicious.

Regards
Stanislaw

> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> > 
> > But Tomislav and Daniel, please check if this code is correct.
> > 
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> > > -			rfval = rfb0r2 & (~0x33);
> > >  			rfval = rfb0r2 | 0x11;
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> > > -			rfval = rfb0r42 & (~0x50);
> > >  			rfval = rfb0r42 | 0x10;
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
> > >  
> > > @@ -8901,13 +8898,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> > >  
> > >  			rt2800_bbp_dcoc_write(rt2x00dev, 1, 0x00);
> > >  		} else {
> > > -			rfval = rfb0r1 & (~0x3);
> > >  			rfval = rfb0r1 | 0x2;
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> > > -			rfval = rfb0r2 & (~0x33);
> > >  			rfval = rfb0r2 | 0x22;
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> > > -			rfval = rfb0r42 & (~0x50);
> > >  			rfval = rfb0r42 | 0x40;
> > >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
> > >  
> > > -- 
> > > 2.47.1
> > > 
> > 

