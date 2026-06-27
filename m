Return-Path: <linux-wireless+bounces-38200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DHOABBO4P2p5XgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 13:46:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD26D1D96
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 13:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=eHtlArgH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38200-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38200-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54420300735B
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972813ACA7E;
	Sat, 27 Jun 2026 11:46:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563313A75BB;
	Sat, 27 Jun 2026 11:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782560760; cv=none; b=iBEUwg0cdmAMsFj59Xqsv9CjnW/RiPY/ZIb9DeOa3NqODRMsTJq/bnPnMlsX0vzpqyQlIwQ8+sjPGRVZ2RQpc+lzeNCkHx+BzchVH1bVmJrdmQyGKNWNdfGa7BfPAzJc/xMb+TnGmTTzXdzsb9skibR7JS6FTE4f5vH6nfA4zVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782560760; c=relaxed/simple;
	bh=UazYg031LuaG5dzOwh37O2G3JKjxmmnpm0lnLqN4mTE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WaCl0fdLp/yZxubk8hQEDSBP8Jmsf3A1U/XPJoJ1gkaumFaeEIsUy3rmKjAC0y1piXQPDF7YHdqPkOkvAl+T0XYJi3nVZI34lOvrNcceY2VQwxsWowAYl90uv2KIOd38oAVU3E7yBqjO2ZC8hcZ3ab11YrOaTlSWrRJwY6bPY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eHtlArgH; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782560753; x=1783165553; i=markus.elfring@web.de;
	bh=3K3S7tl+97OqsjxXwV6LyYubY1M8CDonpPb5IHf7MhA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eHtlArgHtmfcVQwsCGT6N7GznBoM6FU2j4G2bYuu6Bx6lJ4nC4T0OL9B4W3VtcYP
	 k4QsjvkcIDSzPZeeXDSvLIZczq769uWinky8iXc4i/FX1Qy4+H+tzqhRXaMWLBN1R
	 5vbk2DE0LDm9Pab3jQ/JXA3lPmMTEX/W3mESH0yUpmNGNQuRxlFLDKbUsyZZkv7Te
	 tHSA2hxq1LPI05EomoHK78osi1pTbn9lInAZP/H/MpdDnC+6DptPu2eU28Ibg8z2W
	 lxuNQGjkoY8osNuJCvnEmBE+pfuOByPF+TSVoEOjGJG/1ARuHomCxH4PDek25FqUQ
	 NU52pshmxYnjHEtiHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLijs-1wv6rA3uhE-00PICS; Sat, 27
 Jun 2026 13:45:52 +0200
Message-ID: <147239f2-452a-4100-8341-dc5dd77448eb@web.de>
Date: Sat, 27 Jun 2026 13:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiao Wu <xiaowu.417@qq.com>, linux-wireless@vger.kernel.org,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Johannes Berg <johannes@sipsolutions.net>,
 "John W. Linville" <linville@tuxdriver.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <tencent_D39C654EBCC3C95DC8C48841701D8D5D2808@qq.com>
Subject: Re: [PATCH] wifi: cfg80211: Fix an error handling path in
 cfg80211_wext_siwscan()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_D39C654EBCC3C95DC8C48841701D8D5D2808@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xEFJ2PVgCHGmPFMYwB5TrsQE8zac9dLaqk+yCdVAExEUjD+eF+m
 r+iSxFRi490YxNOss23O4Z1KioVEHHrMTPsujaEtka1HFALpSPNd1dxGKFcG3Nj4u4RUR8I
 9d/2LLwzwBDBDFG/cWqfVhFhQRZfnL0aMICuT4cQjmbjB0bS/OiLS0Gz7+PJJZUaYvRUitS
 stuQWI+ECSrO6ESLX6b6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xn71pgFovCI=;aUMnStkykFekYbeT84MhzQictW+
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:linux-wireless@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:johannes@sipsolutions.net,m:linville@tuxdriver.com,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38200-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,wanadoo.fr,sipsolutions.net,tuxdriver.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EAD26D1D96

=E2=80=A6
> The PoC uses pthread barrier synchronization to force both paths through
> the lockless check simultaneously.  It runs on wlan0 created by
> mac80211_hwsim (modprobe mac80211_hwsim radios=3D2).
>=20
> Full PoC (compile with:  gcc -Wall -o poc poc.c -lpthread):

Thanks for your test approach.


=E2=80=A6
>      pthread_barrier_init(&barrier_go, NULL, 2);
>      pthread_create(&nt, NULL, nl_thread, NULL);
=E2=80=A6

Can there be a need to improve error detection and corresponding exception=
 handling?
https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standa=
rd/rules/posix-pos/pos54-c

Regards,
Markus

