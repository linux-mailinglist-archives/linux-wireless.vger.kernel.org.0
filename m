Return-Path: <linux-wireless+bounces-25256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECFB016F1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B80189F718
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3E20E702;
	Fri, 11 Jul 2025 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOhIhLc0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12271F3FC8;
	Fri, 11 Jul 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224108; cv=none; b=BclQXmQ4JWpS0rMK16q5FDXCUs5YNHO3J/kBWdqEWCyBqMN3zeXAAQ5M8qrETw+jVoBI9NBD2Iz8q7gCoFbPfgfqq1DgpXxQ/IXbvCivXsm4XBbhMzwkMuH7ppXdjircgqxJ2L3t56frxluNHQcH9wVnGToi4BMSPUixHsZSNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224108; c=relaxed/simple;
	bh=E88bWI2C43NOAEpHeI3UrXi9BYA6+UhekxlaejqGJXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2U72kuDKWd+e4jBNAwXRAoCT8qZbP+IqiIFg7A9i4Vu5dU7+v+0QnaLqfRV/SVcW9w6TF9+2XsvL5SaaWuuyM048nTRMRVlj13tGTx02uU/Uybon7qI4o0Dsrv+1/Os1aUsI2Dolw2Yc6FIxjH8NvKgCVrK2wKB4FIM6Ye0LlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOhIhLc0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-556373661aaso1511171e87.2;
        Fri, 11 Jul 2025 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224105; x=1752828905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7/rqxG6RcszxvkbOvouwdW7veRLx3yXk7oMIneWgf8=;
        b=ZOhIhLc09i/ZGSPfrikUnT290nQ2PAjNxNayHNnx08cCuPmGK5RtMwPwGZNxUTucmV
         krMG8k+N6hZImXi1KePjhwe4B5pzoKwOZhdXEFvjqAc2gXKmdUD7b07HFkAV5T62CcCq
         B62V43f+AUkDu70K1HsP4KDZNhxgOKlJftnjNtjm5WxuJ1L1wfuRgUsMxEtSbF4PdAqR
         mXEXAEIOxYnn8jIYctxMvZVU1w7mgLMRbckcJcWVMbpep6dGjrV7u58yFJcH4NOn9oMF
         qIdXktvSGW63jGMxN3IYVdu3M6v+Xj+JS7+/VLbRLiwFklitXDhdfMtt4i8RFlpaRCyN
         yhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224105; x=1752828905;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7/rqxG6RcszxvkbOvouwdW7veRLx3yXk7oMIneWgf8=;
        b=CAZ/V18IjGVe7tfWZ7yHBFT7T19qk21B24rSFExJuoSkwGoJsTL4MfdFBGDA0eNSJH
         nV95PCTEmRxGm3tDZuCtDU49dihWcAITq4fGvwAv7B6RTIMXqgKqGywGYBDOQCmW0T4t
         Vzf/4vXofDRk4INwMaTAvTTJYauX+kWqMz+AZ4zFQSUEk5P9mBsjVHR6IYJBqbvPQun9
         lW0O/AvkJpLiFY/9EcDumIziaNzjtbDIoRgFXq6xSF67xNUr/AvGvg9IGLT2NJ/QBnig
         qU+T/8MLvFoaocUisYNN5iJh/6V+9HAeu6YmBwukt0ONBzh4k7b1xAhHDmkUQDpseiDp
         R31A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Lx6FXgU5NVHQjFzeNV42nJWwsyFxaTdhP26WDVJtQwdur30nG4G6DFzDi1dxGEYN2B/8O1Ca+R7Y1RA=@vger.kernel.org, AJvYcCUMTA4i60YxPdUlP/UC5vk6BUVqXT95kb404aLQbIsZ/Uy8wGTbSMwWF70WvWaAXtlCZ4DH6p8vZfZLFe7y1wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEmwzkfGlxX9RBvweo8zEo0mbtt0ZjWROuCtjcOrgcfkux1tl
	wpsfSlcsOtVMww4irDlJ7Lwti0YXcfqElB+xHB3QE0tKwPjrTax80bv5x6bsrg==
X-Gm-Gg: ASbGncuiOw2Hqq5kd1t/NiQmtN2C4OBZxBiA/26yKYqtsi9Fj/sEw6ETnmE2aiOJqm/
	7IJWpRCq7K881kc39hoGEnyTecdsQ2M0IAkObsHBhl54KlKr0CPL1k3GqipkqRRR26sKy5qlC3s
	mVkM45zBwrRC7ws5awRciePCh5Gi1SloM+bWyEqOat1zXXPZfDNBPBRbL7FpP7nMKfpyjCEKX+w
	wTQc3EvELbsjziMp8DsEfTvLWUwQq+iIEzWa2PEsBJloSoFzBxsVk9szZbHieboWQq+h2E4FjcJ
	ioKtFnqdtzMCPey6AjCpEdBDQwMFJN8c+8F7tzl01PhSXVAZcIR6+Tpl2hJ/cXmWIVWM2/wp3qf
	klxwmxLWA75BV9OuZK6gHymYfnz5bcxLbrytn1w==
X-Google-Smtp-Source: AGHT+IHL/Nizc8Q4KOjWgryF6MkDZGSwtwbBZ5/b80N2kgWG8UkmeKn8meHQrpOIXwXduNT5w3dUrw==
X-Received: by 2002:a05:6512:159f:b0:553:ad28:210a with SMTP id 2adb3069b0e04-55a04663602mr649798e87.51.1752224104436;
        Fri, 11 Jul 2025 01:55:04 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55943b7115dsm824152e87.190.2025.07.11.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:55:04 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:52:49 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH v3] wifi: rtw88: enable TX reports for the management
 queue
Message-ID: <aHDQ4ah-UpJ7ADvJ@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
References: <20250710222432.3088622-1-andrej.skvortzov@gmail.com>
 <7e7a3532816b48ef94c18e735a0f7a3f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e7a3532816b48ef94c18e735a0f7a3f@realtek.com>

On 25-07-11 00:11, Ping-Ke Shih wrote:
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > This is needed for AP mode. Otherwise client sees the network, but
> > can't connect to it.
> > 
> > REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
> > init function (__rtw8723x_mac_init), but the value was overwritten
> > from mac table later.
> > 
> > Tables with register values for phy parameters initialization are
> > copied from vendor driver usually. When table will be regenerated,
> > manual modifications to it may be lost. To avoid regressions in this
> > case new callback mac_postinit is introduced, that is called after
> > parameters from table are set.
> > 
> > Tested on rtl8723cs, that reuses rtw8703b driver.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> > 
> > Changes in v2:
> >  - introduce mac_postinit callback to avoid changing register tables
> > 
> > Changes in v3:
> >  - merge two patches back together
> >  - remove unused initialization in rtw_mac_postinit
> >  - init unused .mac_postinit fields in drivers with NULL
> > 
> >  drivers/net/wireless/realtek/rtw88/mac.c      | 11 +++++++++++
> >  drivers/net/wireless/realtek/rtw88/mac.h      |  1 +
> >  drivers/net/wireless/realtek/rtw88/main.c     |  6 ++++++
> >  drivers/net/wireless/realtek/rtw88/main.h     |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8723x.c |  9 ++++++++-
> >  drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++++
> >  drivers/net/wireless/realtek/rtw88/rtw8812a.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8814a.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8821a.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
> >  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
> >  14 files changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
> > index 011b81c82f3ba..e1ec9aa401fa0 100644
> > --- a/drivers/net/wireless/realtek/rtw88/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> > @@ -1409,3 +1409,14 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
> > 
> >         return 0;
> >  }
> > +
> > +int rtw_mac_postinit(struct rtw_dev *rtwdev)
> > +{
> > +       const struct rtw_chip_info *chip = rtwdev->chip;
> > +       int ret;
> > +
> > +       if (chip->ops->mac_postinit)
> > +               ret = chip->ops->mac_postinit(rtwdev);
> > +
> 
> 'ret' is not used [1].
> 
> Prefer:
> 
> if (!chip->ops->mac_postinit)
>     return 0;
> 
> return chip->ops->mac_postinit(rtwdev);
> 
> [1] http://wifibot.sipsolutions.net/results/981272/14152513/build_clang/stderr
> 

Thanks, sorry I've missed warning.
I'll use CONFIG_WERROR and change my build pipeline, so this will not happen in the future.

-- 
Best regards,
Andrey Skvortsov

