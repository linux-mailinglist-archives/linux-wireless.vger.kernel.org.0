Return-Path: <linux-wireless+bounces-35179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBhRGT2e52ml+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:56:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47243D023
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EABE30036E3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873A309EE9;
	Tue, 21 Apr 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F1HJKt7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EE23BD1B;
	Tue, 21 Apr 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786860; cv=none; b=U5BuIetFkgsFb4ph33Vhuu5wdvp3HrStrQ4BYmEhdOGcGDBSptGgxW3XRz5Nor7LIZMfce3SCjgpfnYtUh4Bw6SbSmPyrgBRJApURv3uNeTpMFhbgYRXiqE5fBGWn/stil47ZcAopqS7dvyQlD0VK8vAshIlxhkd/dqWOT5tiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786860; c=relaxed/simple;
	bh=sNNpnXmhChBY9D0sH+a4YdWwThfUoA6af4qc1j3CSvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6QM13VFDzTMRvDHemlk4XUI0IKkxBbXj4yt5QqneOQXz5MF2s6iX4sX4z95m0zsGM+UbbjYsa6CPw8XonaNhIWRxYGNOD8atAVJCZ0k7wQyRz+DCISi75qw+BK59qxz17ueKuIw/W1oboeRIdzjmO+g3KJa5MLnJ7SktZqAUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F1HJKt7F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sNNpnXmhChBY9D0sH+a4YdWwThfUoA6af4qc1j3CSvE=;
	t=1776786858; x=1777996458; b=F1HJKt7FEdyAM6M1PSB3Xxq8QIHagupLBcUAk2gvM7ClaTP
	CYWYUSCJ6lKoc/WDevRSyVnJROJ+yhFwNLABtN1L/JmtneCV2L8APWbxzzfGf8yrlSMKluN+UGCv6
	+Q+ywidU1F4p+LxEAiKIDLAOyDTQ7YgiuhuAXhldlE52p3Vo+57uBOgcx4FQvlxS7etqHqDBU5LnK
	NnUTJoVkLfM1NhfVFo4RJwfmZJ1mzQEEmNfE+RXHgmlnTLXp50UbVN3SjYM8j76RXENUZYiDOJ6Ql
	NciG9eiEydlfHEDYUxJisnHXSTDHFkDZruCAR0fHiEebkMKIolxy6XZ+JIrWvn9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFDQO-00000005Jsx-0j48;
	Tue, 21 Apr 2026 17:54:08 +0200
Message-ID: <6facdf8e06bc107d68086ac8db3330def09aaa6e.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"
	 <u.kleine-koenig@baylibre.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Christian A. Ehrhardt"	
 <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, 	linux-kernel@vger.kernel.org, Marcel
 Holtmann <marcel@holtmann.org>, 	linux-bluetooth@vger.kernel.org, Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, Ping-Ke Shih	 <pkshih@realtek.com>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,  Lorenzo
 Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Brian
 Norris <briannorris@chromium.org>, Francesco Dolcini	
 <francesco@dolcini.it>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 21 Apr 2026 17:54:06 +0200
In-Reply-To: <aeeFun4zdz360GCb@monoceros> (sfid-20260421_162828_161184_36113A7A)
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
	 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
	 <aeaMkfk_1t98e7SU@monoceros>
	 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
	 <aecu1ixyHP2hQvgE@monoceros>
	 <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>
	 <aeeFun4zdz360GCb@monoceros> (sfid-20260421_162828_161184_36113A7A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35179-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,collabora.com,lists.infradead.org,realtek.com,nbd.name,kernel.org,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: CF47243D023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

> > It's probably better for everything all around, including the various
> > automations that test patch series, if you just flip a coin, send these
> > to either BT or WiFi, and then resend the others later :)
>=20
> The first patch of this series adapting sdio_device_id is technically
> mmc material.=C2=A0

Right.

> However to demonstrate the upside of this patch you also
> have to look at at least one of bluetooth and wifi. So even if I drop
> one of those there are still two subsystems involved.

Sure, that's fair.

> And then in my
> subjective view it doesn't matter much if I involve two or three
> subsystems. Regarding test automations I would assume that if the
> bluetooth bot sees patches #1-#4 of this series it can do something
> already (involving either testing the series only partially or finding
> all 6 patches on lore).

Yeah, that's a fair assumption, except at least for wifi, the
automations (like netdev, the nipa software) only ever runs on series
that it receives completely, since everyone gets CC'ed on random things
too much and having the full series is a proxy for "should be applied
here."

> Having said that, I'm happy if the first patch is merged and patches #2
> to #6 are discarded by the bluetooth and wifi people. I'll come back to
> them once the first patch is in a release.
>=20
> > All assuming we get an ACK from whoever is responsible for patch 1 to
> > merge it through some other tree :)
>=20
> To make this more explicit: That would be Ulf as MMC maintainer.

I'm also happy to merge the MMC (with Ulf's ACK) and WiFi parts, though
that's even scattered with my sub-maintainers, but that just needs some
coordination... I'd just like to then have a complete series on the list
so I don't have to all the (build) testing manually.

If either BT or WiFi merge the relevant patches then we can sync via
net-next pretty quickly and get all of it done soon, if the first patch
is via MMC then it'll probably take a whole other release cycle ...

johannes

