Return-Path: <linux-wireless+bounces-8719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9090109A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 10:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A28A283C8B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF9176FC0;
	Sat,  8 Jun 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCTXXt2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40D1804F;
	Sat,  8 Jun 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837162; cv=none; b=F3E4aOmcj5IbtcEaj8hlxWUi14n3jqrCyYYvLESipwO4LSyF3rEsJFh5hQvl+DYjnONl/iMBsZE9K0xFhWOl2w3xGEuBCs1LqFv8Amj4suNTw/mP0qJG29TQTh0dyjMl2s0fOB4bVIpFkU2ksI8qBO30Ozn5Xuw8poYDIaFHSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837162; c=relaxed/simple;
	bh=XELDdMB5Zhru8n4nNoUVmPQIMRF5TRiEouXpDdPtwlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8gJjezTEbGec4YTg6NQJ5X5tUYQC3Qg2JPwfBfO9OKE5KQlB6eMawvb9smdg9HcQUZYh1aWJ2W3ix7zwGriaGFXnQIXr1UzfDM0b2bvnlGgYUoCBz3WM/jrRPMA1IVuNPQv9t1QEYRfglwhzfUazVEu1/+80rVWnOmkwGXAJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCTXXt2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6183C2BD11;
	Sat,  8 Jun 2024 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837161;
	bh=XELDdMB5Zhru8n4nNoUVmPQIMRF5TRiEouXpDdPtwlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCTXXt2KJPWBhun2uazZj+/D2lsiwaV0LKLaEqC7NU65IGNvs/WhvT4XOD06S+83U
	 YXavM7wW21AD46Uvtg077djVTeT01yurx3YB17U734exDQwkPlVackqk2TJw/lL1Qc
	 remZP/lktzLc54Y6QMxXjziU+2fHJaGYIki53oUUeVMXijL/rR035suWkZfoQJp7wo
	 YD/DZRee1oYrohzVpmHOhqi2zgAZOAmqH8HShN5DX9kWfLTZFU7IsBDv+XXS7Bd/re
	 Uu/X8q4NMD57xT9gZUoD7bccb3mD0/d6qZ2ficeAmY3puCu9QK2jwgEVKyYwhMhfwM
	 XvMTs7HgvxfnA==
Date: Sat, 8 Jun 2024 09:59:17 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	sbhatta@marvell.com,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wifi-next 2/2] wifi: mac80211: Remove generic
 .ndo_get_stats64
Message-ID: <20240608085917.GL27689@kernel.org>
References: <20240607102045.235071-1-leitao@debian.org>
 <20240607102045.235071-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607102045.235071-2-leitao@debian.org>

On Fri, Jun 07, 2024 at 03:20:44AM -0700, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> In this driver specifically, .ndo_get_stats64 basically points to
> dev_fetch_sw_netstats(). Now it will point to dev_get_tstats64(), which
> calls netdev_stats_to_stats64() and dev_fetch_sw_netstats().
> netdev_stats_to_stats64() seems irrelevant for this driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


