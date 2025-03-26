Return-Path: <linux-wireless+bounces-20849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFADA71695
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301243AC628
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0E1A238D;
	Wed, 26 Mar 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fPFwn1F6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2818E377;
	Wed, 26 Mar 2025 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991820; cv=none; b=IJ7LDloV0b+Yx+vN58H233pipvT7Mlz7n6qgE8iByeAdIXyXI02TVZRHGYQxoTyk5ov8mqvq77uBSPnRuxR5j1BHBWinyCHqgYL5Kz7X54C3R6XegjYcwlZTB//8F/wSZncX4RNI8ITkwinwz59y8n5bp2T+ABe85L8XFt5y4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991820; c=relaxed/simple;
	bh=l4DPTgSq9Qzf70/+49XtOguTxqYT/uus5HYDDmojE+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN6Bv0eK4yFWP1VIxP6ZJgtT/vxb78tH6JKvdGVsLTEqPimut7lbhVIU5aXC2D10IspjM7ozPRXsEuESDNIMXNRJlf2wtsQPSXKpY/7mvnhv1VMS4rXbIAX0uJmQUlbEnyIIERmwTXuz+yN4PuWxITjlwnG8tjI63x0KW2R7mQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fPFwn1F6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 776A91F8F8;
	Wed, 26 Mar 2025 13:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742991815;
	bh=jmjWxAwt1ix06buQE2VhYcX3H7jCewmrB/2COmu0Oro=;
	h=Received:From:To:Subject;
	b=fPFwn1F6z2MByK4qi0U2Nz3z8a9eghMZ5HudoH128mYwzkUguQJ8zwWVwIifusMRw
	 T1XBCQE1r7VJkj9NIw+dI0tKpgeT9cPj+NaKpS96GGQxlAYgKmlk4o847t6Irevf9p
	 1nFnCXNcmTQyR26XARQ3CSTDkFC+8M/bgBxuFQBiikDN90hDWKKTX9HC2gztN8SqTq
	 SHWCUgbUJ1fFFr6beyUj4mSSrjvpaDwPYAwvkQ5mIzKOppBI+8hYTmp2FrSP8TA+Jb
	 pypTG76FGE/ZaaPpBX4nsrBB+PM4GFvhKnZZItYDIBk5+K6D5JcVVCufaR5Q1QQmcx
	 +bfqLKj7d3ARQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 337167F95B; Wed, 26 Mar 2025 13:23:35 +0100 (CET)
Date: Wed, 26 Mar 2025 13:23:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 4/4] wifi: mwifiex: add iw61x support
Message-ID: <Z-Pxx983jcb0GTtg@gaggiata.pivistrello.it>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>

On Wed, Mar 26, 2025 at 01:18:34PM +0100, Sascha Hauer wrote:
> This adds iw61x aka SD9177 support to the mwifiex driver. It is named
> SD9177 in the downstream driver, I deliberately chose the NXP name in
> the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 79 +++++++++++++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sdio.h |  3 ++
>  include/linux/mmc/sdio_ids.h                |  3 ++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index cbcb5674b8036..7b4045a40df57 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c

...

> @@ -3212,3 +3289,5 @@ MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
>  MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
>  MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
>  MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
> +MODULE_FIRMWARE(IW612_DEFAULT_FW_NAME);
> +MODULE_FIRMWARE(IW612_SDIOUART_FW_NAME);
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> index 65d142286c46e..97759456314b0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> @@ -29,6 +29,9 @@
>  #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
>  #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
>  #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
> +#define IW612_DEFAULT_FW_NAME "nxp/sdsd_nw61x.bin"
> +#define IW612_SDIOUART_FW_NAME "nxp/sd_w61x.bin"

Is there a way to have BT over SDIO with iw61x? I was sure only sd-uart was
possible.

Francesco


