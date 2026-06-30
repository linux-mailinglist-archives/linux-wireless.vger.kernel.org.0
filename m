Return-Path: <linux-wireless+bounces-38387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lhUuDBnIQ2rahgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:43:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D96E4FAF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XzRSf7rB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38387-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38387-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C19C3027877
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC903672A8;
	Tue, 30 Jun 2026 13:39:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164836494F;
	Tue, 30 Jun 2026 13:39:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826755; cv=none; b=Y7j8bR+v7BeIqd/0rf8ucGANmr+fi8UwppWdwcnf6+VUl8UmAu5Ibfl14RH7NSGCGhy2SiNAumP3I76APx06LCgKCTTb1P4wbzJ0YRz3+aqB2W8i0Jwf2AbRfSi1x4rIiSJWPGN4DvxDiZks3zJnYUKMYfNVh49ic2E0GHjZW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826755; c=relaxed/simple;
	bh=V22YxPDmdPZguxRKjI1nMOsakh5MecXZIShdVgxeZW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KtHKzRSvJ/8uUMPM6onMaLUsA3qJvozkn+oIAypKdLonz/5mexDHOsKxM/njkoa3UlO9CY4aUeXLVruE6Qr4glJaKti/OlTrt7aC0V1VwtFbS73GqObNruTGdMhEHcx9CW9H5yxUFYOTyDFFx6RojugxbMSb3bzblmrJOJ3vO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzRSf7rB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A62C1F00A3E;
	Tue, 30 Jun 2026 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826754;
	bh=V22YxPDmdPZguxRKjI1nMOsakh5MecXZIShdVgxeZW8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=XzRSf7rBEBgQp5gYewjvhBlUxppNvvDbqjusuQv8RZdPSBV/ZY+imewmCMlfC998D
	 o/9oUZE3CEZuBgoR2RzGHv2CM6nejbSRCbM6dYVdHQetCXJDhdZlulnZ7iEANGAWPa
	 4vs9pFbhxrXuesNPj8BRLV5HbuxrM0zXyhwfBpyyaSSLS7EJvfvS9Y3psyBpQhtpu5
	 EOIjmqFmwTOBZQiBGq/RmaA328cv9XlIRDoHZvv9hTxXptw9NoDj5VQR2QVj+7OzHu
	 w21cb2eYI186SgelRdFVgPpqy7b85R+/UvHJHtS5h9ZZJ6hooUy3qNNKcmUB7kngpA
	 3CEwM5hFwpA7g==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 15:39:10 +0200
Message-Id: <DJMFC6N91KK9.6Y2UKU1Q0TWA@kernel.org>
Subject: Re: [PATCH 0/4] usb: fix UAF related to dynamic ID
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Johan Hovold"
 <johan@kernel.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Manuel Ebner" <manuelebner@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
 <6d1b5937df1fe002c47b226640f57fda2c0ee862.camel@mailbox.org>
In-Reply-To: <6d1b5937df1fe002c47b226640f57fda2c0ee862.camel@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38387-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:manuelebner@mailbox.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596D96E4FAF

Hi Manuel,

On Tue Jun 30, 2026 at 3:26 PM CEST, Manuel Ebner wrote:
> On Tue, 2026-06-30 at 12:38 +0100, Gary Guo wrote:
>> [...]
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> For all four patches:
> LGTM.
>
> I guess I'm not in a position to Acked-by or Reviewed-by.

I don't know your background and I don't want to make any assumptions, so p=
lease
don't interpret anything in my attempt to clarify a bit.

As documented in [1] "any interested reviewer (who has done the work and is=
 a
person with known identity) can offer a Reviewed-by tag for a patch".

An offer from anyone who has done this work is much appreciated.

Acked-by is usually used by stakeholders of the code (most commonly maintai=
ners)
to indicate acceptance, e.g. for patch routing purposes. There are more det=
ails
in [2].

[1] https://docs.kernel.org/process/submitting-patches.html#reviewer-s-stat=
ement-of-oversight
[2] https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by

