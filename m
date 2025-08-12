Return-Path: <linux-wireless+bounces-26318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0F7B22979
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ECD683491
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36D28689A;
	Tue, 12 Aug 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5M0o3dn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B814285C88
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006548; cv=none; b=Y1KZEU1PV0kJZNxIGgFyiVBBQqua1C8+Woew7eeJVHLQ0AhZuxofs5WZJqyuEZNiLf6tDz92cJwtezTddvt/QfJUopTzN69uaAc9k3b/uhMd/YTwke2p9z2Iqi2Y09l9a2NtvoddTkddp9Ze7GKlwtNG1PZMaED40IR7F/L9ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006548; c=relaxed/simple;
	bh=zAL+HCudjRPYCWrv9McHC6ZrDPADT6Wmpz7N3ujlOuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZreE8kKrMSVnUef0a8vn7PsqKWltD/U04SIAbxWAt+v3Zi8ZjqZJr8tO5OHTaOcmIUXvFCSB1O9JjtSBquyedEOyIfVX+wejG87KdVyUFkw/ozIblFn2lu+Clem6vIrHQSh++gOh8BJ0ML48tyRk/iv9PQ9T9pIJmCfKM+Uc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5M0o3dn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so46680105e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755006545; x=1755611345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08lMMnAuZbexFUDswk//BS4zdf3W0OIMM3C3XcBrhFk=;
        b=w5M0o3dn6iSVUXMHpLMpKprebntTfF1j1cZpADkaAMeLmRYM5EttFF7gviZsjNtX0w
         3MCPkPTO3gGRolhRv4halm9MkyWAogcCHJBr+igUmACM+oOMmO8e1gcnNdAFSBerLuAD
         z4ZyK0euPVibw9lug6zWu77UQ4lInCFa1kfdi/kD4WB6XcdQu5lIdxVBkAjo0U+W72cP
         kH0kU8M3K4XGRv3oM6DZ7StVvf+WJkGVxQn3/XnroAenX52M7UrVGmSU0MZBikQP0fdM
         v4WCKFZXbjNtIaJTiJSWVSVh4Maa3BcPothZPbbVczKD/0GwJOvF1xaybKlpSByESsL3
         zGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006545; x=1755611345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08lMMnAuZbexFUDswk//BS4zdf3W0OIMM3C3XcBrhFk=;
        b=iylNt71Z+Szpzzq37LnmXjQXKZLbRkBA7lolPPotwgS4ADoXM3+GS7pE4JryWmP/hd
         Uvz5b/B4GJ6aneKg15VUCdZW8Qu+t5GKiqNdC++UYL3glIySKjSeRMjJk+cc5WO3Hbgn
         CQVk5J3RS0vHgO1JY/ePQn74r75X73kgnxwZ3AnrwrM+MyDhbTLNjF+UMYNhPnbag5QE
         9HSwcrnm0hz1Jn5SuRf/ikrfk0tysRr+U4DFBuTaK65BqbT0mpA88Ie7VyG2lhkhdyFK
         +8g/MPBrREzZ1y2vJGbiq1Ks418RttWUS23KtVcB/vg4NhXGk8fN3XUC44mtB8Y73Ime
         iFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUejxRWZ9/csZPdMNBDyczgdVJxEaWrNdL0kA4wpGTsKMBQDQw0cnM4twqFQEhv+Vv+1kMKiL6lUBZmY2d6Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQy8biNkfMIWgPuFP+0UwY5GabUYek7k5hXVeyGmlLv7e4t3Za
	DYUHowJgMHxfhNese7OJf3hxgON3Bzo4NopfR6k/N15q8n6odN+BkqgtOSpvP/RYidQ=
X-Gm-Gg: ASbGncs+6kX43Zq2Mx7ETthiHWP5KER8lwiu3Zcnq8Qlu3ty313kl5tsIRSAQrIbKnA
	4LKa/eXY5K9sZUKfwcmCUfSUFNLBzRl1LuKTjvV3qli2lMHuwbbVJ5xl+sDQJVi7JC3HdhxsBPq
	lWnxwgECtzakWihL1ZEU0YXYyLlKKbWf3Fw2GvseeE5WvNluI7UznhcN3j2/rqlKCB1rf9QdYZo
	aQZ8u6i8arhkx6Wjmyj9WYAFoHk1kybmgA6O13HUCIxq2oTAkCJZ3B+0lEbdP0PDRIUx6qn5wrr
	yeuj4J6NA7KGnaFAr4Zk4Q3D3dM3K++3l4UdzfWaY+oY/ma0md1dfNDS0xLWkHhNBAeodRxGTcg
	ulKoP/SK2c6Q9qX5WOjP+edfhCAJkrLiilpBLQnm5tde+nkJ7OxfpmA==
X-Google-Smtp-Source: AGHT+IGLBVpM+WvfEq6XCBSQ9vxuqIAnySFsZdyo9omq1H0RmQIZbDBjg8TJ5XIabgMb/NeqyMxdCw==
X-Received: by 2002:a05:6000:2283:b0:3b6:b020:9956 with SMTP id ffacd0b85a97d-3b91100ce9emr2878960f8f.43.1755006543962;
        Tue, 12 Aug 2025 06:49:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0cd2c90sm351317865e9.17.2025.08.12.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:48:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
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
Message-ID: <aJtGSxkRztAsy92h@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812133226.258318-6-rongqianfeng@vivo.com>

On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 3498743d5ec0..fb4183ff02a9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
>  	 * additional active scan request for hidden SSIDs on passive channels.
>  	 */
>  	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
> -						 adapter->num_in_chan_stats));
> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
> +					    sizeof(*adapter->chan_stats));

n_channels_bg is 14
n_channels_a is either 0 or 31 depending on if we're using BAND_A.
sizeof(*adapter->chan_stats) is 10.

So we're either allocating 280 or 900 bytes, which is quite small.  We
should just use kmalloc_array() instead of vmalloc_array().

regards,
dan carpenter


