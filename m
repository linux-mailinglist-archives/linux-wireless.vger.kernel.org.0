Return-Path: <linux-wireless+bounces-11481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E102952C63
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6094F1C20442
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD401AD415;
	Thu, 15 Aug 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0pmBx7vZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28417C9BB;
	Thu, 15 Aug 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715912; cv=none; b=s0Bx4R21C3Jl0EG/KJznh4FL5EoAbiIC2/MAgfvcR0nBFRtDw44GP5sj5W2FOPgYRhsk3VJtwx+f0HpgXUicQl5F9ZiNVvzZATndoQwjs0gr9ERjCsHCNIFiEGll/K0jtU8WXRH4rzkKeLJwCQONacrfJJ/F3IlbzkKGWMlpEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715912; c=relaxed/simple;
	bh=L5KS2owqysFKEDXssXd16jQ8G+Y/Y0IWnxwXFq4mJQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSPP1feKMBAEp/jyPh2XYhE4kJbGA+k7B/B5iRfRM3W1eQ70alD/urbcYmCJ/Pf1E/xsEq0nL+wcD6sOjBpA/Mal3FrP/ClXaZ5Xs2bV72PaqFXYe/Oax1Xv0kF89epWwjsgbn3ASrVhvM+xe9udAyyVUsiIgGP7IzpfCvzNWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0pmBx7vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE23C32786;
	Thu, 15 Aug 2024 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723715911;
	bh=L5KS2owqysFKEDXssXd16jQ8G+Y/Y0IWnxwXFq4mJQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0pmBx7vZI1zbPElkFwNu3Fxwo4xNDdRSvv28rCrJQNpOIn7ACxC/ba7f418U6xdAg
	 cfPUpLBmb/2ole1QF6NbXy60B2E/nD8g6AGUursGJbuSG9JEf1V3x72AM2Dua23KjY
	 C3x3tW9CO6TZWDo69DXamobs5xvEWOrAb0nMIITI=
Date: Thu, 15 Aug 2024 11:58:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Message-ID: <2024081500-essential-recovery-374f@gregkh>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <2024081523-curator-pronounce-4619@gregkh>
 <877cciyvdg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cciyvdg.fsf@kernel.org>

On Thu, Aug 15, 2024 at 12:43:07PM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Aug 15, 2024 at 01:52:18AM +0000, David Lin wrote:
> >> Hi Greg,
> >> 
> >> 	Following the guideline for new driver, it should let every
> >> file as a single patch for review and generate a final
> >> 	single patch after reviewing. I think stuffs mentioned by you can be got from cover letter.
> >> 
> >> 	If I misunderstood anything, please let me know.
> >
> > Please read the kernel documentation for how to submit kernel changes in
> > a way that we can properly review, and accept them.  As-is, there is
> > nothing we can do with this series at all, sorry.
> 
> Greg, just a bit background for this:
> 
> Because wireless drivers can be huge in our documentation we have
> actually requested to split the driver one patch per file for easier
> review and avoid mailing list limits:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver
> 
> The final patch to be commited will be just one big patch with a proper
> commit message.

Ick, wow, good luck!

That being said, you still can't take patches without any changelog text
and most importantly, no signed-off-by lines, right?

thanks,

greg k-h

