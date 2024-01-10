Return-Path: <linux-wireless+bounces-1643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C088829193
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 01:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D211C25348
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC24691;
	Wed, 10 Jan 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEzKFRWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB6440C
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cce6c719caso40086261fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jan 2024 16:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704847382; x=1705452182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM8heQLb1WxBeDONq1X7q8jQ8JXiO0fRAK69Y+bY9XY=;
        b=hEzKFRWKexc/Gtvkxpqfbz7ytB4ctmpzLKGVMpA2tllRHIO5NigQTDTc0CRFvZQQm+
         vCOuGBp5WXHx3Zlx7LHh94I4oGDYfg++L+vC9+T8X/+YtXybR1KY0iodFDc/rB9Mij1l
         5Y+qcxGYMhuSUfTsoW6rxriIYFS1FZ33jpLGvPt7cbfC6ZAdBf5P+9TAq22+GGBUxGFB
         AhGHBOkJq9nx8tGnOTkT6dyv21tdVe766s9A52NlqlS+IBCYELEIUXNxIS0OmiYhosZ+
         3oIEynlQPLQ/E6t64pvzNw9RFzAyLTciBMKL1c8NFF81TvZirjK3N4039fQMkYGgYC6b
         oUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704847382; x=1705452182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM8heQLb1WxBeDONq1X7q8jQ8JXiO0fRAK69Y+bY9XY=;
        b=qdkf0KvA3i7e2kE5r4pksYf8b6ZRXbsI5WA7gtlFy6vJwiNNJ+8puWv5dSKxo3rMq5
         8AEzjDkTbO/X2N7UGpGdepxxyJUQkG8ZN5Zxj2CCCurusv0qhGzW7yuYMRlJ/3BJE8KS
         XijW5YtwoLIA8D63sTREYvricP/Wnqv8Ebzluk5e51QnTdfWE6W4lt43Vhaswf57rDqv
         sF/pCoX91Z0xSrXTmYWmka7X/ajDwk2f6NaxDNes/OsYMY3iNSBvzGHWqrIBWPFU08Ry
         TZBcuLzoyNJZJoW0PdVn+1CoiqXQfU+jXWimfueyok/4DncCK3+Yru5n5KUET6ecP9Nb
         I3Lg==
X-Gm-Message-State: AOJu0Yy0bO+5xfLglHBDCBVLM58VSYUpu/VfMH+Jws65HQeeoeXs+wbe
	KTCurK4+A8H/0nZdaYyOfJvh8hwtrZeHvot85/yhMI+AHsQ=
X-Google-Smtp-Source: AGHT+IGp7Svf1+qtr+oIJ3lI1JMomxiI1ELL3hpayjh1w0As/k9QdU0Q4TgGJGkw6bBmNF8huV0bjq91MJiwdckEomk=
X-Received: by 2002:a05:651c:1315:b0:2cc:e919:eb8f with SMTP id
 u21-20020a05651c131500b002cce919eb8fmr75322lja.101.1704847381655; Tue, 09 Jan
 2024 16:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212031914.47339-1-imguzh@gmail.com> <8734v6ecp1.fsf@kernel.org>
In-Reply-To: <8734v6ecp1.fsf@kernel.org>
From: Zhenghao Gu <imguzh@gmail.com>
Date: Tue, 9 Jan 2024 18:42:50 -0600
Message-ID: <CAMuEUs+ZOwgOmNXSc42H5yFiNWQQiKJL7Q1isBUCBO1AaVsN1g@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: fix IOMMU errors on buffer rings
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:41=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
>
> Zhenghao Gu <imguzh@gmail.com> writes:
>
> > virt_to_phys doesn't work on systems with IOMMU enabled,
> > which have non-identity physical-to-IOVA mappings.
>
> Can you give an example of such system? Just curious where you are
> seeing this.

I'm testing on an AMD system with IOMMU enabled in the BIOS and "iommu=3Dno=
pt"
in the kernel command line. I also noticed
https://bugzilla.kernel.org/show_bug.cgi?id=3D217056
which may be the same issue.

>
> > It leads to IO_PAGE_FAULTs like this:
> > [IO_PAGE_FAULT domain=3D0x0023 address=3D0x1cce00000 flags=3D0x0020]
> > and no link can be established.
>
> What do you mean with link in this context? Are you talking about 802.11
> association?

Yes.

>
> > This patch changes that to dma_map_single(), which works correctly.
>
> Good catch. And virt_to_phys() documentation even says this:
>
>  *      This function does not give bus mappings for DMA transfers. In
>  *      almost all conceivable cases a device driver should not be using
>  *      this function
>
> > Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> > Signed-off-by: Zhenghao Gu <imguzh@gmail.com>
>
> Jeff, are you ok with this?
>
> I did some cosmetics changes in the pending branch (removed unnecessary
> parenthesis, reverse xmas tree etc), please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=
=3Dpending&id=3Dfefa43d63e1928fce6e8c2bb626900e9ce98ca69

