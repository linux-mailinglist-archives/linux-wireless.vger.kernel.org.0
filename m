Return-Path: <linux-wireless+bounces-1541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B57825BA8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 21:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F261F23F55
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8271DFC3;
	Fri,  5 Jan 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UeDhjOJa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75031DFD0
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SnElq5yrZB/z202fEDqJ6UnKppdrd6BJLDBJODe2vDs=;
	t=1704487017; x=1705696617; b=UeDhjOJa5Myd8decLCEk/lIZFtHbVq4I9lDcBRqLU4djq1w
	f4NHDlmLJ8MkMjGMPTxfSZdNe12IRDrkvFQSzopAGYA9MxBwHNkOXOkz5AvPd1PxP8wQr0kqBmehh
	m/+1MxNbxAYDQ1N4+uosHcnRDbv4j0k58ft9nGk0MSFGTm4tPMp5vlQ44wxjY2+ajaDTfMuxjWnoH
	cQmCbEYsevncJmJY/jYRVViFtBl3OMDH3V+FlvF7BVeRdQv6hLp+/Rt2NAt5ezYm28FT6xAC5EubW
	vg++LdWZoNcqrw1FSwqGMcX193+D6LPbUmsjlBIMDsBjN5G7liIO0feXh3mLG1Tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLqw1-00000006ONf-3kkh;
	Fri, 05 Jan 2024 21:36:54 +0100
Message-ID: <b39657b8e248443b1b728e81fd194942a02826d8.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: strip NLA_FLAGS from printed bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Matthias May <matthias.may@westermo.com>, 
	"linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Zefir Kurtisi <Zefir.Kurtisi@westermo.com>
Date: Fri, 05 Jan 2024 21:36:52 +0100
In-Reply-To: <728b6538-19b3-4fb4-b91e-f72080c4c9f0@westermo.com>
References: <20231221222842.1310957-1-matthias.may@westermo.com>
	 <6a54a2afd9e2b1b67822e3ca9b86654e3886feef.camel@sipsolutions.net>
	 <728b6538-19b3-4fb4-b91e-f72080c4c9f0@westermo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-05 at 21:35 +0100, Matthias May wrote:
> We saw that happen on one of our platforms where we are forced to use an=
=20
> out-of-tree driver by QCA (SPF12.2).
> If you think this is something that can not happen with upstream=20
> drivers, feel free to ignore this patch.
>=20

It should be independent of drivers, so they must have modified cfg80211
to explicitly use the nla_put_nested() instead of
nla_put_nested_noflag()? It's just ... weird.

johannes

