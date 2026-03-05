Return-Path: <linux-wireless+bounces-32573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKDKCHrcqWm4GgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 20:41:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F026217A99
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 20:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C0A30173BE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577A2F5A36;
	Thu,  5 Mar 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1QsnlU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EE3D5232
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739681; cv=pass; b=niX9Z1Gz8KJ7VAz427mJR4MG9GlnY56u4k0kXy6HerCYSjvtcKiFzpZMntXoW9hURl5+AjuSWAwuhNgo3fRNPQJXiQgPoGCBgBAEoFs+RNwCXcIr9tbcsf4e0mcbZ4CPD6tjAwU7718v7Zh9UrzCtxLXSBUduDzUPJ7BYfRZIJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739681; c=relaxed/simple;
	bh=lox259fTu7QOFu4MjsK4i2V8GXG4Bsnk52hGfxSithU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbE5LLLCF/v4NS5t28NNSb5NRpWW+BLwAbTWSDJEl/Pwn2N4igdxwcpU7QCw+9WY3P59DbITP9Dl8qZePY+xt5FToZM3SsOGs/d3zPP0dN/r+AuV9aMWwsh9WdpcthQlX388F9QQnxFRC3rFZT39EhshyACN/LT6zsoI5pl/CCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1QsnlU+; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2be4781d2baso1035301eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 11:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772739667; cv=none;
        d=google.com; s=arc-20240605;
        b=JiDYVIQ7rFmlWowBy8bTqVJFrv14tll97fDeqOtCZpDaWhqbpbu6ET6e7cmyrZS5P+
         CjaMF7vy3qT51hA2NHzMPsVOYyUzETce9P+IdVJsvh1gQdJo0ZEXOHNjHX9nhum34zpu
         sIYzBZqzzI8wIo1gg/QgMgnCF69w4SAqls1xRg1Em3svPZjBwHWk75xhU8lYqePSGd40
         7zs1K1LPD9Hzw05VMivIqZTOJDlYSpXirX9TQrBXS/zCeeu825VmUVKh206cHsWAjRZ4
         aSMbUYNwksRAAmeKtlx5KIaR/sNVKwURQy+3kUJJWgsYmD30a9xs7dSH/mDzFmYCU+qL
         VZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lox259fTu7QOFu4MjsK4i2V8GXG4Bsnk52hGfxSithU=;
        fh=8yW2R5kEDDVlpS0o0vt3/hxqXeKYdowE5lSBsVdByTY=;
        b=YXowzTZmkob46WBBJ0pM+Epk0mgHnD8GdtQFVzBadVHKipqyzu7KwAvO3dnxjPDfXO
         5M9vEB03U0nFQCu2W6n/dur9Y/B98FY611RfTg45c4FamvEcTbWhR6a24zshU/FyTcYI
         1gCIFs9fTEirtHk2hgDRJoJpql9MyS0TC73JKWRb1MIOSTCjzJeNTm/aN1gWiKNfplKG
         brGNYeOaIiRJZXKhveIj2FdiffRAQtxbcEspjUaVDxqY/F3XhieW1XzzPC0H3GVus2Cn
         +igZpDg9bBFrFcJWmAPNwhuY5JdaZGUTudYSPzUEUa5nK2LH7M0htkAc5CGpVosS6A2T
         TpjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772739667; x=1773344467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lox259fTu7QOFu4MjsK4i2V8GXG4Bsnk52hGfxSithU=;
        b=P1QsnlU+Tk8BirygZNKjOQ/rPodMcV9RgZHHJotJAynvPr6NlW5RI6gy/6Ztm9eyxh
         GM14N9r/B4HLuh5h/8fgrpm2p3qWYpk7sZpj93fGvEAloW35A6oOd5bBYxmqRyHi75VC
         1FdvpopfZICNAeQ6/GVDht6LUmlevSnSD4LPdLsWArp9bYiOV9HK36W2J2Z88Z1QB5PJ
         mouZj7b03RsJDRyixFpVHHdmul1ovue4DPHLN5Eg0A4rCu+Os00xvxphwHS6X0G+BS3F
         1CC16E3yEAmDAB5i3/xEzCRgLAbii6hMFU7+vEU6Hxqv1N+czv06EYs0uTlkX74w2krw
         /AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739667; x=1773344467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lox259fTu7QOFu4MjsK4i2V8GXG4Bsnk52hGfxSithU=;
        b=uuZhKelvSXmyVps/HXPRWeFi1pYQQJhKv193FFg0yOed+S2w8E28D1Urv4aRP4U3ZC
         1+ckMcfMaELZ3pNA76DbMEoyRT2/jCgahOm0Mw0vqrevMYPS4SYxaArFvSpWLHu3IZYq
         GOmxCL7MtX33ASECJb3w6a2As+G/NKXPVNDN8ncToOMOcgyFmmdquB/canFNZ4Drfg3H
         /7PiHuf21HNAoLk88AxmyZdV5OINRyRpuBokOKqKGR+my7CxSU/e6E395N4lJkV8Edue
         a7yXScs221HMuZjQ8owpyt3t6CtLPLqXPlPI+sZuYRX0lC005YRx5KvrihypVT+aBTZv
         DdRg==
X-Forwarded-Encrypted: i=1; AJvYcCVhxHNopE+0efijIBy775piDbL7SZuMr8DSEOKUF9vWrOMmx5Y03RUZL+abi/QgvV/Ofwab40wNAncJsN5rCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfpjTBG+9ti3Tx5WQg2u7OXUrco33BACL68iiguggAydMqVrY
	icTJM55WKp1EKXQ8PFk+4ju5WErPodA0ckOlOeiBMOVN39OxvW6lyni3mk2SR31tTU95aL1u++t
	CH1h6Vd91DV8B0iqS46sAyArvApllY+GLH/bkmfkr
X-Gm-Gg: ATEYQzy1BiTvK30w8kHvILkcAZ/tSxrvMwUjjveekGklT3i63OAZdv2n9sMzBw3X+a8
	CIjR+rHN2A4Yk9v42V2Ap9rC66T8oUPEtD0nHuBfNlynRGDrZLzchxbWlKcRS3QVuRKU/5tMP2k
	DfJ47nwfSRlckFQDolxeTlpxE+vqR92zGiJCQPjC8qadEad2ZDtPfe4Q53D4D26a49lrRhGpbUW
	ZQSnJRJcGCRfBW6w75dF/z9M1qGJRWepfv4CURCxGY1MpXjK6TlteBj0AOaFva0qB5G4UXizIFX
	9U4xbUTffO/6+dk5cldnTiJtrV3U7VFdr7CGvZ2UWpRbgKGpicHAkt/MwSd9F5ffJWUvBjmp
X-Received: by 2002:a05:7022:6b98:b0:119:e56b:957c with SMTP id
 a92af1059eb24-128b70760e5mr2918031c88.1.1772739666080; Thu, 05 Mar 2026
 11:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304204317.1921550-1-kuniyu@google.com> <0d823e5cd52792cae3e42afb6125c5c822554faa.camel@sipsolutions.net>
In-Reply-To: <0d823e5cd52792cae3e42afb6125c5c822554faa.camel@sipsolutions.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 11:40:53 -0800
X-Gm-Features: AaiRm52SdRJ2VKWTur2Ohx5ANF0NEX4G-9lO3RPGKHMJO1yPBUXktz2QWcUa4m4
Message-ID: <CAAVpQUDh29dyayo6Tag6hMJsq8H7cVuKVpP-=qG3a3ZWvodc_w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-wireless@vger.kernel.org, 
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7F026217A99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32573-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 2:20=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Wed, 2026-03-04 at 20:43 +0000, Kuniyuki Iwashima wrote:
> > syzbot reported static_branch_dec() underflow in aql_enable_write().
> >
> > The problem is that aql_enable_write() does not serialise concurrent
> > write()s to the debugfs.
> >
> > aql_enable_write() checks static_key_false(&aql_disable.key) and
> > later calls static_branch_inc() or static_branch_dec(), but the
> > state may change between the two calls.
>
> Fun.
>
> > Let's add a static mutex and move static_key_false() there.
>
> Wouldn't it be simpler to use static_branch_enable()/disable() and never
> even bother checking the previous state?

Exactly, it already have a mutex and we don't need to
track inc/dec counters actually.

Will update v2.

Thanks !

