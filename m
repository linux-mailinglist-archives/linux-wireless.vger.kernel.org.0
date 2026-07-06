Return-Path: <linux-wireless+bounces-38698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TIKDEPXKS2pqaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:34:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FC3712A4D
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=JhYf8Kff;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38698-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38698-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B8030BF0E6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED83A2540;
	Mon,  6 Jul 2026 14:54:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0F3FCB00
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 14:54:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349696; cv=none; b=XJVmPY2JgpyxDkxKHNkJrmd5fYALaBJIXYEbWYCbJdXdb1DeO+Oy2X4qxn0A1pCKrfFV3gA3fLgxaYj3xK1T/09aCCYxi908OT13UKydozchZTiz33+qMoXOpBnUrHz3IMM01X/qRDtLeQRf4BZs1QMi9ZmELwnZ7zhnKYGkfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349696; c=relaxed/simple;
	bh=Kksx9x3KD/QqVq9g+mgo2v0oF2B9zffbFhWAvCAV2Jg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=CS2w+9u94uSXFwjyI033+/HwyKdFRhVqBL2dF2tWGrL6ddhVZU9of1NNPNSbD7+XxeQFWV6MJIQaAAMtHKdoDnOT0iGYDsfD3GzHofnVSysIBKFiafqiXcw/1Ty4mMHC5OvK8dxdQdwmOu6HxzTlmOJWo+yLFaERtejDHgzU7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JhYf8Kff; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Kksx9x3KD/QqVq9g+mgo2v0oF2B9zffbFhWAvCAV2Jg=; t=1783349695; x=1784559295; 
	b=JhYf8KffoofAo1zVqxVNdyXmFtBBw12ya6lf1dkkmyhE5eU7wdFKJOVqsxRvfYYAfjUuinaRDYz
	A1LDvHENgod1K7Muy5HgbgeBoJYKOwH2/zlP+SPlsyDIsyvL5Oyh5Z5dj6Sa78Zo7Ri6DQH94rI8d
	ewFUJuahcGWNnEGxNyT5UBdu1hVDHjDzL8ozX3EFjpZi7J0a+4K9bmyCiyz2tFQw5Rnwbi/l5sCd2
	KYhah+BclFNFf89l4HTJGG+wmRDE/PLmYb3tTD8Ab2ZBilW/oBtjXF2z2btpciaA2soDM8oxlFYnp
	E+ibZYzNhzh2yHdLzzZBv6oGepRDa9wg4+dg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgkih-0000000DUli-3vSZ
	for linux-wireless@vger.kernel.org;
	Mon, 06 Jul 2026 16:54:52 +0200
Message-ID: <cfb943ff3d7bd273d0f46293177824a7f839636b.camel@sipsolutions.net>
Subject: FYI: wireless & wireless-next rebased
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Mon, 06 Jul 2026 16:54:51 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38698-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3FC3712A4D

As much as I like to avoid it, given the linux-next reports I've rebased
both of the trees. The heads are currently:

wireless: 4a360c6e18df ("wifi: mac80211: validate deauth frame length
before reason access")

wireless-next: f9202a374ec3 ("wifi: cfg80211: support MAC address
filtering in station dump for link stats")

If you have prior versions of those commits, sorry, please rebase as
well.

(neither of the prior versions were live for very long, but I figured
I'd give a heads-up anyway)

johannes

