Return-Path: <linux-wireless+bounces-32343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDOOHyVGpWkg7AUAu9opvQ
	(envelope-from <linux-wireless+bounces-32343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 09:11:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 843831D4748
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D79A7300723D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409C383C74;
	Mon,  2 Mar 2026 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E/z+Wy4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E13803F2
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438831; cv=none; b=oRYD0rJERotOPKb4xixg8HhCnShmoGpd3oi+vqiFEQiMzXs2x0M3UiI/9smGfLnIX1tsY8DmxqKQClQlqQTHIH2mt9Xbr2HWwpXzn44mN1h0AmvCXUQPXnYtBUC2MGw5uc5NTVPz1GmRzIX4CxZIgBzYJQs5Z6CsZShXne6Y9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438831; c=relaxed/simple;
	bh=0RMhqP4cdKu7RyHGbl/3SdsNccuox8w69M18Eo9jxDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtu6LnV7QDSV6C1JrTSMme2PuVoYeU3Mb9eHK8gIhcU/JK5bD4WCsVWUUTtdAwQT8r3RPbAx3EUb4zpB53lyUcRJw0YEOnguHnoWFgsfbWnZV0ZkEtsURYfosCCYDmn4cVaSOJeYmsw8KsRpuwzO70tQS7RLx2Tbj7Kplv7EHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E/z+Wy4g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OkiFt+uB8UsibYpbmcOUuPEKBML0y7wKh0BdaI8RJwc=;
	t=1772438830; x=1773648430; b=E/z+Wy4gV+I2jrjDO2LHaeh+gZm4D62j09e6lTVPN5ecp+2
	d9TQNEYG/ocCbgsaLmsOTNbvIYuRE8pt15aXjYKvvBhBDr3TvAKjQpn3HTZ+v4mZygCLnprr3TCro
	+QHFHCLx14FNUdTdR3xH+MyRcB4gxFsW04ADNvTFokw3sZvs8DC2Merq6dZ87Zm/PY5shcLBmnkhp
	wAv4C0V1tZNG3e/4mFBfECW4J03hbVp0b1oM2QZEmoDaaLhX/+ckoP6AHflTcvG8Nw8pdnE1YDCPd
	arj5jLEkqDWP5hi5ccn1EOpSjrY1csrvqxpLWwGRKZqwlqmygyXEDT+sQ2YEgChw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vwyJ0-000000060iU-0syx;
	Mon, 02 Mar 2026 09:07:06 +0100
Message-ID: <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	linux-mm@kvack.org
Date: Mon, 02 Mar 2026 09:07:04 +0100
In-Reply-To: <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32343-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 843831D4748
X-Rspamd-Action: no action

On Sun, 2026-03-01 at 07:38 -0800, Ben Greear wrote:
> On 2/27/26 08:31, Ben Greear wrote:
> > On 2/23/26 14:36, Ben Greear wrote:
> > > Hello,
> > >=20
> > > I hit a deadlock related to CMA mem allocation attempting to flush al=
l work
> > > while holding some wifi related mutex, and with a work-queue attempti=
ng to process a wifi regdomain
> > > work item.=C2=A0 I really don't see any good way to fix this,
> > > it would seem that any code that was holding a mutex that could block=
 a work-queue
> > > cannot safely allocate CMA memory?=C2=A0 Hopefully someone else has a=
 better idea.
> >=20
> > I tried using a kthread to do the regulatory domain processing instead =
of worker item,
> > and that seems to have solved the problem.=C2=A0 If that seems reasonab=
le approach to
> > wifi stack folks, I can post a patch.
>=20
> The other net/wireless work-item 'disconnect_work' also needs to be moved=
 to the kthread
> for the same reason....

I don't think we want to use a kthread for this, it doesn't really make
sense.

Was this with lockdep? If so, it complain about anything?

I'm having a hard time seeing why it would deadlock at all when wifi
uses  schedule_work() and therefore the system_percpu_wq, and
__lru_add_drain_all() flushes lru_add_drain_work on mm_percpu_wq, and
lru_add_and_bh_lrus_drain() doesn't really _seem_ to do anything related
to RTNL etc.?

I think we need a real explanation here rather than "if I randomly
change this, it no longer appears".

johannes

