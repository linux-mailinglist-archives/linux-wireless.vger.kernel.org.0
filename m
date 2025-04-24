Return-Path: <linux-wireless+bounces-22019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFBA9B7FD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B09646728C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C02949E5;
	Thu, 24 Apr 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sIJBdH/U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1628F53C;
	Thu, 24 Apr 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521604; cv=none; b=tmhOQHqxNBgkIXggWarH+cJUHGOYQmSMschG2pr65Elq77E9pde+3v7gk1jorRxQjox4ZUuycsIZAjugyqsXDCEKsPwxMAU/R7jQA2ZtRhT5sLHCYSxQZ8IY4njazNcx5cGqTkNUrsKEKGo+/i4NA6RN8l41BXenTeDRfX8nIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521604; c=relaxed/simple;
	bh=aXmI/LWiDL+s0JgrOR5v1WnqR5ydsWQiIBGaZvc4lGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNPJGpvtLC6yV/3oKpGyj5lHAf9XdMw+8E7T6nnNBhHoaYG7FDcOTG1aexNgeVMgAu0sFKJKDTs+/YnALQWjwCZsMFCBYCOf18XLfKKy/qF5HzvUGAuqo1SaymtRG1ujpI7e5mdIOKlblPcbOXG36gKBD/YQh+yrXixK1vLDW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sIJBdH/U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aXmI/LWiDL+s0JgrOR5v1WnqR5ydsWQiIBGaZvc4lGc=;
	t=1745521603; x=1746731203; b=sIJBdH/UfDw8mXtkYzclnbFQ6Kfwu+dhPA6cSFpSOowYmbW
	nvKKuannJu+jQcpjlwIGz6pkYtYgWcE7tJx2xU8kc1OzYj5xkUq1IH6vmctN5zwE0Ehpe5P5gvey2
	2UFB5gCOUj39R9bjCw+xNh4FuoUnwUwC9X41kW6xGjIp9Scj3aI12ywcpkxJhthN5EZfvg+zzzcHU
	uPpWgaJDAdGIx17YiR/iLT19498uNpqNk4grrDSCzV/aXAS6JcsEhZIzLabhjR3YtEzNfJl4ZFOyA
	GCx7ofZw18lpPY/34dUba677h88trimFtYQfk8B1ma4tvAskar2pFo2yzoWqrevQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u81u6-00000000Cop-3nRq;
	Thu, 24 Apr 2025 21:06:35 +0200
Message-ID: <4db7b681cea6841012d2bb84944221bfb0e88ea4.camel@sipsolutions.net>
Subject: Re: [PATCH v5 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, david@ixit.cz, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, van
 Spriel	 <arend@broadcom.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller	
 <jerome.pouiller@silabs.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
 Mailing List	 <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, Janne Grunau
	 <j@jannau.net>
Date: Thu, 24 Apr 2025 21:06:33 +0200
In-Reply-To: <CAL_JsqJHdw5XOz5PLUvTZLVA0mUQTyGuqnXT0WTLTqNh27VWAw@mail.gmail.com>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
	 <d8619ab4-3a91-467f-a3d4-f23b4e0383a4@kernel.org>
	 <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
	 <4b040936baa8fa8669b34e36fe9dff6e08aeede9.camel@sipsolutions.net>
	 <f0e56cb2-17a6-44d4-ae71-8639966d565a@kernel.org>
	 <8d8b7c3ad6a67a683abbb4fc6049898747300a16.camel@sipsolutions.net>
	 <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com>
	 <4e5d875c3f666be8d1c72fa19f6237f21b24f7ec.camel@sipsolutions.net>
	 <CAL_JsqJHdw5XOz5PLUvTZLVA0mUQTyGuqnXT0WTLTqNh27VWAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-24 at 14:04 -0500, Rob Herring wrote:
> On Thu, Apr 24, 2025 at 1:39=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > On Thu, 2025-04-24 at 13:26 -0500, Rob Herring wrote:
> > > While it seems the reviews of the series caused more warnings for
> > > Apple, in general, schemas creating warnings is not breaking things.
> > > In a way, the whole point is to create warnings because if the .dts
> > > files were perfect already we wouldn't need schemas. The main
> > > requirement for schemas is only that they don't create warnings for
> > > the examples. There's still too many for .dts files to worry about it
> > > (and there's intermittent warnings from things getting merged via
> > > different trees).
> > >=20
> >=20
> > Oh, sure, but now if you want to apply the fixes you probably have to
> > wait for the broken patches in my tree to percolate all the way through
> > to Linus, then back to your tree, and then you can apply the fixes?
>=20
> No, I never take .dts changes. They all go via the individual platform
> trees. It's a bit weird if Krzysztof refers to the commit that's not
> in the linear history, but that shouldn't hold things up. The issues
> exist with or without the schema change. They might even be backported
> to stable while the schema change won't be.

Ah. OK, so never mind then. I'll assume whatever Krzysztof did will go
through some other tree and just go on with things :)

Thanks for the explanations!

johannes

