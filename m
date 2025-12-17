Return-Path: <linux-wireless+bounces-29838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B335ACC7CAD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 14:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590C6308A950
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC0334F27B;
	Wed, 17 Dec 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3Z8mZkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EA34BA3B;
	Wed, 17 Dec 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976766; cv=none; b=nR8KjEicr84CLiS1u4UtylGqUkEnO3+R4rZaYjLyzZTqgQZwO7U/DvWazaB3R5WZC3gIlfDAfiNcv5frnMWss1PRTdfp4xqexx/XqH/8rr0nF0fWGU4AMnzCrHrTxxz6b8HUQZWeDwksJz6IqEPxy9yPgw6TR1JkrhfsS9Cgkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976766; c=relaxed/simple;
	bh=GycZoFSVTVbrHlD1wd/rzxe+nBR0S43CqCvhbhMByDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/AZ+6kmb5uOXxOqm8ifFh0wetkwbmPr5NWXGsprcnCauQ/WQQ6dSUMgmDbKPw36yk5sc5n82cUO1gAhuW5XaxZGxhqt0vyNW2+60CzBr6TTpSjdQ2KZbwzllJIpbyaQY94rEOne1yelQ48FPjU0MKxPRcpcBd3XGqzREmcEFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3Z8mZkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A9C113D0;
	Wed, 17 Dec 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765976765;
	bh=GycZoFSVTVbrHlD1wd/rzxe+nBR0S43CqCvhbhMByDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3Z8mZkcIHD1VrOtUfS2a0Dr+sfZwyGqLdir5ssoWH7+/V85r4v7Spk1PVhMgP4ya
	 jLJ8HnIhlHYiJKmN/BCzw47a6H0S/b+Qozkst832negKR4Bn2QwBxiOCMUW0gkrOrL
	 CgmI+PAzJXClEOTj1e0gLeqBGrqjmNjOjDtT2HUY=
Date: Wed, 17 Dec 2025 14:06:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cjz <guagua210311@qq.com>
Cc: linux-staging@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtl8723bs: Add kernel-doc comment for
 rtw_reset_continual_io_error in rtw_io.c
Message-ID: <2025121757-crowbar-junkman-a96a@gregkh>
References: <tencent_BAB546E9C29DF17A0E3BCE8EAE1428D88206@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BAB546E9C29DF17A0E3BCE8EAE1428D88206@qq.com>

On Sun, Dec 14, 2025 at 02:16:59PM +0800, cjz wrote:
> From: changjunzheng <guagua210311@qq.com>
> 
> rtw_reset_continual_io_error lacks a standard kernel-doc comment and has an incorrect
> parameter name (dvobjprive vs dvobj) in the existing comment, which causes gcc W=1
> warning and reduces code readability.
> 
> This change replaces the non-standard comment with a complete English kernel-doc comment,
> fixes the parameter name error, and keeps all functional logic unchanged.
> 
> Signed-off-by: changjunzheng <guagua210311@qq.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_io.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
> index fe9f94001eed..358a16b25a20 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_io.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_io.c
> @@ -147,7 +147,15 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
>  	return false;
>  }
>  
> -/* Set the continual_io_error of this @param dvobjprive to 0 */
> +/**
> + * rtw_reset_continual_io_error - Reset the continual IO error counter to zero
> + * @dvobj: Pointer to the device object private data structure
> + *
> + * Atomically set the 'continual_io_error' atomic counter in the dvobj private data
> + * structure to zero, resetting the state of consecutive IO error counting for the device.
> + *
> + * Return: None
> + */
>  void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
>  {
>  	atomic_set(&dvobj->continual_io_error, 0);
> -- 
> 2.43.0
> 

None of the functions in this file are in kernel doc format, so why do
it for just this one?  Does it get added to the kernel documentation
output when it is generated?  If not, I wouldn't worry about it at all.


Also, an atomic variable is a huge hint that maybe this function is
doing something wrong, why does this need to be an atomic at all?

thanks,

greg k-h

