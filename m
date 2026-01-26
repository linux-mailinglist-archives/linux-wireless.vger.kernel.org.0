Return-Path: <linux-wireless+bounces-31173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCweB7NEd2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:40:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650687219
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16E9B3015B92
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD52D060B;
	Mon, 26 Jan 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mUjNDqJ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24238330660
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423840; cv=none; b=plXp5H1LiitBtekpcrHN7yzk4ZPhj6nN3ZNqQho0s2TUYV4B5FtPCvNjGIHMCkQlsqakQaOFZ1a+dkWUNSZoHOcVHg8rzI8dcQiBzL0RAzLwiITAqqz17vmrXfqjn8f3YJWs4Vh8PtScCpVss4ReM5L1U95zQixIYOhIHVQX6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423840; c=relaxed/simple;
	bh=YDd2JzWliFqrWbZfJPu0/NotnK4TNAffHVQLEGs7TDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNz53y8nglMRX72BiSoK34v3fK9r2imIhlfRBd2yD92/DMa3NCzTCgBoMCr4a8czJtgaXVFQBde4bBL73KQt8PxemKOi4DDGOCWR3qJajpmkCxyGCsfqTr7FihBU98UTT0pkwGreYq68MTsoS7kWfXS6PQ9/GETQiqJkpNs4LY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mUjNDqJ6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YDd2JzWliFqrWbZfJPu0/NotnK4TNAffHVQLEGs7TDg=;
	t=1769423839; x=1770633439; b=mUjNDqJ6ojFm7+8af88ei3dRDwmfrUdzKV3GdKi5u8poo81
	hcNjr9K7jF3GK8x7MMyQLclvrdMHSddNw9H7DISYlufKqIqPguHD4NTR5nlIRnRNO/8HVHmUY3PbK
	i5+MnnZtcfpdWQGS7oRU+i40QWOzP3wChRBSsxRM4lfkz9T4pswo+vnvRjZY2l+FURWMMzCuSNSxr
	IyZWyJu2sXK37EfGTsFBElExknVyIsAnzEc2oKrF7el9BDC1V8vLlg7lzV+Paol7iycNN7jETSgue
	JmxTPrLHfbZjPVDnSOjUZdpLjaGvKismDSDhK+qIs6zI7xbHWpQZBlaHWG7/oNGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vkJy7-0000000473k-1vfK;
	Mon, 26 Jan 2026 11:37:15 +0100
Message-ID: <2a4013ab012305907d69beaf9250f762a04ed844.camel@sipsolutions.net>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Escande <nico.escande@gmail.com>, Pablo MARTIN-GOMEZ
	 <pmartin-gomez@freebox.fr>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 26 Jan 2026 11:36:17 +0100
In-Reply-To: <DFYFUQNL5YRY.24VJC5QJMQFVF@gmail.com> (sfid-20260126_111133_479894_9D5E7AD9)
References: <20260123144224.2216923-1-nico.escande@gmail.com>
	 <d26ee979-b5d5-4f50-b423-f8783122f603@freebox.fr>
	 <bfed10db742d29f0609acb04d3354695f87b24e2.camel@sipsolutions.net>
	 <b0e79f6c-36d7-4e49-9d43-8e305a598201@freebox.fr>
	 <26bfd810c1dabc9ed86d4ba68cd20f6434c1d3a2.camel@sipsolutions.net>
	 <DFYFUQNL5YRY.24VJC5QJMQFVF@gmail.com>
	 (sfid-20260126_111133_479894_9D5E7AD9)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31173-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,freebox.fr,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6650687219
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 11:11 +0100, Nicolas Escande wrote:
> > Ah, you're asking why mac80211 doesn't clear those bits ... I guess it
> > just doesn't matter. If you're not on 320 MHz I'd guess the bits are
> > never checked, so it's not really relevant at all, although then could
> > argue that you only need the first line here as well.
>=20
> I you want Johannes, I can post a patch that also clears those bits in ma=
c80211
>=20

I don't think it really matters much, though I think in some older cases
we might be clearing more related bits.

johannes

