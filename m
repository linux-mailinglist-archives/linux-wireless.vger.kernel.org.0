Return-Path: <linux-wireless+bounces-38461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OaONL6AvRWqG8QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 17:17:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADB6EF2E4
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 17:17:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cC7q0JXt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38461-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38461-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B3C303D735
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84F481FAC;
	Wed,  1 Jul 2026 15:08:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5239060F;
	Wed,  1 Jul 2026 15:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918493; cv=none; b=U3PxBM0NAxC22HnwlffcHsh0D3VRjzxZ5jJSxJPighqHwx6Z8hzJIXJRbFTg1gBieLdr6v/oggRUK32bGtZGiwrtJaRCZqWPUXtSrzO+0SnUdW+hyzHpbN7T3pcvCTimAEHaP+2FqjcmvLcTTvI/2nDc9DyVvubV0UK5DY+ZgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918493; c=relaxed/simple;
	bh=n4frkwAq+5P0uEWR5WFhkRIJO8quwC2aYaGdGlPpXc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYqaFRORpGZkwgYYkGSsajw1Ee+dpveLkRR3D53rBtRaof0tdpC330Bhz+inbp2LMWRkQTKP8gzobI0sk2xUEf+hTpabdlM97xFxqbkPeDndIX2941bX1wb0yovv1J3cfRUg3/BOw558YcHxQAxaAgAG95JVYsoQ4NcGlE5p0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cC7q0JXt; arc=none smtp.client-ip=80.241.56.172
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gr3D31GkKz9tW1;
	Wed,  1 Jul 2026 17:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782918179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4frkwAq+5P0uEWR5WFhkRIJO8quwC2aYaGdGlPpXc4=;
	b=cC7q0JXtE5Ws3+O6rYpVzPKZCUV4c1RcQRnb4az+fNoLb0rQukpjG3MD/Jk0vdggz5k3Vb
	cMKzO0883aTNQK9U4ssInwYAs9PqdXe+Y3Acw8DG42eOSpUFIPi/o6wO7dnzdEHFaS+U2w
	P4YH1odc1YsKS7MBOSTPEbmi9fPsXykJMfK2L3/bY+jJWsNFy03uajHpJnMStIO6R8yRR/
	mek0QjA6vfGoxh35F/w2Wk6tYp7RIcpcPI3QikJHnFtyAO6HPTDaYhpHsAMfUudLhjBehs
	46CZSWRuBBks0cnxVFsGh1HQOUrE9JR28xpNnVk/eLbpsO4TuGS2308tYXy9Yg==
Message-ID: <c3ae1ee8f393d20843818e8a19b163179a98edf1.camel@mailbox.org>
Subject: Re: [PATCH 0/4] usb: fix UAF related to dynamic ID
From: Manuel Ebner <manuelebner@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,  Johan Hovold
 <johan@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev
Date: Wed, 01 Jul 2026 17:02:53 +0200
In-Reply-To: <DJMFC6N91KK9.6Y2UKU1Q0TWA@kernel.org>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
	 <6d1b5937df1fe002c47b226640f57fda2c0ee862.camel@mailbox.org>
	 <DJMFC6N91KK9.6Y2UKU1Q0TWA@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 48eaa12b366e30c57f6
X-MBO-RS-META: ny4ah5oycj1oe3aq9ec38njwd9or5amg
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38461-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gary@garyguo.net,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20ADB6EF2E4

On Tue, 2026-06-30 at 15:39 +0200, Danilo Krummrich wrote:
> Hi Manuel,
>=20
> On Tue Jun 30, 2026 at 3:26 PM CEST, Manuel Ebner wrote:
> > On Tue, 2026-06-30 at 12:38 +0100, Gary Guo wrote:
> > > [...]
> > >=20
> > > Signed-off-by: Gary Guo <gary@garyguo.net>
> >=20
> > For all four patches:
> > LGTM.
> >=20
> > I guess I'm not in a position to Acked-by or Reviewed-by.
>=20
> I don't know your background and I don't want to make any assumptions, so=
 please
> don't interpret anything in my attempt to clarify a bit.
>=20
> As documented in [1] "any interested reviewer (who has done the work and =
is a
> person with known identity) can offer a Reviewed-by tag for a patch".
>=20
> An offer from anyone who has done this work is much appreciated.
>=20
Then you can add my
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
to all 4 patches.

 Manuel

> Acked-by is usually used by stakeholders of the code (most commonly maint=
ainers)
> to indicate acceptance, e.g. for patch routing purposes. There are more d=
etails
> in [2].
>=20
> [1]
> https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statem=
ent-of-oversight
> [2]
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked=
-by-cc-and-co-developed-by

