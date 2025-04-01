Return-Path: <linux-wireless+bounces-21022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF9A775BC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1388A3A8ED1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388ED1E47CA;
	Tue,  1 Apr 2025 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WVH0tvBM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FF1078F
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494194; cv=none; b=A0X8Q7IqaeFZAzxEGjKm9JK50f95EyJQYg1dynNdKX1O5onBfN1IRs/apto16uzh3qs6/7Sw4mdGfCTb2EJfubci3jR1LK+mGwSfd9xctDoobTDELXJSoOJQr7w7ShQ/tUK5fg1sJI7kbZ2YgMh+sM3nlNWyooTP192v9+OrwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494194; c=relaxed/simple;
	bh=/Bo5bYwXAw1JSj4iMW3hbUB54GZbPf6jG4p5n2DtEMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfCdyCqn+JbzyL0efe2GCoFrFEg2QlbZqMOoVvNQ0jXgTgb4j8g8PF7YqZ0KR7uVaWVegDVw2sYTAulZoWgXeW+juuM07qliPOH9sZF9TcemUP7R7o03NV4/XcR5yf4jVk+/akRNGejTNnMp0v8hfC7zPS9zrI9OQHFozCWe/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WVH0tvBM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/Bo5bYwXAw1JSj4iMW3hbUB54GZbPf6jG4p5n2DtEMo=;
	t=1743494192; x=1744703792; b=WVH0tvBM3NiVK0AK8edOhO1113oUoXWyTnQKIQ6ujjeNisf
	6fiuevmF+Ejo1oIpFetns7rfrt0OoXp/NtSUzGAlu8nAOo4gcDnU/G042Tg3uvPast0QUD4l3LAHv
	u9AwJV7sL9b+YQqeEq2fAQDmB9qNDJwzt2ggAWtHlSqQNmgxyUUP6fCQtrbqq2I6FhKgFWUED1ktR
	e5XsIB/wfES7qPgwQNiVj2yP6LpekGC0v1D2IO5iCyjg1OE5LXo1CThRZx91sA96m70Kz4MAcxwNW
	4w1AgLnWOYiwAwrZbPtgz2Fr+BwAP3N2hl6fL6GFVea4bylKBc9mM77RLBEa83YQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzWTw-0000000C8U9-0sQN;
	Tue, 01 Apr 2025 09:56:24 +0200
Message-ID: <b9734a917c3a085f1fe1fc8d11acd36448370c64.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7925: add EHT preamble puncturing
From: Johannes Berg <johannes@sipsolutions.net>
To: Allan Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AE=B6=E5=81=89=29?=	
 <Allan.Wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
 "lorenzo@kernel.org"	 <lorenzo@kernel.org>
Cc: Leon Yen =?UTF-8?Q?=28=E9=A1=8F=E8=89=AF=E5=84=92=29?=	
 <Leon.Yen@mediatek.com>, Deren Wu
 =?UTF-8?Q?=28=E6=AD=A6=E5=BE=B7=E4=BB=81=29?=	 <Deren.Wu@mediatek.com>,
 Posh Sun =?UTF-8?Q?=28=E5=AD=AB=E7=91=9E=E5=BB=B7=29?=	
 <posh.sun@mediatek.com>, Eric-SY Chang
 =?UTF-8?Q?=28=E5=BC=B5=E6=9B=B8=E6=BA=90=29?=	
 <Eric-SY.Chang@mediatek.com>, Quan Zhou
 =?UTF-8?Q?=28=E5=91=A8=E5=85=A8=29?=	 <Quan.Zhou@mediatek.com>,
 "linux-wireless@vger.kernel.org"	 <linux-wireless@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org"	 <linux-mediatek@lists.infradead.org>,
 Mingyen Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=98=8E=E8=AB=BA=29?=	
 <Mingyen.Hsieh@mediatek.com>, Shayne Chen
 =?UTF-8?Q?=28=E9=99=B3=E8=BB=92=E4=B8=9E=29?=	 <Shayne.Chen@mediatek.com>,
 CH Yeh =?UTF-8?Q?=28=E8=91=89=E5=BF=97=E8=B1=AA=29?=	
 <ch.yeh@mediatek.com>, KM Lin =?UTF-8?Q?=28=E6=9E=97=E6=98=86=E6=B0=91=29?=
	 <km.lin@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>, Soul Huang
 =?UTF-8?Q?=28=E9=BB=83=E8=87=B3=E6=98=B6=29?=	 <Soul.Huang@mediatek.com>,
 Michael Lo =?UTF-8?Q?=28=E7=BE=85=E7=92=A7=E7=AB=A0=29?=	
 <Michael.Lo@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>, Robin Chiu
 =?UTF-8?Q?=28=E9=82=B1=E5=9C=8B=E6=BF=B1=29?=	 <robin.chiu@mediatek.com>
Date: Tue, 01 Apr 2025 09:56:21 +0200
In-Reply-To: <aa5c71fe08572f578f322a6ef9bb7727fe8f4023.camel@mediatek.com>
References: <20250331091747.2592021-1-allan.wang@mediatek.com>
		 <bb2c561c7b849dcf9c129520a28f8d5667e5bd8e.camel@sipsolutions.net>
	 <aa5c71fe08572f578f322a6ef9bb7727fe8f4023.camel@mediatek.com>
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

On Tue, 2025-04-01 at 07:50 +0000, Allan Wang (=E7=8E=8B=E5=AE=B6=E5=81=89)=
 wrote:
>=20
> To compatible with firmware control, dscb present is required to 1
> while bitmap is non-zero, and 0 while bitmap is zero.

Sure, but ...

> > > +=C2=A0=C2=A0=C2=A0=C2=A0 req->eht_dis_sub_chan_bitmap =3D chandef->p=
unctured;
> >=20

that's an __le16 getting assigned from a u16?

johannes

