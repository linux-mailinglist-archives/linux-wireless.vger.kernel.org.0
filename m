Return-Path: <linux-wireless+bounces-29991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CBCD1E22
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C534300CB90
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6BC33DED1;
	Fri, 19 Dec 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaaSyuTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955633B6F8
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177786; cv=none; b=PCH2NlIJWL0Rb8cVfSaxgJYAaspJxhV2QDX2y+pd58uWBRZweDrlz1FWCRbWkANIVvErqbfzrs+NdCDlhSR0rftzmoQAZY0mzngATVWh5PBmpxdqC1uJpeuSXbxXBlsQPtuMWxWkAixesYOU9Z1edNOb7C8HGeS/I2K7Rfkzhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177786; c=relaxed/simple;
	bh=i3Vnb75W8CfJzDnDxCk3fIRFIT3WDMCJ1BDdD071/aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqyrQsKVxfVSp3jVzMmiRPrJ5wL15as5EONsyIR6lzL1G2dgnd60H0/lpnkpt6wADbXcxNtUAsnOQC4tYRNP5/G9jm24NTn6nr9T0FO3FnH7Y5e2FFc25T601YTOHgzijNET6e1VUlLsQFzlhvQpUzG4tUW5sCR6MOZT6orTpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaaSyuTT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a35a00506so31526466d6.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766177784; x=1766782584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3Vnb75W8CfJzDnDxCk3fIRFIT3WDMCJ1BDdD071/aU=;
        b=XaaSyuTTgjeiPXXr+5iCBGk+qrr6tWD3XNCE0Z/P8donYTHVj7XCPNsb412WZqAZU5
         o/cHLQ/jYP65srDFn1t3sSv3rAXo7VTtITTyIUf9n5m10XEun9NoGbf8PeKUtE5cSUfp
         syX3FEbAdllnLjCZKMCnAe0iRFRFyMartIn7MJSu5fvwnTn4R3x7ExW+c6+shm7mtAA9
         4MAPlzeG1quQ64gX9KTIUAYMuhU7uS5T01l7c63su5ZXHUNye/5pXlxsmUoJ4zS0yhZ6
         csUt6P42T2ZGZgMb9uNG0qLBrKF0yEss9bOtzp9CFG4s0lzdoLKejt0NqZ4XIenHkV78
         Pd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766177784; x=1766782584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3Vnb75W8CfJzDnDxCk3fIRFIT3WDMCJ1BDdD071/aU=;
        b=Xzeq30y+F5OGV9LTfUMwhdQ3IhzEn7nA9olhONnH0wGBJMz9o+tOCATrINFbdRuavb
         lP1rVSyaZIpeFhlaiiYvFnf3wwykZg+U563QFfN7/LWMhoOG4FmN/DHP9OiU6KreFc2n
         cwh/wuUFItw4o8wFDEc+oIxlQ2LcIxV4hL2KA48ghYU2Pmwt+I+07RlDY7MOObcng1xx
         u2DXqizpvrDA0qPWEpeQCUlJG+3XL5hSmKaQVvGmVx6krMeDG+lz8OqMOxeDjrOGjYdd
         YWIUaM/vFXbyXN7E3Zy6pwuPXQ3o+P8cvYhiFJ6qn/sHFCvaEn7IREpyD/Gjgt8lCOLy
         7EjA==
X-Forwarded-Encrypted: i=1; AJvYcCUoBqj6dUYF4X++Z4Vnz5jVxGoAOQE2FKq+5/F18kHA5CieUwZsLGsru4iA6KIK41ja/LoShBCdyG/FTX6L+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QwRQAkX+DWC0F+mDDwQYu+u5/X78r0Cc6oSlHU9YgDoo0XdC
	B4nsU5c/kY0kFwjic5H/SRT6mXeqPheuIjuc/ARWZeHyRNaC7+XQ5VR+6S/nKZOw2ewt46k1aF8
	YGSFz7YLcSxtjwDQgPQR82WH41xYILA==
X-Gm-Gg: AY/fxX52RanO3CYZX557wjmCKrQsj/eQSSuJPTG0uJoDgAieXliEL9M9ZanPZy5RT4m
	E3Odfbe3rvF6mBTmcRLLeCVc9aZe2PwQ3BEp/TwFVusJH46aYx78J4J3dhw2w3TIe45qoR+XcL8
	NIWaeQWBcoNIjm3FMR0NTUsSdpzQmKIY6BexBQadA3Q4ICyvhdYn3fRgK/OITvrUBACISezjb4F
	ysrMv+zg3/2mbk4ZKulp7lTs2LiZH/XcrUGOPmXGWQ1+fSzu29zUo1oMfF6bnyeeHzA6omWCkpv
	g63RwKC4Kt9bpG7pHF4ylfRqhdk=
X-Google-Smtp-Source: AGHT+IGQH6VIaRGaIEOqpyUgjkUaKG66oDPn1z9oy8qj+n60mmZ/JwdsKN6CJzkL/LLNCeXKogbMXa71ZR0FC4qCU1E=
X-Received: by 2002:a05:6214:4e85:b0:880:47e0:19e8 with SMTP id
 6a1803df08f44-88d83792f32mr72964826d6.42.1766177783822; Fri, 19 Dec 2025
 12:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
 <20251218-surface-sp11-for-next-v4-5-7bcf83c1504a@gmail.com>
 <de00f21e-7fc7-4caa-93ec-afbcc5d9e12d@kernel.org> <d4a87f75-92a3-4c09-9f9c-e906f0b7ae70@gmail.com>
In-Reply-To: <d4a87f75-92a3-4c09-9f9c-e906f0b7ae70@gmail.com>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Fri, 19 Dec 2025 21:55:48 +0100
X-Gm-Features: AQt7F2qYuzcLI8NAKl_7FuywvK75_EKSOb3h7eO67Yd-AWYZh8w_fOHJFdfFDTk
Message-ID: <CA+kEDGGbfXYXwkQcouLJHF3uBv+sPKdG8BE8PEGvVzgwWn_nYw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add support for Surface Pro 11
To: Dale Whinham <daleyo@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 19 d=C3=A9c. 2025 =C3=A0 20:27, Dale Whinham <daleyo@gmail.com> a =
=C3=A9crit :
>
> On 19/12/2025 17:47, Krzysztof Kozlowski wrote:
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights res=
erved.
> >
> > How exactly is this copyrighted by Qualcomm? I don't think Qualcomm eve=
r
> > prepared DTS for this, so can you point us to the original work?
>
> As mentioned in the commit message, this device is very similar to
> Microsoft Romulus (Surface Laptop 7).
>
> Its associated device tree (x1e80100-microsoft-romulus.dtsi) was used as
> a starting point for SP11, and so I felt it would be courteous to keep
> the original copyright notice there.
>
> If this isn't appropriate, then that's fair enough and we can remove it.

Dale answered for the denali.dtsi file but your quote was for one of
the 2 .dts files.

For those 2 .dts files, it was kept when splitting our initial single
DT into 3 files. Thank you for pointing this out, I will only keep
the Copyright from Dale for them in v5 (if I understood correctly).

> --
> Best regards,
> Dale

Thank you,
J=C3=A9r=C3=B4me

