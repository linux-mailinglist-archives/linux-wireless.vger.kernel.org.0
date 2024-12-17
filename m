Return-Path: <linux-wireless+bounces-16478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2A9F4E48
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6897A4333
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7331F542F;
	Tue, 17 Dec 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmRcvJa3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60981F7069
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446996; cv=none; b=urZt2ZEXoxV+6sbObiGPPuF+tRiEFDga3BhYVEb9kVN01jF+H7rHOsf8r66EFkPPHxw7Li9QfR33k2i+56hWcnIHeGtNCqAojRK4kWO3VuV1r3wzwS7ex4q3tAYX1hwK0LEt13E7Q3/PihAjLGSI9T1ttRgUu2KUB/WcyLV0pVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446996; c=relaxed/simple;
	bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUAqUya+94i9mjEHWYFnwkSwD145YQxwD4elBn01m+pUk+39TxWNrm1aeR0lgQHU2O6OyXQUSfz2dHBAo+wQn9NmGruBxNy5/q8X6RdqKV8V/KFPbOhA8XJNNvQMWxvH3THx5t43cOHVkV/BXCgx5n3bu/3jkKqCw1y9ZGhrjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmRcvJa3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3002c324e7eso60736861fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 06:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734446993; x=1735051793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
        b=xmRcvJa3WEHNTJQ6jFS4QaCDGSfFDW8fKu9wpiKn9CApLpdUBp+Rbm/KGM4DuWYhTq
         OEuwFpZVK5Tk7sDAhKoa0wWBWz11/wvbMvsuFj4yx5jZSz+UTox+vNFx3G8cX5GCnA3U
         fQ7dHP392ecZJ5O3L39k+CuqrjXmfxnLKpdV+tTPWc3IR1kcQ5TLU8NY/Yw6IMK1OTSl
         w1KayYS4ck4BVF4BWM6gAaioSexXRkmBAJwEiCjaiRCcBgWXXa8rkcB7t1yhzyzm42wi
         xO24YgDWv41ivj+l0zpCYaUPFKUyhmczjhsitwO8ktz5D6IoBVFJtcKCOoqrn+AO3gKZ
         hUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446993; x=1735051793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
        b=vbdzArsKt6OiQHHQiryaRswNwvmbEQNYxwDNoae9qOgSE3ARWyjKoWqmQttkd9FT05
         mxADEzqs0ol7Q8t4IeXXVRIx2UlEfhn7aKZGFnOeI0KO0Ssr1vHBq+QB/3C0cV8KHH2A
         hcTOt97WoAf1ykPdI1QVszT/NZabtvX/pFHoegSv9FByQAIMFYVJ33w2ohYkvshPPnjp
         69wmVlC7TtnjEjfS77F5jfnVjQA5KC4ezqgzWfxNNX5zSWCPzv8DDBIvHWvyvKQg6cRY
         BOEyN/tLPfipXL5fTShx/rkyZjsStPn9csAXJ+iWU7zLfQrsLfIIafW+7h7BGq1ZqDRl
         iM/g==
X-Gm-Message-State: AOJu0Yyes+B3t48LLYVafFBevpl3c/oJva+k4fU8ZhLFXH3eex9F1oPF
	0PtgHKBNpzsWVJjayn1ScV68QMsW3lKS0v/iEPbinjHfVn+zLcpqdV8/nrm7VY1Afaff/4dts13
	02nHYhx/4apKr5GdLVy8zdUbs1S0vt7HsewPJEg==
X-Gm-Gg: ASbGncti0X1K528YAIi8L2tO5xu2qTBpZZa6emQ2vIt05fFDdS4Dts+YO2j6e+3d+G4
	jB8z21yuzJZDShFyZfC1O3iIYuhq7tcmo5qy5CA==
X-Google-Smtp-Source: AGHT+IEojnvT9hVPC1FrcIjDlzTg/uUCwnVp85Wn55woQaSTaCTEvTkGa6X620K2Ep491Rxn9vhg4tMaL98umVEArAY=
X-Received: by 2002:a05:6512:2314:b0:540:2022:e3b7 with SMTP id
 2adb3069b0e04-54099b71a53mr5065250e87.53.1734446992976; Tue, 17 Dec 2024
 06:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-cw1200-fix-v1-1-911e6b5823ec@linaro.org> <87jzbymldo.fsf@kernel.org>
In-Reply-To: <87jzbymldo.fsf@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:49:41 +0100
Message-ID: <CACRpkdY9RvHKSLcgbncaOoPjzQr4oziwpum-r5QjQxQeTT-JNg@mail.gmail.com>
Subject: Re: [PATCH] wifi: cw1200: Fix potential NULL dereference
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:31=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:

> Linus Walleij <linus.walleij@linaro.org> writes:
>
> > A recent refactoring was identified by static analysis to
> > cause another potential NULL dereference, fix this!
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411271742.Xa7CNVh1-lkp@intel.com/
> > Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> If it's ok for you, I'll add the smatch warning to the commit message:
>
> drivers/net/wireless/st/cw1200/cw1200_spi.c:440 cw1200_spi_disconnect() e=
rror: we previously assumed 'self' could be null (see line 433)

Sure go ahead!

Yours,
Linus Walleij

