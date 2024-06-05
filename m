Return-Path: <linux-wireless+bounces-8524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A78FC762
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ACB1F2165F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A218FC74;
	Wed,  5 Jun 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2SVO9602"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753214B093
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578799; cv=none; b=cEId3RaTMucMRb5nqiUepzDsMDYjLmL9Cy5N93Vr1q7F2eSuNY7nyf4twly0FlbI7Mrw9EY3s0hvqQzq/v2gPKzeDOblzZtK0FiDZQfCG+ROw42bBXr4idMx2N1dy5zXwP2jfkSU1Y6bz40CfL2brXh7KwmmhpkADIARtzOuyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578799; c=relaxed/simple;
	bh=AFakv71kM06p0q3oYAQzeRow8V15P35z1h8kfitwLYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaZaL0pvyxx1tbxcj2LYKTC5m339digYtK4f+CDLLh9yk+VcS/MvmLZ+YlFW/eipUfypes8TxfZBR4aNFJV83t0vV2hqfDW6GgljQRWw+eZfic2gM+2hk2X/z9hBhgqop2eqPOn0AqLjXgGteoKM9g6sCqGiWjbvies++KqfOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2SVO9602; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ea9386cde0so66730841fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Jun 2024 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717578796; x=1718183596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c4YFpd8Fm+Esjyb3eXLbvb26s9zAJBJ0sBTmfOcoOQ=;
        b=2SVO96020zsJW3oJBymyp4e6hfylB/HZFX48nO1GS+XKJVBKQq0wdZsIUdelO4ZyKe
         SQu0FXL/8HyyEj+CJk3nsUpE6PycFoeR8rrHr465kRj5JHqfgScdEXHzZC34rBbigV+b
         EH3kFuP2zyWGGjd91iSqrfikkXRu2M5Z5boa+1iEVT032LUU768k/3GpyJ9CFBmKJJsC
         5I0lAlaoagW20dzf/3vzsjRMNR5bgeLPWssU/99Yhyxv/4rA63N1jc84nG1XrLSBiCh5
         9KDm4lokoOLPbb1HfUztacDkq7cVE4iDKGqYzK7RRUKk23O4DD3GOq6iJawg7HEulqdJ
         /RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578796; x=1718183596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c4YFpd8Fm+Esjyb3eXLbvb26s9zAJBJ0sBTmfOcoOQ=;
        b=jBFScVu0TQksdos4SxHTEIKfJkd20L769sHFi661e5DDHHA0vJEC0TSwOba7FZmAJp
         LLYB/kgWRhJqqIHwGZpP34ljX6F1+sKd3ZnHFtm05Kj9UW3PzoGORPp80wia4FxiVfzN
         bav3gIHGCSvW/SRUc5+juin7huI6/hhUYDAXZr+BehLGycMVb7TwmCdiBTtljHI5n1vQ
         KVY2CdA5VyCnGYIjvfkp6SoiznwX9kjT67Upe6lS6UdW/Ld7NcMtcpvlzwnIPE06Yxqw
         TWZSdSngnTf9rmi8YrMscaVcymUU91dfTAsC9gbaNv+ja6lcPBg+l/0JN36X4wKXVIny
         +WJw==
X-Forwarded-Encrypted: i=1; AJvYcCUSKypPNTjKJn03wT/ion0i7FGVqvbeMgErJzSWvCAv97EN/9UbFmLV3jQK3tIdnkdO0aVapJ9EcYu1eBduLr9dzMI6VK9uvBs62PgmCFc=
X-Gm-Message-State: AOJu0YzNlsHjKM06UPYaodpqCVgnAsCXxYhPyYBO/AzcAHocTUgZ4xVb
	Pa98soPfxKYQhQzPeFHYdez1dkEnvs0wLhJUpO5uOiiKgXyKeBhLQtl5ykoi/yvT++m6kInL7+S
	qJY6bTEXOz50uzXfEpShdPndGroeUumS/Ww9VrQ==
X-Google-Smtp-Source: AGHT+IE63vGTd6+j21cBJUHSJYSLK2xCKb5rCCgsCKhs4EXyLEAsob0AZ/LylbrE5cvmoYjm+qi2nvoKP8Y3gZgS3f0=
X-Received: by 2002:a05:651c:30f:b0:2ea:7e50:6c94 with SMTP id
 38308e7fff4ca-2eac79c1bbdmr8705551fa.16.1717578795960; Wed, 05 Jun 2024
 02:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-1-d354d52b763c@linaro.org> <20240604173021.GA732838@bhelgaas>
In-Reply-To: <20240604173021.GA732838@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Jun 2024 11:13:04 +0200
Message-ID: <CAMRc=MeNPvZUyu6rtsWtdvXFmOOpmjKCEpkoc5zBfJy6qBpxrg@mail.gmail.com>
Subject: Re: [PATCH v8 01/17] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:30=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:09PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The QCA6390 package contains discreet modules for WLAN and Bluetooth. T=
hey
>
> s/discreet/discrete/
>
> > are powered by the Power Management Unit (PMU) that takes inputs from t=
he
> > host and provides LDO outputs. This document describes this module.
>
> LDO?  Again below, but maybe this is obvious to everybody.
>

Yes, this is an acceptable abbreviation to use, it's all over the
bindings and regulator drivers.

> "This document describes this module" seems possibly unnecessary.
>
> > +description:
> > +  The QCA6390 package contains discreet modules for WLAN and Bluetooth=
. They
>
> s/discreet/discrete/
>
> > +  are powered by the Power Management Unit (PMU) that takes inputs fro=
m the
> > +  host and provides LDO outputs. This document describes this module.
>
> > +  vddpcie1p3-supply:
> > +    description: VDD_PCIE_1P3 supply regulator handle<S-Del>
>
> s/<S-Del>// ?

Eek, bad copy-paste.

Bart

