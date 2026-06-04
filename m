Return-Path: <linux-wireless+bounces-37390-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1zvCDlWDIWoJHwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37390-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 15:53:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FD6408E4
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 15:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="ke+AD/f1";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37390-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37390-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74364308E6B8
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0847DFBE;
	Thu,  4 Jun 2026 13:49:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D647DF80
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 13:49:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580985; cv=none; b=TrFOSpvxOXNiSESI2IPyWWAFCc7QSxjDh1A9pqmsat9UpFUPHsV989rqWnqifoJLndq10WcAG9y33vgnri6DYxfNehM0ro5RsBwJAav7AnsOdDSn+MT6u0hQtHQIHd7Y7mlx8qrHywAplj1Qqg2ar7nczDVlFdqG2/uP71x3yp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580985; c=relaxed/simple;
	bh=JD92VZSW/OyDjTtFWVB7GTOMhFL2j8mF5xfhFT/RXNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7UmQcFgBo3vnD9e1G/rzYSjwM+p8FTx/9ePSEjIlGBYU8JTFxp9XmZihEyVQcIQNpk4jxC1LhhYd8NLYyudejCeS8CHJG1iGc97JxjKayD26Ap5mqR6mANMP4TfwLretYt01H5cXYEWbxzdMemFxWagI9XG9K0547kF7L+2WAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ke+AD/f1; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4F+m1ONjD4u0+SN45MxCNp2bTSfMX+G00I7GDNPV60Q=;
	t=1780580983; x=1781790583; b=ke+AD/f1nXRfqHhfwgdzjHJck1TH0fub4Oa2xVA8PzPGBrQ
	d58sd8VreRrIB1l+XWBBLsV7s9fMEl84aws7iNKQjIwW+SBkyS/7jutaNJxwwpzBsaZOVuTSTUUq2
	QlAVp0B/pjxN9KPzn4Rsqdrw451+5q8gKK5uO/5mZH1iBeKaJVBCIpimJHNqSPpYhUWdqJKp7lZAi
	Y0VbJ2SKBL5fVZxrmqQVThpolhCjakDCqdWGK7e3/SYmJliiK2PjusdWAsera4tyyNwGcoQLAComr
	RVT0Mm6aonDq3yxzikcgLb03+AVzEc0dhewhFYH7KUGuArpl//jmQb14l1CXenTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV8S4-00000000W24-3Jrr;
	Thu, 04 Jun 2026 15:49:40 +0200
Message-ID: <68154cc80be7b2ddffa74a72eb59f1383ff8ee75.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Peter =?ISO-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>, 
	linux-wireless@vger.kernel.org
Date: Thu, 04 Jun 2026 15:49:40 +0200
In-Reply-To: <20260604153917.4c065791@kemnade.info>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
		<20260508102403.4e2fb1bc@kemnade.info>
		<a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
		<20260604120834.508f606f@kemnade.info>
		<ba6e767a75b02c11d4bec542c971c1affda77df9.camel@sipsolutions.net>
	 <20260604153917.4c065791@kemnade.info>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andreas@kemnade.info,m:astrand@lysator.liu.se,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37390-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sipsolutions.net:from_mime,sipsolutions.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC9FD6408E4

On Thu, 2026-06-04 at 15:39 +0200, Andreas Kemnade wrote:
> Hi,
>=20
> On Thu, 04 Jun 2026 12:23:50 +0200
> Johannes Berg <johannes@sipsolutions.net> wrote:
>=20
> > > >  =20
> > > btw: if the firmware is started for a second time, it will also decre=
ment again.
> > > So after some reboots we end up without any cipher.
> > > And afaik the firmware ups at any ifup. =20
> >=20
> > Maybe just send a revert for now?
> >=20
> I was preparing something while you wrote this. Do want anything simplier=
 for
> now?=20

I picked it up into wireless-next for now, not sure if we should do
anything for 7.1 still (it's getting close) or just have this go to
stable later maybe.

johannes

