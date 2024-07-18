Return-Path: <linux-wireless+bounces-10359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D49935024
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216A0B22DEF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAA144D09;
	Thu, 18 Jul 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G74C37e+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B561448F4;
	Thu, 18 Jul 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317635; cv=none; b=K5RPDK/3Izw+v9jVKsKlXdtQh1jlawHHUy6WOvT7ry74k6XoJmN9N3Ex65YzSgvKiSXZgDiDcVs1XvLFPz4iMnYRh7WPxBEbDCK76EGwmeGtldWDjLdy3EzcDC9yemSgB3QalSErn0k0cKMNAr9iJ/9PNdLDGID+VPfoeJQQ+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317635; c=relaxed/simple;
	bh=EtSWcsZopK16D9DPDPs9MnpIDDRj7ilh3qtdU3kWjLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYEwBg60KM1KNGxurchyaDYlfmIf/xoVoyvwuM6gLGB+acGDgT31w/nKeiTTQbBb2YD6X+5V7ib2BsaJr07ASR9BlRsb4aDd62T8lVGzlBdileQjv3JWViHrJ0u2jRtgYQGCIh7a8sp8SM4jUKh8trFyD9Hy2JJHSZIALDCUxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G74C37e+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1568416a12.0;
        Thu, 18 Jul 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721317632; x=1721922432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O5FpF2UiLkbwb7WiFk7nvfeS7BUMqQ4dHZRhUE0Ug4=;
        b=G74C37e+Ue7rFUmlIqyaX5aikBtExMRCyEtlREb4z21l8jdlDNurBOs26uvetI5euU
         ap/cCupUnNfyOu2H+20ANsmhUVI0/M/sjy2hkfO7wJy3rpLucgY77PUUvqPYK+ZTEo4a
         Na4+B3ODXKWMi0dFu1CVjHMdku9ulZWBH6YnTcQkrD2Zg2yHt1yyJ9a2EwaZOXFQh+6d
         fEcgRZ0M9hEvYSAASbJ7FoW8SG4CC3GbTIwn0cYE+gWJpfVk5W3T3lT8h1z7ZUKScrn6
         Sm86pmBYrAITl/GBS8hOXzBFU0S1+YBPTa/bymPXeT2WxJEYw3/oJr70d3yvZyb9F1ge
         7yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317632; x=1721922432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O5FpF2UiLkbwb7WiFk7nvfeS7BUMqQ4dHZRhUE0Ug4=;
        b=mweFCT8bW7SETynqdXXmBgdJNslypmAcIy71VqR2EzyJVbnG1flsV4G2Wwc0E0HDU9
         loUfN4fwZc4D8q+qVv/EBOjtFQN/siteZBokbzyTdyX/2uQaLOgj+kRYwpc1yDDmGLeN
         h53ErQ/XnR8wZmVMA4tjmPnwzRTUmsBB8o2CbPo85EQgEV4Of5X+nYh/35sXdSQyAk+K
         60uAQrgQRJDE0klWOyUEwd0ya4eRVBtD4va2zGNr2vpAVxP/tBn7nmBeart+NkZ7U8Ev
         qFBAYjWz6hyV0PAbn3hKPNYcWyQ7CaZ6C6pSyf1c/vqAmW1b98RdWW5NAXlioHZ2dom9
         KdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIU6CCvU2wsMWWbk6s1oByaSpBxrDsgTX8tDVLPBCvCi54Xx9eVi/7IoxIiNArDV91WWiMy1mr22fdM9Axr/oGt45luveFxCZm6rvY5/pjo+j7S+nSFmFywYelgP7SmamgYxY9oHO5vQdBtV5blHYhY5opeNf2b4D0VnGKNKBC9tZm3GF9J3+6mHAr6uiryC+TB7p8YXeXwj/xjBSu+phRFjwkDbZOQ/I7gDtLG57qVaKwXMdmkdZrmb//EEsm2Q==
X-Gm-Message-State: AOJu0Ywa7x06eIhwzPpyPONgGpA1mdGBZLC4gwbmekOtg2iB4aPbfMkv
	3Iu0ru+6sejO6V3KYXNWFGJae6AM2m7n9ZYuUY4OcBVF10soHarw6+PDrknKi/1JYPXjFgprN7A
	RGXbB9N8HApnkFT9kWUBFynp17Dc=
X-Google-Smtp-Source: AGHT+IGEkor275ooaElET2xkJh/wMWi5qM0YgC30wYo3hNF5WVOBm2FQ5tOFtC6x8JZXY6EiJPFxP7zqRjzBcUYOtfE=
X-Received: by 2002:a50:c308:0:b0:5a0:edfa:e5a9 with SMTP id
 4fb4d7f45d1cf-5a15617ff0amr3053656a12.12.1721317632011; Thu, 18 Jul 2024
 08:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box> <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>
In-Reply-To: <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 18 Jul 2024 08:47:00 -0700
Message-ID: <CAF6AEGtL7gphh7sY0do6i71JC_kfFm1cNopBQfkzzwAPx=QB-Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Patrick Wildt <patrick@blueri.se>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Steev Klimaszewski <steev@kali.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:40=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 7/15/2024 12:38 PM, Patrick Wildt wrote:
> > This series adds the missing calibration variant devicetree property
> > which is needed to load the calibration data and use the ath12k wifi
> > on the Lenovo Yoga Slim 7x.
> >
> > Patrick Wildt (2):
> >   dt-bindings: net: wireless: add ath12k pcie bindings
> >   arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
> >
> >  .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
> >  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
> >  3 files changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom=
,ath12k-pci.yaml
> >
>
> +ath12k mailing list.
>
> Qualcomm expects, on x86 and Qualcomm-based ARM devices, that this inform=
ation
> come from ACPI.

That is fine for acpi boot.  But it never prevented adding needed
information in dt.

BR,
-R

> That support is currently under review:
> https://lore.kernel.org/all/20240717111023.78798-1-quic_lingbok@quicinc.c=
om/
>
> /jeff
>

