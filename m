Return-Path: <linux-wireless+bounces-32501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMPSLAdaqWkL6AAAu9opvQ
	(envelope-from <linux-wireless+bounces-32501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 11:25:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEE20FA77
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 11:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D76730FAC0D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1732AAD1;
	Thu,  5 Mar 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lFW/itea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A84379EDF
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706036; cv=none; b=HhYDa/Yc1aV/YMk/589ekJkkIZguuNQkvB8VeXlDgLcXNLXY3fNHgzkbkc6Px8D7U8NfAAuS/XMs8D00JsUyS4YVecxzsj4F9V/s9x5/IGy8lLu6xWMG7Q3ZaE+HNh1lvg51LFkS4HpA3ej3OXsp2s2dtC5iihUAdyoRiJ5faHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706036; c=relaxed/simple;
	bh=XuriflBgFHwz1p+9mVF9EibjO9YhfzxpGuWNzRoLaf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiEhR4sdEQciFkSq8CYeOK6u9QTcYw32jYuDhdok3a3a66xS8UIi7NLs+A5DHHQ1uWEsv4cclNfu5UoEEJUiMZ3Q+IR+Jxn8CKqjlw562L87mqPKkHZFkkUQiZY5gPyOb56ItbuG9EYs55tD5HTs6m9q1Kxcqd+GaHV6wKgiqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lFW/itea; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XuriflBgFHwz1p+9mVF9EibjO9YhfzxpGuWNzRoLaf0=;
	t=1772706035; x=1773915635; b=lFW/itea/bXnOvShImQM3gA8w9VwJxMcUL21jl1UhzKNIt4
	RW2CiZp9hnAJ7CfUVAtBB5QRSNta0AcCVc19uMMqdC+bGMLT+kQLCaAOIZ2oh9k1Rs0koiq1+DcjE
	aEov6P2BZXUzxYORJw3jts2YhImku3gl89+m4SQQGHJPe9qz/Oz8/11KTxXE04pXC3Vw3BzNc2trS
	0D9cB+wRJpcTbaQRW7Ie9XFa7Hmxd6V1Uwaq7d3z32aPJr/qrmSzvbD/WVhNgGTQzH5rxjTi0QimY
	PghdN5I9ntcCESmW3GnQcJ1sepKMI6Ul2QurAtZeBMfgqwFlADo85KGVgZ9Wk1DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vy5om-0000000906o-2sFM;
	Thu, 05 Mar 2026 11:20:32 +0100
Message-ID: <0d823e5cd52792cae3e42afb6125c5c822554faa.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Fix static_branch_dec() underflow for
 aql_disable.
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Kuniyuki Iwashima
	 <kuni1840@gmail.com>, linux-wireless@vger.kernel.org, 
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Date: Thu, 05 Mar 2026 11:20:31 +0100
In-Reply-To: <20260304204317.1921550-1-kuniyu@google.com> (sfid-20260304_214324_630361_3D91D09C)
References: <20260304204317.1921550-1-kuniyu@google.com>
	 (sfid-20260304_214324_630361_3D91D09C)
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
X-Rspamd-Queue-Id: 22AEE20FA77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32501-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 20:43 +0000, Kuniyuki Iwashima wrote:
> syzbot reported static_branch_dec() underflow in aql_enable_write().
>=20
> The problem is that aql_enable_write() does not serialise concurrent
> write()s to the debugfs.
>=20
> aql_enable_write() checks static_key_false(&aql_disable.key) and
> later calls static_branch_inc() or static_branch_dec(), but the
> state may change between the two calls.

Fun.

> Let's add a static mutex and move static_key_false() there.

Wouldn't it be simpler to use static_branch_enable()/disable() and never
even bother checking the previous state?

johannes

