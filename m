Return-Path: <linux-wireless+bounces-25330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB932B02D87
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21081177703
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25732309B2;
	Sat, 12 Jul 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtSyUuf/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1B1F560B;
	Sat, 12 Jul 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752362426; cv=none; b=hGfMU9p8bsD4skAR7W+jcbNFB43m1wVOoAdOdstYcgvEilgUtUA5qAUKJyJWg0W7kAq9U7SgbyX8Q96aZFLdb1snKQsvugW8XLvA5yRSqaJz0miCllNWS5NU4p0o5G7uuaUjcoskSzKpnkKm/JzMKq2rp8jLVYSutBz5drO1R6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752362426; c=relaxed/simple;
	bh=9Y8Fjr7KqkE3E/uJ3c0Bp0ihg+c1iAP3vmMRnvmL9GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUwQGRgmI3mZmVfaYdnePla4iR5r6RSRnZ+/9NjURULJeOATnnFteWDttTGl5ytzt0qMDPIYuy+rgn6ztF++/qK49pGtbRoDmxaq6I63S/mNz10zUeOfUnHJrINONAV9PkgjiJ13J9DgOy1mQ/Xr2D0e6H5+M3wLZWQcu6pG6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtSyUuf/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6facba680a1so39346546d6.3;
        Sat, 12 Jul 2025 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752362424; x=1752967224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJFl78XZ+XY3PQ6hqlxJcMbRGA/vaIbR4su4ePprkx4=;
        b=BtSyUuf/VDY0diQjWosqgShnbh3m3waNqhpbAi66DH5GaeHoilHQlitmciNqXh+4Po
         D478Z16NaWEqmteUrz6t7FH1N96kCdcRr4ExXaUgUe80gbq+y6e77zAIySeMsP7kDCmf
         kJPV+R/xmpSEqb7HdbWODQp7HrVe7MCSJQijNlw9bCc8j2Qxjb5mQ2tyIjOBrvkXKEIj
         0sy08ZprmgDwM6Dr3S3Gcth85adFKmZO4j2hg7ofP6Aza/sl+bI0RgRdhwpJwOQBEFXQ
         4KZp9zmLtJGclR7k/smMD/00y0agY84fwvUftodQg0Tf9ac/+szMEw133BbA3sZLNj+g
         TauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752362424; x=1752967224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJFl78XZ+XY3PQ6hqlxJcMbRGA/vaIbR4su4ePprkx4=;
        b=XaSF4Oeh+yVglS1JR8IxuhWFYM7ge49ZkkQLt7ELshqfPqxuy/c4gYSY2jjn4hEvSc
         qr8FTQAkkUF46ftorQK7iulcZ/LrQcztn72Y7Rf4qLs2dodSWyv6+d9tpK2g9iN37Zhb
         1Gt/hB6oUGI1tCCKoyBIYxdjFn0jC1zWvWPq5d3M7HvJiKI4rBBv7d4tVuiCerlugP9w
         u6xr/vsK7/BHRHFvXyL8wbtNF6qkihbmwUffCYGfWMwrckEPb2SsvSXOyc6a7M+ReJvY
         baBXNB6k2ElWLhHGrm5+hnDbYKNlCHRpenLjoK9xdyFjHf3GHN3uaep5zSWUCrdPNJgX
         XLGA==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ+F9fXXmrjYmuwzz6PHb7vHoIw1OG6bbSdZaZU8/qNvbI2K2UOoB/D93FPdaDApAusvoMliRrnZ9XLTWNT0=@vger.kernel.org, AJvYcCUXm5/aMWGCWA31U4o3wmkDmmkztDQWZs6/qW9/RyE+W0kjVgg9J24LTrMKAPJLd5xrGSBeJHhnv+Aq@vger.kernel.org, AJvYcCVM8dMb2DrYJxNEFHe5SoCU/ns8tnpN56Ak6GbWveNjks5cCAwezyCln81BixEMXGVPeoWYTKlb9/uSsw==@vger.kernel.org, AJvYcCXEvhnG1uudB7fWRcgvxUz1An8qmqhb3cIhaumwrzi0Kb5m1kYkEaflHEZ2yBpcbHN8cy693sYeksjhV2F+@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNUFciuIbGeh4BFtY98XakLoVbHWyV6x40UhgPvF8uQgapN//
	EEJadIwI5ED+daINS3vbP8rbEScQ6xjwjVZ/22Q0Octkor+xVTj0rcvNYqXh3JangECSrR05ooF
	SETE8VBeoivEaUneI+K0giR3mYzSmQeE=
X-Gm-Gg: ASbGncstBhaBTpO5tizQBlHkoy3O4TXa4hw1ezby1ip35QxVkd2ZGjrLy5LXP6K2oVc
	ESiclEGUVBrm0ha+lqM8XJAUFvKFnSshnf89XWxZjnWTJS2rLNSnAOVZ79Vq6w/jRByx1OLLbZh
	KoA6PCvg7Nlf0i+UDnT4Z8v68Yb1gyNIcbK5m04ZkebDUJz2lUZe3gjXiQGQB/FeyFTQxO44gaO
	S7yMoE=
X-Google-Smtp-Source: AGHT+IFxoLdRf98+nAnGYYkZ3v8X8Zabbt4512qKXAZnA97TDHShi9FJhWzH8PYyZvNSK3yat23YgSRK0z1vNWmf/lY=
X-Received: by 2002:a05:6214:2b86:b0:702:c939:9d9d with SMTP id
 6a1803df08f44-704a4220990mr161700106d6.28.1752362423744; Sat, 12 Jul 2025
 16:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710200820.262295-1-rosenp@gmail.com> <20250710200820.262295-8-rosenp@gmail.com>
 <d8b0abb2-1a12-42bf-aafd-4cd1e21babd6@kernel.org> <CAKxU2N-c2tHBYWBM+FJGqdSaqzw9u0O8e0G7AVqk6b0QdRnPTw@mail.gmail.com>
 <20250711-invisible-dainty-jackrabbit-acbf8f@krzk-bin> <20250712104006.GA13512@wp.pl>
 <e435a765-fb91-408f-81dd-01a73fc43b6b@kernel.org> <23e629cb-0698-4a9c-aa18-9a7e71aa8b73@kernel.org>
In-Reply-To: <23e629cb-0698-4a9c-aa18-9a7e71aa8b73@kernel.org>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 13 Jul 2025 09:20:12 +1000
X-Gm-Features: Ac12FXzHmWw2pTYCCUYiI4xo0Q3W3oiBA__ty2FODlbGDbYFA2NA_IcVvNhC2_U
Message-ID: <CAGRGNgVk9__2mCE-hYSP7T0yKLjPsDkvG6+NghJMXazYXUid1w@mail.gmail.com>
Subject: Re: [PATCHv3 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof and Rob,

On Sun, Jul 13, 2025 at 2:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 12/07/2025 18:53, Krzysztof Kozlowski wrote:
> > On 12/07/2025 12:40, Stanislaw Gruszka wrote:
> >> Hi Krzysztof,
> >>
> >> On Fri, Jul 11, 2025 at 09:48:49AM +0200, Krzysztof Kozlowski wrote:
> >>> On Thu, Jul 10, 2025 at 03:40:30PM -0700, Rosen Penev wrote:
> >>>> On Thu, Jul 10, 2025 at 2:40=E2=80=AFPM Krzysztof Kozlowski <krzk@ke=
rnel.org> wrote:
> >>>>>
> >>>>> On 10/07/2025 22:08, Rosen Penev wrote:
> >>>>>> Add device-tree bindings for the RT2800 SOC wifi device found in o=
lder
> >>>>>> Ralink/Mediatek devices.
> >>>>>>
> >>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>>>>> ---
> >>>>>>  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 ++++++++++++++=
+++++
> >>>>>>  1 file changed, 47 insertions(+)
> >>>>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless=
/ralink,rt2800.yaml
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ralink=
,rt2800.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800=
.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..8c13b25bd8b4
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800=
.yaml
> >>>>>
> >>>>> Filename should match compatible. You were already changing somethi=
ng
> >>>>> here...
> >>>> hrm? that makes no sense. Various drivers have multiple compatible l=
ines.
> >>>
> >>> Luckily we do not speak about drivers here. Anyway, follow standard
> >>> review practices, you don't get special rules.
> >>
> >> Could you please elaborate what you mean ?
> >
> > Rosen replied in abrasive way, so I am not going to dig this.
> >
> >>
> >> I greped through Documentation/devicetree/bindings/*/*.yaml and plenty
> >
> > I assume you refer to last 2 years bindings, not something older, right=
?
> > It is really poor argument to find old files and use them as example
> > "they did like that".
> >
> >> of "compatible:" items do not match the filename. So hard to tell
> >
> > I did not ask for compatible to match filename.
> >
> >> what rule you are referencing, as it seems it's not really applied.
> > Check reviews on the lists. It is pretty standard review. Everyone gets
> > it for this case here - single device, single compatible.
>
> BTW, it is not hiding on the lists:
>
> https://lore.kernel.org/linux-devicetree/?q=3Df%3Aherring+filename
> https://lore.kernel.org/linux-devicetree/?q=3Df%3Akozlowski+filename

I just had a quick look through the in-tree documentation on device
tree bindings and can't find this rule there.

It's good that you and Rob are consistent in applying this rule, but
pointing to the mailing list archives instead of the documentation
makes it feel like patch submissions in this space are judged by some
arbitrary set of undocumented rules.

Could you please update the documentation with the current set of
requirements so that people who are new to this space have a
consistent set of rules they can apply to their work?

I understand that Krzysztof doesn't particularly like having
discussions around the rules given his usual abrasive manner, so
having the full rules documented would be a way to shift these
conversations into something a bit more like how Greg applies stable
rules: if you get it wrong, you get a link to the documentation, which
should clarify most issues without any further discussion.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

