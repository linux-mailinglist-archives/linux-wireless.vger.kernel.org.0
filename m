Return-Path: <linux-wireless+bounces-24920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D578AAFC7BE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01381888436
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4069267732;
	Tue,  8 Jul 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6TnXjE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02D2080C4;
	Tue,  8 Jul 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969037; cv=none; b=N2PMPzvvQJPiF4q5gd/sSQu93qstCdlobVULWBpalrViv1B3qCgyUy0VUc5Q5BUs0hzFcYCpFocDUqBduxotHI/DTbaUi6ORurOSD7k/UVJz7cOcfL1f+2yafS8G1RAYFMN6t6b73jjLgiLywofDhggyAYOt6coOXVhX/bpovJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969037; c=relaxed/simple;
	bh=Y1X9PBX7qcUQ3VQhQVIFAiKTntxUOEwd/Za4bXmASfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5p2Mp11XTK49bO/NsVv4A5I73xZ0oela+6qzjGOBIs2Dnh5c646d4GbTceQppUQJp9Qk8pP3ygI3nbOgui/ayvz4K12vT8dwCchXna8pmrhJz4NOg2sxDd5tbHQ4cvUDebdLOLhYPL/lLSlX5LGzUB/6lsDA6ST9t07bFAeAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6TnXjE7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237311f5a54so38477955ad.2;
        Tue, 08 Jul 2025 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969035; x=1752573835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpGeu0fct+3VmHlRdU5eb8NMKV/Ar7w1D2lbejumdKs=;
        b=F6TnXjE7EibE1OiAWTl7V7TBoP4cvVVOCpXapuOdS+mgL/0QljvhYyCaXmss5XX0uB
         /dk1aiPi4aPixrMj/xcX9hZc7vPyuF+Ci9Rz3lNpuQuLXOgM3YKrtl2d/N8ke114krZ3
         0Pg3LWnMPGq8AEUnorLg/O1rOtZ78JkErm8vUiCRdkJg+l/kNl5WpH2kiQ0BS35+O2m5
         fNVtUsRlwOI2bz8sKxj+kiSKL6HhyCaaPjl0zBEWnx2y4eYbP/3sBvEQVgb0sxy6JdG4
         H98PFh+LNNmsdSVd5dUZzeth5afVo20nhSSJhr16YkO9pfWWtbVgT24kboi6ctaObaYo
         Yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969035; x=1752573835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpGeu0fct+3VmHlRdU5eb8NMKV/Ar7w1D2lbejumdKs=;
        b=HJz2GoRTJ4PY299JvQAJ8VCZbikVcG7Q1OujWmmhWUO/aFJWASwDak6fcaR+XoWc+w
         5vOE9R9mG6l8lki0ts3aonH4GiIo4fTcDlUKsAwTU6QOsneOcKT0viDGMVtM2AZSvVhF
         vapqkRuETFcssOg7Hr16zvIFP2OsjZGkmZ22Ik5z35/vNaKNrSUsYFyg1PRi+bixewov
         9hfr/4B+KaRbGuDRgKCwzOSNitMiSHDGjWlE6zy3fUg8gQBKGx2EDGCviLio9eV1wh9i
         hWvrqXIzzEB8PF9EPBK6TTcUDBmbkCXZq3axKYEn/7AhPzoh1lW4cBlVfqK7ooHdwd3p
         QJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUSenDKRug8w8zOp9ZgtDrgCIwORlAGUz5b5fnHEJQxlWyDK6dLGbjdqAr40CRTmji2hZl/J5k0qaxurCI@vger.kernel.org, AJvYcCVteU8/E5ZnoZqUNN729eLogzcVATqGUtW5NnJhqXXFgZzjeOrKlxWeoqw/qADEOerd5dZiKHoGk7mEag==@vger.kernel.org, AJvYcCW2ccPGMbAm9/v82GrQanvQMadGTfmw5irW7koZuhJ8OuIQbSIqrUGw+68PWwE+9cZduMkR/rdqgjgl@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWtz+lQ7GDkv/o8yJfK6suRZbGITWtX54LUVtaPv1L5E9DHAd
	2xpWKv0saKCmw1615+cFf32f8wlZK4jj8DatQ+fFVEOguLhLu/CAMGOhhWYOb0Pqr7j2t9p8xos
	e4Rvcfm78cKDYYgTe1rPY0U14w6xvdgk=
X-Gm-Gg: ASbGnct87ZJWpEfWAOUFKrR5UTBcn35zq91iZ15Ecx11RpXav8Bd0hzWrKpw8nOz0Rn
	158fVRS0Ys5PB2grHftD84D9uaA/5yHsCKXrLgzjy+Nvci5TOyGb/9hYhFkmqNMc6lumXFW8z4l
	fNkBZ77lOhdasvd7tFzsOIQYfMNTD1KVtV/ouYCqIN
X-Google-Smtp-Source: AGHT+IHCEfcIS2hUnEdB9PbPmt5ZD9T64WlU2Ot8WUjUZqgiMJ9d2john/gI6sTWhRffzI0DT19R2HBQAqTyVFgmv0M=
X-Received: by 2002:a17:903:a47:b0:23c:8f21:ac59 with SMTP id
 d9443c01a7336-23c8f21addemr149130485ad.29.1751969035426; Tue, 08 Jul 2025
 03:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-4-rosenp@gmail.com>
In-Reply-To: <20250706214111.45687-4-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 8 Jul 2025 12:03:44 +0200
X-Gm-Features: Ac12FXwhjylZMsoY4rDqa01BVMXMM5PiGD4HvSivpj3vJ2MwrtIBDDKsIP82h3Y
Message-ID: <CAMhs-H9PcmyNsZsU_JujV0PkRmJX5HSc0TBMR05OWmhUP0ByYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] wifi: rt2800soc: allow loading from OF
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
> Add a single bindng to help the already present dts files load the
> driver. More are possible but there doesn't seem to be a significant
> difference between them to justify this.

typo: s/bindng/binding

>
> Use wifi name per dtschema requirements.
>
> The data field will be used to remove the custom non static probe
> function and use of_device_get_match_data.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
>  1 file changed, 7 insertions(+)

With the typo fixed:

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

