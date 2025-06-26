Return-Path: <linux-wireless+bounces-24526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A06AE9851
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893414A14F0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401BE272808;
	Thu, 26 Jun 2025 08:30:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199B267713;
	Thu, 26 Jun 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926605; cv=none; b=mqata9UBPnIdcoGIh/Km2UX+Jc43uC/miaGWFsPuN2j9ricN2hllTe8+5UGCjgs5kj34juSNnvMuUFkVxi+R8zbDPmfJ0EJxE/NwHV2H0FXUVvhbQ6XScL7JPrlYTq+cgO2FHJlnK+tj2IN29O9unkmj/XC/WJsxbvGL4E4yi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926605; c=relaxed/simple;
	bh=pkxTjPhLMGyJG2LYhRzWNpcmEeQWv2oYgzhEsh6CSMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je7Txk+jxoGtQv2ngawkqPJb9vIoQ6yrdQCja7A/cqkCbRvYQL0EZzvWNlEPBoAPbz6DJEZ5fdPZ4Ksv1KFSBJ9MMbdgroviigs/+Iq4hMzV1S2PhWqC5zvvZaY0PMnNkdC5KDxmLw6CvrEsY4V2aIh9dlPlagXr5NOKl5YeKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 10:29:53 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 26 Jun 2025 10:29:53 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uUhzV-00GdE8-2n;
	Thu, 26 Jun 2025 10:29:53 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andrew@lunn.ch>
CC: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<martijn.de.gouw@prodrive-technologies.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction option
Date: Thu, 26 Jun 2025 10:29:53 +0200
Message-ID: <20250626082953.3963992-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: cf871c23-963a-4d50-a13b-97e84ee0ddb7@lunn.ch
References:
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> On Tue, Jun 24, 2025 at 02:42:46PM +0200, Paul Geurts wrote:
> > Add option to reduce the RX antenna gain to be able to reduce the
> > sensitivity.
> > 
> > Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> > ---
> >  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> > index d0332eb76ad2..066a7abc41e0 100644
> > --- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> > +++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> > @@ -55,6 +55,12 @@ properties:
> >      description: |
> >        Regulator for supply voltage to VIN pin
> >  
> > +  ti,rx-gain-reduction:
> 
> You should include the units, "ti,rx-gain-reduction-db"

Well, Currently it's not really a dB value (see below).

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Specify a RX gain reduction to reduce antenna sensitivity with 5dB per
> > +      increment, with a maximum of 15dB.
> 
> Given that description i think you can provide a list of values, [0,
> 5, 10, 15] and the tools will validate values in .dts files.
> 
> > +
> >  required:
> >    - compatible
> >    - interrupts
> > @@ -95,5 +101,6 @@ examples:
> >              irq-status-read-quirk;
> >              en2-rf-quirk;
> >              clock-frequency = <27120000>;
> > +            ti,rx-gain-reduction = <3>;
> 
> Err, how does 3 fit into 5dB increments?

I implemented it in a way that the value of ti,rx-gain-reduction is programmed
directly into the RX_GAIN reduction register, and there it means 5 dB/LSB. My
description probably was not clear enough about that. So a value of 3 here actually
means 15dB.
So I could either improve the description here that this is the case, or make the
value in here in actual dB, and do some calculations in the driver. What has your
preference?

> 
> 	Andrew
> 

Thanks!

Paul

