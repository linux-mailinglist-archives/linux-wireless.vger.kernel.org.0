Return-Path: <linux-wireless+bounces-17043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E0A008C9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007CB162E04
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6C1EE7CF;
	Fri,  3 Jan 2025 11:41:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC11BEF85;
	Fri,  3 Jan 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904470; cv=none; b=hQVVBEgaQaaH3aHcAhOIYL6rDaAPJda69ziUwKJTO+HPVD5q/BzhGIk53xMo9z9SUaV4Z3/zEmhw0Orc+uY4kWrrs6GPhX376Y/Xzv3lc16O3NhtgropVnSIA7+l/2Fcn+aBSghW9x6QAn/AB5xsA5N1cBMDkt38l0EzbgqyZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904470; c=relaxed/simple;
	bh=r0+bPk+18OLFPNZOyzIFvNO34XF2I50Yma4ohzN75aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ7b1eJK7bZQ9YSsxpQywN2RFgvxZqGwAKue68Zv98PR+/0YET7m3bQDgaeBKwuvGdQrJF9yE/jtxzkL4AW8SmdXh0r6vsixyTZi9hWrZoBdJB9mmyyBzWt84Yj0cqOU5xmGlPHqibiZApr2ghLcd0GbmVftHuXFGoI/3UVu08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tTg36-000000005et-3d5p;
	Fri, 03 Jan 2025 11:41:04 +0000
Date: Fri, 3 Jan 2025 11:40:52 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103085540.GA94204@wp.pl>

On Fri, Jan 03, 2025 at 09:55:40AM +0100, Stanislaw Gruszka wrote:
> On Sat, Dec 21, 2024 at 01:39:32PM +0100, Ariel Otilibili wrote:
> > Coverity-ID: 1525307
> > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > ---
> >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > index 60c2a12e9d5e..e5f553a1ea24 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > @@ -8882,13 +8882,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> >  
> >  	for (ch_idx = 0; ch_idx < 2; ch_idx = ch_idx + 1) {
> >  		if (ch_idx == 0) {
> > -			rfval = rfb0r1 & (~0x3);
> >  			rfval = rfb0r1 | 0x1;
> 
> I wonder if intention here was different, for example:
> 
>  			rfval = rfb0r1 & (~0x3);
>   			rfval = rfval | 0x1;
> 
> For me the patch looks ok - it does not change existing behaviour,
> since rfval is overwritten by second line anyway.

I agree with the likely intention here, however, the vendor driver
also comes with the dead code, see
https://github.com/lixuande/rt2860v2/blob/master/files/rt2860v2/common/cmm_rf_cal.c#L2690

So this is certainly a bug in the vendor driver as well which got ported
bug-by-bug to rt2x00... Not sure what is the best thing to do in this
case.

> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> But Tomislav and Daniel, please check if this code is correct.
> 
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> > -			rfval = rfb0r2 & (~0x33);
> >  			rfval = rfb0r2 | 0x11;
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> > -			rfval = rfb0r42 & (~0x50);
> >  			rfval = rfb0r42 | 0x10;
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
> >  
> > @@ -8901,13 +8898,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> >  
> >  			rt2800_bbp_dcoc_write(rt2x00dev, 1, 0x00);
> >  		} else {
> > -			rfval = rfb0r1 & (~0x3);
> >  			rfval = rfb0r1 | 0x2;
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
> > -			rfval = rfb0r2 & (~0x33);
> >  			rfval = rfb0r2 | 0x22;
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
> > -			rfval = rfb0r42 & (~0x50);
> >  			rfval = rfb0r42 | 0x40;
> >  			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
> >  
> > -- 
> > 2.47.1
> > 
> 

