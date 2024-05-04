Return-Path: <linux-wireless+bounces-7167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E88BBC84
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33858B217E2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2C3BBE9;
	Sat,  4 May 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTjuRlls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D057CAE;
	Sat,  4 May 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834091; cv=none; b=rvJM2eUuypDmtNCQXd29CPVk6YMlZ64eiIxBvD+kEbac9Bb6NwZAdVvHhzTEQMRaZ71eQeKNM1s6vGJLrs7ic0l8Zvm0UZ4AhdFwga+lqjnOBVzWZSrzg5BJ9wxsPStMZV4Roq0MLqXm+amFieNg6pMAsmFV6ZCaq7Se5vx6JqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834091; c=relaxed/simple;
	bh=mnWhwHwbu6vfOBX72yPCmIu8TRUsTLMhnSRh1zYW2oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du03qjVmNx+xgVTQAjNfvR+Y/k3or+GlgO25NG0imYXEYZvNXEh4IPVvo1KiB9BDFs/Xd0aM3/PS0GtvcwwAz1sMG9liGoaQQI151e9Lnh1p17+bKc7VKc4oGW3tDD+iSnPiMhQ9yDq8/X1iwea1RAg+94KZYRslEYOrjzXpXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTjuRlls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53C5C072AA;
	Sat,  4 May 2024 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834091;
	bh=mnWhwHwbu6vfOBX72yPCmIu8TRUsTLMhnSRh1zYW2oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTjuRlls7beT4C4+N9maJy/KhaTRAZ/gauIYHdhqD3NUKTnYtw3OajltEC0pIT9Q3
	 sl4023iOTIxTsQWPP1MfdWABYeqxAtKeMb8BmQ7GvvSCZfn4H1PHJbTtjmMk/B/U0Q
	 u5Swrw/b1EPQMksmhSk1Z1ySi5ejMCMWkYebAvIRFDFb+kmuf8N/nXBKcjAM47uTv6
	 g7U1Cd7URbGLeDlbjeTJCAey4964nkF5pi1KdumQDNlSOh3Xn4uDTasP9BJRBi8MHn
	 Aw7HBhRiaQ8lC/1MFx2VgJYH4jBbNRgmHBKm59bNqc0JQBzWOFygzTNnlEm8op7jV0
	 JaVqtxT17Rz0Q==
Date: Sat, 4 May 2024 15:48:07 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Kalle Valo <kvalo@kernel.org>, netdev@vger.kernel.org,
	merez@codeaurora.org, quic_ailizaro@quicinc.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wil6210: Do not use embedded netdev in
 wil6210_priv
Message-ID: <20240504144807.GB2279@kernel.org>
References: <20240503103304.339489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503103304.339489-1-leitao@debian.org>

On Fri, May 03, 2024 at 03:32:56AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct wil6210_priv by converting it
> into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> the net_device object at wil_if_add(). The free of the device
> occurs at wil_if_remove().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


