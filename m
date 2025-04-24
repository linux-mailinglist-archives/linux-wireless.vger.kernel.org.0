Return-Path: <linux-wireless+bounces-22014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F10A9B659
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0055D1885FE6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79828F50A;
	Thu, 24 Apr 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKkJpikB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A61F09B4;
	Thu, 24 Apr 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519185; cv=none; b=IP34JmmAW2P+eEMmpgek2UGI3mxcvCFYlvvNiRWwCg+DsHaD8AYC+yxbbefqt1m+NZxmEhMKaAmFfed/L2j99m7qTiISBFroHFfdE7UhVQgnQdzwOG1soOY+kwgUglGJkJMA224DrdUgmGDeP3M1NiB3S3zP7DHOnjk3lNlARGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519185; c=relaxed/simple;
	bh=CHScCNXIVyd/VGxBgYpY/XP42OaAihqot4h2Nj/OKjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOtSmv9lL+lAnO36eJc3IR67wbB4A63JDMxXqJebbNMIlxikrkxgpdqPL+5eLoevtz3OwJ/wloQ4YH+GxqE6j9PlCEAfpJuzRa7RZ1rg/YNbzxebJRsTGWWQwk9+QGwB3MwcZP73raUI6vNfyrx2PcHNXR31dlyVTkATDLfOW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKkJpikB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D8C4AF0B;
	Thu, 24 Apr 2025 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519184;
	bh=CHScCNXIVyd/VGxBgYpY/XP42OaAihqot4h2Nj/OKjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SKkJpikBw8teLtSB7WRreyv1/9vmWXIkN1GViZIboErjPpSRCQSZO114Xo5eFww8k
	 vyJdpZC+gY8mgSSvxGUDRQ82f/bV2ckkgjpkuuPyM2i4MXOaSs1CqUX3as26MjdLL4
	 DP7CY/IZ7Fy/fPk40MxD0/l0Hhx5eZyf2tC5R91d6zLCjlgRffpWWNtIoWnqxmOEGM
	 YcI/uVKhNYRtcXv+UryAQ1suBGv/m0NaCk4EtbiE4o/wKkhySFyTRLxeb5S3Q+X+/e
	 60w3fozZd4TIQ99IcAtdT1d8fKItbK/SWZ4HRFLeKfkVr85nIDNbh+/H/qG2EzJS0/
	 QXyRHmiCsMhUA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso238083966b.1;
        Thu, 24 Apr 2025 11:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDffNfJFi8BSVlMfaMYLvxiFxFWvxoebXfDSV7qsjxMm+cGUofnaV0nAB064VAwM8ZYz0URXuK4m1yNMxkGDA=@vger.kernel.org, AJvYcCVmjGF2MqJDBdXe/YReFReCQDvggrLRHB6XORIAMVOsDcoYy47cdbcn9SRsnudR/hfAhvMen2cySZY1kQ==@vger.kernel.org, AJvYcCWJ7MDsoakZiNsecGKCZ9soPxvGSPXeCKbLinMpZ0nB6Y5Bp2B6Avgdy6THXaUuFA0SCGad3RlXRMM2EhO+@vger.kernel.org, AJvYcCWyXaSZYKalM7xsu7JzzGKjpTk+1NgdCLkF9T1Pca4OVpqAK6riqHJU8kCmN886U7gsDbvOdowH@vger.kernel.org, AJvYcCXKtuPeNkasemhWKLIY0oE1whwGX7lS95Dugtdbnu8CkAi/i8zksur3NgdDbg95pPQoWPaWyxl1ggswtiPVhg==@vger.kernel.org, AJvYcCXlDZhSYdHBElbjH8TzfyuHJ4TikG7rUiznaMfHa7HL7DjfW0x1a+5YAkwpftBlTIeQ+j5bYTuMMcKhTrxbK+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqWPzyj8HAudD8NwAOLthGHHO/PSBJrOFI2LdywFeMFgHpu09
	34Hrcx6c1XhDQgUkGbSl36w547tMvXHkJkS1oAbS1o1pAxMjkrZzUnOfXtsv50V/j7PHZZdTy2u
	9Q80co+u/C2N4hYV53ZZNEO2pSA==
X-Google-Smtp-Source: AGHT+IHcANHsE+bdvnqkb2UnKhC0wdjfxj1hMco6j907XGhULHiQTFKk0sGPEoDGTWQ2tPxmo7m1kava8JyVOdEeOiQ=
X-Received: by 2002:a17:907:944e:b0:acb:5070:dd19 with SMTP id
 a640c23a62f3a-ace6b759bd9mr49595766b.61.1745519183439; Thu, 24 Apr 2025
 11:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
 <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
 <d8619ab4-3a91-467f-a3d4-f23b4e0383a4@kernel.org> <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
 <4b040936baa8fa8669b34e36fe9dff6e08aeede9.camel@sipsolutions.net>
 <f0e56cb2-17a6-44d4-ae71-8639966d565a@kernel.org> <8d8b7c3ad6a67a683abbb4fc6049898747300a16.camel@sipsolutions.net>
In-Reply-To: <8d8b7c3ad6a67a683abbb4fc6049898747300a16.camel@sipsolutions.net>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Apr 2025 13:26:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com>
X-Gm-Features: ATxdqUFdarqKSYdeEAbhUblK1AO9Oheq1fLCxeCtymN54D8OfpcAV5pt8PJAs0g
Message-ID: <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, david@ixit.cz, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
	=?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andy Gross <agross@kernel.org>, Mailing List <devicetree-spec@vger.kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:42=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2025-04-24 at 17:37 +0200, Krzysztof Kozlowski wrote:
> > >
> > > Thanks, I guess I'll hold the pull request for that. And I guess the
> > > Apple ones are on David then.
> > I think you can go ahead. I already referenced that commit from next in
> > my patches, so I hope that SHA will not change (don't rebase your tree)=
:
> >
> > https://lore.kernel.org/linux-devicetree/?q=3Df%3Akrzysztof+%22Align+wi=
fi+node+name+with+bindings%22
> >
>
> Hm. I thought this patchset broke it, and it is going through my tree.
> Wouldn't it be much more complex for fixes on top of it to go through
> another tree?

While it seems the reviews of the series caused more warnings for
Apple, in general, schemas creating warnings is not breaking things.
In a way, the whole point is to create warnings because if the .dts
files were perfect already we wouldn't need schemas. The main
requirement for schemas is only that they don't create warnings for
the examples. There's still too many for .dts files to worry about it
(and there's intermittent warnings from things getting merged via
different trees).

Rob

