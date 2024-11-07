Return-Path: <linux-wireless+bounces-15056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C749C025A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 11:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E5283F08
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE771EC01C;
	Thu,  7 Nov 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWGkMPNy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B81EE015
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975304; cv=none; b=TBOEh+sfe6W7mtYRK/xn28L0KkjXYtIkvFnEv85nfVez0vsVJRG/HborP7PYFRcUVyazAmQ0TifuvO7rJ3N1gfAGyB9w8AfBxQQiq81jWtQTAO0OLzxas7wDP0LTJt0DSVwHHFeZhI0dpJDMt0zFzXTayb7cufuSYyLo+1q5qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975304; c=relaxed/simple;
	bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKfg3T4Y80tVQBmPpeNBrqHcOxltUVPvfIJcISiewu648rXQJSDsfDBo4SO9RnqL8WAKtULWLvyl8PGvPlnTuZznWSbeH21r/bhMvPvys6vdF/9FFbdTiFFGhASHk/hjrj5Z/txa+f9gHqruCG7LP/BdYfcJQe+qyKI/a9jL3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWGkMPNy; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc5b4190eso387423eaf.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730975302; x=1731580102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
        b=IWGkMPNyTPtr2/xbW2b9E0AGBASrOFT/hZl6RzCkEBgS8d2AtBCD4/6v97ltX9LUXO
         TgNscLBvqyFeRhbM40xoDZhDc5LXcHOq+NBsO35pSj8jzguF0OD09AtobrUT/CRrCjGp
         pNeU+2QPjK0zaSklHNLVJy4wBNP23wpvITZeJqRWFggQRjBoK9OI8sfjV8A+vgHDufpZ
         22ywpeLFF87znVQAXdvv3+Lf1ZJkv9LiySyUhgeAyfVrlqvVkwXOeltDTGRxKCzexP5/
         5ay4TPxVDnfKG0Z4fkxEbhc90pPwztv9DNWRtKC1Ha+0e8gD0WImF11uY6DQf5mEpabE
         N7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975302; x=1731580102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPW4RQP7ib3AAsmmMOe3wNgaOxasplolWrA9JBpP+Fg=;
        b=BYjBqoVpDJRuiiAWQcl2xDliFvOdQWEtQ33cjUsSt3F5q3qX/QyuiPy/PKt9m0x2lu
         yLtToTEhoKTWhHJeALg5huBmaVmbaGQ6z6bHv6bxUeQLMiE198XkWFWbsJubEABWkSWL
         8zmTW8rGDyE+CLNM0vheIHL4zOW825I33gKoLAMm8mFtiFh5mqOiuNGXRyqCuw7HPL3/
         i3h6JvgkNvIBfXeHlI9iwliGkZEBHR0P7y6Z+JnG3RZYnaZOLXvf+YGZNxWJYN7Ar9d2
         GhKK2ypRPc9Cy4oukmY+Of/N+oSh3cp6r+/5N2F/V0kx2sBLgxeGEepQLacJug4dcnhz
         PDqg==
X-Forwarded-Encrypted: i=1; AJvYcCVWNyuwmtCp7ZjYVmkDdBF1/mReg2Bd2n+KjdP5gTe3v3CdebOfyLFAQNj3kdmTARhENY0N135WB1ixhLFE2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aSeKjSdemlkgp/kzE+BdyP4Ddw9eRR39B+kuOSXSbUAF8D3u
	t8EDB6SuIAQ7lqse43NwWlmsWJxQLkJ2yG0Z3u82GutRFWoXgoW2FQPZ4q+/mtsCyQYBKUEC1UG
	ZVXEIKZhK+Mf3dtPdMtn0nCCZn1tQ1Khxz8Zxbg==
X-Google-Smtp-Source: AGHT+IFMKnoCwjkJOKUaR+JuoWoKm+qaHvhzoPAEmFGwh8CvhPiJdL6CFrkZE6oR1vfLCGTQ5HTejc7OEk/6lvThH0w=
X-Received: by 2002:a05:6820:99c:b0:5eb:fc8c:46ad with SMTP id
 006d021491bc7-5ee4ed7aea9mr564587eaf.0.1730975302375; Thu, 07 Nov 2024
 02:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
In-Reply-To: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 7 Nov 2024 11:27:46 +0100
Message-ID: <CAMZdPi_-uH6dk8KcrPRzNGJjX6YjkoNsYM1EJKJu5BYzrhd8gg@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: fix channel survey memory allocation size
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Kalle Valo <kvalo@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Kalle Valo <quic_kvalo@quicinc.com>, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Nov 2024 at 21:00, Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:
>
> KASAN reported a memory allocation issue in wcn->chan_survey
> due to incorrect size calculation.
> This commit uses kcalloc to allocate memory for wcn->chan_survey,
> ensuring proper initialization and preventing the use of uninitialized
> values when there are no frames on the channel.
>
> Fixes: 29696e0aa413 ("wcn36xx: Track SNR and RSSI for each RX frame")
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Acked-by: Loic Poulain <loic.poulain@linaro.org>

