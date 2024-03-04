Return-Path: <linux-wireless+bounces-4354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA08870B6F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091BF1C2231E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7527B3D8;
	Mon,  4 Mar 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKHtDgI5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF57B3EA
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583691; cv=none; b=m45hJ9Akaq0Po34h6uILff0qwWnTxA2Ve5IQFm2kJFZ9bUT9hL4GYBEmj7Y2AgZ/gqKNEp1DcPu+y3ToEwyikH+kfB90DtGM+GsQq6+Jf7J0uq4ywgbu+a2FWezXEunohXSofA/hHCBB2Zw7FrX4ITeNnHaZpY0XQ1z4Bctmggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583691; c=relaxed/simple;
	bh=EwpTei33rW66icXPCuCSEmaDrKS8PEI2sK0grd5M4fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2Ll0mn/KZLe9WG+dHY73rPYMH81QtgboJ4la+y+6j2Q8Lyd8D5q55qJlgI1ed744gy0A45+7z+xHDncm7OFiw11FJ/Pci04DrluDRgyofA9RbGfPllRYl72LBf5LIY3Vym0K3oz96Xi8H3mPjEZWF7mkw/qOQaGFtgSSyi2H6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZKHtDgI5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so5109237276.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 12:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709583689; x=1710188489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rXtl30v0bU2lNsKD86GDf5XsqAJnzL0Xmw5DBF9rviw=;
        b=ZKHtDgI5baypqxNs6YTI9qhnSMN2jf/3rT0AL2pVJZUnUqlm9q33lEZEFLIAMgMNeX
         vX/tRccWqEPsVCaC0TFr0Q8sHeo7CSAql7m4PYzBr7NKGDHruPxJD6nU7BX+0L2rFFzc
         XzRIhWcvhQDheNimQADpQpG48WgCC5TKuoaXzWD0CRsO1iD4tlp8p5WHSXSl1m0VB6Da
         p17oPV/tFQGxNFi0zcwBCCD+dUp7YNv41s06g0pN7ifDQ8hj0MsND5fzES5cq7iLazj9
         58etcCtgS49WYqQfqkjTn863W9pLTc76SbS1k3msLkMRomSFN5GLpgULJfRBFBttVpPN
         LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583689; x=1710188489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXtl30v0bU2lNsKD86GDf5XsqAJnzL0Xmw5DBF9rviw=;
        b=skK9mTy7HjpiksSUSKrabSNMr43HsRuC7Mw1AIjbXnAWLBh4+72mgFHu0kjNcbwDhB
         affopEzwit1dF8PeXgztGmaswo+WbLo/ir8U+7u3eA5QasU0w4vB5UhdLXehAy34QIEz
         /ooMR+DnL61XtPV9rClOV/ZZnJMkwcCPwnkqhb0IsSVSokM3kLu7ER/lSopf7je/mIQL
         rTLeOWiyvv7bxv2GbaDgSdyHJUorYj+NPMyArahZHIAkzsYFf/c1DsU3nqKqkOJ1Icss
         E4Nkddh3z3P4OcUUOMn/1POVf5XgerP0UkaD3OxX3SflN/Vsx4qfWVm2gNQ0KDKl20Y0
         cz7g==
X-Forwarded-Encrypted: i=1; AJvYcCVY3unMxd/pqiN8cXRUmcGa/48YNYA+wmjdLLPGqYNimwSgVcCFhjNGd4wRzQb0075B0cZXQ+pG9TaiYpNf+2Lr5BhwewVatZQyoX6IwYs=
X-Gm-Message-State: AOJu0YwkaZL/2YnQk0qdzsesFLaK2F712bAp7yeszlue9idKEW6I/gKc
	SShom7b8ySQ8hzQHq16X0I05BkuRTmQC63mXuyyB/wvTa/k2ze7d2WJnAiid7616zmkgUKBQso3
	U24zM/CpmvJboLKbhdz+DUpin9edKOhafXwSLeQ==
X-Google-Smtp-Source: AGHT+IHXFskhQBCYX0ZjV07+Eg01r4LfoVVUIYLqmdjQDu/b1QYB54OHk+PP1qlUIzJDtcxzfd0mGHMC4CwKQSXt8zw=
X-Received: by 2002:a5b:a01:0:b0:dc2:1dd0:1d1b with SMTP id
 k1-20020a5b0a01000000b00dc21dd01d1bmr6664631ybq.19.1709583689256; Mon, 04 Mar
 2024 12:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org> <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org> <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr> <20240304-component-animator-e2ee0ab7574a@spud>
 <CAA8EJpq5HQaO2E2Pd7yqUTsWyQ_pLDdyoWng8QmWTzYn5fv3PQ@mail.gmail.com>
 <20240304-superior-vicinity-3dc6ca88141a@spud> <CAA8EJprMG=fY-G-X03bm7MMhcua9axjw5ULZz0efgHxwzgrdVg@mail.gmail.com>
 <20240304-privacy-registrar-93c48ab1b9c5@spud>
In-Reply-To: <20240304-privacy-registrar-93c48ab1b9c5@spud>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Mar 2024 22:21:17 +0200
Message-ID: <CAA8EJppoc9Mu7s8bzXjW_NJDQ5go2+MvoFG_JCnwP-6hC1SRow@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Conor Dooley <conor@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>, 
	wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pierre-Hugues Husson <phhusson@freebox.fr>, Jami Kettunen <jamipkettunen@gmail.com>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 22:17, Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Mar 04, 2024 at 09:59:13PM +0200, Dmitry Baryshkov wrote:
> > On Mon, 4 Mar 2024 at 21:46, Conor Dooley <conor@kernel.org> wrote:
> > > On Mon, Mar 04, 2024 at 09:37:00PM +0200, Dmitry Baryshkov wrote:
> > > > On Mon, 4 Mar 2024 at 21:34, Conor Dooley <conor@kernel.org> wrote:
> > > > > On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:
>
> > > > > > Thus, anyone porting an msm8998 board to mainline would automatically
> > > > > > get the work-around, without having to hunt down the feature bit,
> > > > > > and tweak the FW files.
> > > > >
> > > > > How come the root node comes into this, don't you have a soc-specific
> > > > > compatible for the integration on this SoC?
> > > >
> > > > No. Ath10k uses WiFi SoC as an SoC designator rather than the main SoC.
> > >
> > > Suitability of either fix aside, can you explain this to me? Is the "WiFi
> > > SoC" accessible from the "main SoC" at a regular MMIO address? The
> > > "ath10k" compatible says it is SDIO-based & the other two compatibles
> > > seem to be MMIO.
> >
> > Yes, this is correct. MSM8996 uses PCI to access WiFi chip, MSM8998 uses MMIO.
>
> Thanks.
>
> A SoC-specific compatible sounds like it would be suitable in that case
> then, to deal with integration quirks for that specific SoC? I usually
> leave the ins and outs of these qcom SoCs to Krzysztof, but I can't help
> but wanna know what the justification is here for not using one.

We can probably start with "historically established" here. From the
hardware point of view msm8998, sdm845 and several other chipsets use
a variant of the same wcn3990 WiFi+BT chip. The actual issue is in the
DSP firmware, so it can be handled via the firmware-related means.

On the other hand, I see qcom,snoc-host-cap-8bit-quirk property, so
one can use DT properties to describe the issue.

-- 
With best wishes
Dmitry

