Return-Path: <linux-wireless+bounces-24918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29EAFC7A4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ACD1896CF8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C51E25FA;
	Tue,  8 Jul 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZxfI62n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00272610;
	Tue,  8 Jul 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968865; cv=none; b=NW6c62+bzmhYTKdj9BaAyHIH/WQKeVwdHjyQ9VDyBshiN+BA/6a+6TbPNaadJHJDUgfOJf9WGUF3xsyWluF56eri7fD20aRVR/l3s8bIfBC/hPAVAw7Bh0gkEZQ/m7jesB28e69MatCkFolfD1rOoXDhSLLvGQ3+lINKxF9Hs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968865; c=relaxed/simple;
	bh=pPJ3ZM+61NoEPP7sVqf8nRihh6saAoswmamcXrU9qmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLlX60JMu/Yes88DMcfF4Yly1Bj0U59/wZxbzqU+EzTYwiRc0N1cOiPSD89G59/9nkCyv/iEUQFGaSbozxpkzDF0bduObqkyjofWIEnuD/YR+R/gAoaeKfyUSoRC3XFIzbuFK/hOgyFa1lV+TRFaM5EFwK+3Nzaysnks87X2PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZxfI62n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23508d30142so49865685ad.0;
        Tue, 08 Jul 2025 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751968863; x=1752573663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3wkBIAWu6vMGhx4ihyYrJkvVRzXaSU5Nke0PKHHZR0=;
        b=IZxfI62nuRf0pcjI1fu+dN6UyT1eGG0tzqEEA25u7KNC4DGXZP024LK0hY8cree43g
         UAazC3ReUUvOft8J/m4PLyWBSJOu+uQwvHbl2euqcm2V6h94RpWnZN8HPVb1rHOAskyW
         UDvBjjvHGmoGczuQQtaEyx0kuRJw1MQN5lc3ax6QcJZWn5+RC9CmMIBLcvIS7Ef4EI1N
         5KFbqaMmJaI3CILzFZGv/Z+J+3DAeCCze8LVv31aekFdvHSAhKti/JUxHb83XtyPtUIf
         FmyPeG3esN9rin/97TCTTXFHigNFnMRjZkX5W+NFf1Ufe9qdGa5dDv95BnuSoPxAxbUd
         g0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968863; x=1752573663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3wkBIAWu6vMGhx4ihyYrJkvVRzXaSU5Nke0PKHHZR0=;
        b=E5WuYOPf+5JF7sFuDcTu9/WSXq9cPkBAv7JOuW4b459Rq2NRmYC1p2QyP6nknS/KD7
         TYZxh1wpFEbfiDWvvMmMf3syKfoIPR4ip81CicgbPDO/Oj4t8K1lvc6wj4XIG4RxpE3z
         bUaYWhToOF73/hQF1Gx0VaNJIsa7Jm/7PYG3d4WsuAmIbmTZst+1TV9EEhxCcNINdglF
         FKf2KQnF/BXjyIDjA2i9ZmG2Exn3fiyL1pxBs8oK5gdOm3CmDrKkTISuBIXSdcT+dgmU
         /wCeowTwU2eP/LwCvTf996wuHu+CtF+my18g8CkSeKSxcXuYpQGqC5r4dGLoGKiuorD4
         BTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUzWn04IQnjz/KSis1bpakEM4UkpVhKJgIY92p2vUR72gvA+BeotcWiG6CPlTvk+Fm9eaSgzLGtNPtrjLM2@vger.kernel.org, AJvYcCWlQPsIUnn/etJ7LCckJ8XX5MsVhywHg5crSy4Bu7wVrFFIhbOoROUG6TV7jNtgWauGg1Mo0f/jV2MB@vger.kernel.org, AJvYcCXLs61sEZWto39E8sCoy+a7BqVVtHOoFE6FnZ6SSjaGK64oCj4D5boIk4R73L3C8ahxF/dO9ggJxn15zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eNakFf2wf10ZP1MyNaoBjpfdwd6c7z+7KBMEap1AMgGzc5/t
	yzCx69Z2G5A/kidiobf6lyB7CQlLkkt7RCEgI3eY0J2HpsrzSz71UhmMdhZjc9BYjITjVtChRnN
	FH6beLy0IxrJATHW3Ne923mBDH8pyK48=
X-Gm-Gg: ASbGnctpdaLC6CHRh2rC2h/ipOJHQKtffjxrRMkAzV4zRKyMY9CZPo34UX5/xTzUSoS
	y+Y1kqxNlu6LIjE58nQ+DjnJ3V4gTJeMxWIpmjcEUfbpKbCJ9LC2BUtXjwZRZbnBZDORe5cSHov
	b8E9JxM/EMT8GjUpKcqDNV9EcL29g/N2h94wV00tpb
X-Google-Smtp-Source: AGHT+IGAe+59sFXxJtTzkwvN/ahnPXiW4uDCXu7SJ3GxoxXjyVqLVVp4TiGhxGEmNwLOC3JUTpSndKTB39EzWdmJQBw=
X-Received: by 2002:a17:902:cec1:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-23c85ec7c0amr255897365ad.46.1751968862766; Tue, 08 Jul 2025
 03:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-2-rosenp@gmail.com>
In-Reply-To: <20250706214111.45687-2-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 8 Jul 2025 12:00:51 +0200
X-Gm-Features: Ac12FXz_arerdXgv7XWPfT5u_8acT2yjf8UClrrHDQjOZEpD7ryHNclY75AcmHs
Message-ID: <CAMhs-H-DNZik1EhM03QjUk=KwJwdQ=MCS-XdkA_dy6G7EpjBbQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] wifi: rt2x00: fix compilation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	yangshiji66@qq.com, ansuelsmth@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The .remove prototype commits seem to have missed this driver. Probably
> because COMPILE_TEST is missing.
>
> This is a mess anyway. These non static functions will be moved to their
> proper place.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
>  drivers/net/wireless/ralink/rt2x00/rt2x00soc.c | 4 +---
>  drivers/net/wireless/ralink/rt2x00/rt2x00soc.h | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

