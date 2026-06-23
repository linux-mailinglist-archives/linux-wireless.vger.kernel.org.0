Return-Path: <linux-wireless+bounces-38004-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7fe0BRhOOmrR5gcAu9opvQ
	(envelope-from <linux-wireless+bounces-38004-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 11:12:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA116B5A75
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 11:12:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=wvcWqHoZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38004-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38004-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71041309D8A8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543930C366;
	Tue, 23 Jun 2026 09:10:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E62D4B68;
	Tue, 23 Jun 2026 09:10:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205835; cv=none; b=NdmY56PyAoznvM/9vhraX/EJcQXdT3VrV8ASkBpleaI01s0mjAdSGJMUY4NxEmiiebkCLlwt8UHqCprvxPi4LLjPaEUuT7nKg/p+i03LteD7fQZK1h7WdXwVSxSQk1y43xKnWBBkhciGlys27K/F5jDZJEC9Y0xfQYNVYNkuvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205835; c=relaxed/simple;
	bh=nyF+gNW8/nSCzTolTcL2Udbq/hDcUcNUOW1uk87EcHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQx4j4bEP3ZnhZGVVVsVAVMDmnbIEkdnJIaO36VH5bX391F6NhSISQe/hQemGByZknPo/ytirLMsHZIcA7EUcgzjbwhwcvORyIVZP9HBQkgksc0vP8NB8pgjHy348qwWbCygrgu6njXXJ0fa1Z/Zgqym9VEdVOiqGSFNWbZGx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wvcWqHoZ; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nyF+gNW8/nSCzTolTcL2Udbq/hDcUcNUOW1uk87EcHY=;
	t=1782205832; x=1783415432; b=wvcWqHoZDhB04XqEH7qBgWhOqDD400S3TJWpbJkBXFI7Ufr
	8HQ0Wk5rz1YP2HSyyw694jZAuIVUo8RfpKcE1CXuH5zZJVMJWRQFmURz588DyOscX8bkdlKroYdDO
	1f01CEmWo3j9xU00RllUqQfAzlDP1WlvAx0MzDsNzClS1vAF923tPUkOc2U/f4nrtq6Rm/i1ZgBAG
	BKN3ztRZtb37UdZ0eTHcuRcqvRBCzacUFvKKng4OnoJFlg7c5k3quEGxDRCPwAaNvuvp+LEimqIzX
	C3euG8Yrquv9QDGm2MHOoQ3fuOU2IQs85NywnkMUngRVqFPrKZB5yXnwgwiv/4gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wbx9J-0000000ERr1-2bYK;
	Tue, 23 Jun 2026 11:10:29 +0200
Message-ID: <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from
 our own BSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Yingjie Cao <yingjcao@sigvoid.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 23 Jun 2026 11:10:27 +0200
In-Reply-To: <20260623090437.13198-1-yingjcao@sigvoid.com>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yingjcao@sigvoid.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38004-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FA116B5A75

On Tue, 2026-06-23 at 17:04 +0800, Yingjie Cao wrote:
> ieee80211_rx_bss_info() acts on a channel switch announcement (CSA)
> carried in a received beacon or probe response before it verifies that
> the frame's BSSID matches our own IBSS; it only checks that the SSID
> matches. ieee80211_rx_mgmt_spectrum_mgmt() acts on a spectrum management
> (channel switch) action frame without checking the BSSID at all.
>=20
> Because of this, any station in radio range that knows the IBSS SSID
> (which is broadcast in cleartext) can inject a beacon or action frame
> carrying a CSA element that points at an unsupported channel. The switch
> then fails in ieee80211_ibss_process_chanswitch(), which queues
> csa_connection_drop_work and tears the whole IBSS down. The members
> rejoin and the attacker repeats, resulting in a persistent,
> unauthenticated denial of service. Encrypted IBSS networks are equally
> affected because beacons are not protected. Since both of these CSA
> entry points are IBSS-specific, the impact is confined to IBSS (ad-hoc)
> mode; managed-mode CSA is handled separately in mlme.c and is unaffected.

Once you rewrite this to be more honest, you'll see that the whole Cc
stable thing and all is fairly much pointless?

Or have you not realised yet that stations can also trivially fake their
MAC address?

johannes

