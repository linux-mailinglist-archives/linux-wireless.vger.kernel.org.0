Return-Path: <linux-wireless+bounces-24530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3EAE9948
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699FC16FEF1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B829AAEC;
	Thu, 26 Jun 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YXtdF63C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1D2957AD;
	Thu, 26 Jun 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928250; cv=none; b=MNlrSzcANQlKcslqi9PjtnqwUfSp6HCU5ZTcyhwWj4I5TqcQyji+7aGh5OyR4iEunQPcB1zg/AHozrxgKxi/mMISirZrX0yUZVuWDBgJZ0Q5H24qwS80twMMGPrlp4Npxsqd7Tw8SCtvhwLFsr6bYwjhvtfQ/drvBtcatco2W2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928250; c=relaxed/simple;
	bh=iexAl4IZBdK0K86HpFD/b/If8pH2fw4n5Z9QnMksSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUshYpn+iA05Q6F02dIb2GYsiZye7wBUFzUWzRx32e+9iODhnnIuoccJqoUJMeY3/CyPnUgqehgIihbgoPcWljANeZYZIBOJuhBLJs22uQLR75fg7R3wS79jtHkfkBwS0Liptct0+WvQoAPyi4TrujIbQZ5srl8u56hiVx/EQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YXtdF63C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fVmE/YiM+9C7jTD9oWg38lCkPD2nzPFS2EHGoqNAdeI=; b=YXtdF63CS4XTioz7pSvXGoJsWU
	vi/CmOrqzYmLVJBFpW39RM9JpzGVI37KoO45IBc/DAxH1Oek+1HzAQtA/ES8t/V4TMFnC/MEIlP5E
	5lNRnigiEccxo0z0X3ezV3BAkwBinCmgSkzZnUvZzKyIhNtLbWmLOjJ1NxtL+rW9XDAQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUiQ2-00H1gg-H5; Thu, 26 Jun 2025 10:57:18 +0200
Date: Thu, 26 Jun 2025 10:57:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, krzk@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, conor+dt@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	martijn.de.gouw@prodrive-technologies.com
Subject: Re: [PATCH v2 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 ti,rx-gain-reduction option
Message-ID: <ddb9a1a9-7070-416c-848e-00d151846999@lunn.ch>
References: <20250626082953.3963992-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626082953.3963992-1-paul.geurts@prodrive-technologies.com>

> > You should include the units, "ti,rx-gain-reduction-db"
> 
> Well, Currently it's not really a dB value (see below).
> 
> > 
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Specify a RX gain reduction to reduce antenna sensitivity with 5dB per
> > > +      increment, with a maximum of 15dB.
> > 
> > Given that description i think you can provide a list of values, [0,
> > 5, 10, 15] and the tools will validate values in .dts files.
> > 
> > > +
> > >  required:
> > >    - compatible
> > >    - interrupts
> > > @@ -95,5 +101,6 @@ examples:
> > >              irq-status-read-quirk;
> > >              en2-rf-quirk;
> > >              clock-frequency = <27120000>;
> > > +            ti,rx-gain-reduction = <3>;
> > 
> > Err, how does 3 fit into 5dB increments?
> 
> I implemented it in a way that the value of ti,rx-gain-reduction is programmed
> directly into the RX_GAIN reduction register, and there it means 5 dB/LSB. My
> description probably was not clear enough about that. So a value of 3 here actually
> means 15dB.
> So I could either improve the description here that this is the case, or make the
> value in here in actual dB, and do some calculations in the driver. What has your
> preference?

DT should use SI units, Volts, Amps, degrees C, meters, etc. The
driver then should do whatever conversion is needed to convert to
hardware register values.

Less important, but i'm also wondering if this should be negative,
ti,rx-gain-db, with a value of -15. You say this receiver is overly
sensitive, so you need to reduce the gain. But are there TI devices
where you can actually increase the gain? Ideally the property should
be generic and be able to cover that use case as well.

    Andrew

---
pw-bot: cr

