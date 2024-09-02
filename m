Return-Path: <linux-wireless+bounces-12327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9D96820B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E471C22141
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5B161310;
	Mon,  2 Sep 2024 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ufI/dgqz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78873176AC3
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266063; cv=none; b=lgXn+5frKI5o49Bmq3/I5yLqWznDfBzNHc+1tGcqk3k0mMYwDKOOubmojR7RfM/Xx+3n13z/4LAUdALA28q3M65GdTs/1b25BPjyfsgJUWU0hGtGO/bmVajLjnS9EP/pFX+ZgZVcAHD9DR0MvPFWbeFl+clP+ZjvK+dW2rF1Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266063; c=relaxed/simple;
	bh=txgND3gwVKn6mjB+PMDD7QdLkXKhRLtMsD4C90K0ZC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hng+/sAWd1skIziN32TxzjhyOSLQfsGfomC8Tbwedk7GsZPs9NQxPyj9Z2hzWorMRW8XlBhM0XwgjgEPgj1uSroZeJIVYxSHXzFq1ferqAOHMUQTRCTcEVw+MGABAHrcfhR02L6uVV51CIuFRWTecJc8zFIwIo2I6KzNjvPJkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ufI/dgqz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50966c469so44042401fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725266059; x=1725870859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG1MaX9Wixqm8LX4jVIjxRtWDElDhiE8Ho1xpB08+bA=;
        b=ufI/dgqzjBePBCsR1bnDU8O03jxZPZ3AlZ0Pz8zipgMY5lbHchbtJqeLNUMM/A6b+i
         1BbSnwvEqnCNk4nEiQbqxoI+2l0ZmIK+q5C5kCV8XkqaIthD3iaXdniqDbchCaznUlXu
         2XS8izELJLhjKBX2aYb3uvRmz5NwXQ810A5ZmdOhmvrKMhWofPEZRF3j6n1pP7pMHtR/
         u/cnYRwVKQ3v/TRlQnwpI82b9xMgGjFLTZeairNND6/VUgUhj1svBI8HoA8Gfwt2xX6c
         bOYfi4ufpvr3HO6cDNCW5t84BBlorpAjOWzfZviw3XbiUuYr6GU50WpibpDtALv+Y6yh
         9ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266059; x=1725870859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG1MaX9Wixqm8LX4jVIjxRtWDElDhiE8Ho1xpB08+bA=;
        b=vl+osvjPe/uI6vjoq7h9DHID/jHp5SlM0YJtMqUklogpZ/jgcEDQulVTWWgd46AGjQ
         q+TAswPxxUfePBGqNtkKDw+GIQOAvXNVKsbVBXYpb8/B43csi9PNY9IyA+bK7zAFJFvQ
         ZSTj/67FNlRD1MZ8kogm51rphJrtUrXK4XOobOesoIiRMqRBh7HyawqJrhI4UY3AV9EO
         6xFbEyhadB6blINV/jcVwjmlsfn3qANHobnbY7R3M/zEw7LyMP/KEEvXSlY8TkqzInrM
         xyR8+ofLuBaY87t4370eZawGG7PRd4EUZh9+zMjQsz1iJjMqh/KIowMltE6l+gtwr42B
         e/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVHG1Vp3aNcwCfzt2UTWmwCWZI7zFbqKZL5S93NjwCDUQJy6BK9CCvqaduv0YAXRRjYShpg5kjcseGXXDc4dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJBJOPjI/mKFfdKMcItGexS4T749vnic9b4RdZT8n2ptkKAeE
	hUAifBMn0uTVkByRRK3FXyrqAb+giXj30A7VDVETIxjtmRwMyh+il45JZcLAzLcCQnxtuXgklZ+
	SN3Jfoft4p7gcP+RYuIHLVH4Baq7K4OnQ4F4CSw==
X-Google-Smtp-Source: AGHT+IFZPkz+zpegGiynrc/uuNxJ0ov4qqo022LeyJfV540+XBhmrJitjFwxWZA+2HM3HGR7rldq/MxJvLLQLrQlwh0=
X-Received: by 2002:a2e:e0a:0:b0:2f5:136d:89ef with SMTP id
 38308e7fff4ca-2f629063f04mr32120871fa.22.1725266058091; Mon, 02 Sep 2024
 01:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org> <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 10:34:07 +0200
Message-ID: <CAMRc=MeuB1yhENHXqLxRf8xFNm7dYvjLisa7zsd6_2ov_OPw3g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:10=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Fri, Aug 16, 2024 at 10:26=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wr=
ote:
> >
> > Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Describe the inputs from the PMU of the ath11k module on WCN6855.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > > v1 -> v2:
> > > - update the example
> > >
> > >  .../net/wireless/qcom,ath11k-pci.yaml         | 29 +++++++++++++++++=
++
> > >  1 file changed, 29 insertions(+)
> >
> > This goes to ath-next, not net-next.
> >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath1=
1k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pc=
i.yaml
> > > index 8675d7d0215c..a71fdf05bc1e 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.=
yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.=
yaml
> > > @@ -50,6 +50,9 @@ properties:
> > >    vddrfa1p7-supply:
> > >      description: VDD_RFA_1P7 supply regulator handle
> > >
> > > +  vddrfa1p8-supply:
> > > +    description: VDD_RFA_1P8 supply regulator handle
> > > +
> > >    vddpcie0p9-supply:
> > >      description: VDD_PCIE_0P9 supply regulator handle
> > >
> > > @@ -77,6 +80,22 @@ allOf:
> > >          - vddrfa1p7-supply
> > >          - vddpcie0p9-supply
> > >          - vddpcie1p8-supply
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: pci17cb,1103
> > > +    then:
> > > +      required:
> > > +        - vddrfacmn-supply
> > > +        - vddaon-supply
> > > +        - vddwlcx-supply
> > > +        - vddwlmx-supply
> > > +        - vddrfa0p8-supply
> > > +        - vddrfa1p2-supply
> > > +        - vddrfa1p8-supply
> > > +        - vddpcie0p9-supply
> > > +        - vddpcie1p8-supply
> >
> > Like we discussed before, shouldn't these supplies be optional as not
> > all modules need them?
> >
>
> The answer is still the same: the ATH11K inside a WCN6855 does - in
> fact - always need them. The fact that the X13s doesn't define them is
> bad representation of HW and I'm fixing it in a subsequent DTS patch.
>

Gentle ping.

Bart

