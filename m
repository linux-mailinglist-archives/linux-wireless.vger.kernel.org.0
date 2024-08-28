Return-Path: <linux-wireless+bounces-12173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DA9629EB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F25B1C20C92
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0541898F6;
	Wed, 28 Aug 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqCUZIzO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2A168489;
	Wed, 28 Aug 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854309; cv=none; b=DauZpVdoY/nJdCvZFPLpVY5gMVikh2px7AQo7wzLceAB/qAhTzjgsh42t3w0LnWzQ03Cka0hxidQUOtEANfIeQWTRBOQF6Us6kloXr3Un8Aabzsp1UyMHyBAOdX73W1uJRr26ARL6qpNZ5Uez79gw5L/oGoF6pWaSB37QLyrcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854309; c=relaxed/simple;
	bh=/sGcY4F+aAJo3L951yH4iJQ++Orj4o/OLAtDeLIwZgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhPv5looch7VPd6LfPZJNeohB5ShwGG7s2jtcni5tP7WoCJb0a41vaDBh3sN066+rFsDHOo1Kg3/M6woba8WRpgTrI07vE4Y4rx+dfJhQzUTrsij6gUuB1zNyDpHQ8NFJCvwo9/+0acSw+R9dKZRUPfT1k2Z2vbgCqQbwV9D5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqCUZIzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A610C581B0;
	Wed, 28 Aug 2024 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854309;
	bh=/sGcY4F+aAJo3L951yH4iJQ++Orj4o/OLAtDeLIwZgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqCUZIzOCoL3SQcVu19GpLLId3HHsOoowhIBCWnG8h2D06eGnbb0zZ8dgs+bzfZZz
	 W30DNowL0l06EYFMPTO6e78G9469jVGi+zfnAynqQAiXKD87HYJz1KDF+JaAJChZLO
	 N4AOssCQT83JWgPde7nZVvVq5EssKWWmuvcnUyC4iKJb/rlDs3PbzLbLj95RGS1Ddw
	 XDguQOcDB1eeprOPpw7kj5zh5gOu35GpCPsPjP1bZm/7541BoQZQgirZscwPiPeHD8
	 QsOcOVLYaBvBODlT7BLxJAkpdszxkqOLCpACrPv7EUx3k3RnAoybMKV0nGzdQo3QNy
	 yo17f21Lwtc2w==
Date: Wed, 28 Aug 2024 15:11:44 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
	dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 8/8] net/ceph: Use min() to simplify the code
Message-ID: <20240828141144.GG1368797@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-9-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-9-lihongbo22@huawei.com>

On Sat, Aug 24, 2024 at 03:40:33PM +0800, Hongbo Li wrote:
> Let's use min() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/ceph/osd_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 9d078b37fe0b..450eb3be48b0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -3058,7 +3058,7 @@ static void linger_reg_commit_complete(struct ceph_osd_linger_request *lreq,
>  				       int result)
>  {
>  	if (!completion_done(&lreq->reg_commit_wait)) {
> -		lreq->reg_commit_error = (result <= 0 ? result : 0);
> +		lreq->reg_commit_error = min(result, 0);
>  		complete_all(&lreq->reg_commit_wait);
>  	}
>  }

As per my comment on 2/8 [*], I think it would be best to drop this patch.

[*] https://lore.kernel.org/all/20240828135310.GC1368797@kernel.org/

