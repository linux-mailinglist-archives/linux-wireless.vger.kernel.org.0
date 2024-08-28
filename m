Return-Path: <linux-wireless+bounces-12174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694E962ADB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF86B2340F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9381A2557;
	Wed, 28 Aug 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVu5dJ8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA71A08CB;
	Wed, 28 Aug 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856836; cv=none; b=jdHIU1HLH7HEPCiPUA+1F6kfROekFqvQPVu5wGS2y+Mqqz1Wju2yFHA/5iZH+QLZw9RF0EZMIJ3xoRn9RS99RH1s5L/6KdM49UJZisRF5WubjagP8WkiNbdN0xRgQOzjQLh9K82nYxvcf3yRq5LPgGbDR5cr/tl5PxULGhcI/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856836; c=relaxed/simple;
	bh=PBEPGqLR8W67wqTgV4duHrB8dd1jHssYs3wnL6pRvuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufTLSSFx9HuXVS3VKlefjK+XwMId2Fui8TFSA85BQxiQHEkLCV1H1ylJdL5GxGfF7y1gO0SMB3iuWIyYpOgWoEu8s0+br6VyNHspoeM3zhuo1EI4aCVLrxOor5tcYQAqueGbeEv6lb6JKOUTrSpckTdFBGqBM0XSOPNI/ht+J3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVu5dJ8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41934C4CEC0;
	Wed, 28 Aug 2024 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856835;
	bh=PBEPGqLR8W67wqTgV4duHrB8dd1jHssYs3wnL6pRvuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVu5dJ8MsKoc6ut6ZXPE83dPH3NzU9mjG9y7WZSZWA+nx4LTYyHtioivJTa70tMcM
	 LpfNLviG3Lg2ViP81bmOKbkC88mVYlCTjRLq4u3pUac1xm6URdCRc/zydBx/6el5ER
	 Tahu/OtqjWRXnLXrt2VNKd8hAv+ER6AiaEXwCKiGH7m1fut7BUPF/XToeD7sZzRaM5
	 mzDQ+Q41gDfbDmqa+/WUzqCQso3z1WABESx8/Q9HkyAJiuYrSRon9l+onGa3iy4ech
	 mu+A4qBPPFVmU3eli/59X4GAytjOFc765utBVzZWFDTEoAopXCI61z03jqRZphrCQY
	 XZmvIR2MYYO6A==
Date: Wed, 28 Aug 2024 15:53:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, marcan@marcan.st,
	sven@svenpeter.dev, alyssa@rosenzweig.io, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	saikrishnag@marvell.com, megi@xff.cz, bhelgaas@google.com,
	duoming@zju.edu.cn, minipli@grsecurity.net, yajun.deng@linux.dev,
	stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com
Subject: Re: [PATCH v12 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Message-ID: <20240828145348.GO1368797@kernel.org>
References: <20240828034915.969383-1-jacobe.zang@wesion.com>
 <20240828034915.969383-5-jacobe.zang@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828034915.969383-5-jacobe.zang@wesion.com>

On Wed, Aug 28, 2024 at 11:49:14AM +0800, Jacobe Zang wrote:
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
But this does not compile.

>  	bus->sdiodev = sdiodev;
>  	sdiodev->bus = bus;

...

-- 
pw-bot: cr

