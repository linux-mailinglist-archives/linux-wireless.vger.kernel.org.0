Return-Path: <linux-wireless+bounces-12977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34A97C04D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E9F1C21057
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FF1C9EAB;
	Wed, 18 Sep 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj02ZxUN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D671C9848;
	Wed, 18 Sep 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686580; cv=none; b=OsDnfX40d/OD0v3nc156LkvX/3zJZefKXHMmVlqEqHLIPT+0WHSv+lOtCcopdSISCI9k9vf+LI9srz8+uq0AT79nIacHpruSrZu6tMvLlydPct0jaNe0XvZyMbc+vM8SO+c5NtXerb8X1hSeMRd2CKZvJHQloRTYQK+DEjjoNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686580; c=relaxed/simple;
	bh=QPpFx0Q3zKnneD2ii8FC7UChFgp+otrhwFBO4M1w0U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrByxp7iHkdSXlIEvF2Xebm9XqVi6JHsuF4sXPygiYm8eJ8rp/b7Q3li/bxHcMmEUxmzBPjbcmlRWgl6NNIcSPUFcDa93OSPX6kHmod6YK2H3NdfomymxvUDO5W8U4O4g7Zgb7FabNoXL09NietnfxcGZMZWdy0Yc49zMV93pgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj02ZxUN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365a9574b6so47775e87.1;
        Wed, 18 Sep 2024 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726686576; x=1727291376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVtVjN7ESleHAw6Xqn4v8byziIaTNLaTeqcfWiwPJ1Q=;
        b=Sj02ZxUNdW0Rl82JOCNaiSx/cNXaokvjf2dYYoLVh8wNrqJBDi79r39J+nheuhWLYW
         /DQ9YmI1FbepihCLZ/LoOwmy4Dc638gCsbB0nVgoo95NG/JivizmSMF0bTW05IeFp6cA
         eq2Bx1CrThZeqrxIIVI91rOtK8LJIQK1Q+FUr/bQZaLjwIX9krGgzh6Yz/cg/YnkQYvY
         phiiXhvV4fVtliOUaoDAS/WF2K6QvhV/LQy52+Mhp4OS/dKIA26ZPCUb0Cdx9eUV57NN
         OOrD2Sg8m7HHomxmlAM3Qs3KwfxBx0GEPgC71QcFjQn2C2UMZkl3r+BlhESmbCBmjFDh
         +Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686576; x=1727291376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVtVjN7ESleHAw6Xqn4v8byziIaTNLaTeqcfWiwPJ1Q=;
        b=qZZw9x1cG6o/xuPdBYDha9meVF7smgjIJMtM+qsnw4mEEoFNs8VGVjL280KOHTgIz3
         Od9cwHyNdTxt0e+kEyudnVQrxrEsRymKkKvc+BOaEPrsCqIusf+s6gPcxEZ2fx7aTLzJ
         0x5Yce0ZIkqFxp8CUfsJE1ulSQ+CNkVce+xx+ZrsVGvHBcwbNeIMDHNPTs4tcNmZgIxV
         OjUBbT3P2t2VFBKhM2wY/eymjNM8UoA+6niKJ2/cUqljOzXe1ea4OxDQwmy2jKUqFsmI
         vIOVGyglglUnK0Sf3J6jgCHUOEPp/wmj/iKXfg4G+SUCHftZ0V4nT8TxFdW0rucxrdDn
         GLBg==
X-Forwarded-Encrypted: i=1; AJvYcCWedwAtIWCAyJfS1EjLMcbt8SZpLTQmaE2XgVeJCG4rLuBUh8TgTfKXCOuml30AY1ZXRTTETuIgQ/wZvWNrfow=@vger.kernel.org, AJvYcCWqnezn7G54mL8gy/FgGkuUlYnoLbR2FNJXGxhvqmHLvaxcYFecWpd+GzEux2e8vs0dRdW0LIkABiccr1aRt5Q=@vger.kernel.org, AJvYcCX4Hi5jiTn32didp/XP7pxuIVW5Efqzx1ryfnwqafpYU48av0FMm/QspCxZ8jmbLSKS4QSJcXrJHiBVEqaQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0lXasxGeSSMAOAs/ULdKYEagPm4FmXj9Leuvn9Rn3ErhStQf
	dp7s9JDcljTfLuDbmS8F0Ymxh1ykGPmeYRJ2vTX8VoV7q4MovyZl
X-Google-Smtp-Source: AGHT+IH4UUvSM6UbmwH34UJUS7NKgR1HZ30Q5WoW8wpvn/NMYyaAkRUvTTcGy8eMHUJH3StbRfSFaw==
X-Received: by 2002:a05:6512:238b:b0:52e:932d:88ab with SMTP id 2adb3069b0e04-5367fee25a8mr15659135e87.23.1726686576008;
        Wed, 18 Sep 2024 12:09:36 -0700 (PDT)
Received: from void.void ([37.46.46.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330d48sm621347066b.207.2024.09.18.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:09:35 -0700 (PDT)
Date: Wed, 18 Sep 2024 22:09:32 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Loic Poulain <loic.poulain@linaro.org>, wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] wifi: wcn36xx: fix a typo
Message-ID: <ZuslbC6xlP_fUFfi@void.void>
References: <20240913094319.13718-1-algonell@gmail.com>
 <172667909414.4089263.7060582994040911136.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172667909414.4089263.7060582994040911136.kvalo@kernel.org>

On Wed, Sep 18, 2024 at 05:04:55PM +0000, Kalle Valo wrote:
> Andrew Kreimer <algonell@gmail.com> wrote:
> 
> > Fix a typo in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> The subject should be unique so in the pending branch I changed it to:
> 
Thank you.

> wifi: wcn36xx: fix a typo in struct wcn36xx_sta documentation
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240913094319.13718-1-algonell@gmail.com/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> https://docs.kernel.org/process/submitting-patches.html
> 

