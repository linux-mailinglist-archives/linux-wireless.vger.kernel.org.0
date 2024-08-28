Return-Path: <linux-wireless+bounces-12169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5096294E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A06D1C21C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873018787C;
	Wed, 28 Aug 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkcmiH+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFB186E4C;
	Wed, 28 Aug 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853226; cv=none; b=CQcX+eP0xtqPbsiMldkaYTDwYzbDtRUqMLMFWgzP4GEbX2G7FJX0tt8LkZLXf0EuCHfvWK4dn422UshQj48koK6z6wFkWR3dtZ0iYxJ8LSLldDNaBNZbWtib8NrXN7hDwUDzvHdP8w+ci7x+gPXfh8gVUOuKUn/LK1N+J+1WHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853226; c=relaxed/simple;
	bh=uQhv+PNgrmTou4nKOaSWCbDq0tsirKSailGjmpqVubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lykRLRJX/lEpdk9lulaaZXNlsJ3OV5pK7Kj5Sh062RGeAYiup1x1og7Dhr4jjk0BlZ/2BzTjE9YLB5dB/Ny2A7uZwY6Dz54Y3uZvpJ3tJkPv0ZexcGGJDHMqZiWdbJpDZxIY1zJVg5Ff4rSunuliER38M4kgRzPcC3IYqqqwEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkcmiH+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB4AC98EC6;
	Wed, 28 Aug 2024 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724853226;
	bh=uQhv+PNgrmTou4nKOaSWCbDq0tsirKSailGjmpqVubs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkcmiH+s+5n6OLE88+mS/D8TkaO30rjgPh/nmp2a4eTWOuzJDU2fVQtVg3mqr1HLt
	 Nsf7VLke3eyLCBGwWx5aBBz/MBH0M9MTuWCdpgqNP1BeSPsTpfTmFj1YJ4NIOVWsBy
	 40+72UHjf8O6p7oNiWjYeeGMVQMJ/RzENhSWLZ1W9R8gA/tYnx+XhUFAc0nH8g1NgL
	 8WFpH1hAGfn0INm3IXclniCGAwYE5grdlS+uGsYRMwnTDOGwkSmfhWoXbn4piQDvId
	 HG1LOcNDxkv2g7tOc/SFpFxb9F0N7VruG9JSd7QPvkQ++JpohU5/toea4NEJQ/o7/U
	 3HjOiaf/Ndk5g==
Date: Wed, 28 Aug 2024 14:53:10 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
	dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 2/8] net/rds: Use max() to simplify the code
Message-ID: <20240828135310.GC1368797@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-3-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-3-lihongbo22@huawei.com>

On Sat, Aug 24, 2024 at 03:40:27PM +0800, Hongbo Li wrote:
> The target if-else can be replaced with max().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/rds/info.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/rds/info.c b/net/rds/info.c
> index b6b46a8214a0..8558b0a466b4 100644
> --- a/net/rds/info.c
> +++ b/net/rds/info.c
> @@ -194,10 +194,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
>  	}
>  	ret = pin_user_pages_fast(start, nr_pages, FOLL_WRITE, pages);
>  	if (ret != nr_pages) {
> -		if (ret > 0)
> -			nr_pages = ret;
> -		else
> -			nr_pages = 0;
> +		nr_pages = max(ret, 0);

Along the same lines as Johannes Berg's comment on a different patch [1]
I think that there is a subtle but important difference, semantically,
between max() and that the existing code does, for which the best
description I can think of is setting a floor on the value.

Other than Johannes's comment, and now mine here, I think you will find
that, if you search the netdev ML, you will find this point being made
consistently, at least over the past year.

And yes, we understand that mathematically max() is doing the right thing.
But that is not the point that is being made here.

I suggest dropping this patch.
And any others like it.

[1] https://lore.kernel.org/all/d5f495b67fe6bf128e7a51b9fcfe11f70c9b66ae.camel@sipsolutions.net/

>  		ret = -EAGAIN; /* XXX ? */
>  		goto out;
>  	}
> -- 
> 2.34.1
> 
> 

