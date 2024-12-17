Return-Path: <linux-wireless+bounces-16469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE769F49F9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471BF161CE2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F4F1EBFE1;
	Tue, 17 Dec 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cCepK+gb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C32F5B;
	Tue, 17 Dec 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435214; cv=none; b=ay+gGZVSp2h6ybumM8qh2cOvxfKAuvOhSkozvo7m/Q8RJLHRhgeQJkp2bV8dsFSR0nIJ7zwHJtJcDWoONk8R/Z/P2hRE1dGV+k15fSZpFMOj51rCi/oxzkEztfdFnZWkoIPP08hyd+oElWk/lEMlFtiaNxOKr8I8bOPnivaE0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435214; c=relaxed/simple;
	bh=8eSpCFU3mFgtDlnrbHSgypbaJf+8eWWNe9euGMobuzg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nph+tvkepjsvveC8Mb3rniNwqxuf1GEx7T8l1gnhlkqaPtw7cDrWIZjkdytFG/UbP5l8pvX14cGDDbouqIt8tlGpil7aZEDgLAWDDz3qheaHCC7m+8Hm9mmXg3XoqTLqNgGpezRsCOvNn866iubfO84tPmHOLCE3lxSTpURAOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cCepK+gb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8eSpCFU3mFgtDlnrbHSgypbaJf+8eWWNe9euGMobuzg=;
	t=1734435212; x=1735644812; b=cCepK+gb8j5FHcsF2e2xcw+gwq4em2WlXNpVDly7gMctMpt
	ScYuWRhLj0TrRBXIsZ/auegXnGKUdK8Vnys2sr2ZS+KqmATWDRBRESuvmjiMlGmf7KfHTZXAGA9OE
	ZpfjhKraefm36NE+3Urt/NCYyBhW9E4BLqy4AeHjnPMBIJ7mUQqFv0+vqTVOhN6T7TxYunq1hKN+K
	AP+QbNehooZpQUMEsX4C82Dw+au8QTQnqZpsZ+WH7seEPoxk4rC1dP02SsWRwm2OjYwN7HyyT50jt
	DmsxECpAUi1roIxLTT+PAoXSnS9UkFkizKzR4rs5BiCftnuXTkDOa3YWhzOQF2KQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tNVpK-000000026Dl-3lVm;
	Tue, 17 Dec 2024 12:33:23 +0100
Message-ID: <de5d98be99086a7182ba2bd0676b261349a145c4.camel@sipsolutions.net>
Subject: Re: [Bug] Deadlock between rfkill_fop_write() and
 nfc_unregister_device()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
	 <horms@kernel.org>, pabeni@redhat.com, kuba@kernel.org, Eric Dumazet
	 <edumazet@google.com>, davem@davemloft.net, krzk@kernel.org
Date: Tue, 17 Dec 2024 12:33:22 +0100
In-Reply-To: <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net>
References: 
	<CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
	 <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net>
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

On Tue, 2024-12-17 at 11:46 +0100, Johannes Berg wrote:
> On Tue, 2024-12-17 at 17:33 +0800, Sam Sun wrote:
> > Dear developers and maintainers,
> >=20
> > We originally encountered a task hung while using our modified
> > syzkaller. It was tested against the latest upstream kernel. We
> > analyzed the root cause and pinpoint the kernel crash log to the
> > following two tasks.
> >=20
>=20
> This issue has been known a very long time and should be fixed in NFC,
> but I guess nobody is around to do it.
>=20
> https://syzkaller.appspot.com/bug?extid=3Dbb540a4bbfb4ae3b425d
>=20

I think this one is also the same:

https://syzkaller.appspot.com/bug?extid=3D9ef743bba3a17c756174

and that's much older still.

johannes

