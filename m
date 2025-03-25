Return-Path: <linux-wireless+bounces-20800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB346A70235
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D93284725F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853725D551;
	Tue, 25 Mar 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nZirLOuP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193019CC2E;
	Tue, 25 Mar 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908298; cv=none; b=ZVefcnZE78PqcfAqhYOg8HPvQ+mLCatt+tmYce6j3jiDYndU2fm5O2RLpGLvmm7WSLifvzrbf1o9xUTjALSHPTqW0Ax8RHWji0Dg/MgW+jH5xaPlELEBPVZULzk85WAMTzVJuVryw92gVrfYygkeqZjlPuE01CviG6JCQP5dj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908298; c=relaxed/simple;
	bh=zQE7l7QJJRU50A1ezQBABnNaU4SfTHa6rs31LDY+qOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amBqwxPrnWI4tU/ge/oeQGBfiPjKXhad0U/cSTkI3NLz10DSvaw20uagLDgGomAMcKIyLI8AFoayecs9K7KGxntavih5q0BVxi8bBZRGfZb0z/SZPE4qgG6qrrbLovm4JyGpDSZ4DXVYoZchRwJeUnXK0wGJ5r+Pm32GVGL594E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nZirLOuP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zQE7l7QJJRU50A1ezQBABnNaU4SfTHa6rs31LDY+qOg=;
	t=1742908296; x=1744117896; b=nZirLOuPOmDB0Vn1mFA+HGegbqYCW0UQu4PMyBfmhJDu5Ye
	vrGW7UASEFvXaXGVoU4eqcoXNd/2H3dn9k8gCKmHFAbQw1GHNpJ3h2acpGuHiYPbZLoNSyhX7aJYI
	84er/hAXiAriQwuv2WH4wxtpADuf5swPcNrtoHIPpHwYobvD8bwbfvg4hD/xlq2yR3Xvva/D1YhFY
	lKKVod8jtrdmpPVOqnfvMVcrDhrDxuTbccLARhYnTaZFa92OYlyxvbtLceFl2Z6+tu6v79i11iNTx
	Z8AO+4Vh8xDe85kz6uz5KJfEhwtXWNExKmU1ccOhcKbWOYVJt5QzCHIWzOJcAs1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tx440-000000057Rx-3jhN;
	Tue, 25 Mar 2025 14:11:29 +0100
Message-ID: <bfb7433131cb9aeebc75666f86a67a6c71521229.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>
Cc: david@ixit.cz, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mailing List	
 <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Bianconi
	 <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller	 <jerome.pouiller@silabs.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Andy Gross <agross@kernel.org>, Mailing List	
 <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, Janne Grunau
	 <j@jannau.net>
Date: Tue, 25 Mar 2025 14:11:27 +0100
In-Reply-To: <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net>
	 <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com>
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

On Tue, 2025-03-25 at 08:02 -0500, Rob Herring wrote:
> >=20
> > I have no idea what tree this should go through, and you CC'ed enough
> > people that I can't figure it out either ... I'll assume not wifi but D=
T
> > for now?
>=20
> Can you take it via wifi as the main target here is wifi bindings.

I can do that, but I suppose it's 6.16 material at this point.

johannes

