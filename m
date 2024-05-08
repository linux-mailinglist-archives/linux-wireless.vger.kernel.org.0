Return-Path: <linux-wireless+bounces-7343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFEE8C00B4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ACA1C240F5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87486126F1F;
	Wed,  8 May 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyK/6sxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DC126F07;
	Wed,  8 May 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181110; cv=none; b=KawXHMuz+VSDjzOaW1IXj5mZi6j2xDsYx+S7Jjjfq270lur4v2vUa4x+XMU4GMGF0E+QjYfLM90xHqEmBzCBuN9Xwi3R7tJM2Eu+B8bmZc4J8S7fEc9qGmPIw+yHm9629vinwrtk8HY3d617Ee1D1L1htiVwDMudxJqFduykfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181110; c=relaxed/simple;
	bh=vikwuTwMkABdES9wzg7+bp3LS1APlhsRz9rgvZ9XVt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5CBshEVq3CumAhlIf0uMstKNq21Rck2JeP241tQbfEm/M32AwG0lOD5UZrq1YI/Z/65bhtqu2IMMBH+6iu1dVMU3DDdOnoR3yuW9H1ihDF9ewwhQ4x2HMCv1vdQriEtEXUblr2wirEJmohsdmcA1QLL2j9xZgY15mG0PZPp80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyK/6sxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DA4C2BD10;
	Wed,  8 May 2024 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181109;
	bh=vikwuTwMkABdES9wzg7+bp3LS1APlhsRz9rgvZ9XVt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyK/6sxK5ZGUQqv0U91OuTojVQ4jqgAwXQLfi20bKBNBNBnsfqp7sU2GT1PTQFU0o
	 0OgCBSGbvRfZkT6KcIJdWyDdxWM9eJxmTuN6Tz9JeK4YHnc/e7Z6mQ9i5ll5uMxtCr
	 W1XM0f6tchzFPrnxAJQzx4qG5fovQD2PhGsqzKWB/c5ZnuMJ6MbordKrRQglmJSnAb
	 3VvqZ+Pq7fJ3uuVsY+mN+kdKyytNNtbZnpj/H/NI6Xji6mMaxdtUJb/Dl5bsLEUS0u
	 3j0kbZRrTUBpVIxhMzmyvS7hj5j1EnB11y8gJRjTKvyClwHr2xm9QkfcFd3DENaeWt
	 kuGHSQt6WLuWQ==
Date: Wed, 8 May 2024 16:11:45 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next v2] wifi: ath12k: allocate dummy net_device
 dynamically
Message-ID: <20240508151145.GG1736038@kernel.org>
References: <20240508095410.1923198-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508095410.1923198-1-leitao@debian.org>

On Wed, May 08, 2024 at 02:54:09AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> the net_device object at ath12k_pci_ext_irq_config().
> 
> The free of the device occurs at ath12k_pci_free_ext_irq().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>  v2:
> 	* Free all the allocated dummy devices if one of them fails to
> 	  be allocated (in ath12k_pci_ext_irq_config()), as
> 	  pointed by by Simon Horman.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


