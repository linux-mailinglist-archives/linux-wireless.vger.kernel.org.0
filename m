Return-Path: <linux-wireless+bounces-4772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D887C3C3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899072822CC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9775807;
	Thu, 14 Mar 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be/06FhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA12BB13;
	Thu, 14 Mar 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445239; cv=none; b=IKgNshX0y1op76MmLl+cO1SQkZUL52VpSRwmdfdWCD0jtznaontPHw7h8O5ojST6A+vNdl7jb/37YlH5NlB/4bgn624LmcEPkVa3uDPY/y3eGoWX2yvLpv1BZJS5tzqF8EGQhun4mI2T0TQLW+fYo8Jsuby3BseD8Q02zpGEIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445239; c=relaxed/simple;
	bh=yqTlmnf69fHubQexPXqqONf3QGnNyWhVSFVyqG6LZvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMgFqNxI8s8yFzpVwRiSoE71LNGnEBoKm6nG1TIOEvFTAzTKhRZLE3pJQuq66WwZBwPQKb538ShsMeuiqGrpuAAB/omt9Of4wl1pvWB+wBOUgQ7YlIXnkAtFYEJNncknNhB1JukcAjCZ90CgfW5mJmzED4r0G0uZh0LvqXt1+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be/06FhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D208C433F1;
	Thu, 14 Mar 2024 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710445238;
	bh=yqTlmnf69fHubQexPXqqONf3QGnNyWhVSFVyqG6LZvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be/06FhS2UKbtX0uABfVqBHqnFX6+r7rWE5qLEQhao/dMX4kN9yTKhIRMCpmwc8WH
	 Fe+IVeoJ2MsRn2NdOu1upW2ZCGErZg8uInYgQUhYaxcK8jP33raF9YDs2qZsPM2Sgh
	 hfbT5JUx+H5467wDkkGSNsbRBDVuKx6TUY9X550rKws4tgVPAGQy37dGEQxb4W1E0m
	 Toi0+c2IZTwEcYcX/acDV3fym+ZXa6CP4U4q/ABQqUE6RZ1FO5U3Lv4tN5a01WnU6+
	 4XqRuCdqjBtL84s3dNO6uIPvnhLPQxmzW9jv8NW16Vm+8InjVmA2NDFkGQX+7v3FdY
	 TwBnHNnmsHN/w==
Date: Thu, 14 Mar 2024 12:40:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Karel Balej <balejk@matfyz.cz>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: keyrings@vger.kernel.org, linux-wireless@vger.kernel.org,
	iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
Message-ID: <20240314194037.GA1132@sol.localdomain>
References: <20240313233227.56391-1-ebiggers@kernel.org>
 <CZTBKHQZXJTR.3VMFEA8MZSP5W@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZTBKHQZXJTR.3VMFEA8MZSP5W@matfyz.cz>

On Thu, Mar 14, 2024 at 09:11:08AM +0100, Karel Balej wrote:
> Eric,
> 
> Eric Biggers, 2024-03-13T16:32:27-07:00:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > This reverts commit 16ab7cb5825fc3425c16ad2c6e53d827f382d7c6 because it
> > broke iwd.  iwd uses the KEYCTL_PKEY_* UAPIs via its dependency libell,
> > and apparently it is relying on SHA-1 signature support.  These UAPIs
> > are fairly obscure, and their documentation does not mention which
> > algorithms they support.  iwd really should be using a properly
> > supported userspace crypto library instead.  Regardless, since something
> > broke we have to revert the change.
> >
> > It may be possible that some parts of this commit can be reinstated
> > without breaking iwd (e.g. probably the removal of MODULE_SIG_SHA1), but
> > for now this just does a full revert to get things working again.
> >
> > Reported-by: Karel Balej <balejk@matfyz.cz>
> > Closes: https://lore.kernel.org/r/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz
> > Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> thank you very much for the revert. I have compiled 6.8 with this patch
> and attest that it solves my eduroam connection issue.
> 
> Tested-by: Karel Balej <balejk@matfyz.cz>
> 
> May I please ask, though, why you did not Cc stable (and add a Fixes
> trailer for that matter)? It seems like something that would be nice to
> see fixed in 6.7.y and 6.8.y too as soon as possible.

I just forgot.  Reverts usually get backported without asking anyway, but the
following should be added to make it explicit:

    Fixes: 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support")
    Cc: stable@vger.kernel.org

That should just be added when the patch is applied, unless I happen to need to
send out a new version anyway.

We need to decide who is actually going to apply this revert.  Probably Herbert,
since he took the commit that's being reverted?

- Eric

