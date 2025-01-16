Return-Path: <linux-wireless+bounces-17602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388EA139DA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD90F3A77BA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2981DE89C;
	Thu, 16 Jan 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGcaYm4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC71DE89A
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030089; cv=none; b=DGn0A3gkInWO+XUh1mtDpDyHCggrOzGS74QO4MXNK721vGsKcDBb6FoTNnO/R+BN3JuBlq4eMRevQh8mMJ/5lJgkKaZlm+mffXcMBg2z0lqCVl452NUF2eLSdNaWKsZgouz/f4jxoZNhxwV+2SDRmLTL/qlE0gO/hwZK57ElzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030089; c=relaxed/simple;
	bh=t7XNkb+EognnEhNuRSl2GEnEcY0izezjMfN4Yo4afSs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qT7vU/X+QsPvyG4xt5kBAh+dHrIUOja6exftF3s0CfaaXfm6VJ53v3SDK0uuewufSeuTozHfxYsWu2D4F+Tx+bbH28v+HDLdFIXnzuG408oGTJAacqpz4EDO1IP3YdzKUcgCUTPWlYSlV9RPqZaxzk93PYgWvF+KIUXCSLDZr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGcaYm4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FE1C4CEE3;
	Thu, 16 Jan 2025 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737030087;
	bh=t7XNkb+EognnEhNuRSl2GEnEcY0izezjMfN4Yo4afSs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RGcaYm4La/zTGzmaJfscUV/UvRsl586/WpfKJSzFbXIgtq9GChRFUshAlnrlNTSKi
	 QbDInCshTojAS1Y1WdqkGPs3R6MEr+BGHX0RLQYWaDNhbabkRLQ172uNjD9RhtsgIi
	 5IibzE2HfZnmZvlTxC82IKzSvX3caTqQUvr30Qi8z1Ln4StOhmU7qBhb8gqOxJcT/e
	 U1jf4wdszidD7zk6cKzNXs1eMz/80sWVq4o//pU59FpsCo75gKVsHT/Bh3KTZQUqa2
	 ncVrcdpK7X1uM9gsw8z35kyu03RLnHT3mHBvsBxksg2QCGnu0DqfIYj3w4G4hr8IAi
	 FH88z2RJQnoJQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,  Stephen Rothwell
 <sfr@canb.auug.org.au>
Subject: Re: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
References: <20250116054337.35723-1-pkshih@realtek.com>
	<877c6vnjvk.fsf@kernel.org>
	<d30d222d7c0845fa85fa3506242511b5@realtek.com>
Date: Thu, 16 Jan 2025 14:21:24 +0200
In-Reply-To: <d30d222d7c0845fa85fa3506242511b5@realtek.com> (Ping-Ke Shih's
	message of "Thu, 16 Jan 2025 12:06:11 +0000")
Message-ID: <87plknlzjv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>
>> + stephen
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > When using allmodconfig, .config has CONFIG_LEDS_CLASS=m but
>> > autoconf.h has CONFIG_LEDS_CLASS_MODULE (additional suffix _MODULE)
>> > instead of CONFIG_LEDS_CLASS, which condition CONFIG_LEDS_CLASS in
>> > rtw88/led.h can't work properly.
>> >
>> > Add RTW88_LEDS to Kconfig, and use it as condition to fix this problem.
>> >
>> > drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_led_init'
>> >    19 | void rtw_led_init(struct rtw_dev *rtwdev)
>> >       |      ^~~~~~~~~~~~
>> > In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
>> > drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous
>> > definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
>> >    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
>> >       |                    ^~~~~~~~~~~~
>> > drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
>> >    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
>> >       |      ^~~~~~~~~~~~~~
>> > drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous
>> > definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
>> >    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
>> >       |                    ^~~~~~~~~~~~~~
>> >
>> > Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
>> > Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> Maybe add Reported-by and Closes pointing to Stephen's report?
>
> add these by v2.

Thanks.

>> > --- a/drivers/net/wireless/realtek/rtw88/Kconfig
>> > +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
>> > @@ -238,4 +238,9 @@ config RTW88_DEBUGFS
>> >
>> >         If unsure, say Y to simplify debug problems
>> >
>> > +config RTW88_LEDS
>> > +     bool
>> > +     depends on LEDS_CLASS
>> > +     default y
>> > +
>> >  endif
>> 
>> As led.c uses ieee80211_create_tpt_led_trigger() should we depend on
>> mac80211? For example ath10k has:
>> 
>> config ATH10K_LEDS
>>         bool
>>         depends on ATH10K
>
> Kconfig of rtw89 uses a big 'if RTW88', so I will not add 'depdens on
> RTW88'.

Ok.

>
>>         depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
>>         default y
>> 
>> I can't recall the details but I suspect that's handling the case where
>> one of the modules is 'm' and other one 'y' (or something like that).
>> 
>
> Since ieee80211_create_tpt_led_trigger() depends on CONFIG_MAC80211_LEDS,
> which looks like
>
> config MAC80211_LEDS
>         bool "Enable LED triggers"
>         depends on MAC80211
>         depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
>
> So I will imitate ath10k to use 'depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211'

Thanks. I think the leds stuff is number one cause of build failures in
wireless so this is always tricky, let's hope this works.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

