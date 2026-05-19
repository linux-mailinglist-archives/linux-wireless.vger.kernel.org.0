Return-Path: <linux-wireless+bounces-36654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJVkKj0rDGq0XwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 11:19:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC857B1A9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12A73290E64
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613713E1232;
	Tue, 19 May 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMm8iQRD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5023A1A58
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181196; cv=none; b=V0Em3jFK1rCudm1zgZ6+9YgLDQzckdtfjdKJLnVFa+o8wfPFD/iNIyUyEjgJz9K71yl6nBqkJ5Jyj6PedrZHvqeoW471FC29rr961XHwdgRjssPC+uloBbtLPBKePr43qUbFxxnjfsET3VZaL8uoW8AcAw2DOUdQ1XzfDOdoZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181196; c=relaxed/simple;
	bh=5tZw93ICj25PnnYmvR4YeRspHxfndEVNyr3lMAYxh/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5/2lr5EYZlKrpj+i30eqIcY5I1FmlnRELSp/J4+zbyMVhCJzTj1ZMcwEdoj2QbreTWH7h9UaR8yGSajcDYj/C6rzCnvrBy2WLkEjKLck/M5IULxA6/Yr+becap1PbQSMNWx4Q2/vtaMDXHH4DayhxBUx2FVEF65SHiufjgHBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMm8iQRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE37C2BCF6
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181195;
	bh=5tZw93ICj25PnnYmvR4YeRspHxfndEVNyr3lMAYxh/k=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AMm8iQRDn1b3QQ/hPLNQ/UGIGvCF0ErlJ4dzN3aD+lQ+H3aYvv8VYt9COVVqG/G98
	 vJApltRLq4ojf0eTH0EIcXKeuThuF1XiLTcw2/iD4ApcWBzHJYP2F9ycZCpAQT/Cag
	 JY/mh7rmRlzGgU1n+ufTPaUdNImn+Wych5F+wG2onLLL83S7RwSS2vqn9unHuRzMMB
	 aoWefXET+Wg6bK6eVgaOWUpzDM3vTSny9TS468TpdLtNl0OFjsRUKSeI9yp1z4SzBL
	 ijAsssXQIfu4i8wMW+LxTTbQN4a8N4Xld/b73tSPhF0SBvSMocfyJIhBGYCEOT4PB8
	 BFkr6iMziFYNA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-395317d8852so29326801fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:59:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JkUoEuWwhdkKUovuBqo8YhGhqx6beQFEeOUz7LpdJ+kzgJ2scNgmiq9OqhtwFI8Ko58s2aVeo0HFolbEQOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR+grinRypSuTaHMezYLMvlWTEKa2o3SK17/8+dErzrJQP6fv
	hEh6GyDKY7uiM1bn+DPqmtp+QhUf8IddEU1SYZmCIoTlh1Dk8YlYJ7EBvyDJ1/IHfYInK5Z6ziz
	aaxPwSjQ3iAuB3VjzHE0e337ZeUuFGII=
X-Received: by 2002:a05:651c:440d:20b0:394:2c5d:8514 with SMTP id
 38308e7fff4ca-39561cc2043mr42013771fa.12.1779181194283; Tue, 19 May 2026
 01:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1886262646.6291779.1777997531793.ref@mail.yahoo.com>
 <1886262646.6291779.1777997531793@mail.yahoo.com> <dc91809a60874f87a5e9d67f0c4696e5@badraproject.com>
 <CAGb2v66mCBP8KiMF3nRTix_zYDhsb_o4KNj-7-enB0+ULvh0_A@mail.gmail.com> <21a4cc48403b338311ea0ff76d757893b1f765cd.camel@sipsolutions.net>
In-Reply-To: <21a4cc48403b338311ea0ff76d757893b1f765cd.camel@sipsolutions.net>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 19 May 2026 16:59:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v6624U99E6AG1Yi5JrEpP4P9V8TmorJ4=GNK-R4Mxo9upA@mail.gmail.com>
X-Gm-Features: AVHnY4L_q8NPWKnpISJpvljFh593OtSjwPgq2P5kIDA2-ifC0GTqRV7V5dhNao0
Message-ID: <CAGb2v6624U99E6AG1Yi5JrEpP4P9V8TmorJ4=GNK-R4Mxo9upA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: add regulatory rules for Iraq (IQ)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mohammed.Al-Obaidi@badraproject.com, wireless-regdb@lists.infradead.org, 
	linux-wireless@vger.kernel.org, mnewiraq2000@gmail.com, mnew_iraq@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36654-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[badraproject.com,lists.infradead.org,vger.kernel.org,gmail.com,yahoo.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sipsolutions.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Queue-Id: 29EC857B1A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 4:55=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> Hi,
>
> > As for 10 MHz, I don't think it is supported, so we don't really consid=
er
> > that case. I could be wrong though.
> >
> > Johannes, could you shed some light on 10 MHz channel width support?
>
> It's ... complicated?
>
> We support a _very_ limited set of 5/10 MHz operation, but I think most
> of it is fairly much unreachable from userspace. I asked about removing
> it entirely a few years ago, and some people were opposed, but said
> people also haven't actually helped take care of it or anything ... I
> was just tempted again a little while back to remove it due to the rates
> issues.
>
> Ever since my commit 5add321c329b ("wifi: cfg80211: remove scan_width
> support") I believe it has been unreachable on the *client* side, but
> given that we still have some support in _nl80211_parse_chandef() and
> chandef functions, I expect that it would be possible to still configure
> an AP or monitor interface with 5/10 MHz, though only with drivers that
> have WIPHY_FLAG_SUPPORTS_5_10_MHZ, i.e. ath5k, ath9k and hwsim. I
> wouldn't mind removing it all though.
>
>
> Is this a concern from a regulatory POV right now, due to say power
> density by channel width? This feels somewhat familiar even with higher
> channel widths - maybe it's time to add such an attribute to the regdb?

There are some regulations that say X dBm for 10 MHz or X*2 dBm for 20 MHz.
I've mostly been ignoring 10 MHz since that doesn't seem to be a thing
in modern WiFi. This is slightly different from the newer PSD rules we
are seeing with 6 GHz, since it only gives two points instead of an
actual density value.


ChenYu

