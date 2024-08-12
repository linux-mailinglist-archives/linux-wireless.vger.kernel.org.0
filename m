Return-Path: <linux-wireless+bounces-11305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014FC94EBF6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEC61F22412
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D87216A948;
	Mon, 12 Aug 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwSdGqGt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A3176ADC
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462908; cv=none; b=AKYDfzOFJTlDC2zsclIs6XtnOHmIYG/F3xITDtK1sspY6RmTZwGaFp1JjjKb1R0iIMpZif5MktLBzHGb5PZny1D/nVdiedyjhLiRn2v6Upcd7YTncQoAH0u7QGri59man8PjcJayRDHCxbMuoJ8I8zUd0KfnNH7FVIf/S4EBiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462908; c=relaxed/simple;
	bh=kMF/pcDT8zvMHchT4Oz6nEmx/XYKw/r6u78XbQTxCzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgTxMq0B1nQEdqK+Mfzy7asne1PB1dLdNXpkhHX/iDmzIb1uCJOWlidg5b2pPsrOyooeaADK1SGELw2QoRwrI54OVlPGdt1KppiR4KBkiklg/+5RNyGLkLTghO50ggZ7h0IZnmAT5ubOJujKlJjHkAPR33QSHWtC3Dk5vQLj7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwSdGqGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED591C4AF0F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462908;
	bh=kMF/pcDT8zvMHchT4Oz6nEmx/XYKw/r6u78XbQTxCzo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=fwSdGqGtwnL2Z+bsF0FzAjoPWuh4aDDAIQ+WexMbo0BeVw8zabCr/UoZTvPSEk2A3
	 SArytF8YkzlT6/fE4AcT811FvYbY2ZKTnx+haUl2wEvEO6vTp1i6NhslEdanzn7NO+
	 8GdZ3jIXZfhdVst95npT9GumSqH46QXgalKP8/n7y2udFx8n6fpYh7Q87KjEg1h8aT
	 luhKGLqf04Z6PiOEPh8QeeVkk1FKArIxBwMxt0qIyEG8UaKyPjPx6qxWNkVU6vM953
	 Lm9fdKCKaqvGWwdpb5cxhl0/s6bWJLQ+cpcp0eEESPeBckVUuKD0Ii9KAmRV2Q3Tlw
	 Ci++t+KjUJL6g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso43544341fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 04:41:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1snVZlCSrpPwTvqHJHpdulzO57ktS10/JECzkjO7s/Im2JJpS
	2yuL7n8A48mpRgDwIpzRoDRjfnA4qXudfEPLw5M9TrcArL4m3vEHozA+N6EIrlz2trMmzfrS/+O
	yFhWLizwfS+usGjcp8qYqFEaMWA0=
X-Google-Smtp-Source: AGHT+IE8wXvfgTPIrpcj6QGb+Lk/FLqmTQL6rqO3+fRPj//sfaG2Gq43ZomYIe1ktiIfua0kkUkRrEMCDFKyAqSp/uU=
X-Received: by 2002:a05:651c:221e:b0:2f1:a509:ce66 with SMTP id
 38308e7fff4ca-2f1a6cd441emr72474261fa.5.1723462906267; Mon, 12 Aug 2024
 04:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806061203.1839-3-gcperfinian@up.edu.ph> <CAGb2v67fQiYAq7C-eT98L-tx4DoS5AN0UyfaB+hFkpOQy4Z3vQ@mail.gmail.com>
 <CAJ5pLOZ0mBWjZ2zSwwsBj1TsLXc+R__1bGsUgNUpZ8an9K8WEw@mail.gmail.com>
In-Reply-To: <CAJ5pLOZ0mBWjZ2zSwwsBj1TsLXc+R__1bGsUgNUpZ8an9K8WEw@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 12 Aug 2024 19:41:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64MnnY8ekQd1AES68J6NSOXP4Rcb41orShrzhtH0aT4Xg@mail.gmail.com>
Message-ID: <CAGb2v64MnnY8ekQd1AES68J6NSOXP4Rcb41orShrzhtH0aT4Xg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Philippines
 (PH) on 6GHz
To: Gacel Perfinian <gcperfinian@up.edu.ph>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:38=E2=80=AFPM Gacel Perfinian <gcperfinian@up.edu=
.ph> wrote:
>
> > Could you use the value and unit directly given in the referenced
> > document? So 250 mW.
> >
> > The database takes both. You don't need to convert the other ones.
>
> Can you clarify if this is just for the new entry or for all of them?
> The documents has always stated the requirements in mW eirp but the
> old entries were in dBm so I thought there was a reason why these are
> listed in dBm.

AFAIK in the distant(?) past the database only supported values in dBm.

You can either "just" add the new 6 GHz rule using mW, or update all
of them.

If you opt for the latter, could you also mention "changing the existing
values and units to match the official documents" in the commit message?

Thanks
ChenYu

