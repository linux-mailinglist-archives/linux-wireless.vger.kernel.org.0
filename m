Return-Path: <linux-wireless+bounces-24921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A2AFC7F6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830A2167CAB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A513263C91;
	Tue,  8 Jul 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2Z8en79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CE3595C;
	Tue,  8 Jul 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969248; cv=none; b=ogY6VPGPJzIHRagQ/i377nXgvocO6iUM28X+5L28FIddvaD4khdUDQVlmoGq611UEkDORgSD6R5pe/qCGrquCbFCR6vpDN39YH0SrrexCQ1dfYX7DRFu3nqevCBKQaKlaXF2Wa8XQNwNxScRu5ut+YOULU01AIODFBqq+zeXdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969248; c=relaxed/simple;
	bh=P3NK+9lggpPVEF+oeCQI9OBZIdnKQEtSoCgAkv1ctG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeMD1cHfgaCeha3PLt5G9kRN+SIKtfASzXxdKoajtv2e9aliixzRicprQaUP/rt6kXmONUHzH+/kku5LKrOl2Hd3ynew4+c2+9c9wXirGwj5P/LwKEMQf15qD/cwn6lwDM9I80+B3geOmptZ/iOMi8ZgbECCM8NQ5OwqybGUFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2Z8en79; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so3301528a91.3;
        Tue, 08 Jul 2025 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969247; x=1752574047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jWe3GpjiIlL1nZ3AwtNcM7ezIxInSVu38CWRYqmno4=;
        b=X2Z8en79xxavTjNujEcaiM7jlsfnKzWIFVcn1Z2zp0MVsauT8dKcXKxA6wiWdtIZpO
         pN3srTc76EgyF5jAv9f1LNhIppyYW8IfmWo6Ns2YGc1CxP3d9rP8QGR7FSoL04CfhJdi
         zLP07EAtsfDOJo1kuczFHmzazIbUVALcAPtPLDxdcwhWZ0v8xSzNyLA2uticc7HLJ0NL
         jslAc8fExnD9l+VNVM6gf1qHbORtJFACUvX29f1+R8MiK/BOvb8sAv6ZSHIFrlpmob3W
         6bSTti6yrgIq5jORwOuRodcwmhoP94ZaaZ2LjN6yuqsSpkKfArAEX+jfWIlXeDLerWzj
         dm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969247; x=1752574047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jWe3GpjiIlL1nZ3AwtNcM7ezIxInSVu38CWRYqmno4=;
        b=r/JnwYRinFPzsrgz1bQddGk7EMn0NJIuZb6/Zt3FT85/sU66qdFzzWJJ8flfAujG6a
         uiLqUSywaMuOo5nNCFh90X1xwUeFBsg/T/Bp9XmnrS3farrhcuFe52J1Bjb+KGb8O5BE
         Qk+LmDzSEJQgQ3By6vWPmPigdWghzcLoBIUrF2y2jD7Ju99vXfcLkSn+bO+ZKt/fXphp
         +q55JJAn9Y/vlJnk4pdwKhILYhA6Ua7VSHT/kjanKLrHPiJxO5Lq3i94H2N7wbbnzpGk
         n1D+JFeODnem4DT+WyKFMEa0du/MwECFJRHzK01i/5bypTPKl14TvmrVunfmnhGbIi9Z
         WcwA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQxReb2yyXPbuf/+yajzNgRSCMxccwtbpzAQi7hWtAvQWqd5K57PzrM/Y2u+TzzW+F86+RCYSPWk2bX3c@vger.kernel.org, AJvYcCUWCuYDYWuIQ4v7mvSTwHMYDMQzDoX2E8367dHfH18DrKWuxV2v7HimwDy50Yiu6VCvYbib+5PL9GMZ@vger.kernel.org, AJvYcCVYS/ztWR20E841RZaCBM0Pv2TXI6QbwwmFuuo2VSJJGpDgJZaSGACUUBeGlSdU56TleWyDXk08ppr4Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YypGrtwqaqNznG5geu9+K0H4BIAtiKXIBKlA3lDJn3ZOhA63NI1
	ORGVUcJ+EsjbUoSRP8oJOB3uyYroUrxnxxYfjIQv+DgBbAmXM57+FY9bs2jIN2yvHdCBQjjrg/9
	iv/HxCkNnDMQgqojIdiKvAUJX08a3Ru8=
X-Gm-Gg: ASbGnct8ENmIk362uvRGMYMJWPLdWcQ/StaCCTHd9Dj+vYGOWN+3+P3b+rGq5qgENkv
	/0l+VgI2mh5TzANojgBrVfmuffw/Yis7FU0zuGXkuYatGBI5eeair/XLNuPaSZPCdW8Kc3IDWWV
	BzOnPMWmrBISHaJghFNGU+uG2qkD1T48dvCod6HE5o
X-Google-Smtp-Source: AGHT+IH5HS9R8EC1RTg/jg9CUL8rPNysDY/yHGuHTdZ8sVLdLzbsBYnKiUpv0L2D/dSxXO5fZVs10JjXwdkV3ew9wGg=
X-Received: by 2002:a17:90b:3804:b0:311:f99e:7f4e with SMTP id
 98e67ed59e1d1-31c21db7b0fmr3713376a91.16.1751969246681; Tue, 08 Jul 2025
 03:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-5-rosenp@gmail.com>
In-Reply-To: <20250706214111.45687-5-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 8 Jul 2025 12:07:15 +0200
X-Gm-Features: Ac12FXw1xdIN9U8Q2cMOcX8lGU96JDJzneChS1fP6nA64__OBK_Dj4Vk5DpL6rc
Message-ID: <CAMhs-H9oqY+noxUyVWdH03bZmyime0G+y=hUXV=1Q3MByf4HsQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] wifi: rt2x00: soc: move and modernize probe
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

On Sun, Jul 6, 2025 at 11:42=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> By moving functions from rt2x00soc to rt2800soc, the driver benefits
> with potentially smaller compiled size. It also becomes much easier to
> remove a bunch of manual memory management and use devm.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2800soc.c    |  67 +++++++++++-
>  .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 102 ------------------
>  2 files changed, 65 insertions(+), 104 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

