Return-Path: <linux-wireless+bounces-17611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0EA1423A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 20:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B6C7A3969
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7C22CBC1;
	Thu, 16 Jan 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdIElFlr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55222E40F
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055578; cv=none; b=b+1YSvt7WPyw0yT7k2H7O1k+V//rYyft9oI20zyeyLwdYcTj/erK6CuS7mw4xBufKnpB2GnR3alWuYsvrYad/Q7LODTixWTlAu2Q7kpDlxklhM8UuyoncNwVmY0f3KE0GYblenfOMhNakFNQhTrXT5sl5vODunLgSsW5HYdj1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055578; c=relaxed/simple;
	bh=1qBdtG9JK9sIk3aW1/PXjJPv5bRecs9Mua8OjF6+Pz8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YMNg03a/h60BrN+3UwTPIJ5uJvd7KySRpmmCSaSFNqMNksN5YWMhVCbZ5nFOSwN/twQ0PpvAMfZ5dcVJP8CLYYeF6BPX1hTsVrloMmfm00/JK4h79LZ2YP6sasEULsZiNlmK97h1IC15s6F2oWxRJUWwzIJWjO1/WSUgZ7+WDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdIElFlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE71BC4CED6;
	Thu, 16 Jan 2025 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737055577;
	bh=1qBdtG9JK9sIk3aW1/PXjJPv5bRecs9Mua8OjF6+Pz8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rdIElFlrllrJISKujK3wsTPsT4q1ybEfFABwCkLxgAJd2nVt9fY+hNeIZBbVeAVn2
	 zMyP+x7wf1xxh8p+zo3+5cX0e3vLuSUbjp1tdZl8GQtIOokoQP3BBHsCMaz/+aVmHT
	 FXyrdzvkjJAtHGOC5UZOS64Uk/IJx01jMEi/OQwMgVA3gGeHPfA4ulkKrZDkGfQmmy
	 0uFZWuQxTb74Qmt2moEwCg2voL7fvQWvID5mC0q4fUmMM8vTlLT4OTqi7WV55lq5Dq
	 cuw/jt8+pD5urYFcUShrgIKTkIcJTFZ/cw5jKRLVfmNfJvc3hF90f0nJzI84xp2Ghi
	 V2ZIHD4XJ6Ayw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250116120424.13174-1-pkshih@realtek.com>
References: <20250116120424.13174-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>, <rtl8821cerfe2@gmail.com>,
 <sfr@canb.auug.org.au>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173705557492.574756.8841895327319970368.kvalo@kernel.org>
Date: Thu, 16 Jan 2025 19:26:16 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

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
> drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
>    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
>    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |      ^~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
>    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
>       |                    ^~~~~~~~~~~~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-wireless/e19a87ad9cd54bfa9907f3a043b25d30@realtek.com/T/#me407832de1040ce22e53517bcb18e322ad0e2260
> Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b4bfbc50b1b9 wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250116120424.13174-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


