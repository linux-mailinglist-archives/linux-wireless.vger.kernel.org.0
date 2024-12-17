Return-Path: <linux-wireless+bounces-16471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527249F4AA7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C4A1890F09
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB281F12E3;
	Tue, 17 Dec 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pNQCeYb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CE1E5708;
	Tue, 17 Dec 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437389; cv=none; b=tH1PJN/QySpnb5NrVjfqwK09fLwc1is2qr50BwBzXdomctDqwpnO8R988yvtiyv1aOG7IV0nLOxXVmrkbtL27o2MN0BVChGooaOytxtkPa5cPuEH78lj7VaX9p81gJtG3vbTK7rC1n/y2IXV+Iq3iyuQFv56ROu0HcgdsBEJrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437389; c=relaxed/simple;
	bh=/SG3AzAHOff+hccD3OcucAh5OThZTC7Mgq9xZD7ruxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVVGndGlEZKrMpJv9OjjYWzZUmrkJ6sAU5oMhNNeep/KyRqtKm/jPzm6vJPTljrIDYXK7Qkqal975O15Zo2nTZ+gU7IMhP7+HKtTABdmCOXoDUoyMIDJtJIky0g9Tu2sc9WrVJtkvsOlRBkXWIQnpCwXl2DdaHk6Xw+dwDe39X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pNQCeYb8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/SG3AzAHOff+hccD3OcucAh5OThZTC7Mgq9xZD7ruxo=;
	t=1734437387; x=1735646987; b=pNQCeYb83bndxl855f4uqARs9WCSwk/EO1DiZMYjKFFCzkh
	/yFNBKAw/VBS84dA5tpLBMsmQeQBmSA4iC5CxV9hVsP0ylxLG4scE4pa7/Bk9K9jXRWJnWw0lVpR1
	wVrO/9lzw/n0LLJujUghScnQY1xBq64E6EQyPCFPnDPvO3mVs+fDQjRkweps+ACOqWncOEeOIeDOp
	wWidTDmDJuV74Rq+QhG2vYwQbMXDmqKgy4BCJQUfI3zvv8YkCHMITbzLsx6PLWVXl5mdu5o73LYOk
	8PFylKxK5pJ4PxAN3Sicxs2tBg9XnUzJcK/m2aMZLG4izNQ74BHXQXpBuYuQX8rA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tNWOW-000000027FC-06Rs;
	Tue, 17 Dec 2024 13:09:44 +0100
Message-ID: <70f796f623a67b283c4fe3a1b56e59647a39ce6c.camel@sipsolutions.net>
Subject: Re: [Bug] Deadlock between rfkill_fop_write() and
 nfc_unregister_device()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, pabeni@redhat.com,
 	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, davem@davemloft.net, 
	krzk@kernel.org
Date: Tue, 17 Dec 2024 13:09:42 +0100
In-Reply-To: <CAEkJfYP297P=RjvZ9-ctpYHXu7bDhVN0+ZBoMNz2xjzyqOakLQ@mail.gmail.com>
References: 
	<CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
	 <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net>
	 <de5d98be99086a7182ba2bd0676b261349a145c4.camel@sipsolutions.net>
	 <CAEkJfYP297P=RjvZ9-ctpYHXu7bDhVN0+ZBoMNz2xjzyqOakLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-17 at 20:01 +0800, Sam Sun wrote:
> On Tue, Dec 17, 2024 at 7:33=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > On Tue, 2024-12-17 at 11:46 +0100, Johannes Berg wrote:
> > > On Tue, 2024-12-17 at 17:33 +0800, Sam Sun wrote:
> > > > Dear developers and maintainers,
> > > >=20
> > > > We originally encountered a task hung while using our modified
> > > > syzkaller. It was tested against the latest upstream kernel. We
> > > > analyzed the root cause and pinpoint the kernel crash log to the
> > > > following two tasks.
> > > >=20
> > >=20
> > > This issue has been known a very long time and should be fixed in NFC=
,
> > > but I guess nobody is around to do it.
> > >=20
> > > https://syzkaller.appspot.com/bug?extid=3Dbb540a4bbfb4ae3b425d
> > >=20
> >=20
> > I think this one is also the same:
> >=20
> > https://syzkaller.appspot.com/bug?extid=3D9ef743bba3a17c756174
> >=20
> > and that's much older still.
> >=20
>=20
> Thanks for your quick reply! I am sorry that I didn't double-check the
> call stack of historical bugs reported by Syzbot. I will be careful
> next time.
>=20

No worries. Maybe someone who feels responsible for NFC will wake up ;-)

johannes

