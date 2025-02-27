Return-Path: <linux-wireless+bounces-19569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6342A48C7B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 00:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD351660E5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464C2309A3;
	Thu, 27 Feb 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XipCgQP5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2427290C
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697985; cv=none; b=jm06EFVzYNFvq87sxJol4hG0qHdR/VaKqu4o3B9nJh8YiQO+4at+CB/Yp/rZUjI4up7RktVub0cI2CuBTSHlkWGU2xFA+NDyXs0cD4DfDsVCAfjq3cgtgGinFoX9+l2fNfy53ZERyhiKVoAh9Yr8lLgu0iUJ8/G7MjdRVh4xLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697985; c=relaxed/simple;
	bh=VrMyULN9yRhX0362jZvsXqzL/blFpYThDTo1AkO/c30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXnQj/6+gjk+lhz2HGhgnE+UR38dEXQyvq0uVpkhdWbM8EKRVj6haVvHADlTCmo1E+dVg5RPPy4mUagRc57P3ApSGqi8be6P77kTQfjtoDDJz+bJza/iyMa/e/JKbzILsMgMfgBIBSXwzy9RtfplLSyzPyg4F/e6knjp+ylVETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XipCgQP5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30b7f91218cso15290761fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740697981; x=1741302781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=XipCgQP5AMF9HQZrYR98rzjGwiwORxjbfuqc08WQYkF5sJfbva3dXBMA18/bZAYruq
         lYzFIm066i1nKA/I7Wzwj6MRBy+0n/39lK+vm6FC6CVRgGDu7WVqIrB8ipuDCvhsn2zX
         gv0fpICwmOY5QulyxYLrcoOFj5IBGXjw4THDC8H5KzFtAVKQ4BSA0oM7EMfJbsaTTsxD
         VZVNpjtUVnbHGmSynxMcIgz16aEeDQ4C2vuh5WGjDtLxJlH3J37QUF3px8FPH2CV6ejF
         XHzz6NQx80JJCWwT0F7ydmGCbLFt4WTzVd+9gutJtxv6qDO2V0i8yvXAaddp2Q2ZPUFr
         Z/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697981; x=1741302781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=QedSYa4WcLcXFDeHM2E3C0VGusnU4X+p7snChOeX63jCTJCBbvQlRSob0gQTQOfYE/
         C+QxZK9/LZiroQgIOnkHWyJ7aGE6QCUSPAZCOx5rSdj2BMl5sKxyLO2xmxVcQdOh4HiM
         AT43XWYtbEoYwSP6fSc+/c0dth2BqrKTiEsh42cuBU82ObdeYNrBz4uyVcVWKCGzCXuy
         Zy2fzEYqj0AoY8ihhKa/fnEuvypo1YBFI0wTKRGw6FLyYzSJjISr3UheafpAPIRdMn49
         8DMkNvWgIbsA0n1kq1+ddvvhgQMXpMEzfVWnHUjLgGRS/GkTxAj4Yb7tTBUOUtrjS4Jb
         hcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXU+V7a30i86WOWyz3vJolFAYCAlHD3m1vCfUctxN6hnCxPQNd/rHTDO9KWiPGjmrKcyXGO1UQPKODPC6k3dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykBCYY5hFqNCLiTOvDVBia8s4lRW3d9qLWFm7pg65geN3gvKYL
	fOYJe1W+suJ0Ze+bIIpi4Ct8oKBHEmjsmjDMD1/5JlWAUwRVgJa5dcAPKJLYCkvWgtbCyERnk+s
	9AGBujGxZLVppIsoxO65EuJuKHmtk8YatkM6jew==
X-Gm-Gg: ASbGncu+ea5ZDzaV5ezFBEAQZBho5ZB+aeYKq9LhuCmvXsZqSOULmNZs5iXRuRxdPFu
	yyQS7cyhlryA9sNOkXbuFruFp4UySnKBqqvdS2yCnogZwnOOH3wb1OrMn3K4/C3RsdrffqJr4I4
	sSDDYh+60=
X-Google-Smtp-Source: AGHT+IHLcUchRQ5RHejMZKQOgPdGa2RgldlYInULBrGmDbyHiaxGOnJDGcYbTPdwNuvGN5wuzKGCGgT0iWuzwLntJq0=
X-Received: by 2002:ac2:4e0e:0:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-5494c354e58mr578980e87.49.1740697980909; Thu, 27 Feb 2025
 15:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:12:48 +0100
X-Gm-Features: AQ5f1Jra6Y1TNly1NYmSkFPtENvNIwlGHtsux17X3bXg-g3qhlo7h9G9hMQoxr8
Message-ID: <CACRpkdZV4EHGxYrX77FgsZvPrHohCEixXX6dkEoVSYSsaAzbYg@mail.gmail.com>
Subject: Re: [PATCH *-next 15/18] mfd: db8500-prcmu: Remove needless return in
 three void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:

> Remove needless 'return' in the following void APIs:
>
>  prcmu_early_init()
>  prcmu_system_reset()
>  prcmu_modem_reset()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

