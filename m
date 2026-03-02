Return-Path: <linux-wireless+bounces-32345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME/bIrZvpWlXAgYAu9opvQ
	(envelope-from <linux-wireless+bounces-32345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 12:08:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF31D7341
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D6C730074DE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CA3603DD;
	Mon,  2 Mar 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tdawdhDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB73603C8;
	Mon,  2 Mar 2026 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449710; cv=none; b=hiHn3bYqxCk9rRE8/KinKCPGnxGvUpc2Qv+BH6dShrWAt7lb2557KcaWpWB2Xz9rI9je9r5Z+1JneAjQVAisPc7eSaq3Vveg6P5xpND98kvXFjZvzvQUNhI2l2JOvekbiLRZByE6b6IpAodRiSQ1/KF6sgfy7aqYe8ikazJlOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449710; c=relaxed/simple;
	bh=LgDdTMJ4ne2r+2Ntubk2gBsYHIi3L38fvrPK3J3KDus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hexs2yykKLzhdjxNVdlW58kyPkJ7AVc9+qpqsCnjQyr5omnvw0kjCorEgeykWEalEjPdleNT42QY8el+ZzQRVySIz+9X8ICQIYt8zwC9We4P4qdOhFJfkkq3XzWpGQa55rjMn1v0PMXGva6RZ3tmWYkuWQSxNp8DoJB28+Ot/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tdawdhDx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LgDdTMJ4ne2r+2Ntubk2gBsYHIi3L38fvrPK3J3KDus=;
	t=1772449709; x=1773659309; b=tdawdhDx75wg92CDWf60IJVvFKzXU69/881/0Ziu+eIvTUn
	gZUMjangLyQAQet8v5HFyTJnVDUqBvjKYTEwzpjv9f2S70PHI552XhNVDJddxkqX8RfS/Jv7I59ZY
	fWhYBRRms0oUMC/9IoZjZgdxwrkVa5ImlLScA2kU/Qkwl8Y/2UVeoOfovBSP4GxEwzCqm0zxivN8q
	w+nwghFLYxM077IGcj1W5WqaI/AZvzgCeOdF2hyhZelm2PZlAyhk5zpA+zPpvaoA7VM52rutP9+dM
	/pLmcg/A/xpw4ypRw6zqrfxmddgLt0K6zQivNVx55C8XozfsiGyrD/QrM23sbLGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vx18I-000000065Zo-3cId;
	Mon, 02 Mar 2026 12:08:15 +0100
Message-ID: <38b05b3519fc7b1ddc91937990d4b667d6314d78.camel@sipsolutions.net>
Subject: Re: [PATCH 24/62] net/cw1200: Fix locking in error paths
From: Johannes Berg <johannes@sipsolutions.net>
To: Bart Van Assche <bart.vanassche@linux.dev>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun
 Feng	 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Christoph
 Hellwig	 <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, Nick
 Desaulniers	 <ndesaulniers@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Kees Cook	 <kees@kernel.org>, Jann Horn
 <jannh@google.com>, Bart Van Assche	 <bvanassche@acm.org>, Kalle Valo
 <kvalo@codeaurora.org>, 	linux-wireless@vger.kernel.org
Date: Mon, 02 Mar 2026 12:08:13 +0100
In-Reply-To: <20260223220102.2158611-25-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
	 <20260223220102.2158611-25-bart.vanassche@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32345-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Queue-Id: 79AF31D7341
X-Rspamd-Action: no action

On Mon, 2026-02-23 at 14:00 -0800, Bart Van Assche wrote:
> From: Bart Van Assche <bvanassche@acm.org>
>=20
> cw1200_wow_suspend() must only return with priv->conf_mutex locked if it
> returns zero. This mutex must be unlocked if an error is returned. Add
> mutex_unlock() calls to the error paths from which that call is missing.
> This has been detected by the Clang thread-safety analyzer.
>=20
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org

This, and 25, are part of a larger series and I didn't get a cover
letter, so not sure what's supposed to happen with it.

johannes

