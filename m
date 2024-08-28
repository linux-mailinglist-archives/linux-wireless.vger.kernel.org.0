Return-Path: <linux-wireless+bounces-12176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5B962C0A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00096286F54
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E91A257C;
	Wed, 28 Aug 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOAKgVcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB71A2556;
	Wed, 28 Aug 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858426; cv=none; b=VBPIkrK072x/Iime9diBdqbXWYmAlNDZabSVvZupE7jWiqD1dl0ZvfuaVSjDFAOrlqYqSJsw84wxSfxeHzXjJH2fkAcdXfrhqa0IIbNAHJgTjFPnWPZk+ysePFP9AZqsy3LHuVTELoPLL8BfgC/HPuHJx9qNOZ1R7h1ijY/XRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858426; c=relaxed/simple;
	bh=I3VT8DEW+KJDkGC5ecXmG1EoqgveTqR4k+rkP2CqGcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slt1+uodnt6cDh7Sztzi6jtfs/s/al3za2YJaXTBxOH+iN2Fv++M/4Iw2g8vHEvNOELwA6F4WxqnD/UhB95Semv/2uEqz7+A+A6Evo8fRITIY3p/0vp9PVQfdxxnN74TKZEmWtGeyJpxz9Y10Vcj5anX5PdxM7sUF9FzuxzEwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOAKgVcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D04AC4CEC2;
	Wed, 28 Aug 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724858425;
	bh=I3VT8DEW+KJDkGC5ecXmG1EoqgveTqR4k+rkP2CqGcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOAKgVcxNb+B4wgj2Iqdi0xCrLVUk5C9Aa92UCKr3/v4QeBmLNdbz8PqK308NovuJ
	 g+zm9ovfPI9/yR/d4UV447BKSrF1OhIm0qY/GodN4WNCCFpQ0j5fY79rbEQDGsyeno
	 1RUSbxju2le2V9SNGbUFxs0xxlyPap8N4Qf11kQOE5ag8nFuWTVDOS7quoFOwQCILt
	 4yeBQomdq7BEDNjzfxDTq1TGWtUrkELBKxOuOhEOdAsqWXTZn++0H8Mh253o7PKgY/
	 RHRUb+eY9hvrDk0FX8Y+jev/4gZ66XgSC3M9Nrzc6QxF4ZBXxli8k6QEMVORFo1Qji
	 RiK6+NtKFzdkA==
Date: Wed, 28 Aug 2024 16:20:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [PATCH v13 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Message-ID: <20240828152019.GQ1368797@kernel.org>
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
 <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>

On Wed, Aug 28, 2024 at 04:49:25PM +0800, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.
> 
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>

...

> @@ -4452,7 +4454,9 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
>  	/* Allocate private bus interface state */
>  	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
>  	if (!bus)
> +		ret = -ENOMEM;
>  		goto fail;
> +	}
>  

Perhaps a local change didn't make it into git, or something like that.
But this does not compile. As was also the case in v12.
Please take time to test your patches, not just the local tree.

>  	bus->sdiodev = sdiodev;
>  	sdiodev->bus = bus;

-- 
pw-bot: cr

