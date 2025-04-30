Return-Path: <linux-wireless+bounces-22239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3842AA47BA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FFF9C086F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C821D3E4;
	Wed, 30 Apr 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R7DpX3lM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703319048A;
	Wed, 30 Apr 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007025; cv=none; b=HNuMLsBrLBIr5fbitU34y4oB2EuOAGmrDD+m83JmpJkG2pHUph0UblTVXsDs0Tl0DkNDjpaeuobvz+ejLVi6l5c+Iq0NDi3N07kAqp145GuqM5y68C515kFR/cqGO14cwWwI2goSptGyECJ7cnRmBg8BH6E6euToMsWaNgMnL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007025; c=relaxed/simple;
	bh=4eNo/9b9IFarOWVGY148lc7T2Kb2igwtuuHmf6mKeSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqQ7bNaq7xkcweVSVkIQmaZ/PlfeykMossa7F3D0BgvvNiem3+jqEnaTc08hf0ffFd5R1c9j+g63En1IGgj9/YRxgJdVvDqYotJjqz/qCn7Y3w4Z7/xkWhRkajUAvz42UNR6/SQE6AAw9AfJDfVAFncrkAdLSKDlMtNJkWbN6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R7DpX3lM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4eNo/9b9IFarOWVGY148lc7T2Kb2igwtuuHmf6mKeSo=;
	t=1746007023; x=1747216623; b=R7DpX3lM6UvMVTtzs4qWQV/3jbF/VbnO9tg2yS0PiCYUNSp
	QtQ4KN2Ohquo34ZD1EkeGuqBgtZBAyY5MlX4Vc239bmEmx2uANXnc4dzClletQBzErcv2vVpRNphG
	u7SCy12iSfP2ZjHHdxyf3uEt7AjSsypcDL3Q0Lj92g+39lpponAzedtzGgK/h7hWpFyQ9GB3Ud3bt
	3h9CJ03C1dz9jHmqn9xyJAS9oGyb9f8OphLld3OlJBIRDduJ4Wo9AiwMBT8Z6ulrwBQZyX73tbqSH
	18S5h07diwwBACLbe3/dKx3iyfUok0AmSeAgap1qBZcQ1A789XUvDbQ7SZAHXbDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA4BY-0000000DbJI-1euX;
	Wed, 30 Apr 2025 11:57:00 +0200
Message-ID: <7df5d59180c660aff36fbd179251a17df2636365.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Gokul Sivakumar
	 <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com, Jouni Malinen <j@w1.fi>
Date: Wed, 30 Apr 2025 11:56:59 +0200
In-Reply-To: <dca65ca5-56ee-4082-b5c7-68e49435c06c@broadcom.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
	 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
	 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
	 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
	 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
	 <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
	 <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
	 <aAyQma_qLrH_7S2a@ISCN5CG14747PP.infineon.com>
	 <09f9a8700163a509846418354235bd3b84e8d532.camel@sipsolutions.net>
	 <dca65ca5-56ee-4082-b5c7-68e49435c06c@broadcom.com>
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

Hi,

> To me this raises the question as to when this SET_BSS primitive should=
=20
> be used. As I recall one of the goals of nl80211 was to get rid of doing=
=20
> individual configuration change like we had in wext which even sometimes=
=20
> required specific order to get what we want. So why are these parameters=
=20
> not in the START_AP primitive (actually the P2P parameter are). Some of=
=20
> the parameters are probably implicit as they are represented in the=20
> beacon data passed in START_AP. The ap_isolate however is not expressed=
=20
> in the beacon afaik.

Yeah, I can't say I remember anything about it. Perhaps just because it
was NEW_BEACON rather than START_AP originally...

> When all parameters would be handled by START_AP what would be the need=
=20
> for SET_BSS. I think it would be to modify the parameters for a BSS that=
=20
> is active, ie. beaconing, and possibly serving client STAs. However,=20
> this is where I get a bit confused. There is also a SET_BEACON primitive=
=20
> which looks like it supports a similar scenario.

You can obviously change the beacon during the operation of the AP, I
can't tell you now why we didn't change it to SET_AP or CHANGE_AP when
we changed NEW_BEACON/DEL_BEACON to START_AP/STOP_AP ...

But I agree it'd make sense today to have it all with these operations.

But do we want to change everything now and have hostapd be able to do
both paths? Is the cleaner future in the kernel worth that complexity?

> The drivers that implement .change_bss() today have a relaxed policy. If=
=20
> we add restrictions in .change_bss() for brcmfmac that means from=20
> user-space perspective the API is not driver agnostic.=C2=A0

Also true, mostly, though it'd depend on what you actually want to do.

I'd argue that the "default" settings should indeed be accepted by the
driver, but maybe if you set something that _isn't_ supported by
brcmfmac (and isn't default in hostapd) then refusing it would be more
user-friendly than ignoring it?

> Restricting the=20
> .change_bss() in the other drivers will likely cause user-space=20
> regression.=C2=A0

Depends how much, in some ways the "regression" could be beneficial if
it would otherwise ignore settings the user wanted? But yeah, it could.

> So there should be a capability exchange between driver and=20
> user-space. My idea here is to have the driver add a nested attribute in=
=20
> NL80211_CMD_GET_WIPHY listing the bss parameters supported. Probably can=
=20
> use the same attribute as flag in NL80211_CMD_SET_BSS to indicate=20
> user-space does handle the bss parameter support info from the driver.=
=20
> Will try to get something implemented to see how that goes.
>=20

Cool, thanks! :)

johannes

