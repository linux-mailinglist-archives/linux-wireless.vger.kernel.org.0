Return-Path: <linux-wireless+bounces-29292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2FC81745
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C27FB4E1131
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F38314B82;
	Mon, 24 Nov 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2/Nb8ER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E0314B66
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999927; cv=none; b=Jp/GTCQJcvGqigW1QLIEjb/aYWd94C1oLaI2NzI5C3jeSt7ANqYpZQKiIbv2r2tccX6YbkocyRsV6uSRw15UlL5eiufn270n05499vc/HxJxdwAlWQZJxdYgWEdX7wNfirSIrinE1sIpFDT76jOpHgp4OWYhfTS6xG+lPDfbmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999927; c=relaxed/simple;
	bh=kzcKbFQegFyhpmmKTMMk1GIoAvcj5qAtmhbBbXcQm3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7uPQX+Cz+KlPsrK7j8Sf7+jbFOe4Hru7zZJCzBYmM/nitodEGBwlpCktLfRiESDncT0/DFe7kbRWdRE7wtunBLL71EDTnlSDOouS0oJqnfp3fWbrnnvLWwdaQsucxROz5T6YHy0qBD8RgKbhBTySksRxYPDr7bM+bvHSY9+uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2/Nb8ER; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e239baecso40955815ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763999925; x=1764604725; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzcKbFQegFyhpmmKTMMk1GIoAvcj5qAtmhbBbXcQm3M=;
        b=m2/Nb8ERvkkbGjlc4ygkP/FPkDAvUZmbOgYnLOhyyneXSlaD+lHA+dnIY2SwwkMJKV
         KWSKfldbYvpzHd+gqRIHpKygXIebATo6qTq4Or8VDQusbUF0VcombleTg62us4ppTCEq
         iwRW4rU2836a2QBKHJTansgDR+lnqKcECQ3RM9JlXHqNF7ukADXzRUprzykrxiJgzgF7
         /aZe/fhaIECNVV6hOixm7awpQe7n6tM8iR0+CjSpNRqkAAomKwImcjLVCOGLrHVQK9R8
         yPQuu/p65glNHEVmilhhgP1QQUUntmAoOT4b6QMEHGmQWRTCD9UjLypsTReI0nIo/obO
         bgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763999925; x=1764604725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzcKbFQegFyhpmmKTMMk1GIoAvcj5qAtmhbBbXcQm3M=;
        b=C0I15V4IOhB4K1BVb3ybhfaAfxlqx1vAQH08Tr/twoBNmZ4Gmjbs7+wnCdOo7554S9
         mrbRIxXMXncH2OOFTMsZDN0ONTUHgMY5pHeO/V4fVQhna4ZgygPW29Gk5lsotWARIOPH
         oXUUg/E3eY2u2tomAX4YRzr9cya3Y7snk72HYgLj1QZaUW8oCdpWbknd+AH0D3wZCOmL
         IZf0mE5gZo/ug9BkrRIuI+o5Zo44JK06gJeCmPlpj3YW+dcDcNMPGAyHs+FBG6g/pOmP
         OQEGxSrK4KnC2WjNzxxU0qPHnYABsyDJWEGq+lhU4/vVsCt2BP0JmBjJi0slQaix9t7j
         rV/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7jCk90ANNHPjQ85IGsWvObFBXauQIaWmPI0M9C0k8XG/Wak5k3NrVEMVwQ1Mx72QQlcd+KJmJwn6g1xaNTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygOc0FprIEA5LEVIjOTENPw6hs4H+PBMb/pN+gVFr2V+ugRXjT
	4zExp7+viq1smXB4vmfQ9nbNpCgRvRkiVV/HBfs5D5sE+z6nKDsO3jKG
X-Gm-Gg: ASbGncvydWSaM32H3qnUTMAPE8kENdi/bY1woUJctmPrbSFwWxrZT8EGwbHkw/O8K+c
	FI5NikGnxp5qtWbamo8j9z83+NOQOKbKiExDTaA2bpnWLqeQ2OUmT4mtJNgen4K2PoIMJGPtZYp
	DElRi7NalkBDNCJXlLaNAlDEkvVPVilruM0cP6pEHFqopnLyfsDW5CrhI8MMIaRtt8e108Tjh0V
	yxhQG9ZN6BEJmG6nF8C5Exz7AYy/EB0flXh5o7Ug43ezUo2cGMDkXMjcoDAtBgJarYWlP7AVIgR
	+O7WhJC9PrhEusq7yFv+ZQfJZZkIR6/lIA0R/1H7vA1Ux63hhnjPlxoE0RV7skRtYSvXiYN9LE0
	SsxttQOIAgNUzzW9kA0m8wc6hkGhRN8nXKe9tiYJ9hlXLnzIChKMdomYW1pldAnkVB4UExUvPh1
	nm/ah7FLxyaAFsYBw1mC/kGFEzkeK81EEYXdjJEBMtgckXij6BisZ+x0c=
X-Google-Smtp-Source: AGHT+IGq8iFbiA7UQS+0Wo1XX3vm6ldrRO9dF5nnubwDwZmco5AkHHyrDkv14ANYE7c0Ul275wWkIg==
X-Received: by 2002:a17:902:f608:b0:295:5da6:5ff7 with SMTP id d9443c01a7336-29b6bfa8cdemr131295095ad.15.1763999925016;
        Mon, 24 Nov 2025 07:58:45 -0800 (PST)
Received: from ?IPv6:2401:4900:8fce:eb65:99e9:53c:32e6:4996? ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm140226965ad.77.2025.11.24.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:58:44 -0800 (PST)
Message-ID: <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
From: ally heev <allyheev@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Krzysztof
 Kozlowski <krzk@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Nov 2025 21:28:39 +0530
In-Reply-To: <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
References: 
	<20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
	 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
	 <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-24 at 10:38 -0500, Konstantin Ryabitsev wrote:
> On Sat, Nov 22, 2025 at 03:18:20PM +0100, Krzysztof Kozlowski wrote:
> > > Best regards,
> > > -----BEGIN PGP SIGNATURE-----
> > >=20
> > > iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
> > > HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
> > > 20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=3D
> > > =3DA6F+
> > > -----END PGP SIGNATURE-----
> >=20
> > You should switch to patatt instead, not signing emails. We don't use
> > that, I think at all, unlike patatt which is being actively checked by
> > toolkit (b4).
>=20
> It's even more curious. The patch was sent with b4, but I'm pretty sure w=
e
> wouldn't have put the PGP signature in like that, so I'm curious how that=
 even
> happened.
>=20
> Ally, can you shed some light on that?
>=20
> -K

Yes, I use b4 for my patches. I work on other open source projects
which use Github. So, my global git config commit autosign is set to
`true`, hence you have seen PGP signatures.=20

I have disabled it locally now

Regards,
Ally

