Return-Path: <linux-wireless+bounces-20941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F38A7510A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 20:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0061738FF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A901E1E13;
	Fri, 28 Mar 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="DsWrrv4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88E322B;
	Fri, 28 Mar 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743191554; cv=none; b=gYnwLt0+02ck4fuz17ADbcvxonxE+X3ot3mkuUiSfBha1YQEmO3KKDsY9OFKrwyF7Sla22SnL+2tJo7r4LU1Zojlj5nEZcmh+jmZchViLzPorwh1KBspomccwjeAWqu3ZWaid+Lkb8fco/D2zFsrewtGh9gvBEWimomODKbvEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743191554; c=relaxed/simple;
	bh=YaO70SFlWiugUmK0UvlOIGdArpJwA4i3j0CMMhbaJtg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FfEbr4oM9gpShlR+xtvO5WCfamDlXLDiMPF9CtcUANxMn+6zwVv3JOCWOdL/rZOpG1T0OtC6nezvbDfx6LlY3sV7bs4/Wl7ZH3IFNGnIJHCyOqswBY4w5477kzVUBoP+jlX20f8ljcOdlo+rwjl710uAaQWx6tjJMvaA0D/5lh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=DsWrrv4p; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [127.0.0.1] (78-80-113-104.customers.tmcz.cz [78.80.113.104])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id C7768166734;
	Fri, 28 Mar 2025 20:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1743191541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaO70SFlWiugUmK0UvlOIGdArpJwA4i3j0CMMhbaJtg=;
	b=DsWrrv4pATyhBjy330V52YVR7/U6IEbdIN0bLmMqS7u0ypYW1s9HicPipP+Ea+DVpEzYEo
	J4KpYiRjNreuP0JfptcLoB5gKSZWxU1UlErJQiedYNLxo97rB6/s3m9O76C0MBhROW00Q+
	vR9LNUtjnlr3vUIDJsJfqMoYoxOISS4=
Date: Fri, 28 Mar 2025 19:52:18 +0000
From: David Heidelberg <david@ixit.cz>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>,
 =?ISO-8859-1?Q?J=E9r=F4me_Pouiller?= <jerome.pouiller@silabs.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
 Mailing List <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
In-Reply-To: <69bd300d79f7f6317a964030930252b307b85007.camel@sipsolutions.net>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz> <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net> <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com> <bfb7433131cb9aeebc75666f86a67a6c71521229.camel@sipsolutions.net> <4B465FA3-E6B5-4EB1-A712-0C8874402FCE@ixit.cz> <69bd300d79f7f6317a964030930252b307b85007.camel@sipsolutions.net>
Message-ID: <42F3BE66-15C3-4C95-8133-2EA19E54B32F@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

from the functionality standpoint this bindings do not change anything=2E

From=20validation point, if the `make dtbs_check` will pass as expected, it =
should yield only better results for integrators and developers=2E=20

Thou if you want to postpone it for 6=2E16, I'll understand=2E

Thank you
David

On Wed, 2025-03-26 at 23:08 +0000, David Heidelberg wrote:
> > I can do that, but I suppose it's 6=2E16 material at this point=2E
>=20
> Hi Johannes=2E=20
>=20
> I assume you meant 6=2E15?=20

No=2E 6=2E15 merge window just opened=2E

> This patchset should mainly clarify where these properties can be used a=
nd address incorrect warnings regarding device-tree verification=2E=20

I'm not really convinced that makes it a bugfix for the rc series
though?

johannes

