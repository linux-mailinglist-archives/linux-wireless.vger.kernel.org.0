Return-Path: <linux-wireless+bounces-8190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC068D18F6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2CBB26067
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3131016B74B;
	Tue, 28 May 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvfeiVof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0013C8F9
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893632; cv=none; b=P7H/XkmjUGISek+K2momRPAxaAsJKK2zlXqA3w/90z6WsNKroUBtxpiZfgya0ewAMtNqiXffCoke3sQjhTe/4vVKxWZELnFhjPVT4bbvaSunjcKy3Uz603UBUvLEVAIZCg+XVUE659/08BoehRTLeyNDeyL2F74n70RqnHsqxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893632; c=relaxed/simple;
	bh=QkcZxajGb00J6ZbUt2EuAnm/6oRcshndsRkoG7aXCQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvL72vPlwYmaYZ/hKppoCWmbmTMSCCzGW48niuqVuDZE0pPp9+2WSSthFDhIbo8JPnAPF/GF7Kdrx0O2vAu+3y9WSvP4vZoZjsPL26uqFP4SYc87okdbagLRm4SkBg/Exnlh1VKShFrVvu9eKbiKbuId+reJCx4NUhx1y4ZH684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvfeiVof; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681a4427816so519165a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716893630; x=1717498430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XhHOozL8LqWJTKfnYbtyc4lUHZ9P+Va/JgiPQwIADs=;
        b=XvfeiVofTqZk6A11rkinf1jetyG87TgfiMV/foKjwM2Y2jUf3ILt7MjWOBeyvChMkb
         cUwxXnwtwcmt8wSY9wzxmf3v54VfQKxrXYsNeZVVcFj/b1D63XNtOkeXvZ+FaO1oFivi
         n/rijxVSccIhlRNHukMAfk2WxUVWHTN5LDjfaltBwIGirK0qCmEY8iGlbXFFNPA5gaXB
         Ac7qHo0zXyUxmOgPkLZ6vVwEBvELF46QMRsfKtxU8r4UtXOZJOjlr0wKh0ySxK5/j36y
         4p5O3FEtWlsPD7YIL+FMcROhIq5ZnPBv1gUEXpfwgrvfbP2DI/taBHl+ameol0WIMbRz
         xr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893630; x=1717498430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XhHOozL8LqWJTKfnYbtyc4lUHZ9P+Va/JgiPQwIADs=;
        b=hHWen+qa0df4l/Yy30MpK72qVaNsuZLQwi/yB4FqcL4qh8UD2zpuOknSan+On1Cv6A
         lMY21yStoAGt8CNR95E1nfaGkt6Z74bHJElukydP7yarg6n18TW1Vc9sjQ3ayBc8NtQQ
         u9HmHG8+HtJS7uBwgn09tXH6RKNO6m7PCOmgbo8GdHhUID1zWUO/HwB4TuIw4tV34HC3
         2hkr4IO2TB3oh5sU2e7geqAi8vj7rUJAfjBXQrEYSqW+2MCTXthDbODVRPsnHZ4QKDYK
         tuRsawbGIFCpCZRh7k/2n5ga15CxBEWVtQigaGGB/WF3izHyFvgI3uI52pYwOwUx4qli
         joNA==
X-Gm-Message-State: AOJu0Yxjrr1vW9nqxL6UuePI5/QfqkYVdEgQipnoWTRBQtlgk7Qgciwa
	8SIq21TLxR/aOQ1ThtWxpmbPFmi4g5DxvmZ+exr1ufJDzRYDYKQcD86fLp3epRNg3Z3EvO3d5F5
	mLQwd1f7mcqjfoIUBRyy9ypQMGU4=
X-Google-Smtp-Source: AGHT+IHYlM+QTquclax02IAsGP2376p3T6rgLYJD7W8pSsST3rgkuOkNWQLlu/Y0kyOXT62SHWDNlXPwRI/YTzxyImA=
X-Received: by 2002:a17:90a:e501:b0:2bd:9256:8ce0 with SMTP id
 98e67ed59e1d1-2bf5ea3c2f8mr10180598a91.14.1716893630051; Tue, 28 May 2024
 03:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <20240527173454.459264-2-marcin.slusarz@gmail.com> <7427b534f5e64abf8a31a80082d4b6e1@realtek.com>
In-Reply-To: <7427b534f5e64abf8a31a80082d4b6e1@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Tue, 28 May 2024 12:53:39 +0200
Message-ID: <CA+GA0_tud4wLBKCokQNwB_3jULTPfnS14XmaLHomGMSOLhKszA@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: use RTW_FLAG_RUNNING for deciding
 whether to enter/leave IPS
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 28 maj 2024 o 05:56 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > From: Marcin =C5=9Alusarz <mslusarz@renau.com>
> >
> > Needed by the next patch that disables power off operation for one chip=
.
> >
> > Signed-off-by: Marcin =C5=9Alusarz <mslusarz@renau.com>
> > Cc: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Larry Finger <Larry.Finger@lwfinger.net>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > ---
> >  drivers/net/wireless/realtek/rtw88/ps.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wire=
less/realtek/rtw88/ps.c
> > index add5a20b8432..f9fbc9b3174b 100644
> > --- a/drivers/net/wireless/realtek/rtw88/ps.c
> > +++ b/drivers/net/wireless/realtek/rtw88/ps.c
> > @@ -26,7 +26,7 @@ static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
> >
> >  int rtw_enter_ips(struct rtw_dev *rtwdev)
> >  {
> > -       if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags))
> > +       if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
>
> RTW_FLAG_POWERON is to maintain power state (i.e. ips) of WiFi card, and
> prevent entering/leaving IPS twice suddenly. Changing this is confused to=
 me.

I explained it in the other thread as a reply to Bitterblue.

