Return-Path: <linux-wireless+bounces-24883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94355AFBAE1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FA91BC04B4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D5266573;
	Mon,  7 Jul 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HSd11O/l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A892641F8;
	Mon,  7 Jul 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913382; cv=none; b=BUc88qj5cWcG2KaeLX8WoNbMjf/GGUb0MxKIF56+TeFRGa3Z6okO8hNWCcr06PUm9+EToQK3yesaDHFB4JTTigjK3WA3eRBYPyj8I4fWs6ezj3iPwt/13S/uBHYiQKQJu0CND/3k5im6+Y7p5dur9W/E3FVV2bSw6KCpHd1WlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913382; c=relaxed/simple;
	bh=Fb872cZX0i5UOEEY0lW5GdYCsAbSiYuftSvz3M8IhDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giWYDqmbBy2i+f2sxlv5oKzPwxrN722TYAQ/YmsXfwqU7g1s6v4b1RFJXagyruj4QjVH8YzDe/Z3VCMsloxxzgy+pNCjp3CtenqG6Yu4BFZ4GwyMZD5vNuFm4gSfq70J7pkacNfzKYjWHJcCOrtxcXJrA9jDbDNvqxerKCHSXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HSd11O/l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TdR6EPiemGpohVq7T8ccywqpepfo1bqholedAB1HuL8=;
	t=1751913380; x=1753122980; b=HSd11O/liyOTsrvyw4Q08A4nKkkkAnsKVefEC98fiKRXxif
	ktIQfPHQ+bp3FBD5FWN1kYX7ir6uAC9Jaor0TPR76BPL8RnUdJ+8cCDbbWzv9rofFrfliR7kAWrmf
	NIwWtO71Vp7ZYYXESbr4cR7kHQJn4AX672PNBkc1Xt6AaVCMC9I5IRj/4/XK4ves9qIqIkzQPVugx
	WqezQLbUm1x3jA7SgWvGP9sqafNBBuPwdYfi5HoQCWoi/SeJ43aMCOgm02nDLnID1LT9564J7HIQs
	MYONmxkrZM8z7z1dbwYSecNNCr5QIO5eeYnGWY4uuhsXka3fyBhUrk2VK6pLNERw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uYqhJ-0000000ApJ4-2NVt;
	Mon, 07 Jul 2025 20:36:14 +0200
Message-ID: <b3a63d616c1ca337f6b9d14a9afaafe73bfbe8cc.camel@sipsolutions.net>
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
Date: Mon, 07 Jul 2025 20:36:10 +0200
In-Reply-To: <CAKxU2N9vs5o4tj-9KxCHKevWU+J9wv+ZCOeD8o602y1GY8FzNw@mail.gmail.com> (sfid-20250707_194212_070361_0730191B)
References: <20250706214111.45687-1-rosenp@gmail.com>
	 <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
	 <CAKxU2N9vs5o4tj-9KxCHKevWU+J9wv+ZCOeD8o602y1GY8FzNw@mail.gmail.com>
	 (sfid-20250707_194212_070361_0730191B)
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

On Mon, 2025-07-07 at 10:41 -0700, Rosen Penev wrote:
> On Mon, Jul 7, 2025 at 2:01=E2=80=AFAM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> >=20
> > On Sun, 2025-07-06 at 14:41 -0700, Rosen Penev wrote:
> > > It doesn't even compile. Added OF bindings, documentation, and other
> > > stuff to hopefully this doesn't happen again.
> > >=20
> > > Rosen Penev (6):
> > >   wifi: rt2x00: fix compilation
> > >=20
> >=20
> > That was half covered by Felix already, and really shouldn't do two
> > things at the same time anyway.
> Just saw what you're talking about. That's gonna be annoying though.
> The COMPILE_TEST commit will cause compilation to fail and the bot to
> complain before Felix' patch gets merged.
>=20

Yeah well. That doesn't really mean it should be merged together though,
and we can pretty easily make that work by just putting the further work
in after net/wireless is merged back.

johannes

