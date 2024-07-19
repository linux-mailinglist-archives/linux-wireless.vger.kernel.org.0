Return-Path: <linux-wireless+bounces-10368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F069372A9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643B71F21A14
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015029CE6;
	Fri, 19 Jul 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvm2+am5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB81286A8
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358447; cv=none; b=WdKCP4gXmuazOTdpVpmNraffH4AY1lQXIjCrdAJIWICGTBdOEGZLBu0naxvdtD/yqBiLp9saYZHP7ky0VEG7ezBa3VDO/7495weTOMYQvsdlq2aslxXdpoyTfyK8edkx2175k2neh3SPepXiWus2Qf+bUqsZi+oBZ0PalwrVSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358447; c=relaxed/simple;
	bh=ZBgbVY1dMaONu78QBCJn6K8doA+gMjSbNABg8mq0epQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx/4j5rsdezoFTQU53KX+BweHgwu15gfgEhW/mvGZb+OwmxEX1VWWxXjmfb4Z40LpNEtJ5PGtHLUicZb8Wzq+sdekM3/F9pYw3WUzFgKggw7CMZ65+WMKR+Fmvhv/Hq23NR6oppU1zWEsRLYmzCFkrTXosTGUBR/oxW+zRsvD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvm2+am5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so146526666b.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721358443; x=1721963243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2aBN439CgxyqsWC/FKZX/cRexlSuHG40IikgmWyCH4=;
        b=cvm2+am5snrnIHMDOH5ecALUnkTL+FbwsbB0OmGW90QsoJ1qoGNibu64et7F85HmKm
         U1+MClMcY/643HC+3aTiw2IwGzp/7+YOZo/OdSa1oHtJiFsvW0gewKVCcwJv+wqOCyFI
         0siSlvN5mh2WQjpdy2ronCl/PZm7ZYhgXGHwb4EpYoVeZoSpmWRYZknnz1HptD7yjYym
         9Q7uAyYnqqQtMx5yxghT+oY63l3mo/MJx5VUVAnmofdBA8bM5MgdJIOmX12rF+bXjoCP
         Ij0chdSdsAP4vnny+/FoawVDhoBthc3T36Nf3eAri+DqnMm/EQ/7yT70EY4+32rnRuCz
         ry/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721358443; x=1721963243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2aBN439CgxyqsWC/FKZX/cRexlSuHG40IikgmWyCH4=;
        b=epRNnYSDcqqfilbdNY6vO5xbFMQAcG0Q+tue9yiqbZlcfbSZBDrzQTPLRlCCmVZBHK
         Jb3z0Qjo3ePT3biHwuAnYl92Q8yu66k8bz4wMZH3csWum+XqUxXVG+FkzGqHNT7YvGAC
         tbc/BO69or44ZETn4l/xFsyvcB3kybmwll2Lbt//DWjtMIjmGZRqi5KGaKLg0TC9I3rn
         J9tUSwSZ/IC+j3zF+oX5/XTcGztTIC80JThT+jrAnl1Xu09Jn5W1pHx8NM0a2puPn1pP
         k7BKBDuzDIMTDzvsui5JHvBr5XZZoiy6GW6Qnn5MlW+QH+pnoT6OD3ACI+t9FHgFjPEQ
         9wDA==
X-Gm-Message-State: AOJu0YxZKNrdnvzyQg7Y65RL4rXOKRDAX6L04LA3/BgjadcF55Om0ksC
	eSHJf6KI0jqdKTjN2VX94ALr67jM94K3q+Z6/RHulYGItdS7/08UwTqdQYVUQs1f9T98kSli0MV
	7fsrKSDuhaym9nLf6GAi08p4uj1U=
X-Google-Smtp-Source: AGHT+IEJE61cAf3fLd8YLQ+hDm+7GTnb8etkVZpYIxtEOSpYiChPVVa/B3u7xEdF2li1npL4Zce3tmzzq8pJ0ASkkxk=
X-Received: by 2002:a17:906:b798:b0:a6f:61c7:dea7 with SMTP id
 a640c23a62f3a-a7a01158645mr422794566b.18.1721358442926; Thu, 18 Jul 2024
 20:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060613.28909-1-pkshih@gmail.com> <20240705060613.28909-5-pkshih@gmail.com>
 <CAGb2v64mLd+jhwL2EXZ=zTJZ2VuMXTa==NvAqib=xQrNg-ufkQ@mail.gmail.com>
In-Reply-To: <CAGb2v64mLd+jhwL2EXZ=zTJZ2VuMXTa==NvAqib=xQrNg-ufkQ@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Fri, 19 Jul 2024 11:07:12 +0800
Message-ID: <CAHrRpunYADgM3NcrSC38GPzqGwUBePA84zLMM5u91kz81ZsU5w@mail.gmail.com>
Subject: Re: [PATCH 5/5] wireless-regdb: Update regulatory info for Togo (TG)
 for 2022
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Fri, Jul 5, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
> >
> > 5925-6425 MHz
> >   - LPI
> >     * EIRP 23 dBm (200 mW)
> >     * EIRP density 10 dBm/MHz
>
> The document you linked to suggests it is actually -10 dBm/MHz,
> which kind of makes it useless as the total e.i.r.p for a 20 MHz
> channel would be 2 mW or 3 dBm...
>
> And the PSD for LP being lower than VLP seems like an error.

Since it looks like an error, I keep the power limit as I made, but
add some description by v2.

Thanks for the review.
Ping-Ke

