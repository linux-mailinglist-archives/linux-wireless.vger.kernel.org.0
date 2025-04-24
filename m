Return-Path: <linux-wireless+bounces-21976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD29A9ACE2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C793B0912
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791622B590;
	Thu, 24 Apr 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bQLeMiOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D6214226;
	Thu, 24 Apr 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496570; cv=none; b=MeN9LJg0J0hHjsNB/59qZW89duB1oEZj9PuEugZQZFy/ZgN24hyABtlqLq4ZAxyVAKIu96okbzj7dTe56WyZY8dVO/djfvgnh0jp5gPIy5En+f2bfvEJdxB+H3IzIKFpQuS3nn55sVGYfPNj24Tn45vqxv+1IBI5NokqMzj6eeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496570; c=relaxed/simple;
	bh=mhvQAy4PwAusFJNPxPQDFwPrFvhTyyBHabTJwdC0aUU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jamtRNGm9V6aISTpMH+Fu6ajn9nb5EZNLy53STVn/To+rq2a4bgGUgk0YfOykXmhjqnL+jGoy53XPUNXTRSYS8g40VlS9oT+4x5EyYEIlWmNFSl7jlXoEv2br1jeKK4b5t+0LwKoJWbHfucaRo8RDAh5nBpICGlvRKHg8GHNyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bQLeMiOT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mhvQAy4PwAusFJNPxPQDFwPrFvhTyyBHabTJwdC0aUU=;
	t=1745496569; x=1746706169; b=bQLeMiOTL/CLn6kVXjUmypjR6zOeND/9JQJU+Mrlbe30Tei
	hlO6P2tM5Em2SBXGNkFROFXie/L1SSd9hyzF2LiJ8aA0DtIf1MQ/ul5ja05UAOUiCWcG3+MMr/U2I
	cW1gEs+swyKT2uK1uXIYYvI3aODHrARtUL1u/4XJtO1aFuKdwaDtT9v69g5ADIoh4ADgkAeVviBNP
	2V1iv4PJexVTwRsP8bTzJr+SgONslwJpcyByKqsKQ4CSYHmXlW5Ugdoh8zy2FqDHcsXLQ8b/ksIto
	dn6wcfkn9OZXluWbEgcQcCpmWTXLJB3sDCfkSRQSe0JjNaLpTSfiWQX+I102x67Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7vOJ-0000000H4Oc-2vQj;
	Thu, 24 Apr 2025 14:09:20 +0200
Message-ID: <4b040936baa8fa8669b34e36fe9dff6e08aeede9.camel@sipsolutions.net>
Subject: Re: [PATCH v5 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, david@ixit.cz, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mailing List	 <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Lorenzo Bianconi	 <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller	 <jerome.pouiller@silabs.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Andy Gross <agross@kernel.org>, Mailing List	
 <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>
Date: Thu, 24 Apr 2025 14:09:18 +0200
In-Reply-To: <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
	 <d8619ab4-3a91-467f-a3d4-f23b4e0383a4@kernel.org>
	 <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
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

On Thu, 2025-04-24 at 10:28 +0200, Krzysztof Kozlowski wrote:
> On 24/04/2025 10:20, Krzysztof Kozlowski wrote:
> > On 24/03/2025 18:41, David Heidelberg via B4 Relay wrote:
> > > From: Janne Grunau <j@jannau.net>
> > >=20
> > > The wireless-controller schema specifies local-mac-address as
> > > used in the bcm4329-fmac device nodes of Apple silicon devices
> > > (arch/arm64/boot/dts/apple).
> > >=20
> > > Fixes `make dtbs_check` for those devices.
> > >=20
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> >=20
> > This introduced several new dtbs_check warnings. Including on platforms
> > which were warnings free. It is nice to fix these warnings when you mak=
e
> > such changes.

Heh, especially since it said it should _fix_ things there.

> I will send the patches for them, except for Apple SoCs.

Thanks, I guess I'll hold the pull request for that. And I guess the
Apple ones are on David then.

Knew it was a mistake for me to ever do anything with DT stuff ;-)

johannes

