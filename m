Return-Path: <linux-wireless+bounces-22009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD15A9B2AA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D464A5561
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719CC2580E7;
	Thu, 24 Apr 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WPU8wjtb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566B1B414E;
	Thu, 24 Apr 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509349; cv=none; b=KyvJ2KM6V69B+Yg/m2k+erOysirxx42WcV/uO6J+wUfsgzvYe5BDxJFSkWmWYwm6yUufOA9jmfD7EVm0BWxU4/rLMinbs95vKRc/zO610vDOousuJWxo+oY2jNN8yg5XSnkqV6e8V0//P71NDuR131rqVy5SRrIfasCKqL+gdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509349; c=relaxed/simple;
	bh=OEIq0Q87c6gXNwhDPIX+FKn2LEgNvYm/5NKWTVvThME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rd6QXKDnAD1bfjeIgGpJ69roAmze1N1lm7GWcU/z0UBfeUVIr21Yri6LK2rUU7ISVASbvQngrE1L8f3yXhuiW+nwdu9CrLEB3boTAkeDpNuOIjdqP5E6Va5MOq//uzLuTJPfH5Qpmding8RQYbJzkX/rvI3BNfSfab/s7wav0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WPU8wjtb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OEIq0Q87c6gXNwhDPIX+FKn2LEgNvYm/5NKWTVvThME=;
	t=1745509347; x=1746718947; b=WPU8wjtbHCTaCChe3Yb7jgdzC18ibRitVw6AouDHb+7Fi0n
	N6B1dQT+7amMQTwqHdRwJKLKUUCo4HAOKa7vwBxhuRwMoec94HOECq/2O6Ty7mB/+6EEb1U4ZxDTy
	r/gPfi3rMJAFLCu3gncMNAL8kjfG2L49OORCa4fISiKcIW0XV4PoW3G362eGmG2TGHuuP3RKQiSLZ
	dkySIf+8ESS5tz0Mm0IR/blZdmN4Sye59HKhK5lR9Zl4sGfIEEOYdY9TolrScTnqs4sdlwdZHdqgG
	+V8j4ubJ/1lmC/aiD4pofjMoyeb5gQqE9cByCtmQEgJp70Qd3wpg+s3zcJGrGsMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7yiR-0000000HUGW-2WvG;
	Thu, 24 Apr 2025 17:42:20 +0200
Message-ID: <8d8b7c3ad6a67a683abbb4fc6049898747300a16.camel@sipsolutions.net>
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
Date: Thu, 24 Apr 2025 17:42:18 +0200
In-Reply-To: <f0e56cb2-17a6-44d4-ae71-8639966d565a@kernel.org>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <20250324-dt-bindings-network-class-v5-3-f5c3fe00e8f0@ixit.cz>
	 <d8619ab4-3a91-467f-a3d4-f23b4e0383a4@kernel.org>
	 <57701e2e-0005-4a8a-a3f5-ba098c97b480@kernel.org>
	 <4b040936baa8fa8669b34e36fe9dff6e08aeede9.camel@sipsolutions.net>
	 <f0e56cb2-17a6-44d4-ae71-8639966d565a@kernel.org>
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

On Thu, 2025-04-24 at 17:37 +0200, Krzysztof Kozlowski wrote:
> >=20
> > Thanks, I guess I'll hold the pull request for that. And I guess the
> > Apple ones are on David then.
> I think you can go ahead. I already referenced that commit from next in
> my patches, so I hope that SHA will not change (don't rebase your tree):
>=20
> https://lore.kernel.org/linux-devicetree/?q=3Df%3Akrzysztof+%22Align+wifi=
+node+name+with+bindings%22
>=20

Hm. I thought this patchset broke it, and it is going through my tree.
Wouldn't it be much more complex for fixes on top of it to go through
another tree?

johannes

