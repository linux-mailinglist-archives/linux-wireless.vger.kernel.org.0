Return-Path: <linux-wireless+bounces-14306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECAD9A9EAF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D58D1C242AE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D815157487;
	Tue, 22 Oct 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqR+oJwa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932712D75C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589916; cv=none; b=ms+um+J5JGEgd9j4afFhA61u04/F9NO1OTG3viEfeSv36S2KNKyWAWV/PgmzWlK3v9f+Dnfsp2ebVHZ5yUenmJfU7D35yQX+jyL2ObN/QpepvMNYFIKuHpDXL5nR5Vzxi8kSEgS1+1YsSRlgtsQH85JHXx6k1bS+T4zlZpEFmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589916; c=relaxed/simple;
	bh=/l76xz0qrwEPoe1heDoMlxv6OPOjkqGenBxk8+yINqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qzta4XyiGe/ET2FBKXs2nqbI+5tE8VJiElvDBhYCsKm//Xh1GkRFRTvrA+ZntSnOtuJ8bIuzDIgN2Sb/GX9PJHNGZb/zisDi7t5L2mZ3JD42nvkJ5AIu7XSnYwWwlYZXkiaxmQM61h/7cLyX3yQ1CQvkh5fckSiqDmmtrOGABl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqR+oJwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B086C4CEE4;
	Tue, 22 Oct 2024 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729589916;
	bh=/l76xz0qrwEPoe1heDoMlxv6OPOjkqGenBxk8+yINqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqR+oJwa56D6irHN7m4NCyhE/zdKetiyVKXsx0gq3F2XziJr08MjnbX525MsvL9Ag
	 O0QOhMErKCviMuJUWAFsZmo4z9ZVoslPDKHoyCmx+KUnxAnPId9WN0FgJ91m3zSEbI
	 +3RkDv3uvG7QEXDAh0F3mt8tvEl22SHOqt1+FRXk=
Date: Tue, 22 Oct 2024 11:38:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuan Can <yuancan@huawei.com>
Cc: jerome.pouiller@silabs.com, kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wfx: Fix error handling in wfx_core_init()
Message-ID: <2024102219-manger-jimmy-ba98@gregkh>
References: <20241022090453.84679-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022090453.84679-1-yuancan@huawei.com>

On Tue, Oct 22, 2024 at 05:04:53PM +0800, Yuan Can wrote:
> The wfx_core_init() returns without checking the retval from
> sdio_register_driver().
> If the sdio_register_driver() failed, the module failed to install,
> leaving the wfx_spi_driver not unregistered.
> 
> Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

