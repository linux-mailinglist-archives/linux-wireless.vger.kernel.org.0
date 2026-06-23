Return-Path: <linux-wireless+bounces-38005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zu+QNilPOmoW5wcAu9opvQ
	(envelope-from <linux-wireless+bounces-38005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 11:17:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1F6B5B3A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 11:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=sDUek66i;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38005-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38005-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BF43077AD6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF56130CD89;
	Tue, 23 Jun 2026 09:12:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DEE30C37A;
	Tue, 23 Jun 2026 09:12:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205945; cv=none; b=UF9xWxtDp4RmNgeXgUBdvLQtejdUaMjB3n+bIV25XqHtsyNNXYelmoIzA6/fgAeedX1F27ekCNdLIwsWilOUT9cKJKP3+1FYdyexU5a692h8ENbkLRHa19wOms/NUjHLy0xBxd5dNTTQziUQX4J/JuwOwDxA35iiuIfXIVvMAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205945; c=relaxed/simple;
	bh=MHzNp/YphF9W64kDmQouLhBcCenTH++pKXShErOJQ2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c89AQ4u8M7Xid3sG68GPFyNwpLqqSeeJeostHblDd3tYlv07TTqb2BG9QmIgKadZXFlKJZhNWR1bi+0l5aaSIixsr0zQvcrEg/h4MVigSosrf9dIhCwmYKZNilfAUGvfJFeEV/zQWz2P5sWtTH3lhVT0yA73LGiwrnrwDQil7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sDUek66i; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MHzNp/YphF9W64kDmQouLhBcCenTH++pKXShErOJQ2k=;
	t=1782205944; x=1783415544; b=sDUek66iv9AcrmEQQbhdFHoHZCfhLPyTnR8BSxxZFpepsFk
	sItAVPHd+a9yJNUBCJ/H4z++LHxUZx9MK3UQ/BQZ/J9PWPlVENhcQaU6W4gm/E7VkBaLoxScA5W1C
	CvzMImdeNzJ7AFeXou2JY17sh6hO43cMECG5EqhwEiOkKK4qpcosWk8oQ7jiDT/J49VLsAQcpQI4G
	TDZSV+GTqTYIzd3xJZC2ROAEkoJxqYnXMABslcHrMR1BqoOmDgsRKpmMzBjTJ0HFLFwhwsbNAm4uD
	rTFFxGMY9xx63GaS0XSOiWVlojeDl+mLZqqAAniJFGKhjPGRZ7Kk/NSCvOM4POmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wbxB7-0000000ERvU-1OG1;
	Tue, 23 Jun 2026 11:12:21 +0200
Message-ID: <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from
 our own BSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Yingjie Cao <yingjcao@sigvoid.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 23 Jun 2026 11:12:20 +0200
In-Reply-To: <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
	 <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yingjcao@sigvoid.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38005-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38E1F6B5B3A

On Tue, 2026-06-23 at 11:10 +0200, Johannes Berg wrote:
> On Tue, 2026-06-23 at 17:04 +0800, Yingjie Cao wrote:
> > ieee80211_rx_bss_info() acts on a channel switch announcement (CSA)
> > carried in a received beacon or probe response before it verifies that
> > the frame's BSSID matches our own IBSS; it only checks that the SSID
> > matches. ieee80211_rx_mgmt_spectrum_mgmt() acts on a spectrum managemen=
t
> > (channel switch) action frame without checking the BSSID at all.
> >=20
> > Because of this, any station in radio range that knows the IBSS SSID
> > (which is broadcast in cleartext) can inject a beacon or action frame
> > carrying a CSA element that points at an unsupported channel. The switc=
h
> > then fails in ieee80211_ibss_process_chanswitch(), which queues
> > csa_connection_drop_work and tears the whole IBSS down. The members
> > rejoin and the attacker repeats, resulting in a persistent,
> > unauthenticated denial of service. Encrypted IBSS networks are equally
> > affected because beacons are not protected. Since both of these CSA
> > entry points are IBSS-specific, the impact is confined to IBSS (ad-hoc)
> > mode; managed-mode CSA is handled separately in mlme.c and is unaffecte=
d.
>=20
> Once you rewrite this to be more honest, you'll see that the whole Cc
> stable thing and all is fairly much pointless?
>=20
> Or have you not realised yet that stations can also trivially fake their
> MAC address?

Also, since you don't have a track record in wifi, I'll point once again
to https://docs.kernel.org/process/coding-assistants.html

johannes

