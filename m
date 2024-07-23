Return-Path: <linux-wireless+bounces-10457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6244E93A4B6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 19:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CBF1C22DE1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672F14D431;
	Tue, 23 Jul 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwgSS0if"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4C156C74
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754629; cv=none; b=oN8vchuqhi5gDqtuKYx95ldqvCBzVFJr3+kk2N6TKiYAMoEG7Sj9BasbvZfWm7uy3x8fk5iurOQQoP4x3SZ1UGaB+cfw4RGq9M3ub3j5MPJpucT2Ax/9Udn3X/Q9CdRFmyargDphfzgbngGbW/sKf5KGURuUhyQeLIBGREFnTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754629; c=relaxed/simple;
	bh=24QFWeFJW9cNgD4vg0h/nZ0B3GiusnpIEgOINcnaDNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmjZmVM6+TldcmuspH9/BT0H5KpT0nUoiBEKiRoYYdQlp3RuzfZDZFQh6b9mrXT9WVasHyOdA5BPnShdsNIYDJbchCd/odtpVm69s0uZcMsPd2JZwB8D+xfBoI9LYdQ1rK7RUaYoMUEm5tXqyo+5YSnZWzeTtIAyTFz21taQQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EwgSS0if; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d569bee00aso1809176eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721754627; x=1722359427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8cpYfreI5j7rgcaJv6Mu2RIM9xL9FytkeVp1cbbhk=;
        b=EwgSS0ifk5TjFGBtLE2KTcR9gFr3QYs6nlrGvj1T+6/io8fX5JulMsHRnLiqYWigEb
         o2riHx8QoKORZuja31eMc9jyK0g3W0Y/0yqa/SoaJZ6vLqdZwjD3mwTSQ8t4GiYMdW5C
         oQSEAR6pnl9Lvr1pfx7Wy487nQNEEAUAd8TLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754627; x=1722359427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O8cpYfreI5j7rgcaJv6Mu2RIM9xL9FytkeVp1cbbhk=;
        b=qM9dY0fhpiPulzM5lm2hA33zHn7oycuWrplZH/lXW4RW5+DrexU8ge0IHxP4e2mU/w
         pMg90ZGw0tTdXE2bWdUV0z5/co+OHXOe9zXQXIQDjxo+sHgh4Y3CpgWug9wnMbX07paL
         riAQd2Ngf/p8/1xWGVRU1L67+yAkOfjTq/ZIiLXKvKnjtiIVl7fFcTRePYhuOqd8S62f
         YSm003unZ3edhG8JkVhLNETqJF3CXlsgk2PUTtC/fYV+yBbPoDJgiK0UItHZb4nqDDUa
         GrUbiWinD0i1wfGrLevduTVgnavmafHoQhCLPlJEvsTJhov9bpeh9UZqm6qidHmNE6vB
         7y2g==
X-Forwarded-Encrypted: i=1; AJvYcCUPPXTGnfZuGSdxlVXo82YfixLKFPvZdE2ftYVEf/fluktlBS4kAhzO0ygTjddqf4e3/8qs4R4kvK3zNXecGiI4qmCskaFqfC5kkfRbw/E=
X-Gm-Message-State: AOJu0Ywd9Y+0tmr5KcJn1PVF1Rod2skBg27LHY9DBwLPXKJ3nRAE7Jxp
	iLXl9cTw9dtuyZg52V6gjbugxVur7WRu6eYPvCZ4Q4mO/Lv8pqZVTXGfuobbDA==
X-Google-Smtp-Source: AGHT+IE8pxOJo0CXFT8R6oxSQXh2b6qZzDtVTVpt9uNQrpafHmixjvJjcL4DgSA1MhOA+rq0CDxfCw==
X-Received: by 2002:a05:6358:3404:b0:1aa:c71e:2b2b with SMTP id e5c5f4694b2df-1acc5aedf15mr1246068755d.12.1721754627240;
        Tue, 23 Jul 2024 10:10:27 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3be5:f451:a5db:11b4])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70cff59fcb3sm7432583b3a.176.2024.07.23.10.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:10:26 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:10:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 3/3] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zp_kAeKx_NRag2-m@google.com>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
 <20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de>

On Tue, Jul 23, 2024 at 09:09:59AM +0200, Sascha Hauer wrote:
> This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> using key_mgmt=WPA-PSK-SHA256.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Link: https://lore.kernel.org/r/20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
>  2 files changed, 4 insertions(+)

Acked-by: Brian Norris <briannorris@chromium.org>

