Return-Path: <linux-wireless+bounces-11445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26325952231
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C131C21A85
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447851BDAAA;
	Wed, 14 Aug 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEIBuYZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CC1BDAA8;
	Wed, 14 Aug 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661295; cv=none; b=p8W4AxW6zAMKqpCxFfoczsm7AO56N9y1pzfskeNQS2ucpUCOYXQM3ZOPvPcRI5TQkShdoqR2O9dvNudJ1gnhSRZDs9ZNqIdjJTiXfnEO3nbe1FbWH2ZwpLgzTfvPq8+FUbv7ZnoYhQblmB+j0P1Px4ZCIQ4/AFn4dEvJcXzgHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661295; c=relaxed/simple;
	bh=Sjar6FMhAOh7vXMFfUfQjuxYizxSii4Ilb7cO1wplmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGVBMYNdP+9Vy7QsZacTrspLW5IAhcrrXVJYa8FXC46+yhbrSEmznPuIj3gOr/AXUGH3e3PdBYzRDiHP6dn+wUdpTLR/mr+e3a1wI0OFGdy8WvrEupSyqI+DwWwLjBFrwbmTDJtggq+CKTPsJGL13BRMDjtRrlptzwHtWtN1n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEIBuYZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABA4C116B1;
	Wed, 14 Aug 2024 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723661294;
	bh=Sjar6FMhAOh7vXMFfUfQjuxYizxSii4Ilb7cO1wplmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEIBuYZdtl2T+6hFKC5xcfFJkhyOhtSUjrK2V4wKnTVf1NPo/Tx0K7L/mQjyJpuNh
	 aEzaG9+nCpIajsJez2CCYAvGmZ3yBvzf5IcXEpSse2xoolIaMtk/C774CUWs2KCcxL
	 WDCLTGm02EpdcfpGJDTGn/CIyQ8RHh9AgoVb1IZw=
Date: Wed, 14 Aug 2024 20:48:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, johannes@sipsolutions.net,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Message-ID: <2024081430-derail-diocese-78dc@gregkh>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809094533.1660-41-yu-hao.lin@nxp.com>

On Fri, Aug 09, 2024 at 05:45:30PM +0800, David Lin wrote:
> ---
>  drivers/net/wireless/nxp/nxpwifi/wmm.h | 78 ++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h


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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

