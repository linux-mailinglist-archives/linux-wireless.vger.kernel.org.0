Return-Path: <linux-wireless+bounces-24904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC8AFC353
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682434261A8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114F2222D4;
	Tue,  8 Jul 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n4rnXU8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85C9461;
	Tue,  8 Jul 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957543; cv=none; b=kzjCSOsFqclMlDB8LU7jlVOCUTIYOryDAuId2ENhAGsJBMo2/VY7WSHioKBRH+rEHIekR3zeGH7r923h/nhV0DwQenFyDURPa6nUYT6HB3AXmC4XU1EKN7O4QCWVNaapkKMb+hVs7Db7rUIMogt/ZmeufO828yit5zqeNcW4ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957543; c=relaxed/simple;
	bh=QgkicBTpwhIu4KhwMQ9MKtUqejjyYnHk87N/snpkRoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6Z4uTWaMO8GQ4FZzXFalcDreTnMfeGHcRHbPTGUVB5YSxkMBtA+6s7yJAWD68vv0bp/L9xZQuDHdrOD/gPmLAwW6bUHwpOJXWUpAdG6auTmCm00bm+XulCXTkV6/IbGQbTDVWOhPMjNyhoCAR3qqzqKZiBzqjVyD7v11cNmho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n4rnXU8Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QgkicBTpwhIu4KhwMQ9MKtUqejjyYnHk87N/snpkRoM=;
	t=1751957542; x=1753167142; b=n4rnXU8YwOUQP1z7Vh14gcY7GRmkgNNX04XcYJMzWOkDkBo
	Mu+AHAmEoxXdFpcmUMqXq7JqihpB+qgkt+l7Ep7KLwz0ZTpxVqQu8QVKDwgHzXvMwT5EwjVZKVhQW
	8UZR5MBi3HMvBjEeWL9nrtl4E40Lr16l23O5P4qyS6KtLLKIvVI7sqKvVhAHQbEsbNSq+sRfSOXss
	iFDm5z2NQyARgBRjfMoF0uOMJu5kaqtXXNOsXMNXrvYVPt2o9aZ+SywBNrZxCYvViy6HCHY7BZ89e
	EqShB7dTWdOxvmgnJ91SGR92t2xJ/Pln2Nk+07Hy+5kCwSswCfMiLaIh0QxlfxjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ2BD-0000000BePp-1ddS;
	Tue, 08 Jul 2025 08:51:54 +0200
Message-ID: <304f48242d99fec81990d492777cb45a58aa038c.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] wifi: rt2x00: add OF bindings + cleanup
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, yangshiji66@qq.com,
 ansuelsmth@gmail.com,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka
 <stf_xl@wp.pl>,  "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS"	 <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:MIPS"
 <linux-mips@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"	
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Date: Tue, 08 Jul 2025 08:51:44 +0200
In-Reply-To: <CAKxU2N-XviPav1Bh0yidyMUr=QbMr=0jyYyHKc+h0oaM9vak=Q@mail.gmail.com> (sfid-20250708_005520_408645_C4B0336E)
References: <20250706214111.45687-1-rosenp@gmail.com>
	 <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
	 <CAKxU2N9vs5o4tj-9KxCHKevWU+J9wv+ZCOeD8o602y1GY8FzNw@mail.gmail.com>
	 <b3a63d616c1ca337f6b9d14a9afaafe73bfbe8cc.camel@sipsolutions.net>
	 <CAKxU2N-XviPav1Bh0yidyMUr=QbMr=0jyYyHKc+h0oaM9vak=Q@mail.gmail.com>
	 (sfid-20250708_005520_408645_C4B0336E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-07 at 15:55 -0700, Rosen Penev wrote:
> >=20
> > Yeah well. That doesn't really mean it should be merged together though=
,
> > and we can pretty easily make that work by just putting the further wor=
k
> > in after net/wireless is merged back.
> Looking at it again, I'm effectively removing rt2x00soc.c . Meaning
> Felix' patch is mostly useless here.

But we're not going to put your changes into 6.16. They're not even
entirely ready yet, from what I see in the thread.

> It might make more sense to submit this series at a later time.
>=20

By end of the week Felix's patch should be in wireless-next too, if I
get all the things done right...

johannes

