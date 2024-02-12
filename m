Return-Path: <linux-wireless+bounces-3459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7798517BB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01916B218B1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BFD3C6A6;
	Mon, 12 Feb 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcnhJPbY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE63C699
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750906; cv=none; b=NBlc9teBK0ADtemM4/NcVcM+1yKQgXLKyhA3BxNrWV3F4ZW5TETyxt4pvTziJwuBFrGwFwM93CvBNGj1fUlcUjrDIBc2tlLG1fY6bRUq0Z/X9y26CWSN1OgOZNQm+ydNtAmzaNYIQIfv0Zw9oTygypshiCMYVJimXYt9EFLm8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750906; c=relaxed/simple;
	bh=byVy2FspEX+pStbgIC9cPs/Ue/TGHtQ1dCEI1xdx/nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ioyK+XpmDWfu6vb2i4z8sKgDJfFO3OoMje7vb1UfwlCQ9G5GhYdeBkGR7LA6kScj6ryoY5bQhCH8RYSCB5bJdvkkLriq9YdlTpBCWSYccMYYeeXaZPDErAy1ggc5b9750citNEGW88FqK0h7VzJPrprdFurIyCRogvUw2t8tExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcnhJPbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26EBC433C7;
	Mon, 12 Feb 2024 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707750905;
	bh=byVy2FspEX+pStbgIC9cPs/Ue/TGHtQ1dCEI1xdx/nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IcnhJPbYPDJMG1kQHT8gnRo7nDVL+9F1wT3+aAQAUFKBUjekm9VKECBEYvR66Lydi
	 DRG2/2x3s4EHYHgsMtpwb+Us17at+m6MVX5wZEf5ROkJYsusCH/ZrcMKjI6kCj1ly4
	 U+tC0uBWvIT7SNfmpk4SUc5lUJT8bSaCbSBnSVjNZubU8dNsxCLFO+p1h0Qqq0kaaE
	 SDKHjH8dUYYQK26+YhA59VpRTvGzQ75rhkHS5Sgz3AS9OwNifzbp2C+S5X7DkAVpqq
	 k3AOqdX4XZmta7fEh9l2vjYyXcc7crBIwVqA8duDghptISHwIM2lOh9ek0GJQ7icM1
	 J88toh7a57XkQ==
From: Kalle Valo <kvalo@kernel.org>
To: David Mosberger-Tang <davidm@egauge.net>
Cc: linux-wireless@vger.kernel.org,  Ajay.Kathat@microchip.com,
  alexis.lothore@bootlin.com
Subject: Re: [PATCH v5] wifi: wilc1000: validate chip id during bus probe
References: <20240207044559.2717200-1-davidm@egauge.net>
Date: Mon, 12 Feb 2024 17:15:02 +0200
In-Reply-To: <20240207044559.2717200-1-davidm@egauge.net> (David
	Mosberger-Tang's message of "Wed, 07 Feb 2024 04:49:29 +0000 (UTC)")
Message-ID: <87h6idpvd5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mosberger-Tang <davidm@egauge.net> writes:

> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.
>
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>  drivers/net/wireless/microchip/wilc1000/spi.c | 69 +++++++++++++++----
>  .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
>  .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
>  3 files changed, 57 insertions(+), 16 deletions(-)

[...]

> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -12,10 +12,11 @@
>  
>  #define WAKE_UP_TRIAL_RETRY		10000
>  
> -static inline bool is_wilc1000(u32 id)
> +bool is_wilc1000(u32 id)
>  {
>  	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
>  }
> +EXPORT_SYMBOL_GPL(is_wilc1000);
>  
>  static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
>  {
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
> index f02775f7e41f..ebdfb0afaf71 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> @@ -409,6 +409,7 @@ struct wilc_cfg_rsp {
>  
>  struct wilc_vif;
>  
> +bool is_wilc1000(u32 id);

I was about to apply this but then noticed the new EXPORT_SYMBOL_GPL().
The overhead for such tiny function sounds too much, much better to move
the static inline function to wlan.h.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

