Return-Path: <linux-wireless+bounces-24727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59581AEF8CC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9217A8141
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8A2741AD;
	Tue,  1 Jul 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqABSae2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA72741A1;
	Tue,  1 Jul 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373510; cv=none; b=pxCGCQqpfU9yx711srfobBamWULBYOLCG4e4XG2VjBs69hsjQu9/AZG2x2+qB9vXoap3+UhjsflkYcxP35kaqi+m0aUBvBlc5l0wV/eRCqKAXhC23j66mTAa5u/vH9udaNr5HPXlPE6TirQcCA6SbbQCxg2rCDor/8qdCEpOxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373510; c=relaxed/simple;
	bh=/jvyLpcGhPB03tF3eqbvEXwDgmNMzvglQGW69LsdiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrwH296e149cuzHpDMHdanVT6YHo0Wy56pKn7mxwLvB3Q4V2HATa2lsAIeWVqpPtFtaZGMMgRdW7k1SyZuxvgmwaGMBcRdc1R5RFShFOPYe+cir0TJ7usALPZp69NkY+pIms6OPt3hUvXEPHXN8GtQYFlLT6k+muhpUxDDG8JJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AqABSae2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAEFC4CEEF;
	Tue,  1 Jul 2025 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751373509;
	bh=/jvyLpcGhPB03tF3eqbvEXwDgmNMzvglQGW69LsdiFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqABSae2j6kV3XBiOGE7BUFoXMiXHrzLB88Vfl72cP6n4eHS9TgfyNlcdl6U6iZj6
	 fFhi9DjUm/N8RuIMT/fNtETgCZ9w2aKzxryGTDbkM/cXciq8bwNmiFWYDuXUuRPojf
	 YjtR+4YQg/lXsjU/ymEwvRfNRMEu/a4Ai6BJnX5k=
Date: Tue, 1 Jul 2025 14:38:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5] wifi: cfg80211: move away from using a fake platform
 device
Message-ID: <2025070125-spent-glowworm-7405@gregkh>
References: <2025070116-growing-skeptic-494c@gregkh>
 <0004f9e5eb62f9ccad3dec52ebc935bfec42c949.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0004f9e5eb62f9ccad3dec52ebc935bfec42c949.camel@sipsolutions.net>

On Tue, Jul 01, 2025 at 01:06:46PM +0200, Johannes Berg wrote:
> On Tue, 2025-07-01 at 12:56 +0200, Greg Kroah-Hartman wrote:
> > Downloading regulatory "firmware" needs a device to hang off of, and so
> > a platform device seemed like the simplest way to do this.  Now that we
> > have a faux device interface, use that instead as this "regulatory
> > device" is not anything resembling a platform device at all.
> > 
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: <linux-wireless@vger.kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v5: - rebase against 6.16-rc4 and actually cc: the relevant maintainers
> >       and mailing lists this time, doh!
> 
> I did wonder for a second why it's v5 and I never saw it ;-)
> 
> >  int __init regulatory_init(void)
> >  {
> > -	reg_pdev = platform_device_register_simple("regulatory", 0, NULL, 0);
> > -	if (IS_ERR(reg_pdev))
> > -		return PTR_ERR(reg_pdev);
> > +	reg_fdev = faux_device_create("regulatory", NULL, NULL);
> > +	if (!reg_fdev)
> > +		return -ENODEV;
> 
> Is that really -ENODEV rather than say -ENOMEM? Having a hard time
> imagining how a faux device creation would end up failing in any other
> case, there's no underlying device to bind to, after all? :)

There are some low-level functions that could fail, but the error that
I thought should be told to init would be "no device" as the device was
not created which is what really matters :)

> Anyway, that's not really all that relevant. I assume you want me to
> merge it through wireless-next, since we have faux.h in the tree now?

Please do, thanks!

greg k-h

