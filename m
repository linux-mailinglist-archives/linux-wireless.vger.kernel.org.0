Return-Path: <linux-wireless+bounces-38384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HougCQzEQ2qXhAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:26:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C77036E4D47
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uuIjcSYW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38384-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38384-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44D10300B9FE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE344192FF;
	Tue, 30 Jun 2026 13:26:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1E406812;
	Tue, 30 Jun 2026 13:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825993; cv=none; b=OdV8nTr2mvlOZcUhTzsCkuxcv4zJUzF+4OhZ8cNrywuceogEDWRJGgjQzbGHxsIJ900QkVbHSH8GftxtErY/zxz2WjJrlJIqJhaWC+psl+OBqUaEKO9A+ahubB4Dleum0sRohOLXh38jJSUPpcLxxCBY9pzLiNUEr2wYMVdFzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825993; c=relaxed/simple;
	bh=P+H2VKdt3H4VFRm7+/1xSBzaUNejyy46NlpKb6DPm48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF3nHDqluLCziGumnF420m0EcHWIipmZW4y/QzKyKF1d8iliMZo57g7eKQXg1QZY3HKfu8hiGN1WEdpzs65Ai4hH0wRbxqjjR9rfd0S8H0Q9EGmDVVZdmgrB3k4mn36jKKH/CacdSu6B5vffzWmVR6t8jvS0icjjATNngjCM+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uuIjcSYW; arc=none smtp.client-ip=80.241.56.171
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gqP721h9Nz9v56;
	Tue, 30 Jun 2026 15:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782825982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+H2VKdt3H4VFRm7+/1xSBzaUNejyy46NlpKb6DPm48=;
	b=uuIjcSYW0OS/og0ZRHzWORPstnCuC7dh2pewdBgWL42S9kyeRlh0Op/On4/oLzbSoAVlrn
	TJ3+AbZ6YV1a/t8SmxR6UXRIknfx4Sqxw+NsELOcvx44X1SqFqITuN6ClrGEWgt1vMPkrA
	mKKEkNbobwGT19v1lhEd4o38MKWhU/xgAfATbEwnoinFUwNu4ut/2vjsVnor0Quvx0s3fc
	rumAY17BouQXnd/X+tSxhDXgAoH9ZIm2uW60PBVj/TjzdpIbrhLOK3VMahhgv4cGZH0anv
	+R/e78FeqLysvIQalWSXGyRrIBfI7MvZJVDRwN1dhwtTVe2/PxCw4/PcVcjkew==
Message-ID: <6d1b5937df1fe002c47b226640f57fda2c0ee862.camel@mailbox.org>
Subject: Re: [PATCH 0/4] usb: fix UAF related to dynamic ID
From: Manuel Ebner <manuelebner@mailbox.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=	 <toke@toke.dk>, Johan Hovold
 <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev
Date: Tue, 30 Jun 2026 15:26:16 +0200
In-Reply-To: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: wura8epi8m1s77gcizumoj8tskoa3y49
X-MBO-RS-ID: ee80a4195932e5f6a8e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38384-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,mailbox.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C77036E4D47

On Tue, 2026-06-30 at 12:38 +0100, Gary Guo wrote:
> [...]
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

For all four patches:
LGTM.

I guess I'm not in a position to Acked-by or Reviewed-by.

 Manuel


> ---
> Gary Guo (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wifi: ath9k_htc: don't keep usb_device_id
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb: usbtmc: don't keep usb_device_id
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb: serial: spcp8x5: don't keep usb_devic=
e_id
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb: fix UAF when probe runs concurrent to=
 dyn ID removal
>=20
> =C2=A0drivers/net/wireless/ath/ath9k/hif_usb.c | 12 ++++++------
> =C2=A0drivers/net/wireless/ath/ath9k/hif_usb.h |=C2=A0 2 +-
> =C2=A0drivers/usb/class/usbtmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 --
> =C2=A0drivers/usb/core/driver.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 ++++++++++++++++-----=
-----------
> =C2=A0drivers/usb/serial/spcp8x5.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0include/linux/usb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 ++-
> =C2=A06 files changed, 29 insertions(+), 29 deletions(-)
> ---
> base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
> change-id: 20260629-usb_dyn_id_uaf-9d5f415387d4
>=20
> Best regards,
> --=C2=A0=20
> Gary Guo <gary@garyguo.net>

