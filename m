Return-Path: <linux-wireless+bounces-32118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCrfOodvnGmcGAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 16:17:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264921789E7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 278F630299C0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD827B340;
	Mon, 23 Feb 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Ga0sug7O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41400272813
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859842; cv=none; b=d3jfRNKlJcEYMG1ry8KVHK6KZsW75q7bUoqlsx5CMYBu/urj5dm7lTWcGQYgqByY4lPedGpTP9+veMPnZL0ZWOCPOSdiVw80WCyHjdDz9kKe/EtGCX9fLcgt2Z9NFFAantoiAkfmYVp452uESgDiij3EOGEK+atLTEvrbk34ycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859842; c=relaxed/simple;
	bh=WxKan2GM8N8SMgAHvV3grY2N6ud+QVQiHZ0M0NaMtWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhQ5wYwUsMObAlNjRRl1WHAQzYp3wZHAE4D2aTMaVhVyoU3bpPnAYqMXFdxyTdHNtat4RANznblVpjqHD6tXzxPJDybNYPbzB1eHVq4aiULO0YrnXXQkKd/dnFRW2Y9qJl9HMX/G2W/5cHFtY8dbLR/7zPQK7CfTbUdvWJjkxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Ga0sug7O; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1771859837; bh=WxKan2GM8N8SMgAHvV3grY2N6ud+QVQiHZ0M0NaMtWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ga0sug7O48UJWO9TdyDy/3ggxtrmFBesR0+mdwMMVjBKzieJyXo8vItTvzNShkEoI
	 p4lSRktAi/kx1EFjxTX8vDB9alwK21sHhuveLdhOEgoUxRwYtW/ErZS48Ej4SGiHYm
	 hV03+Jhxuuswt+ymaO+VlntOnN6frnBnbJxk4DfUsz68amPg2jj+lp64FFNk4bTQ2k
	 1512CgEaEvMRcAfB3IVGF+7oMogsI89Mt8pSbvogTTCMfINIt+jOpDGQ1E2BgOkzgB
	 zngaSxX+hEaF+9x1YvXJs1zmv4KXoO2xNKND3VPoAImMMyOzyJlZi9fvghGqi3+Saa
	 Hsvn4QcXT6biw==
To: Alejandro Colomar <alx@kernel.org>, linux-wireless@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Rajkumar Manoharan
 <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
In-Reply-To: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
Date: Mon, 23 Feb 2026 16:17:20 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pibo5fj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.25 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[toke.dk,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[toke.dk:s=20161023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32118-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[toke.dk:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:dkim,toke.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,tuxdriver.com:email]
X-Rspamd-Queue-Id: 264921789E7
X-Rspamd-Action: no action

Alejandro Colomar <alx@kernel.org> writes:

> This only worked by chance, because all callers of this macro used the
> same identifiers that were expected by the macro.
>
> 	$ grep -rn ath_for_each_chanctx
> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx=
) {
> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, c=
tx) {
> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, c=
tx) {
> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, c=
tx) {
> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx=
) {
> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(=
_sc, _ctx)                               \
>
> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating chan=
nel context")
> Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>
> Cc: John W. Linville <linville@tuxdriver.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

Yeah, looks reasonable - thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

