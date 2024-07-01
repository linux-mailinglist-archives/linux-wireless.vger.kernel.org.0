Return-Path: <linux-wireless+bounces-9757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6E91DB60
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522A61C221D8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED157C8D;
	Mon,  1 Jul 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g63thwVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426683A18
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825997; cv=none; b=Tl/ij1tu1StKd1HKsrKxbJnvb7NRFlVCL4SN70sP5kiG6y0El01LOPH27184ht0i3Yif/sJR6T8sXQ3SCWrf74zOe3u6M+2nKIo6XEUpMgxrKcuxvKm23DKjPdBgdbc6vk1WU64xGZV4K3JjYe9McqqrOmzFEncZ5kRWNoGcHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825997; c=relaxed/simple;
	bh=E8ISHJRZ0T/wmgb74RMlaRUlrSpgkvdgYZlNdp66hSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsYsPJL2bPPUyOP82Cq8A6xie8fSi6u9qoOev7mpFn41040xKNKBtHjEVxb06iGYIz1FfXgVTp1/mpGdpqUua0bhcwv3r9nIn38MxgwRJ883xH/iLyge6pas8qXdIrN6O16twKiGVGYUSxDQSUdZA9tVXiXqwWy33pCJ9oPk0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g63thwVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7B0C116B1
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825997;
	bh=E8ISHJRZ0T/wmgb74RMlaRUlrSpgkvdgYZlNdp66hSo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=g63thwVTDS93Gpb36X1j8fIy2YOuYjLmODvt//DMk3KDd7AkcXlUyAmh7ByNU+llJ
	 Z89zA2tRiN2UIlcaN0pyXVQ7fXv5hxOcvou12z0ev3KcrZo57q7LNd4RQajWKS07rL
	 TchVrFTxx+dAz7G2wW6h8sysq5+CJ8XnukjCgffzI4W9+Thih3IxWD5Z0I0/XlVpck
	 TLHEw3vDXsvPAeMthiGw29Ocd8dh0J7cCwH2LuZ9htsJ4YQC4v4Gd86i8muaJ1F4aK
	 5VVZmkVJ0KhlpeZP2clntxhOWO7JBrYJekdtXNQfhoMGkoENGpIwqPyz1nCdbeUOlU
	 QY2Ysi7BnKM2Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so39351681fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 02:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw2M9VJ9lguACmRyJ2N88cJ7F2/KX56xZgHbglecIY7fZdQlmVk/q38ChA7g4EuKjEBO5Kk5V1fxXTSR4rXM+0s+vLrCliqR20F2lXU/c=
X-Gm-Message-State: AOJu0YyJpjW3ZdrIFTFEF1yJacOhyO7NS41UOnhEXej4GD8B+5m9TvI2
	zUjMkBp8qZcC8pxGifVMC2zETGLTBcxRi3R4dfL+OVFWuNEUAFbaPzglG2vvwjpyoB270ZiAK4p
	AI3pFvpfjUOY/gabYU6ZwX/efn0k=
X-Google-Smtp-Source: AGHT+IHMe03KviipNWz/spwITQbaWDQjiqkIVKXLq6j97XrzUf1loSPVyZVsGkgp8u4hDeEBZfH6FAGujQnAED7LTqI=
X-Received: by 2002:a05:651c:118d:b0:2ec:5685:f061 with SMTP id
 38308e7fff4ca-2ee5e3a3f04mr37129561fa.21.1719825995419; Mon, 01 Jul 2024
 02:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230416013031.158433-1-sforshee@kernel.org> <d448ca6a-106a-478f-ad80-5c8730765ca0@nbd.name>
In-Reply-To: <d448ca6a-106a-478f-ad80-5c8730765ca0@nbd.name>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 1 Jul 2024 17:26:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ArWLugdvZfGxSGA3eqxcozMo1Xov77_93=A=FwtijNw@mail.gmail.com>
Message-ID: <CAGb2v64ArWLugdvZfGxSGA3eqxcozMo1Xov77_93=A=FwtijNw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: update regulatory rules for India (IN)
To: Felix Fietkau <nbd@nbd.name>
Cc: Seth Forshee <sforshee@kernel.org>, wireless-regdb@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Keshav <the.ridikulus.rat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 1:54=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 16.04.23 03:30, Seth Forshee wrote:
> > Increase the max EIRP for 2.4 GHz to 30 dBm, and add DFS for 5250-5350
> > MHz and 5470-5725 MHz.
> >
> > Source:
> > https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr=
-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> > https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e=
-dated-22102018
> >
> > Signed-off-by: Seth Forshee <sforshee@kernel.org>
> > ---
> >   db.txt | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 915a3b94d418..2a7779510cc5 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -850,11 +850,14 @@ country IL: DFS-ETSI
> >       # Table B List of conditions, row 68, wireless device using 802.1=
1a/n/ac protocol
> >       (5725 - 5875 @ 80), (200 mW), AUTO-BW
> >
> > +# Source:
> > +# https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-=
gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> > +# https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-10=
48e-dated-22102018
> >   country IN:
> > -     (2402 - 2482 @ 40), (20)
> > +     (2402 - 2482 @ 40), (30)
> >       (5150 - 5250 @ 80), (30)
> > -     (5250 - 5350 @ 80), (24)
> > -     (5470 - 5725 @ 160), (24)
> > +     (5250 - 5350 @ 80), (24), DFS
> > +     (5470 - 5725 @ 160), (24), DFS
>
> What about the DFS region? The DFS channels won't work without it.

The given references do not specify which region to follow. So unless someo=
ne
provides more information, there is nothing we can do.

ChenYu

