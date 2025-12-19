Return-Path: <linux-wireless+bounces-29993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D590CD1E07
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0617C30022C1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338733986C;
	Fri, 19 Dec 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdC3FLXp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC72DE6E6
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177903; cv=none; b=fbD9OiyFA6OFPlfJt9JelSZErRkYaOvnrHAZQBaHsxyQd+rqdifnC8rbb40a5kHDePv+ai01pzhMZ8yL9vbxlHBFe4QXAqPbqA5RaXIXmdTTQR+GgZ1czzq30qT1gnbIr5plVzkLORQX6NqxpmOPt5l98mv5whuuelXbutAf2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177903; c=relaxed/simple;
	bh=GI0vwFm7IpACeuQ0a/1FT/Ls1BnVN0WU4IFXbwr2GMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecrROgukHtuEfSfQXokzh/LDJQsXdY8FCuQwlrJhayTPr8z7wiAvSsMj41E09hhXSQMvcpyOYUU7l9/C3BKfnYJ0t3XrrbqpVT5Eqe0fa0H0RfZPjk894TeJKUBGC1324/pWhNEc6RHOcftsRGkm4E8ayxLCOwGGUO0oOjsbOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdC3FLXp; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a367a1db0so33827066d6.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766177900; x=1766782700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2mHPlSnjBcdFaDnCQucul1Ba9bLMUO55RhPO6dSnwA=;
        b=BdC3FLXpHekyYdRqG0JNkrtQ6VMJntaTp1wZIRDx2hilL3WSKFWny3Wv1Gnb0ge1RG
         49UAx82j1pjjMV484d/T5k7WbXe0gtm6tjJgiXlLKtE5yp46UzFkp9LtfXL/GOuPz1XK
         4uhut8czMFz+0Esm9wyXeRRSAYhFr8lEn+PDxegTyxdx4JXw5emDA9oJJJ+cQL4L8Vqh
         PJLrdTTDCMKNYYqkWmfprGFnCuEJ8asVmPXCAtX8nVhaWISRwOnHoLKaBUR+3PdUE4jy
         FxrJA3b7EUoh99qeaqmlMhy6OXUBg1HNO+aD8z82anFZ4VK+hMm0YuuxjTGmL8vi3QwY
         xipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766177900; x=1766782700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2mHPlSnjBcdFaDnCQucul1Ba9bLMUO55RhPO6dSnwA=;
        b=GnRW4u8LQtnDQwl8icYSHxbiDZCdLLvPSpP1duhH+9Zxa9ZG6+gaIAPQjL3fAiTBpZ
         RsDWxzZYT/2j4HC5x7w1jez0V2aS87KTT0jsTG33ICkDcurt3HlwDlEroEdh3Lcan073
         x6wAQiAltfH9XeHkclo11btCWhjt4eSopM0QlCl0kvN7i2mWDSYXgz2PIA1tON4AWnYQ
         X1OF0Lojq6GX5B8lFpxGyUuLiT9txu9e+tOXgGGAvoo+LnoMDrhny3sqL4n+fuhUisKp
         bo0oQWvOiP5UFFchpY10lJ+doc74GuH5zFfxL16pRsGWx6Gg8yIP5zsBInvHEAuWKW1p
         dgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV/1wn/fR5WQKs+0zDkWJKKzFlihqJU7q6UaYA3KjxWTtV7PWiIwUoCajs6RG1AerplNARiZc23KhXWl3voQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYaUFws98AH8sye30psJ+cWTRIIHXgNnxftKOBlG4+pFXIOVA
	gsYRonrftxh+oXJD0XoYdtpUCp5GJ8gn/T3YSZ21LoYs8BulDe7K+H+XWuT+yLjRlPZyZkDvxyP
	9n90cn8eJvXZrjmvAawMqXkGe1nLZYQ==
X-Gm-Gg: AY/fxX4ymVyalek8pKdVWeoMd/AyoA8Mmour5PSvCGSk7nWWVWoB9UpPMps26T486Wo
	RENCVPaJQ5w2y0g1vvzEO3Qo8jSDzlCJdWmHqbp5OGCrPr2nAMGautswISFnM+upEcWKY8zbi2L
	rp/yWpCOMsFXjZtpbeZZhd39M0GoOHAI64yXOvzjGqkOTQPNKEsXFQ1tcIvdLZT0q3JeQnbisjJ
	pHb7RWI/KozrHkg8SASG8uqVoZR5065FShwOdvSDxfhrWTC3fb6aN/C5NrwIhSaOaHVuYbQdRXK
	GPehOUY9o9jCkRa/WIoVarTa5Tg=
X-Google-Smtp-Source: AGHT+IE5zXTwVQxrbaPXQC3VXCOoLJhpKpR4tXpdb/7cIMJryLXfVsLBo2c1bVuuXPFjDhO95WFjskd8XdCTxgQXiZU=
X-Received: by 2002:a05:6214:459f:b0:88a:2ce5:a049 with SMTP id
 6a1803df08f44-88d8491cb3dmr66535756d6.62.1766177899802; Fri, 19 Dec 2025
 12:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
 <20251218-surface-sp11-for-next-v4-2-7bcf83c1504a@gmail.com> <9c7115b2-9f31-49e1-a2cd-2071b84fb85d@kernel.org>
In-Reply-To: <9c7115b2-9f31-49e1-a2cd-2071b84fb85d@kernel.org>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Fri, 19 Dec 2025 21:57:42 +0100
X-Gm-Features: AQt7F2pKwyReFTFBW1AkMHui4zZvwtcdzXVXBUuKjfAtNTDFOhMAD_POvY0snFk
Message-ID: <CA+kEDGGsmANidzkMV4=Dhr_tvTYKYNyrU1TBDja40tZ3MygYag@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 19 d=C3=A9c. 2025 =C3=A0 18:38, Krzysztof Kozlowski <krzk@kernel.or=
g> a =C3=A9crit :
>
> On 18/12/2025 23:22, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:
> > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> >
> > For some devices, Wi-Fi is entirely hard blocked by default making
> > the Wi-Fi radio unusable, except if rfkill is disabled as expected
> > on those models.
> >
> > Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> > disabling specific features based on ACPI bitflag") added a way to
> > support features set via ACPI, including the DISABLE_RFKILL bit.
> >
> > Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> > equivalent for devices described by a Devicetree instead of ACPI.
> >
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> You cannot test a binding. Building and other make-steps are not testing.
>
> I don't even get how this appeared - wasn't here before and there is no
> trace on the mailing lists. Can you point to the mailing where this was
> given?

We co-develop and test this patchset with Dale, I missed that Tb:
tags shouldn't be used for a binding, my bad, I will drop this in v5.

> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > ---
> >  Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++=
++
> >  1 file changed, 6 insertions(+)
> >
> Best regards,
> Krzysztof

Thank you for your review,
J=C3=A9r=C3=B4me

