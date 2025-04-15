Return-Path: <linux-wireless+bounces-21539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D83A896AE
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E9A1695B6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4092820DB;
	Tue, 15 Apr 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcKoYDLx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063ED284673
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705774; cv=none; b=OL7EpvAoF1YGFmzheGbA4JTFkeMbL/rR2b38L6y4R84jfdLKNhcLTLbZmO2QFghorCrWS2DxIabcfKVAL5qwfUEsSdYuR+Fz0KcnFt23qewArG75BiKnlP/MT7OELUe+vhMivILx5JyJDjQqz4TDEDTYoE1yPVjEZoqf4uUad6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705774; c=relaxed/simple;
	bh=JqF91dZIOXlVj0NeUvRp3kehfD9MyoxzqTqimBqYe6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMnY+dodNiW568kTAgEwTeTkPILR7QUN10MYjMGwGTpEFRJYODGpfIgsQj89cB7jzowD3gC/wsAXv3m5cx1zxP0RqzUScUcdqEdsGMc7GMJdsun32f0XxFC/Qm0dwZ7AwjsK0BKX4wdW6peDhWyveXDgOCrlsuKo1QQI7q6QPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcKoYDLx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfed67e08so51657501fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744705771; x=1745310571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqF91dZIOXlVj0NeUvRp3kehfD9MyoxzqTqimBqYe6Q=;
        b=xcKoYDLxvj3EDKKIoYmqrloJhQUGDIAD4FnRAl+jCsC/9yTvpdYylTMjy2u9pjTZDm
         iJHzKKKpiGezLUik1oYSkGqKlUfuwu+XIynzXRZPFjzPcixRITHxg7KTovOiKmMCqCrp
         7zj4vV6YGkzGG4keXPSmeTlg3DT/DuOclA8fNQKL9ZtW9SvBe0kX3KJAgZlPO5uZ4lpS
         1hdylfNtjy0/LSkfjZUJjbeOdUVDCVoQpS5MwiwNCry5THCEesNNWYq4wCfGL3slEHBz
         3512Mnav27ajcuCqt5TmQo2nQRnMgUFj5c2I/Frf0NooRvo5rmfZLw1mEhUDqecTy2n+
         mWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705771; x=1745310571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqF91dZIOXlVj0NeUvRp3kehfD9MyoxzqTqimBqYe6Q=;
        b=glXedfvmPiQCjwZqPps/J9m61efoEu6IzTXZihRMHVgeGsopCgsr61vZvzKS9EOZHa
         C4XK1Xk3rysRIio9nSpRVJscFtmVcKs52xVr35OxyyeEf4KWGT0vUmCkuJ4bdVdvRIN2
         nMknVmMOpLfKWgCarMSC0e0X961VD1TsnJorDqhUahqJ2gVunAIl0/sIColOdV3uHsrZ
         GJmYJx5b1sIIOQyInQuHyrFcXvjLW45MtHA+LEFxelmJyKgCJlUfbSM2m9HrCeUEkMy8
         k1IXqqwyqtZaKlVHBm23IZfmc5y/O3P15U+aznXNS0JHqu4A3ZFEJUfK5iznHIoSu6Up
         PZWA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Mp2+ogFrU2hqA3mnsITPj7n4XGF67pvuhHmhLWLE8+zQ7wXzCAZqJDUP/kQLbhdunJVvRbsGRetoJmuF4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlzn9sYEnEIajCJTtkLNQkHn2mJiQK3L7rlZmRl4qGXRZw0RUJ
	f+7fa5YKedv814b38Q7yu4BvPrtUZRcbXvSUeY4owpSF/YSrvgf44vmKuYc3/PvqDsTmS4eNkyj
	h63OlKrhOSL6AU5gYf6LVWhkFE5TomC6a4NCjoQ==
X-Gm-Gg: ASbGnct2A7rBJaCjx0hZrtMOegxVSaIfgJ5sH3hY6k7vGlFiqFiZ7QqbcBbdfBt2wXT
	vg5UroF9O5GcEjswL2ctk7aFezJ40fRxjJCwxP2auUXkBjs3dHy1VpeNPTNO78Da0UCCiNVshGq
	5suGfH/3qVY4B2mik3UaMbnQ==
X-Google-Smtp-Source: AGHT+IFjWv4YN2TLRK+8gIXeTMozvedsriPJva3Us+iyvNvjh4tmGiLADPX3P4ddGuJK/i6+QCaKD34pqB7ZlhiSFww=
X-Received: by 2002:a2e:bd08:0:b0:308:e54d:6195 with SMTP id
 38308e7fff4ca-31049a021d6mr45079331fa.24.1744705771136; Tue, 15 Apr 2025
 01:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-gpiochip-set-rv-bcma-v1-1-fa403ad76966@linaro.org>
In-Reply-To: <20250407-gpiochip-set-rv-bcma-v1-1-fa403ad76966@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Apr 2025 10:29:20 +0200
X-Gm-Features: ATxdqUE9g7RM0HJPsiRtWp5uefAcSNQmT280xjEtFgRSUBBli2MK8hnSPFDk1to
Message-ID: <CACRpkdbu01ivd7AX5vn6App2UXbCFMPCMK5FBoJJvHjV52Q5YQ@mail.gmail.com>
Subject: Re: [PATCH] bcma: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:10=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

