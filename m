Return-Path: <linux-wireless+bounces-29338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E32C8544B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA234F862
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF8247281;
	Tue, 25 Nov 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKyWNFCK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7572459EA;
	Tue, 25 Nov 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078873; cv=none; b=I6Cq7KbRGTHLEys1Ms+e9cAfTL+8R/iQWwGSdg5euhVu1Kb/TtZf5W+NdjLAEHK4UeL1YAkZQeHvtzSx9CKeevJqOuSMHvaZJ6n0/GjqHwVtQr9d8pvxCEJE4FEf24V/lPVkiUq1YdtJS4JhEEvl39PdL+b8SfNtYHad+vukFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078873; c=relaxed/simple;
	bh=po6o50AoLgke32JKu/zbHIhDBu2RjKjpprVpBMnKGWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/dbKMBj5F11Ppv8Z3HCGTVRlDJ2bMlskCDb7Cz+MwB+60nWdiijiFFEr22E7yoOFOK2TvGHz5zZBndEPkNBCkbQ6MjNG+zrOtu8wfW6drviBn2YELDAgkIiLJl1Pk9XUA2DRUCwAA1jHVKnp70YkfBn1Dv7iFTa+nmHvDqUpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKyWNFCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D26C4CEF1;
	Tue, 25 Nov 2025 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764078873;
	bh=po6o50AoLgke32JKu/zbHIhDBu2RjKjpprVpBMnKGWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKyWNFCKuc1r/nrF9+b82ff2UGmmIZcPfmOlh5IqtDZBLO3v9fAAwFrRHKJQNwvns
	 Kzicr8kNwCurq5NEcGYdF9yxRIwcK+tt5HVKcKNzNDSa+RysDByQcFej7fUNP1x5bi
	 BcCNR/G5VEeblQ7AWCoip5m4tPkBq6vzCzZzmR6M=
Date: Tue, 25 Nov 2025 08:54:32 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: ally heev <allyheev@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
Message-ID: <20251125-hot-seagull-of-trust-cc4bbe@lemur>
References: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
 <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
 <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>
 <20251124-encouraging-snobbish-nuthatch-230bcb@lemur>
 <89c6d616ed10eadcf41f085c2484560752db82be.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89c6d616ed10eadcf41f085c2484560752db82be.camel@gmail.com>

On Tue, Nov 25, 2025 at 12:50:44PM +0530, ally heev wrote:
> > > Yes, I use b4 for my patches. I work on other open source projects
> > > which use Github. So, my global git config commit autosign is set to
> 
> typo: `tag autosign`
> 
> > > `true`, hence you have seen PGP signatures. 
> > 
> > Interesting! I've not seen this cause PGP signatures to be added to "git show"
> > output before. I've tried to replicate it locally, but even if I have a signed
> > git commit, I can't make the "gpgsig" header to show up in the output of "git
> > show --format=email" (which is what b4 uses). Do you have some local git
> > configuration changes that make "gpgsig" fields show up in the output of "git
> > show"?
> > 
> > -K
> 
> I think b4 uses tags for patch series. I have checked old
> patches(before disabling autosign) and found that signature is only
> added on first(cover-letter) of the patch series

Oh! Interesting, so this happened on resend? I'll test it out, thanks!

-K

