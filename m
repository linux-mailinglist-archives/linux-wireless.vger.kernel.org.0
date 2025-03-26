Return-Path: <linux-wireless+bounces-20865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3FA726EC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B327A64D9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CA2561C4;
	Wed, 26 Mar 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x/EEL1ja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247419C569;
	Wed, 26 Mar 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030885; cv=none; b=PfajpzEE6v2NbpqOm31jpN943o+ApTPY/k2OLVfSbPujsI5Ovs0nKfBgsuC28paat0xgs/PJ1E6yyUFRakJyCuToqgTENUuNNzaf/LPjHbvSZVByjFDRnltViLKV0vmeAkgKrAHCou66lb0supL6njCK4/za+t4kffPXjSxreGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030885; c=relaxed/simple;
	bh=NRxhzX97zbLNqsKqNz31eZbURDBwCrCNRXlfK0yFU6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X07cbKcRkgNXZ4Z+hTVCUWUSKHIIv7CRyns7+V7attsWVq4nXyhyggwMJkLSIj9PdMf8shaxXt/AZw4LdNzuSjil5sYe8yVLtzrA5dyH2dkFIGbB3e1rErmxjFA92nbLln4WJ/VSbL02sGMdEqg5g6TDXJd0+k46GPVLA6bvIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x/EEL1ja; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NRxhzX97zbLNqsKqNz31eZbURDBwCrCNRXlfK0yFU6I=;
	t=1743030883; x=1744240483; b=x/EEL1ja1n0FpYr0sDGlWFxeEgs7/QwJVuDntw0gzrfhavm
	mb5qlkdKrYgxZ+Weo3yTMSmBLwUVe606Nnpo1KULQAIw7pAau46NulauJfYGjOZ/qMoHD+n60SVn+
	Z5N0hhO13cVWFlGy78HdVLDcEeX+FfKc+rIseP9l4ftFl8SoPTh2OixyT33BBqqmBc5+H/ntLJ7++
	8hBeKlf/89k0AnMkBHc+JO58m1CbSObjQpHIGgSltZBA/LGfqzzPpTC/TIr3zr0snviokudTAynh2
	/2mhiMK/OfzVxFnxduw+FI62EC7I1xexuhuwuqdFLpky39MO9pHzK+Dvyl3Zfa2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1txZx1-00000006USq-3r9X;
	Thu, 27 Mar 2025 00:14:24 +0100
Message-ID: <69bd300d79f7f6317a964030930252b307b85007.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Krzysztof Kozlowski	
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
Date: Thu, 27 Mar 2025 00:14:19 +0100
In-Reply-To: <4B465FA3-E6B5-4EB1-A712-0C8874402FCE@ixit.cz>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
	 <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net>
	 <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com>
	 <bfb7433131cb9aeebc75666f86a67a6c71521229.camel@sipsolutions.net>
	 <4B465FA3-E6B5-4EB1-A712-0C8874402FCE@ixit.cz>
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

On Wed, 2025-03-26 at 23:08 +0000, David Heidelberg wrote:
> > I can do that, but I suppose it's 6.16 material at this point.
>=20
> Hi Johannes.=20
>=20
> I assume you meant 6.15?=20

No. 6.15 merge window just opened.

> This patchset should mainly clarify where these properties can be used an=
d address incorrect warnings regarding device-tree verification.=20

I'm not really convinced that makes it a bugfix for the rc series
though?

johannes

