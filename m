Return-Path: <linux-wireless+bounces-6568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13F8AAF50
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E01C2250B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A384127B56;
	Fri, 19 Apr 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doKKNFpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3953622
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533367; cv=none; b=UPu1bkxPDV5FO+IvWLve8AiT/xYrQt9kAFcQ3ZcHfaX7S7Px4Pdx1y3/AtQ1MdNG7mHEtjN2Hrnr0u7uC3dfP6shdmfsvD7qCEZVZBy9IINRuNDN2JVsMAkHOLs+KTZunkKmG/RakimiNcp6rE6NQTsqYbgO4M7rpdgMunm4ono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533367; c=relaxed/simple;
	bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJLjjIzKQ71OOQ3b3Dtvoepb9o6vlZhxnRm0j5FPwpYk/3q2kiUzFuQqqygLzm0SRTqMsOcRwZPNKHo3hZs/Q+ulJCAhHdsovDt65wmCqh5F39S2TnMXJ+g70eg4F7mJHKFrWL+OspZApgWFuCJzRNxxEzStXzlvwVXIXi96y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doKKNFpX; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61816fc256dso19337777b3.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713533365; x=1714138165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
        b=doKKNFpXWbFPX9Hk7DLkM9Zs03XuC/xLc1N2FAiVqVzFml+x+GA0Sd57E747W7pqXs
         8hg6JSR6s1ii8m5DeiT/LCpPNsZfJLHxHOB7AF8QBNhBgXlz2AxnQm1MOWpOnSFndsIj
         hB8tgllVCjXxje8dv2cBH9Qc9agmXUjz0Z/JxDmzolY+9YUhrXEwbbbtLxcDwBHiAHto
         O0ZRcbrAlifHDC9X685pTo38FLoFL7BjR92BLEZDcGTnpJzfPso7G9BKB0Blbf1zOANY
         6EankST9bH1KDEr6mO3Tb3cq8TIDpXI0oraRwCbo1yM3y4i4mTUITjqXkybYPRld/Gu0
         d9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533365; x=1714138165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JAiJ5Etf3MuJKuNZBjkja2+rCHW1cnBdM4LUduqTKQ=;
        b=bsaXB/+Vnma/X4R5yxAmj7nGgDBMPl8dShMjiRszvAX7JhRQ4mt7Hwq2Q5u4hUua1I
         MdRjePiQAp8bjIvcY9BjHAC4QInBuw3ycTO3+TgnO8LHBTw6u9AKNwJ1iJV6vrDYJa+j
         Azn3jerNKDEPMPoucegDTYln4utJXO1xkj+fhkv4sXD+Mm9aI4YRYd/7oLwbelAaW/EQ
         ytVvyWSCCjorV3osT/iaCrIf3eTgZVMq1YmbrMNClrysacYBZGzkAiW7u8Q6ysK1AeGC
         80P9tpJSTpWV5b7G5oejhZMK5B0gYfF3cyo3XnHsM3ymhHi38eA3mMQPszY2c8rCbn13
         gmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFC4irPGhCKCDi33hdJRZwcVMhFLdGDic3gTpzempQz0yR4bcBbZ6oUoBMZM9Q328dSmJ2PLOUXHkMidz4I2WAaj84rtnqZPqlESLBxlM=
X-Gm-Message-State: AOJu0YytCwrirTgPi+IIKbZ8qR8AcBpSrLOYnrmFjOYU+7NgEPJRNOtW
	VcfNwbJtuj2bkN71bUONqRArjwqoVOeGp66ULukNlSFJXmyEu6i2iKCj4+GexF+MuZSTCn9Smc2
	MXTdkbpkn/NZ3FCa7/+mNQNie3j+kpWcylvW5bQ==
X-Google-Smtp-Source: AGHT+IFgMs/8AHU4XdiOhdZmmG+AX6lMDzgX2zHpudUuHQbXt36lKVWz9la2Pxkh/EmTXCCM3Oc22brh0qqFa3E8lKQ=
X-Received: by 2002:a25:86c7:0:b0:de0:d45f:7c5 with SMTP id
 y7-20020a2586c7000000b00de0d45f07c5mr1937027ybm.20.1713533364785; Fri, 19 Apr
 2024 06:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
 <Zh6FkejXcwBTAqIR@smile.fi.intel.com> <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
 <Zh-MMAjf6hhNOCpL@smile.fi.intel.com> <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
In-Reply-To: <CAMRc=MfJdfwP7=a3govCcj8XHR7uPwCf2BA+BiWqif74pW5u8A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:29:13 +0200
Message-ID: <CACRpkdYHuw1K1VYbTH3YzvmZevt_whNsd1ce58wCSd1+B1np5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Unfortunately my TODO list runneth over. :(

When in situations like this, patch the objective into
drivers/gpio/TODO so others can pick it up, that's why
I created the file, and it has actually helped a bit!

IMO you don't even need to send edits to this file for
review, it's just a work document. Just edit and commit
it in your tree.

Yours,
Linus Walleij

