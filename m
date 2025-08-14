Return-Path: <linux-wireless+bounces-26383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C6B25BC0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 08:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1861C6224D5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF41242938;
	Thu, 14 Aug 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/M7YKy0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CD241679
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152685; cv=none; b=iEfA83fnCmpEAm8iafK6B0VPctz+8t02mJ+GIFzPGv+RrRLKFwkc6cYH43PUrclY35nbiqDyZK0XBHoYaC8K6SyZShWU7Hex0SkSTgy9BS3Bz1jkseEg/AkwOYXOMrljKOHw9MkKqKe9zDSaV7Vva1ogVOQ2HSEQdqdXfAjLOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152685; c=relaxed/simple;
	bh=qZNGyMPtpCLM6EfQifGMbXKiGpwjX+bjskdpMhwc3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2oZufJEzq3VYNNyA47fB9DGyIV7YrFL0GCOyTZvy6i3bupKhyKs3iZKM+BPsUo6FVN0m7u8HVoT2KDuct0h1pQzP4pQtu0F5B1Gfq0L9PCUDZu2kx45eJNXwEQy+s1ZlhmFitp0VtRDDKoElKXFg7zMKsv28bn5MGC4pX9TL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/M7YKy0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so2589235e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755152682; x=1755757482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2V662DeXltqYKqnizy5mT9VDX//IKEiaMN/OlCmjlaM=;
        b=U/M7YKy06GluTnYSmp4bQVBh9JZnoQZFwWjG5NmENbweDWRpBbFumTu7kNMJXELm2I
         iatZpZ1Nd5jNiWpt8WS2bOUHyk9WDNj6jlBexvPZnFITDGkZNpLOmsQmeblW46q2xPKl
         XlIUbnXry9D3VK5DFj985JxpXJqXlwP2aMsBoMr1ARRBtRrLTjwSkcoRYhdSnDzTLyMo
         yZd0OQ8lHrqaEc8hWBe/6qK3a2hT+WcpFGAJstENTzAnMexHYyi9JW1eRGW1PCPydA2U
         PL5Z8pGuj8amaJh86kADmh6crujyKAkc8psgl2ubm1uqHRGkfspLGcxXNSeRnMUMWQqN
         EqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152682; x=1755757482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V662DeXltqYKqnizy5mT9VDX//IKEiaMN/OlCmjlaM=;
        b=cRuURo/2lit0GcYKV1l5wCRK9zgZ7G6h64mPKt4XLHPu6Hf6RTNhGJnLhMvR1m1VvB
         qd8CldLjBJgGCxZ2o3ICeejV7vSYN0ZSkNtk5XU0qph7Tc/aw1N9Dfxk2UFt2IX4o4yG
         cMWtArwiLzXdLKI0BHTC7jXGkvqL+1Md/WsngIBvWox79ITNyLQyxirxqrGa+nOCsK+Y
         rYBptkGL3t2meGumkvm+qyf9k/Rl03NMXeIB8jrXOiXUtXe7mlM75yvVpJDeuzA+6L+Q
         wWMoTUTfLMmpoLiuh+4O31OKJKlo5mA477yX/g5hc6QLgIKoCPqK0cr8lCcxiD1ZR5Gi
         wbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlFdVfayjXP0qx/bhWfuO3UlHB+eAP29ME/BfTAXq446eOQtPMnce2bsIanWlZEKIrazqWRYRN71nUA3qzMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydZqMATrl0hzDQ38JT08o70loTkbDscsKJCUTFO3YyDqyvKAan
	IC13vPgLwv1ozwocaLpRmtuDFX801zRcd5CFR7PNyQl2opnp/fG3f5924s+7hjvPOO8=
X-Gm-Gg: ASbGncvq1aUSvwFvr7fgNAtngHXHd8xAR9xDMDMzWYQxFDeaL7bURUwJDQtgWHlnRNF
	8WfONk2klJLSkQPV79tfVq5H/sB4tbvlgJNCRvTmVE4lE+/zdZDnzJvGq78oybTU85JvNCWhPql
	cfYJfCDyKKb1oBR+BDj8IvV2iNshUIMt2TfHv4acf+HHtm0GV+VzeUt5ox7/Tp8+8kfkNf4YELe
	KDkEjQ+yAxFQibYZva46teaCSvQGP8WwxHfBivEzIj7vVZ/GmGOmUyU2w38cGfmGAA7aPkQ8fOG
	AY8ul0vcUlZk/Vb/lb6TJyKa8I6OflmmETl/SaMV7iVPQNifETImtHkGEe1LQXkFlHwJMGMFPFr
	HGJCaPni6WHpqfewZ20LeBfCAoXlKhUcFJOeKPGRBHkOcFoiO25HdxQ==
X-Google-Smtp-Source: AGHT+IEf+EdlTte75NZBvFy8FZziO62jRtYq3j83EMroZ09yzmhGTqWD2sPpyKuBoUMWeKXskigG5A==
X-Received: by 2002:a05:600c:46cb:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45a1b602f28mr12689675e9.4.1755152681744;
        Wed, 13 Aug 2025 23:24:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6fcd32sm8872795e9.22.2025.08.13.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:24:41 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:24:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJ2BJKAnFuJ-xIjs@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <272c9a0f-1e95-4c7c-9b84-a6b564d9e2bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272c9a0f-1e95-4c7c-9b84-a6b564d9e2bd@oss.qualcomm.com>

On Wed, Aug 13, 2025 at 11:35:45AM -0700, Jeff Johnson wrote:
> On 8/12/2025 6:48 AM, Dan Carpenter wrote:
> > On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
> >> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> >> simplify the code.
> >>
> >> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> >> ---
> >>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> index 3498743d5ec0..fb4183ff02a9 100644
> >> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
> >>  	 * additional active scan request for hidden SSIDs on passive channels.
> >>  	 */
> >>  	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
> >> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
> >> -						 adapter->num_in_chan_stats));
> >> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
> >> +					    sizeof(*adapter->chan_stats));
> > 
> > n_channels_bg is 14
> > n_channels_a is either 0 or 31 depending on if we're using BAND_A.
> > sizeof(*adapter->chan_stats) is 10.
> > 
> > So we're either allocating 280 or 900 bytes, which is quite small.  We
> > should just use kmalloc_array() instead of vmalloc_array().
> 
> Should transition from v*() to k*() be separate from transition from *malloc()
> to *malloc_array()?

It doesn't make sense to split this up.  The right thing is kcalloc().

regards,
dan carpenter


