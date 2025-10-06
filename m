Return-Path: <linux-wireless+bounces-27833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8946BBF633
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 22:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F364349DE1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A78248176;
	Mon,  6 Oct 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xlmARB/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1D223DD1;
	Mon,  6 Oct 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783709; cv=none; b=XpgbFWt3xfVJrXrhaMuu7WmYodgdPJzOY69THszpgSYLmO71vctQHZbhpkuoomHcQ0fTYlZYaRK4ea5wlKpe8yooPvzbw3+bCvCUTF4qn7z5eIHiLLK8Owtl06ueZwzn7brCx5e7yJQSPLri22hS9UhNRcrvckvYRNlcwJWAfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783709; c=relaxed/simple;
	bh=8iW5nse50LMyBbWXX1gvG2h9SFTg3/xMCE/L0DElJ/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IftAXTrRijNCnI14hP1GoFZQRTlW5HH73d7orNk4K0LhqkHrqXnHTLVF128NSbFv8R5+6Bme9apkTNWVont6Id2tLEoav+sGKV016umxW1zX9kXkMAeQAFzI/na0/ATqZ/MrtqrE0lYZ+K2EBBS72eThyrgx/ci01nClHiyb3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xlmARB/I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VIKAcr7AiKo1tJTrh+bk2m2hYbyR4gITRIGMmYNi20Y=;
	t=1759783708; x=1760993308; b=xlmARB/IP6PGx7iyiB+UTX7V2qQ9ddOchDXTb0FoKqIu2tl
	x6tmyARBao1qEDA23z0ty1+pJs41qB8Jk2GQfX1qt6QiBkZi1aYRRp3fh/1qRf2Xk+MZ3Zzb+gxEr
	bIXN4CWmLJdDLtn4wk0y8wclrBV9toUlCiJWeUuBcSGnGobOL/mFpcXGHKk+tTkYFB7hCD8YnOfir
	Y1oWyxmdR8PtwowkD9tBbT9ED8bBWV4nZewdEUFdzAeAilY11XIG1u3j+BXUgv8+3X0Glp7cG9BVA
	bi9tcIhZH4mo7zc7nEY++beQ6K2u/s1l+W5YnKUI3lXpyrrwBgEdtu5cv9czQsmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v5s80-0000000FBWk-3fK8;
	Mon, 06 Oct 2025 22:48:17 +0200
Message-ID: <1697b64e2b64682dbf83186f17f42c50ecf88fa8.camel@sipsolutions.net>
Subject: Re: [PATCH mt76 v2 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>, "Sven Eckelmann (Plasma Cloud)"
	 <se@simonwunderlich.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang	 <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
Date: Mon, 06 Oct 2025 22:48:15 +0200
In-Reply-To: <20251006204529.GA549972-robh@kernel.org>
References: 
	<20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
	 <20250926-backoff-table-support-v2-1-16d3726646c4@simonwunderlich.de>
	 <20251006204529.GA549972-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-10-06 at 15:45 -0500, Rob Herring wrote:
>=20
> > +          country:
> > +            $ref: /schemas/types.yaml#/definitions/string
> > +            description:
> > +              ISO 3166-1 alpha-2 country code for power limits
>=20
> This would be constrained to something like this?:
>=20
> pattern: '^[A-Z]{2}$'

There's a "00" special case for "world roaming", so maybe that would
have to be '^([A-Z]{2}|00)$'? Not sure you'd ever want to specify that
though. We also use '99' internally for even more special cases, but I'm
pretty sure that shouldn't be specified externally.

johannes

