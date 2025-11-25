Return-Path: <linux-wireless+bounces-29321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B1C83B20
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5D03423BD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB223D7D0;
	Tue, 25 Nov 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHFJh4a0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82913AA2D
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055250; cv=none; b=RzZKg4dTOg+sPg3V5/5rK9T+xK4tN5yDqyz6t0sny60IvpUGazeOCMe8/PmSLHKtvHdB8L0MQzE3rLdUEK8yLxDtEPNSTr7DZ6Gtp+995k4p4U3x3MLmqKT1+1ByiBaClrWTOlr8z/lmhrzhrm30wHgsZiMw1Wr8i8/lEDDbsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055250; c=relaxed/simple;
	bh=q8WSPg9K8s3RKBF6KYkF1C0RobzPNb46sbDlEUxZ5Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDtgsA8VNp94ceYdViFAikirQNMQbyxmhihNFAqsXInmbon3ofhWp9bD3GiLdlIS3AAyeOxyh9cg68bsgpS1RcnuGRDJNX1prsW71Mb1CLumWpGRBfaAEfmPyUO/UrpIPDrXZjBd3ChoJUslVxqkL9WkbbsG/A/9JJIDHYFWphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHFJh4a0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29844c68068so56266505ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764055248; x=1764660048; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8WSPg9K8s3RKBF6KYkF1C0RobzPNb46sbDlEUxZ5Ik=;
        b=QHFJh4a0Z17WNrqXngwTaeFaLn4SvOZX+yqlWzQPR/45+rOXfsQi1rvFNqbBrjFOtP
         4KdVxs6UIptlUpc1sD5Id1fHWP80gHI2O3eMqSgd2kc4C8f2uXUiBqr+5oJoKTbxJDL6
         0pnBHPVur90rcQcQoHRBHYnGX/sp/0ZFkRD/nr9J+boW88Jyl+LzFgHEWUArEWrHginp
         sbeAdJjQ8bXJd8bq/cR1HUgluTr9GvS7ZGmmG4RmSi0OZWq7MyhXHn3yTD7CdIK1r28P
         uZpNQQtfGnRIEoQwrbeN11yI/XSv6nWXuvKQRcPTWm6dEBXio01ISalfwaW1PBgQSXXI
         fluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764055248; x=1764660048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8WSPg9K8s3RKBF6KYkF1C0RobzPNb46sbDlEUxZ5Ik=;
        b=MgVtWtcMAM4j4LkngXIgklO8duN59DL9SXShd8Joz0DNK7fvah692bXTbozWd7dB6T
         N76uK6rnNYui8CGG13Gn2ZU9oLUKHx5pG2NH5DniTEi8U4r9y61QIDaNnM7IOjnH8B1p
         3tDXZUN6hNqSqxX9bC1McpF6Y2TSRoP41eWAniuZwxs65oui70QkCec3S/y6BSPXrQHg
         J6PYZJFCwh6urfCHE2KtE8eaS5lzY/faCRGn1aPDdCFuL7AkioDM9tvd6+cuXA8svJrp
         1sHUhMpa+8nT9VZbki9SNBGKeLRdD57TOoTrGndKg27O52kxWVC8b+7VYK775wSVVUie
         upEg==
X-Forwarded-Encrypted: i=1; AJvYcCWrKvAlJOOPQn4U7Rh2JDk4LQDXvqANxRf0XClT7Dup4qexq2Wfgp+4izP/XEd2ooo7GTOvEepRK1UN7bpnCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwV5srz8LPvr0+ZZqVpeO2g7GLtOGaWN7HKRaBc6fyvVlGhBp7
	ftFoBSRwQrNH6gWGDpoaSLW8LZqdPjU17eiDEm/P2kyb0KFXXgVFmIMqrxPTbw==
X-Gm-Gg: ASbGncvd0QOcKFc4aDnHRhcufC8NIe2A2CCwB1z9M6KxHGRjD1love22ir3kcHyOoa1
	mcEGHDMCQv6SsoUlhKoP0GbkoPBhn1KDsOxRCOzIs+0U8UIzuCicBtFAXr8vyxqF27tkisMnuCf
	oPyXaaB5dX3ZHzn2Ji5SeHXq8Z+2ZYONwsEqsvWvDHrHhttayWGq6wFZGF2t7qqOvkyn7oMkPld
	MxfzAhFnV1t0+M5ZWMprkokP1qf47LUFHIPH17xJnRkdBPGjLRkfUFB0U2hwW0w+pOhxRbA1z7m
	rVcNAI0e0cBRMzAA9drzUak9gaZIMBKlmb/ccxZMyPQy1nL/jpyyCLqj41QZb7UVf5mCmrYX8kl
	2FHqIPK9rrhrLjVsHUPVv2vu/Djt1iablbJCtRdvgTSQfkwxO10z/xK5wb2tkBZDAc9/hvhA0Wh
	SMXhk8M4HjquDF3hxbZvZ/kDUn6WicybCaJA3LIl6xYcKpZ8SWALrQ9Es=
X-Google-Smtp-Source: AGHT+IE/Oe/AmEIuITz7vIrvGrPvB506Bsu7j0TVHHtqdPJ4WCFVT3BbtquedN8iFJS7SWA8SDmgQA==
X-Received: by 2002:a17:903:19ed:b0:24b:25f:5f81 with SMTP id d9443c01a7336-29b6beb1e22mr168876495ad.17.1764055248048;
        Mon, 24 Nov 2025 23:20:48 -0800 (PST)
Received: from ?IPv6:2401:4900:8fce:eb65:99e9:53c:32e6:4996? ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bd7sm154527005ad.28.2025.11.24.23.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:20:47 -0800 (PST)
Message-ID: <89c6d616ed10eadcf41f085c2484560752db82be.camel@gmail.com>
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
From: ally heev <allyheev@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 25 Nov 2025 12:50:44 +0530
In-Reply-To: <20251124-encouraging-snobbish-nuthatch-230bcb@lemur>
References: 
	<20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
	 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
	 <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
	 <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>
	 <20251124-encouraging-snobbish-nuthatch-230bcb@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-24 at 11:28 -0500, Konstantin Ryabitsev wrote:
> On Mon, Nov 24, 2025 at 09:28:39PM +0530, ally heev wrote:
> > > > > Best regards,
> > > > > -----BEGIN PGP SIGNATURE-----
> > > > >=20
> > > > > iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
> > > > > HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
> > > > > 20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=3D
> > > > > =3DA6F+
> > > > > -----END PGP SIGNATURE-----
> > > >=20
> > > > You should switch to patatt instead, not signing emails. We don't u=
se
> > > > that, I think at all, unlike patatt which is being actively checked=
 by
> > > > toolkit (b4).
> > >=20
> > > It's even more curious. The patch was sent with b4, but I'm pretty su=
re we
> > > wouldn't have put the PGP signature in like that, so I'm curious how =
that even
> > > happened.
> > >=20
> > > Ally, can you shed some light on that?
> > >=20
> > > -K
> >=20
> > Yes, I use b4 for my patches. I work on other open source projects
> > which use Github. So, my global git config commit autosign is set to

typo: `tag autosign`

> > `true`, hence you have seen PGP signatures.=20
>=20
> Interesting! I've not seen this cause PGP signatures to be added to "git =
show"
> output before. I've tried to replicate it locally, but even if I have a s=
igned
> git commit, I can't make the "gpgsig" header to show up in the output of =
"git
> show --format=3Demail" (which is what b4 uses). Do you have some local gi=
t
> configuration changes that make "gpgsig" fields show up in the output of =
"git
> show"?
>=20
> -K

I think b4 uses tags for patch series. I have checked old
patches(before disabling autosign) and found that signature is only
added on first(cover-letter) of the patch series

Regards,
Ally

