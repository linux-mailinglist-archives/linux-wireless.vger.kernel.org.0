Return-Path: <linux-wireless+bounces-8891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E7905AD7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3502836BF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310F40867;
	Wed, 12 Jun 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddpy3LFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCF3FE2A;
	Wed, 12 Jun 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216915; cv=none; b=ewaREUR7EFS7AaqVNAr+Dx3HJfMfcdoma53Rj479OlcocDfnWWpd0LzL1QfbRzC8U0qcconbuXA6HZMHW04cruOu9Zp9my7kUdR97Gn+XUIKLKjbm7Cw3jFyiKgXcgRJ64dwwy1Y1fK/l+o9TChxnVGyJ9/FdhrfShhxREWZiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216915; c=relaxed/simple;
	bh=NJeqqnsIfUMhlSi06vIIKPHNE2ykrkcvFQ48tdRGhsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq4iZ7hCt99U5OfAl4lLxoSCTS9LnIFIZItFEYCZ0Q5Ypv2Ae+JESr7AB34S7J0xof3bu/cBRRd2fcOl3P6ra0b7zfzcHF3iseReWINIt2hT9fPF1hUDhrs+hYTfFv7gWpm4sptyvKQJDkWEZ5QxpPWHEupr4GhEX1hyl+LjjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddpy3LFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE7CC116B1;
	Wed, 12 Jun 2024 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718216914;
	bh=NJeqqnsIfUMhlSi06vIIKPHNE2ykrkcvFQ48tdRGhsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddpy3LFXn9c98MKv3p1z9yzC/k7fp2NoQZCwQ1Bp3h+rc35Aj+5XYZpEUKKZ724ju
	 y9ZVcyK1HprCeVdIqNoKJZA4N3pV2QBPcSSYx5JVzTca/Va89RiIqfN0iHQoRB5v22
	 4P3VgoYjRQ0YRiOTFBQRUENT3jTcTYpRVcLHbZDkmjvl5fr0ovC4LYgtA8l9Bo4qNi
	 sj6e2NiHBaBOFoXtpyO9MS/O51xFBlLGWQtlXXkxqasrMderNVfzK0R8HW3Fi9nd5v
	 VqL2s2J+83NWAWDiaNO7RZLtHBTbLgANwd7LPwPmWBvnlcaNkfDGkoiSy+OXB4oGcu
	 z4C8Bg0Ko80zg==
Date: Wed, 12 Jun 2024 11:28:33 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kenton Groombridge <concord@gentoo.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <202406121127.FB2E58C2@keescook>
References: <20240605152218.236061-1-concord@gentoo.org>
 <fd1acc0f69ef9573ff0dced35863949c80c6d5e7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1acc0f69ef9573ff0dced35863949c80c6d5e7.camel@sipsolutions.net>

On Wed, Jun 12, 2024 at 10:20:41AM +0200, Johannes Berg wrote:
> On Wed, 2024-06-05 at 11:22 -0400, Kenton Groombridge wrote:
> 
> 
> > Co-authored-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Kenton Groombridge <concord@gentoo.org>
> > 
> 
> Wait ... I don't know what Kees did here, but seems then he should sign-
> off too.
> 
> Kees?

I had helped mainly in private emails with Kenton. I'm fine with
whatever tags people want. :)

Signed-off-by: Kees Cook <kees@kernel.org>

and/or

Reviewed-by: Kees Cook <kees@kernel.org>

(Though note the email address change just to keep checkpatch happy
about Co-authored-by vs S-o-b mismatches.)

Thanks!

-- 
Kees Cook

