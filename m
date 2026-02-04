Return-Path: <linux-wireless+bounces-31522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IQSIp4ng2kxigMAu9opvQ
	(envelope-from <linux-wireless+bounces-31522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:03:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D56E4E01
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52CFF3004D1B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BA3E8C67;
	Wed,  4 Feb 2026 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TyMrRYbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC03C1995
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203032; cv=pass; b=hLt5Czmcq7OTOKWvSlCXr+/BlzCV3IzJpGyd1idpnmw4YKZUaxQIo7GRY6gi0z93nGfuQLiAVPsD9DQpz6PBE8gZ8QPlxsxIhSFBwQMXOlkoXPWA3qEXFrUOUklGs08g+D5YYs7VrTa0LXKw1U8pLbaNPDyXs4UUW7QCg0jp5Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203032; c=relaxed/simple;
	bh=eRy/oPzLmxtsWHG5VjFuzuJPGDKzBtKAALaG1Gvjbvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfMVVG9Hebn+D8ezeOFitkajsFCoIt5mx1h0dmogqAQdZ4BKB/GW84wP6CymfGxCOre4VcxdIiwM6HV159sxWXqJnaysBoptqoyPDpHZRsX6PLZxtdW6FGFcaGCDJ9FyLdfdcKItHr1QyLxXBTpdOYWZ9Ks2Sn64V1IKi7K4Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TyMrRYbE; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso8012034e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 03:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770203030; cv=none;
        d=google.com; s=arc-20240605;
        b=H8fSp8sBz1gk8OgE2sAZsPdrisamZkc6YVYP0YwcihnwjVeoisixVpPCLIzAj7Reyi
         XW0GwXuayf0NQ7R4zl4l8J+EFEd+jqqW/3fFWXGUSUH6vgI5RT7m7OrrYqXYErUGulOL
         US+oRDLYdVp5Y3b6qAKx01cWdumgmaKJD4IuqBEDcnBBKlb8JOzzJRlrEDYUzxS/2Af4
         wmIPjh0JFrJ1wqSrA67Pgoq+id8PC3zFnrsvK5w6Mch+upt7kKR8dS8mgYxVvlGdpdXN
         PlwlZQN+MqlSL4ketUnl2xmdg+f2YRoi3ObQH4dSt88VgQmJI8OcPjK4XDBxhWmZOom3
         ghtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d7rlcvpylhgeQW0hOW9enY2lOptvraHbZscYX/VP6YM=;
        fh=qB46bfT38dLznOEhSJZgEr+4bLce5uZiQqWeD8IaFPo=;
        b=g49sCxR/c/VjVKx8GuZvJTQaGt18cwDDAI9TmdhRgLnmxdRzzmGOz/3vsWjxGq8gNG
         2xK8pAl6IXMIkDS/FQ8dl+6HSVUzEePB6+nY7eKwXeBxIwldXR75Zlx0xjBd+crzyAso
         wcSg8BWFSiOpUxdLuevj1NLbhDSg76Bas0GDm4e9XU6ajecOi31cGI1TMrHg2drcmOFT
         ELaHUNh0xsgScNDadGKNcs6QOVWp33QLtz1gCwYLN/npUlISTmNIXklesveo1gcIfpdz
         2Kb0mdb80r3NHPsgUmBmMKAWFnkpUTUqrbDpcsyeWxmvKM5ukJOfRzK9X8l25U5PDnwc
         DyGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770203030; x=1770807830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7rlcvpylhgeQW0hOW9enY2lOptvraHbZscYX/VP6YM=;
        b=TyMrRYbEcXau6c/G4xdEYwmaWy6yg12fEu+x/0RRuBN8ByQTekVPFbdiG4/5H2soNQ
         /pYVTGO1UG3C3YMNG9mgg+vXf7iyTf+/WOugkuHIchusevpx1fI/XGcPTGb6uIJ2km9U
         PWmQTkTgPnU9o9fX1E1iPnU5vbwdZAdmqIGR04HNUJlyAOzmiklKF6pqLcKn51ZBvMeh
         ri5ygwWV4RrXeet1OCG6XIpFY2nJT6ccpnKEm9IF/enubgnehuNJUarxkjIHJnTjXPin
         4xHDZ4E4d1KOmsQaNXtGht2z/3zq2Mg34hN8qG5ijqZ2BApsz/aDhzjr8cu3EO8t7EYe
         rPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203030; x=1770807830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7rlcvpylhgeQW0hOW9enY2lOptvraHbZscYX/VP6YM=;
        b=c04rHPe4q2+0tI8Sh7NYeyjeUARRfTDYGkXhHvaATYLA1GiOf6ppf0tm21LhtPO+99
         fp5NmyPMnicVe393mGKoZ7lcrq5WaubjHVtlN686uz5L1eD4O8ixkGGBT/FlUm6V2fDE
         Rhfupe+8YcyBbEcO8/rtikb7Xgf4js+VJhMk3mK/RH1Bjy7MDD2PFz8QdZxAPYp72/wI
         fBigGEjJvoCNWHWvvWqrW0nd9vyjfu49R7Sc8pI/KwjeW9998RY2FtatBV9ViESmSloc
         j7WGGjaw73FcTJiKmwcHuxoBn5smxsZIKJ81dcHVULN3EsMTWh3htSHfY4jyiPvTOQ5K
         hGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ067RE3LuTM3hi0br8p4MwjeASCX01c8PsHD50b3pbTjMIME9Stmy99cU6u9doAbrY5tfRVVgmiMFluDZcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywZ+1A7c9feTxLmTgfhwUmEIQ4wVQrkRzyEGnP4ip/+5ls6JPo
	/MzyQm1KATDsE8ez2L7VMB9KnwSqu05ddpXe32OA+jrhRGqdBtNUr4O4Lnz6hBBVYRA2qP/1aGb
	XLZW1YguL7I6L5YJcdt2PN1poGUD+I4MxYloP3t+Zhg==
X-Gm-Gg: AZuq6aLJWKHjp9x4RzV+R2XlkepusNxdXryyvgXexKZVzDbPoEj+T4+zKQB6OCBDKRY
	zgZH4LLIGgKUBpJaVM/zHpQee9Ar8JsVpiVlsPsIcFiXWkH6oqZPZNW9xbyuW9yl8i5bfeThkJV
	zfrFOCnGSl/KQjbeufcq9W6ieVywKUysFROgiJp7agojg3eNJA/r9LLcwxRZmVf+BrSrktSZ/p1
	AIjEE/ukD4odJ6S6PC8kSI3VZqAZYDvftUiUpLTZcEBg9Rk1xMJme/bC9oDv8POlyGP256BRK/s
	NwIYNIjT4iBe4PalxlvKQJM29JIT
X-Received: by 2002:a05:6512:32c8:b0:59b:9f59:c15 with SMTP id
 2adb3069b0e04-59e38c2952dmr906461e87.38.1770203029666; Wed, 04 Feb 2026
 03:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120100850.66192-1-marco.crivellari@suse.com> <CAAofZF7hFFH+pqojfrpgw2L8G9eLXxo1jO4kHxs9mtzbxboAMQ@mail.gmail.com>
In-Reply-To: <CAAofZF7hFFH+pqojfrpgw2L8G9eLXxo1jO4kHxs9mtzbxboAMQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 4 Feb 2026 12:03:38 +0100
X-Gm-Features: AZwV_Qhb4elIgWHOUBqI--cCQn56MaBMKVgLZQTCMJ9cmLasdxOfBeiCO3HA0Lw
Message-ID: <CAAofZF6jhui6T0dLt5OAO9EVySLmxGUpe2UORLi+xMSzK85M8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replace uses of system_wq and system_unbound_wq
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-31522-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: B0D56E4E01
X-Rspamd-Action: no action

On Wed, Dec 24, 2025 at 4:27=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> > Marco Crivellari (3):
> >   wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
> >   wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_w=
q
> >   wifi: iwlwifi: nvm: replace use of system_wq with system_percpu_wq
> >
> >  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
> >  drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
> >  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
> >  3 files changed, 6 insertions(+), 6 deletions(-)
>
> Gentle ping.
>
> Thanks!

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

