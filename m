Return-Path: <linux-wireless+bounces-24547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08FAE9E75
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85C03A5071
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888FB2E5417;
	Thu, 26 Jun 2025 13:19:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106D1AAA1B;
	Thu, 26 Jun 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943980; cv=none; b=P38uyRcxbsbG5X+MWK19L3KAeV3IucX7QqpbPBRAisMSZeZCfdsFoh/JE0+p4iZZjpj9pcgWDqhD44911vxJ1Pk0YprhgFpzpJv+S50TcsKaQXtMz8ReeQ7jCm6ElNxdgTtIge/BBpa7uxbKIZ2nOdcsXkbL2KATcYuzdmIc+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943980; c=relaxed/simple;
	bh=75mkrs7dNrjFqYbU96pjzxClIJ/jiib6Uq9QOKp4sF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsWdQ1UxRfaoDDGuIBfKdqdFp7pyZRZymwzB6+RVMnXkjtvUfS8Tcoub/Gwo4Yoh4gQXjdy8Ao1wnaIt1bvJ8dhepeIiNMfc99y5xVfGF0/mKjdRi9Mu8bmGC8S1KkSfz9ewCaqhnZVaySWA44iuO6hV3See/WVK89gjXJB7Fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 15:19:34 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 26 Jun 2025 15:19:34 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uUmVq-00Gq2g-29;
	Thu, 26 Jun 2025 15:19:34 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<devicetree@vger.kernel.org>, <edumazet@google.com>, <krzk@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>,
	<martijn.de.gouw@prodrive-technologies.com>, <mgreer@animalcreek.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<paul.geurts@prodrive-technologies.com>, <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction option
Date: Thu, 26 Jun 2025 15:19:34 +0200
Message-ID: <20250626131934.4013096-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ddb9a1a9-7070-416c-848e-00d151846999@lunn.ch>
References: <ddb9a1a9-7070-416c-848e-00d151846999@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> > > You should include the units, "ti,rx-gain-reduction-db"
> > 
> > Well, Currently it's not really a dB value (see below).
> > 
> > > 
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      Specify a RX gain reduction to reduce antenna sensitivity with 5dB per
> > > > +      increment, with a maximum of 15dB.
> > > 
> > > Given that description i think you can provide a list of values, [0, 
> > > 5, 10, 15] and the tools will validate values in .dts files.
> > > 
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - interrupts
> > > > @@ -95,5 +101,6 @@ examples:
> > > >              irq-status-read-quirk;
> > > >              en2-rf-quirk;
> > > >              clock-frequency = <27120000>;
> > > > +            ti,rx-gain-reduction = <3>;
> > > 
> > > Err, how does 3 fit into 5dB increments?
> > 
> > I implemented it in a way that the value of ti,rx-gain-reduction is 
> > programmed directly into the RX_GAIN reduction register, and there it 
> > means 5 dB/LSB. My description probably was not clear enough about 
> > that. So a value of 3 here actually means 15dB.
> > So I could either improve the description here that this is the case, 
> > or make the value in here in actual dB, and do some calculations in 
> > the driver. What has your preference?
> 
> DT should use SI units, Volts, Amps, degrees C, meters, etc. The driver then should do whatever conversion is needed to convert to hardware register values.
> 
> Less important, but i'm also wondering if this should be negative, ti,rx-gain-db, with a value of -15. You say this receiver is overly sensitive, so you need to reduce the gain. But are there TI devices where you can actually increase the gain? Ideally the property should be generic and be able to cover that use case as well.

As far as I am aware, I cannot put a negative number in a dts property. I can interpret the property as s32, but that would mean I need to put it in the dts like

ti,rx-gain = <0xfffffff1>;

which looks like a bad idea. I will just convert it to a dB value for v3.

> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

Thanks!

Paul

