Return-Path: <linux-wireless+bounces-27809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B1BB8EA1
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159C7189DDB3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BA212546;
	Sat,  4 Oct 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K3G0EyBS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34A40855
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587544; cv=none; b=XKDSN38K0HK+vnraphnB+R5/9aU8IbCJviK8+QtfkpaZ3Syg/fpJwoZ03UypP4myQwARJEjQ3PXA/zPUaEOx1BLUYrPxwEcQX+3ecHlbpwuT2CEyUqAeQEP522GX298zG1FlazpMh3EBTvSo0jkdGV5BwHlUODLfBpwCY4Pr8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587544; c=relaxed/simple;
	bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2WXoBJwlAumHLz+qQZMNgTsI9mYas/jO2tlXvLIOtndMwA1hLXgCRVyNF9aci+7U8atq2IUNMnmoTh2W7Y7fJ5ctPL8x6rGZvy8LpuMKoTxJJRhvgb5O6+XYHgSa9JM16Q5sjibUtVOMZs5vY79M0//kcgzna6S6ny2KCA2teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K3G0EyBS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-373a5376d0bso33237611fa.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759587541; x=1760192341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
        b=K3G0EyBSwWHx1iAfcC6afwTtsP2B6M9yC+qZtrjR7pukrDoofASiGwa4fL5oVTXk4a
         heVPlqQpKhPXEmGnGW8hYITnle7Zs6XQ+VXGcmlHLnwMGjmN1e/lr9Pkc8dy0oMVAnyZ
         oisKcfyY3wwinAlsfGiZvK2ScCN+o7ZbqNkOMWjBIwwPoco4I+k7w59gZ1PnkwSRjzHf
         qTkdbTfKyCSghmLAt02qHHfT0tYlR+3VPgYsbe9K7kS7iiDam0wwon9p9IEbCMnJ7wiH
         UrlsR96FCtog3GeHPELoibwT8arYilnfP+kn8FnrYASKCUxLPQYwWVwV+Qyh7gMZQoee
         C/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759587541; x=1760192341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
        b=w0RLDHvOZNlfCUGLtp2+0g/vxMzGm1jsOSq/c0/GT/1u4150+hJnEq0xvTMl51GFCK
         wnuWhEdjqHbZCGwGoub9VAiNWstAW0pDXZdEmyt4flHklWw/mwOnjPqgcgKzlSt/Yii+
         f3/J65UBZ2k+vU5r2CNF7xFKZGCbDniJWBjy3WlGp3mNJOQDe8GgyeQdmI3QMxFxt3WG
         Tuks+GN53VlVocjh4hoDlCFTnaEguuSARLLmImJUGwYNbVlBjYQ3VUokI2kEvrFt7iWy
         G0u9TqoTUcqcJgWXbGwycaS9F3WNLkGKNR8jXHVeQE7hSDFvGB8/x5iKk45JMZDi/jNF
         ZUSA==
X-Gm-Message-State: AOJu0YwYgTNzlEmOkzyM13UoG4U8uUlOztN+mtaFqSRsoTpz048ETFcc
	MIkZqfpQF5ZWh+FPYRqHa3gZEXVRUBtdcUiLno9ahtwXjVPbofjXFtbxxBHIyBVvojJteNC1pCe
	TlKW7lD30ri+aw2XP3IzJUfjHxqn2/Y3B/r/BwlctrQ==
X-Gm-Gg: ASbGncueeOYcTw2R715uhVVrBoY5oQpLyfjv0tKzR4IKi4pJa1hSCePhyky6xV7Ps1c
	fGZHSFiMeXe0jg+U4Dy61bvfbNRsjF0y925zesDF32cgiWX0h0svw8meP1eXTnrtTQqsoxKg2u0
	mdIZcxZa4mdpAN/miOEExFdGWyF9tJabbFMl6GRhj3+LN+x8qWigyyE9gCmEyhtdcBi76eUJkJZ
	4zXFWzfBrC7VXG6NYItHZ6Na5Hm4peRGTalrUVG/MnSOn/q6XAga6TapHV1cDX00e+FC3Igdgoq
	akKCoX0y
X-Google-Smtp-Source: AGHT+IFxJhujf/JEJFinAISvCYQxGDap6lxZLW3dvJRDEoihGAkLv91WxlPHii/cSibBOV6XplK8oqH8DyeoFN75R/k=
X-Received: by 2002:a05:651c:a11:b0:372:88fa:b680 with SMTP id
 38308e7fff4ca-374c384e15amr18469051fa.29.1759587540893; Sat, 04 Oct 2025
 07:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl>
In-Reply-To: <20251004141539.6512-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 4 Oct 2025 16:18:49 +0200
X-Gm-Features: AS18NWA7nwSBIvK3ZCwEcd_HigJdxeufjWRzlxAnyotRQRzHX-B4cb1IwxlUYaw
Message-ID: <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilan Peer <ilan.peer@intel.com>, 
	Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 4:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This reverts commit e3fd06d1d8869747e02a022e3c9045a3187f3aa5 as it broke
> wifi on my Thinkpad P1 (Intel AX210) in v6.17. I don't have a better idea
> than reverting as - contrary to what the commit message claims - this
> chip seems to still be using the commands removed by this commit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

And here's the kernel log: https://pastebin.com/zrTPbE0j

Bartosz

