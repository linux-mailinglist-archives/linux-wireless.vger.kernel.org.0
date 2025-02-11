Return-Path: <linux-wireless+bounces-18736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29DA3017D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 03:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083751885C08
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4C433C0;
	Tue, 11 Feb 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="PVTR7L8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D279C0;
	Tue, 11 Feb 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240951; cv=none; b=VItqy+VaBIzkCCUhDugUrkv7kTspTAaYCVSvDgygYVSJ+jDnBaFd9YZM8qv6crPSpunhLZBf7vDnFi9KICJ3FqmeQGxSJfpREu4iFfod8yvcfafexYZOenKHOQJya+T3OUgbgPl0tV1214sR3Rb+uDyz7WGnwp7islj3IsaO/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240951; c=relaxed/simple;
	bh=qVxsUnNwlPvuYlUn5MDBi2RStH03X19aLhveKSnIMNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJTvcTemNGuz6lOL6TdozSWH1vfDm4TDfHUh23L0vyxlvmcAQZNUwRFWx4zpTFdeEw9JKu1a2cfRCe/Izwyd+eXze5tqIx076BhMIvhq9SLMB1vqXqh7qdg43AWMuqr+XhDqkGicRJ092yAwNkSsyTc5OVlt2VvKcW4LFBtECT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=PVTR7L8B; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YsQP33ppkz9sW9;
	Tue, 11 Feb 2025 03:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739240935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IrwYLkPaZu6AzANx50orYDsvna7IavtON87rF1I0qck=;
	b=PVTR7L8BR9QA2ygX1CHN2RG1B/0/+Nqy3UPFqWI5gGK5VWlLYjwLaU9tHEF43F6Ep9u651
	w0dtL1MX8VZ6L8gt5aIZJKcgU9lTMaqVE3iIcj6CV2x471fFg6KIsT6YG3I0hSRFXVh7Ob
	yA+JoZMrXgLB2hyY0sYYzS3VQBBQ6J+yO2sHFueS8JKV0LKrkECBK2E0eWo3O03EVAxHs0
	Twn8pVZUlqv+yhsTnnj0LeZ5JaBgVWbMbILQyJANv0j41cIM44uMOZBKPTokacsWooZCPH
	J/DJcLb6KjQ5jJjlqYA6nV22j0AkvWAi/Msg6tVhPSwOyt8Jq0RoOgAPpHG2YA==
Date: Mon, 10 Feb 2025 21:28:52 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Kalle Valo <kvalo@kernel.org>, 
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Harshitha Prem <quic_hprem@quicinc.com>, Kalle Valo <quic_kvalo@quicinc.com>, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Message-ID: <mmutvwbsr3h33hxr364zr6f3whmyxp73od3fihsbynek2pkvjd@6bqaqfkwkf4m>
References: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
 <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
X-Rspamd-Queue-Id: 4YsQP33ppkz9sW9

On 25/02/10 05:08PM, Jeff Johnson wrote:
> On 2/9/2025 8:36 PM, Ethan Carter Edwards wrote:
> 
> commit subject should be as specific as possible.
> suggest you at least mention the function
Will change. Thanks!

> 
> > There is a possibility for an uninitialized *ret* variable to be
> > returned in some code paths.
> > 
> > This moves *ret* inside the conditional and explicitly returns 0 without
> > an error. Also removes goto that returned *ret*.
> 
> ath driver convention is to declare function variables at the beginning of the
> function -- please do not relocate the definition of 'ret'
Will fix.

> 
> > 
> > Addresses-Coverity-ID: 1642337 ("Uninitialized scalar variable")
> 
> Is that an official kernel tag? IMO the proper tag would be
So, it isn't "official" as far as I can tell, but it is widely used in
other commits, especially by Gustavo Silva. 

Also: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=778e2478d19574508861bcb1806d6e34d095587c

Coverity-IDs: is another option I have found. I have seen Closes: a few
times as well. I'm not really sure what the best option is, honestly.

I'll use Closes: in v2. LMK if you want me to use something else.

> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1642337
> 
> (is there a shorter URL?)
Not that I know of.

> 
> see https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> > Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")
> > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/core.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> > index 0606116d6b9c491b6ede401b2e1aedfb619339a8..ae75cdad3bd6b6eb80a35fee94c18d365d123cbd 100644
> > --- a/drivers/net/wireless/ath/ath12k/core.c
> > +++ b/drivers/net/wireless/ath/ath12k/core.c
> > @@ -908,7 +908,6 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
> >  {
> >  	struct ath12k_hw *ah;
> >  	struct ath12k *ar;
> > -	int ret;
> >  	int i, j;
> >  
> >  	for (i = 0; i < ag->num_hw; i++) {
> > @@ -918,14 +917,13 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
> >  
> >  		for_each_ar(ah, ar, j) {
> >  			ar = &ah->radio[j];
> > -			ret = __ath12k_mac_mlo_ready(ar);
> > +			int ret = __ath12k_mac_mlo_ready(ar);
> >  			if (ret)
> > -				goto out;
> > +				return ret;
> >  		}
> >  	}
> >  
> > -out:
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
> > 
> > ---
> > base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> > change-id: 20250209-ath12k-uninit-18560fd91c07
> > 
> > Best regards,
> 
> replacing goto out with return ret and unconditional return 0 LGTM.
> 
> can you respin a v2 with the other comments addressed?
Will do! Thank ya much.

> 
> /jeff

