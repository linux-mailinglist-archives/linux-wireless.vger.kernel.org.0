Return-Path: <linux-wireless+bounces-33294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBelHpTdt2mcWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:38:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4525298008
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924653009FA4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FD382F39;
	Mon, 16 Mar 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hL2UrIKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EF17D2;
	Mon, 16 Mar 2026 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657489; cv=none; b=uxVJ7ZrZ6/EEZoVP0FaBsF/ak1Y66z0L4lls9NQtSuLzVEI5D016uiRUNWB/lgdxp7LSElNNoaq/JMkqED2/LKWiy1U4AT5xcp9X8dkWOV4X7cDuDRSzF34hgsdarY/KYOD+F6nB1/3jnelLHk/ADoPsv2F+w7ypvcpkTgPwB+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657489; c=relaxed/simple;
	bh=P+WGoX56mYFeB5NHJVqP3DF3oHzkRuS066gqfc2Rusc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvRHMnCEKWrvoLmVsUly+67eLUb+bOtMwMULGJemkXZM2pN+EMdSfDaBzHZiD91WuYPMDO41bJGgZWNR6x6aXCFZUdi2gicJU6pTvCm1G+MHbc3LDAlFeNVRcnFstLR+WIk6jD/OZU1NTSjg8IyxSWXOdSmNBgZ68YJ4OQhf8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hL2UrIKW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n7VM6NNCGH0TvPrUW5qoHi31o78h40B/CYvexp2TK04=;
	t=1773657488; x=1774867088; b=hL2UrIKWZEKX2s0WnrwY7/zGCdQwykFieHx8SvX/gG6RNsG
	7Jw32EaZy3fkd5QmzgG8Mz+fos6xR4fTNE7OcfzbEZbD/K5qeatlM3uBZcVBGyrZpOtF7N4dh6zHB
	/0pYfqm2mQAL88eu1TK/aso6Oj0RT9D+1MJ8TlbDwRuShnIDWCLUBn77r0pSkX39DQQRN0onkU7sb
	T7PK/7Xk7S+0TtZBWpAdfA4ogkj5Xwodj4loQIoKyRJOHdI3Vm4OMTD6s3W1xf46To9mb3nVQDRc/
	Sds9b0UtN2vdoAy0Op1nQVLdFztogeWnDga2+LfNOD8MEzhc9hGhVdMoJCyUTb5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w25Ko-000000028z5-09oc;
	Mon, 16 Mar 2026 11:38:06 +0100
Message-ID: <71acefb76084d5a82f9ce4536e270942cffc64e3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real
 chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, oscar.alfonso.diaz@gmail.com
Date: Mon, 16 Mar 2026 11:38:05 +0100
In-Reply-To: <20260309104559.22252-1-fjhhz1997@gmail.com> (sfid-20260309_114615_459820_69893C51)
References: <20260309104559.22252-1-fjhhz1997@gmail.com>
	 (sfid-20260309_114615_459820_69893C51)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33294-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4525298008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-09 at 10:45 +0000, =E5=82=85=E7=BB=A7=E6=99=97 wrote:
>=20
> I see the key difference between our approaches: your v2 iterates
> the chanctx_list and only proceeds when there is exactly one entry
> (going to fail_rcu if more than one exists), while mine blindly takes
> the first entry via list_first_entry_or_null(). Your approach is
> clearly safer -- in a multi-chanctx scenario, there is no way to know
> which channel the user intends to inject on, so refusing is the
> correct behaviour.

Oh, right, I hadn't even realised that at first.

> I have tested my patch on an MT7921AU (mt76, USB) adapter across
> v6.13, v6.19, and v7.0-rc2 with managed + monitor coexistence, and
> have not observed any crashes. However, my testing was limited to a
> single-chanctx scenario (one managed interface + one monitor
> interface), so it does not rule out crashes in multi-chanctx
> configurations.

Maybe =C3=93scar can comment on which device/version he tested and got the
crash with? I just would like to avoid having crashes because of this,
but generally think that - perhaps optionally - we could have code like
this, since people _do_ want injection to work.

> Could you share some details about the crashes that were reported
> with your v2? For example, which devices/drivers were affected and
> what the crash signature looked like? That would help me understand
> whether the issue was specific to multi-chanctx usage or something
> more fundamental with accessing the chanctx_list in this code path.

No, it was specific to some driver implementation, but I don't have any
more information now.

> If you agree, I would like to send a v2 that combines both approaches:
> use list_first_entry_or_null() for simplicity, but add a
> list_is_singular() guard so we only proceed when there is exactly one
> chanctx -- matching the safety constraint from your v2:
>=20
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2399,10 +2399,24 @@
> -	if (chanctx_conf)
> +	if (chanctx_conf) {
>  		chandef =3D &chanctx_conf->def;
> -	else if (local->emulate_chanctx)
> +	} else if (local->emulate_chanctx) {
>  		chandef =3D &local->hw.conf.chandef;
> -	else
> -		goto fail_rcu;
> +	} else {
> +		struct ieee80211_chanctx *ctx;
> +
> +		ctx =3D list_first_entry_or_null(&local->chanctx_list,
> +					       struct ieee80211_chanctx,
> +					       list);
> +		if (ctx && list_is_singular(&local->chanctx_list))
> +			chandef =3D &ctx->conf.def;
> +		else
> +			goto fail_rcu;
> +	}
>=20
> This avoids the ambiguity of picking an arbitrary chanctx in
> multi-chanctx scenarios while still fixing the common single-chanctx
> case (e.g. one managed + one monitor interface).

Seems reasonable, I think we could even drop the "if (emulate) part
(since in that case the list should always be singular). Just like I
said above - would like to understand the issue that had appeared with
it.

johannes

