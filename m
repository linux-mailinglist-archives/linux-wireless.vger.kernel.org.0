Return-Path: <linux-wireless+bounces-34741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPVtGAQy3mkdpAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:24:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D33F9F59
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFE9D300BB82
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E72FE575;
	Tue, 14 Apr 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmRpLEjO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA242798F8
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169472; cv=pass; b=qFm7nXIrP0M+MEAFNChYSxNrROI8F0DvB7CkJ5qjHyjXtLGcAXl8W7+VMbvggwMbzcgUgqcsmy1jU0b47kGhJNjJqHVDdnPtdP0qnwp2BYYkY9+S8QQUfoYYBsYLyMRfKSOsyJLHoALpLoWCBUp/xDMc+eqyQ1ZUHsZskN3yTCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169472; c=relaxed/simple;
	bh=nXEx0OwQjLKCa6jsqMhUKJH18MenvvNtcSPs3xvHw+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVYTM02/hxO4KNhvBm6W1op2gwkeRt6ZvjMo0937b1FFH6BMXNXuaO1cYwPvOKQYFzBzIfr2vjG53THqZeoOUH7W1WbzJ7HSaMrCfd8KbH0abms2JzOBHW9D3ZgozJGvns/70WAjz1vDJk8tXyW/NM/IyeaUWDbBTElNor1hLys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmRpLEjO; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ea87af213so77309067b3.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 05:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776169470; cv=none;
        d=google.com; s=arc-20240605;
        b=UxmLwAOuqFic9bMHOY7HqkT8JXUbrHCk9Ipu4vDKlTbjN78V3dcsQmlNYwPv9poUPd
         X6GDRo/ySP85a3Tdpp40s0ikUqCjtgSSVm8Pg7zGCuh8bevrSQKPqkTklawlKm5Pq5nt
         35o8yLcOirkETk/YVrvKpxNddVACn8dqJ0upehaESYHjN8mGClutf9McC7FJ+AOwqiH8
         DTAo9P3zHg6sC3aQVD97UZTXOSWpwsYsPENrbgoJGCdC4ebfQ6Lt2UXFhiwDcFRsIs//
         36W89Y9EYpUAMnpzPNXXNbtV30Gzk/kzFVgW8Hpq9xiPb6jhK25MCX0t2rlFJQj0HwP7
         zYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXEx0OwQjLKCa6jsqMhUKJH18MenvvNtcSPs3xvHw+4=;
        fh=m16gGtBIXKnJzLD6RXUZUJ6ZeFTkx22WPgu+snHobTQ=;
        b=ivY7+dXSembPwrvJDIvBV4wzSXnfJeP9DnA7dn6zKSM6kS8B83L6gg3oAkt3Z8QGgV
         sk9r4dZXBFJkCI+NsPSk1FFofzGzZNurzwpt0u3gVEJ1+uJc+/58W/g6OT7Oii3nXKnI
         UMvCh2PhuwfIC/Cg7ZCDA/Mv8Im9fOfntLI06AvGEX0OjTvDozJIg4Kzwb5FqZwgdHVT
         W2FFOIj3mPLtATwquQYEAyp881Fki+AkO55ouwk0pSEp1xsqwnhvLqRoDVUNe7yOUmW4
         WltRlrh9l5TTyfur8aSPdXRtYQXW0ZmYGnOXQ5W5Xd0+LWdiuWoi688hpd1xN289wyns
         tglA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776169470; x=1776774270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXEx0OwQjLKCa6jsqMhUKJH18MenvvNtcSPs3xvHw+4=;
        b=OmRpLEjOUWDgAUZQpILh8U05c/jkXfsYMM3i1Ni6/HI24KVQyJeHc6pLhh7QEwVqFx
         C3jSdZrcq5cUZEqLgIXreIZq2D3a/iUtNKYBLFICzXZNzndHpSRtpL50b5MghbffK7DH
         K7nMmI+7jsCFVhxiFCYRZFKDkDs1o8jqDi/MulSr5J0tgbYaObpmALu0fsPzDePC4kTA
         30YQgriXNA9DtA6M8qbZ4VwONU1eXMQqur8dfEOWgOKaKWpRSdFNRBEubqQAE228rmWj
         XwX5tRvD9thIcyHTgiux4dxYQ17rKHT2+WnyVS9Fxm5f0Rb6ELm3X2XxwThMc037LZzG
         Z4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169470; x=1776774270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXEx0OwQjLKCa6jsqMhUKJH18MenvvNtcSPs3xvHw+4=;
        b=e0Ham+rrA+KfBa5hmeDUv02K3A4M7Up0gm76bBJsPE8WN1fpF7DVY1bOKJb4+wkHZm
         6ODUgPRVCSgMNUC5ifHFBnH8xgsAQLhQVfuhekJ13Oz27XjfiJkW0psCLqMrA7wGtaWB
         thQE4untv/yWXmJs0L/4UA+2Bs4wIu8LvTlNZfOlj46iSEkmF8DJz05bcNQnGUHgYsog
         7CQpuBKHLIlGllGUcdBdjw7hXRwC4ZCG8PnnkxiHBhoUWBGIpcQRHwUryuddn88gvG01
         T018BMOGkWNj+OP3D1i8K+z7DzZlY9lMyGbfqF/JYOmvW4+BlhMbCQqIg5KKWJJMdIUq
         hYnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+l68LNMTWVw7QqkRSxHhVTTMXNiE7i66lqlMlLf1uHurHWmx/u57TgV20VClRRlceaDtDdeZMDb2IaHbJYeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0mNTBqlk5MX9N6jeVrDFKdMmTaDM3iFKm0fNEqLJTku94Z7P
	dbF2Yki+41BiucIah7NHu5bgzpwfTg+9s3+vSAiRE93lmv0lkcrq8RywA9LQRk6zcpaI1Tlz+ry
	xVFCwuCY2StVdxmMaoElxamEGerP+ld8=
X-Gm-Gg: AeBDieulF++DlaLd4Ct2oeC7xwryZOdp1Y7jiYued5SPWqhbkxhBn5HZIvwfPMQ3BmO
	NpPY5jf5RaLYwkCSFI6/lstbTJmvfUe9yzRcnRYhsOXSlIubHtQfCUSeL9zru4iicYIOH4M+fjR
	uJYN0Tu0PuKlv3T0nWALYRbUYcEP6vmIIBCb2E7uVZNaaDb7jVewwhHB/hw/SK2HWPZSU+zai3y
	1trlXNWZ4BaFJo+H/JCXnmE1meNV41mK2NmzMG1WX79EyhNp/qb0eWPzmDhLWIu3rkbi42LaUbB
	X+iZPGZ/1onBwNl4
X-Received: by 2002:a53:ac87:0:b0:650:77d0:8f7f with SMTP id
 956f58d0204a3-6519905c33cmr13608242d50.21.1776169470206; Tue, 14 Apr 2026
 05:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com> <c62a448843f189d78187de18d3fcb955f2779d13.camel@sipsolutions.net>
 <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com>
In-Reply-To: <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 14 Apr 2026 14:24:19 +0200
X-Gm-Features: AQROBzAAzfypNQSTvzh9EmOZlgJkA5U4WMv7xCPO4Op0p4GctZKOzd2QGF-pvcU
Message-ID: <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
Subject: Re: Firmware for reverse engineering b43?
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, b43-dev@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34741-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ubuntu.com:email]
X-Rspamd-Queue-Id: EE8D33F9F59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 14, 2026 at 1:31=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu.com=
> wrote:
>
> On Tue Apr 14, 2026 at 5:14 AM EDT, Johannes Berg wrote:
> > I think there's no easy answer - what are you even trying to achieve?
> > Does b43 not work sufficiently well? Do you even know if some specific
> > calibration have a tendency to go out of whack? Is there later firmware
> > that has some advantage (given how little actually happens in firmware
> > in these devices, I'd be surprised by that) but isn't compatible with
> > the driver now, and you want to change that?
> >
> > I'd be tempted to say that if there's no problem there don't try to fix
> > anything, the hardware is ancient anyway, likely has few users, and
> > those users would probably be fine with just leaving it?
> >
> > johannes
>
> The BCM4321 (nphy) doesn't connect to my 5G network, so I figured that
> by filling in TODOs and FIXME's, I could eventually get something
> working.
>
> Other than that, I was thinking of making improvements for the sake of
> improving the driver.

The initial version of the brcm80211 softmac driver [1] should also
help in making sense of some of the code (flag names etc). While it
officially only supports BCM43224 and newer on BCMA, it still had
remnants of support for older N-PHY revisions, so may help in finding
differences or explaining what code does.

I once considered trying to clean up b43 based on brcmsmac, but never
got around to it.

Best regards,
Jonas

[1] https://github.com/torvalds/linux/tree/a9533e7ea3c410fed2f4cd8b3e1e213e=
48529b75/drivers/staging/brcm80211

