Return-Path: <linux-wireless+bounces-17834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9051FA193D7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 15:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747473A4BDD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC82213E7E;
	Wed, 22 Jan 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFNZZX7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB7213E6C
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555961; cv=none; b=Who732UvsJ41fTnaDKqsYLADnFjxDqNzj227yCdDcifF27/2xdSCuDhnHMjcIJ13xFjBWLtm/JsTy8Zk28BnektILEuYw0p/DlhI9s8Coqta3EXcOC8QLks4fHHkJx2kajLWm3aP/3udsU0+6yhBNL6YYRAB+yKeYNlAA7ayDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555961; c=relaxed/simple;
	bh=GEYuyepDvJQHU0OWuSJuMUwOHkFF3mnkFbzu1MzrkVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bnjnk/Dk9FEvw/8DBI4rPyrI9E3yAsROyRVAm55JZSVC1G3CkmtdD2TbyB7Ze7azsKN9CP683v/91yqSFevapU3jE7cLqD7LGx5CIZxwBl2OfLyAs7SRwKI+26kcvBDkp/3hKfsYUAsU1q5fCYtvNQhif4J8J17WHMg4UrBg/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFNZZX7q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso13792007a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737555958; x=1738160758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNFpBQrbXGtkVcHia3dRz+MrUcEY8+3C3sC1yHl5hb0=;
        b=ZFNZZX7qxZflbBBhFqVtpjurA3ZwJnGwohJN+pgZF48wnpZeE0B+QREgU95IcXGbdb
         bGIVhFep85j5KT+NQH0lhU+brhT5IGWRgBcwnxxgEHzXVLkMww806P2sXFwHUyjcV9zE
         nruS7TyybWorVdNsvW/xtt5mghNzcH8UU2LKZvgeIzEN1E3YohnuqFvyr3K3wzFBACC2
         x/NIhcp6QRCD7c5+lpoRDT1B3ZApjdA13DoD3uSpeEgCGo98DwfORYDLna7OB55nH8Te
         CluaGq9y56V6PUu68cXNW+IR/+BMPgT6MLyaXaiQZZ15+1SZmUjIsLKUWivKb3e1cYY1
         hBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555958; x=1738160758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNFpBQrbXGtkVcHia3dRz+MrUcEY8+3C3sC1yHl5hb0=;
        b=supRytWaMAVuQpxjL1b9VrhGkjG5La0ZcgRl7sclwtTLLcGUzMHVXdN07hy6hjf22L
         J4vXn3PjsaawHrRu9IDEH55jxTDYkIlxq0MhbcofcXGI1vzkvecXiZi8SXzmKqB1hTjm
         iepEtMuEdo4oj1ixl+TMB/dBlSehk3jKhkxSXLigZ0zKe/4978yVA3xrX8tz0JRanH3g
         CdykQwdqfQpbhKpAObmRgsl5m/T1rU54olr5zGSfcaOk9wrWdyC4m17U96KJcSpnaoVv
         oRhCVDLySBqXYvpr1mEKqnNpI42IhjLKm3qfQRAqhg3M1HFiR9OL34ckmiIg8DBOKPgv
         C6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwYplormR1x2ZOv10R1avcQmZwnR7TjIAEKXpntUyJM2J2pzXvXI/9on6T4XmKIaUGBcojK7+3fWlqxEwH8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhtBQyLRlp/BdUcIqngyAlF3stt2vEMh2ym2gw9H5OmbhJv4F
	IKGpWrGKsaHrI3WXCA1XTkkXDRHA9iC5RccHAfyVVGuRetG8/Vx6BNj8lYPVMp3zK9PfUIcXPMc
	8KTZmoYqeCpnvTs8qFkN0ZXHfVwEU0tQ0le0p
X-Gm-Gg: ASbGnctOlMFsu97dX8EKTc7MVPBVw73TdVix868MKMCEyiomee/rYBNWyWNtOlO3C6P
	IXb6DZL8uY6ycoutlIHNrVCZwj5qRpJL9cKEunQvplif/VqhMiw==
X-Google-Smtp-Source: AGHT+IGLj09hPWquIkHf/8XvlFlW6u8BwJooHo+rNadAxyJbAgr4lSTmg6M5BlydW4dOT9HY5LI9UOuF4zQQ2zuC8qE=
X-Received: by 2002:a05:6402:845:b0:5d0:cd85:a0fe with SMTP id
 4fb4d7f45d1cf-5db7d339cdamr17143671a12.25.1737555957905; Wed, 22 Jan 2025
 06:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-8-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-8-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 15:25:46 +0100
X-Gm-Features: AbW1kvZEXl79pX3ie6fM6gX6tiqbCd0h20U2xFVpkxnAkTIZANzisq266OJ5J8A
Message-ID: <CANn89i+n4bpxUXMOiYdFa57SATCreum+XQAd8DtkLOFpic0a=A@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] wifi: mt76: move napi_enable() from under BH
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	quan.zhou@mediatek.com, johannes.berg@intel.com, emmanuel.grumbach@intel.com, 
	leitao@debian.org, mingyen.hsieh@mediatek.com, leon.yen@mediatek.com, 
	deren.wu@mediatek.com, chui-hao.chiu@mediatek.com, kuniyu@amazon.com, 
	romieu@fr.zoreil.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> mt76 does a lot of:
>
>   local_bh_disable();
>   napi_enable(...napi);
>   napi_schedule(...napi);
>   local_bh_enable();
>
> local_bh_disable() is not a real lock, its most likely taken
> because napi_schedule() requires it. napi_enable() needs
> to take a mutex, so move it from under the BH protection.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

napi_schedule() can run from arbitrary contexts though...

BH protection seems strange to me, but this is orthogonal to your fix.

