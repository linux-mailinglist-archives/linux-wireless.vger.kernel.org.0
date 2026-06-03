Return-Path: <linux-wireless+bounces-37345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yaMALngZIGoWvwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:09:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BE63755E
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:09:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=r8mDbHEv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37345-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37345-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6364B3035C2A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6C3D7D77;
	Wed,  3 Jun 2026 11:57:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745593806DB
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 11:57:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487871; cv=none; b=pcPYjdyl93VzOaFcYJhzuMKBQBv877MauG7lIDFtxpRIG7srT08Ft4rUqhq8Lrt4O9qSDC7QZooU9IeTpjOIRCHSCBIQ9gD2nhEZWj4kp4KPL7E2WrUlwwsMIHwIzPI6v0VlxtF+LCJLd7sl9gDJSpT6fd4ZfFiq5WYSMlgFUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487871; c=relaxed/simple;
	bh=Ob1TskLdOOz1tdbeYY2JHoGWTW726ZQc+15KXxkRD9c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Il6rDKj3b6EbgwDS6k1WQBI5sPdBpHIjazH4pEtPF3Obqq8u/kceRGRnBVFVgSZlhn/gL9PajB5qs0XUy4iu56DHJFr1ylXXMj8+IsStHq3/fPWIKfy7q35796koCfgwKtf3c4534cuUfvo8/Kswapph1FzBP78qNdvWVpOoWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r8mDbHEv; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y7hud1xk5leMLSvrYKwipBZ+7MyCWPZ5IDaXFcVKiRg=;
	t=1780487870; x=1781697470; b=r8mDbHEv55nLgRwcZhT6InzLHKPkaafEPCvFiim4PUXNupa
	BBeBEN9vATMVM1l1onXosBK9Eji4mbnAP7o3t7mlkIzd/ohD2gUPwQQ2bNgygyqkgLtQHskcIWH0n
	JK/7oibOZ+sNhJZcnK/R/Tnd00HykITa5OH6oSsZu6g40AUhjm0yG39qo4Q4F/zUCSZj6AAqBG+Zm
	RDfsu5zYYLDG8vpYYofajjwvYU2S9zKx0RBg9DpBWCxWVqJJ7ntFSgQgRkPst/E+UWGs9ehH+qWWC
	ZYwEFBwq9sl0QjKV1SMJQvQkquA6wisSGTr2fKvJ/OMazup/ig00dcJ+atGJuewA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUkEE-0000000H69Q-260R;
	Wed, 03 Jun 2026 13:57:46 +0200
Message-ID: <d52d32d4301d06084a0bbeb36811913e3c89f40d.camel@sipsolutions.net>
Subject: Re: pull-request: wifi: iwlwifi-next - 2026-05-31
From: Johannes Berg <johannes@sipsolutions.net>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
 linux-wireless <linux-wireless@vger.kernel.org>
Date: Wed, 03 Jun 2026 13:57:45 +0200
In-Reply-To: <DS0PR11MB78809C3AE2C2F3348D39581AA3142@DS0PR11MB7880.namprd11.prod.outlook.com>
References: 
	<DS0PR11MB78809C3AE2C2F3348D39581AA3142@DS0PR11MB7880.namprd11.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37345-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A33BE63755E

On Sun, 2026-05-31 at 14:27 +0000, Korenblit, Miriam Rachel wrote:
> The following changes since commit 6f5dc19f46f4bd0e104c9a4da2f0a912cdf3bd=
86:
>=20
>   Merge tag 'ath-next-20260526' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/ath/ath (2026-05-28 10:23:15 +0200)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.gi=
t/ tags/iwlwifi-next-2026-05-31
>=20
> for you to fetch changes up to 933c7e591e4112dc3d664374c6a62d7153df1d16:
>=20
>   wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 106 (2026-05-3=
1 17:22:55 +0300)
>=20
> ----------------------------------------------------------------
> wifi: iwlwifi-next - 2026-05-31
>=20
> This contains features, cleanups and fixes.

I don't think that between the ~26 patches there's absolutely nothing
worth mentioning. Please resend with some explanations.

johannes

