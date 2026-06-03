Return-Path: <linux-wireless+bounces-37329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ME9MR7aH2qErAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:39:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41F6354CC
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:39:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=lSW5EsE8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37329-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37329-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5780B30607E2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7D38AC88;
	Wed,  3 Jun 2026 07:36:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C233264D8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 07:36:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472209; cv=none; b=IluxaqctMeDFMz4dUykSpQBnHUNOh0COl90ZQal+xU6YsKTFqz674IKg5Csm53lpXTUoL+UbPx2ZNlr+LUfNI3l1U3jN+ShtFlsXxVsHH2M7MHcLkJoM6GlcE7+RzaNqshmpIbDF9hjiyNmgKVF24LU9/87D2Cx/oUiQvwxlosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472209; c=relaxed/simple;
	bh=d5SttnKcjxO3u1x92Al6rAlnHGpPKWq5a0Nn76f0k3o=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=B53fb+QNsvT8NHNBo+Xi/Ud/Iu3Sxng6CmCQipPYeY/87csrAkjB+aMY61Yx03RZbe4RYbeBQcCtZr8TL62VnNO2lXHGIZbsiVRITOwPg6kf2iuVSbKcQfbodfrlpjGeQodaWmWTqWU15snPHx1ZRyHVnd0SpklcUFR6sjWweQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lSW5EsE8; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=d5SttnKcjxO3u1x92Al6rAlnHGpPKWq5a0Nn76f0k3o=; t=1780472206; x=1781681806; 
	b=lSW5EsE8JVqqn0SpkS/ZaMLv1d/j+xJYPHYolBLilhMbZyOLJVb4R15jsdwhrerUKW0nn0ODd89
	cYWBXyA60YedDPwAfcSxHeqX1HnpETsovTnZBy8XR7o2GFFDX/r3/Q7U3Kj2Ma9NW7BY3YwHNscbJ
	G8bUF1CKDMJOkrGV7DbXpkz+iohHxH3FLxGXhkim4WtqYYc/kIBEdTcXQLkvBJEHnA/1sxEJzBTZj
	XgZLmQ1NUdWqtXpVbEkj87kxdYIt/k3bxNSPAu+BA2tDCP7eXNUNpL6bfJo7F/vsRxQzxCf/ww6p6
	lvZchoZp3GO3Kok3/Q02fGEPzYkPKj3HZNLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUg9W-0000000Gx54-3pWj
	for linux-wireless@vger.kernel.org;
	Wed, 03 Jun 2026 09:36:39 +0200
Message-ID: <49053d2520d891e7bb3bbc69e596ffdb76462cd2.camel@sipsolutions.net>
Subject: =?UTF-8?Q?=E2=9A=A0=EF=B8=8F?= wireless tree rebased
From: Johannes Berg <johannes@sipsolutions.net>
To: Wireless <linux-wireless@vger.kernel.org>
Date: Wed, 03 Jun 2026 09:36:38 +0200
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37329-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C41F6354CC

To drop a commit that didn't have proper S-o-b, I just rebased the
wireless tree.

Sorry for the mess.

johannes

