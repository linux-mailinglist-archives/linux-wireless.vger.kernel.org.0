Return-Path: <linux-wireless+bounces-26384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE759B2609D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9851CC3D1A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08282ECD31;
	Thu, 14 Aug 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2LR4MNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0032EAB90;
	Thu, 14 Aug 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162719; cv=none; b=f+V7L9oJslkUcfe/K848Tf+CF6WtKwmGu/TfY2BCJ/3Rgs/R0LYu3rhnT1fF2dp8jNuNUV4xh9f/fWSN8zidRchnclX+ksF+cd33HAlvTjpV3FRBM1CrGGoiuYUEN3QeyAYJxUm54LgNnLZFSRcuwbbLe+EcAxz3Hx1MubZmIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162719; c=relaxed/simple;
	bh=KpPt0fkcfW+EkmwbLOQPg8tnnnTCZmXxVb8az3l0UWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWQG6eA7po+buycmojPcOPgl/40uwpBjaf2ZjkAcPSGVNVbVwscHYnOJPkGozzRcEEvqoAU1m1pqXkxc+9xdB7Ve7endIVv+gJjO1VrQSBr0BbdiNg3Lv+5G2mGJoNcjCt34eLGg0bJKBoSdP1Vhf1XiC45nwOeh9ePqiqVWToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2LR4MNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE0C4CEED;
	Thu, 14 Aug 2025 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162719;
	bh=KpPt0fkcfW+EkmwbLOQPg8tnnnTCZmXxVb8az3l0UWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2LR4MNAJtYja39bXuF6NPDdvuiX3a0LgHExroY+OLXuR7DaBbg04P8zyIRZYShg1
	 pM5wdlIWjMw4ExrGN2JxXvuntQOs6MsH/NKnEskujnZsK3HpI6rMHx1fTUNgvLTihu
	 Ht/v6gec/Mak8UJCiAGVcbzWz7gDaC68lHWR8geteWEZKPD0bEQzck2/HlxTvtOZmY
	 nUx9cz+jBCeXWkU4K1oHh3BNOAFVzD1g6X2eoAvwtUZ5fJxl2uaVxjk1GDjxtEXg21
	 iyCFuJnCPNc6XG/ISzi2Tj4dr5V3qfjU2ru6qXI/xDiboCWp8gZdprsr+iR2nK4WnL
	 Jy5BAUDILqJcg==
Date: Thu, 14 Aug 2025 11:11:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCHv2 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Message-ID: <20250814-dramatic-glorious-dugong-eecfae@kuoka>
References: <20250812192334.11651-1-rosenp@gmail.com>
 <20250812192334.11651-2-rosenp@gmail.com>
 <14f0cb76-1694-4330-899a-7565af0dfdfc@kernel.org>
 <CAKxU2N_vo9NThjGaiX1Fq5jet0vdw390ZYpVct4=XPa5gwj-Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKxU2N_vo9NThjGaiX1Fq5jet0vdw390ZYpVct4=XPa5gwj-Kg@mail.gmail.com>

On Wed, Aug 13, 2025 at 04:04:27PM -0700, Rosen Penev wrote:
> On Wed, Aug 13, 2025 at 1:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 12/08/2025 21:23, Rosen Penev wrote:
> > > The ath9k driver has various pin GPIO numbers for different chipsets
> > > which are not always correct for every device.
> > >
> > > Add bindings to specify the correct number and if it should be
> > > active-low.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  .../bindings/net/wireless/qca,ath9k.yaml           | 14 ++++++++++++=
++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k=
=2Eyaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > > index d16ca8e0a25d..e701046146f2 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > > @@ -50,6 +50,17 @@ properties:
> > >
> > >    ieee80211-freq-limit: true
> > >
> > > +  led:
> > > +    type: object
> >
> > Each node must end with additional/unevaluatedProperties: false. See
> > example schema and writing schema.
> >
> > That will probably lead you to missing LED common binding.
>=20
> >
> > > +    properties:
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      led-active-low:
> > > +        description:
> > > +          LED is enabled with ground signal.
> >
> > Aren't you redefining existing properties?
> I don't think led-active-low is specified in any central location:

True, because it is active-low which you could easily find if you opened
and read the LED binding you were already referencing here.

Best regards,
Krzysztof


