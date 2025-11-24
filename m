Return-Path: <linux-wireless+bounces-29293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA3C818D3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 17:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55A58344847
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60C315776;
	Mon, 24 Nov 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xzj5bGZ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A6314B69;
	Mon, 24 Nov 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001710; cv=none; b=NjKBdVKbYA/qwva66WJ6ngU/TCK2DxqPQ8d2AvhJDzsLKbskvCfqoSaxwlggFQa4xgVM8/qBzER4SQqfAUzstNIgosrc+OvQ41BSNeLJ7UTTOdQI3L+w2dxISTNxkNT7Xl6Xvv1HHugw60X6f913RvC5HN3XsS0KJcTXLAxh99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001710; c=relaxed/simple;
	bh=2iELB5rwjL25jBVIUS4vLRAa0RDKGPiTUWfFO5PceUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw5VZDyz/PLYxPL/mdoAfw/8YNL0dAp3ZIRD6M0j5aAuvHfeAEou9a9J2xz0+5kUMFf2q5HEwknN2yX7TH18A2vF5QEpA/o+fzV8Ztv4Otx4d2W4LAb/FGZdGIt0PesoBW9LMwiFtAxK7fBqHM0zIwt4Hc7QUoeGaR1CazjdqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xzj5bGZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1512FC4CEF1;
	Mon, 24 Nov 2025 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764001710;
	bh=2iELB5rwjL25jBVIUS4vLRAa0RDKGPiTUWfFO5PceUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xzj5bGZ2NqSx6jVHvqVXTi/QhfCa1zNxR0W1Mm9AK760n2BeY9XK2NgdofLOYo0mr
	 O7QVNmtLP9v9yxgw+omsRViJrP44FZPqZ7N1/OkOqg3nDF40wk/zDBJU2Xcm9UPix+
	 gouLOjO0eQV5pPgW+P0u+6+6dvZRQcXpXgMc9WBM=
Date: Mon, 24 Nov 2025 11:28:28 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: ally heev <allyheev@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
Message-ID: <20251124-encouraging-snobbish-nuthatch-230bcb@lemur>
References: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
 <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
 <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>

On Mon, Nov 24, 2025 at 09:28:39PM +0530, ally heev wrote:
> > > > Best regards,
> > > > -----BEGIN PGP SIGNATURE-----
> > > > 
> > > > iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
> > > > HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
> > > > 20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=
> > > > =A6F+
> > > > -----END PGP SIGNATURE-----
> > > 
> > > You should switch to patatt instead, not signing emails. We don't use
> > > that, I think at all, unlike patatt which is being actively checked by
> > > toolkit (b4).
> > 
> > It's even more curious. The patch was sent with b4, but I'm pretty sure we
> > wouldn't have put the PGP signature in like that, so I'm curious how that even
> > happened.
> > 
> > Ally, can you shed some light on that?
> > 
> > -K
> 
> Yes, I use b4 for my patches. I work on other open source projects
> which use Github. So, my global git config commit autosign is set to
> `true`, hence you have seen PGP signatures. 

Interesting! I've not seen this cause PGP signatures to be added to "git show"
output before. I've tried to replicate it locally, but even if I have a signed
git commit, I can't make the "gpgsig" header to show up in the output of "git
show --format=email" (which is what b4 uses). Do you have some local git
configuration changes that make "gpgsig" fields show up in the output of "git
show"?

-K

