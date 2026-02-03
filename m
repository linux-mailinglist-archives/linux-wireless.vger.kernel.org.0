Return-Path: <linux-wireless+bounces-31485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLbWFQ9IgWkZFQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 01:57:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE0D32DE
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 01:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E58300E707
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 00:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E42165EA;
	Tue,  3 Feb 2026 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agj0LUKv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408B1E5B9E
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080231; cv=pass; b=NrJSD02jqrw+oTFEw7WME2dlOPwQ06sLC364bAQ7oxXcI+C3jXcLuNY/UFV6L3nF5QgdEABC2bI9Z2Z2SLedknhTWF8COKE1Q8dBcM6+zaQ3Cs1XqTSkzcKteE06Fgy4w/5smUk9bhZ35gmRqtEFtaaKDVE33irSMaKv7ap2lO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080231; c=relaxed/simple;
	bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaThbG/HCZeXTFG/xqE5+bJFLOWsB5aPNWDA3TBSjSgqxbPYnK4XwGZWBx64i9Bm1adRUSYMaPQOAh/VfJOjUE9aTrgSmt4w70alHHy1I+SwlchelGrqWd6fNRAuJfI2L+hWQSWDfcpy4bydsrQiZkk3EbXE4tP60RY2SwlyxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agj0LUKv; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946e32e534so59428196d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 16:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770080229; cv=none;
        d=google.com; s=arc-20240605;
        b=PGTRt2zc62VrMqBdJiUgKbK6hh8FGMdzogElYctOx1PTZXshpbr1oW1CAnRqQ2fOxy
         x9YhGkQfCpZyPqWg0bmsLtGG0kcHLLHJcDHxng3YUzcH+y1/huTUL1iEtE+SFBnHRhWK
         S1vI1llH6EjvQ1ZfMZx4YLsvdVtinKuoN5q6TdzGDOGs1T/2ytrvp8OYt7fQ/kMhFsha
         sOUWl/7FIF0gDKA6hGSq6XjJUNuX0Rj+jb+UAqTVpCDXJAN7hZPWSa4PEAaT+Mc/VcRY
         u5+ILAlE2TZANTvKi1uk30aRzewQwuoBAQhwvE1uHlA7u6TUAGuFkc3QfTQKKppWBptF
         wR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        fh=yvG+EK9HKfPuoZ66AUGYit+XszP1rUz9C7ul7jjoI/w=;
        b=Rab82KCeC/iB+TKZ9xMoX8+0UmaCo7GZe60MsKCsGmpMv3hWHIUE48p5wR9vHwsoxr
         RtGs2bjzolWAsGW1wGODFr+UZ4LA9IqyL4zb3Z/05zAm8dFw0IMl0kCwDf3U0vggg9F5
         UxvGgBALhp+tz4rke3/JURxvY4hym0ks0+orrHE9YN/G9VH0jpiEN5rtQsL4RUsh9W8x
         FWNULsV1a+kmk9HPPj16s0eR0yhnz8tfAgOjaoDGVremqxOm2QlMVLUXD8um4fL0c478
         j55x4kSngh7ifdTBa10mgeRTR3lrTEoJvW45C6RdtGBs/K0GEUvJQ49NXCUyRuyQCmas
         G+8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770080229; x=1770685029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=agj0LUKvCNI+z9z47/5kTXHAVgRBy4EBnVUo95soHvJsQMsvTgnU4DKES7IJqm3/sw
         7+U4fD1Npb3IgadzPdCy9mM99lWFUp2Z9WiNOLH3Bb5154PEM9VXvwYMKXVxSsZeWSwB
         zUHrTfFRC/Z97GFPkg5VOfb9msE+VA8Tj5g7baY7JbTO14FkSEiNFZrkdT9mDDB5kE2N
         AM6eQsrKif65TcKPq7/YbLfhjzp3IoqE780unlCpSj2kbxrfXSjBUvXDZwvEIt9FSDOF
         R1SrBVR+yp1iE/YCw3Xalw3EhAFWdXlwLvs45OG71tNHdy8c/BUR9b6oFpZxVCj9RhZj
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770080229; x=1770685029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=K55HPTQCW9G9nA6aOxn5IuOVE/mDIu+VAgFlU6TuVm91Luyfo5ipXYpSiw3mx5jkAd
         2Gx9XbksWCEtEhFe1jEP5GlOa1va5mNxiamLHTqhjQj8E/1VgVOn30CjMAquWIBo5COU
         lmMgiTjxLfoiIwoBNmZ2E8I3wQYrSK+bX3SwqS4algwyKlDCF20+ODOLF/CNPuFfzCiU
         zAuew4SFc2L9q3Lan1v89IGAsMT8XYmHM8PcE6iMD3cGhKPhlX5XrWZy7ANrudHLe68o
         B5qkq5MgSef7bC1PJ/iUb1Fse7ygcXyPnGI3d7iPwhPw15GOuJLIDcxHB7VsDoOQd6MO
         e1kw==
X-Forwarded-Encrypted: i=1; AJvYcCWS0ju0sJ3pd2EpEv49a9Ca4mPsc/n0fYymB+rWg2PwE8fTy3t2GT/0cMDrGkDKl18EXWNdHxOgKiUeL5inLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSpheeEWOb30U86hPo44HVatNj2elUXfGaDKRT2i+uUk1/rlA
	L5fyIkONcnRP3c+7suc9I1rbNxCu+nP5tzb2+1SlQ1RSV5sMoxQ/+ypgm+vN+/3kg689xwOpml6
	1JSW025N5iBeVfI7si+T4t3/W4kqzAuc=
X-Gm-Gg: AZuq6aLSmtOabOaCkJEw8ZX2Pk+p84J0cwRDrNOJ4OLkjjMaC7yfFeQjuoWlwwqPKxo
	l896ne17zEtYEFim7PKRN2DmXhJlr16a2KNeXK15e1iZmDczy4bJm0Eyn9hmgnLTmqc9v4zfogu
	lLEzHQcYjKhe979H8CAcqadefn91Jhi3RnPeEZljgfFH2bQnIRJm90DcmXry0uFBJEDNnDxCpit
	2jsYawyfl+fpH3y4dYIwq/ZVkyzNj7WqHp02zWaycJbJd2dahKcD8eFuJQRYmJ5HISdC6RB0rLA
	EyV+R8Hi7DIdqNfB6yrxksP3aDYJQgkGyIqXbf33wn3ydAfbcoZtaaog
X-Received: by 2002:a05:6214:2aaa:b0:894:7c5e:3368 with SMTP id
 6a1803df08f44-894e9fb767fmr188217846d6.4.1770080228677; Mon, 02 Feb 2026
 16:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
 <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch> <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
 <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
In-Reply-To: <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 16:56:57 -0800
X-Gm-Features: AZwV_QibcfxGBlb6FY5bnd6CK6KIio3ZsP_VQLrtoKrlRtMkrnbOMvIqQ4x18WE
Message-ID: <CADkSEUjxL11fjj4tsxnF6FFtWDP0+Sru45H1sVyOYxPX_S5-3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31485-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A1AE0D32DE
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 1:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> You need to be careful with commit messages. Reviewers read them, and
> think about the implications of what they say. As a result, you wasted
> some of my time looking for a driver which did not have an
> module_exit, and wondering if there was a legitimate reason for not
> having it, and had you just broken it....
Sorry about that. Should I send another version with a better commit
message or is this patch okay the way it is?

Ethan

