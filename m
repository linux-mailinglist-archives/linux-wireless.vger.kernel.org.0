Return-Path: <linux-wireless+bounces-12171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7639629A8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80F61C23D07
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B34175D5D;
	Wed, 28 Aug 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYIXBPT/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FA16C859;
	Wed, 28 Aug 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853875; cv=none; b=mTJlwFHHv/gcpuP4SiRaDgR1ULAgXi0aw+gjmPX29YIJ1xnLePzSIYO7uiV+NRaqQQb1GvIJ6ONUZupkKRnegAsXItKWv9BXJQCRM09qFWuiX2G+Fxlq4r0OyyGu6oRqKay/+MpBHhhHif+/wYIBYQXZT8KLWjQzrCzA0tmCCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853875; c=relaxed/simple;
	bh=O02XWElbfvIPDImyfaPXGTwRAgzSgaCpeA6XeqSzALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOHeNGgmvZuU5V6xZjvngfrnL8esgUGnh/eRW/NyIazKVCoO4Clz/lpmW5E9Go9BKs6ho+BCUgTKNQ/ogf0MHugEuLb5nyMAo8nxTF6SAhcP2Wjxdf0BuOVulBs79fkFJIv4qr63Zfjt2+RjfgqqBVylbTVsf3s2jupksQ6zMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYIXBPT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755D2C4AF68;
	Wed, 28 Aug 2024 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724853875;
	bh=O02XWElbfvIPDImyfaPXGTwRAgzSgaCpeA6XeqSzALk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYIXBPT/ReIUAlFeixgiNGXsNyog7nC1PqUwFBus4KPU5NnmfOox0k+rPN5Ca+kq5
	 myLyj02fl/6bezWhRvymqr4HYZEmWWQvjnMaRKbh/M7BrezpxhkpWDYJE1fBOKznDr
	 KDrVea5Ye4vkjLL5BPS4KZLplr8IDZqboUP96MD95GCRnaTLpwWfef/bDe2VdjEXQf
	 rVt43HtbTiXdafuv1ouSUO/tmNzgHubPJz05PpmZuMkrrUtnlW1jF8raVOgTVvKo8n
	 76oBjNGqJ0/YSYBFMdcDWmulhooPlD0ZU1lWv1L0Z7DL+sodfx9A7jACKhaWHiyoZR
	 WCLic80yCHX1g==
Date: Wed, 28 Aug 2024 15:04:30 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, allison.henderson@oracle.com,
	dsahern@kernel.org, pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 5/8] net/dccp: Use min()/max() to simplify the
 code
Message-ID: <20240828140430.GE1368797@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240824074033.2134514-6-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-6-lihongbo22@huawei.com>

On Sat, Aug 24, 2024 at 03:40:30PM +0800, Hongbo Li wrote:
> Let's use min()/max() to simplify the code and fix the
> Coccinelle/coccicheck warning reported by minmax.cocci.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/dccp/ackvec.c | 2 +-
>  net/dccp/dccp.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/dccp/ackvec.c b/net/dccp/ackvec.c
> index 1cba001bb4c8..faadd0190107 100644
> --- a/net/dccp/ackvec.c
> +++ b/net/dccp/ackvec.c
> @@ -305,7 +305,7 @@ void dccp_ackvec_clear_state(struct dccp_ackvec *av, const u64 ackno)
>  	 * Deal with overlapping Ack Vectors: don't subtract more than the
>  	 * number of packets between tail_ackno and ack_ackno.
>  	 */
> -	eff_runlen = delta < avr->avr_ack_runlen ? delta : avr->avr_ack_runlen;
> +	eff_runlen = min(delta, avr->avr_ack_runlen);

delta is s64, but known to be non-negative
avr->avr_ack_runlen is u8

I _think_ this is a candidate for umin().

>  
>  	runlen_now = dccp_ackvec_runlen(av->av_buf + avr->avr_ack_ptr);
>  	/*
> diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
> index 1f748ed1279d..872d17fb85b5 100644
> --- a/net/dccp/dccp.h
> +++ b/net/dccp/dccp.h
> @@ -149,7 +149,7 @@ static inline u64 dccp_loss_count(const u64 s1, const u64 s2, const u64 ndp)
>  	WARN_ON(delta < 0);
>  	delta -= ndp + 1;
>  
> -	return delta > 0 ? delta : 0;
> +	return max(delta, 0);
>  }

As per my comment on 2/8 [*], I think you should drop this hunk.

[*] https://lore.kernel.org/all/20240828135310.GC1368797@kernel.org/

