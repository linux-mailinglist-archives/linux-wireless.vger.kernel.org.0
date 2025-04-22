Return-Path: <linux-wireless+bounces-21801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E4A95A40
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 02:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D329188EA50
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE982125DF;
	Tue, 22 Apr 2025 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3BESd99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC0139D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745282810; cv=none; b=HZGZm7VGwi2Gx2G0UHYoGoPhFkQrT7ThOTphNvyo2JQ1PHHSCX9qxKlfhaMJ1mIulqYI43w06adRUocX6cwYvOaJwjVy4bYHb3LrqLmZ0y/Z0SoQUn+68CyQS3XZq8NMXGt6VIKf95COvtJykKAhShsxqcrsGqcqitI9YQDxhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745282810; c=relaxed/simple;
	bh=vTY6LT8I7a4anz4QeeLwR5HKGUj/trf02eQvmzZTnfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su8Ct+3Oe5tNF7Gy6qaVyu9aB0vTCembSbvKLu3nCoIT5ceyM8X1VRcj8ozsgzEgLx+a9UhpSvV/pN09TgevVUMeURbgC8P2TOUp6ditPduDop2SAtjAiHNEYzitH4adbJ2H7Q1cM4NyFhLzHtYwzp7KbZkhUmfovDEu9nsVeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m3BESd99; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b98acaadso4209202b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745282808; x=1745887608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DESd6kACTnQKmLSbi0O5NrgwAZmaHVMz5BjPH0vRm/Y=;
        b=m3BESd99riFlJB9sBQuB4GqQz2+zRTJs+7OF1t7Nj1lcAHVUcaEQIC6S+SFCmJW97O
         ptRcgRMKfuVJIlaa7n/AsULPpNo1GyUpCiNQ5fuJC6dRWSOfKElH+97Z7Zrxzevs/tN+
         cZC6/1LPYjrb2Rmnk2WROScW5We9huWAnqlP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745282808; x=1745887608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DESd6kACTnQKmLSbi0O5NrgwAZmaHVMz5BjPH0vRm/Y=;
        b=wWTtbdqDyV+D1+RdPBqDIJdvzZcX9C32rvAG39MhImC4KRFhmYeQ/ZAAaQHEEarLPr
         f0WkD4pc30B+dC/40N+JGmlT0g+ssEA3Nt71+FFRiKAz8NQqhNsgRFGXT0U5jJBqFiH0
         U48CTLuDCb0sdn4yQ69K4XsSGZ2/s82tU0WXH0Cw7qTjE72qD5wXRbAmAfMkf2oa6ls5
         QiDkh/Ho70ig+Q/dOuE1yrx9d+F1dUJHl0BtBTNKYBB9XSzJTUSNQ3GLq78vwoWgXYVn
         Nc6U0PP46tuykmnfecWphOvoLWJ/HPgrPucy5X1w7iZKt31rZEM02BZbPxSo1/PVrM9x
         RRqg==
X-Gm-Message-State: AOJu0YxaKJZdVuw36MaHlJBUH3hqWcdz1GmBvkmBZ3tJNL3qOWqPyYrz
	zYYJkDAqGALlpAXRPFbC2rZWUO1HIaAsMf8MCl3jJ0zwWHDjBwHH748hxfWNAA==
X-Gm-Gg: ASbGnctKCarpUYWGcYwpGEZ1tRQbm2SOXzDN8tH5yeZjRSkG6oauM6D2UUsfogXl3xx
	WD5KgDOR4/U2FMV1tSdy3XgWcuUbLC5hfagIEnSHcCqAKMA919rWEpAisMuDeCmCNi5JXMeGqM6
	AFjVYvriI6l1P3ubb5UPHyEGpyVcLwm2kTzGxE1w6kh3/el0w1i025HEIJ5TaBdopLwHbXXUEuM
	VdVFn2DuYWetgg7tqpR/LC+Kxf60Q7S/s52HyM7e2jhjpJ4q5782fNFOxUwMd0yNhqUrZehAhA6
	A6Ws/a82oMcUfL8cga1zS5vtBRVx6Fb5nOc9F82nF7O2E5q+HlVsA4JeF81RpzMTn4PJBDssfMG
	dsQM=
X-Google-Smtp-Source: AGHT+IHpmV5qAalHsZLfGW7snz5zVoC49bLUHJDnuf1xQk+zbKalF+g+4dAFedrgrA/YYjldiv8U2g==
X-Received: by 2002:a05:6a00:2443:b0:736:32d2:aa8e with SMTP id d2e1a72fcca58-73dc14ad1b3mr17055309b3a.6.1745282808205;
        Mon, 21 Apr 2025 17:46:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a29d:cdf7:a2a6:e200])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e4622sm7566279b3a.67.2025.04.21.17.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 17:46:47 -0700 (PDT)
Date: Mon, 21 Apr 2025 17:46:45 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: Use "scan_plans->iterations" for bgscan
 repeat count
Message-ID: <aAbm9W3yAxMc_C1l@google.com>
References: <20250416155425.4070888-1-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416155425.4070888-1-jeff.chen_1@nxp.com>

On Wed, Apr 16, 2025 at 11:54:25PM +0800, Jeff Chen wrote:
> Updated the "mwifiex_cfg80211_sched_scan_start" function to assign
> "bgscan_cfg->repeat_count" based on "scan_plans->iterations"
> provided in the sched_scan settings instead of the default
> "MWIFIEX_BGSCAN_REPEAT_COUNT". This change ensures that the repeat
> count aligns with the iterations specified in the schedule scan
> plans.
> 
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index a099fdaafa45..be28c841c299 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -2833,7 +2833,7 @@ mwifiex_cfg80211_sched_scan_start(struct wiphy *wiphy,
>  				request->scan_plans->interval :
>  				MWIFIEX_BGSCAN_INTERVAL;
>  
> -	bgscan_cfg->repeat_count = MWIFIEX_BGSCAN_REPEAT_COUNT;

Drop the MWIFIEX_BGSCAN_REPEAT_COUNT definition from main.h, now that
it's unused.

> +	bgscan_cfg->repeat_count = request->scan_plans->iterations;

Are you sure you want to take the provided value as-is? For one, the
request field is 32 bits wide, and your FW interface is 16 bits, so we
definitely to make some size checks at a minimum.

It seems like we should be setting wiphy->max_sched_scan_plan_iterations
somewhere...

Additionaly, what about the described behavior for 0 in cfg80211.h?

 * @iterations: number of scan iterations in this scan plan. Zero means
 *      infinite loop.
 *      The last scan plan will always have this parameter set to zero,
 *      all other scan plans will have a finite number of iterations.

Is that how FW treats a value of 0? Or is there some other sentinel
value?

And, why did we have "6" here previously? Is that an important default?
Or was it just a guess, and it's really OK to just have 0 (infinite)
default? This could be a user-noticeable change, but maybe that's OK.
You should at least acknowledge how and why this will change things in
real terms.

All in all, it feels like you haven't given me much reasoning to say,
"yes, this is correct and a good idea."

Brian

>  	bgscan_cfg->report_condition = MWIFIEX_BGSCAN_SSID_MATCH |
>  				MWIFIEX_BGSCAN_WAIT_ALL_CHAN_DONE;
>  	bgscan_cfg->bss_type = MWIFIEX_BSS_MODE_INFRA;
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.34.1
> 

