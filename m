Return-Path: <linux-wireless+bounces-38488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id klUKCxsdRmrQKAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:11:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC516F4A04
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:11:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="Rn/cub4a";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38488-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38488-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81508302E73E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020E3D4101;
	Thu,  2 Jul 2026 08:06:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABC40B6DF
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 08:06:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979583; cv=none; b=h+rLKRHDwdMSzwJWr2k+KdDRCPYSLdBuF5bjqtP59v88pBChx0NHjp8VA51sqPM8NBvzqDfHwqq8TdAF7gyZMgnXuRrKb6F7gUAJfLFk2bAzJgnFQ9hqMtHkbxNb3XQSBDW0k/M5H4vUcLyAvpjUBGJ5fexn8AM0wZeiS2Sq6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979583; c=relaxed/simple;
	bh=PjNkcrwcTkFtObt4+/Wn2/q6bYQtdEPYlbSbKbXxBxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzmiqd/TuOg9vb6/9NyVp7+3DZGte0PrFJYrWdHQRktuQ5h9r3++TzFHRXw60LKoz0iBr1JiwiyONGCJ/cRv89KbF1SfikS7PtLweKCfXXcp7vgKHYFSqHg20SgDe+JBkQR7eig2l9osu9azCGK7qH4hmXJwgys6v3pe9wJCvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rn/cub4a; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PjNkcrwcTkFtObt4+/Wn2/q6bYQtdEPYlbSbKbXxBxo=;
	t=1782979578; x=1784189178; b=Rn/cub4aR15+YWABVo3VwbqBJ4kabMTEOdBm9HqwlhA4PTw
	ZuaEEfXrvJP1iUfH8epenpywsnfRYfBDxEfCjhyZE+4GwL/0qTniQJfzLFC6qj9i93toNtoBxynBx
	K3PXcqEQt4zgjgu0jkmo7aD1K9metH8j71MekcfaSuwGS+2kRWdZOenoX/BkZtcXPgiESigGtY17F
	K6gryMHWcK7CYsab3kl/L08Ez7LlCoSCw0kZmfg3eklx3BlmTdAeKcWxsN9UeDXplg8lvOuhgIfed
	WFIddMNUwoKNlS75ZDjXiaAVX+DGH3RvlgV6bzW3zhXdrN//BDWLaAC84Sag/k/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wfCQr-00000008pFI-1yWp;
	Thu, 02 Jul 2026 10:06:01 +0200
Message-ID: <0723f2f3ddb22ce4b9a1c2d075126c8987031a6a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7996: remove beacon_int_min_gcd from
 ADHOC interface combinations
From: Johannes Berg <johannes@sipsolutions.net>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, nbd@nbd.name, 
	lorenzo@kernel.org
Cc: ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	linux-wireless@vger.kernel.org
Date: Thu, 02 Jul 2026 10:06:00 +0200
In-Reply-To: <20260702071647.667539-1-jtornosm@redhat.com>
References: <20260702071647.667539-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38488-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBC516F4A04

On Thu, 2026-07-02 at 09:16 +0200, Jose Ignacio Tornos Martinez wrote:
> This violates a cfg80211 rule from commit 56271da29c52
> ("cfg80211: simplify netlink socket owner interface deletion") that

What?

johannes

