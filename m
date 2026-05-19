Return-Path: <linux-wireless+bounces-36655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHWKCbZUDGqmfAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:16:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE557E7CC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8909530182B0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916743BCD3D;
	Tue, 19 May 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WMk6sCbk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255A4C77AD;
	Tue, 19 May 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192701; cv=none; b=Nro1WBaTI6b/myNfvxnxoil5hG3QF6BL4L5MOrMAfsDxFXvl6ztZqvr2fBimwZZ1ReseCCfGY3esqq9WKYARVNF01iFutBOgD3PGO2clzqN0ndpeIultAKMqMSxqX7xUqOdCcUbqtC2F1ACpj0eTnNufnfs+r5mOmWhh3ApVmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192701; c=relaxed/simple;
	bh=BzPILivh8u0VPbKcKjEXQnpX2c2Ts/Bj0Ue0PAy66jM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEOmtaoeDbsOecbhWBcKqwQSJ/nGo9IleLaXdQZnCO2yAl7HoQoTrJ5xCdc8ZpQFhOa+5Mtv6qr+XibsZPraT6gMSweze4hrL8Z+4AwU1NP3YH/8AEeMCnV0iiNVdelHH93INkSU23GXG6A7DF++YUBGJShadsiy7PLExJsXfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WMk6sCbk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ii8DV8jwO7CRY9lsiWuhphBYKigNJYNHkFu2YjA2p4A=;
	t=1779192699; x=1780402299; b=WMk6sCbkgzb+GmDru/5SYDjY9GXm07/dJ8pUJEWBXFOlDtk
	LmREyj2tBD9njzGSAMmvQBo9oW+j6GYSQ/xrwrNApiA3jD3b0RPt/4nK61yTuHbdEo7LEf9E+J3eN
	4SvJnrLd18eo1JpSDsn+ZLoX0m2P036t1L2/sRRUZ55Re8zwxj/dSFlVRJoqlgLIWFPDyzMLEfZJR
	ubqlGgRpL0GcoJRjIaA/7n2etvvjt4wQQxCtFpq0LpTtBSpFL+BeaIp9OSgqxyTCpJuJHdxxe3UIR
	S3E5qanhtPbBo6vLJKI2Th4nn7CQYZ9UpJj8FRIvKQp0y6QXgIvyUbhehBkBfJDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPJIO-00000006ZBJ-1TkK;
	Tue, 19 May 2026 14:11:36 +0200
Message-ID: <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
Subject: Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add hw_info sysfs attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Johnson Tsai <wenjie.tsai@realtek.com>, driver-core@lists.linux.dev
Date: Tue, 19 May 2026 14:11:32 +0200
In-Reply-To: <efb61959e14e4f57b78fbd49a563398e@realtek.com>
References: <20260519072415.25746-1-pkshih@realtek.com>
	 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36655-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: A1EE557E7CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> > Example usage from user-space:
> >   $ cat /sys/bus/usb/devices/2-3.1.2:1.0/hw_info
> >   SN: 36 42 00 01 23
> >   UUID: aa ec 2b 7c 0a 55 47 27 8d e0 b3 0f eb cc bb aa

Sysfs has a "one value per file" rule (soft rule according to the docs,
but harder in practice, I believe), so seems if anything that should be
two files. Maybe a UUID should also be formatted as such with %pU or
similar.

> I also looked up lore.kernel.org and only found a thread commented by Kal=
le [1].
> However, it is not clear to us if sysfs is suitable to read efuse SN/UUID=
.
>=20
> [1] https://lore.kernel.org/linux-wireless/87ziib3da5.fsf@kamboji.qca.qua=
lcomm.com/

It seems to me this was more in the context of _writable_ files to do
some operations.

I don't think I have a problem with this, but sysfs also has
documentation requirements, and we should probably ask
driver-core@lists.linux.dev.

I'm not really quite sure I see the _point_ of identifying the serial
number of a wifi device in a container, but I guess you do.

johannes

