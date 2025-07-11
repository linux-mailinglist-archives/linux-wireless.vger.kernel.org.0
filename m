Return-Path: <linux-wireless+bounces-25253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367DDB01523
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4306E189F235
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B21F150B;
	Fri, 11 Jul 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD68Ts6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C322628D;
	Fri, 11 Jul 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220132; cv=none; b=ap4LmL/gippr2T9kaMavR/5XIWTrwffuaqSjK1+ijX0gf3FBWBwIa2GnDETYIxn5OcBdSCQDBkCMtcdajyVu8TxODUdJnzmfYS4Z6zkDkIO4vIA/7KveIuEJZQ2/SrbvNAGolYVf9ZNXxjoLcN53vMFlqBe7blY2J3pbHn6li8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220132; c=relaxed/simple;
	bh=S80RCc8AU+x0HOq9skXnJp/RPQxNXic9/cfuMq1Im68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na64QGoyARvNXSRcjqgpMV2qPGFrj20kXthLxugEoFE4NLNKYOAPlcw2IIdXj/31i3Zl4J0sboztXAqRa0dOisdry2WUWxBCPMcK4VBOnL56BZGPh43b+7Y6zuf/jsJIZxAHe0FNjqbCZuiNHkmZmfT71syvd4l4hxxi0u5HOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD68Ts6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0C8C4CEED;
	Fri, 11 Jul 2025 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752220132;
	bh=S80RCc8AU+x0HOq9skXnJp/RPQxNXic9/cfuMq1Im68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD68Ts6Mc+lxinHx4tEPAuFhkN/k9whUNRSfIBCRyk+l7tKFZGC/EwaNlBgN1Xgzi
	 qTod2g8rkqpjAEw5DwSoeoFxvyhzAkUt+EfGMiXDSWYTwy4AICs9gd7elyf4EZOFzS
	 KBVbf2fofMljwswaQtpVVpJTgzNyord956SC8l2G79CNoxdtT0xgdvm1I+DZ5inef6
	 zQmgwvgwtsntLj+BK6SaF0M2T4KQVWwukkFIF6OSt5DDL/NELFpYbCQv48vwpz/1g4
	 b+vg7hZrZmn0lZXpavB4XKn2We8S8raoTN0kNbIbAM3mfvFqUz+RWGykgYPEK0ICgg
	 10ivlZG1LQoBw==
Date: Fri, 11 Jul 2025 09:48:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCHv3 wireless-next 7/7] dt-bindings: net: wireless: rt2800:
 add
Message-ID: <20250711-invisible-dainty-jackrabbit-acbf8f@krzk-bin>
References: <20250710200820.262295-1-rosenp@gmail.com>
 <20250710200820.262295-8-rosenp@gmail.com>
 <d8b0abb2-1a12-42bf-aafd-4cd1e21babd6@kernel.org>
 <CAKxU2N-c2tHBYWBM+FJGqdSaqzw9u0O8e0G7AVqk6b0QdRnPTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKxU2N-c2tHBYWBM+FJGqdSaqzw9u0O8e0G7AVqk6b0QdRnPTw@mail.gmail.com>

On Thu, Jul 10, 2025 at 03:40:30PM -0700, Rosen Penev wrote:
> On Thu, Jul 10, 2025 at 2:40=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 10/07/2025 22:08, Rosen Penev wrote:
> > > Add device-tree bindings for the RT2800 SOC wifi device found in older
> > > Ralink/Mediatek devices.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++=
++
> > >  1 file changed, 47 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/wireless/ra=
link,rt2800.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt=
2800.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.ya=
ml
> > > new file mode 100644
> > > index 000000000000..8c13b25bd8b4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.ya=
ml
> >
> > Filename should match compatible. You were already changing something
> > here...
> hrm? that makes no sense. Various drivers have multiple compatible lines.

Luckily we do not speak about drivers here. Anyway, follow standard
review practices, you don't get special rules.

Best regards,
Krzysztof


