Return-Path: <linux-wireless+bounces-8344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A08D62E9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DEB284B2
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CF158D60;
	Fri, 31 May 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC20ebcs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796F158204;
	Fri, 31 May 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161875; cv=none; b=aWIuG6hhYgHWGM+hr4hl/n16Ts9uQZjEM7Fx/n3YNO2aqqAyiCQzU9TV9qAHYpkwb1sEtqm2eSkoLKC1q/GH5jdTbnBPnt1LkkV6/uAuUvXwPQhozB17sHUuUrDWR2EdLRBkyd3xLvQYfpg/qtqKmgnw7aK0Mw6sxyT9BfxBCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161875; c=relaxed/simple;
	bh=qC6oQjpZSfBA998RP9I1hRl7y4IrnDxjeMykj7MUTFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/hTNVA2JOITo+sg0Oiepi8UGbkgBkAdMI4j5WwugoG6zzNDHEle8XE/idFi69SHkTkY/gHV1uymxBfl+v1AuSAj3RmYxpU8ZJPtnFoTWkoDOtXAfvcGMHdKOZiKfYZnzm6t73k1uGlPQsfbRHsa1vuvn1Wwha5DaSqr+AybYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC20ebcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A8FC116B1;
	Fri, 31 May 2024 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161875;
	bh=qC6oQjpZSfBA998RP9I1hRl7y4IrnDxjeMykj7MUTFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC20ebcsFvKurvoX/FWth/aEYtFBnTLnMFW1FbIVl2GUL8Qkq3gaqnu+lMF9G/jyp
	 ZWRaGdR0+5ZJWdvGp9DP11ZiPdAkNBihvRk68H8XJtRosaPWA2KuaFh3V1iE267umX
	 U5DWkcItpa79VzUcndKXdBqVcwRjSo4tbLAvmIf+f/p37igTPHr0q/45yER2Gr561/
	 /f8DyZzJHIEZNIs6FdAz3f5dJk2RGbgnOaZ4ShPyD2GZfoGJWWsMkG6wgadKRpTcC2
	 22CRV7G+TsKkUTMtYSmHh2m21BnYgJCSSq9aYjebtp+1aHtsosGDi7+rQrEmPBYpGP
	 dXZqYDloSDWdg==
Date: Fri, 31 May 2024 14:24:31 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kenton Groombridge <concord@gentoo.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <20240531132431.GH123401@kernel.org>
References: <20240517145420.8891-1-concord@gentoo.org>
 <20240517204532.GC475595@kernel.org>
 <9fca4c0d496eb731f571cd8eacd409b9a9e61dae.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fca4c0d496eb731f571cd8eacd409b9a9e61dae.camel@sipsolutions.net>

On Thu, May 23, 2024 at 11:35:37AM +0200, Johannes Berg wrote:
> On Fri, 2024-05-17 at 21:45 +0100, Simon Horman wrote:
> > 
> > FWWIW, it seems unfortunate to me that the __counted_by field (n_channels)
> > is set some distance away from the allocation of the flex-array (channels)
> > whose bounds it checks. It seems it would be pretty easy for a bug in the
> > code being updated here to result in an overrun.
> > 
> 
> In a way, this is a more general problem, this allocates the max we know
> we might need, but then filter it down. It'd have to iterate twice to
> actually allocate the "correct" size, but then you could still have bugs
> by having different filter conditions in the two loops ...

Yes, I agree this problem is more general than this patch or the code it
updates.

> Don't see any good solutions to this kind of code?

I was hoping you might :)

