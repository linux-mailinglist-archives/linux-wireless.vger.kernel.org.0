Return-Path: <linux-wireless+bounces-23412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89781AC38E8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 07:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4544A17057C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E214A4F9;
	Mon, 26 May 2025 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6RjDzTq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6533DF;
	Mon, 26 May 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236748; cv=none; b=jkSU9OXcgDGiUkIz90s/Tgh1yZRmRGm5NxMdzbmOU1rv41Jnzpvlq0cDcPFZxgG/wdRX3Umi+WaXV3WzIY8fN9H3YsV5hoxKaFyNufjqwCWUCoPrlzbH51Wg1Ja79Q/viIXbzfSp8Kq6xKPIXNy+rJlXyE9qj/dvpqqe8vDU+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236748; c=relaxed/simple;
	bh=OgmGObiPVCk99Mw6Lwjpa95yH8RjYrWJB6CO56SpTq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+j+iwCtdSf+xQVA98YNu2czurLlqzxWj3KJfKSJK45yJ7oY2jkop2X/W7XU4obxrKLy1za+8SkPROHJnX/7kGIGsQY+PlvT5+ltpMisdFLYHTSEwmhNq0gNHgKwPwDJFPbDctxKoJTMRJQpgkAWUR4YTfPja1U4K3IFvUPEKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6RjDzTq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70825de932bso25184807b3.0;
        Sun, 25 May 2025 22:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748236745; x=1748841545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQMsqKsJ1Stce3vL45EhuWBDbGjUQLt0u0NEhPlgf4E=;
        b=Z6RjDzTqz6quxx4fYU7cY1kG8el4D9ph4RQPniHeUN6h9udeU7AKABdS0RR8M8Vzky
         qg1fM0x+lStpx1lVjbtfsQbfjkmvXMkF3GJ0hlIGWZZPOQqqHhrfkt9RbBR1KwNgAqsC
         c1vp4gCf4nQi3lje1xyagP1eI5vXFIJVCXu7PcQqXbbx3t+VOkP8XUWI+o8uaBXR8gfW
         8yUMCf5YjTfyZbdj0D1nTPxyAj0uto6XqZiw7GL2Kdjnska2mFQamgCk5qijP21RzkC3
         6R9/BL+qWqg2yi7hvRdGasSTKkybKaIbl4hNhcdNOZa0JLCr8uU7nZAfz8y9KYLXEgR/
         iJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748236745; x=1748841545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQMsqKsJ1Stce3vL45EhuWBDbGjUQLt0u0NEhPlgf4E=;
        b=L/ZWtpuwiVAolcvyGBM1d4JjBnfD2oCxCHG1i7xpZaOMq13UMb8KGAW5RmIs6bIP1H
         vd915eoKh0xUsdakFVgFDlfPT9VHgHVYnbaZG6SZaG/TJVgLUuN1TS/LQBdw4z4RdzE3
         wU3C+Yrq4Whbbi3Jllon9/hntI1Sidtfmhic36xMeTMmIjcUNae/wZyDcFAlpZOKaUfM
         1qXZev4ZZjUlXfwOkUZbfuO5wlEs8lasrR78WUzEiuFETTq3jvYqHgBDPrtbPe5N8saV
         vEeXZNRVXwbdFSWgqtM+ug2DhbNM+33aRaGHA0IgV+LZqMlMULQAwJ8orUik5QAj6JkL
         Tzzw==
X-Forwarded-Encrypted: i=1; AJvYcCV3i0cguH1Mpcve+HjzeDHvhhgeGpWuK1nBIcjQlryreqWnpwLBT9gk6hVSN22zmCpjcYFnLwpG5SB6mQBQ@vger.kernel.org, AJvYcCWe3Q3gQPAFbW41JEJsmeQfOALzFAu4Xa2zni4io+kFsZ1kL6BXXGQ7giUjPDEXvyjtL8ACWo97jgcG@vger.kernel.org, AJvYcCXnoj64JVjpii4bjYu57gBEsgKBHP9DZDT/jVXFZRyW+I1ZcKPDSLd57KJnw2Fan8CX3N90Xg1rSRD1tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpp9ylhhmPdT48iAOaxrVT9620ByJ9oacNVJ24p21zBXB1VzOf
	wcEQ6Ogz7aHBA9cmP5e9zATn/YG3OrY5SUPMMq73ZLRx4b0FSOU++oHH/yv/7HE/cu6kifV99vu
	Y5m0j4mTa5Uji0D+8GgTjZEVkAlfkcNY=
X-Gm-Gg: ASbGncsdGSn3gjeplAd01mlegpjrVPj9FULoNNX8bnzvL+GTRSM2BNEMkji3tezyinu
	IByAFa0DWNJmtsMdI24FxAw57X7g/T0/ntXikI6k1SEwU77eyZhnuLrcJ6Tq+x6UrgrevrTXqEQ
	9c89NvY6GHlPBi1D47YC7KXhBmZABR0Z5fkRNe69MTJh5OWA==
X-Google-Smtp-Source: AGHT+IErL+qls1X8IoPcJE7qEWqb7o53Tg0Qa52/SEzMjg3lLBXfOBjCqN1gFebfM/yIeGEB0JYbxIr2j4TAqM1s1P0=
X-Received: by 2002:a05:690c:a85:b0:70e:2173:6f98 with SMTP id
 00721157ae682-70e2cb7848amr91488797b3.6.1748236745253; Sun, 25 May 2025
 22:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525214256.8637-1-rosenp@gmail.com> <20250525214256.8637-4-rosenp@gmail.com>
 <7145bfad-16d6-4445-bc19-261c5bdca8d9@kernel.org>
In-Reply-To: <7145bfad-16d6-4445-bc19-261c5bdca8d9@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 25 May 2025 22:18:54 -0700
X-Gm-Features: AX0GCFuQEQUbF0Y0jRNZDpxah3rNr12SLH_rwz8yvaV-4IHIlX9NGVTXpFIZxUo
Message-ID: <CAKxU2N82ju6K3jew171jnVEME76Gc3_-PWnasVPxCmANjpaQBA@mail.gmail.com>
Subject: Re: [PATCHv4 3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	nbd@nbd.name, Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 9:26=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 25/05/2025 23:42, Rosen Penev wrote:
> > These are for the wireless chips that come built in with various
> > Atheros/QCA SoCs. dts wise, the difference between pcie and the wmac is
> >
> > AHB > PCIE > WIFI
> > AHB > WIFI
> >
> > These will be used to replace the platform_device code with OF in the
> > following patch.
>
> Drop the sentence. If we use auxiliary driver instead, should it
> invalidate this commit msg?
Will drop.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml       | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index 0e5412cff2bc..68d56e5b8680 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -12,7 +12,7 @@ maintainers:
> >  description: |
> >    This node provides properties for configuring the ath9k wireless dev=
ice.
> >    The node is expected to be specified as a child node of the PCI cont=
roller
> > -  to which the wireless chip is connected.
> > +  or AHB bus to which the wireless chip is connected.
> >
> >  allOf:
> >    - $ref: ieee80211.yaml#
> > @@ -35,6 +35,12 @@ properties:
> >        - pci168c,0034  # AR9462
> >        - pci168c,0036  # AR9565
> >        - pci168c,0037  # AR1111 and AR9485
> > +      - qcom,ar9130-wifi
> > +      - qcom,ar9330-wifi
> > +      - qcom,ar9340-wifi
>
> I assume all these qr9xxx are capable of running Linux, thus you
> document here other side - having them as part of other SoC.
I assume you're referring to
Documentation/devicetree/bindings/mips/ath79-soc.txt
>
> > +      - qcom,qca9530-wifi
> > +      - qcom,qca9550-wifi
> > +      - qcom,qca9560-wifi
>
> But what about these? As well? Do they have other interfaces? IOW,
> suffix "-wifi" is added ONLY if there is "qcom,qca9530" or
> "qcom,qca9530-foo" somewhere or possible.
They do. An example being the ar71xx driver which has

              - qca,ar9130-eth   # Atheros AR9130
              - qca,ar9330-eth   # Atheros AR9330
              - qca,ar9340-eth   # Atheros AR9340
              - qca,qca9530-eth  # Qualcomm Atheros QCA9530
              - qca,qca9550-eth  # Qualcomm Atheros QCA9550
              - qca,qca9560-eth  # Qualcomm Atheros QCA9560

I was advised earlier to change it to qcom instead of qca. Qualcomm
itself uses the qcom, prefix for its maintained drivers while the non
Qualcomm maintained stuff uses qca.
>
>
> Best regards,
> Krzysztof

