Return-Path: <linux-wireless+bounces-96-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E490E7F9D0C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CA6281231
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E517734;
	Mon, 27 Nov 2023 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HwPCEOEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58EE1
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0OCQkreozwY1trDAvVl49hOYJhbSKGMOBxd56W0AJzw=;
	t=1701079352; x=1702288952; b=HwPCEOEiRD5bVI9lvEX6SsJeoQj8OKx7ZonD+mhhWuUzLV7
	OndFqHiG1/gcORPlJ+ZjHwdO/nngRn4PEQWV1sgBdBRm6W7EvHlJbddQUlV3L2BG3ADrtdn2qcsgG
	svOgtTz4LdcMrg007pF0DUgtLEFAuiBPMWVut6kVB47CmVot8/8JlIN21p1XgeAmK9XV02bheULSq
	nYGP9DoOnSyXhmXOwcBey5aMxWxEYezVm/k5ouuux/5n7USgLhc/+RoYQ7J0+LpFzvSSG6ntZoWgi
	1L5iGGcquDOmW4cf3nr0MJPeeLbkyKXqxx5kP/DzSIum3P+IiI8XvO+opzmCePog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r7YRe-000000065ei-34cP;
	Mon, 27 Nov 2023 11:02:26 +0100
Message-ID: <d13570223dd4bad257a719fb77b0cc4f2839cb36.camel@sipsolutions.net>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?=
	 <Michael-cy.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "nbd@nbd.name" <nbd@nbd.name>,
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
 <Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
 <Money.Wang@mediatek.com>
Date: Mon, 27 Nov 2023 11:02:25 +0100
In-Reply-To: <b4b3a5b0e6cf03564c6d09f01688dd41df5fe137.camel@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
	 <20231113021107.13110-2-michael-cy.lee@mediatek.com>
	 <9dd37c008572bb0938bd0d0a0fa207dd70aa8b98.camel@sipsolutions.net>
	 <b4b3a5b0e6cf03564c6d09f01688dd41df5fe137.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> The old flow also converted the Element to operation elements first,
> then it used ieee80211_chandef_vht_oper() to build the new chandef from
> operation elements.
>=20
> We think it's necessary for the case that AP is trying to switch to a
> 160 MHz bandwidth, while the STA doesn't support the 160 MHz bandwidth.

Yeah, you're right, it did before and I suppose it's still easier than
managing two conversions, since some formats are the same.

> Just like what had been done during the association,
> ieee80211_chandef_vht_oper() checks the STA's capabilities and builds a
> valid chandef for the STA. However, even if the STA doesn't support the
> 160 MHz bandwidth, ieee80211_chandef_vht_oper() doesn't mark the
> conn_flags as IEEE80211_CONN_DISABLE_160MHZ, so the same check is
> necessary when handling CSA.

Right.

> Like we had discussed in previous mail, we expected the patch will be
> simplified.

Yeah I just circled back to it for stupid reasons (I guess mostly forgot
to mark in patchwork that you were going to make changes) and looked
again after having looked at all the other code in the series I posted
late last week.

> In summary, the steps for STA to handling CSA are,=20
> 1. parse the new channel information from either operating class or
> WBCS Element.
> 2. convert the channel information into corresponding operation Element
> (HT/VHT in 5 GHz band and HE/EHT in 6 GHz band)
> 3. Build a valid chandef from the operation Element.
>=20

Sounds good.

johannes

