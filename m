Return-Path: <linux-wireless+bounces-12172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8A9629DF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C711F212D3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039D189B91;
	Wed, 28 Aug 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O87TjcAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197718952B;
	Wed, 28 Aug 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854241; cv=none; b=kWU4US/fmHqUyMcNA83XjwVedxt42Ns7xw3yvG5CrjsWGcb8O0rOZpK1ieeCCqfFozcwOKD5bKHH++MOHQ7rLJ/zVJ/g5tiWBHCYAf/GBDc5HEgRYeoIn4lBUnN5cE4ZGztsHvcatibUrdlzJmC/u6Cwk/jSZCLdWShPy51OhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854241; c=relaxed/simple;
	bh=9i0a2n459rkMzdokWabNjZl5cE4Y9VoUReTGNcDedVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7tYzCFP3fulAzbfq3BZg97GQmKxMnM56oG1QZzMeohHCfYegzHZVE58Wk1HPjohGZxazm8DLwLSioIMm+ZijQqx+rBwMu/p7QmzOVe1Cn28SaVhQN6u20HvORsEzOj0oHhx2/t7ufeUEAYi3rDCVIFGSpRHdi8GPIhcH5IsCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O87TjcAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CF5C58136;
	Wed, 28 Aug 2024 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854241;
	bh=9i0a2n459rkMzdokWabNjZl5cE4Y9VoUReTGNcDedVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O87TjcAE/orAhrFqRxcRmVI0z/0KbgRq0nSyDVy+ubzX+UnXEiVBVcvPPBQI2s2U8
	 H65qANSzt6kKfK8beoM80VOFgUtk/IbCfZonu5Te6aft+rMXEQZoImR4QyfT5qJMyi
	 9M5u4Da/tdwjTIZGjIfmDKUvQAo5T4FAhNOj2stXyoMTTOUEq6OY+THxHOWBh3tcxM
	 GH/vkXnVRhh06Z9Z0CWsbtre4vFEVMMpXMa7HSmRKC8vBi9I1PaXyhv12l49b+j4wx
	 S++NJr9qChAwuNcjtnYkQ9jg+whFHDSPbvV3iZABTbpzU66Kk4YXTC2g152TxwSt/J
	 /sVrBcvK/z5VQ==
Date: Wed, 28 Aug 2024 15:10:36 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
	dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net-next 6/8] net/openvswitch: Use max() to simplify the
 code
Message-ID: <20240828141036.GF1368797@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-7-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-7-lihongbo22@huawei.com>

+ Aaron, Eelco

On Sat, Aug 24, 2024 at 03:40:31PM +0800, Hongbo Li wrote:
> Let's use max() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/openvswitch/vport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 8732f6e51ae5..859208df65ea 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -534,7 +534,7 @@ static int packet_length(const struct sk_buff *skb,
>  	 * account for 802.1ad. e.g. is_skb_forwardable().
>  	 */
>  
> -	return length > 0 ? length : 0;
> +	return max(length, 0);

As per my comment on 2/8 [*], I think it would be best to drop this patch.

[*] https://lore.kernel.org/all/20240828135310.GC1368797@kernel.org/

