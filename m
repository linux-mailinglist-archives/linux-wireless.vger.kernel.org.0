Return-Path: <linux-wireless+bounces-17603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38EA139E1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E2C7A521B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327091DE3DC;
	Thu, 16 Jan 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0Wsai7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4761DE4DD
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030209; cv=none; b=Gn5IJoeGbDZQRyTfk297lPRKuBtILnAF2aOeYyyBYS1I3DCGv0Ml32/vj+wO+6ue7I3/yLbkM4YqmS4B66Gn41pkZlROwZOaKJncMrfuFSVRbP/dHJLtEvFtyTET1vFYkdHrS8B69TZo1Sihln53RY7V/FBn/5fBIJzw9tcNsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030209; c=relaxed/simple;
	bh=12ScO1hMhrdppGkD4LnSDI9JMDlY+xSGvS1dSMrXETk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ibHsz9lU7tXwXNM/EAuWrFKUF0uzibikJRJ3MejIheP7OxU1KRdNS8FA/Fzk6biesd5IeK5iQ7lFeApacG1WIIFAgrJGcYZLE/Ir6gD8LZOmz38hMVvbKDlp9tIqF/OUjBuW7cJ7EmKPeKnVKfjEknrwryQclDHaIsj9lH9NCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0Wsai7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE57C4CED6;
	Thu, 16 Jan 2025 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737030207;
	bh=12ScO1hMhrdppGkD4LnSDI9JMDlY+xSGvS1dSMrXETk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Y0Wsai7uHR1UjC/Kq4vErKeOuT9wZ45KHa+IJqh7lw72zIaiFiqxXGT3xvvFbyinS
	 FPeEl7KohRuwkL2f13MRy4csSw66gPG+9RFpDoGVgxhoonpJAkdLSEefBtDnXd/jlI
	 vJRiMSFOM54rLTHmjmM8mKlnfNZJibGfFVW9SLQCqsYRKAkDiW2YtT8I+0H/Z3Mw0O
	 24KLjWlHU2A4r9KcHhL8zMYknmxLDN1FRWBT8r7J3jJBeYTeTCNJANUI4LVSZAW+An
	 mxbyu7TWjeU63R2KJ3G+D6Emwm1Vc2eJpPHlZy25DzrbXCi8NErVRuKI5csu4su61Y
	 uogtDR1WMiyDQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>,  <rtl8821cerfe2@gmail.com>,
  <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
References: <20250116120424.13174-1-pkshih@realtek.com>
Date: Thu, 16 Jan 2025 14:23:24 +0200
In-Reply-To: <20250116120424.13174-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Thu, 16 Jan 2025 20:04:24 +0800")
Message-ID: <87ldvblzgj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-wireless/e19a87ad9cd54bfa9907f3a043b25d30@realtek.com/T/#me407832de1040ce22e53517bcb18e322ad0e2260
> Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks, looks good to me. I'm hoping to apply this to wireless-next
still today so that it can be in tomorrow's linux-next build.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

