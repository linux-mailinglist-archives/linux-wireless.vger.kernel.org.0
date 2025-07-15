Return-Path: <linux-wireless+bounces-25451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C6B054B9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107433AC8F6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374A274B26;
	Tue, 15 Jul 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2MsH4Qv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93509274659;
	Tue, 15 Jul 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567719; cv=none; b=SAJHGOnunBUCZxlvKFitddgCoONmKTMquNUMmfpCIElEz+T0lxot1YLkYox+JvLHZegSrQo3I8QHwTmbGxdvvhvf+0SUCz6PJvG+XWbXP5p/CW2zAF8u0pdoK/syQmbeH1n5gghzHtdnt+7PrveO5Pbu7NKseeIMzN/7BIm/ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567719; c=relaxed/simple;
	bh=vW9p0alo/dC71JoIr875PRUYUG4vkxx/6o2dNKhrxvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AELzrSWsBk1o4CZUBCTSuIXOQ5MROBpRkHsN+KBfINDq7TrV9eClJ++wfa5QEMLSQE0tVf+ICJ6SFafncdW2nrXPPWwTHF6hV9faqnUuF1dXMGxnyrKnZ/Cz9Peeag9R4qZD0b448H1/ojqI5uCNyxFhkG9pDWWocmq3p/G/oAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2MsH4Qv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso5564308a12.2;
        Tue, 15 Jul 2025 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567717; x=1753172517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hNgW4kby0iU/XtbfyNGjM7Ij3cEWeDVAVgxTdH2+aQ=;
        b=O2MsH4QviyQWMDvzOCj1NlACMtpe5PUN9A6EuNg9IxTyLT0bxN/Wh8Oxn0GWVCVXCM
         CZk60OPfJ08UsRJfNjBwvnugtPZoU4nZWRDAGXw6Bi82WEys4HlYwNI8dB7qb2bu42Qu
         IywD8KM/9etjZJGZhFgAJjQmr0sXpaYuzBdnQw27ImPNLMUUVpCnX2ic2cEFV3ApoiOh
         abPacW1ZDGJCrn4OxUy8EuRdGEEGvjlFiUd4ighY+rmSGqLAn92eCc1c5Pc/udXAecex
         TYiFWqqk1L5vaXmKzNFoJpCnk1iN1zKRt2pjHliiOc74qnFRDK7BWGLgWXjnf0YpmWQy
         vHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567717; x=1753172517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hNgW4kby0iU/XtbfyNGjM7Ij3cEWeDVAVgxTdH2+aQ=;
        b=g240DaP0v2YDiNnIg/DcZjrhTE1LQP40db/pc45IW0hO3WLTbRpW0MEdkiYQgI7QL+
         Q3DSeS5WthVLn9HQAO9PsEHISiIs03Q11fPkLM8fXCPb4PQUmdXkc/2964rI+3uXJ2u1
         KWF/7vF/HK73jf/KYunCLCcK/8olw2AclPgKKQBefZARRLN85Ben/AK19XtxuS/o2Kio
         sDoMK5pnRj5GbOTRi07vj5nHhbNVRcFbBzCiJZZNi3Or28W77B4mQXDqGg7U3okqS4/v
         2CdqYR+U3aZQw4Ww8DfynLvoPHl/15N+hCCHuLOoUAezvCFMmJCR/WMyoksT49I3/zp1
         s4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCURnSJt5eAe4VILdv3YoTK3nsIOstw1DIinrm6wm5/62fftsnMlxPyjmCgQ1cxSjwaVvco3ziK+bQZ0@vger.kernel.org, AJvYcCWUCXvJlITAt8AXyslEII48ba/mKJhq8tQUBCWZsmny3rZ8FDb6oa0zNj0t5gCDe08pJw5YDm1GbzLvxw==@vger.kernel.org, AJvYcCX4XrGQPM1aEyPgY0rmxylEpHP6+sCE6/YeoJK5fDOsviOn8udbp0MIodr1mdEnPDYFTUTGSUJqcxzQtfzE@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJaZ9ILnlh2o0QpP5biay8hUCQCrBvoVFXisAxmG50JXP332h
	8WdAUUbvRy85e7eT8Gs6EK4DY99DG88oYI7E/ABJkfJvkZhgzA5BssDIKNJKquExMrjQDQSe9yL
	7LXhtEYblHbD7FtObS88Y9zh0dGv9WiC1miNlRlZq5atH
X-Gm-Gg: ASbGncuhsaYnO+OKU7JxPCd2CWTzFj6cPE36anBTP/1zDCOgyQt1H1BDAVD5m7BZbrK
	rN/XMsZDJG9agln8plIbvmgS90xAI/jJqTC9M0N3iwX0awIDpaxQqueKGD3X0jbOSA2J9mDPQdQ
	xZW5lhWqZz6ekdsGxOSmUAD2S1aVvaWjILA2VW657nz4nqAMxX8k7OCDFBI97s+1IkFNufJvk3y
	0Aw
X-Google-Smtp-Source: AGHT+IEggynKq4vD6SNTsY3SuiaP/yVTDeVqAA+gk8qh26/Eyl7WSxbYYZGy5UpZ/5sv+D7En1DMCxw9GKvAVwKvF8g=
X-Received: by 2002:a17:90b:4a0a:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-31c4f4ccca2mr26575080a91.14.1752567716750; Tue, 15 Jul 2025
 01:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712210448.429318-1-rosenp@gmail.com> <20250712210448.429318-5-rosenp@gmail.com>
In-Reply-To: <20250712210448.429318-5-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 15 Jul 2025 10:21:45 +0200
X-Gm-Features: Ac12FXzvb6Vo4hFlEEN171p2VK_2rD2O8rW8KBf-Sr8ny31IT3KEqoC_trh2J6Q
Message-ID: <CAMhs-H_T+Nh==pxeW+uwk1gSr8YZMAva1DO9hF947tH7ot4=kg@mail.gmail.com>
Subject: Re: [PATCHv4 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 11:05=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> This driver was written with multiple SOC platforms in mind. However
> since Ralink was aquired by Mediatek, it only effectively got used by
> older platforms. As such, we can slim down the driver slightly by moving
> all of rt2x00soc to rt2800soc in order to benefit from inlining.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig    |   5 -
>  drivers/net/wireless/ralink/rt2x00/Makefile   |   1 -
>  .../net/wireless/ralink/rt2x00/rt2800soc.c    | 119 +++++++++++++-
>  .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 151 ------------------
>  .../net/wireless/ralink/rt2x00/rt2x00soc.h    |  29 ----
>  5 files changed, 118 insertions(+), 187 deletions(-)
>  delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
>  delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

