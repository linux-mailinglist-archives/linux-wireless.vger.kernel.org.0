Return-Path: <linux-wireless+bounces-5198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5988A8AA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538F41F67927
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22E1474A5;
	Mon, 25 Mar 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QRUuEYaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D90146D6B
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375767; cv=none; b=oa8WnwO2kwOCNtL71JWtmUh6564/q339qJHzEZ1L8bPPHF5wou2TEI96NLd0sHtm9MBOAdXWIYxSfkPO3VOTdnzp2y9xihFShzs5DlU9RN/YtbogiFpQ0J9RLqHfPWUIPUrBApZXD0r++elmu4ZMefe1WeDTVHZNBC2Jnxd5aWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375767; c=relaxed/simple;
	bh=Q186ZwCP59wb65acR46Ym/x35a2ynPh5L0W6/TiLR8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utznHyzdfsl+QmwB1HfZ6aDWxWJzva3VDJ4Zo6zMbG5TrL8byfa1M/I8iUmBEayYwY3Ivtxp5U2tlRoPMSbF/JGkwAw52JUknAfIBCtniKNNwvQT3GKGuZwBM8Cma8NCyoAv5on/eBMUq61545MpLrwdT5raoxLEmEVV2KOSRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QRUuEYaJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so53312241fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711375764; x=1711980564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfuObMCkrCoZSR2Wc4+k3mUI6EGOtW5n3H7jAAQzsO8=;
        b=QRUuEYaJWrnftGnBemS05m1T5cXGEomfYiCsWFZXCjdNRXCcZmsL7BZLlhWiRCN2vu
         Q1tHYVdnJgNpynusyfNkbWelCltqFsu9g5EqJ/ZRlLbYnpPEKEvdEdzcOKfvKrIEfOkA
         1EjcBYVy51FpDVJX6F7TGkFVcvqn3unil0+D6Cat2FVJprbQGuoJhR8reNm33dp7amG6
         JDgQkuWJgVtyK+r+2xxDneepDbxQKIqJSLbXjJ8Zs2Hyz2hvKGhEs5C+QcwZTAxHCNBp
         j+2JWTB6vMEWp6de1QHco2cs55wikJo0Pd0PqTKnLqE2F1AjU6nGBEDCzDasSbDML0/8
         j7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375764; x=1711980564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfuObMCkrCoZSR2Wc4+k3mUI6EGOtW5n3H7jAAQzsO8=;
        b=nmB2H2PZRWy3Aow38uuwsU35ZN7zdV25XuAVViPOUSXQpHf6zXsMXZaxM93Z1bm7La
         E9Tx7Yudq7Xn1RhbGPGyOXTOGQvsOYqdD7j+Jw8h9Aycr1UvOLj19YjybxOTaIuHL4eX
         B7nxDHy+eBWlGGzCu5/X6rIGing3L9YQF8ZobVw+a6kytKhzNtmicYGnlOEcv/lDWCix
         T+zmxFhieEWodfYXhwhKmHsVNX+8VD0IISAsNpQabOKAoQnaJPfq6sf0InJyKw96/JNk
         GQGGEdofcC81M0DN+fr3P+1DkYHB08IMTQnh7arR8SSIKphKPtYWXByu/dVHOdsURLnZ
         5yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9QELJVC5MqMJPtPbDPdAw4c+VRbSLqk5gfdsrAOjVitr5+xLFBkpjNZu1gTtHswEbFJDyqjmPfZRg+DSKSYhqzQzpk+G6etlv6Itb7oA=
X-Gm-Message-State: AOJu0YxV2hmGsKWy4BK0YXXumc3k/MoL+HtWaAGlFY4J+myIVoWPMhqa
	UMNC5R7uGVqy5zsuBcrvMrwLdeMbn8PL/6UQ0xPJiT0IiK/weVpaW1bUCyEqZvLtV+MUpUtP11x
	AWlcNDKAiYlmG8pESiHctN/LZGATXuz58efzMqQ==
X-Google-Smtp-Source: AGHT+IEvJFLfJKGkEqnYgSEId2a/oSfTm8lmiWB7lZbWVsuHFW1Kj1Md8cKVyFWUl5FdFvxVvX1pTsDznN8+aT1HRMo=
X-Received: by 2002:a2e:a590:0:b0:2d4:62b7:4c7b with SMTP id
 m16-20020a2ea590000000b002d462b74c7bmr5582449ljp.51.1711375763943; Mon, 25
 Mar 2024 07:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-5-brgl@bgdev.pl>
 <87r0fy8lde.fsf@kernel.org>
In-Reply-To: <87r0fy8lde.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 15:09:12 +0100
Message-ID: <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> > power inputs from the PMU that it consumes.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> [...]
>
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: pci17cb,1101
> > +    then:
> > +      required:
> > +        - vddrfacmn-supply
> > +        - vddaon-supply
> > +        - vddwlcx-supply
> > +        - vddwlmx-supply
> > +        - vddrfa0p8-supply
> > +        - vddrfa1p2-supply
> > +        - vddrfa1p7-supply
> > +        - vddpcie0p9-supply
> > +        - vddpcie1p8-supply
>
> I don't know DT well enough to know what the "required:" above means,
> but does this take into account that there are normal "plug&play" type
> of QCA6390 boards as well which don't need any DT settings?
>

Do they require a DT node though for some reason?

Bart

