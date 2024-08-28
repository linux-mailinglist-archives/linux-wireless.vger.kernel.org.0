Return-Path: <linux-wireless+bounces-12170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2411A962984
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5911285B0D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA23187FF6;
	Wed, 28 Aug 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtKEU8jw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40300187848;
	Wed, 28 Aug 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853549; cv=none; b=bRp5ZTdYBSLMoZzVemBmnDdZwtDrgJe+MjGwDo3xrhmenJGzcyg42LeWSjkZFUFLbraWxk5XiKLHA6pN1c51lBmDC63maQat7e73t14U8rIQtV0AqkjPv6BLtNfhkaTBnNAC/kLiYZ9fX3b5ARZ4uymLATzBEIhxCpadHSpD228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853549; c=relaxed/simple;
	bh=0Ih6JqhtfhWIczTuRqzqPA5LNSm0PTuhsCjp28AbAKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZC6w78G6aU08ZXdPBvu+LlsuXD+S/2c+JjaeAV6LccbIcZDdq0i+9qYPnbbli1N2ZiXFS3U05MHKChykliB/7dvocB8911IALABKPANlS35wWLjORybBvTrQPt/hQIVgf7tFbDuHsTf9yDgDHArOztuqUHERT7zoLlaDjfGzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtKEU8jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44BEC98ED2;
	Wed, 28 Aug 2024 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724853548;
	bh=0Ih6JqhtfhWIczTuRqzqPA5LNSm0PTuhsCjp28AbAKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtKEU8jwDHDYSEqcJKew0sb6EWebEoDflAuToyxP/rP1TSBF8alY4WEXPjoCGccJT
	 MdGUZqVc0zo7vnPugyefgeD/Am+OrT3cuEMqwiY29RLOWELW3l+emLpF+675sHP2ao
	 oHL9G12ZNdSOaGTBVWtQ2cA644FHOvXf8V+gtUnmvCGfHAvq8qggU6wNhzXJqXPfdN
	 DqxHGzN9w0Tdc5DgsxBUaEear/BLhQWJz5hTx7/TvKnaxE78Vv72w1G21Od3x1wwal
	 I6K9EAVskG/k+YvnzhBHVDFMSPNp5Os7lNInx8/vB0nmLJutiRcIIJJexmcnhnyj5W
	 wWq+KPaMiLLdQ==
Date: Wed, 28 Aug 2024 14:59:03 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
	dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the
 code
Message-ID: <20240828135903.GD1368797@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-5-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-5-lihongbo22@huawei.com>

On Sat, Aug 24, 2024 at 03:40:29PM +0800, Hongbo Li wrote:
> Let's use min()/max() to simplify the code and fix the
> Coccinelle/coccicheck warning.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

...

> diff --git a/net/core/sock.c b/net/core/sock.c
> index bbe4c58470c3..c9910f48903f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3800,7 +3800,7 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
>  	for_each_possible_cpu(cpu)
>  		res += per_cpu_ptr(net->core.prot_inuse, cpu)->val[idx];
>  
> -	return res >= 0 ? res : 0;
> +	return max(res, 0);
>  }
>  EXPORT_SYMBOL_GPL(sock_prot_inuse_get);

As per my comment on 2/8 [*], I think you should drop this hunk.

[*] https://lore.kernel.org/all/20240828135310.GC1368797@kernel.org/

