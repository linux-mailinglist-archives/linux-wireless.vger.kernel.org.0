Return-Path: <linux-wireless+bounces-23317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6DAC120C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518244E49BF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80093193436;
	Thu, 22 May 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqw/jrLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CA17A2F3
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934660; cv=none; b=qGdVzCqgug6vqfHnnTrhm7eQNwzO/MpkA5uDtKxal1WG5QSry1p6TYrAEmXJKS8UKMEZIaBjGw+BgVzuzmIm7d8L7ggPeZD2dssreQlCVcxQE/BMLR82uyf3+k5lBkT+n3Jy1daR9GeTcIg88F+bcxJTOL3ph2udr7VTX9iHewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934660; c=relaxed/simple;
	bh=KvaN/yfKGtsdh01A/Vg2kwDIuhYHaquHlXyuOmWW2AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORLamnUmcKA3M1KDB6DbUL1DD2ZqZ57Go82C9lAvAOeT+sFiPU68ALAFmn9FLutMyIh256dpzBN4tz6XS952hRB8kQkQfN+VWL39UqtFsZwFS+u4QKUkP01dQrYCZ9dtCLDeYKs5XWJS8PZM3xyPHivwY7ItaURwqRYaT+SLNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kqw/jrLu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ae727e87c26so4976047a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747934657; x=1748539457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEF6GYIX6oyyajg52e52+WAYQucDYWoIxRKIMxJyhFk=;
        b=kqw/jrLub+zCKPoBet4PGFa78Su6c28iN9OUXjF5lmi1ETg4dBGQXs+SlrCto4/Fhn
         BxnmCVISVwgV7OI6Gq9kLLDi82bOYFNJj1YOeUU57fyIbccmaKHmnQdbc7XuCxVodBWy
         8hgfYZZZNwnXOvV5HoS2E60MgFegTogiujbDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934657; x=1748539457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEF6GYIX6oyyajg52e52+WAYQucDYWoIxRKIMxJyhFk=;
        b=Y9WjE1NNqJ0NWch2Rr92YVTffIYGo1JV08OTL3qzcv0kWLT94t3MSX3+p+LaPhhHiI
         dgf9EjPhR2x/JcjvgSvIUxXrtIshzEswISve2zCLc88mambXbs3+DVTnMp0CLZwBlu5x
         z5Scruc3/N+4EpuWsnRG4qKWtyeAYGL0p+j9GvrWsMP0lKW4WEWWbMvybGYqXvRBANOO
         jbEMuMVbrCGP8gQcetRu6BvAfeMfjmressyLDotrX2Qmz338Dr5blonADG19cZ+7ZeqL
         iDhGtHKktxyyBQ/Epi71oT4qN93LtxEj8kq8gZUtTocF8QwW4Qs24qA+WJYg/yYBC7pS
         8xeg==
X-Forwarded-Encrypted: i=1; AJvYcCVOyqCAwjAaQKDoo6eS/s/QC5NBfERwyPTo9C4XgCh2URoI+7/joZGIukZ55+/rDN/pk1V/mbIZi3hHDLt//Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3W0INqfVuZ7gOaYlumAoImhIOcdEJEveyqwagUcUDZMgOwD7
	6rC+ToDP251A7fhfigV3ftI9BhRdxl3BMSe2wVmjU3KvUm9kIeEFTIp2bU3iEbyRig==
X-Gm-Gg: ASbGncv5P7GA0ID6Uh6FpxwsHvThXYWH1yLiKrOEDh9agxrMDQemUYALDPI9QdgH0hR
	gxg1dWtBQGsFup6gswzTF8Jg61BoChNsoSsLJ9GpkFPe08CA6BX24POKFnPSQKWEx2nOhk9Qgim
	gIABqZ4vEamxfOcUDIsQec5aAmbvPyE0YncrmmJ9ZrKHvqtnGYHQpkqxv3HVOPWB3vD0/Ag2F9C
	KJ/qln3t+HLn254yR5uKwwMI/b1To4CYP2zpoDUEMhGYcgsFRYaRXy+cMzzNVH/o/002LJ3t0UF
	z54kPUaMAzbloUFN+wCbjJYo7mxW+Q1+Z/VWWO4cvolhqwR/4xGjEtsp4L4JYfTq5kBERFQXAxC
	9Rjh7s74IkmXZ2A==
X-Google-Smtp-Source: AGHT+IFRSz/tRaVeLZrqA1fX8rhsQ1UTYI64MklqaLYZeJlKbPrLh3UFKLqJnOjYtsSZL7+ciGxB4A==
X-Received: by 2002:a17:902:d4c8:b0:220:eade:d77e with SMTP id d9443c01a7336-231d452da59mr375514505ad.40.1747934657477;
        Thu, 22 May 2025 10:24:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:88a1:1660:1cc7:bb28])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ed239bsm111440565ad.219.2025.05.22.10.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:24:16 -0700 (PDT)
Date: Thu, 22 May 2025 10:24:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: rafael@beims.me
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Message-ID: <aC9dvv6Ki1T5RsHF@google.com>
References: <20250521101950.1220793-1-rafael@beims.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521101950.1220793-1-rafael@beims.me>

On Wed, May 21, 2025 at 07:19:34AM -0300, rafael@beims.me wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
> This feature depends on firmware support (V2 API key), which may not be
> available in all available firmwares.

Is it available in *any* W8997 firmware? Or particularly, is it
available in the firmware in linux-firmware.git? Judging by its git
history, the answer is "no", in which case this is definitely NAK'd.

At a minimum, can you post what FW version you're testing with? This is
the bare minimum required for this kind of patch on many other drivers,
although I'm not sure we've been so strict on mwifiex.

And even if it works for *some* firmware, I'd generally highly encourage
not making breaking changes like this, where there's a long history of
users on the old FW version. So, we'd need to teach the driver to know
the difference between v1 and v2 API here, and choose accordingly.

Brian

> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> ---
> Tested on a Verdin iMX8MP (SDIO-UART) and Verdin iMX8MM (SDIO-SDIO):
>     - created AP's requiring WPA2 and WPA3 authentication and successfully
>       connected clients to them.
>     - connected as a client to AP's requiring WPA2 and WPA3 authentication
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index c1fe48448839..f039d6f19183 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -438,7 +438,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
>  	.can_auto_tdls = false,
>  	.can_ext_scan = true,
>  	.fw_ready_extra_delay = false,
> -	.host_mlme = false,
> +	.host_mlme = true,
>  };
>  
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
> -- 
> 2.47.2
> 

