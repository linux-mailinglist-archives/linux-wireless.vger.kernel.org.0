Return-Path: <linux-wireless+bounces-22018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12FA9B809
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73053B89D8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AEB2900A1;
	Thu, 24 Apr 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtuyTswE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6D28FFD5;
	Thu, 24 Apr 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521511; cv=none; b=crZdeoBd7+CZuasM/4nUyFicmmlWFWUp0zUQnKhOoMtAKCLQkRm+O/9fT9X0KDMelBOHXvvEMXfnoKIxltZD3JlgHtuHKYJ9JHL252asBOoIWukhteghNtjvC97nqPw/WxiBXHM5DzpwUOrY78gz4f/SVwmbc1cb0wd8aXR/0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521511; c=relaxed/simple;
	bh=Sm3N+EFDuoJzdqd1YhzgxLoS15KUYF+jl7ejRzSDu/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb4jGitkMp8TNgwWRqA4W02Siq3zeqcrdXY11RFZS29Rb+XgKYMG3TzL2R1GwR7iMdpj9jsRms/FU/7gSC+o59/jTC8ZdjayZ4VfNz8R4l15KHM73AbKHxLS5yfz1QFuxGOas+Gaa/NRUz8XVwZg9EOHptZHhLM3eM6+BUxzUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtuyTswE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0688AC4CEE3;
	Thu, 24 Apr 2025 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745521511;
	bh=Sm3N+EFDuoJzdqd1YhzgxLoS15KUYF+jl7ejRzSDu/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KtuyTswEq/d9ogf6clbFjqLdijhnwWgmrCSHLZDwopx250NPh93izNpnCpJAPKINI
	 TnHcBzoZDFzKmCWZCh4EtBlYvj1Iul6E9I6RiUgEqgpfU1bAe73+9l++Oxn+9+w0Jt
	 26JG1mXLhp+XWqEJBujYNeW2AiktpTT4hMaH2mP9mC2pgmX+WNAO3CzQfdYz5RXkxz
	 3WCkJoSaqqVJ5XhjKIaVHRAxJGbQ1m84advQUHWjGTKDPE2BdFMkajlqV6iQ/VmiSf
	 xA/jIPzG7jgR3rFyoYu9P/MIjLZGOZuIkv2wcO82aAzcU9PQzVHy/lRj7ecMtMwd6K
	 iipVWf06+4aIQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so2734124a12.2;
        Thu, 24 Apr 2025 12:05:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ3Xuy4Oc45vU8ojl7vUPEHbVJhF1iKA2HFtMjUkXfSXc/LmIxYkfTG4lrmaeyFLiB7+TuGpw/s8fLODw/Ww==@vger.kernel.org, AJvYcCW6gK8wOa8Ham8AjBsgvwbDWO9KD62DJ+ne42fgnbeA66oDXS8tGoicHPRQ4Ppoe+YstymcPv3sWsQ8Cg==@vger.kernel.org, AJvYcCWW279uWhfkQNf0JnlMapIMue/lK0BZkiXihhnu9B0ledgIp0kxXr5AG1HCWMU0zRAmPvWbFUAfosFxnKm9QXM=@vger.kernel.org, AJvYcCWobk4qWOLhU9uX3198LbkdS6M8rl8a7i6xwJD9IHqKephSApK23WYTssLnIrbw3DJ/OihQeeJM@vger.kernel.org, AJvYcCWynJTG/3x9kx9Mih+bYFhFTFOa/i+hQ028P2Tlv5pTII4NyM4B/RzfPQfYqOx9aMZtcxPrBqtFPpiwYvg1@vger.kernel.org, AJvYcCX0v1mWV75PTjnNsclUkCYhTOb0zjl1wYjaKM8OpAzQwRoNAKo/Bb/ByZWs9iktkcPF3ZxWRAXKvVvt+ZJ4JgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1y2Ezz/4UIqT5H13xMhbYs22qY2bdG8oSiulx0G/8RZA1wvf
	E20ntuaic+rk2aiK2VIn2nisQBIlhFiiQGcAGcQHECQFBiYuBw4KmzeoFkN4dH1Wa2Vth3zdPS5
	v1u8IBGed7ewENsnaOD4vf6i5Ow==
X-Google-Smtp-Source: AGHT+IGm7lm+b5Mr+cnYEdSkB8OI56BIVMt5nL9APzOm0qOr/4ImpeRmdhZ5NAUq0UWQDbHi8kbmShTWjc6+am4lBiQ=
X-Received: by 2002:a05:6402:2686:b0:5e5:b572:a6d6 with SMTP id
 4fb4d7f45d1cf-5f6fabcda3dmr535218a12.10.1745521509605; Thu, 24 Apr 2025
 12:05:09 -0700 (PDT)
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
 <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com> <4e5d875c3f666be8d1c72fa19f6237f21b24f7ec.camel@sipsolutions.net>
In-Reply-To: <4e5d875c3f666be8d1c72fa19f6237f21b24f7ec.camel@sipsolutions.net>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Apr 2025 14:04:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHdw5XOz5PLUvTZLVA0mUQTyGuqnXT0WTLTqNh27VWAw@mail.gmail.com>
X-Gm-Features: ATxdqUHcl-CocjTcGXsOgyTDuLgwr5CqEc9QLMguz9q9ZTXAuu1QgWqCyAOM0fo
Message-ID: <CAL_JsqJHdw5XOz5PLUvTZLVA0mUQTyGuqnXT0WTLTqNh27VWAw@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 1:39=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2025-04-24 at 13:26 -0500, Rob Herring wrote:
> > While it seems the reviews of the series caused more warnings for
> > Apple, in general, schemas creating warnings is not breaking things.
> > In a way, the whole point is to create warnings because if the .dts
> > files were perfect already we wouldn't need schemas. The main
> > requirement for schemas is only that they don't create warnings for
> > the examples. There's still too many for .dts files to worry about it
> > (and there's intermittent warnings from things getting merged via
> > different trees).
> >
>
> Oh, sure, but now if you want to apply the fixes you probably have to
> wait for the broken patches in my tree to percolate all the way through
> to Linus, then back to your tree, and then you can apply the fixes?

No, I never take .dts changes. They all go via the individual platform
trees. It's a bit weird if Krzysztof refers to the commit that's not
in the linear history, but that shouldn't hold things up. The issues
exist with or without the schema change. They might even be backported
to stable while the schema change won't be.

Rob

