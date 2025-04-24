Return-Path: <linux-wireless+bounces-22015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECDA9B683
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA71B8144E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73B28F52B;
	Thu, 24 Apr 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c6pUqxbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8827F74E;
	Thu, 24 Apr 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519953; cv=none; b=XiZBI0mtCBfUPdW0oMnIUmrzs+D9V1feJCMd/QLFxNCL0zawIIWizHgGnweDmQeYPyCiBirNE6LEPG/Ev8gvTC+gX8XfgDQ6qj0czq8WdorUv462m+VPjldNIwxElXHhy7dG/IdpPKX/b9DxeeUXsT9X+F2uyToPtuvjHqSemIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519953; c=relaxed/simple;
	bh=6bdpaVdvFvYiYPzJcAlvCLWS4TRiBZPClZi9eEprHSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5RwMnUk4iq7fcTHtlkT6yIdmGocFnIX196is7jD/GGXI0BHogCRPQNvE8Zerk1Jx62QKuXDp2lqkolfKwlvTQPzFTkTl4CpUBwRFVSCd2PZpMKgdEFzBElPkkKMp6drznJh+sKK64zGGcAHCdXFOazjZCdGWPVWzBnsY56Ys8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c6pUqxbM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6bdpaVdvFvYiYPzJcAlvCLWS4TRiBZPClZi9eEprHSk=;
	t=1745519952; x=1746729552; b=c6pUqxbMRusqXQdwwBsQDHgV+/ZrFqQ02j87oPcJ39EtrBo
	49FYPn/EA7Li7f2mWmWwioG5mT2GmQoY9va5LYI7B2mTSBmAHfHbPajmITdhteGtXzJL4aLSi0N3Q
	1Hc3Y37CAFtU03mPxUFe7sTfoxA+bbdmQJmip4Wu2CFvPdBRHXNQEdFTqtjS8xaraxd9wnKD7W+av
	fuMnuAyIqCOhLxP6cbHmK05Qgr2msjLqcgnQkmLyOMvVY8m1cWn7egR/Y+B49Q0npk//mAaZvvyrv
	GqGVRL1ICBmx87F/katan/F24iRPDlLI5ySg825T8leTnVy4Feq5MnHKYWXLDZXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u81TT-00000000BVN-0Jsz;
	Thu, 24 Apr 2025 20:39:03 +0200
Message-ID: <4e5d875c3f666be8d1c72fa19f6237f21b24f7ec.camel@sipsolutions.net>
Subject: Re: [PATCH v5 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, david@ixit.cz, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Mailing List	
 <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Bianconi
	 <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller	 <jerome.pouiller@silabs.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Andy Gross <agross@kernel.org>, Mailing List	
 <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, Janne Grunau
	 <j@jannau.net>
Date: Thu, 24 Apr 2025 20:39:01 +0200
In-Reply-To: <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
	 <d8619ab4-3a91-467f-a3d4-f23b4e0383a4@kernel.org>
	 <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
	 <4b040936baa8fa8669b34e36fe9dff6e08aeede9.camel@sipsolutions.net>
	 <f0e56cb2-17a6-44d4-ae71-8639966d565a@kernel.org>
	 <8d8b7c3ad6a67a683abbb4fc6049898747300a16.camel@sipsolutions.net>
	 <CAL_JsqKGmoiW=yDD7G4Qznsa7S2wQ7x4Mh0i4puAyFsvcnHz1A@mail.gmail.com>
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

On Thu, 2025-04-24 at 13:26 -0500, Rob Herring wrote:
> While it seems the reviews of the series caused more warnings for
> Apple, in general, schemas creating warnings is not breaking things.
> In a way, the whole point is to create warnings because if the .dts
> files were perfect already we wouldn't need schemas. The main
> requirement for schemas is only that they don't create warnings for
> the examples. There's still too many for .dts files to worry about it
> (and there's intermittent warnings from things getting merged via
> different trees).
>=20

Oh, sure, but now if you want to apply the fixes you probably have to
wait for the broken patches in my tree to percolate all the way through
to Linus, then back to your tree, and then you can apply the fixes?

Seemed it'd be easier to send the fixes to me but it's all your call,
just let me know what you prefer.

johannes

