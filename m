Return-Path: <linux-wireless+bounces-5893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADB8999F3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A973284392
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4E161339;
	Fri,  5 Apr 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="067XdQO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890D16132A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310767; cv=none; b=f8SoCKY6qmfKdMJSzawETVi9dTTIhbfjRzFGdAjyz2Bz3tnwnxb3DFQojbWvmURvz7Mo53UlOBrNZLtlL76QBMrcvyQ9TpdgoD9M2s66zX+i0+HPQSxhLDcPR1loZyrvqO2R2Ir7MoIX4sz/hsRe/41l/mQoGbyyfZ5WfKVVbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310767; c=relaxed/simple;
	bh=Xao3XwnnM8VJVYj/1S47nAYhy7EFIIHCmB1TEMBpw1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zm4YRyrCa3ocKpfBAvMNQL3Xsd7wZsYHB23J0pKyyr6dFbVSmvZVXRILl6roDiMlXABfVEFayxXewKF+JZwPNw3ialIldi1972wCJYKzZPSwodVtOt9Y/bmT5xnPcGvVK+t646KSV8xfQymK89yYxYEZPiecQgPD+gZD5dNrAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=067XdQO4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d476d7972aso25475951fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Apr 2024 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712310764; x=1712915564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFQ1aSQ/yPIndJu3aWFACdTAkwcoKeyAYdYv4GNLQA8=;
        b=067XdQO4gHy787IaZVrU8QShIADjal3eIQAV1yIyz3d2M0JyTqEeCwT3//IhbBXZ8x
         rgjEviEgwF/s3BizSqRls0C4Nd18WqWoerjO1cJFM1m8saO0kL8fd7ig2b91ZU77KEep
         rC8cSXdPPjLJaWBJDZFvmcYW6aKBRZ5IAm0Nc0PFKLGwV2r2vW+eKpzS3tXNfVLo+IlG
         UAg1syHt4qpuv/xnsRfWCat3aHYibZ9VHbB/jdgSdRiEA8jwOb7FUCQNOzC5D2xWvl1L
         Mb0AxneDB0LYVM8AyRDcCIuE2Dgift4Mijs7lAYUrJpOm3QZAfa/UpdY01KBF1B5ltFo
         lKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712310764; x=1712915564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFQ1aSQ/yPIndJu3aWFACdTAkwcoKeyAYdYv4GNLQA8=;
        b=KYpA6GOAQoX3UgxoqCVnaVzWwwTKqMmEtv6FwoEJ5yrt/EZxaIEGgX1i58rtV799hl
         +RcfTYDEBXoZfYjZgAWbev49QdgFgX7qNnTucU/pXZSqRNfhtRd7TP+DWEiWxRzvGjl1
         I+jBuA72o/8oOe6h0GG4iZUPQYf+kGq6Yxb7VDAzxmGG5HwiYlRvZoyudMG2DfKcZ2+6
         iE+gYXMKfiF3hv6WO/WCof97fgwzvFwMNc3S8+jRGkYaoPkx4s4IGec0W1pmonKwFww6
         2I0FJ3fzaGaB9rby/8CSRhRvLtmDf2RTkbs/KEGJoF6WOAxh4JMqA4BnqgsI4C6Y7Zrw
         9LpA==
X-Forwarded-Encrypted: i=1; AJvYcCVJTfprfpdqFr6Jqe+ZSPQA0aXIrT6fYCI6KVgztvp4Oz5wZcGecTe/0uCT6nMF5oZr3hUDV/4tIBp64QEv8rVx1TejSazNUKmGivlnDiA=
X-Gm-Message-State: AOJu0YzsN7Y1Bjhb3ZCxhqb1NAYdDpS/mS5l+yOdMGUBSzbkayfh0hco
	dFiBFCEYCNKIrEvjaMfOZsuNxjzJp5BpH7l5cnMf8Z/6447ZFtgXG+MsKcGqaGpTjU+YdlAvfHm
	wgPZSzoGh6wV4v/LHJMpnnwH0+6ZLS8d+zcuSPw==
X-Google-Smtp-Source: AGHT+IHFTvgH2ZminO6meSynk+MyIvOEGXYwM8talY5AqWje/YbfLVqUjdVH/aXaf1x5eKBDfACdQBDX+FEmTYh5vE4=
X-Received: by 2002:a2e:7d17:0:b0:2d8:3e07:5651 with SMTP id
 y23-20020a2e7d17000000b002d83e075651mr1024297ljc.34.1712310763809; Fri, 05
 Apr 2024 02:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-6-brgl@bgdev.pl>
 <87msqm8l6q.fsf@kernel.org> <CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
 <87cyr440hr.fsf@kernel.org>
In-Reply-To: <87cyr440hr.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 5 Apr 2024 11:52:32 +0200
Message-ID: <CAMRc=MdzhGxLNcNLWvRfqr0S9pey-iw964=AcYx_yDXgyDDjMA@mail.gmail.com>
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the ath12k
 PCI module
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

On Fri, Apr 5, 2024 at 11:34=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > On Mon, Mar 25, 2024 at 3:01=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
> >>
> >> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >>
> >> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> >
> >> > +
> >> > +maintainers:
> >> > +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> IMHO it would be better to have just driver maintainers listed here.
> >>
> >
> > Why? What's wrong with having the author of the bindings in the Cc list=
?
>
> If you want follow the ath12k development and review patches then you
> can join the ath12k list. I'm not fond of having too many maintainers,
> it's not really helping anything and just extra work to periodically
> cleanup the silent maintainers.
>
> I would ask the opposite question: why add you as the maintainer?
> There's not even a single ath12k patch from you, nor I haven't seen you
> doing any patch review or otherwise helping others related to ath12k.
> Don't get me wrong, I value the work you do with this important powerseq
> feature and hopefully we get it into the tree soon. But I don't see
> adding you as a maintainer at this point.
>

In addition to what Krzysztof already said about you seamingly
confusing the maintenance of the driver vs maintenance of the
device-tree bindings (IOW: structured hardware description) and in
response to your question: I don't see any functional change to any
dt-bindings neither from you nor from Jeff. Are you convinced you can
maintain and properly review any changes?

If so, I don't really care, I can drop myself and have less work.

Bartosz

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

