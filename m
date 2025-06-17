Return-Path: <linux-wireless+bounces-24200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA70ADC6F1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6AC3A78F0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D509288CB5;
	Tue, 17 Jun 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmZfYm5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E691A4E9D
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153731; cv=none; b=HnkZoqjdb2H2mLkwBzvK+7NQBTYRbexzYmZK07iKx4IY5xCBPrzhRcu1bfakMVv/4Gk8U2E+PoBdspPb75hwFc2eG03i4TQBP4U2kGd0aK6nNer9BlOrV0j2JorTUYhG3CxVXnr8NC85stpM69otCZxFUtBY/hZJXsncOBg7GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153731; c=relaxed/simple;
	bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxSCabJ9FJI2UGJCV9TmsbyvzhmEWRplFzr+RwAV5ISU33FJq3Z0k2HPWXxL07Zn3ASwXZaV6V3fpP2yp2Z8fynOcaGOzza6HdyT6uXd04HuJkG9iCcP53YqH4evRO8g+6U9mSRbDNYQ+1J98f0OYHsYpYvWzPEXNWsBuyuZqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmZfYm5i; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso9138799a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750153728; x=1750758528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
        b=OmZfYm5i3P/kBr5xwu+qyYsYSkNpQJE8MJGezWTQLaVs0uoN4BxzIpabIodaU7Twfk
         ShMp3wpqX1QXPfQZsACT45UPEDHNfaaLI7+oi/1D7k4bNbxH6a6KMHbZyfSjT7qC2xoi
         7uMo35nsHEHXi+LwlZFV1qDaOqe6JkYza3WvYbGfY/mZ208EOhKY77fqE04vA6lzyybE
         urKZCqkiC4qIUUJ3tCvRKsuUXYswcRiCF9/7ybhYXfdlNBPS78dU/p6Ks5gS468Rfxvr
         6GttEFfZ68pMqXspqI0lcmaj7FwZsKeSUoOEEJs31kubsGlEXuKXmLcGNMb7q9HOpTlV
         oUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153728; x=1750758528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
        b=uGjHFOgTnpP5i6cnXn/GbKA2qvgQaGyHLal7qkYApPZk1R8V7ZXwziWPM1RFKpEO/i
         iIm2AreQYuC4Q+2+dTGAPFYsvTvKie7bJLufXQDRP9Nx6zy9pS41n5BzPKXkGpinN0Qh
         ShkdU1vXvVZ1VWwV2sZ+YxpQsVa/GKSr0gDiQ0LNsAOhqnnv0nEeibnvYjQaVfo6ABOw
         ETtS2otjDgWem6xXsxgm7t2xUiY1quT2X3mrLaEY8F79ehAekCl1wYBA2MHLg6uetQED
         yO3Cw9QX59B1gVUS8rrLYtt98beE0j1X2brnSt+8xHYtdw3qJGsWDKjf827t2zh90Z8V
         mYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOYVB00f8KdIozEASF6WJsPWIQIepSWI5vfIbX8bNtR1oMCvrCcwo1LDLSpE0siBT3D892x5V32Cvnml1EMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWq4su87+RY9kl+cPe3KC0tW56bYyGxVjMm8dVq89zv8zcu+p/
	mzW3K9yOxhELzbonD03dGXu49cSAGiAN/XPW1iy9sUW0+01DOZLmSwJ9s1U0/ZUORFJT4FUobpO
	kTko+MICnkVdJ9Bd3zIj2lsowUgP8qO0SNJRh9Hy7
X-Gm-Gg: ASbGncs6CCCxZA5LMX/XF3KFtrfFZgZu+nlphUkshYwfyccfWx+IUK/dJwloalpYMcM
	eI1jfXZuBcJ0/45XEshPPUNpoch9pSdMWaffSMZ5W2OANHGSKatg4LLEYNFTFhK1LsOhl2R5xNT
	sQncruY87gJ7IvOni5CQRRK8GNTK5kOJdZlYq2V+pp+mg8z3df2fCrWi9rnIA5d4gL6P2SFx9op
	5tPh0jBXwM=
X-Google-Smtp-Source: AGHT+IGxJ/+hSyr2gNBDCExA5aN7uTYi8ZegfjnYTodx8GGEjXxZ5WnT4AkolwnayQwqylcNFPloTyiWduziC9USG5A=
X-Received: by 2002:a17:906:c105:b0:ad9:85d3:e141 with SMTP id
 a640c23a62f3a-adfad52b9e4mr1223752866b.53.1750153727535; Tue, 17 Jun 2025
 02:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com> <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
 <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
In-Reply-To: <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Jun 2025 11:48:33 +0200
X-Gm-Features: AX0GCFv6Czlrb0GcMMCvwTkEltQ2PwbAAXxRRCc_-jICqq7SqhBA80DDGlCg2CY
Message-ID: <CANp29Y5+W426u0jUz0PT=zVde+QqSD9H1fLpTuaKSzCLrt5FcA@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2025-06-17 at 11:34 +0200, Aleksandr Nogikh wrote:
> > #syz dup: WARNING in __ieee80211_beacon_get
> >
>
> Not just this one :)
>
> https://lore.kernel.org/linux-wireless/20250617104902.146e10919be1.I85f35=
2ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid/
>

Ah, interesting :)

FWIW, in this particular case, syzbot sent the duplicate report
because the WARNING format has somewhat changed in the latest
linux-next. So before we updated syzbot's parsing rules, it had
managed to re-report quite a few duplicates.

--=20
Aleksandr

> johannes

