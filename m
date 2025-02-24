Return-Path: <linux-wireless+bounces-19368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716EBA41FAE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA3F7A3021
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4B2571A1;
	Mon, 24 Feb 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0+td8w5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BD221F00;
	Mon, 24 Feb 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401654; cv=none; b=OGyMN3glK772HuZRuZl6GWaPMlAkRKkoKz/IE02XhOzwIqGneirAUnjKZ+w8IicCKAkQnWEX4OReTxSuzxzDcFQMeZwZq7b8Y3AR22E9J4rUrPSR1WSQQkdCNc18t4eVGxTklrw8p6HTftqU0bcs09ZpVpzt+lsrH3RxsgBIdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401654; c=relaxed/simple;
	bh=BVaV6E0vu9Z/0quDpf7tDL/iGAcbEvGWgsSeHYa0oQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhJqTixgJ0S+mrkl1Y+0lDUs+bHY+AqqXzinlA7cCmR/7tieGDoQdNaW+jjNBNvECeB3qBo19VQrve/hGQ87UPR/7WlmcNK6CMghC6R5JAwzI7aq9d+n+sS+gDPnAymtYKjDNQ8hF1qTpdJhfuV2kydMu2kcc6DCcBsTC8RyBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0+td8w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D775C4CED6;
	Mon, 24 Feb 2025 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740401654;
	bh=BVaV6E0vu9Z/0quDpf7tDL/iGAcbEvGWgsSeHYa0oQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0+td8w5VgxPU/n8Lm4t8xexsTS8JTKU13ZGdCDVpzlvuyRuOuGp9ZVrh/d6I38vs
	 BAAy4T0BFW37EZtL7nqumzaOFImaYLCeLIMsg2z+jWhsRb1jRPeHFR8FM4dVOz3tds
	 QJ16NtndhMyxPhgOKZsvskkoxVYlNWhi/kPYEvo0=
Date: Mon, 24 Feb 2025 13:54:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev, kvalo@kernel.org,
	rand.sec96@gmail.com, m@bues.ch, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent()
Message-ID: <2025022412-unlikable-aftermost-bc2a@gregkh>
References: <20250224083707.2532381-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083707.2532381-1-jianqi.ren.cn@windriver.com>

On Mon, Feb 24, 2025 at 04:37:07PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Rand Deeb <rand.sec96@gmail.com>
> 
> [ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]
> 
> The ssb_device_uevent() function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
> 
> To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
> ensuring that the pointer is valid before attempting to use it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
> Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Verified the build test.
> ---
>  drivers/ssb/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index d52e91258e98..aae50a5dfb57 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
>  
>  static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
> +	struct ssb_device *ssb_dev;
>  
>  	if (!dev)
>  		return -ENODEV;
>  
> +	ssb_dev = dev_to_ssb_dev(dev);

This patch does nothing, sorry.  It's impossible for dev to be null so
no need to verify this and I guess I'll go reject the cve that was
assigned to it as well as it's pointless.

thanks,

greg k-h

