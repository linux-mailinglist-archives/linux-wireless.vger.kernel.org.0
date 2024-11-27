Return-Path: <linux-wireless+bounces-15764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86819DAAEE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93498281C9E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA420010B;
	Wed, 27 Nov 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LO/F4eIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60D1FF7C6
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722258; cv=none; b=uWpRwtONuJzf/KYBPRcR8ICpFRsLKRsZ+QsC93oTTwzcHAZJuS7glTBRbNtXeM5BPSPSqDmSEk+Piae9UJIxprUT+bgObTz91VtNJyNwNfQdbKt88atB2801RkEVcNyFooFxLAdRCMJl2EwAKldcZpHaRxfAg0dd/7jkG8t8NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722258; c=relaxed/simple;
	bh=bVT+dpvBwxjyqpQVrhRvKPf3wxf2mZmKZ5jvpYljAyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvjp9OoonWMwMciodcUkPWwRGZKKrZ1UFpDcl7tGheEHVR8x2thnHc2Ikgx9Y5DLnlzEhq2F7wF+Qc5WzMyqvxF1boFti9OTlcRe7aTYlG8J9Yn7rtyVqvQva7FCNDAWfC9A08k5k4dX6tibeeRDAuld1QbWgHhgFUhmoHYNdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LO/F4eIq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df31ca44eso480049e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732722254; x=1733327054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb++oae+LfaSjUgB9HTAkHZpSmH52F0dJv7k1k95lEU=;
        b=LO/F4eIqZiIv9Fmgvy+uu0dRnL7XHFL5DKBcMkKkSF7L+6zpror4jTsGIO1JWT0oMY
         0SwX447jD8zpA6iNqyymSjk1WvnoNHLVX73L5iqbcIevQn/CdBwqKoeiiIQ4AXP6CYX8
         ADyVsZGwOKkujqQFccRLXY2e7dIaHfUWZSmPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722254; x=1733327054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb++oae+LfaSjUgB9HTAkHZpSmH52F0dJv7k1k95lEU=;
        b=oHsNGdaRKxTTiQbCMlRS8405te3k6gi5w4EKKugTobiqPHex+Zok58RjtTWYvpepxf
         vyIdmrpOkDGNElDbz9ofsTPQ0x6jbxVgeiqxAorDN2DlBuG5ZoJBQC5R+hH2joyYCg8C
         JEMkngu/GaQpEn68r/i6+yK3ch7e/rWFBTvTLKih6hLEzm09L/eNwe6v51yxSxV7QBdN
         HdYfbjRE8Oeno7Z111cw5AihXHsNF3WZDw89LLlbG7oAvwJQhGTqpVdbv8DI4c024fob
         UohwPwAhe3EHDzjLrbssmhtQlfzudDfd2UJdA9KbEFQOo5SDw0nF6bWbhXcPa/U1kHvy
         9ZoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0irdJglo6aQTWMqLl/VP80iMs1DJLcakLHF9pxVeY6EFVjv1TS2LIJQY7bANFVRbDEoQRsZUWGBzKWOAOEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYWx85Lv3yeQExRMJ47jnbOC6LCoJIIcc6T/5xnyiLyxeGATB
	+Ly6xf7YGatnEVFEQSRiWw3lZHVTVmI0wmWUhRr8zaXHUJnsZl6ZM78XS3fyuKZ0JLEtdvvjfAc
	DlA==
X-Gm-Gg: ASbGncvIoDSP0nws9zhvO+iIAFtd4Ldl9AM9Gokoiz1/o/BSdNwOkV1y7pXGxm3AU3b
	flZ627DNjhH8izIbSf/DbjY39PvC37hLGiFkaztCGb1XWoIbd3ysxzXVdXSc6fNVMGN5PAwPbPC
	lj00KnUWndRmfK22zLhAT9RyNQQytivXesN2cMFsd0puB3s8qV/q/N9JWwYVol4yP3f8mr1nmAR
	Q1zsXVxe/fUkf77bSuHpx7A9bFKqQc5jpoil7ELk9kd07WPWNenT6JKYRwUbinoAKDybW5UXDfQ
	pn3ewveCd2E/Rg==
X-Google-Smtp-Source: AGHT+IFH5z8v0FS1DjZ4MT7j1QX80p4r49Hd79PCHEID3l7/nKvoTlcZbuTLtJP21A/LOfh7GQYdXw==
X-Received: by 2002:a05:6512:b0b:b0:539:e85f:ba98 with SMTP id 2adb3069b0e04-53df01126a8mr2210496e87.56.1732722253790;
        Wed, 27 Nov 2024 07:44:13 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53de43407c0sm1094956e87.215.2024.11.27.07.44.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:44:12 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53df1e0641fso781723e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 07:44:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRdoOZAC92/n6Ddr/LNR2ICILiVe6fmvGFpvYVPFelEIvedgj15mC2qnz+irvCoI7Mozf/9dEvNchmIyLUww==@vger.kernel.org
X-Received: by 2002:a05:6512:2355:b0:53d:e5fd:a445 with SMTP id
 2adb3069b0e04-53df00dd3ddmr2419949e87.32.1732722252087; Wed, 27 Nov 2024
 07:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
In-Reply-To: <20241127105709.4014302-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Nov 2024 07:44:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
Message-ID: <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, 
	David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2024 at 2:58=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> wait_event_interruptible") it was noted that sometimes we seemed
> to miss the signal that our host sleep settings took effect. A
> 10 second timeout was added to the code to make sure we didn't
> hang forever waiting. It appears that this problem still exists
> and we hit the timeout sometimes for Chromebooks in the field.
>
> Recently on ChromeOS we've started setting the DPM watchdog
> to trip if full system suspend takes over 10 seconds. Given
> the timeout in the original patch, obviously we're hitting
> the DPM watchdog before mwifiex gets a chance to timeout.
>
> While we could increase the DPM watchdog in ChromeOS to avoid
> this problem, it's probably better to simply decrease the
> timeout. Any time we're waiting several seconds for the
> firmware to respond it's likely that the firmware won't ever
> respond. With that in mind, decrease the timeout in mwifiex
> from 10 seconds to 5 seconds.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I believe Brian Norris is still anointed as the personally nominally
in charge of mwifiex upstream (get_maintainer labels him as "odd"
fixer, which seems awfully judgemental), so he should be CCed on
fixes. Added him.


> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/n=
et/wireless/marvell/mwifiex/sta_ioctl.c
> index e06a0622973e..f79589cafe57 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> @@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter=
)
>
>         if (wait_event_interruptible_timeout(adapter->hs_activate_wait_q,
>                                              adapter->hs_activate_wait_q_=
woken,
> -                                            (10 * HZ)) <=3D 0) {
> +                                            (5 * HZ)) <=3D 0) {

Given that I suggested this fix, it should be no surprise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Upon sleeping on the idea, the only slight concern I have here is
whether we'll trigger this timeout if we try to suspend while WiFi
scanning is in progress. I don't have any actual evidence supporting
this concern, but I remember many years ago when I used to deal with
the WiFi drivers more often there were cases where suspend could be
delayed if it happened while a scan was in progress. Maybe/hopefully
that's fixed now, but I figured I'd at least bring it up in case it
tickled anything in someone's mind...

If somehow that turns out to be a problem, hopefully we'd be able to
find a way to cancel the scan or break scans up into smaller chunks
because even delaying suspend for 5 seconds seems like it would be a
big problem.

-Doug

