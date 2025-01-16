Return-Path: <linux-wireless+bounces-17592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD43A13796
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362281889E64
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CCB142E7C;
	Thu, 16 Jan 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6xkGtOC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474224A7C0
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022628; cv=none; b=XHUx0kiIYAA8toGky8jp8tq5GpqTnYx/IvV0pfdBIyfQvUa6ezhb4GKmLA0dlhbvlSP6R6GqmA6m/2BdQfhpa80cn7vcfhaXaaqxjeaNdzriP8Pe+q/XcErAyMftJ/4EwBhuMge1Kf/0hYiiNLgs77HzWImv2UGp85RfmqoUpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022628; c=relaxed/simple;
	bh=RUWTuIjMyqk7vbnqniogu2hMM0t/Qwrpz7Phq1gZrCM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kxBMnINhuHjSPLaJZqJffWO9b05x6G5aULzmgH+sD6TslGRCYdPRRZiM7UFtehfEBw/ZwXs7/WYszN5TvNTVhfYpW284jiJWvagAspLRbXic/rIGy+fPsWa5CwL5B0CxGPY2YqrBf+QnbuKk5w7VQkQ9AgJP3JVRd0ozK482WaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6xkGtOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8C4C4CED6;
	Thu, 16 Jan 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737022626;
	bh=RUWTuIjMyqk7vbnqniogu2hMM0t/Qwrpz7Phq1gZrCM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=m6xkGtOCNAej4YBSXQEctEdVKEuDFsXv7GlsY6nxfcbfrTsvr6QhYY+yTwEcncQ77
	 LfEbZ6P311Dpay75PsknZ0hcdMZSrANcwxcI82FCtpDYr9HaeQvUSe0LlOCq8DYo6x
	 E6E8qKWz0oMEo9nBS+chlO2vc62T1MIATIpdUUAGDTVFKynBeIhJRLgCtkMPs8hAw2
	 Sf1af3czzoCHwYKDcd+asWGR4faCs3k/yllOaCGjxOATD/aBem2T58dDK9moUKTCLd
	 2DqCXvdP9PyGwnNSE+EstPqYoyGmOfgC39EtM79p9rY7OlVkT1X8Duqx8dqZGuPhT1
	 4ad/BZxPjb2mw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>,  <rtl8821cerfe2@gmail.com>,
    Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
References: <20250116054337.35723-1-pkshih@realtek.com>
Date: Thu, 16 Jan 2025 12:17:03 +0200
In-Reply-To: <20250116054337.35723-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Thu, 16 Jan 2025 13:43:37 +0800")
Message-ID: <877c6vnjvk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ stephen

Ping-Ke Shih <pkshih@realtek.com> writes:

> When using allmodconfig, .config has CONFIG_LEDS_CLASS=m but
> autoconf.h has CONFIG_LEDS_CLASS_MODULE (additional suffix _MODULE)
> instead of CONFIG_LEDS_CLASS, which condition CONFIG_LEDS_CLASS in
> rtw88/led.h can't work properly.
>
> Add RTW88_LEDS to Kconfig, and use it as condition to fix this problem.
>
> drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_led_init'
>    19 | void rtw_led_init(struct rtw_dev *rtwdev)
>       |      ^~~~~~~~~~~~
> In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
> drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous
> definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
>    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
>    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |      ^~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous
> definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
>    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~~~
>
> Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Maybe add Reported-by and Closes pointing to Stephen's report?

> --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> @@ -238,4 +238,9 @@ config RTW88_DEBUGFS
>  
>  	  If unsure, say Y to simplify debug problems
>  
> +config RTW88_LEDS
> +	bool
> +	depends on LEDS_CLASS
> +	default y
> +
>  endif

As led.c uses ieee80211_create_tpt_led_trigger() should we depend on
mac80211? For example ath10k has:

config ATH10K_LEDS
	bool
	depends on ATH10K
	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
	default y

I can't recall the details but I suspect that's handling the case where
one of the modules is 'm' and other one 'y' (or something like that).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

