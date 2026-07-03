Return-Path: <linux-wireless+bounces-38567-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAB6La1iR2ojXgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38567-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:20:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F154B6FF7DD
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=BCxQwAud;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38567-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38567-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900C83011592
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628EE33ADAF;
	Fri,  3 Jul 2026 07:15:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D701340286;
	Fri,  3 Jul 2026 07:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062958; cv=none; b=ObodzivKuxAEwU1fSVmeDnAnbkVHJ2Ero/taWGWf35a+YLgDt364liOyHoRZ17osvMd0qIAhTBtK1kZZaE5qW41GWsX2CyrXvl2YjTpvX8AWeLfy4dhqvEJARQ2EwusqtzPH//E0F3Eq7nbZBj+bhjZpmH1YfSIgzoPE5i8K8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062958; c=relaxed/simple;
	bh=sZgjixs2xPeB7/AN+Da5erhmySpfmwoTCQk6Plg/eCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tH1o21lhJfqX9M5UaFnafvyxvD92GWaWWVA3NK/wrtcpKFsfYX0ntXvwSOVwb1bpgblrZxEZp3CbAKxbSZAEoinBFYHNvdrQ6KUSOD/TXczevBYsKu3PuF4NTrGN9Sd2gYQcbDJ3YNGVVnxvcC/caeVC4aH60Utsr09CTwTL9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BCxQwAud; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NxjMdu5JOVdPnBPpE21xEaCGzEk7c4qDGVEijzuquBs=;
	t=1783062954; x=1784272554; b=BCxQwAud+JjqWhAUmRa6Ri5Z9Fse9AV/sxXQd3QNr9X/bbc
	ywEMkUaVEAikzMvdpaS6FiWQwYg76Ph3h3mt04GJIyQPhSCIq07Ur86gAbQl5CX1BuyBSzdZ3Gr1Z
	pZWxJYGBHCyBXJfkA1Uw0LWDthQCBOBf+kZjOHsu0scWqDC9pvis/JZfijq+7LiZ0FCHwsqSS12Hy
	Zs9dIL7P3B3W68AzFkNeWoIdHVpPiR55sZLzaNwdtmaszMjqr2rY0itSCWkCgtigoeG1msEKhWVSU
	I1QgUPebmtHDtdXgumX28Yiyu9NgMmYYYk71n1BvNGQd4YkBSMfeXZTo/M/udzRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wfY7j-0000000Eo7S-1sB2;
	Fri, 03 Jul 2026 09:15:43 +0200
Message-ID: <251c85cf04f523e6dba6c5e02e252ed6b83a930b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 ath-current] wifi: ath12k: avoid flushing scan
 timeout under the wiphy lock
From: Johannes Berg <johannes@sipsolutions.net>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: Wen Gong <quic_wgong@quicinc.com>, Carl Huang
 <quic_cjhuang@quicinc.com>,  Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>, P Praneesh <quic_ppranees@quicinc.com>, Ramya
 Gnanasekar	 <quic_rgnanase@quicinc.com>, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 03 Jul 2026 09:15:42 +0200
In-Reply-To: <20260703060219.2998148-1-runyu.xiao@seu.edu.cn>
References: <20260703060219.2998148-1-runyu.xiao@seu.edu.cn>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-38567-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:jjohnson@kernel.org,m:quic_wgong@quicinc.com,m:quic_cjhuang@quicinc.com,m:quic_periyasa@quicinc.com,m:quic_ppranees@quicinc.com,m:quic_rgnanase@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F154B6FF7DD

On Fri, 2026-07-03 at 14:02 +0800, Runyu Xiao wrote:
>=20
> @@ -9975,6 +9974,15 @@ void ath12k_mac_op_stop(struct ieee80211_hw *hw, b=
ool suspend)
> =20
>  	lockdep_assert_wiphy(hw->wiphy);
> =20
> +	/*
> +	 * scan.timeout takes the wiphy lock before aborting the scan, so do
> +	 * not wait for it from the locked stop path below.
> +	 */
> +	wiphy_unlock(hw->wiphy);
>=20

No. Don't drop locks in the middle of someone else's (mac80211 here)
process.

If that work requires wiphy mutex anyway, better just convert it to a
wiphy work.

johannes

