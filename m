Return-Path: <linux-wireless+bounces-5878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85817898E19
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C9F1C22528
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8511311A9;
	Thu,  4 Apr 2024 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="D9xNsJdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE217997
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256046; cv=none; b=t1WPoV2rvZWZAzfl/bPRrc3nh2QVfVruNgUJwuq0VqvztrgKwcQMd6Y+pKJvf7UcXgTyAUOv6RGQgPFu1dqfRCYv6XobuoK/cQud4lLOv/CxA72gDjboynUxPdQqfKKNk/MZqpAzwtsK1YKkT4ZRub/aGf4M6dmubxVfajnKEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256046; c=relaxed/simple;
	bh=enjMn02TLD3mOlnQB3yn7S7ejIE2sr8ne5y/rmqQS0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpOAgPfbnoDUCZ8oKnwSeqVgT/zpC6Nz/TVNmBV6ErTKQEZ2IS81SiH0eNF2lkdvQjDhQmaEkwHXVvC4TUI7CQQKmr23x/bCT/Sxp+xJDXr90A4LBlHfsbC148ZaOMmETZtdjf18HwvhrWrNo4sY4X6800dAZERA85dyyxlFDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=D9xNsJdK; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1712256037; bh=enjMn02TLD3mOlnQB3yn7S7ejIE2sr8ne5y/rmqQS0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D9xNsJdKKuXc5gFTSJJMIvdvNp5bNm3DTwdjoiY2alEUOebOBsttHHtOxBBw0+Wfh
	 DNttDY0xYyXO7UwLLLrFlmXI+4P2gVFb+vNkjMoHKIDhhuccQ7pYEWLnRdJUIgQQMc
	 t/MSYrV9Ee9hbjR1BGrMRFMA6Qof5/LriiGizL1jNa9mQrVXfJ4ZRJSFthf0pFOolq
	 yp1Srcs4ZEiuFYtKc/ghB9pa0wRzgRhVQhW7+HbS1sUhzwJZvJ0+HnP2RrUjRgwgRm
	 EkKvqmJRpLpo8/ruHhsk0Yn817UDQYwdofKVcrRLdXCLgJngcdq4LZjPKMNO7dB1+Y
	 9nWF/PKQNaN+g==
To: Chien Wong <m@xv97.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k_htc: drop too long USB messages
In-Reply-To: <20240404150110.13816-1-m@xv97.com>
References: <20240404150110.13816-1-m@xv97.com>
Date: Thu, 04 Apr 2024 20:40:37 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87edblkm3e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chien Wong <m@xv97.com> writes:

> Currently, the length of USB messages sent from host to Wi-Fi dongle is
> not checked. Without the check, we could crash the firmware.
>
> The length limits are determined by _HIFusb_get_max_msg_len_patch()
> in the firmware code, located in k2_HIF_usb_patch.c and HIF_usb_patch.c
> of the open-ath9k-htc-firmware project. The limits are 512 and 1600
> bytes for regout and Wi-Fi TX messages respectively.
> I'm not sure if the firmware crash is due to buffer overflow if RXing
> too long USB messages but the length limit is clear and verified.
> Somebody knowing hardware internals could help.
>
> We should try our best not to crash the firmware. Note that setting the
> MTU limit may not work: monitor interfaces will ignore the limit.
> So we just drop too long messages and give warning on such events.

Silently dropping packets seems like a bad idea. If needed, we can have
a length check with a warning *in addition* to the MTU limit, but we
should definitely disallow the MTU change first...

-Toke

