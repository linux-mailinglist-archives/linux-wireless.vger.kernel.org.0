Return-Path: <linux-wireless+bounces-32748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ParCnBvrmn8EAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:57:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D292348EB
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7498D3044B87
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6B3624A6;
	Mon,  9 Mar 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ADQZbB/9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFB35DA41;
	Mon,  9 Mar 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039190; cv=none; b=S8xlhWmrKS2Q1AJ7MVRScEgz8pABmPbDRxaAbBYlu1VFavS0oOgodXbEk3q0XYKx7ppzrts+ardspPoO5jF/aYFZONszDB0SWYsGNGN8rQpXQYBneFbgraxkJLkxvwLyNngAXmjE0oarKY9eFdHHZct031g/LypPljMsyXyj52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039190; c=relaxed/simple;
	bh=hG4GnsxkzseM2bRinFB1n4eJZFMddV0ip4lYdY7xYCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gY/kF0aBFvPflYFc/RcH0lQqjuvIwmTqV+daLBPteR1zBAYebM0euckYvKxGN0Cyw/chhfvZmdOLipn7j3ZpXG6KSm8Shq1tB1fc+N7AjNmcmSn4majW7PeQOCzjerQiH5PLRVOiYj1OlpVcHCBrhN0DHfQ4ZYsxGH7DjiqGV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ADQZbB/9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hG4GnsxkzseM2bRinFB1n4eJZFMddV0ip4lYdY7xYCU=;
	t=1773039189; x=1774248789; b=ADQZbB/9hFWTk3dmT3OYyKF30uXR8Geg6yCcVTwbYRDAGPV
	rDU2BdgNgmzrSl/TWVxYno1yySdR1BBePi+pCexiF69/MM2fFKgAnUUTrWjUdK7dg7K+7pgFwGHnQ
	K8WlejI9uRvQ4ofpWwQ6fdr/hMIKsTkw4NkZqbJkr9agUKRS6g3LNSEWlqDCsdC0CNiRKuHxhN+Wc
	+xJTdBjnllIVIXBhp+rtNVw0gOMAlsG/Clh2zLRagLlfuxwsMk5hbj1WYx/RoD3Ho0Ai496by8JRa
	k4KdGF2rM24KLkZ9g3vnI1OtAmSFm+O3iaKNDbqhkU4dJpbzS7tARyu8cJislIlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vzUUF-0000000ClUy-1MnZ;
	Mon, 09 Mar 2026 07:53:07 +0100
Message-ID: <8155c8f93c233e430c75c98bcdaea219b16e9596.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real
 chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, =?ISO-8859-1?Q?=D3scar?= Alfonso
 =?ISO-8859-1?Q?D=EDaz?= <oscar.alfonso.diaz@gmail.com>
Date: Mon, 09 Mar 2026 07:53:06 +0100
In-Reply-To: <20260308164510.5927-1-fjhhz1997@gmail.com> (sfid-20260308_174529_643449_E6D8C735)
References: <20260308164510.5927-1-fjhhz1997@gmail.com>
	 (sfid-20260308_174529_643449_E6D8C735)
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
X-Rspamd-Queue-Id: 88D292348EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32748-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Sun, 2026-03-08 at 16:45 +0000, =E5=82=85=E7=BB=A7=E6=99=97 wrote:
> Commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> removed the fallback path in ieee80211_monitor_start_xmit() for when
> the monitor interface has no channel context assigned. This broke frame
> capture and injection for drivers that implement real channel context
> ops (as opposed to the ieee80211_emulate_* helpers), such as the mt76
> family, when a monitor interface runs alongside another interface
> (e.g. managed mode).

It actually broke the others too, as you note later.

> In that scenario the (virtual) monitor sdata does not get a chanctx of
> its own, even though there is an active one from the other interface.
> Before the simplification the code fell back to local->_oper_chandef;
> after it, the code goes straight to fail_rcu and silently drops every
> injected frame.
>=20
> Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
> behaviour") restored the fallback for drivers using emulate_chanctx,
> but explicitly left real chanctx drivers unfixed.
>=20
> Fix this by falling back to the first entry in local->chanctx_list
> when the monitor vif has no chanctx and the driver uses real channel
> contexts. This is analogous to how ieee80211_hw_conf_chan() already
> uses the same pattern.

I did have pretty much the same attempt at a fix:

https://lore.kernel.org/linux-wireless/20251216111909.25076-2-johannes@sips=
olutions.net/

but it was reported to cause crashes on certain devices, so we didn't
think it was very safe at the time.

Is that no longer an issue?

johannes

