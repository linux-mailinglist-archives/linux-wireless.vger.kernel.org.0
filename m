Return-Path: <linux-wireless+bounces-25141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC71AFF49D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 00:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3D4E2443
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D83243399;
	Wed,  9 Jul 2025 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjDF+iHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82934801;
	Wed,  9 Jul 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099801; cv=none; b=nqtMaGEEzrM9aYNFOn9teclTXP9QmR5vTbuUFO4luxFjCohTkylCdudSzesIFCiKrBUaxCVe72Gw82LewK4CkulkVUFc/ovq0ttR2uJ31i9c5MbeSvNWsZhasnA9bo3DWnpsN2pG8hJM/lRiY4ICA4oJC5n7kkS3FQiReRD7p0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099801; c=relaxed/simple;
	bh=24abscj+2i0/x8q5F6sm4ALzwy1Yuq8FqxkeCqDKPvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCtAnInleMHJH6fjfygdV2xItB0NLTUFfhIQ3MQ6oV5T2A8Ra6ZQTK8w0/YUdT69ZaML9wEESwsY2hAg68odJaGtTtuYzFNuGGaQ0e9P/BWe6zogLuUFe60HNCO02BSVhl7eauR+DApEoAtuMtGQa7nzib+UX/5yECPkuTiLai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjDF+iHZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso325647e87.0;
        Wed, 09 Jul 2025 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099795; x=1752704595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAjCWrXsEExfgLvwmihVAXrAcyRTsmUgAr/4yGrIjDM=;
        b=GjDF+iHZyRQNDR8NTzVbK3q+lzJ8bBcMNCzxjFsdWAtN/RChv9ivrEoxCdg/uXj5pj
         TUhNA4isS755DrXAN9Vr3ROxnYtazDNg0lXR7cFG4l7lOpfT2qwHenBkm5gCoX3K9CzE
         /pYee++yx6blBVsi0sl8PK6vspfNJl9pv6YqpBTgwSnBfDGsLhdhNPWhBV3crgBGmDn9
         MYmsB3daJTbwQNeEdOj85imB0ddnbfD7ly5JUDRkPlkoAglUz0nLX4SvFDqrrKYsTdv+
         /BZxWuWC9tVUzN9/0mmlOHCUIPlNUZC/jqA/WLZ5f/rd/x2XyR3qJBgIWwNRC+FcYjA/
         n+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099795; x=1752704595;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAjCWrXsEExfgLvwmihVAXrAcyRTsmUgAr/4yGrIjDM=;
        b=OcFxvemLaZmUuiaAf4MDsANp3kmlwv/eu8u85e5bc9s5zgPzXvGEpixCnu8UUvP+B/
         ocYBxpSplQUxIdr22ur84T79u0Ow83z2jwttmkyXRbQB6Hnbq7U777kyUwsZvl5wLtzz
         aRxsOqc+WVZ3lUcfQRP+lVVDQotY/pivRAhLb5P9vtSr0uZrTZ1e+3APuxaSgqEK2EgY
         3McG2oVIWSx/fU4O4AvFdlCcngTIZJNOm4Gx75gNkLQc2Eqk2VUSgKy6HShq+L1JwWca
         v28xfLt5KauX1ZVXbfbIdGcUDs1uP/sE67t4nqrzeE8Bky55atmbUKUbZiP8IOIJjTVj
         En3w==
X-Forwarded-Encrypted: i=1; AJvYcCVEJHuCkiPmglDJGdHsX1kEhV2O5bN2pAQi0e5PTwtyOsSzCYJ2TCdGxWx5R9fZdygEV9mF6U6P5Aijxyw=@vger.kernel.org, AJvYcCVvayM0o9TSQPB1q9MPonCrqUQFG9J9WzXrvbIrnvNQlx/F1p19YsGaSJqnhor3nyIlMw+ZHfddgOoiEsI4mTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4sxw2836UYmbe06rltD7mbTxSwHkZDZmbfRQQL+mPfRmnpaE
	ylrp6EakliVyghJMQFYG/BWN83JW0g4xE8lHp3fj3hOa69a1RDZeHNNF
X-Gm-Gg: ASbGnctljdKuhcSdVwnKi9yv9lJ52OTa6wZutfPRsIDxwo3eK6VoA+XZbq24v297q2f
	Bi+sYGeu1qPYLflp2c0tTvBbA1x1EAvQp+1Ym/v3Ce41uo3niSdm9JZCHZNFDH9IOn7Hslc1N8d
	MPFsVcMgfExZtBM5XTXH70MvR+0nf6MlPQSQFSvVR8D86le9V+ZM2s/qvNHMi8YZRtT0NWHXYBR
	9l4n/Plz4xxKZQTuOpsB33RyN+mlcNbqRfXsWJY3Y1PurMqRzMcIKB4xulmmBImhff0WFO+WS/3
	cS2LqoA/H/igj2ykgdyVmJYE8P3+yP7TW3stv5/VVRdp/4Cdz+zb3IM+Qoh+o/MuK7U=
X-Google-Smtp-Source: AGHT+IGjAqkTuDqUOw0tCaorkdTiv3r6cliFcRPETFVSCXAth56x1yOq9aCfBsrHaxyKWZwnPb36kQ==
X-Received: by 2002:a05:6512:3050:b0:553:25f4:695c with SMTP id 2adb3069b0e04-55935b42d54mr112318e87.50.1752099795229;
        Wed, 09 Jul 2025 15:23:15 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5593c7f3522sm52588e87.87.2025.07.09.15.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:23:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 01:20:59 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH] wifi: rtw88: enable TX reports for the management queue
Message-ID: <aG7rSzyOWqIWMSII@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
References: <20250628223048.3597641-1-andrej.skvortzov@gmail.com>
 <dbd7eee63629497194901210c46bd704@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbd7eee63629497194901210c46bd704@realtek.com>

On 25-06-30 01:51, Ping-Ke Shih wrote:
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > This is needed for AP mode. Otherwise client sees the network, but
> > can't connect to it.
> > 
> > REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
> > init function (__rtw8723x_mac_init), but the value was overwritten
> > from mac table later.
> 
> Since the tables were copied from vendor driver, I suspect people might
> overwrite the tables again resulting in regression. 
> 
> So we can add a mac_post_init to set the value after loading parameters:
> 
>   rtw_mac_init(rtwdev); // not set REG_FWHW_TXQ_CTRL+1 to WLAN_TXQ_RPT_EN
> 
>   chip->ops->phy_set_param(rtwdev); // "0x421, 0x0000000F," by table
> 
>   rtw_mac_postinit(rtwdev); // set REG_FWHW_TXQ_CTRL+1 to WLAN_TXQ_RPT_EN 
> 
> Only rtw8703b/rtw8723d implement postinit ops.
> 

Thanks for the feedback, I'll add this in v2.

-- 
Best regards,
Andrey Skvortsov

